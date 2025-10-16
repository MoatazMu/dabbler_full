-- Update the create_friendship_request function to return existing request instead of raising error
-- This prevents the "already exists" error when a pending request exists

CREATE OR REPLACE FUNCTION create_friendship_request(
  p_friend_id UUID,
  p_message TEXT DEFAULT NULL
)
RETURNS friendships
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_user_id UUID;
  v_result friendships;
  v_existing friendships;
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
  SELECT * INTO v_existing
  FROM friendships 
  WHERE (user_id = v_user_id AND friend_id = p_friend_id)
     OR (user_id = p_friend_id AND friend_id = v_user_id);
  
  -- If found, handle based on status
  IF FOUND THEN
    -- If already accepted, raise error
    IF v_existing.status = 'accepted' THEN
      RAISE EXCEPTION 'Already friends with this user';
    END IF;
    
    -- If pending and user initiated it, return existing request
    IF v_existing.status = 'pending' AND v_existing.initiated_by = v_user_id THEN
      RETURN v_existing;
    END IF;
    
    -- If pending and other user initiated it, user should accept instead
    IF v_existing.status = 'pending' AND v_existing.initiated_by = p_friend_id THEN
      RAISE EXCEPTION 'This user already sent you a friend request. Please accept it instead.';
    END IF;
    
    -- If rejected or blocked, allow retry by updating
    IF v_existing.status IN ('rejected', 'blocked') THEN
      UPDATE friendships
      SET 
        status = 'pending',
        initiated_by = v_user_id,
        message = p_message,
        created_at = NOW(),
        became_friends_at = NULL,
        blocked_at = NULL,
        blocked_by = NULL
      WHERE id = v_existing.id
      RETURNING * INTO v_result;
      
      RETURN v_result;
    END IF;
  END IF;
  
  -- No existing friendship, create new one
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
