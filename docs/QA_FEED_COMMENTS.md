# QA Test Plan — Feed, Comments, Likes

## Prereqs
- App builds (`flutter run`) and user can sign in/out.
- DB objects live:
  - Edge functions: `public-feed`, `public-comments`
  - Tables: `posts`, `comments`, `reactions`, `friends`, `friend_requests`
  - Views/Policies: `users_public`, RLS on posts/comments/reactions (friends/public as configured)

## 1) Initialization & Auth
- [ ] Launch app signed **out** → feed loads **public** posts only; no likes state; actions prompt login.
- [ ] Sign **in** as User A → feed loads (public + friends).
- [ ] Confirm console logs show `public-feed` call (dev mode) without errors.

## 2) Feed Pagination
- [ ] Scroll near bottom → `FeedController.loadNextPage` triggers once per page.
- [ ] When data ends → loader stops, no duplicate requests, `hasMore=false`.
- [ ] Rotate device / navigate away and back → keeps items or refetches cleanly (no duplicates).

## 3) Post Like (Optimistic)
- [ ] Tap heart on a post → heart flips **immediately** (optimistic).
- [ ] Network response reconciles; heart remains if success, rolls back on error.
- [ ] Sign out and tap heart → gets “Not authenticated” (no crash).
- [ ] Like, then like again → toggles to **unliked** without dupes.
- [ ] Across app restart, a previously liked post shows liked after probe.

## 4) Friends-Only Visibility
- [ ] Create a post as User A with `visibility=friends`.
- [ ] Verify **User B (friend of A)** sees it in feed.
- [ ] Verify **User C (not friend)** does **not** see it.
- [ ] As User C, direct GET via `public-feed` edge function returns no item (RLS check).

## 5) Comments Pagination
- [ ] Open a post detail (with many comments) → first page loads.
- [ ] Scroll near bottom → `CommentsController.loadNextPage` fetches next page; no duplicates.
- [ ] End of list → loader disappears; `hasMore=false`.

## 6) Create Comment (Optimistic)
- [ ] Submit a valid comment while signed in → appears **instantly** at top, then reconciles to server ID.
- [ ] Submit empty/too-long → client validation shows error; no network call.
- [ ] Sign out and submit → “Not authenticated” (clean error, no crash).
- [ ] Submit reply (with `parent_comment_id`) → appears threaded correctly (if UI supports).

## 7) Comment Likes (Optimistic)
- [ ] Tap heart on a comment → flips immediately; reconciles.
- [ ] Toggle multiple times → no duplicates; final state consistent.
- [ ] Sign out and tap → “Not authenticated”.

## 8) RLS Guardrails (Spot Checks)
*(Using normal app flows; no SQL needed)*
- [ ] User B cannot like/comment on a **non-friend** private post (actions blocked).
- [ ] User C cannot load comments for a friends-only post they can’t see.
- [ ] Delete/Hide a post → it disappears from feed and its comments aren’t retrievable via `public-comments`.

## 9) Error Handling & Edge Cases
- [ ] Network offline during like/comment → optimistic flip rolls back; error toast/log shown.
- [ ] Edge function returns error → controllers don’t crash; UI shows fallback.
- [ ] Pagination under slow network → spinners visible; no concurrent double fetches.

## 10) Performance Sanity
- [ ] 20-item feed page loads within acceptable time.
- [ ] Comments page with 50 items remains scroll-smooth.
- [ ] No jank on like toggles.

## Acceptance Criteria
- All checkboxes above pass on iOS/Android debug builds.
- No uncaught exceptions in console.
- RLS behaves as expected for public/friends scopes.

Acceptance Criteria
	• File docs/QA_FEED_COMMENTS.md is created with the checklist above.
	• You can hand this to QA and run through it yourself.
