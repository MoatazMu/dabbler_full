# Friendships RLS - Complete Fix Guide

## The Problem
RLS (Row-Level Security) policies are blocking friend request inserts even after applying policies.

## Solutions (Try in Order)

### Solution 1: Apply Updated RLS Policies ⭐ RECOMMENDED

Run this SQL in **Supabase Dashboard > SQL Editor**:

```sql
-- Copy from: supabase/migrations/20251013_fix_friendships_rls_v2.sql
```

Or use the helper script:
```bash
./fix_friendships_rls_v2.sh
```

**Key changes:**
- Explicitly uses `TO authenticated` role
- More permissive `WITH CHECK` clause
- Checks `auth.uid() IS NOT NULL` 

### Solution 2: Database Function (Bypass RLS) ⭐ FALLBACK

If Solution 1 doesn't work, create a database function that bypasses RLS:

1. Run this SQL: `supabase/migrations/20251013_create_friendship_function.sql`

2. The Flutter code now **automatically falls back** to this method if direct INSERT fails!

**How it works:**
- Creates function `create_friendship_request()`
- Function runs with `SECURITY DEFINER` (bypasses RLS)
- Includes validation (no self-friending, no duplicates)
- Controller tries INSERT first, falls back to RPC on error

### Solution 3: Troubleshooting

Run diagnostic queries: `supabase/migrations/troubleshoot_friendships_rls.sql`

Check:
1. Is RLS enabled? (should be `true`)
2. Do policies exist? (should see 4)
3. Is `auth.uid()` returning a UUID? (not NULL)
4. Can you manually INSERT while authenticated?

## Implementation Details

### Current Setup
The code now has **automatic fallback**:

```dart
try {
  // Try direct INSERT (requires RLS policies)
  await _repo.sendFriendRequest(...);
} catch (insertError) {
  // Fallback to database function (bypasses RLS)
  await _repo.sendFriendRequestViaFunction(...);
}
```

### Debug Logging
Enhanced logging shows:
- ✅ Current user ID and auth status
- ✅ Which method was used (INSERT vs RPC)
- ✅ Exact data being sent
- ✅ Full error details if it fails

## Testing Steps

1. **Apply SQL** (Solution 1 or 2 above)
2. **Restart Flutter app**: `flutter run -d chrome`
3. **Navigate to profile** and click "Add Friend"
4. **Check console** for debug messages:
   - 🔵 = Info
   - ✅ = Success  
   - ⚠️ = Warning (fallback triggered)
   - ❌ = Error

## Expected Console Output

### Success (Direct INSERT):
```
🔵 [Controller] sendFriendRequest called...
🔍 [Controller] Current user ID: abc-123-...
📤 [Controller] Attempting direct INSERT method...
✅ [Controller] Friend request sent successfully via INSERT!
```

### Success (Fallback to RPC):
```
🔵 [Controller] sendFriendRequest called...
📤 [Controller] Attempting direct INSERT method...
⚠️ [Controller] Direct INSERT failed, trying RPC function...
✅ [Controller] Friend request sent successfully via RPC function!
```

## Why This Happens

1. **Auth token timing**: Session may not be fully established when making request
2. **Policy mismatch**: Policy checks `auth.uid()` but request doesn't include it properly  
3. **Role issues**: User might not have `authenticated` role in context

The database function approach bypasses these issues entirely.

## Next Steps After Fixing

Once working, consider:
- [ ] Remove debug print statements (or replace with proper logger)
- [ ] Keep the fallback for reliability
- [ ] Monitor which method is used more often
- [ ] Optimize RLS policies if needed

## Quick Reference

| File | Purpose |
|------|---------|
| `20251013_fix_friendships_rls_v2.sql` | Updated RLS policies |
| `20251013_create_friendship_function.sql` | Database function fallback |
| `troubleshoot_friendships_rls.sql` | Diagnostic queries |
| `fix_friendships_rls_v2.sh` | Helper script |
| `friendships_repo.dart` | Updated with both methods |
| `social_profile_screen.dart` | Auto-fallback logic |

## 2025-10-16 Update — user_achievements RLS follow-up

### Symptom
Accepting a friend request failed with:

- PostgrestException 42501: new row violates row-level security policy for table "user_achievements"

### Root cause
RLS on `public.user_achievements` only allowed SELECT (self and others' completed), with RLS enabled and no INSERT/UPDATE policies. When friend acceptance attempted to award/update an achievement row implicitly, the write was blocked by RLS.

### Resolution applied
- Kept `user_achievements` locked down (SELECT-only for clients) and performed writes via a SECURITY DEFINER function triggered/used during acceptance. This safely bypasses RLS for that specific, validated path without broadening table policies.
- Client code already has RPC fallbacks for friendship mutations; acceptance now completes without hitting table-level RLS errors.

### Validation checklist
- Accept, remove, and cancel friend requests succeed from both sides
- No 42501 errors appear in logs during acceptance
- Friend state transitions: pendingIncoming → accepted → friends reflect immediately in UI
- Optional: query Supabase logs to confirm function-based write path executed

### Notes
- We intentionally did not add generic INSERT/UPDATE policies to `user_achievements` to avoid exposing progress writes from clients. Keep future achievement writes routed through vetted RPCs/functions.
