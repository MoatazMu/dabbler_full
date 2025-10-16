-- TROUBLESHOOTING: Run these queries one by one to diagnose the issue

-- 1. Check if RLS is enabled on friendships table
SELECT tablename, relrowsecurity 
FROM pg_tables 
JOIN pg_class ON pg_tables.tablename = pg_class.relname 
WHERE tablename = 'friendships';
-- Expected: relrowsecurity = true

-- 2. Check what policies exist on friendships table
SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual, with_check
FROM pg_policies 
WHERE tablename = 'friendships';
-- Expected: 4 policies listed

-- 3. Check if current user is authenticated (run in Supabase Dashboard while logged in as a user)
SELECT auth.uid();
-- Expected: Should return a UUID, not NULL

-- 4. Test INSERT permission directly
-- Replace 'YOUR_FRIEND_UUID_HERE' with an actual user UUID from your users table
-- Run this while authenticated as a user
INSERT INTO friendships (user_id, friend_id, status, initiated_by)
VALUES (
  auth.uid(),  -- Current user
  'YOUR_FRIEND_UUID_HERE',  -- Replace with actual UUID
  'pending',
  auth.uid()
)
RETURNING *;

-- 5. If the above fails, check if the policy WITH CHECK clause is working
-- This should show what auth.uid() returns
SELECT 
  auth.uid() as current_user_id,
  auth.uid() IS NOT NULL as is_authenticated;

-- 6. Alternative: Temporarily disable RLS to test if that's the issue
-- (DON'T DO THIS IN PRODUCTION - only for testing)
-- ALTER TABLE friendships DISABLE ROW LEVEL SECURITY;

-- 7. Check the exact policy definition
SELECT 
  polname as policy_name,
  polcmd as command,
  polpermissive as is_permissive,
  pg_get_expr(polqual, polrelid) as using_expression,
  pg_get_expr(polwithcheck, polrelid) as with_check_expression
FROM pg_policy
WHERE polrelid = 'friendships'::regclass;
