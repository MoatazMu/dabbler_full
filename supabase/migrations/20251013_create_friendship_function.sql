-- NUCLEAR OPTION: Database function that bypasses RLS
-- Use this ONLY if the policy-based approach keeps failing
-- This function runs with SECURITY DEFINER, which bypasses RLS

CREATE OR REPLACE FUNCTION create_friendship_request(
  p_friend_id UUID,
  p_message TEXT DEFAULT NULL
)
RETURNS friendships
LANGUAGE plpgsql
SECURITY DEFINER -- This makes it run with the function owner's privileges, bypassing RLS
SET search_path = public
AS $$
DECLARE
  v_user_id UUID;
  v_result friendships;
BEGIN
  -- Get the current authenticated user
  v_user_id := auth.uid();
  
  -- Check if user is authenticated
  IF v_user_id IS NULL THEN
    RAISE EXCEPTION 'User must be authenticated';
  END IF;
  
  -- Check if trying to friend yourself
  IF v_user_id = p_friend_id THEN
    RAISE EXCEPTION 'Cannot send friend request to yourself';
  END IF;
  
  -- Check if friendship already exists
  IF EXISTS (
    SELECT 1 FROM friendships 
    WHERE (user_id = v_user_id AND friend_id = p_friend_id)
       OR (user_id = p_friend_id AND friend_id = v_user_id)
  ) THEN
    RAISE EXCEPTION 'Friendship request already exists';
  END IF;
  
  -- Insert the friendship request
  INSERT INTO friendships (
    user_id,
    friend_id,
    status,
    initiated_by,
    message
  )
  VALUES (
    v_user_id,
    p_friend_id,
    'pending',
    v_user_id,
    p_message
  )
  RETURNING * INTO v_result;
  
  RETURN v_result;
END;
$$;

-- Grant execute permission to authenticated users
GRANT EXECUTE ON FUNCTION create_friendship_request(UUID, TEXT) TO authenticated;

-- Test the function (replace with actual UUID)
-- SELECT create_friendship_request('FRIEND_UUID_HERE', 'Hi!');
