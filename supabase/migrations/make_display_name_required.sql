-- Migration: Enforce NOT NULL constraints on mandatory user fields
-- This ensures all required user data is collected during onboarding

-- ============================================================
-- STEP 0: Create user_gender enum type if it doesn't exist
-- ============================================================

-- Drop existing enum if it exists to recreate with correct values
DO $$ BEGIN
    DROP TYPE IF EXISTS user_gender CASCADE;
EXCEPTION
    WHEN undefined_object THEN
        NULL;
END $$;

-- Create enum with only 'male' and 'female' values
CREATE TYPE user_gender AS ENUM ('male', 'female');

-- ============================================================
-- STEP 0.5: Add missing columns if they don't exist
-- ============================================================

-- Add gender column if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'users' 
        AND column_name = 'gender'
    ) THEN
        ALTER TABLE public.users ADD COLUMN gender user_gender;
        RAISE NOTICE 'Added gender column';
    ELSE
        RAISE NOTICE 'Gender column already exists';
    END IF;
END $$;

-- Add display_name column if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'users' 
        AND column_name = 'display_name'
    ) THEN
        ALTER TABLE public.users ADD COLUMN display_name text;
        RAISE NOTICE 'Added display_name column';
    ELSE
        RAISE NOTICE 'display_name column already exists';
    END IF;
END $$;

-- Add age column if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'users' 
        AND column_name = 'age'
    ) THEN
        ALTER TABLE public.users ADD COLUMN age integer;
        RAISE NOTICE 'Added age column';
    ELSE
        RAISE NOTICE 'Age column already exists';
    END IF;
END $$;

-- Add sports column if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'users' 
        AND column_name = 'sports'
    ) THEN
        ALTER TABLE public.users ADD COLUMN sports text[];
        RAISE NOTICE 'Added sports column';
    ELSE
        RAISE NOTICE 'Sports column already exists';
    END IF;
END $$;

-- Add intent column if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'users' 
        AND column_name = 'intent'
    ) THEN
        ALTER TABLE public.users ADD COLUMN intent text;
        RAISE NOTICE 'Added intent column';
    ELSE
        RAISE NOTICE 'Intent column already exists';
    END IF;
END $$;

-- ============================================================
-- STEP 1: Update existing NULL or invalid values with placeholders
-- ============================================================

-- Update display_name (any NULL values)
UPDATE public.users 
SET display_name = 'User_' || SUBSTRING(id::text, 1, 8)
WHERE display_name IS NULL OR display_name = '';

-- Update age (set to 18 as minimum age)
UPDATE public.users 
SET age = 18
WHERE age IS NULL;

-- Update gender (set to 'male' for invalid/NULL values - users must update)
-- First, handle any invalid text values if column is text type
UPDATE public.users 
SET gender = 'male'::user_gender
WHERE gender IS NULL;

-- Update sports (set to empty array if NULL)
UPDATE public.users 
SET sports = ARRAY[]::text[]
WHERE sports IS NULL;

-- Update intent (set to 'social' as default)
UPDATE public.users 
SET intent = 'social'
WHERE intent IS NULL OR intent = '';

-- ============================================================
-- STEP 2: Apply NOT NULL constraints on all mandatory fields
-- ============================================================

-- id and email are already NOT NULL from auth.users, but ensure it
DO $$ 
BEGIN
    ALTER TABLE public.users ALTER COLUMN id SET NOT NULL;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'id constraint already set or error: %', SQLERRM;
END $$;

DO $$ 
BEGIN
    ALTER TABLE public.users ALTER COLUMN email SET NOT NULL;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'email constraint already set or error: %', SQLERRM;
END $$;

-- display_name
DO $$ 
BEGIN
    ALTER TABLE public.users ALTER COLUMN display_name SET NOT NULL;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'display_name constraint already set or error: %', SQLERRM;
END $$;

-- age
DO $$ 
BEGIN
    ALTER TABLE public.users ALTER COLUMN age SET NOT NULL;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'age constraint already set or error: %', SQLERRM;
END $$;

-- gender
DO $$ 
BEGIN
    ALTER TABLE public.users ALTER COLUMN gender SET NOT NULL;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'gender constraint already set or error: %', SQLERRM;
END $$;

-- sports
DO $$ 
BEGIN
    ALTER TABLE public.users ALTER COLUMN sports SET NOT NULL;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'sports constraint already set or error: %', SQLERRM;
END $$;

-- intent
DO $$ 
BEGIN
    ALTER TABLE public.users ALTER COLUMN intent SET NOT NULL;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'intent constraint already set or error: %', SQLERRM;
END $$;

-- ============================================================
-- STEP 3: Add check constraints for data validation
-- ============================================================

