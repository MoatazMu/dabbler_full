#!/bin/bash

echo "=========================================="
echo "Friendships RLS Fix - Version 2"
echo "MORE PERMISSIVE POLICIES"
echo "=========================================="
echo ""
echo "IMPORTANT: Run this SQL in Supabase Dashboard > SQL Editor"
echo ""
cat << 'EOF'
-- UPDATED FIX: More permissive friendships RLS policies
-- This version is more explicit and should definitely work

-- First, let's make sure RLS is enabled
ALTER TABLE friendships ENABLE ROW LEVEL SECURITY;

-- Drop all existing policies
DROP POLICY IF EXISTS "Users can view their own friendships" ON friendships;
DROP POLICY IF EXISTS "Users can insert their own friendships" ON friendships;
DROP POLICY IF EXISTS "Users can update their own friendships" ON friendships;
DROP POLICY IF EXISTS "Users can delete their own friendships" ON friendships;
DROP POLICY IF EXISTS "Enable insert for authenticated users" ON friendships;
DROP POLICY IF EXISTS "Enable read for users" ON friendships;
DROP POLICY IF EXISTS "Enable update for users" ON friendships;
DROP POLICY IF EXISTS "Enable delete for users" ON friendships;

-- MORE PERMISSIVE: Allow authenticated users to insert
CREATE POLICY "Enable insert for authenticated users"
ON friendships
FOR INSERT
TO authenticated
WITH CHECK (
  auth.uid() IS NOT NULL 
  AND user_id = auth.uid()
);

-- Allow users to view friendships they're part of
CREATE POLICY "Enable read for users"
ON friendships
FOR SELECT
TO authenticated
USING (
  auth.uid() = user_id 
  OR auth.uid() = friend_id
);

-- Allow users to update friendships they're part of
CREATE POLICY "Enable update for users"
ON friendships
FOR UPDATE
TO authenticated
USING (
  auth.uid() = user_id 
  OR auth.uid() = friend_id
)
WITH CHECK (
  auth.uid() = user_id 
  OR auth.uid() = friend_id
);

-- Allow users to delete friendships they're part of
CREATE POLICY "Enable delete for users"
ON friendships
FOR DELETE
TO authenticated
USING (
  auth.uid() = user_id 
  OR auth.uid() = friend_id
);
EOF

echo ""
echo "=========================================="
echo "AFTER APPLYING THE SQL:"
echo "=========================================="
echo "1. Hot reload Flutter (press R)"
echo "2. Check console for auth debug messages"
echo "3. Try Add Friend again"
echo ""
echo "IF STILL FAILING:"
echo "Run troubleshooting queries in supabase/migrations/troubleshoot_friendships_rls.sql"
echo "=========================================="
