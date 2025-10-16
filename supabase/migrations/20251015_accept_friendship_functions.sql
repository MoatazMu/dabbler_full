-- Accept friendship functions (SECURITY DEFINER) to bypass RLS side-effects
-- These functions update friendships to 'accepted' and let existing triggers run
-- under elevated privileges, avoiding RLS violations on related tables

-- Accept by friendship ID
CREATE OR REPLACE FUNCTION accept_friendship_by_id(
  p_friendship_id UUID
)
RETURNS friendships
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_me UUID := auth.uid();
  v_row friendships;
BEGIN
  IF v_me IS NULL THEN
    RAISE EXCEPTION 'User must be authenticated';
  END IF;

  -- Lock the row to avoid race conditions
  SELECT * INTO v_row
  FROM friendships
  WHERE id = p_friendship_id
  FOR UPDATE;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Friendship not found';
  END IF;

  -- Only the recipient can accept
  IF v_row.friend_id <> v_me THEN
    RAISE EXCEPTION 'Only the recipient can accept this request';
  END IF;

  -- If already accepted, return as-is
  IF v_row.status = 'accepted' THEN
    RETURN v_row;
  END IF;

  -- Update to accepted (triggers will fire under definer privileges)
  UPDATE friendships
  SET status = 'accepted',
      became_friends_at = NOW(),
      updated_at = NOW()
  WHERE id = p_friendship_id
  RETURNING * INTO v_row;

  RETURN v_row;
END;
$$;

GRANT EXECUTE ON FUNCTION accept_friendship_by_id(UUID) TO authenticated;

-- Accept by requester (the other user), for convenience on the client
CREATE OR REPLACE FUNCTION accept_friendship_between(
  p_requester UUID
)
RETURNS friendships
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_me UUID := auth.uid();
  v_row friendships;
BEGIN
  IF v_me IS NULL THEN
    RAISE EXCEPTION 'User must be authenticated';
  END IF;

  -- Find pending friendship where requester -> me
  SELECT * INTO v_row
  FROM friendships
  WHERE user_id = p_requester
    AND friend_id = v_me
    AND status = 'pending'
  ORDER BY updated_at DESC
  LIMIT 1
  FOR UPDATE;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Pending friendship from % to % not found', p_requester, v_me;
  END IF;

  -- Update to accepted (triggers will fire under definer privileges)
  UPDATE friendships
  SET status = 'accepted',
      became_friends_at = NOW(),
      updated_at = NOW()
  WHERE id = v_row.id
  RETURNING * INTO v_row;

  RETURN v_row;
END;
$$;

GRANT EXECUTE ON FUNCTION accept_friendship_between(UUID) TO authenticated;
