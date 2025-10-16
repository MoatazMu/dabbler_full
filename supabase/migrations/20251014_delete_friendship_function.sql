-- Define a SECURITY DEFINER function to delete friendship rows between auth.uid() and the given user
-- This is used as a fallback when RLS policies prevent direct DELETEs from the client

CREATE OR REPLACE FUNCTION delete_friendship_between(
  p_other UUID
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_me UUID;
BEGIN
  v_me := auth.uid();
  IF v_me IS NULL THEN
    RAISE EXCEPTION 'User must be authenticated';
  END IF;

  -- Delete any friendship rows in either direction between the two users
  DELETE FROM friendships
  WHERE (user_id = v_me AND friend_id = p_other)
     OR (user_id = p_other AND friend_id = v_me);
END;
$$;

GRANT EXECUTE ON FUNCTION delete_friendship_between(UUID) TO authenticated;
