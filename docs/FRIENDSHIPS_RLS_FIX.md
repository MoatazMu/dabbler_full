# Friendships RLS Policies Fix

## Problem
Getting error: `PostgrestException(message: new row violates row-level security policy for table "friendships", code: 42501)`

This means the `friendships` table has Row-Level Security (RLS) enabled but doesn't have proper policies to allow authenticated users to insert friend requests.

## Solution
Apply the following SQL policies to the `friendships` table in Supabase.

## How to Apply

### Method 1: Supabase Dashboard (Recommended - Fastest)

1. Open your **Supabase Dashboard**: https://app.supabase.com
2. Select your project
3. Go to **SQL Editor** (left sidebar)
4. Click **"New Query"**
5. Copy and paste the SQL from `supabase/migrations/20251013_fix_friendships_rls.sql`
6. Click **"Run"**
7. Refresh your Flutter app

### Method 2: Using the Helper Script

```bash
./fix_friendships_rls.sh
```

This will display the SQL that you need to run.

## What the Policies Do

1. **SELECT Policy**: Users can view friendships where they are either the sender (`user_id`) or receiver (`friend_id`)

2. **INSERT Policy**: Users can only create friendships where they are the sender (`user_id` = current user)

3. **UPDATE Policy**: Users can update (accept/reject) friendships where they are involved (either `user_id` or `friend_id`)

4. **DELETE Policy**: Users can delete/unfriend relationships where they are involved

## After Applying

Once the SQL is executed:
1. Hot reload your Flutter app (press **R**)
2. Try clicking "Add Friend" again
3. It should work without the RLS error

## Verification

To verify the policies are applied, run this in SQL Editor:

```sql
SELECT * FROM pg_policies WHERE tablename = 'friendships';
```

You should see 4 policies listed.