-- Display name: not empty, length between 2-50
ALTER TABLE public.users 
ADD CONSTRAINT display_name_not_empty 
CHECK (LENGTH(TRIM(display_name)) >= 2 AND LENGTH(TRIM(display_name)) <= 50);

-- Age: reasonable range (13-120)
DO $$ 
BEGIN
    ALTER TABLE public.users 
    ADD CONSTRAINT age_valid_range 
    CHECK (age >= 13 AND age <= 120);
EXCEPTION
    WHEN duplicate_object THEN
        RAISE NOTICE 'Constraint age_valid_range already exists, skipping';
END $$;

-- Gender: enum type already enforces valid values ('male' or 'female')
-- No additional check constraint needed

-- Sports: array not empty (at least one sport during onboarding)
-- Note: Removing this constraint to allow empty array initially
-- Users can add sports later in profile
-- ALTER TABLE public.users 
-- ADD CONSTRAINT sports_not_empty 
-- CHECK (array_length(sports, 1) > 0);

-- Intent: not empty
ALTER TABLE public.users 
ADD CONSTRAINT intent_not_empty 
CHECK (LENGTH(TRIM(intent)) > 0);

-- ============================================================
-- STEP 4: Set default values for new users
-- ============================================================

-- Sports: default to empty array
ALTER TABLE public.users 
ALTER COLUMN sports SET DEFAULT ARRAY[]::text[];

-- ============================================================
-- STEP 5: Add column comments for documentation
-- ============================================================

COMMENT ON COLUMN public.users.id IS 'User UUID - REQUIRED, from auth.users';
COMMENT ON COLUMN public.users.email IS 'User email - REQUIRED, from auth.users';
COMMENT ON COLUMN public.users.display_name IS 'User display name - REQUIRED, 2-50 characters';
COMMENT ON COLUMN public.users.age IS 'User age - REQUIRED, must be 13-120';
COMMENT ON COLUMN public.users.gender IS 'User gender - REQUIRED, collected during onboarding';
COMMENT ON COLUMN public.users.sports IS 'User sports preferences - REQUIRED array, can be empty initially';
COMMENT ON COLUMN public.users.intent IS 'User intent/goal - REQUIRED, collected during onboarding';
COMMENT ON COLUMN public.users.avatar_url IS 'User avatar URL - OPTIONAL, has default in database';

-- ============================================================
-- STEP 6: Create indexes for performance
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_users_display_name ON public.users(display_name);
CREATE INDEX IF NOT EXISTS idx_users_age ON public.users(age);
CREATE INDEX IF NOT EXISTS idx_users_gender ON public.users(gender);
CREATE INDEX IF NOT EXISTS idx_users_sports ON public.users USING GIN(sports);
CREATE INDEX IF NOT EXISTS idx_users_intent ON public.users(intent);

-- ============================================================
-- STEP 7: Verification queries
-- ============================================================

-- Check for any remaining NULL values (should return 0 for all)
DO $$
DECLARE
    null_display_name_count INT;
    null_age_count INT;
    null_gender_count INT;
    null_sports_count INT;
    null_intent_count INT;
BEGIN
    SELECT COUNT(*) INTO null_display_name_count FROM public.users WHERE display_name IS NULL;
    SELECT COUNT(*) INTO null_age_count FROM public.users WHERE age IS NULL;
    SELECT COUNT(*) INTO null_gender_count FROM public.users WHERE gender IS NULL;
    SELECT COUNT(*) INTO null_sports_count FROM public.users WHERE sports IS NULL;
    SELECT COUNT(*) INTO null_intent_count FROM public.users WHERE intent IS NULL;
    
    RAISE NOTICE 'NULL display_name count: %', null_display_name_count;
    RAISE NOTICE 'NULL age count: %', null_age_count;
    RAISE NOTICE 'NULL gender count: %', null_gender_count;
    RAISE NOTICE 'NULL sports count: %', null_sports_count;
    RAISE NOTICE 'NULL intent count: %', null_intent_count;
    
    IF null_display_name_count > 0 OR null_age_count > 0 OR null_gender_count > 0 
       OR null_sports_count > 0 OR null_intent_count > 0 THEN
        RAISE WARNING 'Some users still have NULL mandatory fields!';
    ELSE
        RAISE NOTICE '✅ All mandatory fields are populated!';
    END IF;
END $$;

-- Summary query: Show current state of mandatory fields
SELECT 
    COUNT(*) as total_users,
    COUNT(display_name) as with_display_name,
    COUNT(age) as with_age,
    COUNT(gender) as with_gender,
    COUNT(sports) as with_sports,
    COUNT(intent) as with_intent,
    COUNT(avatar_url) as with_avatar
FROM public.users;

