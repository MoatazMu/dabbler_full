# Copilot Database Access Cheatsheet (Supabase • Flutter • Edge Functions)

## Golden rules
- Prefer repositories over raw queries in widgets. Add or extend a `*_repo.dart` file first.
- Respect RLS: read/write through views and policies we created (`users_public`, feed via `public-feed`, etc.).
- Use keyset pagination (`created_before` + `last_id`) not offset.
- Use edge functions for multi-table joins or “friends-only” logic.
- Never hardcode secrets. Read URL/keys from `Environment.*` and use `Supabase.instance.client`.

---

## 0) Environment + Auth (always assume this exists)
- Supabase is initialized in `main.dart` with `Environment.supabaseUrl` and `Environment.supabaseAnonKey`.
- When authenticated, Supabase client sends JWT automatically to edge functions.

Quick access token (debug only)
```dart
final session = await Supabase.instance.client.auth.getSession();
debugPrint('JWT: \\${session.session?.accessToken}');
```

## 1) Read patterns

### A) Use repositories (Dart)
If a repo exists (e.g., FeedRepo, UsersRepo, CommentsRepo, ReactionsRepo) — use it.
```dart
final page = await FeedRepo().fetchFeed(limit: 20);
// page.items -> List<PostFeedItem>
```

### B) Query a public view/table (simple reads)
Use `select()` and filter by indexed columns.
```dart
final client = Supabase.instance.client;
final res = await client
  .from('users_public')
  .select('id, display_name, avatar_url')
  .ilike('display_name', '%moa%')
  .limit(20);
```

### C) Read with keyset pagination (posts/comments)
Use `created_before` + `last_id` (matches `public-feed`).
```dart
final next = page.next; // from previous call
final res = await client.functions.invoke(
  'public-feed',
  queryParameters: {
    'scope': 'public', // or 'friends'
    'limit': '20',
    if (next?.createdBefore != null) 'created_before': next!.createdBefore!,
    if (next?.lastId != null) 'last_id' : next!.lastId!,
  },
);
```

## 2) Write patterns

### A) Insert (respect RLS)
```dart
await Supabase.instance.client.from('posts').insert({
  'content': 'Hello world',
  'visibility': 'public',
});
```

### B) Update (owner-only RLS)
```dart
await Supabase.instance.client.from('posts')
  .update({'content': 'Edited text'})
  .eq('id', postId);
```

### C) Optimistic like toggle (use ReactionsRepo)
```dart
await ReactionsRepo().toggleLikePost(postId);
```

## 3) Friends-only data (Edge Function)

Call the feed (friends scope)
```dart
final res = await Supabase.instance.client.functions.invoke(
  'public-feed',
  queryParameters: {'scope': 'friends', 'limit': '20'},
);
// returns { items, next: { created_before, last_id } }
```

Terminal smoke test
```bash
TOKEN=$(node scripts/generate_jwt.js)
curl -s "https://ekmhrxdwgegxkdkdukgq.functions.supabase.co/public-feed?scope=friends&limit=5" \
  -H "Authorization: Bearer $TOKEN" | jq
```

## 4) Comments

Read comments for a post (paginated)
```dart
final page = await CommentsRepo().listForPost(postId: postId, page: 1, limit: 20);
```

Add a comment (optimistic in CommentsController)
```dart
await CommentsController(postId: postId).createComment('Nice!');
```

## 5) Users and public profile data
- Public info: `users_public` view (id, display_name, avatar_url, skill_level, sports, games_played, ...).
- PII stays in `users` behind RLS. Do not select email/phone from client.
```dart
final users = await Supabase.instance.client
  .from('users_public')
  .select('id, display_name, avatar_url')
  .limit(20);
```

## 6) Performance notes
- Use indexes already created:
  - `posts(visibility, created_at desc)`, `comments(post_id, created_at desc)`,
  - `reactions` unique guards (user+post+type / user+comment+type).
