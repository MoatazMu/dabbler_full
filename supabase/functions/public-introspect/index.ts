// supabase/functions/public-introspect/index.ts
import { serve } from "https://deno.land/std/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_ANON_KEY = Deno.env.get("SUPABASE_ANON_KEY")!;
const CORS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type, Authorization",
  "Content-Type": "application/json",
};

serve(async (req: Request) => {
  if (req.method === "OPTIONS") return new Response(null, { headers: CORS });

  try {
    const url = new URL(req.url);
    const includeCounts = (url.searchParams.get("counts") ?? "true") !== "false"; // default true
    const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

    const [tables, columns, fks] = await Promise.all([
      supabase.from("introspect_tables").select("*"),
      supabase.from("introspect_columns").select("*"),
      supabase.from("introspect_foreign_keys").select("*"),
    ]);

    // surface any fetch errors up front
    for (const r of [tables, columns, fks]) {
      // deno-lint-ignore no-explicit-any
      const anyr: any = r;
      if (anyr.error) {
        return new Response(JSON.stringify({ ok:false, error: anyr.error.message }), { status: 500, headers: CORS });
      }
    }

    // Optionally strip row counts to keep payload tiny
    const tablesData = (tables.data ?? []).map((t: any) =>
      includeCounts ? t : { table_name: t.table_name }
    );

    return new Response(JSON.stringify({
      ok: true,
      tables: tablesData,
      columns: columns.data ?? [],
      foreign_keys: fks.data ?? [],
    }), { headers: CORS });
  } catch (e) {
    return new Response(JSON.stringify({ ok:false, error: String(e) }), { status: 500, headers: CORS });
  }
});