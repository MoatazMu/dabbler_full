#!/bin/bash

# Apply Friendships RLS Policies Fix
# Run this script to fix the friendships table RLS policies

echo "=========================================="
echo "Fixing Friendships Table RLS Policies"
echo "=========================================="
echo ""
echo "OPTION 1: Copy and paste the SQL below into Supabase Dashboard > SQL Editor"
echo ""
echo "OPTION 2: Run this if you have supabase CLI linked:"
echo "  supabase db push"
echo ""
echo "=========================================="
echo "SQL TO RUN:"
echo "=========================================="
echo ""

cat << 'EOF'
-- Enable RLS on friendships table
ALTER TABLE friendships ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist
DROP POLICY IF EXISTS "Users can view their own friendships" ON friendships;
DROP POLICY IF EXISTS "Users can insert their own friendships" ON friendships;
DROP POLICY IF EXISTS "Users can update their own friendships" ON friendships;
DROP POLICY IF EXISTS "Users can delete their own friendships" ON friendships;

-- Policy: Users can view friendships where they are either user_id or friend_id
CREATE POLICY "Users can view their own friendships"
ON friendships
FOR SELECT
USING (
  auth.uid() = user_id OR auth.uid() = friend_id
);

-- Policy: Users can insert friendships where they are the user_id (sender)
CREATE POLICY "Users can insert their own friendships"
ON friendships
FOR INSERT
WITH CHECK (
  auth.uid() = user_id
);

-- Policy: Users can update friendships where they are involved
-- This allows accepting/rejecting friend requests
CREATE POLICY "Users can update their own friendships"
ON friendships
FOR UPDATE
USING (
  auth.uid() = user_id OR auth.uid() = friend_id
);

-- Policy: Users can delete friendships where they are involved
CREATE POLICY "Users can delete their own friendships"
ON friendships
FOR DELETE
USING (
  auth.uid() = user_id OR auth.uid() = friend_id
);
EOF

echo ""
echo "=========================================="
echo "After running the SQL, refresh your Flutter app"
echo "=========================================="