- For large reads with joins or friends logic ⇒ edge function.

---

## 7) Debug recipes

Check feed public vs friends
```bash
# Public
TOKEN=$(node scripts/generate_jwt.js); curl -s ".../public-feed?scope=public&limit=5" -H "Authorization: Bearer $TOKEN" | jq
# Friends
TOKEN=$(node scripts/generate_jwt.js); curl -s ".../public-feed?scope=friends&limit=5" -H "Authorization: Bearer $TOKEN" | jq
```

Verify viewer’s friend authors
```sql
select * from public.friend_authors_for_viewer('YOUR_USER_UUID');
```

Explain plans (DB console)
```sql
EXPLAIN ANALYZE
SELECT id FROM public.posts
WHERE visibility IN ('public','friends')
ORDER BY created_at DESC
LIMIT 20;
```

## 8) Safe SQL changes
- Views for public reads: `users_public`, `post_comments_public`.
- RLS policies: only owner can update own rows; public select on public views.

Example template
```sql
-- Enable RLS (once)
ALTER TABLE public.posts ENABLE ROW LEVEL SECURITY;

-- Select policy (public + friends visible) – adjust as needed
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname='public' AND tablename='posts' AND policyname='posts_select'
  ) THEN
    CREATE POLICY posts_select
      ON public.posts
      FOR SELECT
      USING (
        -- public posts visible to all
        (visibility = 'public')
        OR
        -- friends-only posts visible to accepted friends (edge function already gates, but keep DB side strict when queried directly)
        (visibility = 'friends' AND auth.role() = 'authenticated')
      );
  END IF;
END $$;
```

## 9) When to choose what
- Use repo + tables/views for simple CRUD on a single table with RLS-safe columns.
- Use edge functions for:
  - Friends-only feed
  - Multi-table joins (posts + counts + author profiles)
  - Keyset pagination payloads
  - Any place where you’d need server-side secrets (never in client!)

---

## 10) Prompts Copilot should follow

Prompt: add a read method for X
> Add a method to lib/repositories/<entity>_repo.dart called listRecent that returns the last 20 rows using keyset pagination (created_before, last_id). Use select() on the appropriate view/table, include only public fields, respect existing indexes, and return a typed model.

Prompt: wire friends feed
> In FeedRepo.fetchFeed, ensure the call to the public-feed function passes keyset params from the previous page (created_before, last_id), parses { items, next }, and maps to PostFeedPage. Add unit tests for pagination.

Prompt: add controller for UI
> Create a FeedController that stores a PostFeedPage? current, exposes loadFirstPage() and loadNextPage(), and an optimisticToggleLike(postId) that uses ReactionsRepo, updates local state, and notifies listeners. Do not block the UI; handle errors by reverting local state.

Prompt: add comment like
> Extend ReactionsRepo with toggleCommentLike(commentId) using the existing unique constraint (user_id, comment_id, reaction_type). Return the new liked state.

Prompt: smoke test in terminal
> Generate a JWT with node scripts/generate_jwt.js and curl the edge function with scope=friends. Confirm the friends-only post appears, and that the same post does not appear for scope=public.

---

## 11) Folder map (so Copilot knows where to write)
- Repos: `lib/repositories/*_repo.dart`
- Models: `lib/models/*.dart`
- Controllers: `lib/controllers/*_controller.dart`
- Edge functions: `supabase/functions/<name>/index.ts`
- Docs for mapping: `docs/MAPPING.md`, `docs/QA_FEED_COMMENTS.md`
- Cheatsheet (this file): `docs/COPILOT_DB_CHEATSHEET.md`
- JWT helper (local): `scripts/generate_jwt.js`

---

## 12) Gotchas
- JWT expires quickly; regenerate before curl tests.
- Friends scope requires `friend_authors_for_viewer(uuid)`; keep it deployed.
- Public vs private: do not read PII from client; use `users_public`.
- Percent-encode timestamps in query strings (+ as %2B).
