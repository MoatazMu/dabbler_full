

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE EXTENSION IF NOT EXISTS "pg_cron" WITH SCHEMA "pg_catalog";






COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "btree_gist" WITH SCHEMA "public";






CREATE EXTENSION IF NOT EXISTS "citext" WITH SCHEMA "public";






CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE TYPE "public"."achievement_category" AS ENUM (
    'game_participation',
    'social',
    'skill_performance',
    'milestone',
    'special',
    'community'
);


ALTER TYPE "public"."achievement_category" OWNER TO "postgres";


CREATE TYPE "public"."achievement_type" AS ENUM (
    'single',
    'cumulative',
    'streak',
    'conditional',
    'hidden'
);


ALTER TYPE "public"."achievement_type" OWNER TO "postgres";


CREATE TYPE "public"."badge_tier" AS ENUM (
    'bronze',
    'silver',
    'gold',
    'platinum',
    'diamond'
);


ALTER TYPE "public"."badge_tier" OWNER TO "postgres";


CREATE TYPE "public"."challenge_status" AS ENUM (
    'draft',
    'upcoming',
    'active',
    'completed',
    'cancelled'
);


ALTER TYPE "public"."challenge_status" OWNER TO "postgres";


CREATE TYPE "public"."challenge_type" AS ENUM (
    'individual',
    'team',
    'community',
    'streak',
    'milestone',
    'seasonal'
);


ALTER TYPE "public"."challenge_type" OWNER TO "postgres";


CREATE DOMAIN "public"."currency_code" AS "text"
	CONSTRAINT "currency_code_check" CHECK ((VALUE ~ '^[A-Z]{3}$'::"text"));


ALTER DOMAIN "public"."currency_code" OWNER TO "postgres";


CREATE TYPE "public"."event_status" AS ENUM (
    'draft',
    'published',
    'registration_open',
    'registration_closed',
    'ongoing',
    'completed',
    'cancelled'
);


ALTER TYPE "public"."event_status" OWNER TO "postgres";


CREATE TYPE "public"."event_type" AS ENUM (
    'tournament',
    'casual_meetup',
    'training',
    'competition',
    'social',
    'charity'
);


ALTER TYPE "public"."event_type" OWNER TO "postgres";


CREATE TYPE "public"."friendship_status" AS ENUM (
    'pending',
    'accepted',
    'blocked',
    'declined'
);


ALTER TYPE "public"."friendship_status" OWNER TO "postgres";


CREATE TYPE "public"."group_status" AS ENUM (
    'active',
    'inactive',
    'suspended',
    'archived'
);


ALTER TYPE "public"."group_status" OWNER TO "postgres";


CREATE TYPE "public"."group_type" AS ENUM (
    'public',
    'private',
    'invite_only',
    'regional',
    'sport_specific'
);


ALTER TYPE "public"."group_type" OWNER TO "postgres";


CREATE TYPE "public"."leaderboard_category" AS ENUM (
    'overall',
    'sport',
    'skill_level',
    'age_group',
    'region',
    'community',
    'challenge',
    'tournament',
    'seasonal'
);


ALTER TYPE "public"."leaderboard_category" OWNER TO "postgres";


CREATE TYPE "public"."leaderboard_period" AS ENUM (
    'daily',
    'weekly',
    'monthly',
    'quarterly',
    'yearly',
    'all_time'
);


ALTER TYPE "public"."leaderboard_period" OWNER TO "postgres";


CREATE TYPE "public"."leaderboard_type" AS ENUM (
    'global',
    'friends',
    'local',
    'sport',
    'weekly',
    'monthly',
    'all_time'
);


ALTER TYPE "public"."leaderboard_type" OWNER TO "postgres";


CREATE TYPE "public"."user_gender" AS ENUM (
    'male',
    'female'
);


ALTER TYPE "public"."user_gender" OWNER TO "postgres";


CREATE TYPE "public"."user_intent" AS ENUM (
    'join',
    'learn',
    'compete',
    'watch'
);


ALTER TYPE "public"."user_intent" OWNER TO "postgres";


CREATE TYPE "public"."me_profile_row" AS (
	"user_id" "uuid",
	"email" "text",
	"display_name" "text",
	"avatar_url" "text",
	"bio" "text",
	"age" integer,
	"gender" "public"."user_gender",
	"sports" "text"[],
	"intent" "public"."user_intent",
	"language" "text",
	"timezone" "text",
	"created_at" timestamp with time zone,
	"profile_completion_percentage" integer,
	"preferred_game_types" "text"[],
	"preferred_game_duration" integer,
	"preferred_team_size_min" integer,
	"preferred_team_size_max" integer,
	"preferred_radius_km" integer,
	"weekly_availability" "jsonb",
	"last_minute_availability" boolean,
	"open_to_new_players" boolean,
	"tournament_interest" boolean,
	"profile_visibility" "text",
	"show_real_name" boolean,
	"show_email" boolean,
	"show_phone" boolean,
	"show_location" boolean,
	"show_age" boolean,
	"show_sports_stats" boolean,
	"show_game_history" boolean,
	"show_upcoming_games" boolean,
	"show_favorite_venues" boolean,
	"searchable" boolean,
	"allow_friend_requests" boolean,
	"allow_game_invites" boolean,
	"allow_messages" boolean,
	"share_analytics" boolean,
	"share_location_data" boolean,
	"marketing_emails" boolean
);


ALTER TYPE "public"."me_profile_row" OWNER TO "postgres";


CREATE TYPE "public"."notification_category" AS ENUM (
    'social',
    'game',
    'achievement',
    'system'
);


ALTER TYPE "public"."notification_category" OWNER TO "postgres";


CREATE TYPE "public"."point_transaction_type" AS ENUM (
    'achievement_unlock',
    'game_participation',
    'game_win',
    'game_organization',
    'social_action',
    'profile_completion',
    'daily_bonus',
    'special_event',
    'admin_adjustment'
);


ALTER TYPE "public"."point_transaction_type" OWNER TO "postgres";


CREATE TYPE "public"."post_type" AS ENUM (
    'text',
    'game_result',
    'achievement',
    'media',
    'shared'
);


ALTER TYPE "public"."post_type" OWNER TO "postgres";


CREATE TYPE "public"."tournament_format" AS ENUM (
    'single_elimination',
    'double_elimination',
    'round_robin',
    'swiss',
    'league'
);


ALTER TYPE "public"."tournament_format" OWNER TO "postgres";


CREATE TYPE "public"."tournament_status" AS ENUM (
    'draft',
    'registration',
    'seeding',
    'ongoing',
    'completed',
    'cancelled'
);


ALTER TYPE "public"."tournament_status" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."_col_exists"("p_table" "text", "p_col" "text") RETURNS boolean
    LANGUAGE "sql" STABLE
    AS $$
  SELECT EXISTS (
    SELECT 1
    FROM information_schema.columns
    WHERE table_schema='public'
      AND table_name = p_table
      AND column_name = p_col
  );
$$;


ALTER FUNCTION "public"."_col_exists"("p_table" "text", "p_col" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."_comments_parent_same_post_fn"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
    DECLARE
      v_parent_post uuid;
    BEGIN
      -- Only check when a parent is provided
      IF NEW.parent_comment_id IS NOT NULL THEN
        SELECT c.post_id INTO v_parent_post
        FROM public.comments c
        WHERE c.id = NEW.parent_comment_id;

        IF v_parent_post IS NULL THEN
          RAISE EXCEPTION 'Parent comment % does not exist', NEW.parent_comment_id
            USING ERRCODE = '23503'; -- foreign_key_violation style
        END IF;

        IF v_parent_post <> NEW.post_id THEN
          RAISE EXCEPTION 'Reply must target the same post. parent.post_id=%, new.post_id=%',
                          v_parent_post, NEW.post_id
            USING ERRCODE = '23514'; -- check_violation style
        END IF;
      END IF;

      RETURN NEW;
    END;
    $$;


ALTER FUNCTION "public"."_comments_parent_same_post_fn"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."_post_comments_del_fn"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
    BEGIN
      UPDATE public.comments
      SET is_deleted = true,
          updated_at = now()
      WHERE id = OLD.id;

      -- Return OLD to satisfy the DELETE contract on the view
      RETURN OLD;
    END;
    $$;


ALTER FUNCTION "public"."_post_comments_del_fn"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."_post_comments_ins_fn"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
    DECLARE
      v_author uuid := auth.uid();
      v_new_id uuid;
    BEGIN
      IF v_author IS NULL THEN
        RAISE EXCEPTION 'not authenticated' USING ERRCODE = '28000';
      END IF;

      -- Insert into the base table with enforced author + sane defaults
      INSERT INTO public.comments (id, post_id, author_id, content, parent_comment_id, is_deleted, created_at, updated_at)
      VALUES (
        COALESCE(NEW.id, gen_random_uuid()),
        NEW.post_id,
        v_author,
        COALESCE(NULLIF(NEW.content, ''), ''),
        NEW.parent_comment_id,
        false,
        COALESCE(NEW.created_at, now()),
        now()
      )
      RETURNING id INTO v_new_id;

      -- Return the fresh row as if the view row was inserted
      SELECT id, post_id, author_id, content, parent_comment_id, created_at, updated_at
      INTO NEW
      FROM public.comments
      WHERE id = v_new_id;

      RETURN NEW;
    END;
    $$;


ALTER FUNCTION "public"."_post_comments_ins_fn"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."_post_comments_upd_fn"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
    DECLARE
      v_id uuid := COALESCE(NEW.id, OLD.id);
    BEGIN
      -- Update the underlying row
      UPDATE public.comments c
      SET
        -- keep immutable fields as-is unless explicitly provided (generally we don't change these)
        post_id           = COALESCE(NEW.post_id, c.post_id),
        author_id         = COALESCE(NEW.author_id, c.author_id),
        content           = COALESCE(NEW.content, c.content),
        parent_comment_id = NEW.parent_comment_id, -- allow explicit NULL
        updated_at        = COALESCE(NEW.updated_at, now())
      WHERE c.id = v_id;

      -- Return the fresh version as if the view row was updated
      SELECT id, post_id, author_id, content, parent_comment_id, created_at, updated_at
      INTO NEW
      FROM public.comments
      WHERE id = v_id;

      RETURN NEW;
    END;
    $$;


ALTER FUNCTION "public"."_post_comments_upd_fn"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."_ru_sync_comment_likes"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
    BEGIN
      IF TG_OP = 'INSERT' AND NEW.target_type='comment' AND NEW.reaction='like' THEN
        UPDATE public.comments SET likes_count = COALESCE(likes_count,0) + 1 WHERE id = NEW.target_id;
      ELSIF TG_OP = 'DELETE' AND OLD.target_type='comment' AND OLD.reaction='like' THEN
        UPDATE public.comments SET likes_count = GREATEST(COALESCE(likes_count,0) - 1, 0) WHERE id = OLD.target_id;
      END IF;
      RETURN NULL;
    END;
    $$;


ALTER FUNCTION "public"."_ru_sync_comment_likes"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."_ru_sync_post_likes"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
    BEGIN
      IF TG_OP = 'INSERT' AND NEW.target_type='post' AND NEW.reaction='like' THEN
        UPDATE public.posts SET likes_count = COALESCE(likes_count,0) + 1 WHERE id = NEW.target_id;
      ELSIF TG_OP = 'DELETE' AND OLD.target_type='post' AND OLD.reaction='like' THEN
        UPDATE public.posts SET likes_count = GREATEST(COALESCE(likes_count,0) - 1, 0) WHERE id = OLD.target_id;
      END IF;
      RETURN NULL;
    END;
    $$;


ALTER FUNCTION "public"."_ru_sync_post_likes"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."_table_exists"("p_table" "text") RETURNS boolean
    LANGUAGE "sql" STABLE
    AS $$
  SELECT EXISTS (
    SELECT 1
    FROM information_schema.tables
    WHERE table_schema = 'public' AND table_name = p_table
  );
$$;


ALTER FUNCTION "public"."_table_exists"("p_table" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."analytics_dashboard"("p_start" "date", "p_end" "date", "p_top_posts_limit" integer DEFAULT 20) RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
  v_new_users  jsonb := '[]'::jsonb;
  v_dau        jsonb := '[]'::jsonb;
  v_bookings   jsonb := '[]'::jsonb;
  v_revenue    jsonb := '[]'::jsonb;
  v_top_posts  jsonb := '[]'::jsonb;
BEGIN
  -- normalize window (inclusive)
  IF p_end < p_start THEN
    RAISE EXCEPTION 'p_end (%) is before p_start (%)', p_end, p_start;
  END IF;

  -- 1) new users
  SELECT COALESCE(
           jsonb_agg(jsonb_build_object('day', day, 'new_users', new_users) ORDER BY day),
           '[]'::jsonb
         )
  INTO v_new_users
  FROM public.v_daily_new_users
  WHERE day BETWEEN p_start AND p_end;

  -- 2) daily active users
  SELECT COALESCE(
           jsonb_agg(jsonb_build_object('day', day, 'active_users', active_users) ORDER BY day),
           '[]'::jsonb
         )
  INTO v_dau
  FROM public.v_daily_active_users
  WHERE day BETWEEN p_start AND p_end;

  -- 3) bookings per day
  SELECT COALESCE(
           jsonb_agg(jsonb_build_object('day', day, 'bookings', bookings, 'total_hours', total_hours) ORDER BY day),
           '[]'::jsonb
         )
  INTO v_bookings
  FROM public.v_bookings_daily
  WHERE day BETWEEN p_start AND p_end;

  -- 4) revenue per day by currency
  SELECT COALESCE(
           jsonb_agg(jsonb_build_object('day', day, 'currency', currency, 'revenue', revenue) ORDER BY day, currency),
           '[]'::jsonb
         )
  INTO v_revenue
  FROM public.v_revenue_daily
  WHERE day BETWEEN p_start AND p_end;

  -- 5) top posts by engagement (limit, within window if you want to filter by created_at)
  SELECT COALESCE(
           jsonb_agg(
             jsonb_build_object(
               'post_id', id,
               'author_id', author_id,
               'created_at', created_at,
               'comments', comments_count,
               'reactions', reactions_count,
               'engagement', engagement_score
             )
             ORDER BY engagement_score DESC, created_at DESC
           ),
           '[]'::jsonb
         )
  INTO v_top_posts
  FROM (
    SELECT *
    FROM public.v_top_posts_engagement
    WHERE created_at::date BETWEEN p_start AND p_end
    ORDER BY engagement_score DESC, created_at DESC
    LIMIT GREATEST(p_top_posts_limit, 1)
  ) t;

  RETURN jsonb_build_object(
    'window',        jsonb_build_object('start', p_start, 'end', p_end),
    'new_users',     v_new_users,
    'daily_active',  v_dau,
    'bookings',      v_bookings,
    'revenue',       v_revenue,
    'top_posts',     v_top_posts
  );
END;
$$;


ALTER FUNCTION "public"."analytics_dashboard"("p_start" "date", "p_end" "date", "p_top_posts_limit" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."award_badge"("p_user_id" "uuid", "p_achievement_id" "uuid", "p_tier" "public"."badge_tier") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  v_badge_id UUID;
BEGIN
  -- Get badge for this achievement and tier
  SELECT id INTO v_badge_id
  FROM public.badges
  WHERE achievement_id = p_achievement_id AND tier = p_tier;
  
  IF v_badge_id IS NOT NULL THEN
    INSERT INTO public.user_badges (
      user_id, badge_id, achievement_id, tier
    ) VALUES (
      p_user_id, v_badge_id, p_achievement_id, p_tier
    )
    ON CONFLICT (user_id, badge_id) DO UPDATE SET
      times_earned = user_badges.times_earned + 1;
  END IF;
END;
$$;


ALTER FUNCTION "public"."award_badge"("p_user_id" "uuid", "p_achievement_id" "uuid", "p_tier" "public"."badge_tier") OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."point_transactions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "type" "public"."point_transaction_type" NOT NULL,
    "points" integer NOT NULL,
    "achievement_id" "uuid",
    "game_id" "uuid",
    "description" "text",
    "metadata" "jsonb" DEFAULT '{}'::"jsonb",
    "multipliers_applied" "jsonb" DEFAULT '{}'::"jsonb",
    "final_points" integer NOT NULL,
    "balance_before" integer DEFAULT 0 NOT NULL,
    "balance_after" integer NOT NULL,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "created_date_utc" "date" GENERATED ALWAYS AS ((("created_at" AT TIME ZONE 'UTC'::"text"))::"date") STORED
);


ALTER TABLE "public"."point_transactions" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."award_points"("p_user_id" "uuid", "p_type" "public"."point_transaction_type", "p_base_points" integer, "p_description" "text" DEFAULT NULL::"text", "p_achievement_id" "uuid" DEFAULT NULL::"uuid", "p_game_id" "uuid" DEFAULT NULL::"uuid", "p_metadata" "jsonb" DEFAULT '{}'::"jsonb") RETURNS "public"."point_transactions"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  v_current_balance INTEGER;
  v_multipliers JSONB := '{}';
  v_final_points INTEGER := p_base_points;
  v_transaction point_transactions;
  v_new_tier_id UUID;
  v_old_tier_id UUID;
BEGIN
  -- Get current balance
  SELECT COALESCE(SUM(final_points), 0) INTO v_current_balance
  FROM public.point_transactions
  WHERE user_id = p_user_id;
  
  -- Calculate multipliers (simplified for now)
  -- In production, this would check various conditions
  IF p_metadata->>'first_time' = 'true' THEN
    v_multipliers := v_multipliers || '{"first_time_bonus": 2.0}';
    v_final_points := v_final_points * 2;
  END IF;
  
  -- Create transaction
  INSERT INTO public.point_transactions (
    user_id, type, points, achievement_id, game_id,
    description, metadata, multipliers_applied,
    final_points, balance_before, balance_after
  ) VALUES (
    p_user_id, p_type, p_base_points, p_achievement_id, p_game_id,
    p_description, p_metadata, v_multipliers,
    v_final_points, v_current_balance, v_current_balance + v_final_points
  ) RETURNING * INTO v_transaction;
  
  -- Update user tier progress
  SELECT current_tier_id INTO v_old_tier_id
  FROM public.user_tier_progress
  WHERE user_id = p_user_id;
  
  v_new_tier_id := public.get_tier_from_points(v_current_balance + v_final_points);
  
  INSERT INTO public.user_tier_progress (
    user_id, current_tier_id, total_points
  ) VALUES (
    p_user_id, v_new_tier_id, v_current_balance + v_final_points
  )
  ON CONFLICT (user_id) DO UPDATE SET
    total_points = EXCLUDED.total_points,
    current_tier_id = v_new_tier_id,
    tier_up_count = CASE 
      WHEN v_new_tier_id != v_old_tier_id 
      THEN user_tier_progress.tier_up_count + 1 
      ELSE user_tier_progress.tier_up_count 
    END,
    last_tier_up = CASE 
      WHEN v_new_tier_id != v_old_tier_id 
      THEN timezone('utc'::text, now()) 
      ELSE user_tier_progress.last_tier_up 
    END,
    updated_at = timezone('utc'::text, now());
  
  RETURN v_transaction;
END;
$$;


ALTER FUNCTION "public"."award_points"("p_user_id" "uuid", "p_type" "public"."point_transaction_type", "p_base_points" integer, "p_description" "text", "p_achievement_id" "uuid", "p_game_id" "uuid", "p_metadata" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."batch_track_achievements"("p_events" "jsonb"[]) RETURNS TABLE("user_id" "uuid", "achievements_updated" integer, "points_awarded" integer)
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  v_event JSONB;
  v_user_achievements INTEGER;
  v_user_points INTEGER;
  v_results RECORD;
BEGIN
  FOREACH v_event IN ARRAY p_events LOOP
    v_user_achievements := 0;
    v_user_points := 0;

    FOR v_results IN 
      SELECT * FROM public.track_achievement_progress(
        (v_event->>'user_id')::UUID,
        v_event->>'event_type',
        v_event->'event_data'
      )
    LOOP
      v_user_achievements := v_user_achievements + 1;
      v_user_points := v_user_points + COALESCE(v_results.points_awarded, 0);
    END LOOP;

    user_id := (v_event->>'user_id')::UUID;
    achievements_updated := v_user_achievements;
    points_awarded := v_user_points;
    RETURN NEXT;
  END LOOP;
END;
$$;


ALTER FUNCTION "public"."batch_track_achievements"("p_events" "jsonb"[]) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."calculate_achievement_progress_percentage"("p_criteria" "jsonb", "p_progress" "jsonb") RETURNS numeric
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  v_total_criteria INTEGER := 0;
  v_met_criteria INTEGER := 0;
  v_key TEXT;
  v_required_value JSONB;
  v_current_value JSONB;
  v_percentage DECIMAL;
BEGIN
  -- Count total criteria and how many are met
  FOR v_key, v_required_value IN SELECT * FROM jsonb_each(p_criteria)
  LOOP
    v_total_criteria := v_total_criteria + 1;
    v_current_value := p_progress->v_key;
    
    IF v_current_value IS NOT NULL THEN
      -- For numeric values, calculate partial progress
      IF jsonb_typeof(v_required_value) = 'number' AND jsonb_typeof(v_current_value) = 'number' THEN
        v_percentage := LEAST(
          (v_current_value::text)::numeric / (v_required_value::text)::numeric * 100,
          100
        );
        v_met_criteria := v_met_criteria + (v_percentage / 100);
      -- For boolean values
      ELSIF v_current_value = v_required_value THEN
        v_met_criteria := v_met_criteria + 1;
      END IF;
    END IF;
  END LOOP;
  
  IF v_total_criteria = 0 THEN
    RETURN 0;
  END IF;
  
  RETURN ROUND((v_met_criteria::decimal / v_total_criteria) * 100, 2);
END;
$$;


ALTER FUNCTION "public"."calculate_achievement_progress_percentage"("p_criteria" "jsonb", "p_progress" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."calculate_profile_completion"("user_id" "uuid") RETURNS integer
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  completion_percentage INTEGER := 0;
  profile_record RECORD;
BEGIN
  -- Get profile data
  SELECT * INTO profile_record FROM public.users WHERE id = user_id;
  
  IF profile_record IS NULL THEN
    RETURN 0;
  END IF;
  
  -- Basic fields (20% each)
  IF profile_record.display_name IS NOT NULL AND profile_record.display_name != '' THEN
    completion_percentage := completion_percentage + 20;
  END IF;
  
  IF profile_record.email IS NOT NULL AND profile_record.email != '' THEN
    completion_percentage := completion_percentage + 20;
  END IF;
  
  IF profile_record.phone IS NOT NULL AND profile_record.phone != '' THEN
    completion_percentage := completion_percentage + 20;
  END IF;
  
  IF profile_record.gender IS NOT NULL THEN
    completion_percentage := completion_percentage + 20;
  END IF;
  
  IF profile_record.sports IS NOT NULL AND array_length(profile_record.sports, 1) > 0 THEN
    completion_percentage := completion_percentage + 20;
  END IF;
  
  RETURN LEAST(completion_percentage, 100);
END;
$$;


ALTER FUNCTION "public"."calculate_profile_completion"("user_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."check_achievement_completion"("p_criteria" "jsonb", "p_progress" "jsonb") RETURNS boolean
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  v_key TEXT;
  v_required_value JSONB;
  v_current_value JSONB;
BEGIN
  -- Check each criteria key
  FOR v_key, v_required_value IN SELECT * FROM jsonb_each(p_criteria)
  LOOP
    v_current_value := p_progress->v_key;
    
    -- Handle different comparison types
    IF v_current_value IS NULL THEN
      RETURN FALSE;
    END IF;
    
    -- Numeric comparisons
    IF jsonb_typeof(v_required_value) = 'number' THEN
      IF (v_current_value::text)::numeric < (v_required_value::text)::numeric THEN
        RETURN FALSE;
      END IF;
    -- Boolean comparisons
    ELSIF jsonb_typeof(v_required_value) = 'boolean' THEN
      IF v_current_value != v_required_value THEN
        RETURN FALSE;
      END IF;
    -- String comparisons
    ELSE
      IF v_current_value::text != v_required_value::text THEN
        RETURN FALSE;
      END IF;
    END IF;
  END LOOP;
  
  RETURN TRUE;
END;
$$;


ALTER FUNCTION "public"."check_achievement_completion"("p_criteria" "jsonb", "p_progress" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."check_booking_conflict"("p_venue_id" "uuid", "p_booking_date" "date", "p_start_time" time without time zone, "p_end_time" time without time zone, "p_court_number" integer DEFAULT NULL::integer, "p_exclude_booking_id" "uuid" DEFAULT NULL::"uuid") RETURNS boolean
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 
    FROM venue_bookings 
    WHERE venue_id = p_venue_id 
    AND booking_date = p_booking_date
    AND status IN ('confirmed', 'pending')
    AND (p_exclude_booking_id IS NULL OR id != p_exclude_booking_id)
    AND (p_court_number IS NULL OR court_number = p_court_number)
    AND (
      (start_time < p_end_time AND end_time > p_start_time)
    )
  );
END;
$$;


ALTER FUNCTION "public"."check_booking_conflict"("p_venue_id" "uuid", "p_booking_date" "date", "p_start_time" time without time zone, "p_end_time" time without time zone, "p_court_number" integer, "p_exclude_booking_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."cleanup_expired_password_resets"() RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  DELETE FROM public.password_reset_attempts
  WHERE expires_at < timezone('utc'::text, now())
  AND status = 'pending';
END;
$$;


ALTER FUNCTION "public"."cleanup_expired_password_resets"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."cleanup_old_notifications"() RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  -- Mark low-priority unread older than 30 days as read
  UPDATE notifications
  SET is_read = true,
      read_at = now(),
      updated_at = now()
  WHERE is_read = false
    AND priority = 'low'
    AND created_at < now() - interval '30 days';

  -- Delete very old read notifications (180+ days)
  DELETE FROM notifications
  WHERE is_read = true
    AND priority IN ('low', 'normal')
    AND created_at < now() - interval '180 days';
END;
$$;


ALTER FUNCTION "public"."cleanup_old_notifications"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."cleanup_rewards_data"() RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  DELETE FROM public.achievement_notifications
  WHERE is_read = true
    AND created_at < NOW() - INTERVAL '30 days';

  DELETE FROM public.point_transactions
  WHERE created_at < NOW() - INTERVAL '1 year';

  DELETE FROM public.user_achievements
  WHERE is_completed = false 
    AND last_updated < NOW() - INTERVAL '6 months'
    AND progress_percentage < 10;
END;
$$;


ALTER FUNCTION "public"."cleanup_rewards_data"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."collect_daily_achievement_metrics"() RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  -- Keep it a DATE; avoid DATE - INTERVAL coercion
  v_metric_date DATE := CURRENT_DATE - 1;
BEGIN
  INSERT INTO public.daily_achievement_metrics (
    metric_date,
    total_achievements_unlocked,
    unique_users_unlocking,
    total_points_awarded,
    total_badges_earned,
    achievements_by_category,
    tier_ups,
    top_achievements
  )
  SELECT
    v_metric_date,
    COUNT(DISTINCT ua.id) FILTER (WHERE DATE(ua.completed_at) = v_metric_date),
    COUNT(DISTINCT ua.user_id) FILTER (WHERE DATE(ua.completed_at) = v_metric_date),
    COALESCE(SUM(pt.points), 0),
    COUNT(DISTINCT ub.id),

    /* --- category breakdown without nested aggregates --- */
    (
      SELECT COALESCE(jsonb_object_agg(cat, cnt), '{}'::jsonb)
      FROM (
        SELECT
          COALESCE(a2.category::text, 'unknown') AS cat,
          COUNT(*) AS cnt
        FROM public.user_achievements ua2
        JOIN public.achievements a2 ON a2.id = ua2.achievement_id
        WHERE DATE(ua2.completed_at) = v_metric_date
        GROUP BY COALESCE(a2.category::text, 'unknown')
      ) AS cat_counts
    ) AS achievements_by_category,

    COUNT(DISTINCT utp.user_id) FILTER (WHERE DATE(utp.last_tier_up) = v_metric_date),

    /* --- top achievements: apply LIMIT inside the subquery, not inside the aggregate --- */
    (
      SELECT COALESCE(jsonb_agg(achievement_info ORDER BY unlock_count DESC), '[]'::jsonb)
      FROM (
        SELECT
          jsonb_build_object(
            'achievement_id', a3.id,
            'name',           a3.name,
            'unlocks',        COUNT(ua3.id)
          ) AS achievement_info,
          COUNT(ua3.id) AS unlock_count
        FROM public.achievements a3
        JOIN public.user_achievements ua3 ON ua3.achievement_id = a3.id
        WHERE DATE(ua3.completed_at) = v_metric_date
        GROUP BY a3.id, a3.name
        ORDER BY COUNT(ua3.id) DESC
        LIMIT 10
      ) AS top_achievements_subquery
    ) AS top_achievements

  FROM public.user_achievements ua
  LEFT JOIN public.achievements a ON a.id = ua.achievement_id
  LEFT JOIN public.point_transactions pt
    ON pt.achievement_id = ua.achievement_id
   AND DATE(pt.created_at) = v_metric_date
  LEFT JOIN public.user_badges ub
    ON DATE(ub.earned_at) = v_metric_date
  LEFT JOIN public.user_tier_progress utp
    ON DATE(utp.last_tier_up) = v_metric_date
  WHERE DATE(ua.completed_at) = v_metric_date
  ON CONFLICT (metric_date) DO UPDATE SET
    total_achievements_unlocked = EXCLUDED.total_achievements_unlocked,
    unique_users_unlocking      = EXCLUDED.unique_users_unlocking,
    total_points_awarded        = EXCLUDED.total_points_awarded,
    total_badges_earned         = EXCLUDED.total_badges_earned,
    achievements_by_category    = EXCLUDED.achievements_by_category,
    tier_ups                    = EXCLUDED.tier_ups,
    top_achievements            = EXCLUDED.top_achievements;
END;
$$;


ALTER FUNCTION "public"."collect_daily_achievement_metrics"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."collect_profile_metrics"() RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  INSERT INTO public.profile_metrics (
    metric_date,
    total_profiles,
    completed_profiles,
    active_users_daily,
    active_users_weekly,
    new_profiles_count,
    avg_completion_percentage,
    avg_sports_per_user
  )
  SELECT
    CURRENT_DATE,
    COUNT(*)::int,
    COUNT(*) FILTER (WHERE COALESCE(is_profile_complete,false))::int,
    COUNT(*) FILTER (WHERE updated_at >= CURRENT_DATE - INTERVAL '1 day')::int,
    COUNT(*) FILTER (WHERE updated_at >= CURRENT_DATE - INTERVAL '7 days')::int,
    COUNT(*) FILTER (WHERE created_at >= CURRENT_DATE - INTERVAL '1 day')::int,
    COALESCE(AVG(profile_completion_percentage),0)::numeric(5,2),
    (
      SELECT COALESCE(AVG(sport_count),0)
      FROM (
        SELECT user_id, COUNT(*)::numeric AS sport_count
        FROM public.user_sports_profiles
        GROUP BY user_id
      ) s
    )::numeric(5,2)
  FROM public.users
  ON CONFLICT (metric_date)
  DO UPDATE SET
    total_profiles             = EXCLUDED.total_profiles,
    completed_profiles         = EXCLUDED.completed_profiles,
    active_users_daily         = EXCLUDED.active_users_daily,
    active_users_weekly        = EXCLUDED.active_users_weekly,
    new_profiles_count         = EXCLUDED.new_profiles_count,
    avg_completion_percentage  = EXCLUDED.avg_completion_percentage,
    avg_sports_per_user        = EXCLUDED.avg_sports_per_user;
END;
$$;


ALTER FUNCTION "public"."collect_profile_metrics"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."collect_social_metrics"() RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  INSERT INTO public.social_metrics (
    metric_date,
    daily_active_users,
    posts_created,
    posts_with_media,
    total_likes,
    total_comments,
    friend_requests_sent,
    friend_requests_accepted,
    messages_sent,
    conversations_started
  )
  SELECT
    CURRENT_DATE,
    (SELECT COUNT(DISTINCT author_id) FROM public.posts 
     WHERE created_at >= CURRENT_DATE - INTERVAL '1 day'),
    (SELECT COUNT(*) FROM public.posts 
     WHERE created_at >= CURRENT_DATE - INTERVAL '1 day'),
    (SELECT COUNT(*) FROM public.posts 
     WHERE created_at >= CURRENT_DATE - INTERVAL '1 day' 
     AND media_urls IS NOT NULL AND array_length(media_urls, 1) > 0),
    (SELECT COUNT(*) FROM public.reactions 
     WHERE created_at >= CURRENT_DATE - INTERVAL '1 day' 
     AND reaction_type = 'like'),
    (SELECT COUNT(*) FROM public.comments 
     WHERE created_at >= CURRENT_DATE - INTERVAL '1 day'),
    (SELECT COUNT(*) FROM public.friendships 
     WHERE created_at >= CURRENT_DATE - INTERVAL '1 day' 
     AND status = 'pending'),
    (SELECT COUNT(*) FROM public.friendships 
     WHERE updated_at >= CURRENT_DATE - INTERVAL '1 day' 
     AND status = 'accepted'),
    (SELECT COUNT(*) FROM public.messages 
     WHERE created_at >= CURRENT_DATE - INTERVAL '1 day'),
    (SELECT COUNT(*) FROM public.conversations 
     WHERE created_at >= CURRENT_DATE - INTERVAL '1 day')
  ON CONFLICT (metric_date) 
  DO UPDATE SET
    daily_active_users = EXCLUDED.daily_active_users,
    posts_created = EXCLUDED.posts_created,
    posts_with_media = EXCLUDED.posts_with_media,
    total_likes = EXCLUDED.total_likes,
    total_comments = EXCLUDED.total_comments,
    friend_requests_sent = EXCLUDED.friend_requests_sent,
    friend_requests_accepted = EXCLUDED.friend_requests_accepted,
    messages_sent = EXCLUDED.messages_sent,
    conversations_started = EXCLUDED.conversations_started;
END;
$$;


ALTER FUNCTION "public"."collect_social_metrics"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."confirm_user_phone"("p_user_id" "uuid") RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
    UPDATE public.users 
    SET phone_confirmed = TRUE,
        phone_confirmed_at = NOW(),
        updated_at = NOW()
    WHERE id = p_user_id;
    
    RETURN FOUND;
END;
$$;


ALTER FUNCTION "public"."confirm_user_phone"("p_user_id" "uuid") OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."friendships" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "friend_id" "uuid" NOT NULL,
    "status" "public"."friendship_status" DEFAULT 'pending'::"public"."friendship_status" NOT NULL,
    "initiated_by" "uuid" NOT NULL,
    "became_friends_at" timestamp with time zone,
    "blocked_at" timestamp with time zone,
    "blocked_by" "uuid",
    "message" "text",
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "no_self_friendship" CHECK (("user_id" <> "friend_id"))
);


ALTER TABLE "public"."friendships" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."create_friendship_request"("p_friend_id" "uuid", "p_message" "text" DEFAULT NULL::"text") RETURNS "public"."friendships"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
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


ALTER FUNCTION "public"."create_friendship_request"("p_friend_id" "uuid", "p_message" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."create_social_notification"("p_user_id" "uuid", "p_type" "text", "p_title" "text", "p_body" "text" DEFAULT NULL::"text", "p_actor_id" "uuid" DEFAULT NULL::"uuid", "p_post_id" "uuid" DEFAULT NULL::"uuid", "p_comment_id" "uuid" DEFAULT NULL::"uuid", "p_friendship_id" "uuid" DEFAULT NULL::"uuid", "p_conversation_id" "uuid" DEFAULT NULL::"uuid", "p_data" "jsonb" DEFAULT '{}'::"jsonb") RETURNS "uuid"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  notification_id UUID;
BEGIN
  -- Don't notify user about their own actions
  IF p_actor_id = p_user_id THEN
    RETURN NULL;
  END IF;
  
  INSERT INTO public.social_notifications (
    user_id, type, title, body, actor_id, 
    post_id, comment_id, friendship_id, conversation_id, data
  )
  VALUES (
    p_user_id, p_type, p_title, p_body, p_actor_id,
    p_post_id, p_comment_id, p_friendship_id, p_conversation_id, p_data
  )
  RETURNING id INTO notification_id;
  
  RETURN notification_id;
END;
$$;


ALTER FUNCTION "public"."create_social_notification"("p_user_id" "uuid", "p_type" "text", "p_title" "text", "p_body" "text", "p_actor_id" "uuid", "p_post_id" "uuid", "p_comment_id" "uuid", "p_friendship_id" "uuid", "p_conversation_id" "uuid", "p_data" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."create_social_notification_trigger"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  notification_user_id UUID;
  notification_title TEXT;
  actor_name TEXT;
BEGIN
  -- Only process INSERT operations for notifications
  IF TG_OP != 'INSERT' THEN
    RETURN NEW;
  END IF;

  -- Get actor name
  SELECT username INTO actor_name FROM public.profiles WHERE id = NEW.user_id;
  
  IF TG_TABLE_NAME = 'reactions' AND NEW.post_id IS NOT NULL THEN
    -- Notify post author about like
    SELECT author_id INTO notification_user_id FROM public.posts WHERE id = NEW.post_id;
    notification_title := actor_name || ' liked your post';
    
    PERFORM public.create_social_notification(
      notification_user_id,
      'post_like',
      notification_title,
      NULL,
      NEW.user_id,
      NEW.post_id
    );
    
  ELSIF TG_TABLE_NAME = 'comments' THEN
    -- Notify post author about comment
    SELECT author_id INTO notification_user_id FROM public.posts WHERE id = NEW.post_id;
    notification_title := actor_name || ' commented on your post';
    
    PERFORM public.create_social_notification(
      notification_user_id,
      'post_comment',
      notification_title,
      LEFT(NEW.content, 100),
      NEW.author_id,
      NEW.post_id,
      NEW.id
    );
    
  ELSIF TG_TABLE_NAME = 'friendships' AND NEW.status = 'pending' THEN
    -- Notify about friend request
    notification_title := actor_name || ' sent you a friend request';
    
    PERFORM public.create_social_notification(
      NEW.friend_id,
      'friend_request',
      notification_title,
      NEW.message,
      NEW.initiated_by,
      NULL,
      NULL,
      NEW.id
    );
    
  END IF;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."create_social_notification_trigger"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."decrement_comments_count"("post_id" "uuid") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
    UPDATE public.posts 
    SET comments_count = GREATEST(comments_count - 1, 0),
        updated_at = NOW()
    WHERE id = post_id;
END;
$$;


ALTER FUNCTION "public"."decrement_comments_count"("post_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."decrement_likes_count"("post_id" "uuid") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
    UPDATE public.posts 
    SET likes_count = GREATEST(likes_count - 1, 0),
        updated_at = NOW()
    WHERE id = post_id;
END;
$$;


ALTER FUNCTION "public"."decrement_likes_count"("post_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."fanout_urgent_notifications"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE v_email text;
BEGIN
  IF NEW.type = 'system_alert' AND NEW.priority IN ('urgent','high') THEN
    -- Activity feed insert WITH linkage
    INSERT INTO activity_feed (user_id, kind, title, message, action_route, notification_id)
    VALUES (NEW.user_id, 'system_alert', NEW.title, NEW.message, NEW.action_route, NEW.id);

    -- Email outbox (still optional for read-state; we don’t mark emails read)
    SELECT email INTO v_email FROM profiles WHERE id = NEW.user_id;
    IF v_email IS NOT NULL THEN
      INSERT INTO email_outbox (user_id, to_email, subject, body)
      VALUES (
        NEW.user_id,
        v_email,
        COALESCE(NEW.title, 'Important update'),
        COALESCE(NEW.message, 'Please check the app for details.')
          || CASE WHEN NEW.action_route IS NOT NULL
                  THEN E'\n\nOpen: ' || NEW.action_route
                  ELSE '' END
      );
    END IF;

    -- Optional push signal for workers
    PERFORM pg_notify(
      'push_notifications',
      json_build_object(
        'user_id', NEW.user_id,
        'type', NEW.type,
        'priority', NEW.priority,
        'title', NEW.title,
        'message', NEW.message,
        'route', NEW.action_route,
        'notification_id', NEW.id
      )::text
    );
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."fanout_urgent_notifications"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."fn_profile_audit"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    SET "search_path" TO 'public', 'extensions'
    AS $$
DECLARE
  v_changed_by uuid := auth.uid();
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO public.profile_audit (user_id, table_name, action, changed_by, old_data, new_data)
    VALUES (NEW.user_id, TG_TABLE_NAME, TG_OP, v_changed_by, NULL, to_jsonb(NEW));
    RETURN NEW;

  ELSIF TG_OP = 'UPDATE' THEN
    INSERT INTO public.profile_audit (user_id, table_name, action, changed_by, old_data, new_data)
    VALUES (NEW.user_id, TG_TABLE_NAME, TG_OP, v_changed_by, to_jsonb(OLD), to_jsonb(NEW));
    RETURN NEW;

  ELSIF TG_OP = 'DELETE' THEN
    INSERT INTO public.profile_audit (user_id, table_name, action, changed_by, old_data, new_data)
    VALUES (OLD.user_id, TG_TABLE_NAME, TG_OP, v_changed_by, to_jsonb(OLD), NULL);
    RETURN OLD;
  END IF;

  RETURN NULL;
END;
$$;


ALTER FUNCTION "public"."fn_profile_audit"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."friend_authors_for_viewer"("p_viewer" "uuid") RETURNS TABLE("author_id" "uuid")
    LANGUAGE "sql" STABLE
    AS $$
  -- include the viewer themselves
  SELECT p_viewer AS author_id
  UNION ALL
  -- include all accepted friendships where viewer is user_id
  SELECT f.friend_id
  FROM public.friendships f
  WHERE f.user_id = p_viewer
    AND f.status = 'accepted'
  UNION ALL
  -- include all accepted friendships where viewer is friend_id
  SELECT f.user_id
  FROM public.friendships f
  WHERE f.friend_id = p_viewer
    AND f.status = 'accepted';
$$;


ALTER FUNCTION "public"."friend_authors_for_viewer"("p_viewer" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."generate_check_in_code"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  NEW.check_in_code = UPPER(SUBSTRING(MD5(RANDOM()::TEXT || NEW.game_id::TEXT || NEW.player_id::TEXT), 1, 6));
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."generate_check_in_code"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_available_slots"("p_venue_id" "uuid", "p_sport_id" "uuid", "p_date" "date", "p_duration" integer) RETURNS TABLE("start_time" time without time zone, "end_time" time without time zone, "court_number" integer, "price" numeric)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  -- This is a simplified version
  -- In production, this would check against existing bookings
  -- and venue operating hours
  RETURN QUERY
  SELECT 
    ts.start_time,
    ts.end_time,
    ts.court_number,
    COALESCE(ts.price_override, vs.price_per_hour) as price
  FROM venue_time_slots ts
  JOIN venue_sports vs ON vs.venue_id = ts.venue_id AND vs.sport_id = ts.sport_id
  WHERE ts.venue_id = p_venue_id
  AND ts.sport_id = p_sport_id
  AND ts.day_of_week = EXTRACT(DOW FROM p_date)
  AND ts.is_available = true
  AND NOT check_booking_conflict(
    p_venue_id, 
    p_date, 
    ts.start_time, 
    ts.start_time + (p_duration || ' minutes')::INTERVAL, 
    ts.court_number
  );
END;
$$;


ALTER FUNCTION "public"."get_available_slots"("p_venue_id" "uuid", "p_sport_id" "uuid", "p_date" "date", "p_duration" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_friend_suggestions"("p_user_id" "uuid", "p_limit" integer DEFAULT 10) RETURNS TABLE("user_id" "uuid", "username" "text", "full_name" "text", "avatar_url" "text", "mutual_friends_count" integer, "common_sports_count" integer, "distance_km" double precision)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN QUERY
  WITH user_location AS (
    SELECT location_lat, location_lng 
    FROM public.profiles 
    WHERE id = p_user_id
  ),
  user_sports AS (
    SELECT sport_id 
    FROM public.user_sports_profiles 
    WHERE user_id = p_user_id
  ),
  mutual_friends AS (
    SELECT f2.friend_id, COUNT(*) as mutual_count
    FROM public.friendships f1
    JOIN public.friendships f2 ON f1.friend_id = f2.user_id
    WHERE f1.user_id = p_user_id 
    AND f1.status = 'accepted'
    AND f2.status = 'accepted'
    AND f2.friend_id != p_user_id
    AND NOT EXISTS (
      SELECT 1 FROM public.friendships 
      WHERE user_id = p_user_id 
      AND friend_id = f2.friend_id
    )
    GROUP BY f2.friend_id
  )
  SELECT 
    p.id,
    p.username,
    p.full_name,
    p.avatar_url,
    COALESCE(mf.mutual_count, 0)::INTEGER as mutual_friends_count,
    (
      SELECT COUNT(*)::INTEGER 
      FROM public.user_sports_profiles usp 
      WHERE usp.user_id = p.id 
      AND usp.sport_id IN (SELECT sport_id FROM user_sports)
    ) as common_sports_count,
    CASE 
      WHEN p.location_lat IS NOT NULL AND p.location_lng IS NOT NULL 
           AND ul.location_lat IS NOT NULL AND ul.location_lng IS NOT NULL THEN
        earth_distance(
          ll_to_earth(p.location_lat, p.location_lng),
          ll_to_earth(ul.location_lat, ul.location_lng)
        ) / 1000.0 -- Convert to km
      ELSE NULL
    END as distance_km
  FROM public.profiles p
  CROSS JOIN user_location ul
  LEFT JOIN mutual_friends mf ON mf.friend_id = p.id
  WHERE p.id != p_user_id
  AND p.is_profile_complete = true
  AND NOT EXISTS (
    SELECT 1 FROM public.friendships 
    WHERE (user_id = p_user_id AND friend_id = p.id)
    OR (user_id = p.id AND friend_id = p_user_id)
  )
  ORDER BY 
    mutual_friends_count DESC,
    common_sports_count DESC,
    distance_km ASC NULLS LAST
  LIMIT p_limit;
END;
$$;


ALTER FUNCTION "public"."get_friend_suggestions"("p_user_id" "uuid", "p_limit" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_profile_analytics"("user_id" "uuid", "days_back" integer DEFAULT 30) RETURNS TABLE("total_views" integer, "unique_viewers" integer, "avg_duration" integer, "views_by_day" "jsonb", "top_sources" "jsonb")
    LANGUAGE "plpgsql"
    AS $$
BEGIN 
    RETURN QUERY 
    WITH date_range AS (
        SELECT generate_series(
            date_trunc('day', now() - interval '1 day' * days_back), 
            date_trunc('day', now()), 
            interval '1 day'
        )::date as day
    ), 
    daily_views AS (
        SELECT 
            date_trunc('day', viewed_at)::date as day, 
            COUNT(*) as views 
        FROM public.profile_views 
        WHERE profile_id = user_id 
        AND viewed_at >= now() - interval '1 day' * days_back 
        GROUP BY date_trunc('day', viewed_at)::date
    ), 
    source_stats AS (
        SELECT 
            source, 
            COUNT(*) as count 
        FROM public.profile_views 
        WHERE profile_id = user_id 
        AND viewed_at >= now() - interval '1 day' * days_back 
        AND source IS NOT NULL 
        GROUP BY source 
        ORDER BY count DESC 
        LIMIT 5
    ) 
    SELECT 
        (SELECT COUNT(*)::INTEGER FROM public.profile_views WHERE profile_id = user_id AND viewed_at >= now() - interval '1 day' * days_back),
        (SELECT COUNT(DISTINCT viewer_id)::INTEGER FROM public.profile_views WHERE profile_id = user_id AND viewed_at >= now() - interval '1 day' * days_back),
        (SELECT AVG(duration_seconds)::INTEGER FROM public.profile_views WHERE profile_id = user_id AND viewed_at >= now() - interval '1 day' * days_back AND duration_seconds IS NOT NULL),
        (SELECT jsonb_object_agg(d.day, COALESCE(dv.views, 0)) FROM date_range d LEFT JOIN daily_views dv ON d.day = dv.day),
        (SELECT jsonb_object_agg(source, count) FROM source_stats);
END;
$$;


ALTER FUNCTION "public"."get_profile_analytics"("user_id" "uuid", "days_back" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_social_feed"("p_user_id" "uuid", "p_limit" integer DEFAULT 20, "p_offset" integer DEFAULT 0, "p_filter_type" "text" DEFAULT NULL::"text") RETURNS TABLE("post_id" "uuid", "author_id" "uuid", "author_name" "text", "author_avatar" "text", "content" "text", "media_urls" "text"[], "post_type" "text", "likes_count" integer, "comments_count" integer, "user_liked" boolean, "created_at" timestamp with time zone, "relevance_score" double precision)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN QUERY
  WITH user_friends AS (
    SELECT friend_id FROM public.friendships
    WHERE user_id = p_user_id AND status = 'accepted'
  ),
  user_sports AS (
    SELECT sport_id FROM public.user_sports_profiles
    WHERE user_id = p_user_id
  )
  SELECT 
    p.id,
    p.author_id,
    pr.username,
    pr.avatar_url,
    p.content,
    p.media_urls,
    p.type::TEXT,
    p.likes_count,
    p.comments_count,
    EXISTS(
      SELECT 1 FROM public.reactions r 
      WHERE r.post_id = p.id 
      AND r.user_id = p_user_id
    ) as user_liked,
    p.created_at,
    -- Calculate relevance score
    (
      CASE 
        -- Friend's post gets higher score
        WHEN p.author_id IN (SELECT friend_id FROM user_friends) THEN 2.0
        -- Public post gets base score
        WHEN p.visibility = 'public' THEN 1.0
        ELSE 0.5
      END
      -- Boost for posts about user's sports
      + CASE 
        WHEN p.sport_id IN (SELECT sport_id FROM user_sports) THEN 0.5
        ELSE 0.0
      END
      -- Recency factor (exponential decay)
      * POWER(0.95, EXTRACT(EPOCH FROM (now() - p.created_at)) / 3600.0)
      -- Engagement factor
      + (p.likes_count * 0.01 + p.comments_count * 0.02)
    ) as relevance_score
  FROM public.posts p
  JOIN public.profiles pr ON pr.id = p.author_id
  WHERE p.is_deleted = false
  AND (
    p.visibility = 'public' 
    OR (p.visibility = 'friends' AND p.author_id IN (SELECT friend_id FROM user_friends))
    OR p.author_id = p_user_id
  )
  AND NOT EXISTS (
    SELECT 1 FROM public.blocked_users
    WHERE (user_id = p_user_id AND blocked_user_id = p.author_id)
  )
  AND (p_filter_type IS NULL OR p.type = p_filter_type)
  ORDER BY relevance_score DESC, p.created_at DESC
  LIMIT p_limit
  OFFSET p_offset;
END;
$$;


ALTER FUNCTION "public"."get_social_feed"("p_user_id" "uuid", "p_limit" integer, "p_offset" integer, "p_filter_type" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_tier_from_points"("p_points" integer) RETURNS "uuid"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  v_tier_id UUID;
BEGIN
  SELECT id INTO v_tier_id
  FROM public.tier_levels
  WHERE p_points >= min_points AND p_points <= max_points
  LIMIT 1;
  
  RETURN v_tier_id;
END;
$$;


ALTER FUNCTION "public"."get_tier_from_points"("p_points" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_trending_posts"("p_hours" integer DEFAULT 24, "p_limit" integer DEFAULT 10) RETURNS TABLE("post_id" "uuid", "author_name" "text", "content" "text", "engagement_score" double precision)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN QUERY
  SELECT 
    p.id,
    pr.username,
    p.content,
    (p.likes_count * 1.0 + p.comments_count * 2.0 + p.shares_count * 3.0) / 
    GREATEST(EXTRACT(EPOCH FROM (now() - p.created_at)) / 3600.0, 1.0) as engagement_score
  FROM public.posts p
  JOIN public.profiles pr ON pr.id = p.author_id
  WHERE p.created_at >= now() - INTERVAL '1 hour' * p_hours
  AND p.visibility = 'public'
  AND p.is_deleted = false
  ORDER BY engagement_score DESC
  LIMIT p_limit;
END;
$$;


ALTER FUNCTION "public"."get_trending_posts"("p_hours" integer, "p_limit" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_user_online_status"("last_active" timestamp with time zone) RETURNS "text"
    LANGUAGE "sql" IMMUTABLE
    AS $$
    SELECT 
      CASE 
        WHEN last_active > NOW() - INTERVAL '5 minutes' THEN 'online'
        WHEN last_active > NOW() - INTERVAL '1 hour' THEN 'recently'
        ELSE 'offline'
      END;
$$;


ALTER FUNCTION "public"."get_user_online_status"("last_active" timestamp with time zone) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_friendship_reciprocal"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  -- When a friendship is created, create the reciprocal record
  IF TG_OP = 'INSERT' THEN
    INSERT INTO public.friendships (user_id, friend_id, status, initiated_by, message, created_at)
    VALUES (NEW.friend_id, NEW.user_id, NEW.status, NEW.initiated_by, NEW.message, NEW.created_at)
    ON CONFLICT (user_id, friend_id) DO NOTHING;
  
  -- When a friendship is updated, update the reciprocal record
  ELSIF TG_OP = 'UPDATE' THEN
    UPDATE public.friendships 
    SET 
      status = NEW.status,
      became_friends_at = NEW.became_friends_at,
      blocked_at = NEW.blocked_at,
      blocked_by = NEW.blocked_by,
      updated_at = NEW.updated_at
    WHERE user_id = NEW.friend_id AND friend_id = NEW.user_id;
  
  -- When a friendship is deleted, delete the reciprocal record
  ELSIF TG_OP = 'DELETE' THEN
    DELETE FROM public.friendships 
    WHERE user_id = OLD.friend_id AND friend_id = OLD.user_id;
  END IF;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."handle_friendship_reciprocal"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_auth_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
  existing_user_id uuid;
  new_display_name text := NULLIF(COALESCE(NEW.raw_user_meta_data->>'full_name',''), '');
BEGIN
  -- Look up by email case-insensitively and lock any match to avoid races
  SELECT id
  INTO existing_user_id
  FROM public.users
  WHERE lower(email) = lower(NEW.email)
  FOR UPDATE;

  IF existing_user_id IS NOT NULL THEN
    -- link existing app user to this auth user
    UPDATE public.users u
    SET auth_id    = NEW.id,
        email      = NEW.email,
        display_name = COALESCE(new_display_name, u.display_name),
        updated_at = now()
    WHERE u.id = existing_user_id;
  ELSE
    -- create a fresh app user linked to this auth user
    INSERT INTO public.users (id, auth_id, email, display_name, created_at, updated_at)
    VALUES (gen_random_uuid(), NEW.id, NEW.email, COALESCE(new_display_name, ''), now(), now());
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."handle_new_auth_user"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
    -- Check if profile already exists to avoid duplicates
    IF EXISTS(SELECT 1 FROM public.users WHERE id = NEW.id) THEN
        RETURN NEW;
    END IF;

    -- Insert new user profile with complete onboarding data from metadata
    INSERT INTO public.users (
        id,
        email,
        display_name,
        age,
        gender,
        sports,
        intent,
        onboarding_completed,
        onboarding_step,
        language,
        timezone,
        notification_settings,
        privacy_settings,
        avatar_url,
        skill_level,
        games_played,
        bio,
        created_at,
        updated_at
    ) VALUES (
        NEW.id,
        COALESCE(NEW.email, ''),
        COALESCE(NEW.raw_user_meta_data->>'name', 'Player'),
        CASE 
            WHEN NEW.raw_user_meta_data->>'age' IS NOT NULL 
            THEN (NEW.raw_user_meta_data->>'age')::INTEGER 
            ELSE NULL 
        END,
        CASE 
            WHEN NEW.raw_user_meta_data->>'gender' IN ('male', 'female', 'other', 'prefer_not_to_say')
            THEN (NEW.raw_user_meta_data->>'gender')::user_gender
            ELSE NULL
        END,
        CASE 
            WHEN NEW.raw_user_meta_data->>'sports' IS NOT NULL
            THEN ARRAY(SELECT json_array_elements_text((NEW.raw_user_meta_data->>'sports')::json))
            ELSE '{}'::TEXT[]
        END,
        CASE 
            WHEN NEW.raw_user_meta_data->>'intent' IN ('casual', 'competitive', 'social', 'fitness', 'professional')
            THEN (NEW.raw_user_meta_data->>'intent')::user_intent
            ELSE NULL
        END,
        FALSE, -- onboarding_completed
        'phone_input', -- onboarding_step
        'en', -- language
        'UTC', -- timezone
        '{}', -- notification_settings
        '{}', -- privacy_settings
        'assets/Avatar/default-avatar.svg', -- avatar_url
        'beginner', -- skill_level
        0, -- games_played
        NULL, -- bio
        NOW(),
        NOW()
    );
    
    RETURN NEW;
EXCEPTION
    WHEN OTHERS THEN
        RAISE WARNING 'Failed to create user profile for %: %', COALESCE(NEW.email, 'unknown'), SQLERRM;
        RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  NEW.updated_at = timezone('utc'::text, now());
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."handle_updated_at"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."increment_comments_count"("post_id" "uuid") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
    UPDATE public.posts 
    SET comments_count = comments_count + 1,
        updated_at = NOW()
    WHERE id = post_id;
END;
$$;


ALTER FUNCTION "public"."increment_comments_count"("post_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."increment_likes_count"("post_id" "uuid") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
    UPDATE public.posts 
    SET likes_count = likes_count + 1,
        updated_at = NOW()
    WHERE id = post_id;
END;
$$;


ALTER FUNCTION "public"."increment_likes_count"("post_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_message_unread_for_user"("read_by" "uuid"[], "current_user_id" "uuid") RETURNS boolean
    LANGUAGE "sql" IMMUTABLE
    AS $$
    SELECT NOT (current_user_id = ANY(read_by));
$$;


ALTER FUNCTION "public"."is_message_unread_for_user"("read_by" "uuid"[], "current_user_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_profile_feature_enabled"("p_feature_name" "text", "p_user_id" "uuid") RETURNS boolean
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  feature_record RECORD;
  user_hash INTEGER;
BEGIN
  -- Get feature flag record
  SELECT * INTO feature_record
  FROM public.profile_feature_flags
  WHERE feature_name = p_feature_name;
  
  -- Feature doesn't exist
  IF NOT FOUND THEN
    RETURN false;
  END IF;
  
  -- Feature is fully disabled
  IF NOT feature_record.is_enabled THEN
    RETURN false;
  END IF;
  
  -- Check whitelist
  IF p_user_id = ANY(feature_record.user_whitelist) THEN
    RETURN true;
  END IF;
  
  -- Check rollout percentage
  IF feature_record.rollout_percentage = 100 THEN
    RETURN true;
  END IF;
  
  IF feature_record.rollout_percentage = 0 THEN
    RETURN false;
  END IF;
  
  -- Hash user ID to get consistent value between 0-99
  user_hash := abs(hashtext(p_user_id::text)) % 100;
  
  RETURN user_hash < feature_record.rollout_percentage;
END;
$$;


ALTER FUNCTION "public"."is_profile_feature_enabled"("p_feature_name" "text", "p_user_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."leaderboard_my_rank"("p_leaderboard" "uuid") RETURNS TABLE("user_id" "uuid", "score" numeric, "rank" integer)
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  SELECT e.user_id, e.score, e.rank
  FROM public.leaderboard_entries e
  WHERE e.leaderboard_id = p_leaderboard
    AND e.user_id = auth.uid()
$$;


ALTER FUNCTION "public"."leaderboard_my_rank"("p_leaderboard" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."leaderboard_top"("p_leaderboard" "uuid", "p_limit" integer DEFAULT 20) RETURNS TABLE("user_id" "uuid", "score" numeric, "rank" integer)
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  SELECT e.user_id, e.score, e.rank
  FROM public.leaderboard_entries e
  WHERE e.leaderboard_id = p_leaderboard
  ORDER BY e.rank ASC NULLS LAST, e.score DESC
  LIMIT GREATEST(p_limit,1)
$$;


ALTER FUNCTION "public"."leaderboard_top"("p_leaderboard" "uuid", "p_limit" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."mark_notifications_read"("p_ids" "uuid"[]) RETURNS integer
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
  v_uid uuid := auth.uid();
  v_cnt int;
BEGIN
  IF v_uid IS NULL THEN
    RAISE EXCEPTION 'not authenticated' USING ERRCODE = '28000';
  END IF;

  UPDATE public.notifications_unified n
  SET is_read = true
  WHERE n.user_id = v_uid
    AND n.id = ANY (p_ids)
    AND n.is_read IS DISTINCT FROM true;

  GET DIAGNOSTICS v_cnt = ROW_COUNT;
  RETURN v_cnt;
END;
$$;


ALTER FUNCTION "public"."mark_notifications_read"("p_ids" "uuid"[]) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."mark_oldest_unread"("_user_id" "uuid", "_limit" integer DEFAULT 1) RETURNS integer
    LANGUAGE "plpgsql"
    AS $$
DECLARE affected int;
BEGIN
  WITH ids AS (
    SELECT id
    FROM notifications
    WHERE user_id = _user_id AND is_read = false
    ORDER BY created_at ASC
    LIMIT _limit
  )
  UPDATE notifications n
  SET is_read = true, read_at = now(), updated_at = now()
  FROM ids
  WHERE n.id = ids.id;

  GET DIAGNOSTICS affected = ROW_COUNT;
  RETURN affected;
END;
$$;


ALTER FUNCTION "public"."mark_oldest_unread"("_user_id" "uuid", "_limit" integer) OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."users" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "email" "text" NOT NULL,
    "display_name" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "age" integer,
    "intent" "public"."user_intent",
    "avatar_url" "text" DEFAULT 'https://ekmhrxdwgegxkdkdukgq.supabase.co/storage/v1/object/public/post-images/male-1.png'::"text",
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "sports" "text"[] DEFAULT ARRAY[]::"text"[],
    "phone" "text",
    "phone_confirmed_at" timestamp with time zone,
    "email_confirmed_at" timestamp with time zone,
    "last_sign_in_at" timestamp with time zone,
    "is_anonymous" boolean DEFAULT false,
    "onboarding_completed" boolean DEFAULT false NOT NULL,
    "onboarding_step" "text" DEFAULT 'phone_input'::"text" NOT NULL,
    "language" "text" DEFAULT 'en'::"text",
    "timezone" "text" DEFAULT 'UTC'::"text",
    "notification_settings" "jsonb" DEFAULT '{}'::"jsonb",
    "privacy_settings" "jsonb" DEFAULT '{}'::"jsonb",
    "skill_level" "text" DEFAULT 'beginner'::"text",
    "games_played" integer DEFAULT 0,
    "bio" "text",
    "date_of_birth" "date",
    "is_profile_complete" boolean DEFAULT false,
    "is_email_verified" boolean DEFAULT false,
    "is_phone_verified" boolean DEFAULT false,
    "profile_completion_percentage" integer DEFAULT 0,
    "gender" "public"."user_gender",
    "auth_id" "uuid" NOT NULL,
    CONSTRAINT "age_range" CHECK ((("age" >= 13) AND ("age" <= 120))),
    CONSTRAINT "display_name_length" CHECK ((("length"(TRIM(BOTH FROM "display_name")) >= 2) AND ("length"(TRIM(BOTH FROM "display_name")) <= 50)))
);


ALTER TABLE "public"."users" OWNER TO "postgres";


COMMENT ON COLUMN "public"."users"."display_name" IS 'Primary and only name field for the user (consolidated from previous name and full_name fields)';



COMMENT ON COLUMN "public"."users"."age" IS 'User age (13-100)';



COMMENT ON COLUMN "public"."users"."intent" IS 'User intent for using the platform';



COMMENT ON COLUMN "public"."users"."avatar_url" IS 'User profile image URL';



COMMENT ON COLUMN "public"."users"."sports" IS 'Array of sports the user is interested in';



COMMENT ON COLUMN "public"."users"."onboarding_completed" IS 'Whether user has completed onboarding';



COMMENT ON COLUMN "public"."users"."onboarding_step" IS 'Current onboarding step';



COMMENT ON COLUMN "public"."users"."language" IS 'User preferred language (en/ar)';



COMMENT ON COLUMN "public"."users"."timezone" IS 'User timezone';



COMMENT ON COLUMN "public"."users"."notification_settings" IS 'User notification preferences';



COMMENT ON COLUMN "public"."users"."privacy_settings" IS 'User privacy preferences';



CREATE OR REPLACE FUNCTION "public"."me"() RETURNS "public"."users"
    LANGUAGE "sql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  SELECT u.*
  FROM public.users u
  WHERE u.id = auth.uid()
$$;


ALTER FUNCTION "public"."me"() OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_preferences" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "preferred_game_types" "text"[] DEFAULT ARRAY['casual'::"text", 'competitive'::"text"],
    "preferred_game_duration" integer DEFAULT 60,
    "preferred_team_size_min" integer DEFAULT 2,
    "preferred_team_size_max" integer DEFAULT 10,
    "preferred_radius_km" integer DEFAULT 10,
    "preferred_venues" "text"[],
    "travel_willingness" "text" DEFAULT 'medium'::"text",
    "weekly_availability" "jsonb" DEFAULT '{}'::"jsonb",
    "advance_booking_days" integer DEFAULT 7,
    "last_minute_availability" boolean DEFAULT true,
    "open_to_new_players" boolean DEFAULT true,
    "preferred_age_range_min" integer,
    "preferred_age_range_max" integer,
    "preferred_gender_mix" "text" DEFAULT 'any'::"text",
    "equipment_sharing" boolean DEFAULT true,
    "coaching_interest" boolean DEFAULT false,
    "tournament_interest" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "user_preferences_preferred_gender_mix_check" CHECK (("preferred_gender_mix" = ANY (ARRAY['any'::"text", 'same'::"text", 'mixed'::"text"]))),
    CONSTRAINT "user_preferences_travel_willingness_check" CHECK (("travel_willingness" = ANY (ARRAY['low'::"text", 'medium'::"text", 'high'::"text"])))
);


ALTER TABLE "public"."user_preferences" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."me_preferences"() RETURNS "public"."user_preferences"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  SELECT p.*
  FROM public.user_preferences p
  WHERE p.user_id = auth.uid()
  LIMIT 1
$$;


ALTER FUNCTION "public"."me_preferences"() OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."privacy_settings" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "profile_visibility" "text" DEFAULT 'public'::"text",
    "show_real_name" boolean DEFAULT true,
    "show_email" boolean DEFAULT false,
    "show_phone" boolean DEFAULT false,
    "show_location" boolean DEFAULT true,
    "show_age" boolean DEFAULT true,
    "show_sports_stats" boolean DEFAULT true,
    "show_game_history" boolean DEFAULT true,
    "show_upcoming_games" boolean DEFAULT true,
    "show_favorite_venues" boolean DEFAULT true,
    "searchable" boolean DEFAULT true,
    "allow_friend_requests" boolean DEFAULT true,
    "allow_game_invites" boolean DEFAULT true,
    "allow_messages" boolean DEFAULT true,
    "share_analytics" boolean DEFAULT true,
    "share_location_data" boolean DEFAULT true,
    "marketing_emails" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "privacy_settings_profile_visibility_check" CHECK (("profile_visibility" = ANY (ARRAY['public'::"text", 'friends'::"text", 'private'::"text"])))
);


ALTER TABLE "public"."privacy_settings" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."me_privacy"() RETURNS "public"."privacy_settings"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  SELECT s.*
  FROM public.privacy_settings s
  WHERE s.user_id = auth.uid()
  LIMIT 1
$$;


ALTER FUNCTION "public"."me_privacy"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."me_profile"() RETURNS SETOF "public"."me_profile_row"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  SELECT
    u.id,
    u.email,
    u.display_name,
    u.avatar_url,
    u.bio,
    u.age,
    u.gender,
    u.sports,
    u.intent,
    u.language,
    u.timezone,
    u.created_at,
    u.profile_completion_percentage,

    up.preferred_game_types,
    up.preferred_game_duration,
    up.preferred_team_size_min,
    up.preferred_team_size_max,
    up.preferred_radius_km,
    up.weekly_availability,
    up.last_minute_availability,
    up.open_to_new_players,
    up.tournament_interest,

    pr.profile_visibility,
    pr.show_real_name,
    pr.show_email,
    pr.show_phone,
    pr.show_location,
    pr.show_age,
    pr.show_sports_stats,
    pr.show_game_history,
    pr.show_upcoming_games,
    pr.show_favorite_venues,
    pr.searchable,
    pr.allow_friend_requests,
    pr.allow_game_invites,
    pr.allow_messages,
    pr.share_analytics,
    pr.share_location_data,
    pr.marketing_emails
  FROM public.users u
  LEFT JOIN public.user_preferences up ON up.user_id = u.id
  LEFT JOIN public.privacy_settings pr ON pr.user_id = u.id
  WHERE u.id = auth.uid()
  LIMIT 1
$$;


ALTER FUNCTION "public"."me_profile"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."me_update_profile"("p" "jsonb") RETURNS SETOF "public"."me_profile_row"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
  v_uid uuid := auth.uid();
BEGIN
  IF v_uid IS NULL THEN
    RAISE EXCEPTION 'not authenticated' USING ERRCODE = '28000';
  END IF;

  -- users (core)
  UPDATE public.users u
  SET
    display_name = COALESCE(p->>'display_name', u.display_name),
    bio          = CASE WHEN p ? 'bio' THEN NULLIF(p->>'bio','') ELSE u.bio END,
    age          = COALESCE((p->>'age')::int, u.age),
    gender       = COALESCE((p->>'gender')::public.user_gender, u.gender),
    sports       = COALESCE(
                     (SELECT ARRAY(SELECT trim(x) FROM jsonb_array_elements_text(p->'sports') AS x)),
                     u.sports
                   ),
    intent       = COALESCE((p->>'intent')::public.user_intent, u.intent),
    language     = COALESCE(NULLIF(p->>'language',''), u.language),
    timezone     = COALESCE(NULLIF(p->>'timezone',''), u.timezone),
    updated_at   = now()
  WHERE u.id = v_uid;

  -- user_preferences (upsert)
  INSERT INTO public.user_preferences (user_id)
  VALUES (v_uid)
  ON CONFLICT (user_id) DO NOTHING;

  UPDATE public.user_preferences up
  SET
    preferred_game_types     = COALESCE(
                                  (SELECT ARRAY(SELECT trim(x) FROM jsonb_array_elements_text(p->'preferred_game_types') AS x)),
                                  up.preferred_game_types
                                ),
    preferred_game_duration  = COALESCE((p->>'preferred_game_duration')::int, up.preferred_game_duration),
    preferred_team_size_min  = COALESCE((p->>'preferred_team_size_min')::int, up.preferred_team_size_min),
    preferred_team_size_max  = COALESCE((p->>'preferred_team_size_max')::int, up.preferred_team_size_max),
    preferred_radius_km      = COALESCE((p->>'preferred_radius_km')::int, up.preferred_radius_km),
    weekly_availability      = COALESCE(p->'weekly_availability', up.weekly_availability),
    last_minute_availability = COALESCE((p->>'last_minute_availability')::boolean, up.last_minute_availability),
    open_to_new_players      = COALESCE((p->>'open_to_new_players')::boolean, up.open_to_new_players),
    tournament_interest      = COALESCE((p->>'tournament_interest')::boolean, up.tournament_interest),
    updated_at               = now()
  WHERE up.user_id = v_uid;

  -- privacy_settings (upsert)
  INSERT INTO public.privacy_settings (user_id)
  VALUES (v_uid)
  ON CONFLICT (user_id) DO NOTHING;

  UPDATE public.privacy_settings pr
  SET
    profile_visibility     = COALESCE(NULLIF(p->>'profile_visibility',''), pr.profile_visibility),
    show_real_name         = COALESCE((p->>'show_real_name')::boolean, pr.show_real_name),
    show_email             = COALESCE((p->>'show_email')::boolean, pr.show_email),
    show_phone             = COALESCE((p->>'show_phone')::boolean, pr.show_phone),
    show_location          = COALESCE((p->>'show_location')::boolean, pr.show_location),
    show_age               = COALESCE((p->>'show_age')::boolean, pr.show_age),
    show_sports_stats      = COALESCE((p->>'show_sports_stats')::boolean, pr.show_sports_stats),
    show_game_history      = COALESCE((p->>'show_game_history')::boolean, pr.show_game_history),
    show_upcoming_games    = COALESCE((p->>'show_upcoming_games')::boolean, pr.show_upcoming_games),
    show_favorite_venues   = COALESCE((p->>'show_favorite_venues')::boolean, pr.show_favorite_venues),
    searchable             = COALESCE((p->>'searchable')::boolean, pr.searchable),
    allow_friend_requests  = COALESCE((p->>'allow_friend_requests')::boolean, pr.allow_friend_requests),
    allow_game_invites     = COALESCE((p->>'allow_game_invites')::boolean, pr.allow_game_invites),
    allow_messages         = COALESCE((p->>'allow_messages')::boolean, pr.allow_messages),
    share_analytics        = COALESCE((p->>'share_analytics')::boolean, pr.share_analytics),
    share_location_data    = COALESCE((p->>'share_location_data')::boolean, pr.share_location_data),
    marketing_emails       = COALESCE((p->>'marketing_emails')::boolean, pr.marketing_emails),
    updated_at             = now()
  WHERE pr.user_id = v_uid;

  RETURN QUERY SELECT * FROM public.me_profile();
END;
$$;


ALTER FUNCTION "public"."me_update_profile"("p" "jsonb") OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."notifications_unified" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "actor_id" "uuid",
    "category" "public"."notification_category" NOT NULL,
    "kind" "text" NOT NULL,
    "data" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "is_read" boolean DEFAULT false NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."notifications_unified" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."my_notification_set_read"("p_notification_id" "uuid", "p_is_read" boolean DEFAULT true) RETURNS SETOF "public"."notifications_unified"
    LANGUAGE "plpgsql"
    SET "search_path" TO 'public'
    AS $$
BEGIN
  RETURN QUERY
  UPDATE public.notifications_unified n
  SET is_read = p_is_read
  WHERE n.id = p_notification_id
    AND n.user_id = auth.uid()
  RETURNING n.*;
END;
$$;


ALTER FUNCTION "public"."my_notification_set_read"("p_notification_id" "uuid", "p_is_read" boolean) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."my_notifications"("p_limit" integer DEFAULT 20, "p_before" timestamp with time zone DEFAULT "now"()) RETURNS TABLE("id" "uuid", "category" "public"."notification_category", "kind" "text", "data" "jsonb", "is_read" boolean, "actor_id" "uuid", "created_at" timestamp with time zone)
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  SELECT
    n.id,
    n.category,
    n.kind,
    n.data,
    n.is_read,
    n.actor_id,
    n.created_at
  FROM public.notifications_unified n
  WHERE n.user_id   = auth.uid()
    AND n.created_at < p_before
  ORDER BY n.created_at DESC
  LIMIT GREATEST(p_limit, 1)
$$;


ALTER FUNCTION "public"."my_notifications"("p_limit" integer, "p_before" timestamp with time zone) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."my_notifications"("p_only_unread" boolean DEFAULT false, "p_limit" integer DEFAULT 20, "p_offset" integer DEFAULT 0) RETURNS SETOF "public"."notifications_unified"
    LANGUAGE "sql"
    SET "search_path" TO 'public'
    AS $$
  SELECT *
  FROM public.notifications_unified
  WHERE user_id = auth.uid()
    AND (NOT p_only_unread OR is_read = false)
  ORDER BY created_at DESC
  LIMIT p_limit OFFSET p_offset;
$$;


ALTER FUNCTION "public"."my_notifications"("p_only_unread" boolean, "p_limit" integer, "p_offset" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."my_notifications_detailed"("p_only_unread" boolean DEFAULT false, "p_limit" integer DEFAULT 20, "p_offset" integer DEFAULT 0) RETURNS TABLE("id" "uuid", "category" "public"."notification_category", "kind" "text", "data" "jsonb", "is_read" boolean, "created_at" timestamp with time zone, "actor_id" "uuid", "actor_name" "text", "actor_avatar" "text")
    LANGUAGE "sql"
    SET "search_path" TO 'public'
    AS $$
  SELECT
    n.id,
    n.category,
    n.kind,
    n.data,
    n.is_read,
    n.created_at,
    n.actor_id,
    a.display_name AS actor_name,
    a.avatar_url   AS actor_avatar
  FROM public.notifications_unified n
  LEFT JOIN public.users a ON a.id = n.actor_id
  WHERE n.user_id = auth.uid()
    AND (NOT p_only_unread OR n.is_read = false)
  ORDER BY n.created_at DESC
  LIMIT p_limit OFFSET p_offset;
$$;


ALTER FUNCTION "public"."my_notifications_detailed"("p_only_unread" boolean, "p_limit" integer, "p_offset" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."my_notifications_unread_count"() RETURNS integer
    LANGUAGE "sql"
    SET "search_path" TO 'public'
    AS $$
  SELECT count(*)::int
  FROM public.notifications_unified
  WHERE user_id = auth.uid() AND is_read = false;
$$;


ALTER FUNCTION "public"."my_notifications_unread_count"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."my_unread_count"() RETURNS integer
    LANGUAGE "sql" STABLE
    SET "search_path" TO 'public'
    AS $$
  SELECT count(*)::int
  FROM public.notifications_unified
  WHERE user_id = auth.uid()
    AND is_read = false;
$$;


ALTER FUNCTION "public"."my_unread_count"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."precompute_user_feed"("p_user_id" "uuid") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  -- Clear old cache entries
  DELETE FROM public.user_feed_cache 
  WHERE user_id = p_user_id 
  AND cached_at < now() - INTERVAL '24 hours';
  
  -- Insert new feed items
  INSERT INTO public.user_feed_cache (user_id, post_id, relevance_score)
  SELECT 
    p_user_id,
    post_id,
    relevance_score
  FROM public.get_social_feed(p_user_id, 100, 0)
  ON CONFLICT (user_id, post_id) 
  DO UPDATE SET 
    relevance_score = EXCLUDED.relevance_score,
    cached_at = now();
END;
$$;


ALTER FUNCTION "public"."precompute_user_feed"("p_user_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."profile_audit_log_fn"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
  v_actor uuid := auth.uid();
  v_payload jsonb;
  v_user uuid;
BEGIN
  -- Prefer the row's user_id; fall back to auth.uid()
  IF TG_OP IN ('INSERT','UPDATE') THEN
    v_user := COALESCE(NEW.user_id, v_actor);
  ELSE
    v_user := COALESCE(OLD.user_id, v_actor);
  END IF;

  IF TG_OP = 'INSERT' THEN
    v_payload := to_jsonb(NEW);
    INSERT INTO public.profile_audit_log(user_id, table_name, action, changed_by, changed_to)
    VALUES (v_user, TG_TABLE_NAME, 'INSERT', v_actor, v_payload);
    RETURN NEW;

  ELSIF TG_OP = 'UPDATE' THEN
    v_payload := jsonb_build_object('old', to_jsonb(OLD), 'new', to_jsonb(NEW));
    INSERT INTO public.profile_audit_log(user_id, table_name, action, changed_by, changed_to)
    VALUES (v_user, TG_TABLE_NAME, 'UPDATE', v_actor, v_payload);
    RETURN NEW;

  ELSIF TG_OP = 'DELETE' THEN
    v_payload := to_jsonb(OLD);
    INSERT INTO public.profile_audit_log(user_id, table_name, action, changed_by, changed_to)
    VALUES (v_user, TG_TABLE_NAME, 'DELETE', v_actor, v_payload);
    RETURN OLD;
  END IF;

  RETURN NULL;
END;
$$;


ALTER FUNCTION "public"."profile_audit_log_fn"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."react"("p_target_type" "text", "p_target_id" "uuid", "p_reaction" "text" DEFAULT 'like'::"text") RETURNS TABLE("toggled_on" boolean, "reaction_id" "uuid")
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  DECLARE
    uid uuid := auth.uid();
    v_id uuid;
    v_type text := lower(p_target_type);
    v_rxn  text := lower(p_reaction);
  BEGIN
    IF uid IS NULL THEN
      RAISE EXCEPTION 'not authenticated' USING ERRCODE = '28000';
    END IF;

    IF v_type NOT IN ('post','comment','message','game','profile') THEN
      RAISE EXCEPTION 'invalid target_type %', v_type USING ERRCODE = '22023';
    END IF;

    IF v_rxn NOT IN ('like','love','wow','laugh','sad','angry') THEN
      RAISE EXCEPTION 'invalid reaction %', v_rxn USING ERRCODE = '22023';
    END IF;

    IF EXISTS (
      SELECT 1 FROM public.reactions_unified
      WHERE user_id=uid AND target_type=v_type AND target_id=p_target_id
    ) THEN
      DELETE FROM public.reactions_unified
      WHERE user_id=uid AND target_type=v_type AND target_id=p_target_id
      RETURNING id INTO v_id;
      RETURN QUERY SELECT false, v_id;
      RETURN;
    END IF;

    INSERT INTO public.reactions_unified (user_id, target_type, target_id, reaction)
    VALUES (uid, v_type, p_target_id, v_rxn)
    RETURNING id INTO v_id;

    RETURN QUERY SELECT true, v_id;
  END;
  $$;


ALTER FUNCTION "public"."react"("p_target_type" "text", "p_target_id" "uuid", "p_reaction" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."react_toggle"("p_target_type" "text", "p_target_id" "uuid", "p_reaction" "text") RETURNS TABLE("reaction" "text", "cnt" bigint)
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
  v_uid      uuid := auth.uid();
  v_existing uuid;
BEGIN
  IF v_uid IS NULL THEN
    RAISE EXCEPTION 'not authenticated' USING ERRCODE = '28000';
  END IF;

  IF p_target_type NOT IN ('post','comment') THEN
    RAISE EXCEPTION 'unsupported target_type: %', p_target_type USING ERRCODE='22023';
  END IF;

  -- Check if this exact reaction already exists from this user on this target
  SELECT r.id
  INTO   v_existing
  FROM   public.reactions r
  WHERE  r.user_id = v_uid
     AND (
           (p_target_type = 'post'    AND r.post_id    = p_target_id AND r.comment_id IS NULL)
        OR (p_target_type = 'comment' AND r.comment_id = p_target_id AND r.post_id    IS NULL)
         )
     AND  r.reaction_type = p_reaction
  LIMIT 1;

  IF v_existing IS NULL THEN
    -- Insert new reaction
    INSERT INTO public.reactions (user_id, post_id, comment_id, reaction_type, created_at)
    VALUES (
      v_uid,
      CASE WHEN p_target_type = 'post'    THEN p_target_id ELSE NULL END,
      CASE WHEN p_target_type = 'comment' THEN p_target_id ELSE NULL END,
      p_reaction,
      now()
    );
  ELSE
    -- Toggle off (delete existing)
    DELETE FROM public.reactions WHERE id = v_existing;
  END IF;

  -- Return fresh counts for the target
  RETURN QUERY
    SELECT rc.reaction, rc.cnt
    FROM   public.v_reaction_counts rc
    WHERE  rc.target_type = p_target_type
      AND  rc.target_id   = p_target_id
    ORDER  BY rc.reaction;
END;
$$;


ALTER FUNCTION "public"."react_toggle"("p_target_type" "text", "p_target_id" "uuid", "p_reaction" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."reactions_sync_likes"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    UPDATE public.posts
    SET likes_count = COALESCE(likes_count,0) + 1
    WHERE id = NEW.post_id;

  ELSIF TG_OP = 'DELETE' THEN
    UPDATE public.posts
    SET likes_count = GREATEST(COALESCE(likes_count,1) - 1, 0)
    WHERE id = OLD.post_id;
  END IF;
  RETURN NULL;
END;
$$;


ALTER FUNCTION "public"."reactions_sync_likes"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."refresh_all_leaderboards"() RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
    DECLARE
      lb record;
    BEGIN
      FOR lb IN SELECT id FROM public.leaderboards LOOP
        PERFORM public.refresh_leaderboard(lb.id);
      END LOOP;
    END;
    $$;


ALTER FUNCTION "public"."refresh_all_leaderboards"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."refresh_friend_activity"() RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.friend_activity;
END;
$$;


ALTER FUNCTION "public"."refresh_friend_activity"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."refresh_leaderboard"("p_leaderboard" "uuid") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
      BEGIN
        WITH ranked AS (
          SELECT id, RANK() OVER (ORDER BY score DESC) AS new_rank
          FROM public.leaderboard_entries
          WHERE leaderboard_id = p_leaderboard
        )
        UPDATE public.leaderboard_entries e
        SET rank = r.new_rank
        FROM ranked r
        WHERE e.id = r.id;
      END;
      $$;


ALTER FUNCTION "public"."refresh_leaderboard"("p_leaderboard" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."refresh_leaderboards"() RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.global_leaderboard;
  -- Additional leaderboard refreshes can be added here
END;
$$;


ALTER FUNCTION "public"."refresh_leaderboards"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."refresh_sport_leaderboards"() RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN REFRESH MATERIALIZED VIEW CONCURRENTLY public.sport_leaderboards;
END;
$$;


ALTER FUNCTION "public"."refresh_sport_leaderboards"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."run_notification_cleanup"() RETURNS "void"
    LANGUAGE "sql"
    AS $$
  UPDATE notifications
  SET is_read = true,
      read_at = now(),
      updated_at = now()
  WHERE is_read = false
    AND priority = 'low'
    AND created_at < now() - interval '30 days';

  DELETE FROM notifications
  WHERE is_read = true
    AND priority IN ('low', 'normal')
    AND created_at < now() - interval '180 days';
$$;


ALTER FUNCTION "public"."run_notification_cleanup"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."search_messages"("p_user_id" "uuid", "p_query" "text", "p_conversation_id" "uuid" DEFAULT NULL::"uuid", "p_limit" integer DEFAULT 20) RETURNS TABLE("message_id" "uuid", "conversation_id" "uuid", "sender_name" "text", "content" "text", "sent_at" timestamp with time zone, "rank" double precision)
    LANGUAGE "plpgsql" STABLE
    AS $$
BEGIN
  RETURN QUERY
  SELECT 
    m.id,
    m.conversation_id,
    p.username,
    m.content,
    m.created_at,
    ts_rank_cd(to_tsvector('english', m.content), plainto_tsquery('english', p_query)) as rank
  FROM public.messages m
  JOIN public.profiles p ON p.id = m.sender_id
  WHERE to_tsvector('english', m.content) @@ plainto_tsquery('english', p_query)
  AND EXISTS (
    SELECT 1 FROM public.conversation_participants cp
    WHERE cp.conversation_id = m.conversation_id
    AND cp.user_id = p_user_id
  )
  AND (p_conversation_id IS NULL OR m.conversation_id = p_conversation_id)
  AND m.is_deleted = false
  ORDER BY rank DESC, m.created_at DESC
  LIMIT p_limit;
END;
$$;


ALTER FUNCTION "public"."search_messages"("p_user_id" "uuid", "p_query" "text", "p_conversation_id" "uuid", "p_limit" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."search_profiles"("search_query" "text", "limit_count" integer DEFAULT 20, "offset_count" integer DEFAULT 0) RETURNS TABLE("id" "uuid", "username" "text", "full_name" "text", "avatar_url" "text", "bio" "text", "rank" real)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN QUERY
  SELECT
    u.id,
    NULL::text                         AS username,          -- no longer stored; keep column for compatibility
    u.display_name                     AS full_name,         -- map display_name -> full_name
    u.avatar_url,
    u.bio,
    CASE
      WHEN search_query IS NULL OR trim(search_query) = '' THEN 1.0
      ELSE 0.5
           + CASE WHEN u.display_name ILIKE '%'||search_query||'%' THEN 0.3 ELSE 0 END
           + CASE WHEN u.bio          ILIKE '%'||search_query||'%' THEN 0.2 ELSE 0 END
    END::real                          AS rank
  FROM public.users u
  WHERE
    (search_query IS NULL OR trim(search_query) = '')
    OR (u.display_name ILIKE '%'||search_query||'%' OR u.bio ILIKE '%'||search_query||'%')
  ORDER BY rank DESC, u.updated_at DESC NULLS LAST
  LIMIT limit_count OFFSET offset_count;
END;
$$;


ALTER FUNCTION "public"."search_profiles"("search_query" "text", "limit_count" integer, "offset_count" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."search_social_users"("p_query" "text", "p_sport_filter" "uuid" DEFAULT NULL::"uuid", "p_location_filter_km" integer DEFAULT NULL::integer, "p_user_lat" double precision DEFAULT NULL::double precision, "p_user_lng" double precision DEFAULT NULL::double precision, "p_limit" integer DEFAULT 20, "p_offset" integer DEFAULT 0) RETURNS TABLE("user_id" "uuid", "username" "text", "full_name" "text", "avatar_url" "text", "bio" "text", "sports" "text"[], "is_friend" boolean, "distance_km" double precision)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN QUERY
  SELECT 
    p.id,
    p.username,
    p.full_name,
    p.avatar_url,
    p.bio,
    ARRAY(
      SELECT s.name 
      FROM public.user_sports_profiles usp
      JOIN public.sports s ON s.id = usp.sport_id
      WHERE usp.user_id = p.id
      ORDER BY usp.is_primary_sport DESC, s.name
    ) as sports,
    EXISTS(
      SELECT 1 FROM public.friendships
      WHERE status = 'accepted'
      AND ((user_id = auth.uid() AND friend_id = p.id) OR
           (friend_id = auth.uid() AND user_id = p.id))
    ) as is_friend,
    CASE 
      WHEN p.location_lat IS NOT NULL AND p.location_lng IS NOT NULL 
           AND p_user_lat IS NOT NULL AND p_user_lng IS NOT NULL THEN
        earth_distance(
          ll_to_earth(p.location_lat, p.location_lng),
          ll_to_earth(p_user_lat, p_user_lng)
        ) / 1000.0
      ELSE NULL
    END as distance_km
  FROM public.profiles p
  WHERE p.search_vector @@ plainto_tsquery('english', p_query)
  AND p.is_profile_complete = true
  AND (p_sport_filter IS NULL OR EXISTS (
    SELECT 1 FROM public.user_sports_profiles usp
    WHERE usp.user_id = p.id AND usp.sport_id = p_sport_filter
  ))
  AND (p_location_filter_km IS NULL OR (
    p.location_lat IS NOT NULL AND p.location_lng IS NOT NULL 
    AND p_user_lat IS NOT NULL AND p_user_lng IS NOT NULL
    AND earth_distance(
      ll_to_earth(p.location_lat, p.location_lng),
      ll_to_earth(p_user_lat, p_user_lng)
    ) / 1000.0 <= p_location_filter_km
  ))
  ORDER BY 
    ts_rank(p.search_vector, plainto_tsquery('english', p_query)) DESC,
    distance_km ASC NULLS LAST
  LIMIT p_limit
  OFFSET p_offset;
END;
$$;


ALTER FUNCTION "public"."search_social_users"("p_query" "text", "p_sport_filter" "uuid", "p_location_filter_km" integer, "p_user_lat" double precision, "p_user_lng" double precision, "p_limit" integer, "p_offset" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."set_privacy_settings"("p_profile_visibility" "text" DEFAULT NULL::"text", "p_show_real_name" boolean DEFAULT NULL::boolean, "p_show_email" boolean DEFAULT NULL::boolean, "p_show_phone" boolean DEFAULT NULL::boolean, "p_show_location" boolean DEFAULT NULL::boolean, "p_show_age" boolean DEFAULT NULL::boolean, "p_show_sports_stats" boolean DEFAULT NULL::boolean, "p_show_game_history" boolean DEFAULT NULL::boolean, "p_show_upcoming_games" boolean DEFAULT NULL::boolean, "p_show_favorite_venues" boolean DEFAULT NULL::boolean, "p_searchable" boolean DEFAULT NULL::boolean, "p_allow_friend_requests" boolean DEFAULT NULL::boolean, "p_allow_game_invites" boolean DEFAULT NULL::boolean, "p_allow_messages" boolean DEFAULT NULL::boolean, "p_share_analytics" boolean DEFAULT NULL::boolean, "p_share_location_data" boolean DEFAULT NULL::boolean, "p_marketing_emails" boolean DEFAULT NULL::boolean) RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
  v_uid uuid := auth.uid();
BEGIN
  IF v_uid IS NULL THEN
    RAISE EXCEPTION 'not authenticated';
  END IF;

  UPDATE public.privacy_settings s
  SET
    profile_visibility     = COALESCE(p_profile_visibility,     s.profile_visibility),
    show_real_name         = COALESCE(p_show_real_name,         s.show_real_name),
    show_email             = COALESCE(p_show_email,             s.show_email),
    show_phone             = COALESCE(p_show_phone,             s.show_phone),
    show_location          = COALESCE(p_show_location,          s.show_location),
    show_age               = COALESCE(p_show_age,               s.show_age),
    show_sports_stats      = COALESCE(p_show_sports_stats,      s.show_sports_stats),
    show_game_history      = COALESCE(p_show_game_history,      s.show_game_history),
    show_upcoming_games    = COALESCE(p_show_upcoming_games,    s.show_upcoming_games),
    show_favorite_venues   = COALESCE(p_show_favorite_venues,   s.show_favorite_venues),
    searchable             = COALESCE(p_searchable,             s.searchable),
    allow_friend_requests  = COALESCE(p_allow_friend_requests,  s.allow_friend_requests),
    allow_game_invites     = COALESCE(p_allow_game_invites,     s.allow_game_invites),
    allow_messages         = COALESCE(p_allow_messages,         s.allow_messages),
    share_analytics        = COALESCE(p_share_analytics,        s.share_analytics),
    share_location_data    = COALESCE(p_share_location_data,    s.share_location_data),
    marketing_emails       = COALESCE(p_marketing_emails,       s.marketing_emails),
    updated_at             = now()
  WHERE s.user_id = v_uid;
END;
$$;


ALTER FUNCTION "public"."set_privacy_settings"("p_profile_visibility" "text", "p_show_real_name" boolean, "p_show_email" boolean, "p_show_phone" boolean, "p_show_location" boolean, "p_show_age" boolean, "p_show_sports_stats" boolean, "p_show_game_history" boolean, "p_show_upcoming_games" boolean, "p_show_favorite_venues" boolean, "p_searchable" boolean, "p_allow_friend_requests" boolean, "p_allow_game_invites" boolean, "p_allow_messages" boolean, "p_share_analytics" boolean, "p_share_location_data" boolean, "p_marketing_emails" boolean) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."set_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."set_updated_at"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."set_user_preferences"("p_preferred_game_types" "text"[] DEFAULT NULL::"text"[], "p_preferred_game_duration" integer DEFAULT NULL::integer, "p_preferred_team_size_min" integer DEFAULT NULL::integer, "p_preferred_team_size_max" integer DEFAULT NULL::integer, "p_preferred_radius_km" integer DEFAULT NULL::integer, "p_preferred_venues" "text"[] DEFAULT NULL::"text"[], "p_travel_willingness" "text" DEFAULT NULL::"text", "p_weekly_availability" "jsonb" DEFAULT NULL::"jsonb", "p_advance_booking_days" integer DEFAULT NULL::integer, "p_last_minute_availability" boolean DEFAULT NULL::boolean, "p_open_to_new_players" boolean DEFAULT NULL::boolean, "p_preferred_age_range_min" integer DEFAULT NULL::integer, "p_preferred_age_range_max" integer DEFAULT NULL::integer, "p_preferred_gender_mix" "text" DEFAULT NULL::"text", "p_equipment_sharing" boolean DEFAULT NULL::boolean, "p_coaching_interest" boolean DEFAULT NULL::boolean, "p_tournament_interest" boolean DEFAULT NULL::boolean) RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
  v_uid uuid := auth.uid();
BEGIN
  IF v_uid IS NULL THEN
    RAISE EXCEPTION 'not authenticated';
  END IF;

  UPDATE public.user_preferences p
  SET
    preferred_game_types      = COALESCE(p_preferred_game_types,      p.preferred_game_types),
    preferred_game_duration   = COALESCE(p_preferred_game_duration,   p.preferred_game_duration),
    preferred_team_size_min   = COALESCE(p_preferred_team_size_min,   p.preferred_team_size_min),
    preferred_team_size_max   = COALESCE(p_preferred_team_size_max,   p.preferred_team_size_max),
    preferred_radius_km       = COALESCE(p_preferred_radius_km,       p.preferred_radius_km),
    preferred_venues          = COALESCE(p_preferred_venues,          p.preferred_venues),
    travel_willingness        = COALESCE(p_travel_willingness,        p.travel_willingness),
    weekly_availability       = COALESCE(p_weekly_availability,       p.weekly_availability),
    advance_booking_days      = COALESCE(p_advance_booking_days,      p.advance_booking_days),
    last_minute_availability  = COALESCE(p_last_minute_availability,  p.last_minute_availability),
    open_to_new_players       = COALESCE(p_open_to_new_players,       p.open_to_new_players),
    preferred_age_range_min   = COALESCE(p_preferred_age_range_min,   p.preferred_age_range_min),
    preferred_age_range_max   = COALESCE(p_preferred_age_range_max,   p.preferred_age_range_max),
    preferred_gender_mix      = COALESCE(p_preferred_gender_mix,      p.preferred_gender_mix),
    equipment_sharing         = COALESCE(p_equipment_sharing,         p.equipment_sharing),
    coaching_interest         = COALESCE(p_coaching_interest,         p.coaching_interest),
    tournament_interest       = COALESCE(p_tournament_interest,       p.tournament_interest),
    updated_at                = now()
  WHERE p.user_id = v_uid;
END;
$$;


ALTER FUNCTION "public"."set_user_preferences"("p_preferred_game_types" "text"[], "p_preferred_game_duration" integer, "p_preferred_team_size_min" integer, "p_preferred_team_size_max" integer, "p_preferred_radius_km" integer, "p_preferred_venues" "text"[], "p_travel_willingness" "text", "p_weekly_availability" "jsonb", "p_advance_booking_days" integer, "p_last_minute_availability" boolean, "p_open_to_new_players" boolean, "p_preferred_age_range_min" integer, "p_preferred_age_range_max" integer, "p_preferred_gender_mix" "text", "p_equipment_sharing" boolean, "p_coaching_interest" boolean, "p_tournament_interest" boolean) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."set_user_settings"("p_theme_mode" "text" DEFAULT NULL::"text", "p_email_notifications" boolean DEFAULT NULL::boolean, "p_push_notifications" boolean DEFAULT NULL::boolean, "p_sms_notifications" boolean DEFAULT NULL::boolean) RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
  v_uid uuid := auth.uid();
BEGIN
  IF v_uid IS NULL THEN
    RAISE EXCEPTION 'not authenticated';
  END IF;

  UPDATE public.user_settings s
  SET
    theme_mode          = COALESCE(p_theme_mode, s.theme_mode),
    email_notifications = COALESCE(p_email_notifications, s.email_notifications),
    push_notifications  = COALESCE(p_push_notifications, s.push_notifications),
    sms_notifications   = COALESCE(p_sms_notifications, s.sms_notifications),
    updated_at          = now()
  WHERE s.user_id = v_uid;
END;
$$;


ALTER FUNCTION "public"."set_user_settings"("p_theme_mode" "text", "p_email_notifications" boolean, "p_push_notifications" boolean, "p_sms_notifications" boolean) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."sync_auth_user_data"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
BEGIN
  -- Only sync fields to an existing app user linked by auth_id.
  UPDATE public.users u
  SET
      email              = NEW.email,
      phone              = COALESCE(NEW.phone, u.phone),
      email_confirmed_at = NEW.email_confirmed_at,
      last_sign_in_at    = NEW.last_sign_in_at,
      is_anonymous       = COALESCE(NEW.is_anonymous, u.is_anonymous),
      updated_at         = now()
  WHERE u.auth_id = NEW.id;

  -- Do NOT insert here. Creation/linking is handled by handle_new_auth_user().
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."sync_auth_user_data"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."sync_feed_read_from_notification"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  -- Only on the transition false -> true
  IF NEW.is_read = true AND COALESCE(OLD.is_read, false) = false THEN
    UPDATE activity_feed
       SET is_read = true,
           read_at = COALESCE(read_at, now())
     WHERE notification_id = NEW.id;
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."sync_feed_read_from_notification"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."sync_game_skill_level"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  -- When skill_level text is updated, find matching skill_level_id
  IF NEW.skill_level IS NOT NULL AND (OLD.skill_level IS NULL OR NEW.skill_level != OLD.skill_level) THEN
    NEW.skill_level_id := (SELECT id FROM skill_levels WHERE LOWER(level) = LOWER(NEW.skill_level) LIMIT 1);
  END IF;

  -- When skill_level_id is updated, populate skill_level text
  IF NEW.skill_level_id IS NOT NULL AND (OLD.skill_level_id IS NULL OR NEW.skill_level_id != OLD.skill_level_id) THEN
    NEW.skill_level := (SELECT level FROM skill_levels WHERE id = NEW.skill_level_id);
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."sync_game_skill_level"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."sync_game_sport"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  -- When sport text is updated, find matching sport_id
  IF NEW.sport IS NOT NULL AND (OLD.sport IS NULL OR NEW.sport != OLD.sport) THEN
    NEW.sport_id := (SELECT id FROM sports WHERE LOWER(name) = LOWER(NEW.sport) LIMIT 1);
  END IF;

  -- When sport_id is updated, populate sport text
  IF NEW.sport_id IS NOT NULL AND (OLD.sport_id IS NULL OR NEW.sport_id != OLD.sport_id) THEN
    NEW.sport := (SELECT name FROM sports WHERE id = NEW.sport_id);
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."sync_game_sport"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."sync_notification_read_from_feed"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  IF NEW.is_read = true AND COALESCE(OLD.is_read, false) = false AND NEW.notification_id IS NOT NULL THEN
    UPDATE notifications
       SET is_read = true,
           read_at = COALESCE(read_at, now()),
           updated_at = now()
     WHERE id = NEW.notification_id
       AND COALESCE(is_read, false) = false;  -- skip if already read
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."sync_notification_read_from_feed"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."sync_profile_aliases"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  -- Only display_name exists now, no more name syncing needed
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."sync_profile_aliases"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."sync_user_phone"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
    -- Update public.users when auth.users.phone changes
    IF TG_OP = 'UPDATE' AND (OLD.phone IS DISTINCT FROM NEW.phone) THEN
        UPDATE public.users 
        SET phone = NEW.phone, updated_at = NOW()
        WHERE id = NEW.id;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."sync_user_phone"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."track_achievement_progress"("p_user_id" "uuid", "p_event_type" "text", "p_event_data" "jsonb") RETURNS TABLE("achievement_id" "uuid", "achievement_code" "text", "progress_updated" boolean, "is_completed" boolean, "points_awarded" integer)
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  v_achievement RECORD;
  v_current_progress JSONB;
  v_new_progress JSONB;
  v_is_completed BOOLEAN;
  v_progress_updated BOOLEAN;
  v_points_awarded INTEGER := 0;
BEGIN
  -- Loop through all active achievements
  FOR v_achievement IN 
    SELECT a.*, ua.current_progress, ua.is_completed as already_completed
    FROM public.achievements a
    LEFT JOIN public.user_achievements ua ON ua.achievement_id = a.id AND ua.user_id = p_user_id
    WHERE a.is_active = true
  LOOP
    v_progress_updated := false;
    v_is_completed := false;
    
    -- Skip if already completed and not repeatable
    IF v_achievement.already_completed AND NOT v_achievement.is_repeatable THEN
      CONTINUE;
    END IF;
    
    -- Check if achievement criteria matches event
    v_current_progress := COALESCE(v_achievement.current_progress, '{}');
    v_new_progress := v_current_progress;
    
    -- Update progress based on event type and criteria
    CASE p_event_type
      WHEN 'game_completed' THEN
        IF v_achievement.criteria->>'games_played' IS NOT NULL THEN
          v_new_progress := jsonb_set(
            v_new_progress, 
            '{games_played}', 
            to_jsonb(COALESCE((v_current_progress->>'games_played')::int, 0) + 1)
          );
          v_progress_updated := true;
        END IF;
        
        IF v_achievement.criteria->>'games_won' IS NOT NULL AND p_event_data->>'won' = 'true' THEN
          v_new_progress := jsonb_set(
            v_new_progress, 
            '{games_won}', 
            to_jsonb(COALESCE((v_current_progress->>'games_won')::int, 0) + 1)
          );
          v_progress_updated := true;
        END IF;
        
      WHEN 'friend_added' THEN
        IF v_achievement.criteria->>'friends_count' IS NOT NULL THEN
          v_new_progress := jsonb_set(
            v_new_progress, 
            '{friends_count}', 
            p_event_data->'total_friends'
          );
          v_progress_updated := true;
        END IF;
        
      WHEN 'skill_updated' THEN
        IF v_achievement.criteria->>'skill_level_reached' IS NOT NULL THEN
          IF (p_event_data->>'skill_level')::int >= (v_achievement.criteria->>'skill_level_reached')::int THEN
            v_new_progress := jsonb_set(v_new_progress, '{skill_level_reached}', 'true'::jsonb);
            v_progress_updated := true;
          END IF;
        END IF;
        
      -- Add more event types as needed
    END CASE;
    
    -- Check if achievement is completed
    IF v_progress_updated THEN
      v_is_completed := public.check_achievement_completion(v_achievement.criteria, v_new_progress);
      
      -- Update or insert user achievement record
      INSERT INTO public.user_achievements (
        user_id, achievement_id, current_progress, required_progress,
        progress_percentage, is_completed, completed_at
      ) VALUES (
        p_user_id, v_achievement.id, v_new_progress, v_achievement.criteria,
        public.calculate_achievement_progress_percentage(v_achievement.criteria, v_new_progress),
        v_is_completed,
        CASE WHEN v_is_completed THEN timezone('utc'::text, now()) ELSE NULL END
      )
      ON CONFLICT (user_id, achievement_id) DO UPDATE SET
        current_progress = EXCLUDED.current_progress,
        progress_percentage = EXCLUDED.progress_percentage,
        is_completed = EXCLUDED.is_completed,
        completed_at = CASE 
          WHEN NOT user_achievements.is_completed AND EXCLUDED.is_completed 
          THEN EXCLUDED.completed_at 
          ELSE user_achievements.completed_at 
        END,
        completion_count = CASE 
          WHEN EXCLUDED.is_completed AND v_achievement.is_repeatable 
          THEN user_achievements.completion_count + 1
          ELSE user_achievements.completion_count
        END,
        last_updated = timezone('utc'::text, now());
      
      -- Award points if completed
      IF v_is_completed AND (NOT v_achievement.already_completed OR v_achievement.is_repeatable) THEN
        PERFORM public.award_points(
          p_user_id,
          'achievement_unlock',
          v_achievement.points,
          'Achievement unlocked: ' || v_achievement.name,
          v_achievement.id,
          NULL,
          jsonb_build_object('achievement_code', v_achievement.code)
        );
        v_points_awarded := v_achievement.points;
        
        -- Create notification
        INSERT INTO public.achievement_notifications (
          user_id, achievement_id, notification_type, title, message
        ) VALUES (
          p_user_id, v_achievement.id, 'unlocked',
          'Achievement Unlocked!',
          'You earned: ' || v_achievement.name
        );
        
        -- Award badge
        PERFORM public.award_badge(p_user_id, v_achievement.id, v_achievement.tier);
      END IF;
    END IF;
    
    -- Return result for this achievement
    IF v_progress_updated OR v_is_completed THEN
      achievement_id := v_achievement.id;
      achievement_code := v_achievement.code;
      progress_updated := v_progress_updated;
      is_completed := v_is_completed;
      points_awarded := v_points_awarded;
      RETURN NEXT;
    END IF;
  END LOOP;
END;
$$;


ALTER FUNCTION "public"."track_achievement_progress"("p_user_id" "uuid", "p_event_type" "text", "p_event_data" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."track_friend_achievements"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  v_friend_count INTEGER;
BEGIN
  IF NEW.status = 'accepted' AND (OLD.status IS NULL OR OLD.status != 'accepted') THEN
    -- Get total friend count
    SELECT COUNT(*) INTO v_friend_count
    FROM public.friendships
    WHERE user_id = NEW.user_id AND status = 'accepted';
    
    -- Track for both users
    PERFORM public.track_achievement_progress(
      NEW.user_id,
      'friend_added',
      jsonb_build_object('total_friends', v_friend_count)
    );
    
    -- Get friend count for the other user
    SELECT COUNT(*) INTO v_friend_count
    FROM public.friendships
    WHERE user_id = NEW.friend_id AND status = 'accepted';
    
    PERFORM public.track_achievement_progress(
      NEW.friend_id,
      'friend_added',
      jsonb_build_object('total_friends', v_friend_count)
    );
  END IF;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."track_friend_achievements"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."track_game_achievements"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  -- Track game completion
  PERFORM public.track_achievement_progress(
    NEW.user_id,
    'game_completed',
    jsonb_build_object(
      'game_id', NEW.id,
      'sport_id', NEW.sport_id,
      'won', NEW.won,
      'rating', NEW.rating
    )
  );
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."track_game_achievements"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."track_profile_achievements"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  IF NEW.profile_completion_percentage >= 100 AND 
     (OLD.profile_completion_percentage IS NULL OR OLD.profile_completion_percentage < 100) THEN
    PERFORM public.track_achievement_progress(
      NEW.id,
      'profile_completed',
      jsonb_build_object('profile_completion', 100)
    );
  END IF;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."track_profile_achievements"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."trigger_cleanup_old_notifications"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  PERFORM cleanup_old_notifications();
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."trigger_cleanup_old_notifications"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_conversation_last_message"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  UPDATE public.conversations
  SET 
    last_message_id = NEW.id,
    last_message_at = NEW.created_at,
    updated_at = timezone('utc'::text, now())
  WHERE id = NEW.conversation_id;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_conversation_last_message"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_game_player_count"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    UPDATE games 
    SET current_players = (
      SELECT COUNT(*) 
      FROM game_players 
      WHERE game_id = NEW.game_id 
      AND status = 'confirmed'
    )
    WHERE id = NEW.game_id;
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE games 
    SET current_players = (
      SELECT COUNT(*) 
      FROM game_players 
      WHERE game_id = OLD.game_id 
      AND status = 'confirmed'
    )
    WHERE id = OLD.game_id;
  END IF;
  RETURN NULL;
END;
$$;


ALTER FUNCTION "public"."update_game_player_count"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_notifications_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
begin
  new.updated_at := timezone('utc', now());
  return new;
end$$;


ALTER FUNCTION "public"."update_notifications_updated_at"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_post_engagement_counts"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  IF TG_TABLE_NAME = 'reactions' THEN
    IF TG_OP = 'INSERT' THEN
      UPDATE public.posts 
      SET likes_count = likes_count + 1
      WHERE id = NEW.post_id;
    ELSIF TG_OP = 'DELETE' THEN
      UPDATE public.posts 
      SET likes_count = GREATEST(likes_count - 1, 0)
      WHERE id = OLD.post_id;
    END IF;
  ELSIF TG_TABLE_NAME = 'comments' THEN
    IF TG_OP = 'INSERT' THEN
      UPDATE public.posts 
      SET comments_count = comments_count + 1
      WHERE id = NEW.post_id;
    ELSIF TG_OP = 'DELETE' THEN
      UPDATE public.posts 
      SET comments_count = GREATEST(comments_count - 1, 0)
      WHERE id = OLD.post_id;
    END IF;
  END IF;
  
  RETURN NULL;  -- More typical for AFTER triggers
END;
$$;


ALTER FUNCTION "public"."update_post_engagement_counts"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_profile_completion"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  UPDATE public.users
  SET
    profile_completion_percentage = public.calculate_profile_completion(NEW.user_id),
    is_profile_complete           = (public.calculate_profile_completion(NEW.user_id) >= 100),
    updated_at                    = now()
  WHERE id = NEW.user_id;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_profile_completion"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_profile_statistics"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  -- This will be implemented when games feature is added
  -- Placeholder for now
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_profile_statistics"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_user_profile"("user_name" "text" DEFAULT NULL::"text", "user_age" integer DEFAULT NULL::integer, "user_gender" "text" DEFAULT NULL::"text", "user_sports" "text"[] DEFAULT NULL::"text"[], "user_intent" "text" DEFAULT NULL::"text") RETURNS "public"."users"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
declare
  uid uuid := auth.uid();
begin
  if uid is null then
    raise exception 'not authenticated';
  end if;

  update public.users u
  set full_name        = coalesce(user_name, u.full_name),
      name             = coalesce(user_name, u.name),
      age              = coalesce(user_age, u.age),
      gender           = coalesce(user_gender, u.gender),
      preferred_sports = coalesce(user_sports, u.preferred_sports),
      sports           = coalesce(user_sports, u.sports),
      intent           = coalesce(user_intent, u.intent),
      updated_at       = now()
  where u.id = uid;

  return (select * from public.users where id = uid);
end;
$$;


ALTER FUNCTION "public"."update_user_profile"("user_name" "text", "user_age" integer, "user_gender" "text", "user_sports" "text"[], "user_intent" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_user_profile"("user_display_name" "text" DEFAULT NULL::"text", "user_username" "text" DEFAULT NULL::"text", "user_bio" "text" DEFAULT NULL::"text", "user_phone" "text" DEFAULT NULL::"text", "user_date_of_birth" "text" DEFAULT NULL::"text", "user_age" integer DEFAULT NULL::integer, "user_gender" "text" DEFAULT NULL::"text", "user_nationality" "text" DEFAULT NULL::"text", "user_skill_level" "text" DEFAULT NULL::"text", "user_sports" "text"[] DEFAULT NULL::"text"[], "user_interests" "text"[] DEFAULT NULL::"text"[], "user_intent" "text" DEFAULT NULL::"text", "user_location" "text" DEFAULT NULL::"text", "user_timezone" "text" DEFAULT NULL::"text", "user_language" "text" DEFAULT NULL::"text") RETURNS json
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
    current_user_id UUID := auth.uid();
    updated_record RECORD;
BEGIN
    -- Check if user is authenticated
    IF current_user_id IS NULL THEN
        RAISE EXCEPTION 'User not authenticated' USING ERRCODE = '401';
    END IF;

    -- Check if user record exists
    IF NOT EXISTS (SELECT 1 FROM public.users WHERE id = current_user_id) THEN
        RAISE EXCEPTION 'User profile not found' USING ERRCODE = '404';
    END IF;

    -- Validate gender enum if provided
    IF user_gender IS NOT NULL AND user_gender NOT IN ('male', 'female', 'other', 'prefer_not_to_say') THEN
        RAISE EXCEPTION 'Invalid gender value. Must be: male, female, other, prefer_not_to_say' USING ERRCODE = '400';
    END IF;

    -- Validate intent enum if provided
    IF user_intent IS NOT NULL AND user_intent NOT IN ('casual', 'competitive', 'social', 'fitness', 'professional') THEN
        RAISE EXCEPTION 'Invalid intent value. Must be: casual, competitive, social, fitness, professional' USING ERRCODE = '400';
    END IF;

    -- Validate age range if provided
    IF user_age IS NOT NULL AND (user_age < 13 OR user_age > 100) THEN
        RAISE EXCEPTION 'Age must be between 13 and 100' USING ERRCODE = '400';
    END IF;

    -- Update the user profile with only non-null values
    UPDATE public.users 
    SET 
        display_name = COALESCE(user_display_name, display_name),
        bio = CASE 
            WHEN user_bio IS NOT NULL AND trim(user_bio) = '' THEN NULL
            ELSE COALESCE(user_bio, bio)
        END,
        phone = CASE 
            WHEN user_phone IS NOT NULL AND trim(user_phone) = '' THEN NULL
            ELSE COALESCE(user_phone, phone)
        END,
        age = COALESCE(user_age, age),
        gender = CASE 
            WHEN user_gender IS NOT NULL THEN user_gender::user_gender
            ELSE gender
        END,
        sports = COALESCE(user_sports, sports),
        intent = CASE 
            WHEN user_intent IS NOT NULL THEN user_intent::user_intent
            ELSE intent
        END,
        skill_level = CASE 
            WHEN user_skill_level IS NOT NULL AND trim(user_skill_level) = '' THEN NULL
            ELSE COALESCE(user_skill_level, skill_level)
        END,
        language = CASE 
            WHEN user_language IS NOT NULL AND trim(user_language) = '' THEN NULL
            ELSE COALESCE(user_language, language)
        END,
        timezone = CASE 
            WHEN user_timezone IS NOT NULL AND trim(user_timezone) = '' THEN NULL
            ELSE COALESCE(user_timezone, timezone)
        END,
        updated_at = NOW()
    WHERE id = current_user_id
    RETURNING * INTO updated_record;

    -- Return the updated profile as JSON
    RETURN row_to_json(updated_record);

EXCEPTION
    WHEN others THEN
        -- Log the error and re-raise with context
        RAISE EXCEPTION 'Profile update failed: %', SQLERRM USING ERRCODE = SQLSTATE;
END;
$$;


ALTER FUNCTION "public"."update_user_profile"("user_display_name" "text", "user_username" "text", "user_bio" "text", "user_phone" "text", "user_date_of_birth" "text", "user_age" integer, "user_gender" "text", "user_nationality" "text", "user_skill_level" "text", "user_sports" "text"[], "user_interests" "text"[], "user_intent" "text", "user_location" "text", "user_timezone" "text", "user_language" "text") OWNER TO "postgres";


COMMENT ON FUNCTION "public"."update_user_profile"("user_display_name" "text", "user_username" "text", "user_bio" "text", "user_phone" "text", "user_date_of_birth" "text", "user_age" integer, "user_gender" "text", "user_nationality" "text", "user_skill_level" "text", "user_sports" "text"[], "user_interests" "text"[], "user_intent" "text", "user_location" "text", "user_timezone" "text", "user_language" "text") IS 'Update user profile with server-side validation and authorization. Only authenticated users can update their own profiles.';



CREATE OR REPLACE FUNCTION "public"."update_venue_rating"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  UPDATE venues 
  SET rating = (
    SELECT AVG(rating)::DECIMAL(3,2) 
    FROM venue_reviews 
    WHERE venue_id = NEW.venue_id
  ),
  total_ratings = (
    SELECT COUNT(*) 
    FROM venue_reviews 
    WHERE venue_id = NEW.venue_id
  )
  WHERE id = NEW.venue_id;
  RETURN NULL;
END;
$$;


ALTER FUNCTION "public"."update_venue_rating"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."user_exists_by_email"("p_email" "text") RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
declare
  _exists boolean;
begin
  select exists(
    select 1 from auth.users u
    where lower(u.email) = lower(p_email)
  ) into _exists;

  return _exists;
end;
$$;


ALTER FUNCTION "public"."user_exists_by_email"("p_email" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."venue_slot_conflicts"("p_venue" "uuid", "p_date" "date", "p_start" time without time zone, "p_end" time without time zone) RETURNS TABLE("id" "uuid", "booking_date" "date", "start_time" time without time zone, "end_time" time without time zone)
    LANGUAGE "sql" STABLE
    AS $$
  SELECT vb.id, vb.booking_date, vb.start_time, vb.end_time
  FROM public.venue_bookings vb
  WHERE vb.venue_id = p_venue
    AND vb.booking_date = p_date
    AND vb.slot_range && tsrange((p_date + p_start), (p_date + p_end), '[)')
  ORDER BY vb.start_time;
$$;


ALTER FUNCTION "public"."venue_slot_conflicts"("p_venue" "uuid", "p_date" "date", "p_start" time without time zone, "p_end" time without time zone) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."venue_slot_free"("p_venue" "uuid", "p_date" "date", "p_start" time without time zone, "p_end" time without time zone) RETURNS boolean
    LANGUAGE "sql" STABLE
    AS $$
  SELECT NOT EXISTS (
    SELECT 1
    FROM public.venue_bookings vb
    WHERE vb.venue_id = p_venue
      AND vb.booking_date = p_date
      AND vb.slot_range && tsrange((p_date + p_start), (p_date + p_end), '[)')
  );
$$;


ALTER FUNCTION "public"."venue_slot_free"("p_venue" "uuid", "p_date" "date", "p_start" time without time zone, "p_end" time without time zone) OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."achievement_notifications" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "achievement_id" "uuid" NOT NULL,
    "notification_type" "text",
    "title" "text" NOT NULL,
    "message" "text",
    "is_read" boolean DEFAULT false,
    "read_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "achievement_notifications_notification_type_check" CHECK (("notification_type" = ANY (ARRAY['unlocked'::"text", 'progress'::"text", 'tier_up'::"text"])))
);


ALTER TABLE "public"."achievement_notifications" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."achievements" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "code" "text" NOT NULL,
    "name" "text" NOT NULL,
    "description" "text" NOT NULL,
    "icon_url" "text",
    "category" "public"."achievement_category" NOT NULL,
    "type" "public"."achievement_type" NOT NULL,
    "tier" "public"."badge_tier" DEFAULT 'bronze'::"public"."badge_tier",
    "points" integer DEFAULT 100 NOT NULL,
    "criteria" "jsonb" NOT NULL,
    "prerequisite_achievement_ids" "uuid"[] DEFAULT ARRAY[]::"uuid"[],
    "is_active" boolean DEFAULT true,
    "is_hidden" boolean DEFAULT false,
    "is_repeatable" boolean DEFAULT false,
    "max_repeats" integer DEFAULT 1,
    "available_from" timestamp with time zone,
    "available_until" timestamp with time zone,
    "display_order" integer DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."achievements" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."activity_feed" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "kind" "text" NOT NULL,
    "title" "text" NOT NULL,
    "message" "text" NOT NULL,
    "action_route" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "notification_id" "uuid",
    "is_read" boolean DEFAULT false NOT NULL,
    "read_at" timestamp with time zone,
    CONSTRAINT "activity_feed_kind_check" CHECK (("kind" = ANY (ARRAY['system_alert'::"text", 'announcement'::"text"])))
);


ALTER TABLE "public"."activity_feed" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."activity_log" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "activity_type" "text" NOT NULL,
    "activity_subtype" "text",
    "title" "text" NOT NULL,
    "description" "text",
    "venue" "text",
    "amount" numeric(10,2),
    "currency" "text",
    "points" integer,
    "status" "text",
    "target_id" "text",
    "target_type" "text",
    "target_user_id" "uuid",
    "target_user_name" "text",
    "target_user_avatar" "text",
    "count" integer,
    "metadata" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "action_route" "text",
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."activity_log" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."auth_sessions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "device_id" "text" NOT NULL,
    "device_name" "text",
    "device_type" "text",
    "ip_address" "inet",
    "user_agent" "text",
    "is_active" boolean DEFAULT true,
    "last_activity" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()),
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "expires_at" timestamp with time zone,
    CONSTRAINT "auth_sessions_device_type_check" CHECK (("device_type" = ANY (ARRAY['ios'::"text", 'android'::"text", 'web'::"text", 'desktop'::"text"])))
);


ALTER TABLE "public"."auth_sessions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."badge_showcase_settings" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "max_showcase_badges" integer DEFAULT 5,
    "showcase_style" "text" DEFAULT 'grid'::"text",
    "show_rarity" boolean DEFAULT true,
    "show_earn_date" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "badge_showcase_settings_showcase_style_check" CHECK (("showcase_style" = ANY (ARRAY['grid'::"text", 'list'::"text", 'carousel'::"text"])))
);


ALTER TABLE "public"."badge_showcase_settings" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."badges" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "achievement_id" "uuid" NOT NULL,
    "tier" "public"."badge_tier" NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "icon_url" "text" NOT NULL,
    "design_metadata" "jsonb" DEFAULT '{}'::"jsonb",
    "unlock_message" "text",
    "rarity_score" integer DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."badges" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."challenge_participants" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "challenge_id" "uuid" NOT NULL,
    "user_id" "uuid",
    "team_id" "uuid",
    "current_value" numeric(10,2) DEFAULT 0,
    "progress_percentage" numeric(5,2) DEFAULT 0,
    "is_completed" boolean DEFAULT false,
    "completed_at" timestamp with time zone,
    "rank" integer,
    "previous_rank" integer,
    "last_update" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()),
    "update_count" integer DEFAULT 0,
    "is_verified" boolean DEFAULT false,
    "verified_by" "uuid",
    "verified_at" timestamp with time zone,
    "joined_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "left_at" timestamp with time zone
);


ALTER TABLE "public"."challenge_participants" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."challenge_progress_updates" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "participant_id" "uuid" NOT NULL,
    "value_added" numeric(10,2) NOT NULL,
    "new_total" numeric(10,2) NOT NULL,
    "evidence_type" "text",
    "evidence_id" "uuid",
    "evidence_url" "text",
    "is_verified" boolean DEFAULT false,
    "verified_by" "uuid",
    "notes" "text",
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "challenge_progress_updates_evidence_type_check" CHECK (("evidence_type" = ANY (ARRAY['game_result'::"text", 'manual_entry'::"text", 'device_sync'::"text", 'photo'::"text", 'witness'::"text"])))
);


ALTER TABLE "public"."challenge_progress_updates" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."comments" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "post_id" "uuid" NOT NULL,
    "author_id" "uuid" NOT NULL,
    "parent_comment_id" "uuid",
    "content" "text" NOT NULL,
    "likes_count" integer DEFAULT 0,
    "is_deleted" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."comments" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."community_analytics" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "group_id" "uuid",
    "metric_date" "date" NOT NULL,
    "total_members" integer DEFAULT 0,
    "new_members" integer DEFAULT 0,
    "active_members" integer DEFAULT 0,
    "churned_members" integer DEFAULT 0,
    "events_created" integer DEFAULT 0,
    "events_completed" integer DEFAULT 0,
    "total_participants" integer DEFAULT 0,
    "average_event_size" numeric(5,2) DEFAULT 0,
    "posts_created" integer DEFAULT 0,
    "comments_created" integer DEFAULT 0,
    "reactions_count" integer DEFAULT 0,
    "average_engagement_rate" numeric(5,2) DEFAULT 0,
    "challenges_created" integer DEFAULT 0,
    "challenge_participants" integer DEFAULT 0,
    "challenge_completion_rate" numeric(5,2) DEFAULT 0,
    "tournaments_hosted" integer DEFAULT 0,
    "tournament_participants" integer DEFAULT 0,
    "matches_played" integer DEFAULT 0,
    "growth_rate" numeric(5,2) DEFAULT 0,
    "retention_rate" numeric(5,2) DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."community_analytics" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."community_challenges" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "group_id" "uuid",
    "created_by" "uuid",
    "title" "text" NOT NULL,
    "description" "text",
    "type" "public"."challenge_type" NOT NULL,
    "status" "public"."challenge_status" DEFAULT 'draft'::"public"."challenge_status",
    "start_date" timestamp with time zone NOT NULL,
    "end_date" timestamp with time zone NOT NULL,
    "metric_type" "text" NOT NULL,
    "target_value" numeric(10,2) NOT NULL,
    "unit" "text",
    "min_participants" integer DEFAULT 1,
    "max_participants" integer,
    "current_participants" integer DEFAULT 0,
    "sport_id" "uuid",
    "skill_level_min" integer,
    "skill_level_max" integer,
    "region_id" "uuid",
    "has_rewards" boolean DEFAULT false,
    "reward_points" integer DEFAULT 0,
    "reward_badges" "text"[],
    "custom_rewards" "jsonb" DEFAULT '[]'::"jsonb",
    "rules" "text",
    "verification_method" "text",
    "allow_team_participation" boolean DEFAULT false,
    "team_size_min" integer,
    "team_size_max" integer,
    "banner_image_url" "text",
    "icon_url" "text",
    "total_progress" numeric(10,2) DEFAULT 0,
    "completion_rate" numeric(5,2) DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "community_challenges_metric_type_check" CHECK (("metric_type" = ANY (ARRAY['games_played'::"text", 'games_won'::"text", 'hours_played'::"text", 'distance_covered'::"text", 'calories_burned'::"text", 'custom'::"text"])))
);


ALTER TABLE "public"."community_challenges" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."community_events" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "group_id" "uuid",
    "organizer_id" "uuid" NOT NULL,
    "sport_id" "uuid",
    "venue_id" "uuid",
    "title" "text" NOT NULL,
    "description" "text",
    "type" "public"."event_type" NOT NULL,
    "status" "public"."event_status" DEFAULT 'draft'::"public"."event_status",
    "start_date" timestamp with time zone NOT NULL,
    "end_date" timestamp with time zone NOT NULL,
    "registration_deadline" timestamp with time zone,
    "min_participants" integer DEFAULT 2,
    "max_participants" integer,
    "current_participants" integer DEFAULT 0,
    "skill_level_min" integer,
    "skill_level_max" integer,
    "age_min" integer,
    "age_max" integer,
    "gender_restriction" "text",
    "is_free" boolean DEFAULT true,
    "entry_fee" numeric(10,2) DEFAULT 0,
    "currency" "public"."currency_code",
    "has_prizes" boolean DEFAULT false,
    "prizes" "jsonb" DEFAULT '[]'::"jsonb",
    "rules" "text",
    "equipment_required" "text"[],
    "cover_image_url" "text",
    "gallery_urls" "text"[],
    "is_public" boolean DEFAULT true,
    "requires_approval" boolean DEFAULT false,
    "allow_waitlist" boolean DEFAULT true,
    "view_count" integer DEFAULT 0,
    "share_count" integer DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "community_events_gender_restriction_check" CHECK (("gender_restriction" = ANY (ARRAY['all'::"text", 'male'::"text", 'female'::"text", 'mixed'::"text"])))
);


ALTER TABLE "public"."community_events" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."community_groups" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "type" "public"."group_type" DEFAULT 'public'::"public"."group_type",
    "status" "public"."group_status" DEFAULT 'active'::"public"."group_status",
    "sport_id" "uuid",
    "region_id" "uuid",
    "created_by" "uuid",
    "max_members" integer DEFAULT 100,
    "min_age" integer,
    "max_age" integer,
    "skill_level_min" integer,
    "skill_level_max" integer,
    "is_verified" boolean DEFAULT false,
    "requires_approval" boolean DEFAULT false,
    "is_visible" boolean DEFAULT true,
    "allow_guest_view" boolean DEFAULT true,
    "avatar_url" "text",
    "cover_image_url" "text",
    "member_count" integer DEFAULT 0,
    "event_count" integer DEFAULT 0,
    "activity_score" integer DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."community_groups" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."community_growth_metrics" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "metric_week" "date" NOT NULL,
    "total_groups" integer DEFAULT 0,
    "active_groups" integer DEFAULT 0,
    "total_members" integer DEFAULT 0,
    "weekly_active_members" integer DEFAULT 0,
    "events_created" integer DEFAULT 0,
    "event_participants" integer DEFAULT 0,
    "event_completion_rate" numeric(5,2) DEFAULT 0,
    "metrics_by_region" "jsonb" DEFAULT '{}'::"jsonb",
    "metrics_by_sport" "jsonb" DEFAULT '{}'::"jsonb",
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."community_growth_metrics" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."community_leaderboards" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "category" "public"."leaderboard_category" NOT NULL,
    "period" "public"."leaderboard_period" NOT NULL,
    "group_id" "uuid",
    "sport_id" "uuid",
    "region_id" "uuid",
    "challenge_id" "uuid",
    "tournament_id" "uuid",
    "skill_level_min" integer,
    "skill_level_max" integer,
    "age_min" integer,
    "age_max" integer,
    "period_start" "date" NOT NULL,
    "period_end" "date" NOT NULL,
    "min_activities" integer DEFAULT 1,
    "scoring_method" "text" DEFAULT 'points'::"text",
    "is_active" boolean DEFAULT true,
    "last_calculated" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()),
    "next_calculation" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "community_leaderboards_scoring_method_check" CHECK (("scoring_method" = ANY (ARRAY['points'::"text", 'wins'::"text", 'participation'::"text", 'composite'::"text"])))
);


ALTER TABLE "public"."community_leaderboards" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."conversation_participants" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "conversation_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "role" "text" DEFAULT 'member'::"text",
    "last_read_message_id" "uuid",
    "last_read_at" timestamp with time zone,
    "is_muted" boolean DEFAULT false,
    "muted_until" timestamp with time zone,
    "joined_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "left_at" timestamp with time zone,
    CONSTRAINT "conversation_participants_role_check" CHECK (("role" = ANY (ARRAY['admin'::"text", 'member'::"text"])))
);


ALTER TABLE "public"."conversation_participants" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."conversations" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "type" "text" DEFAULT 'direct'::"text",
    "name" "text",
    "avatar_url" "text",
    "created_by" "uuid",
    "last_message_id" "uuid",
    "last_message_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "conversations_type_check" CHECK (("type" = ANY (ARRAY['direct'::"text", 'group'::"text"])))
);


ALTER TABLE "public"."conversations" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."email_outbox" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "to_email" "text" NOT NULL,
    "subject" "text" NOT NULL,
    "body" "text" NOT NULL,
    "status" "text" DEFAULT 'pending'::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "sent_at" timestamp with time zone,
    "fail_reason" "text",
    CONSTRAINT "email_outbox_status_check" CHECK (("status" = ANY (ARRAY['pending'::"text", 'sent'::"text", 'failed'::"text"])))
);


ALTER TABLE "public"."email_outbox" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."event_registrations" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "event_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "status" "text" DEFAULT 'registered'::"text",
    "team_name" "text",
    "position" "text",
    "notes" "text",
    "payment_status" "text" DEFAULT 'pending'::"text",
    "payment_amount" numeric(10,2),
    "payment_date" timestamp with time zone,
    "checked_in" boolean DEFAULT false,
    "checked_in_at" timestamp with time zone,
    "registered_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "cancelled_at" timestamp with time zone,
    CONSTRAINT "event_registrations_payment_status_check" CHECK (("payment_status" = ANY (ARRAY['pending'::"text", 'paid'::"text", 'refunded'::"text", 'waived'::"text"]))),
    CONSTRAINT "event_registrations_status_check" CHECK (("status" = ANY (ARRAY['registered'::"text", 'waitlisted'::"text", 'cancelled'::"text", 'attended'::"text", 'no_show'::"text"])))
);


ALTER TABLE "public"."event_registrations" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."game_check_ins" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "game_id" "uuid" NOT NULL,
    "player_id" "uuid" NOT NULL,
    "check_in_time" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "check_in_method" "text",
    "location_latitude" double precision,
    "location_longitude" double precision,
    "device_id" "text",
    CONSTRAINT "game_check_ins_check_in_method_check" CHECK (("check_in_method" = ANY (ARRAY['qr_code'::"text", 'manual'::"text", 'automatic'::"text"])))
);


ALTER TABLE "public"."game_check_ins" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."game_invitations" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "game_id" "uuid" NOT NULL,
    "inviter_id" "uuid" NOT NULL,
    "invitee_email" "text",
    "invitee_phone" "text",
    "invitee_id" "uuid",
    "status" "text" DEFAULT 'pending'::"text",
    "message" "text",
    "invited_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "responded_at" timestamp with time zone,
    "expires_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", ("now"() + '7 days'::interval)),
    CONSTRAINT "game_invitations_status_check" CHECK (("status" = ANY (ARRAY['pending'::"text", 'accepted'::"text", 'declined'::"text", 'expired'::"text"])))
);


ALTER TABLE "public"."game_invitations" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."game_notifications" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "game_id" "uuid" NOT NULL,
    "recipient_id" "uuid" NOT NULL,
    "type" "text" NOT NULL,
    "title" "text" NOT NULL,
    "message" "text" NOT NULL,
    "is_read" boolean DEFAULT false,
    "sent_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "read_at" timestamp with time zone,
    "metadata" "jsonb",
    CONSTRAINT "game_notifications_type_check" CHECK (("type" = ANY (ARRAY['game_created'::"text", 'game_cancelled'::"text", 'game_updated'::"text", 'player_joined'::"text", 'player_left'::"text", 'game_reminder'::"text", 'check_in_reminder'::"text", 'game_started'::"text", 'game_completed'::"text", 'venue_changed'::"text", 'time_changed'::"text", 'rating_request'::"text"])))
);


ALTER TABLE "public"."game_notifications" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."game_players" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "game_id" "uuid" NOT NULL,
    "player_id" "uuid" NOT NULL,
    "status" "text" DEFAULT 'confirmed'::"text",
    "team" "text",
    "position" "text",
    "joined_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "checked_in_at" timestamp with time zone,
    "check_in_code" "text",
    "player_rating" integer,
    "rated_at" timestamp with time zone,
    CONSTRAINT "game_players_player_rating_check" CHECK ((("player_rating" >= 1) AND ("player_rating" <= 5))),
    CONSTRAINT "game_players_status_check" CHECK (("status" = ANY (ARRAY['confirmed'::"text", 'waitlisted'::"text", 'cancelled'::"text", 'no_show'::"text"]))),
    CONSTRAINT "game_players_team_check" CHECK (("team" = ANY (ARRAY['team_a'::"text", 'team_b'::"text", 'unassigned'::"text"])))
);


ALTER TABLE "public"."game_players" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."game_sessions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "game_id" "uuid" NOT NULL,
    "status" "text" DEFAULT 'waiting'::"text",
    "actual_start_time" timestamp with time zone,
    "actual_end_time" timestamp with time zone,
    "team_a_score" integer DEFAULT 0,
    "team_b_score" integer DEFAULT 0,
    "weather_condition" "text",
    "temperature" numeric(5,2),
    "notes" "text",
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "game_sessions_status_check" CHECK (("status" = ANY (ARRAY['waiting'::"text", 'in_progress'::"text", 'completed'::"text", 'abandoned'::"text"])))
);


ALTER TABLE "public"."game_sessions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."games" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "title" "text" NOT NULL,
    "description" "text",
    "sport_id" "uuid" NOT NULL,
    "venue_id" "uuid",
    "organizer_id" "uuid" NOT NULL,
    "scheduled_date" "date" NOT NULL,
    "start_time" time without time zone NOT NULL,
    "end_time" time without time zone NOT NULL,
    "min_players" integer NOT NULL,
    "max_players" integer NOT NULL,
    "current_players" integer DEFAULT 0,
    "skill_level_id" "uuid",
    "price_per_player" numeric(10,2) DEFAULT 0.00,
    "currency" "text" DEFAULT 'USD'::"text",
    "status" "text" DEFAULT 'upcoming'::"text",
    "is_public" boolean DEFAULT true,
    "allows_waitlist" boolean DEFAULT true,
    "check_in_enabled" boolean DEFAULT true,
    "cancellation_deadline" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "sport" "text",
    "skill_level" "text",
    CONSTRAINT "games_status_check" CHECK (("status" = ANY (ARRAY['draft'::"text", 'upcoming'::"text", 'in_progress'::"text", 'completed'::"text", 'cancelled'::"text"])))
);


ALTER TABLE "public"."games" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."games_public" AS
 SELECT "id",
    "title",
    "description",
    "sport_id",
    "venue_id",
    "organizer_id",
    "scheduled_date",
    "start_time",
    "end_time",
    "min_players",
    "max_players",
    "current_players",
    "skill_level_id",
    "price_per_player",
    "currency",
    "status",
    "allows_waitlist",
    "check_in_enabled",
    "cancellation_deadline",
    "created_at",
    "sport",
    "skill_level"
   FROM "public"."games"
  WHERE ("is_public" = true);


ALTER VIEW "public"."games_public" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."group_members" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "group_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "role" "text" DEFAULT 'member'::"text",
    "status" "text" DEFAULT 'active'::"text",
    "can_create_events" boolean DEFAULT false,
    "can_invite_members" boolean DEFAULT false,
    "can_moderate_content" boolean DEFAULT false,
    "contribution_score" integer DEFAULT 0,
    "last_active" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()),
    "joined_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "left_at" timestamp with time zone,
    CONSTRAINT "group_members_role_check" CHECK (("role" = ANY (ARRAY['owner'::"text", 'admin'::"text", 'moderator'::"text", 'member'::"text"]))),
    CONSTRAINT "group_members_status_check" CHECK (("status" = ANY (ARRAY['active'::"text", 'inactive'::"text", 'banned'::"text", 'left'::"text"])))
);


ALTER TABLE "public"."group_members" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."introspect_columns" AS
 SELECT "table_name",
    "column_name",
    "data_type",
    "is_nullable",
    "ordinal_position"
   FROM "information_schema"."columns"
  WHERE (("table_schema")::"name" = 'public'::"name")
  ORDER BY "table_name", "ordinal_position";


ALTER VIEW "public"."introspect_columns" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."introspect_foreign_keys" AS
 SELECT "tc"."table_name",
    "kcu"."column_name",
    "ccu"."table_name" AS "references_table",
    "ccu"."column_name" AS "references_column",
    "tc"."constraint_name"
   FROM (("information_schema"."table_constraints" "tc"
     JOIN "information_schema"."key_column_usage" "kcu" ON (((("tc"."constraint_name")::"name" = ("kcu"."constraint_name")::"name") AND (("tc"."table_schema")::"name" = ("kcu"."table_schema")::"name"))))
     JOIN "information_schema"."constraint_column_usage" "ccu" ON (((("ccu"."constraint_name")::"name" = ("tc"."constraint_name")::"name") AND (("ccu"."table_schema")::"name" = ("tc"."table_schema")::"name"))))
  WHERE ((("tc"."table_schema")::"name" = 'public'::"name") AND (("tc"."constraint_type")::"text" = 'FOREIGN KEY'::"text"))
  ORDER BY "tc"."table_name", "kcu"."ordinal_position";


ALTER VIEW "public"."introspect_foreign_keys" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."introspect_tables" AS
 SELECT (("c"."oid")::"regclass")::"text" AS "table_name",
    COALESCE("s"."n_live_tup", (0)::bigint) AS "approx_rows"
   FROM (("pg_class" "c"
     JOIN "pg_namespace" "n" ON (("n"."oid" = "c"."relnamespace")))
     LEFT JOIN "pg_stat_user_tables" "s" ON (("s"."relid" = "c"."oid")))
  WHERE (("n"."nspname" = 'public'::"name") AND ("c"."relkind" = 'r'::"char"))
  ORDER BY (("c"."oid")::"regclass")::"text";


ALTER VIEW "public"."introspect_tables" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."leaderboard_entries" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "leaderboard_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "rank" integer NOT NULL,
    "previous_rank" integer,
    "rank_change" integer DEFAULT 0,
    "score" numeric(10,2) NOT NULL,
    "activities_count" integer DEFAULT 0,
    "wins_count" integer DEFAULT 0,
    "metrics" "jsonb" DEFAULT '{}'::"jsonb",
    "best_score" numeric(10,2),
    "best_score_date" "date",
    "calculated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."leaderboard_entries" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."leaderboard_entries_public" AS
 SELECT "id",
    "leaderboard_id",
    "user_id",
    "rank",
    "previous_rank",
    "rank_change",
    "score",
    "activities_count",
    "wins_count",
    "metrics",
    "best_score",
    "best_score_date",
    "calculated_at"
   FROM "public"."leaderboard_entries";


ALTER VIEW "public"."leaderboard_entries_public" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."leaderboard_history" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "leaderboard_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "rank" integer NOT NULL,
    "score" numeric(10,2) NOT NULL,
    "snapshot_date" "date" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."leaderboard_history" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."leaderboards" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "type" "public"."leaderboard_type" NOT NULL,
    "sport_id" "uuid",
    "time_period" "text",
    "entries" "jsonb" DEFAULT '[]'::"jsonb",
    "last_calculated" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()),
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."leaderboards" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."leaderboards_public" AS
 SELECT "id",
    "type",
    "sport_id",
    "time_period",
    "last_calculated",
    "created_at"
   FROM "public"."leaderboards";


ALTER VIEW "public"."leaderboards_public" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."member_activity_log" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "group_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "activity_type" "text" NOT NULL,
    "activity_id" "uuid",
    "points_earned" integer DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "member_activity_log_activity_type_check" CHECK (("activity_type" = ANY (ARRAY['joined_group'::"text", 'left_group'::"text", 'created_event'::"text", 'joined_event'::"text", 'completed_event'::"text", 'created_post'::"text", 'commented'::"text", 'reacted'::"text", 'joined_challenge'::"text", 'completed_challenge'::"text", 'tournament_participation'::"text"])))
);


ALTER TABLE "public"."member_activity_log" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."messages" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "conversation_id" "uuid" NOT NULL,
    "sender_id" "uuid",
    "content" "text",
    "media_urls" "text"[],
    "reply_to_message_id" "uuid",
    "is_edited" boolean DEFAULT false,
    "edited_at" timestamp with time zone,
    "is_deleted" boolean DEFAULT false,
    "deleted_at" timestamp with time zone,
    "delivered_to" "uuid"[] DEFAULT ARRAY[]::"uuid"[],
    "read_by" "uuid"[] DEFAULT ARRAY[]::"uuid"[],
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "topic" "text"
);


ALTER TABLE "public"."messages" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."notifications" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "title" "text" NOT NULL,
    "message" "text" NOT NULL,
    "type" "text" NOT NULL,
    "priority" "text" DEFAULT 'normal'::"text" NOT NULL,
    "is_read" boolean DEFAULT false,
    "data" "jsonb",
    "image_url" "text",
    "action_text" "text",
    "action_route" "text",
    "read_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone,
    CONSTRAINT "notifications_priority_check" CHECK (("priority" = ANY (ARRAY['low'::"text", 'normal'::"text", 'high'::"text", 'urgent'::"text"]))),
    CONSTRAINT "notifications_type_check" CHECK (("type" = ANY (ARRAY['game_invite'::"text", 'game_update'::"text", 'booking_confirmation'::"text", 'booking_reminder'::"text", 'friend_request'::"text", 'achievement'::"text", 'loyalty_points'::"text", 'general_update'::"text", 'system_alert'::"text"])))
);


ALTER TABLE "public"."notifications" OWNER TO "postgres";


COMMENT ON TABLE "public"."notifications" IS 'User notifications for games, bookings, achievements, and system updates';



COMMENT ON COLUMN "public"."notifications"."type" IS 'Type: game_invite, game_update, booking_confirmation, etc.';



COMMENT ON COLUMN "public"."notifications"."priority" IS 'Priority: low, normal, high, urgent';



COMMENT ON COLUMN "public"."notifications"."data" IS 'Additional JSON (e.g., game_id, booking_id)';



COMMENT ON COLUMN "public"."notifications"."action_route" IS 'App route to navigate on tap';



CREATE OR REPLACE VIEW "public"."notifications_unified_public" AS
 SELECT "id",
    "user_id",
    "actor_id",
    "category",
    "kind",
    "data",
    "is_read",
    "created_at"
   FROM "public"."notifications_unified" "n"
  WHERE (("user_id" IS NULL) OR ("user_id" = "auth"."uid"()));


ALTER VIEW "public"."notifications_unified_public" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."password_reset_attempts" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "email" "text" NOT NULL,
    "ip_address" "inet",
    "status" "text",
    "token_hash" "text",
    "attempted_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()),
    "completed_at" timestamp with time zone,
    "expires_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", ("now"() + '01:00:00'::interval)),
    CONSTRAINT "password_reset_attempts_status_check" CHECK (("status" = ANY (ARRAY['pending'::"text", 'completed'::"text", 'expired'::"text"])))
);


ALTER TABLE "public"."password_reset_attempts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."player_ratings" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "game_id" "uuid" NOT NULL,
    "rater_id" "uuid",
    "rated_player_id" "uuid",
    "skill_rating" integer,
    "sportsmanship_rating" integer,
    "punctuality_rating" integer,
    "overall_rating" integer,
    "comment" "text",
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "player_ratings_check" CHECK (("rater_id" <> "rated_player_id")),
    CONSTRAINT "player_ratings_overall_rating_check" CHECK ((("overall_rating" >= 1) AND ("overall_rating" <= 5))),
    CONSTRAINT "player_ratings_punctuality_rating_check" CHECK ((("punctuality_rating" >= 1) AND ("punctuality_rating" <= 5))),
    CONSTRAINT "player_ratings_skill_rating_check" CHECK ((("skill_rating" >= 1) AND ("skill_rating" <= 5))),
    CONSTRAINT "player_ratings_sportsmanship_rating_check" CHECK ((("sportsmanship_rating" >= 1) AND ("sportsmanship_rating" <= 5)))
);


ALTER TABLE "public"."player_ratings" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."points_multipliers" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "code" "text" NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "multiplier" numeric(3,2) NOT NULL,
    "conditions" "jsonb" NOT NULL,
    "is_active" boolean DEFAULT true,
    "valid_from" timestamp with time zone,
    "valid_until" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "points_multipliers_multiplier_check" CHECK (("multiplier" >= 1.0))
);


ALTER TABLE "public"."points_multipliers" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."post_comments" AS
 SELECT "id",
    "post_id",
    "author_id",
    "content",
    "parent_comment_id",
    "created_at",
    "updated_at"
   FROM "public"."comments" "c";


ALTER VIEW "public"."post_comments" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."post_comments__old" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "post_id" "uuid" NOT NULL,
    "author_id" "uuid" NOT NULL,
    "content" "text" NOT NULL,
    "parent_comment_id" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."post_comments__old" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."posts" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "author_id" "uuid" NOT NULL,
    "type" "public"."post_type" DEFAULT 'text'::"public"."post_type" NOT NULL,
    "content" "text",
    "media_urls" "text"[],
    "game_id" "uuid",
    "sport_id" "uuid",
    "achievement_type" "text",
    "visibility" "text" DEFAULT 'friends'::"text",
    "likes_count" integer DEFAULT 0,
    "comments_count" integer DEFAULT 0,
    "shares_count" integer DEFAULT 0,
    "is_deleted" boolean DEFAULT false,
    "deleted_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "location_name" "text",
    "tags" "text",
    CONSTRAINT "posts_visibility_check" CHECK (("visibility" = ANY (ARRAY['public'::"text", 'friends'::"text", 'private'::"text"])))
);


ALTER TABLE "public"."posts" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."post_comments_public" AS
 SELECT "c"."id",
    "c"."post_id",
    "c"."author_id",
    "c"."content",
    "c"."parent_comment_id",
    "c"."created_at",
    "c"."updated_at"
   FROM ("public"."comments" "c"
     JOIN "public"."posts" "p" ON (("p"."id" = "c"."post_id")))
  WHERE ((COALESCE("p"."is_deleted", false) = false) AND (("p"."visibility" = 'public'::"text") OR ("p"."visibility" = 'friends'::"text")));


ALTER VIEW "public"."post_comments_public" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."post_likes" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "post_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."post_likes" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."posts_friends_public" AS
 SELECT "id",
    "author_id",
    "type",
    "content",
    "media_urls",
    "game_id",
    "sport_id",
    "achievement_type",
    "visibility",
    "likes_count",
    "comments_count",
    "shares_count",
    "created_at",
    "updated_at",
    "location_name",
    "tags"
   FROM "public"."posts" "p"
  WHERE ((COALESCE("is_deleted", false) = false) AND ("visibility" = 'friends'::"text"));


ALTER VIEW "public"."posts_friends_public" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."posts_public" AS
 SELECT "id",
    "author_id",
    "type",
    "content",
    "media_urls",
    "game_id",
    "sport_id",
    "achievement_type",
    "visibility",
    "likes_count",
    "comments_count",
    "shares_count",
    "created_at",
    "updated_at",
    "location_name",
    "tags"
   FROM "public"."posts"
  WHERE ((COALESCE("is_deleted", false) = false) AND ("visibility" = 'public'::"text"));


ALTER VIEW "public"."posts_public" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profile_audit" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "table_name" "text" NOT NULL,
    "action" "text" NOT NULL,
    "changed_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "changed_by" "uuid",
    "old_data" "jsonb",
    "new_data" "jsonb"
);


ALTER TABLE "public"."profile_audit" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profile_audit_log" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "table_name" "text" NOT NULL,
    "action" "text" NOT NULL,
    "changed_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "changed_by" "uuid",
    "changed_to" "jsonb",
    CONSTRAINT "profile_audit_log_action_check" CHECK (("action" = ANY (ARRAY['INSERT'::"text", 'UPDATE'::"text", 'DELETE'::"text"])))
);


ALTER TABLE "public"."profile_audit_log" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profile_feature_flags" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "feature_name" "text" NOT NULL,
    "is_enabled" boolean DEFAULT false,
    "rollout_percentage" integer DEFAULT 0,
    "user_whitelist" "uuid"[] DEFAULT ARRAY[]::"uuid"[],
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "profile_feature_flags_rollout_percentage_check" CHECK ((("rollout_percentage" >= 0) AND ("rollout_percentage" <= 100)))
);


ALTER TABLE "public"."profile_feature_flags" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profile_metrics" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "metric_date" "date" NOT NULL,
    "total_profiles" integer DEFAULT 0,
    "completed_profiles" integer DEFAULT 0,
    "active_users_daily" integer DEFAULT 0,
    "active_users_weekly" integer DEFAULT 0,
    "new_profiles_count" integer DEFAULT 0,
    "avg_completion_percentage" numeric(5,2) DEFAULT 0,
    "avg_sports_per_user" numeric(5,2) DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."profile_metrics" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profile_statistics" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "total_games_played" integer DEFAULT 0,
    "total_games_organized" integer DEFAULT 0,
    "total_wins" integer DEFAULT 0,
    "total_losses" integer DEFAULT 0,
    "total_draws" integer DEFAULT 0,
    "favorite_sport_id" "uuid",
    "total_hours_played" numeric DEFAULT 0,
    "average_game_duration" integer DEFAULT 0,
    "longest_streak" integer DEFAULT 0,
    "current_streak" integer DEFAULT 0,
    "total_teammates" integer DEFAULT 0,
    "total_venues_visited" integer DEFAULT 0,
    "sportsmanship_rating" numeric(3,2) DEFAULT 5.0,
    "reliability_rating" numeric(3,2) DEFAULT 5.0,
    "achievements_unlocked" integer DEFAULT 0,
    "badges_earned" "text"[] DEFAULT ARRAY[]::"text"[],
    "last_game_date" "date",
    "last_active" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()),
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."profile_statistics" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profile_views" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "profile_id" "uuid" NOT NULL,
    "viewer_id" "uuid",
    "viewed_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "source" "text",
    "duration_seconds" integer,
    CONSTRAINT "profile_views_source_check" CHECK (("source" = ANY (ARRAY['search'::"text", 'game'::"text", 'friend'::"text", 'direct'::"text"])))
);


ALTER TABLE "public"."profile_views" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profiles_backup" (
    "id" "uuid",
    "email" "text",
    "username" "text",
    "full_name" "text",
    "avatar_url" "text",
    "phone_number" "text",
    "date_of_birth" "date",
    "bio" "text",
    "is_profile_complete" boolean,
    "is_email_verified" boolean,
    "is_phone_verified" boolean,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "profile_completion_percentage" integer,
    "search_vector" "tsvector",
    "display_name" "text"
);


ALTER TABLE "public"."profiles_backup" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."profiles_public" AS
 SELECT "id",
    "display_name",
    "avatar_url",
    "created_at"
   FROM "public"."users";


ALTER VIEW "public"."profiles_public" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."reactions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "post_id" "uuid",
    "comment_id" "uuid",
    "reaction_type" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "reactions_reaction_type_check" CHECK (("reaction_type" = ANY (ARRAY['like'::"text", 'love'::"text", 'celebrate'::"text", 'support'::"text", 'funny'::"text", 'wow'::"text"]))),
    CONSTRAINT "single_target" CHECK (((("post_id" IS NOT NULL) AND ("comment_id" IS NULL)) OR (("post_id" IS NULL) AND ("comment_id" IS NOT NULL))))
);


ALTER TABLE "public"."reactions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."reactions_unified" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "target_type" "text" NOT NULL,
    "target_id" "uuid" NOT NULL,
    "reaction" "text" DEFAULT 'like'::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "reactions_unified_reaction_check" CHECK (("reaction" = ANY (ARRAY['like'::"text", 'love'::"text", 'wow'::"text", 'laugh'::"text", 'sad'::"text", 'angry'::"text"]))),
    CONSTRAINT "reactions_unified_target_type_check" CHECK (("target_type" = ANY (ARRAY['post'::"text", 'comment'::"text", 'message'::"text", 'game'::"text", 'profile'::"text"])))
);


ALTER TABLE "public"."reactions_unified" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."regions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "code" "text",
    "country_code" "text",
    "parent_id" "uuid",
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."regions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."rewards_config" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "config_key" "text" NOT NULL,
    "config_value" "jsonb" NOT NULL,
    "description" "text",
    "is_active" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."rewards_config" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."scheduled_rewards" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "reward_type" "text" NOT NULL,
    "scheduled_date" "date" NOT NULL,
    "points_amount" integer,
    "metadata" "jsonb" DEFAULT '{}'::"jsonb",
    "claimed" boolean DEFAULT false,
    "claimed_at" timestamp with time zone,
    "expires_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."scheduled_rewards" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."skill_levels" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "code" "text" NOT NULL,
    "level" integer NOT NULL,
    "description" "text",
    CONSTRAINT "skill_levels_level_check" CHECK ((("level" >= 1) AND ("level" <= 5)))
);


ALTER TABLE "public"."skill_levels" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."social_metrics" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "metric_date" "date" NOT NULL,
    "daily_active_users" integer DEFAULT 0,
    "weekly_active_users" integer DEFAULT 0,
    "monthly_active_users" integer DEFAULT 0,
    "posts_created" integer DEFAULT 0,
    "posts_with_media" integer DEFAULT 0,
    "total_likes" integer DEFAULT 0,
    "total_comments" integer DEFAULT 0,
    "total_shares" integer DEFAULT 0,
    "avg_engagement_rate" numeric(5,2) DEFAULT 0,
    "friend_requests_sent" integer DEFAULT 0,
    "friend_requests_accepted" integer DEFAULT 0,
    "friend_requests_declined" integer DEFAULT 0,
    "avg_friends_per_user" numeric(5,2) DEFAULT 0,
    "messages_sent" integer DEFAULT 0,
    "conversations_started" integer DEFAULT 0,
    "avg_response_time_minutes" integer DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."social_metrics" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."social_notifications" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "type" "text" NOT NULL,
    "actor_id" "uuid",
    "post_id" "uuid",
    "comment_id" "uuid",
    "friendship_id" "uuid",
    "conversation_id" "uuid",
    "title" "text" NOT NULL,
    "body" "text",
    "data" "jsonb" DEFAULT '{}'::"jsonb",
    "is_read" boolean DEFAULT false,
    "read_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "social_notifications_type_check" CHECK (("type" = ANY (ARRAY['friend_request'::"text", 'friend_accepted'::"text", 'post_like'::"text", 'post_comment'::"text", 'comment_reply'::"text", 'mention'::"text", 'message'::"text", 'game_invite'::"text"])))
);


ALTER TABLE "public"."social_notifications" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."sports" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "code" "text" NOT NULL,
    "icon_url" "text",
    "min_players" integer NOT NULL,
    "max_players" integer NOT NULL,
    "default_duration" integer DEFAULT 60,
    "requires_venue" boolean DEFAULT true,
    "is_team_sport" boolean DEFAULT true,
    "is_active" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "icon_name" "text",
    "category" "text",
    "player_count_min" integer,
    "player_count_max" integer,
    CONSTRAINT "sports_category_check" CHECK (("category" = ANY (ARRAY['team'::"text", 'individual'::"text", 'racquet'::"text", 'water'::"text", 'winter'::"text", 'other'::"text"])))
);


ALTER TABLE "public"."sports" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."tier_levels" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "level" integer NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "icon_url" "text",
    "color_hex" "text",
    "min_points" integer NOT NULL,
    "max_points" integer NOT NULL,
    "benefits" "jsonb" DEFAULT '[]'::"jsonb",
    "privileges" "jsonb" DEFAULT '{}'::"jsonb",
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "points_range_valid" CHECK (("min_points" < "max_points"))
);


ALTER TABLE "public"."tier_levels" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."tournament_matches" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "tournament_id" "uuid" NOT NULL,
    "round_number" integer NOT NULL,
    "match_number" integer NOT NULL,
    "participant1_id" "uuid",
    "participant2_id" "uuid",
    "scheduled_time" timestamp with time zone,
    "actual_start_time" timestamp with time zone,
    "actual_end_time" timestamp with time zone,
    "status" "text" DEFAULT 'pending'::"text",
    "participant1_score" integer,
    "participant2_score" integer,
    "winner_id" "uuid",
    "venue_court" "text",
    "referee_id" "uuid",
    "notes" "text",
    "next_match_id" "uuid",
    "next_match_position" integer,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "tournament_matches_status_check" CHECK (("status" = ANY (ARRAY['pending'::"text", 'ongoing'::"text", 'completed'::"text", 'cancelled'::"text", 'walkover'::"text"])))
);


ALTER TABLE "public"."tournament_matches" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."tournament_participants" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "tournament_id" "uuid" NOT NULL,
    "user_id" "uuid",
    "team_id" "uuid",
    "display_name" "text" NOT NULL,
    "seed_number" integer,
    "skill_rating" integer,
    "current_round" integer DEFAULT 0,
    "is_eliminated" boolean DEFAULT false,
    "final_position" integer,
    "matches_played" integer DEFAULT 0,
    "matches_won" integer DEFAULT 0,
    "matches_lost" integer DEFAULT 0,
    "matches_drawn" integer DEFAULT 0,
    "points_scored" integer DEFAULT 0,
    "points_conceded" integer DEFAULT 0,
    "total_points" integer DEFAULT 0,
    "registered_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "eliminated_at" timestamp with time zone
);


ALTER TABLE "public"."tournament_participants" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."tournaments" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "event_id" "uuid",
    "format" "public"."tournament_format" NOT NULL,
    "status" "public"."tournament_status" DEFAULT 'draft'::"public"."tournament_status",
    "rounds" integer,
    "current_round" integer DEFAULT 0,
    "matches_per_round" integer,
    "points_for_win" integer DEFAULT 3,
    "points_for_draw" integer DEFAULT 1,
    "points_for_loss" integer DEFAULT 0,
    "is_seeded" boolean DEFAULT false,
    "seeding_method" "text" DEFAULT 'random'::"text",
    "match_duration_minutes" integer,
    "break_duration_minutes" integer,
    "rules_url" "text",
    "bracket_data" "jsonb" DEFAULT '{}'::"jsonb",
    "total_matches" integer DEFAULT 0,
    "completed_matches" integer DEFAULT 0,
    "started_at" timestamp with time zone,
    "completed_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "tournaments_seeding_method_check" CHECK (("seeding_method" = ANY (ARRAY['random'::"text", 'skill'::"text", 'ranking'::"text", 'manual'::"text"])))
);


ALTER TABLE "public"."tournaments" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_achievements" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "achievement_id" "uuid" NOT NULL,
    "current_progress" "jsonb" DEFAULT '{}'::"jsonb",
    "required_progress" "jsonb" DEFAULT '{}'::"jsonb",
    "progress_percentage" numeric(5,2) DEFAULT 0,
    "is_completed" boolean DEFAULT false,
    "completed_at" timestamp with time zone,
    "completion_count" integer DEFAULT 0,
    "started_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "last_updated" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "user_achievements_progress_percentage_check" CHECK ((("progress_percentage" >= (0)::numeric) AND ("progress_percentage" <= (100)::numeric)))
);


ALTER TABLE "public"."user_achievements" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_badges" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "badge_id" "uuid" NOT NULL,
    "achievement_id" "uuid" NOT NULL,
    "tier" "public"."badge_tier" NOT NULL,
    "earned_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "is_showcased" boolean DEFAULT false,
    "showcase_order" integer,
    "times_earned" integer DEFAULT 1
);


ALTER TABLE "public"."user_badges" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."user_card" AS
 SELECT "id",
    "display_name",
    "avatar_url",
    "skill_level",
    "language"
   FROM "public"."users";


ALTER VIEW "public"."user_card" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_feed_cache" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "post_id" "uuid" NOT NULL,
    "relevance_score" double precision NOT NULL,
    "cached_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."user_feed_cache" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."user_profile_public" AS
 SELECT "u"."id",
    "u"."display_name",
    "u"."avatar_url",
    "u"."language",
    "u"."skill_level",
    "ps"."total_games_played",
    "ps"."sportsmanship_rating"
   FROM ("public"."users" "u"
     LEFT JOIN "public"."profile_statistics" "ps" ON (("ps"."user_id" = "u"."id")));


ALTER VIEW "public"."user_profile_public" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_rankings" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "leaderboard_type" "public"."leaderboard_type" NOT NULL,
    "sport_id" "uuid",
    "time_period" "text",
    "rank" integer NOT NULL,
    "total_points" integer NOT NULL,
    "movement" integer DEFAULT 0,
    "previous_rank" integer,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."user_rankings" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_settings" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "theme_mode" "text" DEFAULT 'system'::"text",
    "language" "text" DEFAULT 'en'::"text",
    "notification_enabled" boolean DEFAULT true,
    "email_notifications" boolean DEFAULT true,
    "push_notifications" boolean DEFAULT true,
    "sms_notifications" boolean DEFAULT false,
    "two_factor_enabled" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "user_settings_theme_mode_check" CHECK (("theme_mode" = ANY (ARRAY['light'::"text", 'dark'::"text", 'system'::"text"])))
);


ALTER TABLE "public"."user_settings" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_sports_profiles" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "sport_id" "uuid" NOT NULL,
    "skill_level" integer DEFAULT 1,
    "years_playing" integer DEFAULT 0,
    "preferred_positions" "text"[],
    "certifications" "text"[],
    "achievements" "text"[],
    "is_primary_sport" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."user_sports_profiles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_tier_progress" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "current_tier_id" "uuid" NOT NULL,
    "total_points" integer DEFAULT 0,
    "points_to_next_tier" integer,
    "tier_progress_percentage" numeric(5,2) DEFAULT 0,
    "highest_tier_achieved" "uuid",
    "tier_up_count" integer DEFAULT 0,
    "last_tier_up" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."user_tier_progress" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."users_backup" (
    "id" "uuid",
    "email" "text",
    "display_name" "text",
    "created_at" timestamp with time zone,
    "age" integer,
    "preferred_sports" "text"[],
    "intent" "public"."user_intent",
    "avatar_url" "text",
    "updated_at" timestamp with time zone,
    "sports" "text"[],
    "phone" "text",
    "phone_confirmed_at" timestamp with time zone,
    "phone_confirmed" boolean,
    "email_confirmed_at" timestamp with time zone,
    "last_sign_in_at" timestamp with time zone,
    "is_anonymous" boolean,
    "onboarding_completed" boolean,
    "onboarding_step" "text",
    "language" "text",
    "timezone" "text",
    "notification_settings" "jsonb",
    "privacy_settings" "jsonb",
    "skill_level" "text",
    "games_played" integer,
    "bio" "text"
);


ALTER TABLE "public"."users_backup" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."users_public" AS
 SELECT "id",
    "display_name",
    "avatar_url",
    "language",
    "skill_level",
    "sports",
    "games_played",
    "is_profile_complete",
    "profile_completion_percentage",
    "created_at"
   FROM "public"."users";


ALTER VIEW "public"."users_public" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."venue_bookings" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "venue_id" "uuid" NOT NULL,
    "game_id" "uuid",
    "booked_by" "uuid",
    "sport_id" "uuid" NOT NULL,
    "booking_date" "date" NOT NULL,
    "start_time" time without time zone NOT NULL,
    "end_time" time without time zone NOT NULL,
    "court_number" integer,
    "total_amount" numeric(10,2) NOT NULL,
    "currency" "text" DEFAULT 'AED'::"text",
    "status" "text" DEFAULT 'pending'::"text",
    "payment_status" "text" DEFAULT 'pending'::"text",
    "payment_method" "text",
    "transaction_id" "text",
    "cancellation_reason" "text",
    "cancelled_at" timestamp with time zone,
    "cancelled_by" "uuid",
    "notes" "text",
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "slot_range" "tsrange" GENERATED ALWAYS AS ("tsrange"(("booking_date" + "start_time"), ("booking_date" + "end_time"), '[)'::"text")) STORED,
    CONSTRAINT "ck_venue_bookings_time_order" CHECK (("end_time" > "start_time")),
    CONSTRAINT "venue_bookings_payment_status_check" CHECK (("payment_status" = ANY (ARRAY['pending'::"text", 'paid'::"text", 'refunded'::"text", 'failed'::"text"]))),
    CONSTRAINT "venue_bookings_status_check" CHECK (("status" = ANY (ARRAY['pending'::"text", 'confirmed'::"text", 'cancelled'::"text", 'completed'::"text", 'no_show'::"text"])))
);


ALTER TABLE "public"."venue_bookings" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."v_bookings_daily" AS
 SELECT "booking_date" AS "day",
    "count"(*) AS "bookings",
    ("sum"(EXTRACT(epoch FROM ("end_time" - "start_time"))) / 3600.0) AS "total_hours"
   FROM "public"."venue_bookings" "b"
  GROUP BY "booking_date"
  ORDER BY "booking_date";


ALTER VIEW "public"."v_bookings_daily" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."v_daily_active_users" AS
 WITH "activity" AS (
         SELECT "p"."author_id" AS "user_id",
            ("date_trunc"('day'::"text", "p"."created_at"))::"date" AS "day"
           FROM "public"."posts" "p"
        UNION
         SELECT "c"."author_id" AS "user_id",
            ("date_trunc"('day'::"text", "c"."created_at"))::"date" AS "day"
           FROM "public"."comments" "c"
        UNION
         SELECT "r"."user_id",
            ("date_trunc"('day'::"text", "r"."created_at"))::"date" AS "day"
           FROM "public"."reactions" "r"
        )
 SELECT "day",
    "count"(DISTINCT "user_id") AS "active_users"
   FROM "activity"
  GROUP BY "day"
  ORDER BY "day";


ALTER VIEW "public"."v_daily_active_users" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."v_daily_new_users" AS
 SELECT ("date_trunc"('day'::"text", "created_at"))::"date" AS "day",
    "count"(*) AS "new_users"
   FROM "public"."users" "u"
  GROUP BY (("date_trunc"('day'::"text", "created_at"))::"date")
  ORDER BY (("date_trunc"('day'::"text", "created_at"))::"date");


ALTER VIEW "public"."v_daily_new_users" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."v_leaderboard_user_scores" AS
 SELECT "lb"."id" AS "leaderboard_id",
    "e"."user_id",
    COALESCE("e"."score", (0)::numeric) AS "score",
    "e"."rank"
   FROM ("public"."leaderboards" "lb"
     LEFT JOIN "public"."leaderboard_entries" "e" ON (("e"."leaderboard_id" = "lb"."id")));


ALTER VIEW "public"."v_leaderboard_user_scores" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."v_notifications_from_achievement" AS
 SELECT COALESCE("id", "gen_random_uuid"()) AS "id",
    "user_id",
    NULL::"uuid" AS "actor_id",
    'achievement'::"public"."notification_category" AS "category",
    COALESCE(NULLIF("notification_type", ''::"text"), 'achievement_event'::"text") AS "kind",
    "jsonb_build_object"('achievement_id', "achievement_id", 'title', "title", 'message', "message", 'read_at', "read_at") AS "data",
    COALESCE("is_read", ("read_at" IS NOT NULL), false) AS "is_read",
    COALESCE("created_at", "now"()) AS "created_at"
   FROM "public"."achievement_notifications";


ALTER VIEW "public"."v_notifications_from_achievement" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."v_notifications_from_game" AS
 SELECT COALESCE("id", "gen_random_uuid"()) AS "id",
    "recipient_id" AS "user_id",
    NULL::"uuid" AS "actor_id",
    'game'::"public"."notification_category" AS "category",
    COALESCE(NULLIF("type", ''::"text"), 'game_event'::"text") AS "kind",
    COALESCE("metadata", '{}'::"jsonb") AS "data",
    COALESCE("is_read", ("read_at" IS NOT NULL)) AS "is_read",
    COALESCE("sent_at", "read_at", "now"()) AS "created_at"
   FROM "public"."game_notifications";


ALTER VIEW "public"."v_notifications_from_game" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."v_notifications_from_notifications" AS
 SELECT (COALESCE(NULLIF(("id")::"text", ''::"text"), ("gen_random_uuid"())::"text"))::"uuid" AS "id",
    "user_id",
    NULL::"uuid" AS "actor_id",
    'system'::"public"."notification_category" AS "category",
    COALESCE(NULLIF("type", ''::"text"), 'system_event'::"text") AS "kind",
    COALESCE("data", '{}'::"jsonb") AS "data",
    COALESCE("is_read", false) AS "is_read",
    COALESCE("created_at", "now"()) AS "created_at"
   FROM "public"."notifications";


ALTER VIEW "public"."v_notifications_from_notifications" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."v_notifications_from_social" AS
 SELECT COALESCE("id", "gen_random_uuid"()) AS "id",
    "user_id",
    "actor_id",
    'social'::"public"."notification_category" AS "category",
    COALESCE(NULLIF("type", ''::"text"), 'social_event'::"text") AS "kind",
    COALESCE("data", '{}'::"jsonb") AS "data",
    COALESCE("is_read", false) AS "is_read",
    COALESCE("created_at", "now"()) AS "created_at"
   FROM "public"."social_notifications";


ALTER VIEW "public"."v_notifications_from_social" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."v_reaction_counts" AS
 SELECT 'post'::"text" AS "target_type",
    "r"."post_id" AS "target_id",
    "r"."reaction_type" AS "reaction",
    "count"(*) AS "cnt"
   FROM "public"."reactions" "r"
  WHERE ("r"."post_id" IS NOT NULL)
  GROUP BY "r"."post_id", "r"."reaction_type"
UNION ALL
 SELECT 'comment'::"text" AS "target_type",
    "r"."comment_id" AS "target_id",
    "r"."reaction_type" AS "reaction",
    "count"(*) AS "cnt"
   FROM "public"."reactions" "r"
  WHERE ("r"."comment_id" IS NOT NULL)
  GROUP BY "r"."comment_id", "r"."reaction_type";


ALTER VIEW "public"."v_reaction_counts" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."v_revenue_daily" AS
 SELECT "booking_date" AS "day",
    COALESCE("currency", 'AED'::"text") AS "currency",
    "sum"(COALESCE("total_amount", (0)::numeric)) AS "revenue"
   FROM "public"."venue_bookings" "b"
  GROUP BY "booking_date", COALESCE("currency", 'AED'::"text")
  ORDER BY "booking_date", COALESCE("currency", 'AED'::"text");


ALTER VIEW "public"."v_revenue_daily" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."v_top_posts_engagement" AS
 WITH "c" AS (
         SELECT "comments"."post_id",
            "count"(*) AS "comments"
           FROM "public"."comments"
          WHERE ("comments"."post_id" IS NOT NULL)
          GROUP BY "comments"."post_id"
        ), "r" AS (
         SELECT "reactions"."post_id",
            "count"(*) AS "reactions"
           FROM "public"."reactions"
          WHERE ("reactions"."post_id" IS NOT NULL)
          GROUP BY "reactions"."post_id"
        )
 SELECT "p"."id",
    "p"."author_id",
    "p"."created_at",
    COALESCE("c"."comments", (0)::bigint) AS "comments_count",
    COALESCE("r"."reactions", (0)::bigint) AS "reactions_count",
    (COALESCE("c"."comments", (0)::bigint) + COALESCE("r"."reactions", (0)::bigint)) AS "engagement_score"
   FROM (("public"."posts" "p"
     LEFT JOIN "c" ON (("c"."post_id" = "p"."id")))
     LEFT JOIN "r" ON (("r"."post_id" = "p"."id")))
  ORDER BY (COALESCE("c"."comments", (0)::bigint) + COALESCE("r"."reactions", (0)::bigint)) DESC, "p"."created_at" DESC;


ALTER VIEW "public"."v_top_posts_engagement" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."v_venue_bookings_day" AS
 SELECT "id",
    "venue_id",
    "sport_id",
    "booking_date",
    "start_time",
    "end_time",
    ("booking_date" + "start_time") AS "ts_start",
    ("booking_date" + "end_time") AS "ts_end",
    "slot_range"
   FROM "public"."venue_bookings";


ALTER VIEW "public"."v_venue_bookings_day" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."venue_amenities" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "venue_id" "uuid" NOT NULL,
    "amenity_name" "text" NOT NULL,
    "amenity_code" "text" NOT NULL,
    "is_available" boolean DEFAULT true
);


ALTER TABLE "public"."venue_amenities" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."venue_images" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "venue_id" "uuid" NOT NULL,
    "image_url" "text" NOT NULL,
    "caption" "text",
    "is_primary" boolean DEFAULT false,
    "display_order" integer DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE "public"."venue_images" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."venue_reviews" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "venue_id" "uuid" NOT NULL,
    "reviewer_id" "uuid",
    "booking_id" "uuid",
    "rating" integer NOT NULL,
    "review_text" "text",
    "facilities_rating" integer,
    "location_rating" integer,
    "value_rating" integer,
    "is_verified_booking" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "venue_reviews_facilities_rating_check" CHECK ((("facilities_rating" >= 1) AND ("facilities_rating" <= 5))),
    CONSTRAINT "venue_reviews_location_rating_check" CHECK ((("location_rating" >= 1) AND ("location_rating" <= 5))),
    CONSTRAINT "venue_reviews_rating_check" CHECK ((("rating" >= 1) AND ("rating" <= 5))),
    CONSTRAINT "venue_reviews_value_rating_check" CHECK ((("value_rating" >= 1) AND ("value_rating" <= 5)))
);


ALTER TABLE "public"."venue_reviews" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."venue_sports" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "venue_id" "uuid" NOT NULL,
    "sport_id" "uuid" NOT NULL,
    "court_count" integer DEFAULT 1,
    "price_per_hour" numeric(10,2),
    "is_available" boolean DEFAULT true
);


ALTER TABLE "public"."venue_sports" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."venue_time_slots" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "venue_id" "uuid" NOT NULL,
    "sport_id" "uuid" NOT NULL,
    "day_of_week" integer NOT NULL,
    "start_time" time without time zone NOT NULL,
    "end_time" time without time zone NOT NULL,
    "is_available" boolean DEFAULT true,
    "price_override" numeric(10,2),
    "court_number" integer,
    CONSTRAINT "venue_time_slots_day_of_week_check" CHECK ((("day_of_week" >= 0) AND ("day_of_week" <= 6)))
);


ALTER TABLE "public"."venue_time_slots" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."venues" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "address_line1" "text" NOT NULL,
    "address_line2" "text",
    "city" "text" NOT NULL,
    "state" "text",
    "country" "text" NOT NULL,
    "postal_code" "text",
    "latitude" double precision,
    "longitude" double precision,
    "phone_number" "text",
    "email" "text",
    "website" "text",
    "opening_time" time without time zone,
    "closing_time" time without time zone,
    "is_active" boolean DEFAULT true,
    "rating" numeric(3,2) DEFAULT 0.00,
    "total_ratings" integer DEFAULT 0,
    "price_per_hour" numeric(10,2),
    "currency" "text" DEFAULT 'USD'::"text",
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    CONSTRAINT "venues_rating_check" CHECK ((("rating" >= (0)::numeric) AND ("rating" <= (5)::numeric)))
);


ALTER TABLE "public"."venues" OWNER TO "postgres";


ALTER TABLE ONLY "public"."achievement_notifications"
    ADD CONSTRAINT "achievement_notifications_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."achievements"
    ADD CONSTRAINT "achievements_code_key" UNIQUE ("code");



ALTER TABLE ONLY "public"."achievements"
    ADD CONSTRAINT "achievements_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."activity_feed"
    ADD CONSTRAINT "activity_feed_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."activity_log"
    ADD CONSTRAINT "activity_log_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."auth_sessions"
    ADD CONSTRAINT "auth_sessions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."badge_showcase_settings"
    ADD CONSTRAINT "badge_showcase_settings_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."badge_showcase_settings"
    ADD CONSTRAINT "badge_showcase_settings_user_id_key" UNIQUE ("user_id");



ALTER TABLE ONLY "public"."badges"
    ADD CONSTRAINT "badges_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."challenge_participants"
    ADD CONSTRAINT "challenge_participants_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."challenge_progress_updates"
    ADD CONSTRAINT "challenge_progress_updates_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."comments"
    ADD CONSTRAINT "comments_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."community_analytics"
    ADD CONSTRAINT "community_analytics_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."community_challenges"
    ADD CONSTRAINT "community_challenges_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."community_events"
    ADD CONSTRAINT "community_events_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."community_groups"
    ADD CONSTRAINT "community_groups_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."community_growth_metrics"
    ADD CONSTRAINT "community_growth_metrics_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."community_leaderboards"
    ADD CONSTRAINT "community_leaderboards_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."conversation_participants"
    ADD CONSTRAINT "conversation_participants_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."conversations"
    ADD CONSTRAINT "conversations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."email_outbox"
    ADD CONSTRAINT "email_outbox_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."event_registrations"
    ADD CONSTRAINT "event_registrations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."venue_bookings"
    ADD CONSTRAINT "ex_venue_bookings_no_overlap" EXCLUDE USING "gist" ("venue_id" WITH =, "tsrange"((("booking_date")::timestamp without time zone + ("start_time")::interval), (("booking_date")::timestamp without time zone + ("end_time")::interval), '[)'::"text") WITH &&);



ALTER TABLE ONLY "public"."friendships"
    ADD CONSTRAINT "friendships_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."game_check_ins"
    ADD CONSTRAINT "game_check_ins_game_id_player_id_key" UNIQUE ("game_id", "player_id");



ALTER TABLE ONLY "public"."game_check_ins"
    ADD CONSTRAINT "game_check_ins_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."game_invitations"
    ADD CONSTRAINT "game_invitations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."game_notifications"
    ADD CONSTRAINT "game_notifications_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."game_players"
    ADD CONSTRAINT "game_players_check_in_code_key" UNIQUE ("check_in_code");



ALTER TABLE ONLY "public"."game_players"
    ADD CONSTRAINT "game_players_game_id_player_id_key" UNIQUE ("game_id", "player_id");



ALTER TABLE ONLY "public"."game_players"
    ADD CONSTRAINT "game_players_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."game_sessions"
    ADD CONSTRAINT "game_sessions_game_id_key" UNIQUE ("game_id");



ALTER TABLE ONLY "public"."game_sessions"
    ADD CONSTRAINT "game_sessions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."games"
    ADD CONSTRAINT "games_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."group_members"
    ADD CONSTRAINT "group_members_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."leaderboard_entries"
    ADD CONSTRAINT "leaderboard_entries_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."leaderboard_history"
    ADD CONSTRAINT "leaderboard_history_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."leaderboards"
    ADD CONSTRAINT "leaderboards_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."member_activity_log"
    ADD CONSTRAINT "member_activity_log_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."notifications"
    ADD CONSTRAINT "notifications_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."notifications_unified"
    ADD CONSTRAINT "notifications_unified_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."password_reset_attempts"
    ADD CONSTRAINT "password_reset_attempts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."player_ratings"
    ADD CONSTRAINT "player_ratings_game_id_rater_id_rated_player_id_key" UNIQUE ("game_id", "rater_id", "rated_player_id");



ALTER TABLE ONLY "public"."player_ratings"
    ADD CONSTRAINT "player_ratings_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."point_transactions"
    ADD CONSTRAINT "point_transactions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."points_multipliers"
    ADD CONSTRAINT "points_multipliers_code_key" UNIQUE ("code");



ALTER TABLE ONLY "public"."points_multipliers"
    ADD CONSTRAINT "points_multipliers_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."post_comments__old"
    ADD CONSTRAINT "post_comments_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."post_likes"
    ADD CONSTRAINT "post_likes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."post_likes"
    ADD CONSTRAINT "post_likes_post_id_user_id_key" UNIQUE ("post_id", "user_id");



ALTER TABLE ONLY "public"."posts"
    ADD CONSTRAINT "posts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."privacy_settings"
    ADD CONSTRAINT "privacy_settings_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."privacy_settings"
    ADD CONSTRAINT "privacy_settings_user_id_key" UNIQUE ("user_id");



ALTER TABLE ONLY "public"."profile_audit_log"
    ADD CONSTRAINT "profile_audit_log_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profile_audit"
    ADD CONSTRAINT "profile_audit_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profile_feature_flags"
    ADD CONSTRAINT "profile_feature_flags_feature_name_key" UNIQUE ("feature_name");



ALTER TABLE ONLY "public"."profile_feature_flags"
    ADD CONSTRAINT "profile_feature_flags_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profile_metrics"
    ADD CONSTRAINT "profile_metrics_metric_date_key" UNIQUE ("metric_date");



ALTER TABLE ONLY "public"."profile_metrics"
    ADD CONSTRAINT "profile_metrics_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profile_statistics"
    ADD CONSTRAINT "profile_statistics_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profile_statistics"
    ADD CONSTRAINT "profile_statistics_user_id_key" UNIQUE ("user_id");



ALTER TABLE ONLY "public"."profile_views"
    ADD CONSTRAINT "profile_views_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."reactions"
    ADD CONSTRAINT "reactions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."reactions_unified"
    ADD CONSTRAINT "reactions_unified_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."reactions_unified"
    ADD CONSTRAINT "reactions_unified_user_id_target_type_target_id_key" UNIQUE ("user_id", "target_type", "target_id");



ALTER TABLE ONLY "public"."regions"
    ADD CONSTRAINT "regions_code_key" UNIQUE ("code");



ALTER TABLE ONLY "public"."regions"
    ADD CONSTRAINT "regions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."rewards_config"
    ADD CONSTRAINT "rewards_config_config_key_key" UNIQUE ("config_key");



ALTER TABLE ONLY "public"."rewards_config"
    ADD CONSTRAINT "rewards_config_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."scheduled_rewards"
    ADD CONSTRAINT "scheduled_rewards_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."skill_levels"
    ADD CONSTRAINT "skill_levels_code_key" UNIQUE ("code");



ALTER TABLE ONLY "public"."skill_levels"
    ADD CONSTRAINT "skill_levels_level_key" UNIQUE ("level");



ALTER TABLE ONLY "public"."skill_levels"
    ADD CONSTRAINT "skill_levels_name_key" UNIQUE ("name");



ALTER TABLE ONLY "public"."skill_levels"
    ADD CONSTRAINT "skill_levels_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."social_metrics"
    ADD CONSTRAINT "social_metrics_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."social_notifications"
    ADD CONSTRAINT "social_notifications_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."sports"
    ADD CONSTRAINT "sports_code_key" UNIQUE ("code");



ALTER TABLE ONLY "public"."sports"
    ADD CONSTRAINT "sports_name_key" UNIQUE ("name");



ALTER TABLE ONLY "public"."sports"
    ADD CONSTRAINT "sports_name_unique" UNIQUE ("name");



ALTER TABLE ONLY "public"."sports"
    ADD CONSTRAINT "sports_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tier_levels"
    ADD CONSTRAINT "tier_levels_level_key" UNIQUE ("level");



ALTER TABLE ONLY "public"."tier_levels"
    ADD CONSTRAINT "tier_levels_name_key" UNIQUE ("name");



ALTER TABLE ONLY "public"."tier_levels"
    ADD CONSTRAINT "tier_levels_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tournament_matches"
    ADD CONSTRAINT "tournament_matches_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tournament_participants"
    ADD CONSTRAINT "tournament_participants_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tournaments"
    ADD CONSTRAINT "tournaments_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."challenge_participants"
    ADD CONSTRAINT "unique_challenge_participant" UNIQUE ("challenge_id", "user_id");



ALTER TABLE ONLY "public"."community_analytics"
    ADD CONSTRAINT "unique_community_analytics" UNIQUE ("group_id", "metric_date");



ALTER TABLE ONLY "public"."community_leaderboards"
    ADD CONSTRAINT "unique_community_leaderboards" UNIQUE ("category", "period", "group_id", "sport_id", "period_start");



ALTER TABLE ONLY "public"."conversation_participants"
    ADD CONSTRAINT "unique_conversation_participant" UNIQUE ("conversation_id", "user_id");



ALTER TABLE ONLY "public"."event_registrations"
    ADD CONSTRAINT "unique_event_registration" UNIQUE ("event_id", "user_id");



ALTER TABLE ONLY "public"."friendships"
    ADD CONSTRAINT "unique_friendship" UNIQUE ("user_id", "friend_id");



ALTER TABLE ONLY "public"."group_members"
    ADD CONSTRAINT "unique_group_member" UNIQUE ("group_id", "user_id");



ALTER TABLE ONLY "public"."community_growth_metrics"
    ADD CONSTRAINT "unique_growth_metrics" UNIQUE ("metric_week");



ALTER TABLE ONLY "public"."leaderboards"
    ADD CONSTRAINT "unique_leaderboard" UNIQUE ("type", "sport_id", "time_period");



ALTER TABLE ONLY "public"."leaderboard_entries"
    ADD CONSTRAINT "unique_leaderboard_entry" UNIQUE ("leaderboard_id", "user_id");



ALTER TABLE ONLY "public"."leaderboard_history"
    ADD CONSTRAINT "unique_leaderboard_history" UNIQUE ("leaderboard_id", "user_id", "snapshot_date");



ALTER TABLE ONLY "public"."scheduled_rewards"
    ADD CONSTRAINT "unique_scheduled_reward" UNIQUE ("user_id", "reward_type", "scheduled_date");



ALTER TABLE ONLY "public"."tournament_matches"
    ADD CONSTRAINT "unique_tournament_match" UNIQUE ("tournament_id", "round_number", "match_number");



ALTER TABLE ONLY "public"."tournament_participants"
    ADD CONSTRAINT "unique_tournament_participant" UNIQUE ("tournament_id", "user_id");



ALTER TABLE ONLY "public"."user_achievements"
    ADD CONSTRAINT "unique_user_achievement" UNIQUE ("user_id", "achievement_id");



ALTER TABLE ONLY "public"."user_badges"
    ADD CONSTRAINT "unique_user_badge" UNIQUE ("user_id", "badge_id");



ALTER TABLE ONLY "public"."reactions"
    ADD CONSTRAINT "unique_user_comment_reaction" UNIQUE ("user_id", "comment_id");



ALTER TABLE ONLY "public"."user_feed_cache"
    ADD CONSTRAINT "unique_user_post_cache" UNIQUE ("user_id", "post_id");



ALTER TABLE ONLY "public"."reactions"
    ADD CONSTRAINT "unique_user_post_reaction" UNIQUE ("user_id", "post_id");



ALTER TABLE ONLY "public"."user_rankings"
    ADD CONSTRAINT "unique_user_ranking" UNIQUE ("user_id", "leaderboard_type", "sport_id", "time_period");



ALTER TABLE ONLY "public"."user_achievements"
    ADD CONSTRAINT "user_achievements_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_badges"
    ADD CONSTRAINT "user_badges_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_feed_cache"
    ADD CONSTRAINT "user_feed_cache_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_preferences"
    ADD CONSTRAINT "user_preferences_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_preferences"
    ADD CONSTRAINT "user_preferences_user_id_key" UNIQUE ("user_id");



ALTER TABLE ONLY "public"."user_rankings"
    ADD CONSTRAINT "user_rankings_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_settings"
    ADD CONSTRAINT "user_settings_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_settings"
    ADD CONSTRAINT "user_settings_user_id_key" UNIQUE ("user_id");



ALTER TABLE ONLY "public"."user_sports_profiles"
    ADD CONSTRAINT "user_sports_profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_sports_profiles"
    ADD CONSTRAINT "user_sports_profiles_user_id_sport_id_key" UNIQUE ("user_id", "sport_id");



ALTER TABLE ONLY "public"."user_tier_progress"
    ADD CONSTRAINT "user_tier_progress_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_tier_progress"
    ADD CONSTRAINT "user_tier_progress_user_id_key" UNIQUE ("user_id");



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_phone_unique" UNIQUE ("phone");



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."venue_amenities"
    ADD CONSTRAINT "venue_amenities_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."venue_amenities"
    ADD CONSTRAINT "venue_amenities_venue_id_amenity_code_key" UNIQUE ("venue_id", "amenity_code");



ALTER TABLE ONLY "public"."venue_bookings"
    ADD CONSTRAINT "venue_bookings_no_overlap_per_venue_day" EXCLUDE USING "gist" ("venue_id" WITH =, "slot_range" WITH &&);



ALTER TABLE ONLY "public"."venue_bookings"
    ADD CONSTRAINT "venue_bookings_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."venue_images"
    ADD CONSTRAINT "venue_images_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."venue_reviews"
    ADD CONSTRAINT "venue_reviews_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."venue_reviews"
    ADD CONSTRAINT "venue_reviews_venue_id_reviewer_id_booking_id_key" UNIQUE ("venue_id", "reviewer_id", "booking_id");



ALTER TABLE ONLY "public"."venue_sports"
    ADD CONSTRAINT "venue_sports_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."venue_sports"
    ADD CONSTRAINT "venue_sports_venue_id_sport_id_key" UNIQUE ("venue_id", "sport_id");



ALTER TABLE ONLY "public"."venue_time_slots"
    ADD CONSTRAINT "venue_time_slots_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."venue_time_slots"
    ADD CONSTRAINT "venue_time_slots_venue_id_sport_id_day_of_week_start_time_c_key" UNIQUE ("venue_id", "sport_id", "day_of_week", "start_time", "court_number");



ALTER TABLE ONLY "public"."venues"
    ADD CONSTRAINT "venues_pkey" PRIMARY KEY ("id");



CREATE INDEX "idx_achievement_notifications_user_id" ON "public"."achievement_notifications" USING "btree" ("user_id");



CREATE INDEX "idx_achievement_notifications_user_unread" ON "public"."achievement_notifications" USING "btree" ("user_id", "created_at" DESC) WHERE ("is_read" = false);



CREATE INDEX "idx_achievements_category" ON "public"."achievements" USING "btree" ("category") WHERE ("is_active" = true);



CREATE INDEX "idx_achievements_code" ON "public"."achievements" USING "btree" ("code");



CREATE INDEX "idx_achievements_tier" ON "public"."achievements" USING "btree" ("tier");



CREATE INDEX "idx_activity_feed_notification_id" ON "public"."activity_feed" USING "btree" ("notification_id");



CREATE INDEX "idx_activity_feed_user" ON "public"."activity_feed" USING "btree" ("user_id");



CREATE INDEX "idx_activity_feed_user_id" ON "public"."activity_feed" USING "btree" ("user_id");



CREATE INDEX "idx_activity_log_target_user_id" ON "public"."activity_log" USING "btree" ("target_user_id");



CREATE INDEX "idx_activity_log_type" ON "public"."activity_log" USING "btree" ("activity_type");



CREATE INDEX "idx_activity_log_user_created_at" ON "public"."activity_log" USING "btree" ("user_id", "created_at" DESC);



CREATE INDEX "idx_activity_log_user_id" ON "public"."activity_log" USING "btree" ("user_id");



CREATE INDEX "idx_auth_sessions_device_id" ON "public"."auth_sessions" USING "btree" ("device_id");



CREATE INDEX "idx_auth_sessions_user_id" ON "public"."auth_sessions" USING "btree" ("user_id");



CREATE INDEX "idx_badge_showcase_settings_user_id" ON "public"."badge_showcase_settings" USING "btree" ("user_id");



CREATE INDEX "idx_badges_rarity" ON "public"."badges" USING "btree" ("rarity_score" DESC);



CREATE INDEX "idx_bookings_date_time" ON "public"."venue_bookings" USING "btree" ("booking_date", "start_time");



CREATE INDEX "idx_bookings_venue_date" ON "public"."venue_bookings" USING "btree" ("venue_id", "booking_date");



CREATE INDEX "idx_challenge_participants_challenge" ON "public"."challenge_participants" USING "btree" ("challenge_id");



CREATE INDEX "idx_challenge_participants_ranking" ON "public"."challenge_participants" USING "btree" ("challenge_id", "rank") WHERE ("is_completed" = false);



CREATE INDEX "idx_challenge_participants_user" ON "public"."challenge_participants" USING "btree" ("user_id") WHERE ("left_at" IS NULL);



CREATE INDEX "idx_challenge_participants_user_id" ON "public"."challenge_participants" USING "btree" ("user_id");



CREATE INDEX "idx_challenge_participants_verified_by" ON "public"."challenge_participants" USING "btree" ("verified_by");



CREATE INDEX "idx_challenge_progress_participant" ON "public"."challenge_progress_updates" USING "btree" ("participant_id", "created_at" DESC);



CREATE INDEX "idx_challenge_progress_updates_verified_by" ON "public"."challenge_progress_updates" USING "btree" ("verified_by");



CREATE INDEX "idx_comments_author_id" ON "public"."comments" USING "btree" ("author_id");



CREATE INDEX "idx_comments_created_desc" ON "public"."comments" USING "btree" ("created_at" DESC);



CREATE INDEX "idx_comments_parent" ON "public"."comments" USING "btree" ("parent_comment_id") WHERE ("parent_comment_id" IS NOT NULL);



CREATE INDEX "idx_comments_parent_comment" ON "public"."comments" USING "btree" ("parent_comment_id");



CREATE INDEX "idx_comments_post_created" ON "public"."comments" USING "btree" ("post_id", "created_at");



CREATE INDEX "idx_comments_post_created_at" ON "public"."comments" USING "btree" ("post_id", "created_at" DESC);



CREATE INDEX "idx_comments_post_id" ON "public"."comments" USING "btree" ("post_id");



CREATE INDEX "idx_community_analytics_date" ON "public"."community_analytics" USING "btree" ("metric_date" DESC);



CREATE INDEX "idx_community_analytics_group_date" ON "public"."community_analytics" USING "btree" ("group_id", "metric_date" DESC);



CREATE INDEX "idx_community_challenges_active" ON "public"."community_challenges" USING "btree" ("start_date", "end_date") WHERE ("status" = 'active'::"public"."challenge_status");



CREATE INDEX "idx_community_challenges_created_by" ON "public"."community_challenges" USING "btree" ("created_by");



CREATE INDEX "idx_community_challenges_group" ON "public"."community_challenges" USING "btree" ("group_id");



CREATE INDEX "idx_community_challenges_sport" ON "public"."community_challenges" USING "btree" ("sport_id");



CREATE INDEX "idx_community_challenges_status" ON "public"."community_challenges" USING "btree" ("status", "start_date");



CREATE INDEX "idx_community_events_date" ON "public"."community_events" USING "btree" ("start_date") WHERE ("status" = ANY (ARRAY['published'::"public"."event_status", 'registration_open'::"public"."event_status"]));



CREATE INDEX "idx_community_events_group" ON "public"."community_events" USING "btree" ("group_id") WHERE ("status" <> 'cancelled'::"public"."event_status");



CREATE INDEX "idx_community_events_organizer" ON "public"."community_events" USING "btree" ("organizer_id");



CREATE INDEX "idx_community_events_organizer_id" ON "public"."community_events" USING "btree" ("organizer_id");



CREATE INDEX "idx_community_events_sport" ON "public"."community_events" USING "btree" ("sport_id");



CREATE INDEX "idx_community_events_status" ON "public"."community_events" USING "btree" ("status", "start_date");



CREATE INDEX "idx_community_groups_activity" ON "public"."community_groups" USING "btree" ("activity_score" DESC) WHERE ("status" = 'active'::"public"."group_status");



CREATE INDEX "idx_community_groups_created_by" ON "public"."community_groups" USING "btree" ("created_by");



CREATE INDEX "idx_community_groups_region" ON "public"."community_groups" USING "btree" ("region_id") WHERE ("status" = 'active'::"public"."group_status");



CREATE INDEX "idx_community_groups_sport" ON "public"."community_groups" USING "btree" ("sport_id") WHERE ("status" = 'active'::"public"."group_status");



CREATE INDEX "idx_community_groups_type" ON "public"."community_groups" USING "btree" ("type") WHERE ("status" = 'active'::"public"."group_status");



CREATE INDEX "idx_community_leaderboards_calculation" ON "public"."community_leaderboards" USING "btree" ("next_calculation") WHERE ("is_active" = true);



CREATE INDEX "idx_community_leaderboards_category" ON "public"."community_leaderboards" USING "btree" ("category", "period");



CREATE INDEX "idx_community_leaderboards_group" ON "public"."community_leaderboards" USING "btree" ("group_id") WHERE ("is_active" = true);



CREATE INDEX "idx_conversation_participants_user" ON "public"."conversation_participants" USING "btree" ("user_id", "left_at");



CREATE INDEX "idx_conversation_participants_user_id" ON "public"."conversation_participants" USING "btree" ("user_id");



CREATE INDEX "idx_conversations_created_by" ON "public"."conversations" USING "btree" ("created_by");



CREATE INDEX "idx_conversations_last_message" ON "public"."conversations" USING "btree" ("last_message_at" DESC);



CREATE INDEX "idx_email_outbox_status" ON "public"."email_outbox" USING "btree" ("status");



CREATE INDEX "idx_email_outbox_user_id" ON "public"."email_outbox" USING "btree" ("user_id");



CREATE INDEX "idx_event_registrations_event" ON "public"."event_registrations" USING "btree" ("event_id") WHERE ("status" = 'registered'::"text");



CREATE INDEX "idx_event_registrations_payment" ON "public"."event_registrations" USING "btree" ("event_id", "payment_status");



CREATE INDEX "idx_event_registrations_user" ON "public"."event_registrations" USING "btree" ("user_id") WHERE ("status" = ANY (ARRAY['registered'::"text", 'waitlisted'::"text"]));



CREATE INDEX "idx_event_registrations_user_id" ON "public"."event_registrations" USING "btree" ("user_id");



CREATE INDEX "idx_friendships_accepted" ON "public"."friendships" USING "btree" ("user_id", "friend_id") WHERE ("status" = 'accepted'::"public"."friendship_status");



CREATE INDEX "idx_friendships_blocked_by" ON "public"."friendships" USING "btree" ("blocked_by");



CREATE INDEX "idx_friendships_friend_id" ON "public"."friendships" USING "btree" ("friend_id");



CREATE INDEX "idx_friendships_friend_status" ON "public"."friendships" USING "btree" ("friend_id", "status");



CREATE INDEX "idx_friendships_initiated_by" ON "public"."friendships" USING "btree" ("initiated_by");



CREATE INDEX "idx_friendships_status" ON "public"."friendships" USING "btree" ("status") WHERE ("status" = 'pending'::"public"."friendship_status");



CREATE INDEX "idx_friendships_user_id" ON "public"."friendships" USING "btree" ("user_id");



CREATE INDEX "idx_friendships_user_status" ON "public"."friendships" USING "btree" ("user_id", "status");



CREATE INDEX "idx_game_check_ins_game" ON "public"."game_check_ins" USING "btree" ("game_id");



CREATE INDEX "idx_game_check_ins_player" ON "public"."game_check_ins" USING "btree" ("player_id");



CREATE INDEX "idx_game_notifications_game" ON "public"."game_notifications" USING "btree" ("game_id");



CREATE INDEX "idx_game_notifications_recipient" ON "public"."game_notifications" USING "btree" ("recipient_id");



CREATE INDEX "idx_game_players_game" ON "public"."game_players" USING "btree" ("game_id");



CREATE INDEX "idx_game_players_player" ON "public"."game_players" USING "btree" ("player_id");



CREATE INDEX "idx_game_sessions_game" ON "public"."game_sessions" USING "btree" ("game_id");



CREATE INDEX "idx_games_organizer" ON "public"."games" USING "btree" ("organizer_id");



CREATE INDEX "idx_games_organizer_id" ON "public"."games" USING "btree" ("organizer_id");



CREATE INDEX "idx_games_scheduled" ON "public"."games" USING "btree" ("scheduled_date", "start_time");



CREATE INDEX "idx_games_skill_level" ON "public"."games" USING "btree" ("skill_level");



CREATE INDEX "idx_games_sport" ON "public"."games" USING "btree" ("sport_id");



CREATE INDEX "idx_games_status" ON "public"."games" USING "btree" ("status");



CREATE INDEX "idx_games_venue" ON "public"."games" USING "btree" ("venue_id");



CREATE INDEX "idx_games_venue_id" ON "public"."games" USING "btree" ("venue_id");



CREATE INDEX "idx_group_members_group" ON "public"."group_members" USING "btree" ("group_id") WHERE ("status" = 'active'::"text");



CREATE INDEX "idx_group_members_role" ON "public"."group_members" USING "btree" ("group_id", "role") WHERE ("status" = 'active'::"text");



CREATE INDEX "idx_group_members_user" ON "public"."group_members" USING "btree" ("user_id") WHERE ("status" = 'active'::"text");



CREATE INDEX "idx_group_members_user_id" ON "public"."group_members" USING "btree" ("user_id");



CREATE INDEX "idx_lb_entries_leaderboard_rank" ON "public"."leaderboard_entries" USING "btree" ("leaderboard_id", "rank");



CREATE INDEX "idx_lb_entries_leaderboard_user" ON "public"."leaderboard_entries" USING "btree" ("leaderboard_id", "user_id");



CREATE INDEX "idx_lb_entries_rank" ON "public"."leaderboard_entries" USING "btree" ("leaderboard_id", "rank");



CREATE INDEX "idx_lb_entries_score" ON "public"."leaderboard_entries" USING "btree" ("leaderboard_id", "score" DESC);



CREATE INDEX "idx_lb_history_board_time_created" ON "public"."leaderboard_history" USING "btree" ("leaderboard_id", "created_at" DESC);



CREATE INDEX "idx_lb_history_board_user" ON "public"."leaderboard_history" USING "btree" ("leaderboard_id", "user_id");



CREATE INDEX "idx_lb_history_user" ON "public"."leaderboard_history" USING "btree" ("user_id");



CREATE INDEX "idx_leaderboard_entries_board_rank" ON "public"."leaderboard_entries" USING "btree" ("leaderboard_id", "rank");



CREATE INDEX "idx_leaderboard_entries_score" ON "public"."leaderboard_entries" USING "btree" ("leaderboard_id", "score" DESC);



CREATE INDEX "idx_leaderboard_entries_user" ON "public"."leaderboard_entries" USING "btree" ("user_id");



CREATE INDEX "idx_leaderboard_entries_user_id" ON "public"."leaderboard_entries" USING "btree" ("user_id");



CREATE INDEX "idx_leaderboard_history_user_date" ON "public"."leaderboard_history" USING "btree" ("user_id", "snapshot_date" DESC);



CREATE INDEX "idx_leaderboard_history_user_id" ON "public"."leaderboard_history" USING "btree" ("user_id");



CREATE INDEX "idx_member_activity_group_user" ON "public"."member_activity_log" USING "btree" ("group_id", "user_id", "created_at" DESC);



CREATE INDEX "idx_member_activity_log_user_id" ON "public"."member_activity_log" USING "btree" ("user_id");



CREATE INDEX "idx_member_activity_type" ON "public"."member_activity_log" USING "btree" ("activity_type", "created_at" DESC);



CREATE INDEX "idx_messages_conversation_created" ON "public"."messages" USING "btree" ("conversation_id", "created_at" DESC);



CREATE INDEX "idx_messages_conversation_details" ON "public"."messages" USING "btree" ("conversation_id", "created_at" DESC, "read_by");



CREATE INDEX "idx_messages_sender" ON "public"."messages" USING "btree" ("sender_id");



CREATE INDEX "idx_messages_sender_id" ON "public"."messages" USING "btree" ("sender_id");



CREATE INDEX "idx_notifications_created_at" ON "public"."notifications" USING "btree" ("created_at" DESC);



CREATE INDEX "idx_notifications_type" ON "public"."notifications" USING "btree" ("type");



CREATE INDEX "idx_notifications_user_created_id" ON "public"."notifications" USING "btree" ("user_id", "created_at" DESC, "id" DESC);



CREATE INDEX "idx_notifications_user_id" ON "public"."notifications" USING "btree" ("user_id");



CREATE INDEX "idx_notifications_user_read_created" ON "public"."notifications" USING "btree" ("user_id", "is_read", "created_at" DESC);



CREATE INDEX "idx_notifications_user_unread" ON "public"."notifications" USING "btree" ("user_id", "is_read") WHERE ("is_read" = false);



CREATE INDEX "idx_nu_category_kind_time" ON "public"."notifications_unified" USING "btree" ("category", "kind", "created_at" DESC);



CREATE INDEX "idx_nu_user_created" ON "public"."notifications_unified" USING "btree" ("user_id", "created_at" DESC);



CREATE INDEX "idx_nu_user_unread_created" ON "public"."notifications_unified" USING "btree" ("user_id", "is_read", "created_at" DESC);



CREATE INDEX "idx_password_reset_email" ON "public"."password_reset_attempts" USING "btree" ("email");



CREATE INDEX "idx_password_reset_token" ON "public"."password_reset_attempts" USING "btree" ("token_hash");



CREATE INDEX "idx_player_ratings_game" ON "public"."player_ratings" USING "btree" ("game_id");



CREATE INDEX "idx_player_ratings_rated" ON "public"."player_ratings" USING "btree" ("rated_player_id");



CREATE INDEX "idx_player_ratings_rated_player_id" ON "public"."player_ratings" USING "btree" ("rated_player_id");



CREATE INDEX "idx_player_ratings_rater_id" ON "public"."player_ratings" USING "btree" ("rater_id");



CREATE INDEX "idx_point_transactions_achievement" ON "public"."point_transactions" USING "btree" ("achievement_id") WHERE ("achievement_id" IS NOT NULL);



CREATE INDEX "idx_point_transactions_daily" ON "public"."point_transactions" USING "btree" ("user_id", "created_date_utc" DESC);



CREATE INDEX "idx_point_transactions_type" ON "public"."point_transactions" USING "btree" ("type");



CREATE INDEX "idx_point_transactions_user_created" ON "public"."point_transactions" USING "btree" ("user_id", "created_at" DESC);



CREATE INDEX "idx_point_transactions_user_id" ON "public"."point_transactions" USING "btree" ("user_id");



CREATE INDEX "idx_post_comments_author_id" ON "public"."post_comments__old" USING "btree" ("author_id");



CREATE INDEX "idx_post_comments_post_id" ON "public"."post_comments__old" USING "btree" ("post_id");



CREATE INDEX "idx_post_likes_post_id" ON "public"."post_likes" USING "btree" ("post_id");



CREATE INDEX "idx_post_likes_user_id" ON "public"."post_likes" USING "btree" ("user_id");



CREATE INDEX "idx_posts_author_created" ON "public"."posts" USING "btree" ("author_id", "created_at" DESC);



CREATE INDEX "idx_posts_author_id" ON "public"."posts" USING "btree" ("author_id");



CREATE INDEX "idx_posts_created_at" ON "public"."posts" USING "btree" ("created_at" DESC);



CREATE INDEX "idx_posts_created_at_desc" ON "public"."posts" USING "btree" ("created_at" DESC) WHERE ("is_deleted" = false);



CREATE INDEX "idx_posts_game_id" ON "public"."posts" USING "btree" ("game_id");



CREATE INDEX "idx_posts_type" ON "public"."posts" USING "btree" ("type") WHERE ("is_deleted" = false);



CREATE INDEX "idx_posts_visibility" ON "public"."posts" USING "btree" ("visibility");



CREATE INDEX "idx_posts_visibility_created" ON "public"."posts" USING "btree" ("visibility", "created_at" DESC) WHERE ("is_deleted" = false);



CREATE INDEX "idx_posts_visibility_created_at" ON "public"."posts" USING "btree" ("visibility", "created_at" DESC);



CREATE INDEX "idx_privacy_settings_user_id" ON "public"."privacy_settings" USING "btree" ("user_id");



CREATE INDEX "idx_profile_audit_table_time" ON "public"."profile_audit_log" USING "btree" ("table_name", "changed_at" DESC);



CREATE INDEX "idx_profile_audit_user_time" ON "public"."profile_audit_log" USING "btree" ("user_id", "changed_at" DESC);



CREATE UNIQUE INDEX "idx_profile_metrics_date" ON "public"."profile_metrics" USING "btree" ("metric_date");



CREATE INDEX "idx_profile_statistics_last_active" ON "public"."profile_statistics" USING "btree" ("last_active" DESC);



CREATE INDEX "idx_profile_statistics_user_id" ON "public"."profile_statistics" USING "btree" ("user_id");



CREATE INDEX "idx_profile_views_profile_date" ON "public"."profile_views" USING "btree" ("profile_id", "viewed_at" DESC);



CREATE INDEX "idx_profile_views_profile_id" ON "public"."profile_views" USING "btree" ("profile_id");



CREATE INDEX "idx_profile_views_viewer" ON "public"."profile_views" USING "btree" ("viewer_id");



CREATE INDEX "idx_profile_views_viewer_id" ON "public"."profile_views" USING "btree" ("viewer_id");



CREATE INDEX "idx_reactions_comment" ON "public"."reactions" USING "btree" ("comment_id") WHERE ("comment_id" IS NOT NULL);



CREATE INDEX "idx_reactions_comment_id" ON "public"."reactions" USING "btree" ("comment_id");



CREATE INDEX "idx_reactions_comment_type" ON "public"."reactions" USING "btree" ("comment_id", "reaction_type");



CREATE INDEX "idx_reactions_comment_user_type" ON "public"."reactions" USING "btree" ("comment_id", "user_id", "reaction_type") WHERE ("comment_id" IS NOT NULL);



CREATE INDEX "idx_reactions_created_at" ON "public"."reactions" USING "btree" ("created_at");



CREATE INDEX "idx_reactions_post" ON "public"."reactions" USING "btree" ("post_id") WHERE ("post_id" IS NOT NULL);



CREATE INDEX "idx_reactions_post_id" ON "public"."reactions" USING "btree" ("post_id");



CREATE INDEX "idx_reactions_post_type" ON "public"."reactions" USING "btree" ("post_id", "reaction_type");



CREATE INDEX "idx_reactions_post_user_type" ON "public"."reactions" USING "btree" ("post_id", "user_id", "reaction_type") WHERE ("post_id" IS NOT NULL);



CREATE INDEX "idx_reactions_user" ON "public"."reactions" USING "btree" ("user_id");



CREATE INDEX "idx_reactions_user_id" ON "public"."reactions" USING "btree" ("user_id");



CREATE INDEX "idx_ru_target" ON "public"."reactions_unified" USING "btree" ("target_type", "target_id", "created_at" DESC);



CREATE INDEX "idx_ru_user" ON "public"."reactions_unified" USING "btree" ("user_id", "created_at" DESC);



CREATE INDEX "idx_scheduled_rewards_expires_at" ON "public"."scheduled_rewards" USING "btree" ("expires_at");



CREATE INDEX "idx_scheduled_rewards_unclaimed" ON "public"."scheduled_rewards" USING "btree" ("user_id", "scheduled_date") WHERE ("claimed" = false);



CREATE INDEX "idx_scheduled_rewards_user_id" ON "public"."scheduled_rewards" USING "btree" ("user_id");



CREATE UNIQUE INDEX "idx_social_metrics_date" ON "public"."social_metrics" USING "btree" ("metric_date");



CREATE INDEX "idx_social_notifications_actor_id" ON "public"."social_notifications" USING "btree" ("actor_id");



CREATE INDEX "idx_social_notifications_user_id" ON "public"."social_notifications" USING "btree" ("user_id");



CREATE INDEX "idx_social_notifications_user_type" ON "public"."social_notifications" USING "btree" ("user_id", "type");



CREATE INDEX "idx_social_notifications_user_unread" ON "public"."social_notifications" USING "btree" ("user_id", "created_at" DESC) WHERE ("is_read" = false);



CREATE INDEX "idx_tournament_matches_round" ON "public"."tournament_matches" USING "btree" ("tournament_id", "round_number");



CREATE INDEX "idx_tournament_matches_status" ON "public"."tournament_matches" USING "btree" ("status") WHERE ("status" = ANY (ARRAY['pending'::"text", 'ongoing'::"text"]));



CREATE INDEX "idx_tournament_matches_tournament" ON "public"."tournament_matches" USING "btree" ("tournament_id");



CREATE INDEX "idx_tournament_participants_seed" ON "public"."tournament_participants" USING "btree" ("tournament_id", "seed_number");



CREATE INDEX "idx_tournament_participants_tournament" ON "public"."tournament_participants" USING "btree" ("tournament_id");



CREATE INDEX "idx_tournament_participants_user" ON "public"."tournament_participants" USING "btree" ("user_id");



CREATE INDEX "idx_tournament_participants_user_id" ON "public"."tournament_participants" USING "btree" ("user_id");



CREATE UNIQUE INDEX "idx_unique_community_leaderboards" ON "public"."community_leaderboards" USING "btree" ("category", "period", "group_id", "sport_id", "period_start");



CREATE INDEX "idx_user_achievements_category_progress" ON "public"."user_achievements" USING "btree" ("user_id", "is_completed", "progress_percentage" DESC);



CREATE INDEX "idx_user_achievements_completed" ON "public"."user_achievements" USING "btree" ("user_id", "is_completed");



CREATE INDEX "idx_user_achievements_progress" ON "public"."user_achievements" USING "btree" ("user_id", "progress_percentage") WHERE ("is_completed" = false);



CREATE INDEX "idx_user_achievements_user" ON "public"."user_achievements" USING "btree" ("user_id");



CREATE INDEX "idx_user_achievements_user_id" ON "public"."user_achievements" USING "btree" ("user_id");



CREATE INDEX "idx_user_badges_showcased" ON "public"."user_badges" USING "btree" ("user_id", "showcase_order") WHERE ("is_showcased" = true);



CREATE INDEX "idx_user_badges_user" ON "public"."user_badges" USING "btree" ("user_id");



CREATE INDEX "idx_user_badges_user_earned_badge" ON "public"."user_badges" USING "btree" ("user_id", "earned_at" DESC, "badge_id");



CREATE INDEX "idx_user_badges_user_id" ON "public"."user_badges" USING "btree" ("user_id");



CREATE INDEX "idx_user_feed_cache_cached_at" ON "public"."user_feed_cache" USING "btree" ("cached_at");



CREATE INDEX "idx_user_feed_cache_user_id" ON "public"."user_feed_cache" USING "btree" ("user_id");



CREATE INDEX "idx_user_feed_cache_user_score" ON "public"."user_feed_cache" USING "btree" ("user_id", "relevance_score" DESC);



CREATE INDEX "idx_user_preferences_user_id" ON "public"."user_preferences" USING "btree" ("user_id");



CREATE INDEX "idx_user_rankings_rank" ON "public"."user_rankings" USING "btree" ("leaderboard_type", "sport_id", "time_period", "rank");



CREATE INDEX "idx_user_rankings_user" ON "public"."user_rankings" USING "btree" ("user_id");



CREATE INDEX "idx_user_rankings_user_id" ON "public"."user_rankings" USING "btree" ("user_id");



CREATE INDEX "idx_user_settings_user_id" ON "public"."user_settings" USING "btree" ("user_id");



CREATE INDEX "idx_user_sports_profiles_skill" ON "public"."user_sports_profiles" USING "btree" ("skill_level");



CREATE INDEX "idx_user_sports_profiles_user_id" ON "public"."user_sports_profiles" USING "btree" ("user_id");



CREATE INDEX "idx_user_sports_profiles_user_sport" ON "public"."user_sports_profiles" USING "btree" ("user_id", "sport_id");



CREATE INDEX "idx_user_tier_progress_points" ON "public"."user_tier_progress" USING "btree" ("total_points" DESC);



CREATE INDEX "idx_user_tier_progress_tier" ON "public"."user_tier_progress" USING "btree" ("current_tier_id");



CREATE INDEX "idx_user_tier_progress_user_id" ON "public"."user_tier_progress" USING "btree" ("user_id");



CREATE INDEX "idx_users_age" ON "public"."users" USING "btree" ("age");



CREATE INDEX "idx_users_display_name" ON "public"."users" USING "btree" ("display_name");



CREATE INDEX "idx_users_email" ON "public"."users" USING "btree" ("email");



CREATE INDEX "idx_users_gender" ON "public"."users" USING "btree" ("gender");



CREATE INDEX "idx_users_intent" ON "public"."users" USING "btree" ("intent");



CREATE INDEX "idx_users_language" ON "public"."users" USING "btree" ("language");



CREATE INDEX "idx_users_onboarding_completed" ON "public"."users" USING "btree" ("onboarding_completed");



CREATE INDEX "idx_users_phone" ON "public"."users" USING "btree" ("phone");



CREATE INDEX "idx_users_sports" ON "public"."users" USING "gin" ("sports");



CREATE INDEX "idx_venue_bookings_booked_by" ON "public"."venue_bookings" USING "btree" ("booked_by");



CREATE INDEX "idx_venue_bookings_created_at" ON "public"."venue_bookings" USING "btree" ("created_at");



CREATE INDEX "idx_venue_bookings_date" ON "public"."venue_bookings" USING "btree" ("booking_date");



CREATE INDEX "idx_venue_bookings_game" ON "public"."venue_bookings" USING "btree" ("game_id");



CREATE INDEX "idx_venue_bookings_venue" ON "public"."venue_bookings" USING "btree" ("venue_id");



CREATE INDEX "idx_venue_bookings_venue_time" ON "public"."venue_bookings" USING "btree" ("venue_id", "start_time", "end_time");



CREATE INDEX "idx_venue_reviews_reviewer_id" ON "public"."venue_reviews" USING "btree" ("reviewer_id");



CREATE INDEX "idx_venue_reviews_venue" ON "public"."venue_reviews" USING "btree" ("venue_id");



CREATE INDEX "idx_venue_sports_sport" ON "public"."venue_sports" USING "btree" ("sport_id");



CREATE INDEX "idx_venue_time_slots_venue" ON "public"."venue_time_slots" USING "btree" ("venue_id");



CREATE INDEX "idx_venues_city" ON "public"."venues" USING "btree" ("city");



CREATE INDEX "idx_venues_location" ON "public"."venues" USING "btree" ("latitude", "longitude");



CREATE INDEX "privacy_settings_user_id_idx" ON "public"."privacy_settings" USING "btree" ("user_id");



CREATE UNIQUE INDEX "privacy_settings_user_id_uniq_idx" ON "public"."privacy_settings" USING "btree" ("user_id");



CREATE UNIQUE INDEX "uniq_reaction_comment_user_type" ON "public"."reactions" USING "btree" ("user_id", "comment_id", "reaction_type") WHERE ("comment_id" IS NOT NULL);



CREATE UNIQUE INDEX "uniq_reaction_post_user_type" ON "public"."reactions" USING "btree" ("user_id", "post_id", "reaction_type") WHERE ("post_id" IS NOT NULL);



CREATE INDEX "user_preferences_user_id_idx" ON "public"."user_preferences" USING "btree" ("user_id");



CREATE UNIQUE INDEX "user_preferences_user_id_uniq_idx" ON "public"."user_preferences" USING "btree" ("user_id");



CREATE INDEX "user_settings_user_id_idx" ON "public"."user_settings" USING "btree" ("user_id");



CREATE UNIQUE INDEX "user_settings_user_id_uniq_idx" ON "public"."user_settings" USING "btree" ("user_id");



CREATE UNIQUE INDEX "users_auth_id_uniq" ON "public"."users" USING "btree" ("auth_id");



CREATE UNIQUE INDEX "users_email_lower_unique_idx" ON "public"."users" USING "btree" ("lower"("email"));



CREATE UNIQUE INDEX "ux_reactions_comment_once" ON "public"."reactions" USING "btree" ("user_id", "comment_id", "reaction_type") WHERE ("comment_id" IS NOT NULL);



CREATE UNIQUE INDEX "ux_reactions_post_once" ON "public"."reactions" USING "btree" ("user_id", "post_id", "reaction_type") WHERE ("post_id" IS NOT NULL);



CREATE UNIQUE INDEX "ux_reactions_user_comment_type" ON "public"."reactions" USING "btree" ("user_id", "comment_id", "reaction_type") WHERE (("comment_id" IS NOT NULL) AND ("post_id" IS NULL));



CREATE UNIQUE INDEX "ux_reactions_user_post_type" ON "public"."reactions" USING "btree" ("user_id", "post_id", "reaction_type") WHERE (("post_id" IS NOT NULL) AND ("comment_id" IS NULL));



CREATE OR REPLACE TRIGGER "cleanup_old_notifications_trigger" AFTER INSERT ON "public"."notifications" FOR EACH STATEMENT EXECUTE FUNCTION "public"."trigger_cleanup_old_notifications"();



CREATE OR REPLACE TRIGGER "generate_check_in_code_trigger" BEFORE INSERT ON "public"."game_players" FOR EACH ROW WHEN (("new"."status" = 'confirmed'::"text")) EXECUTE FUNCTION "public"."generate_check_in_code"();



CREATE OR REPLACE TRIGGER "handle_friendship_reciprocal_trigger" AFTER INSERT OR DELETE OR UPDATE ON "public"."friendships" FOR EACH ROW EXECUTE FUNCTION "public"."handle_friendship_reciprocal"();



CREATE OR REPLACE TRIGGER "set_updated_at" BEFORE UPDATE ON "public"."game_sessions" FOR EACH ROW EXECUTE FUNCTION "public"."handle_updated_at"();



CREATE OR REPLACE TRIGGER "set_updated_at" BEFORE UPDATE ON "public"."games" FOR EACH ROW EXECUTE FUNCTION "public"."handle_updated_at"();



CREATE OR REPLACE TRIGGER "set_updated_at" BEFORE UPDATE ON "public"."privacy_settings" FOR EACH ROW EXECUTE FUNCTION "public"."handle_updated_at"();



CREATE OR REPLACE TRIGGER "set_updated_at" BEFORE UPDATE ON "public"."profile_statistics" FOR EACH ROW EXECUTE FUNCTION "public"."handle_updated_at"();



CREATE OR REPLACE TRIGGER "set_updated_at" BEFORE UPDATE ON "public"."user_preferences" FOR EACH ROW EXECUTE FUNCTION "public"."handle_updated_at"();



CREATE OR REPLACE TRIGGER "set_updated_at" BEFORE UPDATE ON "public"."user_settings" FOR EACH ROW EXECUTE FUNCTION "public"."handle_updated_at"();



CREATE OR REPLACE TRIGGER "set_updated_at" BEFORE UPDATE ON "public"."user_sports_profiles" FOR EACH ROW EXECUTE FUNCTION "public"."handle_updated_at"();



CREATE OR REPLACE TRIGGER "set_updated_at" BEFORE UPDATE ON "public"."venue_bookings" FOR EACH ROW EXECUTE FUNCTION "public"."handle_updated_at"();



CREATE OR REPLACE TRIGGER "set_updated_at" BEFORE UPDATE ON "public"."venues" FOR EACH ROW EXECUTE FUNCTION "public"."handle_updated_at"();



CREATE OR REPLACE TRIGGER "set_updated_at_trigger" BEFORE UPDATE ON "public"."users" FOR EACH ROW EXECUTE FUNCTION "public"."set_updated_at"();



CREATE OR REPLACE TRIGGER "tr_audit_privacy_settings" AFTER INSERT OR DELETE OR UPDATE ON "public"."privacy_settings" FOR EACH ROW EXECUTE FUNCTION "public"."fn_profile_audit"();



CREATE OR REPLACE TRIGGER "tr_audit_user_preferences" AFTER INSERT OR DELETE OR UPDATE ON "public"."user_preferences" FOR EACH ROW EXECUTE FUNCTION "public"."fn_profile_audit"();



CREATE OR REPLACE TRIGGER "tr_audit_user_settings" AFTER INSERT OR DELETE OR UPDATE ON "public"."user_settings" FOR EACH ROW EXECUTE FUNCTION "public"."fn_profile_audit"();



CREATE OR REPLACE TRIGGER "track_friend_achievements_trigger" AFTER INSERT OR UPDATE ON "public"."friendships" FOR EACH ROW EXECUTE FUNCTION "public"."track_friend_achievements"();



CREATE OR REPLACE TRIGGER "trg_audit_notifications_unified" AFTER INSERT OR DELETE OR UPDATE ON "public"."notifications_unified" FOR EACH ROW EXECUTE FUNCTION "public"."profile_audit_log_fn"();



CREATE OR REPLACE TRIGGER "trg_audit_privacy_settings" AFTER INSERT OR DELETE OR UPDATE ON "public"."privacy_settings" FOR EACH ROW EXECUTE FUNCTION "public"."profile_audit_log_fn"();



CREATE OR REPLACE TRIGGER "trg_audit_reactions_unified" AFTER INSERT OR DELETE OR UPDATE ON "public"."reactions_unified" FOR EACH ROW EXECUTE FUNCTION "public"."profile_audit_log_fn"();



CREATE OR REPLACE TRIGGER "trg_audit_user_preferences" AFTER INSERT OR DELETE OR UPDATE ON "public"."user_preferences" FOR EACH ROW EXECUTE FUNCTION "public"."profile_audit_log_fn"();



CREATE OR REPLACE TRIGGER "trg_audit_user_settings" AFTER INSERT OR DELETE OR UPDATE ON "public"."user_settings" FOR EACH ROW EXECUTE FUNCTION "public"."profile_audit_log_fn"();



CREATE OR REPLACE TRIGGER "trg_comments_parent_same_post" BEFORE INSERT OR UPDATE ON "public"."comments" FOR EACH ROW EXECUTE FUNCTION "public"."_comments_parent_same_post_fn"();



CREATE OR REPLACE TRIGGER "trg_fanout_urgent_notifications" AFTER INSERT ON "public"."notifications" FOR EACH ROW EXECUTE FUNCTION "public"."fanout_urgent_notifications"();



CREATE OR REPLACE TRIGGER "trg_post_comments_del" INSTEAD OF DELETE ON "public"."post_comments" FOR EACH ROW EXECUTE FUNCTION "public"."_post_comments_del_fn"();



CREATE OR REPLACE TRIGGER "trg_post_comments_ins" INSTEAD OF INSERT ON "public"."post_comments" FOR EACH ROW EXECUTE FUNCTION "public"."_post_comments_ins_fn"();



CREATE OR REPLACE TRIGGER "trg_post_comments_upd" INSTEAD OF UPDATE ON "public"."post_comments" FOR EACH ROW EXECUTE FUNCTION "public"."_post_comments_upd_fn"();



CREATE OR REPLACE TRIGGER "trg_reactions_sync_likes" AFTER INSERT OR DELETE ON "public"."reactions" FOR EACH ROW EXECUTE FUNCTION "public"."reactions_sync_likes"();



CREATE OR REPLACE TRIGGER "trg_ru_del_comment_like" AFTER DELETE ON "public"."reactions_unified" FOR EACH ROW EXECUTE FUNCTION "public"."_ru_sync_comment_likes"();



CREATE OR REPLACE TRIGGER "trg_ru_del_post_like" AFTER DELETE ON "public"."reactions_unified" FOR EACH ROW EXECUTE FUNCTION "public"."_ru_sync_post_likes"();



CREATE OR REPLACE TRIGGER "trg_ru_ins_comment_like" AFTER INSERT ON "public"."reactions_unified" FOR EACH ROW EXECUTE FUNCTION "public"."_ru_sync_comment_likes"();



CREATE OR REPLACE TRIGGER "trg_ru_ins_post_like" AFTER INSERT ON "public"."reactions_unified" FOR EACH ROW EXECUTE FUNCTION "public"."_ru_sync_post_likes"();



CREATE OR REPLACE TRIGGER "trg_sync_feed_read_from_notification" AFTER UPDATE OF "is_read" ON "public"."notifications" FOR EACH ROW EXECUTE FUNCTION "public"."sync_feed_read_from_notification"();



CREATE OR REPLACE TRIGGER "trg_sync_notification_read_from_feed" AFTER UPDATE OF "is_read" ON "public"."activity_feed" FOR EACH ROW EXECUTE FUNCTION "public"."sync_notification_read_from_feed"();



CREATE OR REPLACE TRIGGER "trigger_sync_game_skill_level" BEFORE INSERT OR UPDATE ON "public"."games" FOR EACH ROW EXECUTE FUNCTION "public"."sync_game_skill_level"();



CREATE OR REPLACE TRIGGER "trigger_sync_game_sport" BEFORE INSERT OR UPDATE ON "public"."games" FOR EACH ROW EXECUTE FUNCTION "public"."sync_game_sport"();



CREATE OR REPLACE TRIGGER "update_completion_on_preferences" AFTER INSERT OR UPDATE ON "public"."user_preferences" FOR EACH ROW EXECUTE FUNCTION "public"."update_profile_completion"();



CREATE OR REPLACE TRIGGER "update_completion_on_sports_profile" AFTER INSERT OR DELETE OR UPDATE ON "public"."user_sports_profiles" FOR EACH ROW EXECUTE FUNCTION "public"."update_profile_completion"();



CREATE OR REPLACE TRIGGER "update_conversation_last_message_trigger" AFTER INSERT ON "public"."messages" FOR EACH ROW WHEN (("new"."is_deleted" = false)) EXECUTE FUNCTION "public"."update_conversation_last_message"();



CREATE OR REPLACE TRIGGER "update_game_player_count_trigger" AFTER INSERT OR DELETE OR UPDATE ON "public"."game_players" FOR EACH ROW EXECUTE FUNCTION "public"."update_game_player_count"();



CREATE OR REPLACE TRIGGER "update_notifications_updated_at_trigger" BEFORE UPDATE ON "public"."notifications" FOR EACH ROW EXECUTE FUNCTION "public"."update_notifications_updated_at"();



CREATE OR REPLACE TRIGGER "update_venue_rating_trigger" AFTER INSERT OR UPDATE ON "public"."venue_reviews" FOR EACH ROW EXECUTE FUNCTION "public"."update_venue_rating"();



ALTER TABLE ONLY "public"."achievement_notifications"
    ADD CONSTRAINT "achievement_notifications_achievement_id_fkey" FOREIGN KEY ("achievement_id") REFERENCES "public"."achievements"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."achievement_notifications"
    ADD CONSTRAINT "achievement_notifications_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."activity_feed"
    ADD CONSTRAINT "activity_feed_notification_id_fkey" FOREIGN KEY ("notification_id") REFERENCES "public"."notifications"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."activity_feed"
    ADD CONSTRAINT "activity_feed_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."activity_log"
    ADD CONSTRAINT "activity_log_target_user_id_fkey" FOREIGN KEY ("target_user_id") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."activity_log"
    ADD CONSTRAINT "activity_log_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."auth_sessions"
    ADD CONSTRAINT "auth_sessions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."badge_showcase_settings"
    ADD CONSTRAINT "badge_showcase_settings_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."badges"
    ADD CONSTRAINT "badges_achievement_id_fkey" FOREIGN KEY ("achievement_id") REFERENCES "public"."achievements"("id");



ALTER TABLE ONLY "public"."challenge_participants"
    ADD CONSTRAINT "challenge_participants_challenge_id_fkey" FOREIGN KEY ("challenge_id") REFERENCES "public"."community_challenges"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."challenge_participants"
    ADD CONSTRAINT "challenge_participants_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."challenge_participants"
    ADD CONSTRAINT "challenge_participants_verified_by_fkey" FOREIGN KEY ("verified_by") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."challenge_progress_updates"
    ADD CONSTRAINT "challenge_progress_updates_participant_id_fkey" FOREIGN KEY ("participant_id") REFERENCES "public"."challenge_participants"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."challenge_progress_updates"
    ADD CONSTRAINT "challenge_progress_updates_verified_by_fkey" FOREIGN KEY ("verified_by") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."comments"
    ADD CONSTRAINT "comments_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."comments"
    ADD CONSTRAINT "comments_parent_comment_id_fkey" FOREIGN KEY ("parent_comment_id") REFERENCES "public"."comments"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."comments"
    ADD CONSTRAINT "comments_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "public"."posts"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."community_analytics"
    ADD CONSTRAINT "community_analytics_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "public"."community_groups"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."community_challenges"
    ADD CONSTRAINT "community_challenges_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."community_challenges"
    ADD CONSTRAINT "community_challenges_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "public"."community_groups"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."community_challenges"
    ADD CONSTRAINT "community_challenges_region_id_fkey" FOREIGN KEY ("region_id") REFERENCES "public"."regions"("id");



ALTER TABLE ONLY "public"."community_challenges"
    ADD CONSTRAINT "community_challenges_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sports"("id");



ALTER TABLE ONLY "public"."community_events"
    ADD CONSTRAINT "community_events_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "public"."community_groups"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."community_events"
    ADD CONSTRAINT "community_events_organizer_id_fkey" FOREIGN KEY ("organizer_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."community_events"
    ADD CONSTRAINT "community_events_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sports"("id");



ALTER TABLE ONLY "public"."community_groups"
    ADD CONSTRAINT "community_groups_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."community_groups"
    ADD CONSTRAINT "community_groups_region_id_fkey" FOREIGN KEY ("region_id") REFERENCES "public"."regions"("id");



ALTER TABLE ONLY "public"."community_groups"
    ADD CONSTRAINT "community_groups_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sports"("id");



ALTER TABLE ONLY "public"."community_leaderboards"
    ADD CONSTRAINT "community_leaderboards_challenge_id_fkey" FOREIGN KEY ("challenge_id") REFERENCES "public"."community_challenges"("id");



ALTER TABLE ONLY "public"."community_leaderboards"
    ADD CONSTRAINT "community_leaderboards_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "public"."community_groups"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."community_leaderboards"
    ADD CONSTRAINT "community_leaderboards_region_id_fkey" FOREIGN KEY ("region_id") REFERENCES "public"."regions"("id");



ALTER TABLE ONLY "public"."community_leaderboards"
    ADD CONSTRAINT "community_leaderboards_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sports"("id");



ALTER TABLE ONLY "public"."community_leaderboards"
    ADD CONSTRAINT "community_leaderboards_tournament_id_fkey" FOREIGN KEY ("tournament_id") REFERENCES "public"."tournaments"("id");



ALTER TABLE ONLY "public"."conversation_participants"
    ADD CONSTRAINT "conversation_participants_conversation_id_fkey" FOREIGN KEY ("conversation_id") REFERENCES "public"."conversations"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."conversation_participants"
    ADD CONSTRAINT "conversation_participants_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."conversations"
    ADD CONSTRAINT "conversations_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."email_outbox"
    ADD CONSTRAINT "email_outbox_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."event_registrations"
    ADD CONSTRAINT "event_registrations_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "public"."community_events"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."event_registrations"
    ADD CONSTRAINT "event_registrations_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."venue_bookings"
    ADD CONSTRAINT "fk_bookings_sport" FOREIGN KEY ("sport_id") REFERENCES "public"."sports"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."venue_bookings"
    ADD CONSTRAINT "fk_bookings_venue" FOREIGN KEY ("venue_id") REFERENCES "public"."venues"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."leaderboard_entries"
    ADD CONSTRAINT "fk_lb_entries_user" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."leaderboard_entries"
    ADD CONSTRAINT "fk_leaderboard_entries_user" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."friendships"
    ADD CONSTRAINT "friendships_blocked_by_fkey" FOREIGN KEY ("blocked_by") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."friendships"
    ADD CONSTRAINT "friendships_friend_id_fkey" FOREIGN KEY ("friend_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."friendships"
    ADD CONSTRAINT "friendships_initiated_by_fkey" FOREIGN KEY ("initiated_by") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."friendships"
    ADD CONSTRAINT "friendships_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."game_check_ins"
    ADD CONSTRAINT "game_check_ins_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "public"."games"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."game_invitations"
    ADD CONSTRAINT "game_invitations_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "public"."games"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."game_notifications"
    ADD CONSTRAINT "game_notifications_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "public"."games"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."game_players"
    ADD CONSTRAINT "game_players_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "public"."games"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."game_sessions"
    ADD CONSTRAINT "game_sessions_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "public"."games"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."games"
    ADD CONSTRAINT "games_organizer_id_fkey" FOREIGN KEY ("organizer_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."games"
    ADD CONSTRAINT "games_skill_level_id_fkey" FOREIGN KEY ("skill_level_id") REFERENCES "public"."skill_levels"("id");



ALTER TABLE ONLY "public"."games"
    ADD CONSTRAINT "games_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sports"("id");



ALTER TABLE ONLY "public"."games"
    ADD CONSTRAINT "games_venue_id_fkey" FOREIGN KEY ("venue_id") REFERENCES "public"."venues"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."group_members"
    ADD CONSTRAINT "group_members_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "public"."community_groups"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."group_members"
    ADD CONSTRAINT "group_members_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."leaderboard_entries"
    ADD CONSTRAINT "leaderboard_entries_leaderboard_id_fkey" FOREIGN KEY ("leaderboard_id") REFERENCES "public"."leaderboards"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."leaderboard_entries"
    ADD CONSTRAINT "leaderboard_entries_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."leaderboard_history"
    ADD CONSTRAINT "leaderboard_history_leaderboard_id_fkey" FOREIGN KEY ("leaderboard_id") REFERENCES "public"."leaderboards"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."leaderboard_history"
    ADD CONSTRAINT "leaderboard_history_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."leaderboards"
    ADD CONSTRAINT "leaderboards_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sports"("id");



ALTER TABLE ONLY "public"."member_activity_log"
    ADD CONSTRAINT "member_activity_log_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "public"."community_groups"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."member_activity_log"
    ADD CONSTRAINT "member_activity_log_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_conversation_id_fkey" FOREIGN KEY ("conversation_id") REFERENCES "public"."conversations"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_reply_to_message_id_fkey" FOREIGN KEY ("reply_to_message_id") REFERENCES "public"."messages"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_sender_id_fkey" FOREIGN KEY ("sender_id") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."notifications_unified"
    ADD CONSTRAINT "notifications_unified_actor_id_fkey" FOREIGN KEY ("actor_id") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."notifications_unified"
    ADD CONSTRAINT "notifications_unified_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."notifications"
    ADD CONSTRAINT "notifications_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."player_ratings"
    ADD CONSTRAINT "player_ratings_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "public"."games"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."player_ratings"
    ADD CONSTRAINT "player_ratings_rated_player_id_fkey" FOREIGN KEY ("rated_player_id") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."player_ratings"
    ADD CONSTRAINT "player_ratings_rater_id_fkey" FOREIGN KEY ("rater_id") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."point_transactions"
    ADD CONSTRAINT "point_transactions_achievement_id_fkey" FOREIGN KEY ("achievement_id") REFERENCES "public"."achievements"("id");



ALTER TABLE ONLY "public"."point_transactions"
    ADD CONSTRAINT "point_transactions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."post_comments__old"
    ADD CONSTRAINT "post_comments_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."post_comments__old"
    ADD CONSTRAINT "post_comments_parent_comment_id_fkey" FOREIGN KEY ("parent_comment_id") REFERENCES "public"."post_comments__old"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."post_comments__old"
    ADD CONSTRAINT "post_comments_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "public"."posts"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."post_likes"
    ADD CONSTRAINT "post_likes_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "public"."posts"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."post_likes"
    ADD CONSTRAINT "post_likes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."posts"
    ADD CONSTRAINT "posts_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."posts"
    ADD CONSTRAINT "posts_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "public"."games"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."posts"
    ADD CONSTRAINT "posts_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sports"("id");



ALTER TABLE ONLY "public"."privacy_settings"
    ADD CONSTRAINT "privacy_settings_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."profile_audit_log"
    ADD CONSTRAINT "profile_audit_log_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."profile_statistics"
    ADD CONSTRAINT "profile_statistics_favorite_sport_id_fkey" FOREIGN KEY ("favorite_sport_id") REFERENCES "public"."sports"("id");



ALTER TABLE ONLY "public"."profile_statistics"
    ADD CONSTRAINT "profile_statistics_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."profile_views"
    ADD CONSTRAINT "profile_views_profile_id_fkey" FOREIGN KEY ("profile_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."profile_views"
    ADD CONSTRAINT "profile_views_viewer_id_fkey" FOREIGN KEY ("viewer_id") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."reactions"
    ADD CONSTRAINT "reactions_comment_id_fkey" FOREIGN KEY ("comment_id") REFERENCES "public"."comments"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."reactions"
    ADD CONSTRAINT "reactions_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "public"."posts"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."reactions_unified"
    ADD CONSTRAINT "reactions_unified_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."reactions"
    ADD CONSTRAINT "reactions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."regions"
    ADD CONSTRAINT "regions_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "public"."regions"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."scheduled_rewards"
    ADD CONSTRAINT "scheduled_rewards_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."social_notifications"
    ADD CONSTRAINT "social_notifications_actor_id_fkey" FOREIGN KEY ("actor_id") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."social_notifications"
    ADD CONSTRAINT "social_notifications_comment_id_fkey" FOREIGN KEY ("comment_id") REFERENCES "public"."comments"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."social_notifications"
    ADD CONSTRAINT "social_notifications_conversation_id_fkey" FOREIGN KEY ("conversation_id") REFERENCES "public"."conversations"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."social_notifications"
    ADD CONSTRAINT "social_notifications_friendship_id_fkey" FOREIGN KEY ("friendship_id") REFERENCES "public"."friendships"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."social_notifications"
    ADD CONSTRAINT "social_notifications_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "public"."posts"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."social_notifications"
    ADD CONSTRAINT "social_notifications_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."tournament_matches"
    ADD CONSTRAINT "tournament_matches_next_match_id_fkey" FOREIGN KEY ("next_match_id") REFERENCES "public"."tournament_matches"("id");



ALTER TABLE ONLY "public"."tournament_matches"
    ADD CONSTRAINT "tournament_matches_participant1_id_fkey" FOREIGN KEY ("participant1_id") REFERENCES "public"."tournament_participants"("id");



ALTER TABLE ONLY "public"."tournament_matches"
    ADD CONSTRAINT "tournament_matches_participant2_id_fkey" FOREIGN KEY ("participant2_id") REFERENCES "public"."tournament_participants"("id");



ALTER TABLE ONLY "public"."tournament_matches"
    ADD CONSTRAINT "tournament_matches_tournament_id_fkey" FOREIGN KEY ("tournament_id") REFERENCES "public"."tournaments"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."tournament_matches"
    ADD CONSTRAINT "tournament_matches_winner_id_fkey" FOREIGN KEY ("winner_id") REFERENCES "public"."tournament_participants"("id");



ALTER TABLE ONLY "public"."tournament_participants"
    ADD CONSTRAINT "tournament_participants_tournament_id_fkey" FOREIGN KEY ("tournament_id") REFERENCES "public"."tournaments"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."tournament_participants"
    ADD CONSTRAINT "tournament_participants_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."tournaments"
    ADD CONSTRAINT "tournaments_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "public"."community_events"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_achievements"
    ADD CONSTRAINT "user_achievements_achievement_id_fkey" FOREIGN KEY ("achievement_id") REFERENCES "public"."achievements"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_achievements"
    ADD CONSTRAINT "user_achievements_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_badges"
    ADD CONSTRAINT "user_badges_achievement_id_fkey" FOREIGN KEY ("achievement_id") REFERENCES "public"."achievements"("id");



ALTER TABLE ONLY "public"."user_badges"
    ADD CONSTRAINT "user_badges_badge_id_fkey" FOREIGN KEY ("badge_id") REFERENCES "public"."badges"("id");



ALTER TABLE ONLY "public"."user_badges"
    ADD CONSTRAINT "user_badges_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_feed_cache"
    ADD CONSTRAINT "user_feed_cache_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "public"."posts"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_feed_cache"
    ADD CONSTRAINT "user_feed_cache_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_preferences"
    ADD CONSTRAINT "user_preferences_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_rankings"
    ADD CONSTRAINT "user_rankings_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sports"("id");



ALTER TABLE ONLY "public"."user_rankings"
    ADD CONSTRAINT "user_rankings_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_settings"
    ADD CONSTRAINT "user_settings_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_sports_profiles"
    ADD CONSTRAINT "user_sports_profiles_skill_level_fkey" FOREIGN KEY ("skill_level") REFERENCES "public"."skill_levels"("level");



ALTER TABLE ONLY "public"."user_sports_profiles"
    ADD CONSTRAINT "user_sports_profiles_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sports"("id");



ALTER TABLE ONLY "public"."user_sports_profiles"
    ADD CONSTRAINT "user_sports_profiles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_tier_progress"
    ADD CONSTRAINT "user_tier_progress_current_tier_id_fkey" FOREIGN KEY ("current_tier_id") REFERENCES "public"."tier_levels"("id");



ALTER TABLE ONLY "public"."user_tier_progress"
    ADD CONSTRAINT "user_tier_progress_highest_tier_achieved_fkey" FOREIGN KEY ("highest_tier_achieved") REFERENCES "public"."tier_levels"("id");



ALTER TABLE ONLY "public"."user_tier_progress"
    ADD CONSTRAINT "user_tier_progress_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_auth_id_fkey" FOREIGN KEY ("auth_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."venue_amenities"
    ADD CONSTRAINT "venue_amenities_venue_id_fkey" FOREIGN KEY ("venue_id") REFERENCES "public"."venues"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."venue_bookings"
    ADD CONSTRAINT "venue_bookings_booked_by_fkey" FOREIGN KEY ("booked_by") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."venue_bookings"
    ADD CONSTRAINT "venue_bookings_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "public"."games"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."venue_bookings"
    ADD CONSTRAINT "venue_bookings_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sports"("id");



ALTER TABLE ONLY "public"."venue_bookings"
    ADD CONSTRAINT "venue_bookings_venue_id_fkey" FOREIGN KEY ("venue_id") REFERENCES "public"."venues"("id");



ALTER TABLE ONLY "public"."venue_images"
    ADD CONSTRAINT "venue_images_venue_id_fkey" FOREIGN KEY ("venue_id") REFERENCES "public"."venues"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."venue_reviews"
    ADD CONSTRAINT "venue_reviews_booking_id_fkey" FOREIGN KEY ("booking_id") REFERENCES "public"."venue_bookings"("id");



ALTER TABLE ONLY "public"."venue_reviews"
    ADD CONSTRAINT "venue_reviews_reviewer_id_fkey" FOREIGN KEY ("reviewer_id") REFERENCES "public"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."venue_reviews"
    ADD CONSTRAINT "venue_reviews_venue_id_fkey" FOREIGN KEY ("venue_id") REFERENCES "public"."venues"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."venue_sports"
    ADD CONSTRAINT "venue_sports_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sports"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."venue_sports"
    ADD CONSTRAINT "venue_sports_venue_id_fkey" FOREIGN KEY ("venue_id") REFERENCES "public"."venues"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."venue_time_slots"
    ADD CONSTRAINT "venue_time_slots_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sports"("id");



ALTER TABLE ONLY "public"."venue_time_slots"
    ADD CONSTRAINT "venue_time_slots_venue_id_fkey" FOREIGN KEY ("venue_id") REFERENCES "public"."venues"("id") ON DELETE CASCADE;



CREATE POLICY "Allow all authenticated users to view games" ON "public"."games" FOR SELECT USING (("auth"."uid"() IS NOT NULL));



CREATE POLICY "Allow authenticated users to create games" ON "public"."games" FOR INSERT WITH CHECK ((("auth"."uid"() IS NOT NULL) AND ("organizer_id" = "auth"."uid"())));



CREATE POLICY "Allow organizers to delete their games" ON "public"."games" FOR DELETE USING (("organizer_id" = "auth"."uid"()));



CREATE POLICY "Allow organizers to update their games" ON "public"."games" FOR UPDATE USING (("organizer_id" = "auth"."uid"())) WITH CHECK (("organizer_id" = "auth"."uid"()));



CREATE POLICY "Allow users to join games" ON "public"."game_players" FOR INSERT WITH CHECK (("player_id" = "auth"."uid"()));



CREATE POLICY "Allow users to leave games" ON "public"."game_players" FOR DELETE USING (("player_id" = "auth"."uid"()));



CREATE POLICY "Allow users to update their own participations" ON "public"."game_players" FOR UPDATE USING (("player_id" = "auth"."uid"())) WITH CHECK (("player_id" = "auth"."uid"()));



CREATE POLICY "Allow users to view their own game participations" ON "public"."game_players" FOR SELECT USING (("player_id" = "auth"."uid"()));



CREATE POLICY "Anyone can view public groups" ON "public"."community_groups" FOR SELECT USING ((("type" = 'public'::"public"."group_type") AND ("status" = 'active'::"public"."group_status") AND ("is_visible" = true)));



CREATE POLICY "Anyone can view skill levels" ON "public"."skill_levels" FOR SELECT USING (true);



CREATE POLICY "Anyone can view sports" ON "public"."sports" FOR SELECT USING (true);



CREATE POLICY "Anyone can view venue amenities" ON "public"."venue_amenities" FOR SELECT USING (true);



CREATE POLICY "Anyone can view venue images" ON "public"."venue_images" FOR SELECT USING (true);



CREATE POLICY "Anyone can view venue reviews" ON "public"."venue_reviews" FOR SELECT USING (true);



CREATE POLICY "Anyone can view venue sports" ON "public"."venue_sports" FOR SELECT USING (true);



CREATE POLICY "Anyone can view venue time slots" ON "public"."venue_time_slots" FOR SELECT USING (true);



CREATE POLICY "Anyone can view venues" ON "public"."venues" FOR SELECT USING (("is_active" = true));



CREATE POLICY "Enable delete for users" ON "public"."friendships" FOR DELETE TO "authenticated" USING ((("auth"."uid"() = "user_id") OR ("auth"."uid"() = "friend_id")));



CREATE POLICY "Enable insert for authenticated users" ON "public"."friendships" FOR INSERT TO "authenticated" WITH CHECK ((("auth"."uid"() IS NOT NULL) AND ("user_id" = "auth"."uid"())));



CREATE POLICY "Enable read for users" ON "public"."friendships" FOR SELECT TO "authenticated" USING ((("auth"."uid"() = "user_id") OR ("auth"."uid"() = "friend_id")));



CREATE POLICY "Enable update for users" ON "public"."friendships" FOR UPDATE TO "authenticated" USING ((("auth"."uid"() = "user_id") OR ("auth"."uid"() = "friend_id"))) WITH CHECK ((("auth"."uid"() = "user_id") OR ("auth"."uid"() = "friend_id")));



CREATE POLICY "Friends posts are viewable by friends" ON "public"."posts" FOR SELECT USING ((("is_deleted" = false) AND (("author_id" = "auth"."uid"()) OR (("visibility" = 'friends'::"text") AND (EXISTS ( SELECT 1
   FROM "public"."friendships"
  WHERE (("friendships"."status" = 'accepted'::"public"."friendship_status") AND ((("friendships"."user_id" = "auth"."uid"()) AND ("friendships"."friend_id" = "posts"."author_id")) OR (("friendships"."friend_id" = "auth"."uid"()) AND ("friendships"."user_id" = "posts"."author_id"))))))))));



CREATE POLICY "Friendships: insert by requester" ON "public"."friendships" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Friendships: select own rows" ON "public"."friendships" FOR SELECT USING ((("auth"."uid"() = "user_id") OR ("auth"."uid"() = "friend_id")));



CREATE POLICY "Friendships: update by either side" ON "public"."friendships" FOR UPDATE USING ((("auth"."uid"() = "user_id") OR ("auth"."uid"() = "friend_id"))) WITH CHECK ((("auth"."uid"() = "user_id") OR ("auth"."uid"() = "friend_id")));



CREATE POLICY "Group admins can update groups" ON "public"."community_groups" FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM "public"."group_members" "gm"
  WHERE (("gm"."group_id" = "community_groups"."id") AND ("gm"."user_id" = "auth"."uid"()) AND ("gm"."role" = ANY (ARRAY['owner'::"text", 'admin'::"text"])) AND ("gm"."status" = 'active'::"text")))));



CREATE POLICY "Members can view their groups" ON "public"."community_groups" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."group_members" "gm"
  WHERE (("gm"."group_id" = "community_groups"."id") AND ("gm"."user_id" = "auth"."uid"()) AND ("gm"."status" = 'active'::"text")))));



CREATE POLICY "Organizers can manage sessions" ON "public"."game_sessions" USING ((EXISTS ( SELECT 1
   FROM "public"."games"
  WHERE (("games"."id" = "game_sessions"."game_id") AND ("games"."organizer_id" = "auth"."uid"())))));



CREATE POLICY "Players can check in" ON "public"."game_check_ins" FOR INSERT WITH CHECK (("auth"."uid"() = "player_id"));



CREATE POLICY "Players can rate other players" ON "public"."player_ratings" FOR INSERT WITH CHECK ((("auth"."uid"() = "rater_id") AND (EXISTS ( SELECT 1
   FROM "public"."game_players"
  WHERE (("game_players"."game_id" = "player_ratings"."game_id") AND ("game_players"."player_id" = "auth"."uid"()) AND ("game_players"."status" = 'confirmed'::"text"))))));



CREATE POLICY "Post comments are viewable by everyone" ON "public"."post_comments__old" FOR SELECT USING (true);



CREATE POLICY "Post likes are viewable by everyone" ON "public"."post_likes" FOR SELECT USING (true);



CREATE POLICY "Public can read profiles" ON "public"."users" FOR SELECT USING (true);



CREATE POLICY "Public can read users" ON "public"."users" FOR SELECT USING (true);



CREATE POLICY "Public posts are viewable by everyone" ON "public"."posts" FOR SELECT USING (("visibility" = 'public'::"text"));



CREATE POLICY "Users Select (authenticated)" ON "public"."users" FOR SELECT USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Users Update Own" ON "public"."users" FOR UPDATE USING (("auth"."uid"() = "id")) WITH CHECK (("auth"."uid"() = "id"));



CREATE POLICY "Users can create bookings" ON "public"."venue_bookings" FOR INSERT WITH CHECK (("auth"."uid"() = "booked_by"));



CREATE POLICY "Users can create comments" ON "public"."comments" FOR INSERT WITH CHECK (("auth"."uid"() = "author_id"));



CREATE POLICY "Users can create comments" ON "public"."post_comments__old" FOR INSERT WITH CHECK (("auth"."uid"() = "author_id"));



CREATE POLICY "Users can create friend requests" ON "public"."friendships" FOR INSERT WITH CHECK ((("auth"."uid"() = "initiated_by") AND ("auth"."uid"() = "user_id")));



CREATE POLICY "Users can create groups" ON "public"."community_groups" FOR INSERT WITH CHECK (("auth"."uid"() = "created_by"));



CREATE POLICY "Users can create posts" ON "public"."posts" FOR INSERT WITH CHECK (("auth"."uid"() = "author_id"));



CREATE POLICY "Users can create reviews for their bookings" ON "public"."venue_reviews" FOR INSERT WITH CHECK (("auth"."uid"() = "reviewer_id"));



CREATE POLICY "Users can create their own posts" ON "public"."posts" FOR INSERT WITH CHECK (("auth"."uid"() = "author_id"));



CREATE POLICY "Users can create their own reactions" ON "public"."reactions" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can delete own notifications" ON "public"."notifications" FOR DELETE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can delete their own comments" ON "public"."post_comments__old" FOR DELETE USING (("auth"."uid"() = "author_id"));



CREATE POLICY "Users can delete their own posts" ON "public"."posts" FOR DELETE USING (("auth"."uid"() = "author_id"));



CREATE POLICY "Users can delete their own reactions" ON "public"."reactions" FOR DELETE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can delete their own sessions" ON "public"."auth_sessions" FOR DELETE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can delete their own sports profiles" ON "public"."user_sports_profiles" FOR DELETE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can insert own notifications" ON "public"."notifications" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can insert their own preferences" ON "public"."user_preferences" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can insert their own privacy settings" ON "public"."privacy_settings" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can insert their own settings" ON "public"."user_settings" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can insert their own sports profiles" ON "public"."user_sports_profiles" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can like posts" ON "public"."post_likes" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can send messages to their conversations" ON "public"."messages" FOR INSERT WITH CHECK ((("auth"."uid"() = "sender_id") AND (EXISTS ( SELECT 1
   FROM "public"."conversation_participants" "cp"
  WHERE (("cp"."conversation_id" = "messages"."conversation_id") AND ("cp"."user_id" = "auth"."uid"()) AND ("cp"."left_at" IS NULL))))));



CREATE POLICY "Users can soft delete their own posts" ON "public"."posts" FOR DELETE USING (("auth"."uid"() = "author_id"));



CREATE POLICY "Users can unlike their own likes" ON "public"."post_likes" FOR DELETE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update own data" ON "public"."users" FOR UPDATE USING (("auth"."uid"() = "id"));



CREATE POLICY "Users can update own notifications" ON "public"."notifications" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their bookings" ON "public"."venue_bookings" FOR UPDATE USING ((("auth"."uid"() = "booked_by") AND ("status" = 'pending'::"text")));



CREATE POLICY "Users can update their friendships" ON "public"."friendships" FOR UPDATE USING ((("auth"."uid"() = "user_id") OR ("auth"."uid"() = "friend_id")));



CREATE POLICY "Users can update their own comments" ON "public"."comments" FOR UPDATE USING (("auth"."uid"() = "author_id"));



CREATE POLICY "Users can update their own comments" ON "public"."post_comments__old" FOR UPDATE USING (("auth"."uid"() = "author_id"));



CREATE POLICY "Users can update their own notifications" ON "public"."social_notifications" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own posts" ON "public"."posts" FOR UPDATE USING (("auth"."uid"() = "author_id"));



CREATE POLICY "Users can update their own preferences" ON "public"."user_preferences" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own privacy settings" ON "public"."privacy_settings" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own profile" ON "public"."users" FOR UPDATE USING (("auth"."uid"() = "id"));



CREATE POLICY "Users can update their own settings" ON "public"."user_settings" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own sports profiles" ON "public"."user_sports_profiles" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can update their own statistics" ON "public"."profile_statistics" FOR UPDATE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view anyone's statistics" ON "public"."profile_statistics" FOR SELECT USING (true);



CREATE POLICY "Users can view comments on visible posts" ON "public"."comments" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."posts" "p"
  WHERE (("p"."id" = "comments"."post_id") AND (("p"."visibility" = 'public'::"text") OR ("p"."author_id" = "auth"."uid"()) OR (("p"."visibility" = 'friends'::"text") AND (EXISTS ( SELECT 1
           FROM "public"."friendships"
          WHERE (("friendships"."status" = 'accepted'::"public"."friendship_status") AND ((("friendships"."user_id" = "auth"."uid"()) AND ("friendships"."friend_id" = "p"."author_id")) OR (("friendships"."friend_id" = "auth"."uid"()) AND ("friendships"."user_id" = "p"."author_id"))))))))))));



CREATE POLICY "Users can view messages in their conversations" ON "public"."messages" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."conversation_participants" "cp"
  WHERE (("cp"."conversation_id" = "messages"."conversation_id") AND ("cp"."user_id" = "auth"."uid"()) AND ("cp"."left_at" IS NULL)))));



CREATE POLICY "Users can view others completed achievements" ON "public"."user_achievements" FOR SELECT USING (("is_completed" = true));



CREATE POLICY "Users can view own data" ON "public"."users" FOR SELECT USING (("auth"."uid"() = "id"));



CREATE POLICY "Users can view own notifications" ON "public"."notifications" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view participants in their conversations" ON "public"."conversation_participants" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."conversation_participants" "cp"
  WHERE (("cp"."conversation_id" = "conversation_participants"."conversation_id") AND ("cp"."user_id" = "auth"."uid"()) AND ("cp"."left_at" IS NULL)))));



CREATE POLICY "Users can view phone numbers for matchmaking" ON "public"."users" FOR SELECT USING (true);



CREATE POLICY "Users can view reactions" ON "public"."reactions" FOR SELECT USING (true);



CREATE POLICY "Users can view their bookings" ON "public"."venue_bookings" FOR SELECT USING ((("auth"."uid"() = "booked_by") OR (EXISTS ( SELECT 1
   FROM "public"."games"
  WHERE (("games"."id" = "venue_bookings"."game_id") AND (("games"."organizer_id" = "auth"."uid"()) OR (EXISTS ( SELECT 1
           FROM "public"."game_players"
          WHERE (("game_players"."game_id" = "games"."id") AND ("game_players"."player_id" = "auth"."uid"()))))))))));



CREATE POLICY "Users can view their conversations" ON "public"."conversations" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."conversation_participants" "cp"
  WHERE (("cp"."conversation_id" = "conversations"."id") AND ("cp"."user_id" = "auth"."uid"()) AND ("cp"."left_at" IS NULL)))));



CREATE POLICY "Users can view their friendships" ON "public"."friendships" FOR SELECT USING ((("auth"."uid"() = "user_id") OR ("auth"."uid"() = "friend_id")));



CREATE POLICY "Users can view their own achievements" ON "public"."user_achievements" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own notifications" ON "public"."social_notifications" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own posts" ON "public"."posts" FOR SELECT USING (("auth"."uid"() = "author_id"));



CREATE POLICY "Users can view their own preferences" ON "public"."user_preferences" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own privacy settings" ON "public"."privacy_settings" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own sessions" ON "public"."auth_sessions" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own settings" ON "public"."user_settings" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view their own sports profiles" ON "public"."user_sports_profiles" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users update their notifications" ON "public"."game_notifications" FOR UPDATE USING (("auth"."uid"() = "recipient_id"));



CREATE POLICY "Users view their notifications" ON "public"."game_notifications" FOR SELECT USING (("auth"."uid"() = "recipient_id"));



CREATE POLICY "View check-ins" ON "public"."game_check_ins" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."game_players"
  WHERE (("game_players"."game_id" = "game_check_ins"."game_id") AND ("game_players"."player_id" = "auth"."uid"())))));



CREATE POLICY "View game sessions" ON "public"."game_sessions" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."games"
  WHERE (("games"."id" = "game_sessions"."game_id") AND (("games"."is_public" = true) OR ("games"."organizer_id" = "auth"."uid"()) OR (EXISTS ( SELECT 1
           FROM "public"."game_players"
          WHERE (("game_players"."game_id" = "games"."id") AND ("game_players"."player_id" = "auth"."uid"())))))))));



CREATE POLICY "View own ratings" ON "public"."player_ratings" FOR SELECT USING ((("auth"."uid"() = "rated_player_id") OR ("auth"."uid"() = "rater_id")));



CREATE POLICY "audit_select_own" ON "public"."profile_audit_log" FOR SELECT TO "authenticated", "anon" USING (("user_id" = "auth"."uid"()));



ALTER TABLE "public"."auth_sessions" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."comments" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "comments_insert_author" ON "public"."comments" FOR INSERT WITH CHECK (("auth"."uid"() = "author_id"));



CREATE POLICY "comments_insert_own" ON "public"."comments" FOR INSERT TO "authenticated" WITH CHECK (("author_id" = "auth"."uid"()));



CREATE POLICY "comments_select_scoped" ON "public"."comments" FOR SELECT USING ((("auth"."uid"() = "author_id") OR (EXISTS ( SELECT 1
   FROM "public"."posts" "p"
  WHERE (("p"."id" = "comments"."post_id") AND (COALESCE("p"."is_deleted", false) = false) AND (("p"."visibility" = 'public'::"text") OR (("p"."visibility" = 'friends'::"text") AND (EXISTS ( SELECT 1
           FROM "public"."friendships" "f"
          WHERE (("f"."status" = 'accepted'::"public"."friendship_status") AND ((("f"."user_id" = "p"."author_id") AND ("f"."friend_id" = "auth"."uid"())) OR (("f"."friend_id" = "p"."author_id") AND ("f"."user_id" = "auth"."uid"()))))))) OR ("p"."author_id" = "auth"."uid"())))))));



CREATE POLICY "comments_select_visible" ON "public"."comments" FOR SELECT TO "authenticated", "anon" USING (((NOT "is_deleted") OR ("author_id" = "auth"."uid"())));



CREATE POLICY "comments_update_author" ON "public"."comments" FOR UPDATE USING (("auth"."uid"() = "author_id")) WITH CHECK (("auth"."uid"() = "author_id"));



CREATE POLICY "comments_update_own" ON "public"."comments" FOR UPDATE TO "authenticated" USING (("author_id" = "auth"."uid"())) WITH CHECK (("author_id" = "auth"."uid"()));



ALTER TABLE "public"."community_groups" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."conversation_participants" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."conversations" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."friendships" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."game_check_ins" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."game_invitations" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."game_notifications" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."game_players" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."game_sessions" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."games" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "games_insert_organizer" ON "public"."games" FOR INSERT WITH CHECK (("auth"."uid"() = "organizer_id"));



CREATE POLICY "games_select_scoped" ON "public"."games" FOR SELECT USING ((("is_public" = true) OR ("auth"."uid"() = "organizer_id")));



CREATE POLICY "games_update_organizer" ON "public"."games" FOR UPDATE USING (("auth"."uid"() = "organizer_id")) WITH CHECK (("auth"."uid"() = "organizer_id"));



ALTER TABLE "public"."group_members" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "lb_entries_select_all" ON "public"."leaderboard_entries" FOR SELECT TO "authenticated", "anon" USING (true);



CREATE POLICY "lb_insert_service" ON "public"."leaderboards" FOR INSERT TO "service_role" WITH CHECK (true);



CREATE POLICY "lb_select_all" ON "public"."leaderboards" FOR SELECT USING (true);



CREATE POLICY "lb_update_service" ON "public"."leaderboards" FOR UPDATE TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "lbe_insert_service" ON "public"."leaderboard_entries" FOR INSERT TO "service_role" WITH CHECK (true);



CREATE POLICY "lbe_select_all" ON "public"."leaderboard_entries" FOR SELECT USING (true);



CREATE POLICY "lbe_update_service" ON "public"."leaderboard_entries" FOR UPDATE TO "service_role" USING (true) WITH CHECK (true);



ALTER TABLE "public"."leaderboard_entries" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."leaderboards" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."messages" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "notif_insert_service" ON "public"."notifications_unified" FOR INSERT TO "service_role" WITH CHECK (true);



CREATE POLICY "notif_select_scoped" ON "public"."notifications_unified" FOR SELECT USING ((("user_id" IS NULL) OR ("user_id" = "auth"."uid"())));



CREATE POLICY "notif_update_owner" ON "public"."notifications_unified" FOR UPDATE USING (("user_id" = "auth"."uid"())) WITH CHECK (("user_id" = "auth"."uid"()));



ALTER TABLE "public"."notifications" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."notifications_unified" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "nu_select_own" ON "public"."notifications_unified" FOR SELECT TO "authenticated", "anon" USING (("user_id" = "auth"."uid"()));



CREATE POLICY "nu_update_own" ON "public"."notifications_unified" FOR UPDATE TO "authenticated" USING (("user_id" = "auth"."uid"())) WITH CHECK (("user_id" = "auth"."uid"()));



ALTER TABLE "public"."password_reset_attempts" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."player_ratings" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."post_comments__old" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."post_likes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."posts" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "posts_insert_author" ON "public"."posts" FOR INSERT WITH CHECK (("auth"."uid"() = "author_id"));



CREATE POLICY "posts_select_friends" ON "public"."posts" FOR SELECT USING ((("auth"."uid"() = "author_id") OR ((COALESCE("is_deleted", false) = false) AND ("visibility" = 'friends'::"text") AND (EXISTS ( SELECT 1
   FROM "public"."friendships" "f"
  WHERE (("f"."status" = 'accepted'::"public"."friendship_status") AND ((("f"."user_id" = "posts"."author_id") AND ("f"."friend_id" = "auth"."uid"())) OR (("f"."friend_id" = "posts"."author_id") AND ("f"."user_id" = "auth"."uid"())))))))));



CREATE POLICY "posts_select_scoped" ON "public"."posts" FOR SELECT USING ((((COALESCE("is_deleted", false) = false) AND ("visibility" = 'public'::"text")) OR ("auth"."uid"() = "author_id")));



CREATE POLICY "posts_update_author" ON "public"."posts" FOR UPDATE USING (("auth"."uid"() = "author_id")) WITH CHECK (("auth"."uid"() = "author_id"));



CREATE POLICY "prefs_insert_owner" ON "public"."user_preferences" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "prefs_select_owner" ON "public"."user_preferences" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "prefs_update_owner" ON "public"."user_preferences" FOR UPDATE USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "privacy_insert_owner" ON "public"."privacy_settings" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "privacy_select_owner" ON "public"."privacy_settings" FOR SELECT USING (("auth"."uid"() = "user_id"));



ALTER TABLE "public"."privacy_settings" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "privacy_settings_delete_own" ON "public"."privacy_settings" FOR DELETE TO "authenticated" USING (("user_id" = "auth"."uid"()));



CREATE POLICY "privacy_settings_insert_own" ON "public"."privacy_settings" FOR INSERT TO "authenticated" WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "privacy_settings_select_own" ON "public"."privacy_settings" FOR SELECT TO "authenticated" USING (("user_id" = "auth"."uid"()));



CREATE POLICY "privacy_settings_update_own" ON "public"."privacy_settings" FOR UPDATE TO "authenticated" USING (("user_id" = "auth"."uid"())) WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "privacy_update_owner" ON "public"."privacy_settings" FOR UPDATE USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));



ALTER TABLE "public"."profile_audit_log" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."profile_feature_flags" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."profile_metrics" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."profile_statistics" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "ps_self_rw" ON "public"."privacy_settings" USING ((EXISTS ( SELECT 1
   FROM "public"."users" "u"
  WHERE (("u"."id" = "privacy_settings"."user_id") AND ("u"."auth_id" = "auth"."uid"()))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."users" "u"
  WHERE (("u"."id" = "privacy_settings"."user_id") AND ("u"."auth_id" = "auth"."uid"())))));



ALTER TABLE "public"."reactions" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "reactions_delete_own" ON "public"."reactions" FOR DELETE TO "authenticated" USING (("user_id" = "auth"."uid"()));



CREATE POLICY "reactions_insert_own" ON "public"."reactions" FOR INSERT TO "authenticated" WITH CHECK ((("user_id" = "auth"."uid"()) AND ((("post_id" IS NOT NULL) AND ("comment_id" IS NULL)) OR (("comment_id" IS NOT NULL) AND ("post_id" IS NULL)))));



CREATE POLICY "reactions_select_visible" ON "public"."reactions" FOR SELECT TO "authenticated", "anon" USING (true);



ALTER TABLE "public"."reactions_unified" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "reactions_update_own" ON "public"."reactions" FOR UPDATE TO "authenticated" USING (("user_id" = "auth"."uid"())) WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "ru_delete_own" ON "public"."reactions_unified" FOR DELETE TO "authenticated" USING (("user_id" = "auth"."uid"()));



CREATE POLICY "ru_insert_own" ON "public"."reactions_unified" FOR INSERT TO "authenticated" WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "ru_select_all" ON "public"."reactions_unified" FOR SELECT TO "authenticated", "anon" USING (true);



ALTER TABLE "public"."skill_levels" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."social_metrics" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."social_notifications" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."sports" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "up_self_rw" ON "public"."user_preferences" USING ((EXISTS ( SELECT 1
   FROM "public"."users" "u"
  WHERE (("u"."id" = "user_preferences"."user_id") AND ("u"."auth_id" = "auth"."uid"()))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."users" "u"
  WHERE (("u"."id" = "user_preferences"."user_id") AND ("u"."auth_id" = "auth"."uid"())))));



CREATE POLICY "us_self_rw" ON "public"."user_settings" USING ((EXISTS ( SELECT 1
   FROM "public"."users" "u"
  WHERE (("u"."id" = "user_settings"."user_id") AND ("u"."auth_id" = "auth"."uid"()))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."users" "u"
  WHERE (("u"."id" = "user_settings"."user_id") AND ("u"."auth_id" = "auth"."uid"())))));



ALTER TABLE "public"."user_achievements" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."user_feed_cache" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."user_preferences" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "user_preferences_delete_own" ON "public"."user_preferences" FOR DELETE TO "authenticated" USING (("user_id" = "auth"."uid"()));



CREATE POLICY "user_preferences_insert_own" ON "public"."user_preferences" FOR INSERT TO "authenticated" WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "user_preferences_select_own" ON "public"."user_preferences" FOR SELECT TO "authenticated" USING (("user_id" = "auth"."uid"()));



CREATE POLICY "user_preferences_update_own" ON "public"."user_preferences" FOR UPDATE TO "authenticated" USING (("user_id" = "auth"."uid"())) WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "user_self_access" ON "public"."users" USING (("auth_id" = "auth"."uid"())) WITH CHECK (("auth_id" = "auth"."uid"()));



ALTER TABLE "public"."user_settings" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "user_settings_delete_own" ON "public"."user_settings" FOR DELETE TO "authenticated" USING (("user_id" = "auth"."uid"()));



CREATE POLICY "user_settings_insert_own" ON "public"."user_settings" FOR INSERT TO "authenticated" WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "user_settings_select_own" ON "public"."user_settings" FOR SELECT TO "authenticated" USING (("user_id" = "auth"."uid"()));



CREATE POLICY "user_settings_update_own" ON "public"."user_settings" FOR UPDATE TO "authenticated" USING (("user_id" = "auth"."uid"())) WITH CHECK (("user_id" = "auth"."uid"()));



ALTER TABLE "public"."user_sports_profiles" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."users" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "users_delete_own" ON "public"."users" FOR DELETE TO "authenticated" USING (("id" = "auth"."uid"()));



CREATE POLICY "users_insert_self" ON "public"."users" FOR INSERT WITH CHECK (("auth"."uid"() = "id"));



CREATE POLICY "users_select_all_public" ON "public"."users" FOR SELECT USING (true);



CREATE POLICY "users_select_own" ON "public"."users" FOR SELECT TO "authenticated" USING (("id" = "auth"."uid"()));



CREATE POLICY "users_update_own" ON "public"."users" FOR UPDATE TO "authenticated" USING (("id" = "auth"."uid"())) WITH CHECK (("id" = "auth"."uid"()));



CREATE POLICY "users_update_self" ON "public"."users" FOR UPDATE USING (("auth"."uid"() = "id")) WITH CHECK (("auth"."uid"() = "id"));



CREATE POLICY "usettings_insert_owner" ON "public"."user_settings" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "usettings_select_owner" ON "public"."user_settings" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "usettings_update_owner" ON "public"."user_settings" FOR UPDATE USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));



ALTER TABLE "public"."venue_amenities" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."venue_bookings" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."venue_images" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."venue_reviews" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."venue_sports" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."venue_time_slots" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."venues" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";






ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."users";






GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";



GRANT ALL ON FUNCTION "public"."citextin"("cstring") TO "postgres";
GRANT ALL ON FUNCTION "public"."citextin"("cstring") TO "anon";
GRANT ALL ON FUNCTION "public"."citextin"("cstring") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citextin"("cstring") TO "service_role";



GRANT ALL ON FUNCTION "public"."citextout"("public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."citextout"("public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."citextout"("public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citextout"("public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."citextrecv"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."citextrecv"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."citextrecv"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citextrecv"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."citextsend"("public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."citextsend"("public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."citextsend"("public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citextsend"("public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbtreekey16_in"("cstring") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbtreekey16_in"("cstring") TO "anon";
GRANT ALL ON FUNCTION "public"."gbtreekey16_in"("cstring") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbtreekey16_in"("cstring") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbtreekey16_out"("public"."gbtreekey16") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbtreekey16_out"("public"."gbtreekey16") TO "anon";
GRANT ALL ON FUNCTION "public"."gbtreekey16_out"("public"."gbtreekey16") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbtreekey16_out"("public"."gbtreekey16") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbtreekey2_in"("cstring") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbtreekey2_in"("cstring") TO "anon";
GRANT ALL ON FUNCTION "public"."gbtreekey2_in"("cstring") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbtreekey2_in"("cstring") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbtreekey2_out"("public"."gbtreekey2") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbtreekey2_out"("public"."gbtreekey2") TO "anon";
GRANT ALL ON FUNCTION "public"."gbtreekey2_out"("public"."gbtreekey2") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbtreekey2_out"("public"."gbtreekey2") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbtreekey32_in"("cstring") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbtreekey32_in"("cstring") TO "anon";
GRANT ALL ON FUNCTION "public"."gbtreekey32_in"("cstring") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbtreekey32_in"("cstring") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbtreekey32_out"("public"."gbtreekey32") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbtreekey32_out"("public"."gbtreekey32") TO "anon";
GRANT ALL ON FUNCTION "public"."gbtreekey32_out"("public"."gbtreekey32") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbtreekey32_out"("public"."gbtreekey32") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbtreekey4_in"("cstring") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbtreekey4_in"("cstring") TO "anon";
GRANT ALL ON FUNCTION "public"."gbtreekey4_in"("cstring") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbtreekey4_in"("cstring") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbtreekey4_out"("public"."gbtreekey4") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbtreekey4_out"("public"."gbtreekey4") TO "anon";
GRANT ALL ON FUNCTION "public"."gbtreekey4_out"("public"."gbtreekey4") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbtreekey4_out"("public"."gbtreekey4") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbtreekey8_in"("cstring") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbtreekey8_in"("cstring") TO "anon";
GRANT ALL ON FUNCTION "public"."gbtreekey8_in"("cstring") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbtreekey8_in"("cstring") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbtreekey8_out"("public"."gbtreekey8") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbtreekey8_out"("public"."gbtreekey8") TO "anon";
GRANT ALL ON FUNCTION "public"."gbtreekey8_out"("public"."gbtreekey8") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbtreekey8_out"("public"."gbtreekey8") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbtreekey_var_in"("cstring") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbtreekey_var_in"("cstring") TO "anon";
GRANT ALL ON FUNCTION "public"."gbtreekey_var_in"("cstring") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbtreekey_var_in"("cstring") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbtreekey_var_out"("public"."gbtreekey_var") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbtreekey_var_out"("public"."gbtreekey_var") TO "anon";
GRANT ALL ON FUNCTION "public"."gbtreekey_var_out"("public"."gbtreekey_var") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbtreekey_var_out"("public"."gbtreekey_var") TO "service_role";



GRANT ALL ON FUNCTION "public"."citext"(boolean) TO "postgres";
GRANT ALL ON FUNCTION "public"."citext"(boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."citext"(boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."citext"(boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."citext"(character) TO "postgres";
GRANT ALL ON FUNCTION "public"."citext"(character) TO "anon";
GRANT ALL ON FUNCTION "public"."citext"(character) TO "authenticated";
GRANT ALL ON FUNCTION "public"."citext"(character) TO "service_role";



GRANT ALL ON FUNCTION "public"."citext"("inet") TO "postgres";
GRANT ALL ON FUNCTION "public"."citext"("inet") TO "anon";
GRANT ALL ON FUNCTION "public"."citext"("inet") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citext"("inet") TO "service_role";














































































































































































GRANT ALL ON FUNCTION "public"."_col_exists"("p_table" "text", "p_col" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."_col_exists"("p_table" "text", "p_col" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_col_exists"("p_table" "text", "p_col" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."_comments_parent_same_post_fn"() TO "anon";
GRANT ALL ON FUNCTION "public"."_comments_parent_same_post_fn"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."_comments_parent_same_post_fn"() TO "service_role";



GRANT ALL ON FUNCTION "public"."_post_comments_del_fn"() TO "anon";
GRANT ALL ON FUNCTION "public"."_post_comments_del_fn"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."_post_comments_del_fn"() TO "service_role";



GRANT ALL ON FUNCTION "public"."_post_comments_ins_fn"() TO "anon";
GRANT ALL ON FUNCTION "public"."_post_comments_ins_fn"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."_post_comments_ins_fn"() TO "service_role";



GRANT ALL ON FUNCTION "public"."_post_comments_upd_fn"() TO "anon";
GRANT ALL ON FUNCTION "public"."_post_comments_upd_fn"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."_post_comments_upd_fn"() TO "service_role";



GRANT ALL ON FUNCTION "public"."_ru_sync_comment_likes"() TO "anon";
GRANT ALL ON FUNCTION "public"."_ru_sync_comment_likes"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."_ru_sync_comment_likes"() TO "service_role";



GRANT ALL ON FUNCTION "public"."_ru_sync_post_likes"() TO "anon";
GRANT ALL ON FUNCTION "public"."_ru_sync_post_likes"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."_ru_sync_post_likes"() TO "service_role";



GRANT ALL ON FUNCTION "public"."_table_exists"("p_table" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."_table_exists"("p_table" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."_table_exists"("p_table" "text") TO "service_role";



REVOKE ALL ON FUNCTION "public"."analytics_dashboard"("p_start" "date", "p_end" "date", "p_top_posts_limit" integer) FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."analytics_dashboard"("p_start" "date", "p_end" "date", "p_top_posts_limit" integer) TO "service_role";
GRANT ALL ON FUNCTION "public"."analytics_dashboard"("p_start" "date", "p_end" "date", "p_top_posts_limit" integer) TO "authenticated";



GRANT ALL ON FUNCTION "public"."award_badge"("p_user_id" "uuid", "p_achievement_id" "uuid", "p_tier" "public"."badge_tier") TO "anon";
GRANT ALL ON FUNCTION "public"."award_badge"("p_user_id" "uuid", "p_achievement_id" "uuid", "p_tier" "public"."badge_tier") TO "authenticated";
GRANT ALL ON FUNCTION "public"."award_badge"("p_user_id" "uuid", "p_achievement_id" "uuid", "p_tier" "public"."badge_tier") TO "service_role";



GRANT ALL ON TABLE "public"."point_transactions" TO "anon";
GRANT ALL ON TABLE "public"."point_transactions" TO "authenticated";
GRANT ALL ON TABLE "public"."point_transactions" TO "service_role";



GRANT ALL ON FUNCTION "public"."award_points"("p_user_id" "uuid", "p_type" "public"."point_transaction_type", "p_base_points" integer, "p_description" "text", "p_achievement_id" "uuid", "p_game_id" "uuid", "p_metadata" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."award_points"("p_user_id" "uuid", "p_type" "public"."point_transaction_type", "p_base_points" integer, "p_description" "text", "p_achievement_id" "uuid", "p_game_id" "uuid", "p_metadata" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."award_points"("p_user_id" "uuid", "p_type" "public"."point_transaction_type", "p_base_points" integer, "p_description" "text", "p_achievement_id" "uuid", "p_game_id" "uuid", "p_metadata" "jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."batch_track_achievements"("p_events" "jsonb"[]) TO "anon";
GRANT ALL ON FUNCTION "public"."batch_track_achievements"("p_events" "jsonb"[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."batch_track_achievements"("p_events" "jsonb"[]) TO "service_role";



GRANT ALL ON FUNCTION "public"."calculate_achievement_progress_percentage"("p_criteria" "jsonb", "p_progress" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."calculate_achievement_progress_percentage"("p_criteria" "jsonb", "p_progress" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."calculate_achievement_progress_percentage"("p_criteria" "jsonb", "p_progress" "jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."calculate_profile_completion"("user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."calculate_profile_completion"("user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."calculate_profile_completion"("user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."cash_dist"("money", "money") TO "postgres";
GRANT ALL ON FUNCTION "public"."cash_dist"("money", "money") TO "anon";
GRANT ALL ON FUNCTION "public"."cash_dist"("money", "money") TO "authenticated";
GRANT ALL ON FUNCTION "public"."cash_dist"("money", "money") TO "service_role";



GRANT ALL ON FUNCTION "public"."check_achievement_completion"("p_criteria" "jsonb", "p_progress" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."check_achievement_completion"("p_criteria" "jsonb", "p_progress" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."check_achievement_completion"("p_criteria" "jsonb", "p_progress" "jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."check_booking_conflict"("p_venue_id" "uuid", "p_booking_date" "date", "p_start_time" time without time zone, "p_end_time" time without time zone, "p_court_number" integer, "p_exclude_booking_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."check_booking_conflict"("p_venue_id" "uuid", "p_booking_date" "date", "p_start_time" time without time zone, "p_end_time" time without time zone, "p_court_number" integer, "p_exclude_booking_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."check_booking_conflict"("p_venue_id" "uuid", "p_booking_date" "date", "p_start_time" time without time zone, "p_end_time" time without time zone, "p_court_number" integer, "p_exclude_booking_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."citext_cmp"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."citext_cmp"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."citext_cmp"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citext_cmp"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."citext_eq"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."citext_eq"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."citext_eq"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citext_eq"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."citext_ge"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."citext_ge"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."citext_ge"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citext_ge"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."citext_gt"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."citext_gt"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."citext_gt"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citext_gt"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."citext_hash"("public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."citext_hash"("public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."citext_hash"("public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citext_hash"("public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."citext_hash_extended"("public"."citext", bigint) TO "postgres";
GRANT ALL ON FUNCTION "public"."citext_hash_extended"("public"."citext", bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."citext_hash_extended"("public"."citext", bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."citext_hash_extended"("public"."citext", bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."citext_larger"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."citext_larger"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."citext_larger"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citext_larger"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."citext_le"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."citext_le"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."citext_le"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citext_le"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."citext_lt"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."citext_lt"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."citext_lt"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citext_lt"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."citext_ne"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."citext_ne"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."citext_ne"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citext_ne"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."citext_pattern_cmp"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."citext_pattern_cmp"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."citext_pattern_cmp"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citext_pattern_cmp"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."citext_pattern_ge"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."citext_pattern_ge"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."citext_pattern_ge"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citext_pattern_ge"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."citext_pattern_gt"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."citext_pattern_gt"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."citext_pattern_gt"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citext_pattern_gt"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."citext_pattern_le"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."citext_pattern_le"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."citext_pattern_le"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citext_pattern_le"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."citext_pattern_lt"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."citext_pattern_lt"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."citext_pattern_lt"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citext_pattern_lt"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."citext_smaller"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."citext_smaller"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."citext_smaller"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."citext_smaller"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."cleanup_expired_password_resets"() TO "anon";
GRANT ALL ON FUNCTION "public"."cleanup_expired_password_resets"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."cleanup_expired_password_resets"() TO "service_role";



GRANT ALL ON FUNCTION "public"."cleanup_old_notifications"() TO "anon";
GRANT ALL ON FUNCTION "public"."cleanup_old_notifications"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."cleanup_old_notifications"() TO "service_role";



GRANT ALL ON FUNCTION "public"."cleanup_rewards_data"() TO "anon";
GRANT ALL ON FUNCTION "public"."cleanup_rewards_data"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."cleanup_rewards_data"() TO "service_role";



GRANT ALL ON FUNCTION "public"."collect_daily_achievement_metrics"() TO "anon";
GRANT ALL ON FUNCTION "public"."collect_daily_achievement_metrics"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."collect_daily_achievement_metrics"() TO "service_role";



GRANT ALL ON FUNCTION "public"."collect_profile_metrics"() TO "anon";
GRANT ALL ON FUNCTION "public"."collect_profile_metrics"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."collect_profile_metrics"() TO "service_role";



GRANT ALL ON FUNCTION "public"."collect_social_metrics"() TO "anon";
GRANT ALL ON FUNCTION "public"."collect_social_metrics"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."collect_social_metrics"() TO "service_role";



GRANT ALL ON FUNCTION "public"."confirm_user_phone"("p_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."confirm_user_phone"("p_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."confirm_user_phone"("p_user_id" "uuid") TO "service_role";



GRANT ALL ON TABLE "public"."friendships" TO "anon";
GRANT ALL ON TABLE "public"."friendships" TO "authenticated";
GRANT ALL ON TABLE "public"."friendships" TO "service_role";



GRANT ALL ON FUNCTION "public"."create_friendship_request"("p_friend_id" "uuid", "p_message" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."create_friendship_request"("p_friend_id" "uuid", "p_message" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_friendship_request"("p_friend_id" "uuid", "p_message" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."create_social_notification"("p_user_id" "uuid", "p_type" "text", "p_title" "text", "p_body" "text", "p_actor_id" "uuid", "p_post_id" "uuid", "p_comment_id" "uuid", "p_friendship_id" "uuid", "p_conversation_id" "uuid", "p_data" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."create_social_notification"("p_user_id" "uuid", "p_type" "text", "p_title" "text", "p_body" "text", "p_actor_id" "uuid", "p_post_id" "uuid", "p_comment_id" "uuid", "p_friendship_id" "uuid", "p_conversation_id" "uuid", "p_data" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_social_notification"("p_user_id" "uuid", "p_type" "text", "p_title" "text", "p_body" "text", "p_actor_id" "uuid", "p_post_id" "uuid", "p_comment_id" "uuid", "p_friendship_id" "uuid", "p_conversation_id" "uuid", "p_data" "jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."create_social_notification_trigger"() TO "anon";
GRANT ALL ON FUNCTION "public"."create_social_notification_trigger"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_social_notification_trigger"() TO "service_role";



GRANT ALL ON FUNCTION "public"."date_dist"("date", "date") TO "postgres";
GRANT ALL ON FUNCTION "public"."date_dist"("date", "date") TO "anon";
GRANT ALL ON FUNCTION "public"."date_dist"("date", "date") TO "authenticated";
GRANT ALL ON FUNCTION "public"."date_dist"("date", "date") TO "service_role";



GRANT ALL ON FUNCTION "public"."decrement_comments_count"("post_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."decrement_comments_count"("post_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."decrement_comments_count"("post_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."decrement_likes_count"("post_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."decrement_likes_count"("post_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."decrement_likes_count"("post_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."fanout_urgent_notifications"() TO "anon";
GRANT ALL ON FUNCTION "public"."fanout_urgent_notifications"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."fanout_urgent_notifications"() TO "service_role";



GRANT ALL ON FUNCTION "public"."float4_dist"(real, real) TO "postgres";
GRANT ALL ON FUNCTION "public"."float4_dist"(real, real) TO "anon";
GRANT ALL ON FUNCTION "public"."float4_dist"(real, real) TO "authenticated";
GRANT ALL ON FUNCTION "public"."float4_dist"(real, real) TO "service_role";



GRANT ALL ON FUNCTION "public"."float8_dist"(double precision, double precision) TO "postgres";
GRANT ALL ON FUNCTION "public"."float8_dist"(double precision, double precision) TO "anon";
GRANT ALL ON FUNCTION "public"."float8_dist"(double precision, double precision) TO "authenticated";
GRANT ALL ON FUNCTION "public"."float8_dist"(double precision, double precision) TO "service_role";



GRANT ALL ON FUNCTION "public"."fn_profile_audit"() TO "anon";
GRANT ALL ON FUNCTION "public"."fn_profile_audit"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."fn_profile_audit"() TO "service_role";



GRANT ALL ON FUNCTION "public"."friend_authors_for_viewer"("p_viewer" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."friend_authors_for_viewer"("p_viewer" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."friend_authors_for_viewer"("p_viewer" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bit_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bit_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bit_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bit_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bit_consistent"("internal", bit, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bit_consistent"("internal", bit, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bit_consistent"("internal", bit, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bit_consistent"("internal", bit, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bit_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bit_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bit_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bit_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bit_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bit_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bit_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bit_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bit_same"("public"."gbtreekey_var", "public"."gbtreekey_var", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bit_same"("public"."gbtreekey_var", "public"."gbtreekey_var", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bit_same"("public"."gbtreekey_var", "public"."gbtreekey_var", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bit_same"("public"."gbtreekey_var", "public"."gbtreekey_var", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bit_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bit_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bit_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bit_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bool_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bool_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bool_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bool_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bool_consistent"("internal", boolean, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bool_consistent"("internal", boolean, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bool_consistent"("internal", boolean, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bool_consistent"("internal", boolean, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bool_fetch"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bool_fetch"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bool_fetch"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bool_fetch"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bool_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bool_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bool_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bool_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bool_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bool_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bool_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bool_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bool_same"("public"."gbtreekey2", "public"."gbtreekey2", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bool_same"("public"."gbtreekey2", "public"."gbtreekey2", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bool_same"("public"."gbtreekey2", "public"."gbtreekey2", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bool_same"("public"."gbtreekey2", "public"."gbtreekey2", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bool_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bool_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bool_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bool_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bpchar_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bpchar_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bpchar_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bpchar_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bpchar_consistent"("internal", character, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bpchar_consistent"("internal", character, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bpchar_consistent"("internal", character, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bpchar_consistent"("internal", character, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bytea_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bytea_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bytea_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bytea_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bytea_consistent"("internal", "bytea", smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bytea_consistent"("internal", "bytea", smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bytea_consistent"("internal", "bytea", smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bytea_consistent"("internal", "bytea", smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bytea_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bytea_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bytea_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bytea_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bytea_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bytea_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bytea_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bytea_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bytea_same"("public"."gbtreekey_var", "public"."gbtreekey_var", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bytea_same"("public"."gbtreekey_var", "public"."gbtreekey_var", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bytea_same"("public"."gbtreekey_var", "public"."gbtreekey_var", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bytea_same"("public"."gbtreekey_var", "public"."gbtreekey_var", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_bytea_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_bytea_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_bytea_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_bytea_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_cash_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_cash_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_cash_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_cash_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_cash_consistent"("internal", "money", smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_cash_consistent"("internal", "money", smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_cash_consistent"("internal", "money", smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_cash_consistent"("internal", "money", smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_cash_distance"("internal", "money", smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_cash_distance"("internal", "money", smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_cash_distance"("internal", "money", smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_cash_distance"("internal", "money", smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_cash_fetch"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_cash_fetch"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_cash_fetch"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_cash_fetch"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_cash_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_cash_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_cash_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_cash_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_cash_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_cash_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_cash_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_cash_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_cash_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_cash_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_cash_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_cash_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_cash_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_cash_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_cash_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_cash_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_date_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_date_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_date_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_date_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_date_consistent"("internal", "date", smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_date_consistent"("internal", "date", smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_date_consistent"("internal", "date", smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_date_consistent"("internal", "date", smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_date_distance"("internal", "date", smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_date_distance"("internal", "date", smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_date_distance"("internal", "date", smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_date_distance"("internal", "date", smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_date_fetch"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_date_fetch"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_date_fetch"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_date_fetch"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_date_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_date_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_date_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_date_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_date_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_date_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_date_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_date_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_date_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_date_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_date_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_date_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_date_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_date_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_date_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_date_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_decompress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_decompress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_decompress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_decompress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_enum_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_enum_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_enum_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_enum_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_enum_consistent"("internal", "anyenum", smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_enum_consistent"("internal", "anyenum", smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_enum_consistent"("internal", "anyenum", smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_enum_consistent"("internal", "anyenum", smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_enum_fetch"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_enum_fetch"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_enum_fetch"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_enum_fetch"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_enum_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_enum_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_enum_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_enum_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_enum_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_enum_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_enum_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_enum_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_enum_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_enum_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_enum_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_enum_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_enum_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_enum_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_enum_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_enum_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_float4_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_float4_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_float4_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_float4_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_float4_consistent"("internal", real, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_float4_consistent"("internal", real, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_float4_consistent"("internal", real, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_float4_consistent"("internal", real, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_float4_distance"("internal", real, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_float4_distance"("internal", real, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_float4_distance"("internal", real, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_float4_distance"("internal", real, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_float4_fetch"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_float4_fetch"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_float4_fetch"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_float4_fetch"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_float4_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_float4_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_float4_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_float4_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_float4_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_float4_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_float4_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_float4_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_float4_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_float4_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_float4_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_float4_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_float4_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_float4_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_float4_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_float4_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_float8_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_float8_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_float8_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_float8_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_float8_consistent"("internal", double precision, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_float8_consistent"("internal", double precision, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_float8_consistent"("internal", double precision, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_float8_consistent"("internal", double precision, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_float8_distance"("internal", double precision, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_float8_distance"("internal", double precision, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_float8_distance"("internal", double precision, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_float8_distance"("internal", double precision, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_float8_fetch"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_float8_fetch"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_float8_fetch"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_float8_fetch"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_float8_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_float8_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_float8_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_float8_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_float8_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_float8_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_float8_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_float8_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_float8_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_float8_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_float8_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_float8_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_float8_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_float8_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_float8_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_float8_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_inet_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_inet_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_inet_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_inet_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_inet_consistent"("internal", "inet", smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_inet_consistent"("internal", "inet", smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_inet_consistent"("internal", "inet", smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_inet_consistent"("internal", "inet", smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_inet_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_inet_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_inet_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_inet_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_inet_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_inet_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_inet_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_inet_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_inet_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_inet_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_inet_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_inet_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_inet_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_inet_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_inet_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_inet_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int2_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int2_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int2_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int2_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int2_consistent"("internal", smallint, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int2_consistent"("internal", smallint, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int2_consistent"("internal", smallint, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int2_consistent"("internal", smallint, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int2_distance"("internal", smallint, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int2_distance"("internal", smallint, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int2_distance"("internal", smallint, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int2_distance"("internal", smallint, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int2_fetch"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int2_fetch"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int2_fetch"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int2_fetch"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int2_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int2_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int2_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int2_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int2_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int2_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int2_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int2_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int2_same"("public"."gbtreekey4", "public"."gbtreekey4", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int2_same"("public"."gbtreekey4", "public"."gbtreekey4", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int2_same"("public"."gbtreekey4", "public"."gbtreekey4", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int2_same"("public"."gbtreekey4", "public"."gbtreekey4", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int2_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int2_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int2_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int2_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int4_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int4_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int4_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int4_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int4_consistent"("internal", integer, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int4_consistent"("internal", integer, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int4_consistent"("internal", integer, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int4_consistent"("internal", integer, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int4_distance"("internal", integer, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int4_distance"("internal", integer, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int4_distance"("internal", integer, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int4_distance"("internal", integer, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int4_fetch"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int4_fetch"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int4_fetch"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int4_fetch"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int4_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int4_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int4_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int4_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int4_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int4_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int4_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int4_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int4_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int4_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int4_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int4_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int4_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int4_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int4_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int4_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int8_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int8_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int8_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int8_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int8_consistent"("internal", bigint, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int8_consistent"("internal", bigint, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int8_consistent"("internal", bigint, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int8_consistent"("internal", bigint, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int8_distance"("internal", bigint, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int8_distance"("internal", bigint, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int8_distance"("internal", bigint, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int8_distance"("internal", bigint, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int8_fetch"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int8_fetch"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int8_fetch"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int8_fetch"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int8_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int8_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int8_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int8_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int8_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int8_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int8_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int8_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int8_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int8_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int8_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int8_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_int8_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_int8_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_int8_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_int8_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_intv_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_intv_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_intv_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_intv_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_intv_consistent"("internal", interval, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_intv_consistent"("internal", interval, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_intv_consistent"("internal", interval, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_intv_consistent"("internal", interval, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_intv_decompress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_intv_decompress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_intv_decompress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_intv_decompress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_intv_distance"("internal", interval, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_intv_distance"("internal", interval, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_intv_distance"("internal", interval, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_intv_distance"("internal", interval, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_intv_fetch"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_intv_fetch"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_intv_fetch"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_intv_fetch"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_intv_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_intv_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_intv_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_intv_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_intv_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_intv_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_intv_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_intv_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_intv_same"("public"."gbtreekey32", "public"."gbtreekey32", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_intv_same"("public"."gbtreekey32", "public"."gbtreekey32", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_intv_same"("public"."gbtreekey32", "public"."gbtreekey32", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_intv_same"("public"."gbtreekey32", "public"."gbtreekey32", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_intv_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_intv_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_intv_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_intv_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_macad8_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_macad8_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_macad8_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_macad8_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_macad8_consistent"("internal", "macaddr8", smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_macad8_consistent"("internal", "macaddr8", smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_macad8_consistent"("internal", "macaddr8", smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_macad8_consistent"("internal", "macaddr8", smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_macad8_fetch"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_macad8_fetch"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_macad8_fetch"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_macad8_fetch"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_macad8_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_macad8_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_macad8_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_macad8_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_macad8_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_macad8_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_macad8_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_macad8_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_macad8_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_macad8_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_macad8_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_macad8_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_macad8_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_macad8_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_macad8_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_macad8_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_macad_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_macad_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_macad_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_macad_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_macad_consistent"("internal", "macaddr", smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_macad_consistent"("internal", "macaddr", smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_macad_consistent"("internal", "macaddr", smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_macad_consistent"("internal", "macaddr", smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_macad_fetch"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_macad_fetch"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_macad_fetch"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_macad_fetch"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_macad_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_macad_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_macad_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_macad_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_macad_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_macad_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_macad_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_macad_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_macad_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_macad_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_macad_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_macad_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_macad_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_macad_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_macad_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_macad_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_numeric_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_numeric_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_numeric_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_numeric_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_numeric_consistent"("internal", numeric, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_numeric_consistent"("internal", numeric, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_numeric_consistent"("internal", numeric, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_numeric_consistent"("internal", numeric, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_numeric_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_numeric_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_numeric_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_numeric_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_numeric_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_numeric_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_numeric_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_numeric_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_numeric_same"("public"."gbtreekey_var", "public"."gbtreekey_var", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_numeric_same"("public"."gbtreekey_var", "public"."gbtreekey_var", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_numeric_same"("public"."gbtreekey_var", "public"."gbtreekey_var", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_numeric_same"("public"."gbtreekey_var", "public"."gbtreekey_var", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_numeric_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_numeric_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_numeric_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_numeric_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_oid_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_oid_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_oid_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_oid_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_oid_consistent"("internal", "oid", smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_oid_consistent"("internal", "oid", smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_oid_consistent"("internal", "oid", smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_oid_consistent"("internal", "oid", smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_oid_distance"("internal", "oid", smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_oid_distance"("internal", "oid", smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_oid_distance"("internal", "oid", smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_oid_distance"("internal", "oid", smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_oid_fetch"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_oid_fetch"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_oid_fetch"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_oid_fetch"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_oid_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_oid_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_oid_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_oid_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_oid_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_oid_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_oid_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_oid_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_oid_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_oid_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_oid_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_oid_same"("public"."gbtreekey8", "public"."gbtreekey8", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_oid_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_oid_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_oid_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_oid_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_text_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_text_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_text_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_text_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_text_consistent"("internal", "text", smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_text_consistent"("internal", "text", smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_text_consistent"("internal", "text", smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_text_consistent"("internal", "text", smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_text_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_text_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_text_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_text_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_text_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_text_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_text_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_text_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_text_same"("public"."gbtreekey_var", "public"."gbtreekey_var", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_text_same"("public"."gbtreekey_var", "public"."gbtreekey_var", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_text_same"("public"."gbtreekey_var", "public"."gbtreekey_var", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_text_same"("public"."gbtreekey_var", "public"."gbtreekey_var", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_text_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_text_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_text_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_text_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_time_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_time_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_time_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_time_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_time_consistent"("internal", time without time zone, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_time_consistent"("internal", time without time zone, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_time_consistent"("internal", time without time zone, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_time_consistent"("internal", time without time zone, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_time_distance"("internal", time without time zone, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_time_distance"("internal", time without time zone, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_time_distance"("internal", time without time zone, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_time_distance"("internal", time without time zone, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_time_fetch"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_time_fetch"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_time_fetch"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_time_fetch"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_time_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_time_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_time_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_time_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_time_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_time_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_time_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_time_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_time_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_time_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_time_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_time_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_time_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_time_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_time_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_time_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_timetz_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_timetz_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_timetz_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_timetz_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_timetz_consistent"("internal", time with time zone, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_timetz_consistent"("internal", time with time zone, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_timetz_consistent"("internal", time with time zone, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_timetz_consistent"("internal", time with time zone, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_ts_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_ts_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_ts_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_ts_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_ts_consistent"("internal", timestamp without time zone, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_ts_consistent"("internal", timestamp without time zone, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_ts_consistent"("internal", timestamp without time zone, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_ts_consistent"("internal", timestamp without time zone, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_ts_distance"("internal", timestamp without time zone, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_ts_distance"("internal", timestamp without time zone, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_ts_distance"("internal", timestamp without time zone, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_ts_distance"("internal", timestamp without time zone, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_ts_fetch"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_ts_fetch"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_ts_fetch"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_ts_fetch"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_ts_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_ts_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_ts_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_ts_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_ts_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_ts_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_ts_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_ts_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_ts_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_ts_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_ts_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_ts_same"("public"."gbtreekey16", "public"."gbtreekey16", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_ts_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_ts_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_ts_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_ts_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_tstz_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_tstz_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_tstz_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_tstz_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_tstz_consistent"("internal", timestamp with time zone, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_tstz_consistent"("internal", timestamp with time zone, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_tstz_consistent"("internal", timestamp with time zone, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_tstz_consistent"("internal", timestamp with time zone, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_tstz_distance"("internal", timestamp with time zone, smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_tstz_distance"("internal", timestamp with time zone, smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_tstz_distance"("internal", timestamp with time zone, smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_tstz_distance"("internal", timestamp with time zone, smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_uuid_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_uuid_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_uuid_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_uuid_compress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_uuid_consistent"("internal", "uuid", smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_uuid_consistent"("internal", "uuid", smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_uuid_consistent"("internal", "uuid", smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_uuid_consistent"("internal", "uuid", smallint, "oid", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_uuid_fetch"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_uuid_fetch"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_uuid_fetch"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_uuid_fetch"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_uuid_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_uuid_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_uuid_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_uuid_penalty"("internal", "internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_uuid_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_uuid_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_uuid_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_uuid_picksplit"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_uuid_same"("public"."gbtreekey32", "public"."gbtreekey32", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_uuid_same"("public"."gbtreekey32", "public"."gbtreekey32", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_uuid_same"("public"."gbtreekey32", "public"."gbtreekey32", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_uuid_same"("public"."gbtreekey32", "public"."gbtreekey32", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_uuid_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_uuid_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_uuid_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_uuid_union"("internal", "internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_var_decompress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_var_decompress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_var_decompress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_var_decompress"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."gbt_var_fetch"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gbt_var_fetch"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gbt_var_fetch"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gbt_var_fetch"("internal") TO "service_role";



GRANT ALL ON FUNCTION "public"."generate_check_in_code"() TO "anon";
GRANT ALL ON FUNCTION "public"."generate_check_in_code"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."generate_check_in_code"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_available_slots"("p_venue_id" "uuid", "p_sport_id" "uuid", "p_date" "date", "p_duration" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."get_available_slots"("p_venue_id" "uuid", "p_sport_id" "uuid", "p_date" "date", "p_duration" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_available_slots"("p_venue_id" "uuid", "p_sport_id" "uuid", "p_date" "date", "p_duration" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_friend_suggestions"("p_user_id" "uuid", "p_limit" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."get_friend_suggestions"("p_user_id" "uuid", "p_limit" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_friend_suggestions"("p_user_id" "uuid", "p_limit" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_profile_analytics"("user_id" "uuid", "days_back" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."get_profile_analytics"("user_id" "uuid", "days_back" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_profile_analytics"("user_id" "uuid", "days_back" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_social_feed"("p_user_id" "uuid", "p_limit" integer, "p_offset" integer, "p_filter_type" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."get_social_feed"("p_user_id" "uuid", "p_limit" integer, "p_offset" integer, "p_filter_type" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_social_feed"("p_user_id" "uuid", "p_limit" integer, "p_offset" integer, "p_filter_type" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_tier_from_points"("p_points" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."get_tier_from_points"("p_points" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_tier_from_points"("p_points" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_trending_posts"("p_hours" integer, "p_limit" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."get_trending_posts"("p_hours" integer, "p_limit" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_trending_posts"("p_hours" integer, "p_limit" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."get_user_online_status"("last_active" timestamp with time zone) TO "anon";
GRANT ALL ON FUNCTION "public"."get_user_online_status"("last_active" timestamp with time zone) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_user_online_status"("last_active" timestamp with time zone) TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_friendship_reciprocal"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_friendship_reciprocal"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_friendship_reciprocal"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_new_auth_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_auth_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_auth_user"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_updated_at"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_updated_at"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_updated_at"() TO "service_role";



GRANT ALL ON FUNCTION "public"."increment_comments_count"("post_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."increment_comments_count"("post_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."increment_comments_count"("post_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."increment_likes_count"("post_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."increment_likes_count"("post_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."increment_likes_count"("post_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."int2_dist"(smallint, smallint) TO "postgres";
GRANT ALL ON FUNCTION "public"."int2_dist"(smallint, smallint) TO "anon";
GRANT ALL ON FUNCTION "public"."int2_dist"(smallint, smallint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."int2_dist"(smallint, smallint) TO "service_role";



GRANT ALL ON FUNCTION "public"."int4_dist"(integer, integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."int4_dist"(integer, integer) TO "anon";
GRANT ALL ON FUNCTION "public"."int4_dist"(integer, integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."int4_dist"(integer, integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."int8_dist"(bigint, bigint) TO "postgres";
GRANT ALL ON FUNCTION "public"."int8_dist"(bigint, bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."int8_dist"(bigint, bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."int8_dist"(bigint, bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."interval_dist"(interval, interval) TO "postgres";
GRANT ALL ON FUNCTION "public"."interval_dist"(interval, interval) TO "anon";
GRANT ALL ON FUNCTION "public"."interval_dist"(interval, interval) TO "authenticated";
GRANT ALL ON FUNCTION "public"."interval_dist"(interval, interval) TO "service_role";



GRANT ALL ON FUNCTION "public"."is_message_unread_for_user"("read_by" "uuid"[], "current_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."is_message_unread_for_user"("read_by" "uuid"[], "current_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_message_unread_for_user"("read_by" "uuid"[], "current_user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."is_profile_feature_enabled"("p_feature_name" "text", "p_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."is_profile_feature_enabled"("p_feature_name" "text", "p_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_profile_feature_enabled"("p_feature_name" "text", "p_user_id" "uuid") TO "service_role";



REVOKE ALL ON FUNCTION "public"."leaderboard_my_rank"("p_leaderboard" "uuid") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."leaderboard_my_rank"("p_leaderboard" "uuid") TO "service_role";
GRANT ALL ON FUNCTION "public"."leaderboard_my_rank"("p_leaderboard" "uuid") TO "authenticated";



REVOKE ALL ON FUNCTION "public"."leaderboard_top"("p_leaderboard" "uuid", "p_limit" integer) FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."leaderboard_top"("p_leaderboard" "uuid", "p_limit" integer) TO "service_role";
GRANT ALL ON FUNCTION "public"."leaderboard_top"("p_leaderboard" "uuid", "p_limit" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."leaderboard_top"("p_leaderboard" "uuid", "p_limit" integer) TO "authenticated";



GRANT ALL ON FUNCTION "public"."mark_notifications_read"("p_ids" "uuid"[]) TO "anon";
GRANT ALL ON FUNCTION "public"."mark_notifications_read"("p_ids" "uuid"[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."mark_notifications_read"("p_ids" "uuid"[]) TO "service_role";



GRANT ALL ON FUNCTION "public"."mark_oldest_unread"("_user_id" "uuid", "_limit" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."mark_oldest_unread"("_user_id" "uuid", "_limit" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."mark_oldest_unread"("_user_id" "uuid", "_limit" integer) TO "service_role";



GRANT ALL ON TABLE "public"."users" TO "anon";
GRANT ALL ON TABLE "public"."users" TO "authenticated";
GRANT ALL ON TABLE "public"."users" TO "service_role";



REVOKE ALL ON FUNCTION "public"."me"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."me"() TO "anon";
GRANT ALL ON FUNCTION "public"."me"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."me"() TO "service_role";



GRANT ALL ON TABLE "public"."user_preferences" TO "anon";
GRANT ALL ON TABLE "public"."user_preferences" TO "authenticated";
GRANT ALL ON TABLE "public"."user_preferences" TO "service_role";



REVOKE ALL ON FUNCTION "public"."me_preferences"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."me_preferences"() TO "anon";
GRANT ALL ON FUNCTION "public"."me_preferences"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."me_preferences"() TO "service_role";



GRANT ALL ON TABLE "public"."privacy_settings" TO "anon";
GRANT ALL ON TABLE "public"."privacy_settings" TO "authenticated";
GRANT ALL ON TABLE "public"."privacy_settings" TO "service_role";



REVOKE ALL ON FUNCTION "public"."me_privacy"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."me_privacy"() TO "anon";
GRANT ALL ON FUNCTION "public"."me_privacy"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."me_privacy"() TO "service_role";



GRANT ALL ON FUNCTION "public"."me_profile"() TO "anon";
GRANT ALL ON FUNCTION "public"."me_profile"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."me_profile"() TO "service_role";



GRANT ALL ON FUNCTION "public"."me_update_profile"("p" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."me_update_profile"("p" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."me_update_profile"("p" "jsonb") TO "service_role";



GRANT ALL ON TABLE "public"."notifications_unified" TO "service_role";
GRANT SELECT,UPDATE ON TABLE "public"."notifications_unified" TO "authenticated";
GRANT SELECT,UPDATE ON TABLE "public"."notifications_unified" TO "anon";



GRANT ALL ON FUNCTION "public"."my_notification_set_read"("p_notification_id" "uuid", "p_is_read" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."my_notification_set_read"("p_notification_id" "uuid", "p_is_read" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."my_notification_set_read"("p_notification_id" "uuid", "p_is_read" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."my_notifications"("p_limit" integer, "p_before" timestamp with time zone) TO "anon";
GRANT ALL ON FUNCTION "public"."my_notifications"("p_limit" integer, "p_before" timestamp with time zone) TO "authenticated";
GRANT ALL ON FUNCTION "public"."my_notifications"("p_limit" integer, "p_before" timestamp with time zone) TO "service_role";



GRANT ALL ON FUNCTION "public"."my_notifications"("p_only_unread" boolean, "p_limit" integer, "p_offset" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."my_notifications"("p_only_unread" boolean, "p_limit" integer, "p_offset" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."my_notifications"("p_only_unread" boolean, "p_limit" integer, "p_offset" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."my_notifications_detailed"("p_only_unread" boolean, "p_limit" integer, "p_offset" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."my_notifications_detailed"("p_only_unread" boolean, "p_limit" integer, "p_offset" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."my_notifications_detailed"("p_only_unread" boolean, "p_limit" integer, "p_offset" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."my_notifications_unread_count"() TO "anon";
GRANT ALL ON FUNCTION "public"."my_notifications_unread_count"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."my_notifications_unread_count"() TO "service_role";



GRANT ALL ON FUNCTION "public"."my_unread_count"() TO "anon";
GRANT ALL ON FUNCTION "public"."my_unread_count"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."my_unread_count"() TO "service_role";



GRANT ALL ON FUNCTION "public"."oid_dist"("oid", "oid") TO "postgres";
GRANT ALL ON FUNCTION "public"."oid_dist"("oid", "oid") TO "anon";
GRANT ALL ON FUNCTION "public"."oid_dist"("oid", "oid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."oid_dist"("oid", "oid") TO "service_role";



GRANT ALL ON FUNCTION "public"."precompute_user_feed"("p_user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."precompute_user_feed"("p_user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."precompute_user_feed"("p_user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."profile_audit_log_fn"() TO "anon";
GRANT ALL ON FUNCTION "public"."profile_audit_log_fn"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."profile_audit_log_fn"() TO "service_role";



GRANT ALL ON FUNCTION "public"."react"("p_target_type" "text", "p_target_id" "uuid", "p_reaction" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."react"("p_target_type" "text", "p_target_id" "uuid", "p_reaction" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."react"("p_target_type" "text", "p_target_id" "uuid", "p_reaction" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."react_toggle"("p_target_type" "text", "p_target_id" "uuid", "p_reaction" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."react_toggle"("p_target_type" "text", "p_target_id" "uuid", "p_reaction" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."react_toggle"("p_target_type" "text", "p_target_id" "uuid", "p_reaction" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."reactions_sync_likes"() TO "anon";
GRANT ALL ON FUNCTION "public"."reactions_sync_likes"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."reactions_sync_likes"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."refresh_all_leaderboards"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."refresh_all_leaderboards"() TO "service_role";
GRANT ALL ON FUNCTION "public"."refresh_all_leaderboards"() TO "authenticated";



GRANT ALL ON FUNCTION "public"."refresh_friend_activity"() TO "anon";
GRANT ALL ON FUNCTION "public"."refresh_friend_activity"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."refresh_friend_activity"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."refresh_leaderboard"("p_leaderboard" "uuid") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."refresh_leaderboard"("p_leaderboard" "uuid") TO "service_role";
GRANT ALL ON FUNCTION "public"."refresh_leaderboard"("p_leaderboard" "uuid") TO "authenticated";



GRANT ALL ON FUNCTION "public"."refresh_leaderboards"() TO "anon";
GRANT ALL ON FUNCTION "public"."refresh_leaderboards"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."refresh_leaderboards"() TO "service_role";



GRANT ALL ON FUNCTION "public"."refresh_sport_leaderboards"() TO "anon";
GRANT ALL ON FUNCTION "public"."refresh_sport_leaderboards"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."refresh_sport_leaderboards"() TO "service_role";



GRANT ALL ON FUNCTION "public"."regexp_match"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."regexp_match"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."regexp_match"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."regexp_match"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."regexp_match"("public"."citext", "public"."citext", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."regexp_match"("public"."citext", "public"."citext", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."regexp_match"("public"."citext", "public"."citext", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."regexp_match"("public"."citext", "public"."citext", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."regexp_matches"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."regexp_matches"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."regexp_matches"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."regexp_matches"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."regexp_matches"("public"."citext", "public"."citext", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."regexp_matches"("public"."citext", "public"."citext", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."regexp_matches"("public"."citext", "public"."citext", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."regexp_matches"("public"."citext", "public"."citext", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."regexp_replace"("public"."citext", "public"."citext", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."regexp_replace"("public"."citext", "public"."citext", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."regexp_replace"("public"."citext", "public"."citext", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."regexp_replace"("public"."citext", "public"."citext", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."regexp_replace"("public"."citext", "public"."citext", "text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."regexp_replace"("public"."citext", "public"."citext", "text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."regexp_replace"("public"."citext", "public"."citext", "text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."regexp_replace"("public"."citext", "public"."citext", "text", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."regexp_split_to_array"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."regexp_split_to_array"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."regexp_split_to_array"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."regexp_split_to_array"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."regexp_split_to_array"("public"."citext", "public"."citext", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."regexp_split_to_array"("public"."citext", "public"."citext", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."regexp_split_to_array"("public"."citext", "public"."citext", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."regexp_split_to_array"("public"."citext", "public"."citext", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."regexp_split_to_table"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."regexp_split_to_table"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."regexp_split_to_table"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."regexp_split_to_table"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."regexp_split_to_table"("public"."citext", "public"."citext", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."regexp_split_to_table"("public"."citext", "public"."citext", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."regexp_split_to_table"("public"."citext", "public"."citext", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."regexp_split_to_table"("public"."citext", "public"."citext", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."replace"("public"."citext", "public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."replace"("public"."citext", "public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."replace"("public"."citext", "public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."replace"("public"."citext", "public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."run_notification_cleanup"() TO "anon";
GRANT ALL ON FUNCTION "public"."run_notification_cleanup"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."run_notification_cleanup"() TO "service_role";



GRANT ALL ON FUNCTION "public"."search_messages"("p_user_id" "uuid", "p_query" "text", "p_conversation_id" "uuid", "p_limit" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."search_messages"("p_user_id" "uuid", "p_query" "text", "p_conversation_id" "uuid", "p_limit" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."search_messages"("p_user_id" "uuid", "p_query" "text", "p_conversation_id" "uuid", "p_limit" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."search_profiles"("search_query" "text", "limit_count" integer, "offset_count" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."search_profiles"("search_query" "text", "limit_count" integer, "offset_count" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."search_profiles"("search_query" "text", "limit_count" integer, "offset_count" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."search_social_users"("p_query" "text", "p_sport_filter" "uuid", "p_location_filter_km" integer, "p_user_lat" double precision, "p_user_lng" double precision, "p_limit" integer, "p_offset" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."search_social_users"("p_query" "text", "p_sport_filter" "uuid", "p_location_filter_km" integer, "p_user_lat" double precision, "p_user_lng" double precision, "p_limit" integer, "p_offset" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."search_social_users"("p_query" "text", "p_sport_filter" "uuid", "p_location_filter_km" integer, "p_user_lat" double precision, "p_user_lng" double precision, "p_limit" integer, "p_offset" integer) TO "service_role";



REVOKE ALL ON FUNCTION "public"."set_privacy_settings"("p_profile_visibility" "text", "p_show_real_name" boolean, "p_show_email" boolean, "p_show_phone" boolean, "p_show_location" boolean, "p_show_age" boolean, "p_show_sports_stats" boolean, "p_show_game_history" boolean, "p_show_upcoming_games" boolean, "p_show_favorite_venues" boolean, "p_searchable" boolean, "p_allow_friend_requests" boolean, "p_allow_game_invites" boolean, "p_allow_messages" boolean, "p_share_analytics" boolean, "p_share_location_data" boolean, "p_marketing_emails" boolean) FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."set_privacy_settings"("p_profile_visibility" "text", "p_show_real_name" boolean, "p_show_email" boolean, "p_show_phone" boolean, "p_show_location" boolean, "p_show_age" boolean, "p_show_sports_stats" boolean, "p_show_game_history" boolean, "p_show_upcoming_games" boolean, "p_show_favorite_venues" boolean, "p_searchable" boolean, "p_allow_friend_requests" boolean, "p_allow_game_invites" boolean, "p_allow_messages" boolean, "p_share_analytics" boolean, "p_share_location_data" boolean, "p_marketing_emails" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."set_privacy_settings"("p_profile_visibility" "text", "p_show_real_name" boolean, "p_show_email" boolean, "p_show_phone" boolean, "p_show_location" boolean, "p_show_age" boolean, "p_show_sports_stats" boolean, "p_show_game_history" boolean, "p_show_upcoming_games" boolean, "p_show_favorite_venues" boolean, "p_searchable" boolean, "p_allow_friend_requests" boolean, "p_allow_game_invites" boolean, "p_allow_messages" boolean, "p_share_analytics" boolean, "p_share_location_data" boolean, "p_marketing_emails" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_privacy_settings"("p_profile_visibility" "text", "p_show_real_name" boolean, "p_show_email" boolean, "p_show_phone" boolean, "p_show_location" boolean, "p_show_age" boolean, "p_show_sports_stats" boolean, "p_show_game_history" boolean, "p_show_upcoming_games" boolean, "p_show_favorite_venues" boolean, "p_searchable" boolean, "p_allow_friend_requests" boolean, "p_allow_game_invites" boolean, "p_allow_messages" boolean, "p_share_analytics" boolean, "p_share_location_data" boolean, "p_marketing_emails" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."set_updated_at"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_updated_at"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_updated_at"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."set_user_preferences"("p_preferred_game_types" "text"[], "p_preferred_game_duration" integer, "p_preferred_team_size_min" integer, "p_preferred_team_size_max" integer, "p_preferred_radius_km" integer, "p_preferred_venues" "text"[], "p_travel_willingness" "text", "p_weekly_availability" "jsonb", "p_advance_booking_days" integer, "p_last_minute_availability" boolean, "p_open_to_new_players" boolean, "p_preferred_age_range_min" integer, "p_preferred_age_range_max" integer, "p_preferred_gender_mix" "text", "p_equipment_sharing" boolean, "p_coaching_interest" boolean, "p_tournament_interest" boolean) FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."set_user_preferences"("p_preferred_game_types" "text"[], "p_preferred_game_duration" integer, "p_preferred_team_size_min" integer, "p_preferred_team_size_max" integer, "p_preferred_radius_km" integer, "p_preferred_venues" "text"[], "p_travel_willingness" "text", "p_weekly_availability" "jsonb", "p_advance_booking_days" integer, "p_last_minute_availability" boolean, "p_open_to_new_players" boolean, "p_preferred_age_range_min" integer, "p_preferred_age_range_max" integer, "p_preferred_gender_mix" "text", "p_equipment_sharing" boolean, "p_coaching_interest" boolean, "p_tournament_interest" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."set_user_preferences"("p_preferred_game_types" "text"[], "p_preferred_game_duration" integer, "p_preferred_team_size_min" integer, "p_preferred_team_size_max" integer, "p_preferred_radius_km" integer, "p_preferred_venues" "text"[], "p_travel_willingness" "text", "p_weekly_availability" "jsonb", "p_advance_booking_days" integer, "p_last_minute_availability" boolean, "p_open_to_new_players" boolean, "p_preferred_age_range_min" integer, "p_preferred_age_range_max" integer, "p_preferred_gender_mix" "text", "p_equipment_sharing" boolean, "p_coaching_interest" boolean, "p_tournament_interest" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_user_preferences"("p_preferred_game_types" "text"[], "p_preferred_game_duration" integer, "p_preferred_team_size_min" integer, "p_preferred_team_size_max" integer, "p_preferred_radius_km" integer, "p_preferred_venues" "text"[], "p_travel_willingness" "text", "p_weekly_availability" "jsonb", "p_advance_booking_days" integer, "p_last_minute_availability" boolean, "p_open_to_new_players" boolean, "p_preferred_age_range_min" integer, "p_preferred_age_range_max" integer, "p_preferred_gender_mix" "text", "p_equipment_sharing" boolean, "p_coaching_interest" boolean, "p_tournament_interest" boolean) TO "service_role";



REVOKE ALL ON FUNCTION "public"."set_user_settings"("p_theme_mode" "text", "p_email_notifications" boolean, "p_push_notifications" boolean, "p_sms_notifications" boolean) FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."set_user_settings"("p_theme_mode" "text", "p_email_notifications" boolean, "p_push_notifications" boolean, "p_sms_notifications" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."set_user_settings"("p_theme_mode" "text", "p_email_notifications" boolean, "p_push_notifications" boolean, "p_sms_notifications" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_user_settings"("p_theme_mode" "text", "p_email_notifications" boolean, "p_push_notifications" boolean, "p_sms_notifications" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."split_part"("public"."citext", "public"."citext", integer) TO "postgres";
GRANT ALL ON FUNCTION "public"."split_part"("public"."citext", "public"."citext", integer) TO "anon";
GRANT ALL ON FUNCTION "public"."split_part"("public"."citext", "public"."citext", integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."split_part"("public"."citext", "public"."citext", integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."strpos"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."strpos"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."strpos"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."strpos"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."sync_auth_user_data"() TO "anon";
GRANT ALL ON FUNCTION "public"."sync_auth_user_data"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."sync_auth_user_data"() TO "service_role";



GRANT ALL ON FUNCTION "public"."sync_feed_read_from_notification"() TO "anon";
GRANT ALL ON FUNCTION "public"."sync_feed_read_from_notification"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."sync_feed_read_from_notification"() TO "service_role";



GRANT ALL ON FUNCTION "public"."sync_game_skill_level"() TO "anon";
GRANT ALL ON FUNCTION "public"."sync_game_skill_level"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."sync_game_skill_level"() TO "service_role";



GRANT ALL ON FUNCTION "public"."sync_game_sport"() TO "anon";
GRANT ALL ON FUNCTION "public"."sync_game_sport"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."sync_game_sport"() TO "service_role";



GRANT ALL ON FUNCTION "public"."sync_notification_read_from_feed"() TO "anon";
GRANT ALL ON FUNCTION "public"."sync_notification_read_from_feed"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."sync_notification_read_from_feed"() TO "service_role";



GRANT ALL ON FUNCTION "public"."sync_profile_aliases"() TO "anon";
GRANT ALL ON FUNCTION "public"."sync_profile_aliases"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."sync_profile_aliases"() TO "service_role";



GRANT ALL ON FUNCTION "public"."sync_user_phone"() TO "anon";
GRANT ALL ON FUNCTION "public"."sync_user_phone"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."sync_user_phone"() TO "service_role";



GRANT ALL ON FUNCTION "public"."texticlike"("public"."citext", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."texticlike"("public"."citext", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."texticlike"("public"."citext", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."texticlike"("public"."citext", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."texticlike"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."texticlike"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."texticlike"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."texticlike"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."texticnlike"("public"."citext", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."texticnlike"("public"."citext", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."texticnlike"("public"."citext", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."texticnlike"("public"."citext", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."texticnlike"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."texticnlike"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."texticnlike"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."texticnlike"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."texticregexeq"("public"."citext", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."texticregexeq"("public"."citext", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."texticregexeq"("public"."citext", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."texticregexeq"("public"."citext", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."texticregexeq"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."texticregexeq"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."texticregexeq"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."texticregexeq"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."texticregexne"("public"."citext", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."texticregexne"("public"."citext", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."texticregexne"("public"."citext", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."texticregexne"("public"."citext", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."texticregexne"("public"."citext", "public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."texticregexne"("public"."citext", "public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."texticregexne"("public"."citext", "public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."texticregexne"("public"."citext", "public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."time_dist"(time without time zone, time without time zone) TO "postgres";
GRANT ALL ON FUNCTION "public"."time_dist"(time without time zone, time without time zone) TO "anon";
GRANT ALL ON FUNCTION "public"."time_dist"(time without time zone, time without time zone) TO "authenticated";
GRANT ALL ON FUNCTION "public"."time_dist"(time without time zone, time without time zone) TO "service_role";



GRANT ALL ON FUNCTION "public"."track_achievement_progress"("p_user_id" "uuid", "p_event_type" "text", "p_event_data" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."track_achievement_progress"("p_user_id" "uuid", "p_event_type" "text", "p_event_data" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."track_achievement_progress"("p_user_id" "uuid", "p_event_type" "text", "p_event_data" "jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."track_friend_achievements"() TO "anon";
GRANT ALL ON FUNCTION "public"."track_friend_achievements"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."track_friend_achievements"() TO "service_role";



GRANT ALL ON FUNCTION "public"."track_game_achievements"() TO "anon";
GRANT ALL ON FUNCTION "public"."track_game_achievements"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."track_game_achievements"() TO "service_role";



GRANT ALL ON FUNCTION "public"."track_profile_achievements"() TO "anon";
GRANT ALL ON FUNCTION "public"."track_profile_achievements"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."track_profile_achievements"() TO "service_role";



GRANT ALL ON FUNCTION "public"."translate"("public"."citext", "public"."citext", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."translate"("public"."citext", "public"."citext", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."translate"("public"."citext", "public"."citext", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."translate"("public"."citext", "public"."citext", "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."trigger_cleanup_old_notifications"() TO "anon";
GRANT ALL ON FUNCTION "public"."trigger_cleanup_old_notifications"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."trigger_cleanup_old_notifications"() TO "service_role";



GRANT ALL ON FUNCTION "public"."ts_dist"(timestamp without time zone, timestamp without time zone) TO "postgres";
GRANT ALL ON FUNCTION "public"."ts_dist"(timestamp without time zone, timestamp without time zone) TO "anon";
GRANT ALL ON FUNCTION "public"."ts_dist"(timestamp without time zone, timestamp without time zone) TO "authenticated";
GRANT ALL ON FUNCTION "public"."ts_dist"(timestamp without time zone, timestamp without time zone) TO "service_role";



GRANT ALL ON FUNCTION "public"."tstz_dist"(timestamp with time zone, timestamp with time zone) TO "postgres";
GRANT ALL ON FUNCTION "public"."tstz_dist"(timestamp with time zone, timestamp with time zone) TO "anon";
GRANT ALL ON FUNCTION "public"."tstz_dist"(timestamp with time zone, timestamp with time zone) TO "authenticated";
GRANT ALL ON FUNCTION "public"."tstz_dist"(timestamp with time zone, timestamp with time zone) TO "service_role";



GRANT ALL ON FUNCTION "public"."update_conversation_last_message"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_conversation_last_message"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_conversation_last_message"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_game_player_count"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_game_player_count"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_game_player_count"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_notifications_updated_at"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_notifications_updated_at"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_notifications_updated_at"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_post_engagement_counts"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_post_engagement_counts"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_post_engagement_counts"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_profile_completion"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_profile_completion"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_profile_completion"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_profile_statistics"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_profile_statistics"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_profile_statistics"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_user_profile"("user_name" "text", "user_age" integer, "user_gender" "text", "user_sports" "text"[], "user_intent" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."update_user_profile"("user_name" "text", "user_age" integer, "user_gender" "text", "user_sports" "text"[], "user_intent" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_user_profile"("user_name" "text", "user_age" integer, "user_gender" "text", "user_sports" "text"[], "user_intent" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."update_user_profile"("user_display_name" "text", "user_username" "text", "user_bio" "text", "user_phone" "text", "user_date_of_birth" "text", "user_age" integer, "user_gender" "text", "user_nationality" "text", "user_skill_level" "text", "user_sports" "text"[], "user_interests" "text"[], "user_intent" "text", "user_location" "text", "user_timezone" "text", "user_language" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."update_user_profile"("user_display_name" "text", "user_username" "text", "user_bio" "text", "user_phone" "text", "user_date_of_birth" "text", "user_age" integer, "user_gender" "text", "user_nationality" "text", "user_skill_level" "text", "user_sports" "text"[], "user_interests" "text"[], "user_intent" "text", "user_location" "text", "user_timezone" "text", "user_language" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_user_profile"("user_display_name" "text", "user_username" "text", "user_bio" "text", "user_phone" "text", "user_date_of_birth" "text", "user_age" integer, "user_gender" "text", "user_nationality" "text", "user_skill_level" "text", "user_sports" "text"[], "user_interests" "text"[], "user_intent" "text", "user_location" "text", "user_timezone" "text", "user_language" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."update_venue_rating"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_venue_rating"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_venue_rating"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."user_exists_by_email"("p_email" "text") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."user_exists_by_email"("p_email" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."user_exists_by_email"("p_email" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."user_exists_by_email"("p_email" "text") TO "service_role";



REVOKE ALL ON FUNCTION "public"."venue_slot_conflicts"("p_venue" "uuid", "p_date" "date", "p_start" time without time zone, "p_end" time without time zone) FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."venue_slot_conflicts"("p_venue" "uuid", "p_date" "date", "p_start" time without time zone, "p_end" time without time zone) TO "service_role";
GRANT ALL ON FUNCTION "public"."venue_slot_conflicts"("p_venue" "uuid", "p_date" "date", "p_start" time without time zone, "p_end" time without time zone) TO "anon";
GRANT ALL ON FUNCTION "public"."venue_slot_conflicts"("p_venue" "uuid", "p_date" "date", "p_start" time without time zone, "p_end" time without time zone) TO "authenticated";



REVOKE ALL ON FUNCTION "public"."venue_slot_free"("p_venue" "uuid", "p_date" "date", "p_start" time without time zone, "p_end" time without time zone) FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."venue_slot_free"("p_venue" "uuid", "p_date" "date", "p_start" time without time zone, "p_end" time without time zone) TO "service_role";
GRANT ALL ON FUNCTION "public"."venue_slot_free"("p_venue" "uuid", "p_date" "date", "p_start" time without time zone, "p_end" time without time zone) TO "anon";
GRANT ALL ON FUNCTION "public"."venue_slot_free"("p_venue" "uuid", "p_date" "date", "p_start" time without time zone, "p_end" time without time zone) TO "authenticated";












GRANT ALL ON FUNCTION "public"."max"("public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."max"("public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."max"("public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."max"("public"."citext") TO "service_role";



GRANT ALL ON FUNCTION "public"."min"("public"."citext") TO "postgres";
GRANT ALL ON FUNCTION "public"."min"("public"."citext") TO "anon";
GRANT ALL ON FUNCTION "public"."min"("public"."citext") TO "authenticated";
GRANT ALL ON FUNCTION "public"."min"("public"."citext") TO "service_role";















GRANT ALL ON TABLE "public"."achievement_notifications" TO "anon";
GRANT ALL ON TABLE "public"."achievement_notifications" TO "authenticated";
GRANT ALL ON TABLE "public"."achievement_notifications" TO "service_role";



GRANT ALL ON TABLE "public"."achievements" TO "anon";
GRANT ALL ON TABLE "public"."achievements" TO "authenticated";
GRANT ALL ON TABLE "public"."achievements" TO "service_role";



GRANT ALL ON TABLE "public"."activity_feed" TO "anon";
GRANT ALL ON TABLE "public"."activity_feed" TO "authenticated";
GRANT ALL ON TABLE "public"."activity_feed" TO "service_role";



GRANT ALL ON TABLE "public"."activity_log" TO "anon";
GRANT ALL ON TABLE "public"."activity_log" TO "authenticated";
GRANT ALL ON TABLE "public"."activity_log" TO "service_role";



GRANT ALL ON TABLE "public"."auth_sessions" TO "anon";
GRANT ALL ON TABLE "public"."auth_sessions" TO "authenticated";
GRANT ALL ON TABLE "public"."auth_sessions" TO "service_role";



GRANT ALL ON TABLE "public"."badge_showcase_settings" TO "anon";
GRANT ALL ON TABLE "public"."badge_showcase_settings" TO "authenticated";
GRANT ALL ON TABLE "public"."badge_showcase_settings" TO "service_role";



GRANT ALL ON TABLE "public"."badges" TO "anon";
GRANT ALL ON TABLE "public"."badges" TO "authenticated";
GRANT ALL ON TABLE "public"."badges" TO "service_role";



GRANT ALL ON TABLE "public"."challenge_participants" TO "anon";
GRANT ALL ON TABLE "public"."challenge_participants" TO "authenticated";
GRANT ALL ON TABLE "public"."challenge_participants" TO "service_role";



GRANT ALL ON TABLE "public"."challenge_progress_updates" TO "anon";
GRANT ALL ON TABLE "public"."challenge_progress_updates" TO "authenticated";
GRANT ALL ON TABLE "public"."challenge_progress_updates" TO "service_role";



GRANT ALL ON TABLE "public"."comments" TO "service_role";
GRANT SELECT ON TABLE "public"."comments" TO "anon";
GRANT SELECT,INSERT,UPDATE ON TABLE "public"."comments" TO "authenticated";



GRANT ALL ON TABLE "public"."community_analytics" TO "anon";
GRANT ALL ON TABLE "public"."community_analytics" TO "authenticated";
GRANT ALL ON TABLE "public"."community_analytics" TO "service_role";



GRANT ALL ON TABLE "public"."community_challenges" TO "anon";
GRANT ALL ON TABLE "public"."community_challenges" TO "authenticated";
GRANT ALL ON TABLE "public"."community_challenges" TO "service_role";



GRANT ALL ON TABLE "public"."community_events" TO "anon";
GRANT ALL ON TABLE "public"."community_events" TO "authenticated";
GRANT ALL ON TABLE "public"."community_events" TO "service_role";



GRANT ALL ON TABLE "public"."community_groups" TO "anon";
GRANT ALL ON TABLE "public"."community_groups" TO "authenticated";
GRANT ALL ON TABLE "public"."community_groups" TO "service_role";



GRANT ALL ON TABLE "public"."community_growth_metrics" TO "anon";
GRANT ALL ON TABLE "public"."community_growth_metrics" TO "authenticated";
GRANT ALL ON TABLE "public"."community_growth_metrics" TO "service_role";



GRANT ALL ON TABLE "public"."community_leaderboards" TO "anon";
GRANT ALL ON TABLE "public"."community_leaderboards" TO "authenticated";
GRANT ALL ON TABLE "public"."community_leaderboards" TO "service_role";



GRANT ALL ON TABLE "public"."conversation_participants" TO "anon";
GRANT ALL ON TABLE "public"."conversation_participants" TO "authenticated";
GRANT ALL ON TABLE "public"."conversation_participants" TO "service_role";



GRANT ALL ON TABLE "public"."conversations" TO "anon";
GRANT ALL ON TABLE "public"."conversations" TO "authenticated";
GRANT ALL ON TABLE "public"."conversations" TO "service_role";



GRANT ALL ON TABLE "public"."email_outbox" TO "anon";
GRANT ALL ON TABLE "public"."email_outbox" TO "authenticated";
GRANT ALL ON TABLE "public"."email_outbox" TO "service_role";



GRANT ALL ON TABLE "public"."event_registrations" TO "anon";
GRANT ALL ON TABLE "public"."event_registrations" TO "authenticated";
GRANT ALL ON TABLE "public"."event_registrations" TO "service_role";



GRANT ALL ON TABLE "public"."game_check_ins" TO "anon";
GRANT ALL ON TABLE "public"."game_check_ins" TO "authenticated";
GRANT ALL ON TABLE "public"."game_check_ins" TO "service_role";



GRANT ALL ON TABLE "public"."game_invitations" TO "anon";
GRANT ALL ON TABLE "public"."game_invitations" TO "authenticated";
GRANT ALL ON TABLE "public"."game_invitations" TO "service_role";



GRANT ALL ON TABLE "public"."game_notifications" TO "anon";
GRANT ALL ON TABLE "public"."game_notifications" TO "authenticated";
GRANT ALL ON TABLE "public"."game_notifications" TO "service_role";



GRANT ALL ON TABLE "public"."game_players" TO "anon";
GRANT ALL ON TABLE "public"."game_players" TO "authenticated";
GRANT ALL ON TABLE "public"."game_players" TO "service_role";



GRANT ALL ON TABLE "public"."game_sessions" TO "anon";
GRANT ALL ON TABLE "public"."game_sessions" TO "authenticated";
GRANT ALL ON TABLE "public"."game_sessions" TO "service_role";



GRANT ALL ON TABLE "public"."games" TO "anon";
GRANT ALL ON TABLE "public"."games" TO "authenticated";
GRANT ALL ON TABLE "public"."games" TO "service_role";



GRANT ALL ON TABLE "public"."games_public" TO "anon";
GRANT ALL ON TABLE "public"."games_public" TO "authenticated";
GRANT ALL ON TABLE "public"."games_public" TO "service_role";



GRANT ALL ON TABLE "public"."group_members" TO "anon";
GRANT ALL ON TABLE "public"."group_members" TO "authenticated";
GRANT ALL ON TABLE "public"."group_members" TO "service_role";



GRANT ALL ON TABLE "public"."introspect_columns" TO "anon";
GRANT ALL ON TABLE "public"."introspect_columns" TO "authenticated";
GRANT ALL ON TABLE "public"."introspect_columns" TO "service_role";



GRANT ALL ON TABLE "public"."introspect_foreign_keys" TO "anon";
GRANT ALL ON TABLE "public"."introspect_foreign_keys" TO "authenticated";
GRANT ALL ON TABLE "public"."introspect_foreign_keys" TO "service_role";



GRANT ALL ON TABLE "public"."introspect_tables" TO "anon";
GRANT ALL ON TABLE "public"."introspect_tables" TO "authenticated";
GRANT ALL ON TABLE "public"."introspect_tables" TO "service_role";



GRANT ALL ON TABLE "public"."leaderboard_entries" TO "service_role";
GRANT SELECT ON TABLE "public"."leaderboard_entries" TO "anon";
GRANT SELECT ON TABLE "public"."leaderboard_entries" TO "authenticated";



GRANT ALL ON TABLE "public"."leaderboard_entries_public" TO "anon";
GRANT ALL ON TABLE "public"."leaderboard_entries_public" TO "authenticated";
GRANT ALL ON TABLE "public"."leaderboard_entries_public" TO "service_role";



GRANT ALL ON TABLE "public"."leaderboard_history" TO "anon";
GRANT ALL ON TABLE "public"."leaderboard_history" TO "authenticated";
GRANT ALL ON TABLE "public"."leaderboard_history" TO "service_role";



GRANT ALL ON TABLE "public"."leaderboards" TO "anon";
GRANT ALL ON TABLE "public"."leaderboards" TO "authenticated";
GRANT ALL ON TABLE "public"."leaderboards" TO "service_role";



GRANT ALL ON TABLE "public"."leaderboards_public" TO "anon";
GRANT ALL ON TABLE "public"."leaderboards_public" TO "authenticated";
GRANT ALL ON TABLE "public"."leaderboards_public" TO "service_role";



GRANT ALL ON TABLE "public"."member_activity_log" TO "anon";
GRANT ALL ON TABLE "public"."member_activity_log" TO "authenticated";
GRANT ALL ON TABLE "public"."member_activity_log" TO "service_role";



GRANT ALL ON TABLE "public"."messages" TO "anon";
GRANT ALL ON TABLE "public"."messages" TO "authenticated";
GRANT ALL ON TABLE "public"."messages" TO "service_role";



GRANT ALL ON TABLE "public"."notifications" TO "anon";
GRANT ALL ON TABLE "public"."notifications" TO "authenticated";
GRANT ALL ON TABLE "public"."notifications" TO "service_role";



GRANT ALL ON TABLE "public"."notifications_unified_public" TO "anon";
GRANT ALL ON TABLE "public"."notifications_unified_public" TO "authenticated";
GRANT ALL ON TABLE "public"."notifications_unified_public" TO "service_role";



GRANT ALL ON TABLE "public"."password_reset_attempts" TO "anon";
GRANT ALL ON TABLE "public"."password_reset_attempts" TO "authenticated";
GRANT ALL ON TABLE "public"."password_reset_attempts" TO "service_role";



GRANT ALL ON TABLE "public"."player_ratings" TO "anon";
GRANT ALL ON TABLE "public"."player_ratings" TO "authenticated";
GRANT ALL ON TABLE "public"."player_ratings" TO "service_role";



GRANT ALL ON TABLE "public"."points_multipliers" TO "anon";
GRANT ALL ON TABLE "public"."points_multipliers" TO "authenticated";
GRANT ALL ON TABLE "public"."points_multipliers" TO "service_role";



GRANT ALL ON TABLE "public"."post_comments" TO "anon";
GRANT ALL ON TABLE "public"."post_comments" TO "authenticated";
GRANT ALL ON TABLE "public"."post_comments" TO "service_role";



GRANT ALL ON TABLE "public"."post_comments__old" TO "anon";
GRANT ALL ON TABLE "public"."post_comments__old" TO "authenticated";
GRANT ALL ON TABLE "public"."post_comments__old" TO "service_role";



GRANT ALL ON TABLE "public"."posts" TO "anon";
GRANT ALL ON TABLE "public"."posts" TO "authenticated";
GRANT ALL ON TABLE "public"."posts" TO "service_role";



GRANT ALL ON TABLE "public"."post_comments_public" TO "anon";
GRANT ALL ON TABLE "public"."post_comments_public" TO "authenticated";
GRANT ALL ON TABLE "public"."post_comments_public" TO "service_role";



GRANT ALL ON TABLE "public"."post_likes" TO "anon";
GRANT ALL ON TABLE "public"."post_likes" TO "authenticated";
GRANT ALL ON TABLE "public"."post_likes" TO "service_role";



GRANT ALL ON TABLE "public"."posts_friends_public" TO "anon";
GRANT ALL ON TABLE "public"."posts_friends_public" TO "authenticated";
GRANT ALL ON TABLE "public"."posts_friends_public" TO "service_role";



GRANT ALL ON TABLE "public"."posts_public" TO "anon";
GRANT ALL ON TABLE "public"."posts_public" TO "authenticated";
GRANT ALL ON TABLE "public"."posts_public" TO "service_role";



GRANT ALL ON TABLE "public"."profile_audit" TO "anon";
GRANT ALL ON TABLE "public"."profile_audit" TO "authenticated";
GRANT ALL ON TABLE "public"."profile_audit" TO "service_role";



GRANT ALL ON TABLE "public"."profile_audit_log" TO "anon";
GRANT ALL ON TABLE "public"."profile_audit_log" TO "authenticated";
GRANT ALL ON TABLE "public"."profile_audit_log" TO "service_role";



GRANT ALL ON TABLE "public"."profile_feature_flags" TO "anon";
GRANT ALL ON TABLE "public"."profile_feature_flags" TO "authenticated";
GRANT ALL ON TABLE "public"."profile_feature_flags" TO "service_role";



GRANT ALL ON TABLE "public"."profile_metrics" TO "anon";
GRANT ALL ON TABLE "public"."profile_metrics" TO "authenticated";
GRANT ALL ON TABLE "public"."profile_metrics" TO "service_role";



GRANT ALL ON TABLE "public"."profile_statistics" TO "anon";
GRANT ALL ON TABLE "public"."profile_statistics" TO "authenticated";
GRANT ALL ON TABLE "public"."profile_statistics" TO "service_role";



GRANT ALL ON TABLE "public"."profile_views" TO "anon";
GRANT ALL ON TABLE "public"."profile_views" TO "authenticated";
GRANT ALL ON TABLE "public"."profile_views" TO "service_role";



GRANT ALL ON TABLE "public"."profiles_backup" TO "anon";
GRANT ALL ON TABLE "public"."profiles_backup" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles_backup" TO "service_role";



GRANT ALL ON TABLE "public"."profiles_public" TO "anon";
GRANT ALL ON TABLE "public"."profiles_public" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles_public" TO "service_role";



GRANT ALL ON TABLE "public"."reactions" TO "service_role";
GRANT SELECT ON TABLE "public"."reactions" TO "anon";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "public"."reactions" TO "authenticated";



GRANT ALL ON TABLE "public"."reactions_unified" TO "service_role";
GRANT SELECT ON TABLE "public"."reactions_unified" TO "anon";
GRANT SELECT,INSERT,DELETE ON TABLE "public"."reactions_unified" TO "authenticated";



GRANT ALL ON TABLE "public"."regions" TO "anon";
GRANT ALL ON TABLE "public"."regions" TO "authenticated";
GRANT ALL ON TABLE "public"."regions" TO "service_role";



GRANT ALL ON TABLE "public"."rewards_config" TO "anon";
GRANT ALL ON TABLE "public"."rewards_config" TO "authenticated";
GRANT ALL ON TABLE "public"."rewards_config" TO "service_role";



GRANT ALL ON TABLE "public"."scheduled_rewards" TO "anon";
GRANT ALL ON TABLE "public"."scheduled_rewards" TO "authenticated";
GRANT ALL ON TABLE "public"."scheduled_rewards" TO "service_role";



GRANT ALL ON TABLE "public"."skill_levels" TO "anon";
GRANT ALL ON TABLE "public"."skill_levels" TO "authenticated";
GRANT ALL ON TABLE "public"."skill_levels" TO "service_role";



GRANT ALL ON TABLE "public"."social_metrics" TO "anon";
GRANT ALL ON TABLE "public"."social_metrics" TO "authenticated";
GRANT ALL ON TABLE "public"."social_metrics" TO "service_role";



GRANT ALL ON TABLE "public"."social_notifications" TO "anon";
GRANT ALL ON TABLE "public"."social_notifications" TO "authenticated";
GRANT ALL ON TABLE "public"."social_notifications" TO "service_role";



GRANT ALL ON TABLE "public"."sports" TO "anon";
GRANT ALL ON TABLE "public"."sports" TO "authenticated";
GRANT ALL ON TABLE "public"."sports" TO "service_role";



GRANT ALL ON TABLE "public"."tier_levels" TO "anon";
GRANT ALL ON TABLE "public"."tier_levels" TO "authenticated";
GRANT ALL ON TABLE "public"."tier_levels" TO "service_role";



GRANT ALL ON TABLE "public"."tournament_matches" TO "anon";
GRANT ALL ON TABLE "public"."tournament_matches" TO "authenticated";
GRANT ALL ON TABLE "public"."tournament_matches" TO "service_role";



GRANT ALL ON TABLE "public"."tournament_participants" TO "anon";
GRANT ALL ON TABLE "public"."tournament_participants" TO "authenticated";
GRANT ALL ON TABLE "public"."tournament_participants" TO "service_role";



GRANT ALL ON TABLE "public"."tournaments" TO "anon";
GRANT ALL ON TABLE "public"."tournaments" TO "authenticated";
GRANT ALL ON TABLE "public"."tournaments" TO "service_role";



GRANT ALL ON TABLE "public"."user_achievements" TO "anon";
GRANT ALL ON TABLE "public"."user_achievements" TO "authenticated";
GRANT ALL ON TABLE "public"."user_achievements" TO "service_role";



GRANT ALL ON TABLE "public"."user_badges" TO "anon";
GRANT ALL ON TABLE "public"."user_badges" TO "authenticated";
GRANT ALL ON TABLE "public"."user_badges" TO "service_role";



GRANT ALL ON TABLE "public"."user_card" TO "anon";
GRANT ALL ON TABLE "public"."user_card" TO "authenticated";
GRANT ALL ON TABLE "public"."user_card" TO "service_role";



GRANT ALL ON TABLE "public"."user_feed_cache" TO "anon";
GRANT ALL ON TABLE "public"."user_feed_cache" TO "authenticated";
GRANT ALL ON TABLE "public"."user_feed_cache" TO "service_role";



GRANT ALL ON TABLE "public"."user_profile_public" TO "anon";
GRANT ALL ON TABLE "public"."user_profile_public" TO "authenticated";
GRANT ALL ON TABLE "public"."user_profile_public" TO "service_role";



GRANT ALL ON TABLE "public"."user_rankings" TO "anon";
GRANT ALL ON TABLE "public"."user_rankings" TO "authenticated";
GRANT ALL ON TABLE "public"."user_rankings" TO "service_role";



GRANT ALL ON TABLE "public"."user_settings" TO "anon";
GRANT ALL ON TABLE "public"."user_settings" TO "authenticated";
GRANT ALL ON TABLE "public"."user_settings" TO "service_role";



GRANT ALL ON TABLE "public"."user_sports_profiles" TO "anon";
GRANT ALL ON TABLE "public"."user_sports_profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."user_sports_profiles" TO "service_role";



GRANT ALL ON TABLE "public"."user_tier_progress" TO "anon";
GRANT ALL ON TABLE "public"."user_tier_progress" TO "authenticated";
GRANT ALL ON TABLE "public"."user_tier_progress" TO "service_role";



GRANT ALL ON TABLE "public"."users_backup" TO "anon";
GRANT ALL ON TABLE "public"."users_backup" TO "authenticated";
GRANT ALL ON TABLE "public"."users_backup" TO "service_role";



GRANT ALL ON TABLE "public"."users_public" TO "anon";
GRANT ALL ON TABLE "public"."users_public" TO "authenticated";
GRANT ALL ON TABLE "public"."users_public" TO "service_role";



GRANT ALL ON TABLE "public"."venue_bookings" TO "anon";
GRANT ALL ON TABLE "public"."venue_bookings" TO "authenticated";
GRANT ALL ON TABLE "public"."venue_bookings" TO "service_role";



GRANT ALL ON TABLE "public"."v_bookings_daily" TO "anon";
GRANT ALL ON TABLE "public"."v_bookings_daily" TO "authenticated";
GRANT ALL ON TABLE "public"."v_bookings_daily" TO "service_role";



GRANT ALL ON TABLE "public"."v_daily_active_users" TO "anon";
GRANT ALL ON TABLE "public"."v_daily_active_users" TO "authenticated";
GRANT ALL ON TABLE "public"."v_daily_active_users" TO "service_role";



GRANT ALL ON TABLE "public"."v_daily_new_users" TO "anon";
GRANT ALL ON TABLE "public"."v_daily_new_users" TO "authenticated";
GRANT ALL ON TABLE "public"."v_daily_new_users" TO "service_role";



GRANT ALL ON TABLE "public"."v_leaderboard_user_scores" TO "anon";
GRANT ALL ON TABLE "public"."v_leaderboard_user_scores" TO "authenticated";
GRANT ALL ON TABLE "public"."v_leaderboard_user_scores" TO "service_role";



GRANT ALL ON TABLE "public"."v_notifications_from_achievement" TO "anon";
GRANT ALL ON TABLE "public"."v_notifications_from_achievement" TO "authenticated";
GRANT ALL ON TABLE "public"."v_notifications_from_achievement" TO "service_role";



GRANT ALL ON TABLE "public"."v_notifications_from_game" TO "anon";
GRANT ALL ON TABLE "public"."v_notifications_from_game" TO "authenticated";
GRANT ALL ON TABLE "public"."v_notifications_from_game" TO "service_role";



GRANT ALL ON TABLE "public"."v_notifications_from_notifications" TO "anon";
GRANT ALL ON TABLE "public"."v_notifications_from_notifications" TO "authenticated";
GRANT ALL ON TABLE "public"."v_notifications_from_notifications" TO "service_role";



GRANT ALL ON TABLE "public"."v_notifications_from_social" TO "anon";
GRANT ALL ON TABLE "public"."v_notifications_from_social" TO "authenticated";
GRANT ALL ON TABLE "public"."v_notifications_from_social" TO "service_role";



GRANT ALL ON TABLE "public"."v_reaction_counts" TO "anon";
GRANT ALL ON TABLE "public"."v_reaction_counts" TO "authenticated";
GRANT ALL ON TABLE "public"."v_reaction_counts" TO "service_role";



GRANT ALL ON TABLE "public"."v_revenue_daily" TO "anon";
GRANT ALL ON TABLE "public"."v_revenue_daily" TO "authenticated";
GRANT ALL ON TABLE "public"."v_revenue_daily" TO "service_role";



GRANT ALL ON TABLE "public"."v_top_posts_engagement" TO "anon";
GRANT ALL ON TABLE "public"."v_top_posts_engagement" TO "authenticated";
GRANT ALL ON TABLE "public"."v_top_posts_engagement" TO "service_role";



GRANT ALL ON TABLE "public"."v_venue_bookings_day" TO "anon";
GRANT ALL ON TABLE "public"."v_venue_bookings_day" TO "authenticated";
GRANT ALL ON TABLE "public"."v_venue_bookings_day" TO "service_role";



GRANT ALL ON TABLE "public"."venue_amenities" TO "anon";
GRANT ALL ON TABLE "public"."venue_amenities" TO "authenticated";
GRANT ALL ON TABLE "public"."venue_amenities" TO "service_role";



GRANT ALL ON TABLE "public"."venue_images" TO "anon";
GRANT ALL ON TABLE "public"."venue_images" TO "authenticated";
GRANT ALL ON TABLE "public"."venue_images" TO "service_role";



GRANT ALL ON TABLE "public"."venue_reviews" TO "anon";
GRANT ALL ON TABLE "public"."venue_reviews" TO "authenticated";
GRANT ALL ON TABLE "public"."venue_reviews" TO "service_role";



GRANT ALL ON TABLE "public"."venue_sports" TO "anon";
GRANT ALL ON TABLE "public"."venue_sports" TO "authenticated";
GRANT ALL ON TABLE "public"."venue_sports" TO "service_role";



GRANT ALL ON TABLE "public"."venue_time_slots" TO "anon";
GRANT ALL ON TABLE "public"."venue_time_slots" TO "authenticated";
GRANT ALL ON TABLE "public"."venue_time_slots" TO "service_role";



GRANT ALL ON TABLE "public"."venues" TO "anon";
GRANT ALL ON TABLE "public"."venues" TO "authenticated";
GRANT ALL ON TABLE "public"."venues" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";






























RESET ALL;
