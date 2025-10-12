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
// @ts-ignore: Supabase supabase-js import
import { createClient } from "npm:@supabase/supabase-js@2";

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
    const limit = Math.min(parseInt(url.searchParams.get("limit") ?? "20"), 50);
    const page = Math.max(parseInt(url.searchParams.get("page") ?? "1"), 1);
    const from = (page - 1) * limit;
    const to = from + limit - 1;

    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const supabaseAnonKey = Deno.env.get("SUPABASE_ANON_KEY")!;
    const supabase = createClient(supabaseUrl, supabaseAnonKey, {
      global: {
        headers: { Authorization: req.headers.get("Authorization") ?? "" },
      },
    });

    // 1) Public posts are always visible
    const pub = supabase
      .from("posts_public")
      .select("*", { count: "exact" })
      .order("created_at", { ascending: false })
      .range(from, to);

    // 2) Friends-visible posts (RLS ensures only allowed rows are returned)
    const friends = supabase
      .from("posts_friends_public")
      .select("*", { count: "exact" })
      .order("created_at", { ascending: false })
      .range(from, to);

    const [pubRes, frRes] = await Promise.all([pub, friends]);

    if (pubRes.error) return err(`public: ${pubRes.error.message}`, 500);
    if (frRes.error) return err(`friends: ${frRes.error.message}`, 500);

    // merge and sort by created_at desc, then paginate again in-memory (simple + safe)
    const combined = ([] as Row[])
      .concat(pubRes.data ?? [])
      .concat(frRes.data ?? [])
      .sort((a, b) => (a.created_at < b.created_at ? 1 : -1));

    // cursorless pagination response
    return ok({
      page,
      limit,
      count_public: pubRes.count ?? 0,
      count_friends: frRes.count ?? 0,
      total_items_estimate: (pubRes.count ?? 0) + (frRes.count ?? 0),
      items: combined.slice(0, limit),
    });
  } catch (e) {
    return err(e instanceof Error ? e.message : String(e), 500);
  }
});
