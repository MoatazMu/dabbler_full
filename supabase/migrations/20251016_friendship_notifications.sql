-- 1) Safety: schema + extension
set local search_path = public, extensions;

-- 2) Idempotency: unique partial indexes to prevent duplicate notifications for the same friendship event
--    These allow "ON CONFLICT DO NOTHING" patterns via the index names.
--    Insert once per friendship_id + type per user.
create unique index if not exists uniq_notif_friend_request
  on public.notifications (user_id, type, (data->>'friendship_id'))
  where type = 'friend_request' and (data ? 'friendship_id');

create unique index if not exists uniq_notif_friend_accepted
  on public.notifications (user_id, type, (data->>'friendship_id'))
  where type = 'friend_update' and (data ? 'friendship_id');

create unique index if not exists uniq_notif_friend_removed
  on public.notifications (user_id, type, (data->>'friendship_id'))
  where type = 'friend_update' and (data ? 'friendship_id') and (data->>'event') = 'removed';

-- 3) Function: single dispatcher for INSERT/UPDATE/DELETE on friendships
drop function if exists public.notify_friendship_event() cascade;

create or replace function public.notify_friendship_event()
returns trigger
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
  v_requester uuid;
  v_recipient uuid;
  v_friendship_id uuid;
begin
  -- Never write back to friendships here (avoid recursion). Only INSERT into notifications.

  if (tg_op = 'INSERT') then
    -- New request: NEW.status likely 'pending'. Notify the recipient (friend_id).
    if NEW.status = 'pending' then
      insert into public.notifications (user_id, type, title, message, action_route, data)
      values (
        NEW.friend_id,
        'friend_request',
        'New friend request',
        'You have a new friend request',
        '/friends/requests',
        jsonb_build_object('requester_id', NEW.user_id, 'friendship_id', NEW.id)
      )
      on conflict on constraint uniq_notif_friend_request do nothing;
    end if;

    return null;
  end if;

  if (tg_op = 'UPDATE') then
    -- Only react when status actually changed
    if (OLD.status is distinct from NEW.status) then
      if NEW.status = 'accepted' then
        -- Notify both sides that they are friends now
        -- To user A about B
        insert into public.notifications (user_id, type, title, message, action_route, data)
        values (
          NEW.user_id,
          'friend_update',
          'You are now friends',
          'Friendship confirmed',
          '/friends',
          jsonb_build_object('friend_id', NEW.friend_id, 'friendship_id', NEW.id, 'event', 'accepted')
        )
        on conflict on constraint uniq_notif_friend_accepted do nothing;

        -- To user B about A
        insert into public.notifications (user_id, type, title, message, action_route, data)
        values (
          NEW.friend_id,
          'friend_update',
          'You are now friends',
          'Friendship confirmed',
          '/friends',
          jsonb_build_object('friend_id', NEW.user_id, 'friendship_id', NEW.id, 'event', 'accepted')
        )
        on conflict on constraint uniq_notif_friend_accepted do nothing;
      end if;
      -- (Optional) You can add branches for declined/blocked here if you use those statuses.
    end if;

    return null;
  end if;

  if (tg_op = 'DELETE') then
    -- A friendship row was deleted. Notify the other user the friend was removed.
    -- OLD.user_id removed OLD.friend_id (or mirror row removed by other triggers)
    -- We'll notify both sides once; the unique index prevents duplicates if both mirror rows are deleted.
    insert into public.notifications (user_id, type, title, message, action_route, data)
    values (
      OLD.user_id,
      'friend_update',
      'Friend removed',
      'You are no longer friends',
      '/friends',
      jsonb_build_object('former_friend_id', OLD.friend_id, 'friendship_id', OLD.id, 'event', 'removed')
    )
    on conflict on constraint uniq_notif_friend_removed do nothing;

    insert into public.notifications (user_id, type, title, message, action_route, data)
    values (
      OLD.friend_id,
      'friend_update',
      'Friend removed',
      'You are no longer friends',
      '/friends',
      jsonb_build_object('former_friend_id', OLD.user_id, 'friendship_id', OLD.id, 'event', 'removed')
    )
    on conflict on constraint uniq_notif_friend_removed do nothing;

    return null;
  end if;

  return null;
end;
$$;

-- 4) Ownership/privileges: ensure the function owner can bypass RLS.
--    (Supabase default owner for migration is postgres; SECURITY DEFINER will use owner privileges.)
--    Do NOT grant execute broadly; this is only for triggers.
revoke all on function public.notify_friendship_event() from public;
-- (No grants needed; triggers call it as owner)

-- 5) Triggers: create dedicated AFTER triggers that do not update friendships.
--    Use WHEN clauses to further guard noisy updates.
drop trigger if exists trg_friendships_notify_insert on public.friendships;
drop trigger if exists trg_friendships_notify_update on public.friendships;
drop trigger if exists trg_friendships_notify_delete on public.friendships;

create trigger trg_friendships_notify_insert
after insert on public.friendships
for each row
execute function public.notify_friendship_event();

create trigger trg_friendships_notify_update
after update of status on public.friendships
for each row
when (old.status is distinct from new.status)
execute function public.notify_friendship_event();

create trigger trg_friendships_notify_delete
after delete on public.friendships
for each row
execute function public.notify_friendship_event();

-- Notes/constraints
-- 	•	Do not modify any friendship rows inside notify_friendship_event() (to avoid recursion like the stack-depth issue you saw earlier).
-- 	•	Function must be SECURITY DEFINER and owned by a role that can INSERT into public.notifications despite RLS (the migration owner is fine).
-- 	•	Use the provided unique indexes to keep inserts idempotent even if mirror rows or retry paths fire multiple events.

-- End of file.
