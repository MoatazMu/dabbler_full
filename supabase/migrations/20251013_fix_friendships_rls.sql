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
