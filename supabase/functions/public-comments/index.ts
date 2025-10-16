// supabase/functions/public-comments/index.ts
// Returns comments for a given post_id, respecting friends/public RLS on `comments`/`posts`.
// deno-lint-ignore-file no-explicit-any

// @ts-ignore: Supabase edge runtime types
declare const Deno: any;

// @ts-ignore: Supabase edge runtime types
import "jsr:@supabase/functions-js/edge-runtime.d.ts";

// Local CORS headers to avoid bundler resolution issues
const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "OPTIONS, GET",
  "Access-Control-Allow-Headers": "Authorization, Content-Type",
};

// @ts-ignore: Supabase supabase-js import
import { createClient } from "npm:@supabase/supabase-js@2";

function ok<T>(data: T, status = 200) {
  return new Response(JSON.stringify(data), {
    status,
    headers: { ...corsHeaders, "content-type": "application/json" },
  });
}
function err(message: string, status = 400) {
  return ok({ error: message }, status);
}

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") return ok("ok");

  try {
    const url = new URL(req.url);
    const postId = url.searchParams.get("post_id");
    const limit = Math.min(parseInt(url.searchParams.get("limit") ?? "50"), 100);
    const page = Math.max(parseInt(url.searchParams.get("page") ?? "1"), 1);
    if (!postId) return err("Missing required query param: post_id", 422);

    const from = (page - 1) * limit;
    const to = from + limit - 1;

    const supabase = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_ANON_KEY")!,
      { global: { headers: { Authorization: req.headers.get("Authorization") ?? "" } } }
    );

    // Read from comments base table; RLS enforces visibility (author, post author, public, friends)
    const { data, count, error } = await supabase
      .from("comments")
      .select("id, post_id, author_id, content, parent_comment_id, created_at, updated_at", { count: "exact" })
      .eq("post_id", postId)
      .order("created_at", { ascending: true })
      .range(from, to);

    if (error) return err(error.message, 500);

    return ok({ page, limit, count: count ?? 0, items: data ?? [] });
  } catch (e) {
    return err(e instanceof Error ? e.message : String(e), 500);
  }
});
