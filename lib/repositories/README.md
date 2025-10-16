# Repositories

This folder contains thin data-access layers for Supabase.

- Prefer using repositories from widgets/controllers rather than raw queries.
- Repositories respect RLS and call Edge Functions when needed (e.g., friends feed).
- Use keyset pagination (created_before + last_id) where possible.

See the cheatsheet for patterns, examples, and commands:

- docs/COPILOT_DB_CHEATSHEET.md
