# SQL Migration - Step by Step Guide

## Issue Fixed
❌ **Error:** `[42703] ERROR: column "gender" does not exist`

✅ **Solution:** Updated SQL to create missing columns first, then apply constraints

---

## Two Files to Run

### 1️⃣ FIRST: Check Current Table Structure (Optional)
**File:** `supabase/migrations/00_check_users_table.sql`

This shows what columns currently exist in your users table.

**To run:**
1. Go to Supabase Dashboard → SQL Editor
2. Copy/paste the content of `00_check_users_table.sql`
3. Click Run
4. Review the output to see which columns exist

---

### 2️⃣ SECOND: Run Complete Migration
**File:** `supabase/migrations/make_display_name_required.sql`

This is the complete migration that:
- ✅ Creates `user_gender` enum
- ✅ Adds missing columns (gender, display_name, age, sports, intent) if they don't exist
- ✅ Updates NULL values with defaults
- ✅ Applies NOT NULL constraints
- ✅ Adds validation (CHECK constraints)
- ✅ Creates performance indexes
- ✅ Verifies results

**To run:**
1. Go to Supabase Dashboard → SQL Editor
2. Copy the ENTIRE content of `make_display_name_required.sql` (all ~290 lines)
3. Click Run
4. Check for success messages

---

## What the Migration Does

### Step 0: Create Gender Enum
```sql
CREATE TYPE user_gender AS ENUM ('male', 'female');
```

### Step 0.5: Add Missing Columns (NEW!)
```sql
-- Checks if columns exist, creates them if missing:
- gender (user_gender type)
- display_name (text)
- age (integer)
- sports (text[])
- intent (text)
```

### Step 1: Update NULL Values
```sql
-- Sets defaults for existing NULL values:
- display_name → 'User_<id>'
- age → 18
- gender → 'male'
- sports → []
- intent → 'social'
```

### Step 2: Apply NOT NULL Constraints
```sql
-- Makes these fields required:
- id, email (from auth)
- display_name
- age
- gender
- sports
- intent
```

### Step 3: Add Validation Rules
```sql
-- CHECK constraints:
- display_name: 2-50 characters
- age: 13-120 range
- gender: enum enforces 'male' or 'female'
- intent: not empty
```

### Step 4: Create Indexes
```sql
-- Performance indexes on:
- display_name
- age
- gender
- sports (GIN index for array)
- intent
```

### Step 5: Verify
```sql
-- Shows count of NULL values (should be 0)
```

---

## Expected Output

When you run the migration, you should see:

```
NOTICE: user_gender enum created (or already exists)
NOTICE: Added gender column (or already exists)
NOTICE: Added display_name column (or already exists)
NOTICE: Added age column (or already exists)
NOTICE: Added sports column (or already exists)
NOTICE: Added intent column (or already exists)

-- Updates
UPDATE X (rows updated with default display_name)
UPDATE X (rows updated with default age)
UPDATE X (rows updated with default gender)
UPDATE X (rows updated with default sports)
UPDATE X (rows updated with default intent)

-- Constraints
NOTICE: display_name constraint set
NOTICE: age constraint set
NOTICE: gender constraint set
NOTICE: sports constraint set
NOTICE: intent constraint set

-- Verification
NOTICE: NULL display_name count: 0
NOTICE: NULL age count: 0
NOTICE: NULL gender count: 0
NOTICE: NULL sports count: 0
NOTICE: NULL intent count: 0
NOTICE: ✅ All mandatory fields are populated!
```

---

## If You Get Errors

### "column already exists"
✅ **Safe to ignore** - The migration checks for this and skips creation

### "constraint already exists"
✅ **Safe to ignore** - Uses `DO $$ BEGIN ... EXCEPTION ... END $$` to handle this

### "type already exists"
✅ **Safe to ignore** - The migration handles this with `DROP TYPE IF EXISTS`

### "relation does not exist"
❌ **Problem** - Your `users` table doesn't exist. You need to create it first.

---

## Order to Run

1. **Optional:** Run `00_check_users_table.sql` to see current structure
2. **Required:** Run `make_display_name_required.sql` (the complete migration)
3. **Test:** Create a new user account in your app
4. **Verify:** Check database that all fields are populated

---

## Quick Reference

### What Changed from Original

**Before (caused error):**
```sql
UPDATE public.users 
SET gender = 'male'
WHERE gender IS NULL;
-- ❌ Failed because 'gender' column didn't exist
```

**After (fixed):**
```sql
-- First, create column if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns ...) THEN
        ALTER TABLE public.users ADD COLUMN gender user_gender;
    END IF;
END $$;

-- Then update NULL values
UPDATE public.users 
SET gender = 'male'::user_gender
WHERE gender IS NULL;
-- ✅ Works because column is guaranteed to exist
```

---

## Files Summary

| File | Purpose | Required |
|------|---------|----------|
| `00_check_users_table.sql` | Diagnostic - shows current table structure | Optional |
| `make_display_name_required.sql` | Complete migration - creates columns & constraints | **Required** |

---

## Ready to Run! 🚀

1. Open Supabase Dashboard
2. Go to SQL Editor
3. Copy **all content** from `make_display_name_required.sql`
4. Paste and click **Run**
5. Check for success messages
6. Test user signup in your app!
