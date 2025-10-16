// supabase/functions/public-feed/index.ts
// Deno edge function to return public + friends-visible posts, paginated.
// Requires the views we created: posts_public, posts_friends_public.
// deno-lint-ignore-file no-explicit-any

// @ts-ignore: Supabase edge runtime types
declare const Deno: any;

// @ts-ignore: Supabase functions-js imports
import "jsr:@supabase/functions-js/edge-runtime.d.ts";
// Manual CORS headers (remove external import to avoid bundler errors)
const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "OPTIONS, GET",
  "Access-Control-Allow-Headers": "Authorization, Content-Type",
};
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

type Row = {
  id: string;
  author_id: string;
  type: string | null;
  content: string | null;
  media_urls: string[] | null;
  game_id: string | null;
  sport_id: string | null;
  achievement_type: string | null;
  visibility: string | null;
  likes_count: number | null;
  comments_count: number | null;
  shares_count: number | null;
  created_at: string;
  updated_at: string | null;
  location_name: string | null;
  tags: string | null;
};

function ok<T>(data: T, status = 200) {
  return new Response(JSON.stringify(data), {
    status,
    headers: {
      ...corsHeaders,
      "content-type": "application/json",
    },
  });
}

function err(message: string, status = 400) {
  return ok({ error: message }, status);
}

// @ts-ignore: Deno global serve function

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") return ok("ok");

  try {
    const url = new URL(req.url);
    const page  = Number(url.searchParams.get('page') ?? '1');
    const limit = Math.min(Number(url.searchParams.get('limit') ?? '20'), 50);
    const createdBefore = url.searchParams.get('created_before');
    const lastId = url.searchParams.get('last_id');

    const supabase = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_ANON_KEY')!,
      { global: { headers: { Authorization: req.headers.get('Authorization') ?? '' } } }
    );

    // Get current user (if any)
    const { data: authUser } = await supabase.auth.getUser();
    const viewerId = authUser?.user?.id ?? null;

    // Base filter: visible + not deleted
    let q = supabase
      .from('posts')
      .select(`
        id, author_id, content, created_at, visibility,
        likes_count, comments_count,
        author:users_public(id, display_name, avatar_url)
      `)
      .eq('is_deleted', false)
      .in('visibility', ['public', 'friends'])
      .order('created_at', { ascending: false })
      .order('id', { ascending: false });

    // Friends-only gate
    if (viewerId) {
      const { data: ids, error: idsErr } = await supabase
        .rpc('friend_authors_for_viewer', { p_viewer: viewerId });
      if (idsErr) return err(idsErr.message, 500);
      q = q.or(`visibility.eq.public,and(visibility.eq.friends,author_id.in.(${ids.map(i => i.author_id).join(',') || '00000000-0000-0000-0000-000000000000'}))`);
    } else {
      q = q.eq('visibility', 'public');
    }

    // Keyset pagination if provided
    if (createdBefore) {
      q = q.lt('created_at', createdBefore);
      if (lastId) q = q.lte('id', lastId);
      q = q.limit(limit);
    } else {
      // fallback: simple page/limit
      const from = (page - 1) * limit;
      const to = from + limit - 1;
      q = q.range(from, to);
    }

    const { data, error } = await q;
    if (error) return err(error.message, 500);

    const items = data ?? [];
    const next = items.length
      ? {
          created_before: items[items.length - 1].created_at,
          last_id: items[items.length - 1].id,
        }
      : null;

    return ok({ items, next });
  } catch (e) {
    return err(e instanceof Error ? e.message : String(e), 500);
  }
});
