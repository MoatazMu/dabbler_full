# Display Name NOT NULL Enforcement

## Overview
This document describes the changes made to enforce `display_name` as a required (NOT NULL) field in both the database and application code.

## Database Changes

### SQL Migration Script
Location: `supabase/migrations/make_display_name_required.sql`

```sql
-- Migration: Make display_name NOT NULL in users table

-- Step 1: Update any existing NULL values
UPDATE public.users 
SET display_name = 'User_' || SUBSTRING(id::text, 1, 8)
WHERE display_name IS NULL OR display_name = '';

-- Step 2: Make the column NOT NULL
ALTER TABLE public.users 
ALTER COLUMN display_name SET NOT NULL;

-- Step 3: Add check constraint to prevent empty strings
ALTER TABLE public.users 
ADD CONSTRAINT display_name_not_empty 
CHECK (LENGTH(TRIM(display_name)) > 0);

-- Step 4: Add documentation
COMMENT ON COLUMN public.users.display_name IS 'User display name - REQUIRED field, must not be null or empty';

-- Step 5: Create index for performance
CREATE INDEX IF NOT EXISTS idx_users_display_name ON public.users(display_name);
```

### How to Apply
1. Open Supabase Dashboard → SQL Editor
2. Copy and paste the SQL from `supabase/migrations/make_display_name_required.sql`
3. Click "Run"
4. Verify with: `SELECT COUNT(*) FROM users WHERE display_name IS NULL;` (should return 0)

## Application Code Changes

### 1. AuthService - Profile Creation Validation
**File:** `lib/core/services/auth_service.dart`

**Method:** `_ensureUserProfileExists()`

**Validations Added:**
```dart
// CRITICAL VALIDATION: display_name is NOT NULL in database
if (metadata['name'] == null || (metadata['name'] as String).trim().isEmpty) {
  throw Exception('REQUIRED FIELD: Name cannot be null or empty. Database constraint will fail.');
}

final displayName = (metadata['name'] as String).trim();

// Validate display name length
if (displayName.length < 2) {
  throw Exception('Display name must be at least 2 characters long');
}
if (displayName.length > 50) {
  throw Exception('Display name must be 50 characters or less');
}
```

**What it does:**
- Validates metadata contains a valid name before profile creation
- Trims whitespace
- Enforces minimum length (2 characters)
- Enforces maximum length (50 characters)
- Throws clear error messages if validation fails

### 2. AuthService - Profile Update Validation
**File:** `lib/core/services/auth_service.dart`

**Method:** `updateUserProfile()`

**Validations Added:**
```dart
// CRITICAL: display_name is NOT NULL in database - validate before updating
if (displayName != null) {
  final trimmedName = displayName.trim();
  if (trimmedName.isEmpty) {
    throw Exception('Display name cannot be empty - database constraint will fail');
  }
  if (trimmedName.length < 2) {
    throw Exception('Display name must be at least 2 characters long');
  }
  if (trimmedName.length > 50) {
    throw Exception('Display name must be 50 characters or less');
  }
  updates['display_name'] = trimmedName;
}
```

**What it does:**
- Prevents updating display_name to null or empty string
- Validates length constraints
- Only updates if value is valid

### 3. Profile Edit Screen - Form Validation
**File:** `lib/screens/profile/edit_profile_screen.dart`

**Widget:** Display Name TextFormField

**Validations Added:**
```dart
validator: (value) {
  if (value == null || value.trim().isEmpty) {
    return 'Display name is required and cannot be empty';
  }
  if (value.trim().length < 2) {
    return 'Display name must be at least 2 characters';
  }
  if (value.trim().length > 50) {
    return 'Display name must be 50 characters or less';
  }
  return null;
}
```

**What it does:**
- Prevents form submission with empty display name
- Shows inline error messages to user
- Enforces same constraints as backend

### 4. Onboarding - Pre-Signup Validation
**File:** `lib/screens/onboarding/set_password_screen.dart`

**Validations Added:**
```dart
// Validate that we have all required registration data
if (registrationData.name == null || registrationData.name!.trim().isEmpty) {
  throw Exception('Name is required. Please go back and enter your name.');
}
```

**What it does:**
- Validates registration data before calling signup
- Prevents signup with missing name
- Clear error message directing user to fix the issue

## Validation Rules Summary

| Rule | Value | Enforced Where |
|------|-------|----------------|
| **Required** | NOT NULL | Database, AuthService, Form |
| **Not Empty** | Length > 0 | Database, AuthService, Form |
| **Min Length** | 2 characters | AuthService, Form |
| **Max Length** | 50 characters | AuthService, Form |
| **Whitespace** | Trimmed | AuthService |

## Error Messages

### User-Facing Errors (Form Validation)
- "Display name is required and cannot be empty"
- "Display name must be at least 2 characters"
- "Display name must be 50 characters or less"

### Developer Errors (AuthService)
- "REQUIRED FIELD: Name cannot be null or empty. Database constraint will fail."
- "Display name must be at least 2 characters long"
- "Display name must be 50 characters or less"
- "Display name cannot be empty - database constraint will fail"

### Database Errors
- `null value in column "display_name" violates not-null constraint`
- `new row for relation "users" violates check constraint "display_name_not_empty"`

## Testing Checklist

### ✅ Database Constraint Tests
1. Run the migration SQL
2. Try inserting a user with null display_name:
   ```sql
   INSERT INTO users (id, email, display_name) 
   VALUES (gen_random_uuid(), 'test@test.com', NULL);
   ```
   Expected: Error - `not-null constraint`

3. Try inserting with empty string:
   ```sql
   INSERT INTO users (id, email, display_name) 
   VALUES (gen_random_uuid(), 'test@test.com', '');
   ```
   Expected: Error - `check constraint "display_name_not_empty"`

### ✅ Code Validation Tests
1. **Create New Account**
   - Try to submit name field empty → Should show validation error
   - Try to submit single character name → Should show "at least 2 characters"
   - Try to submit 51+ character name → Should show "50 characters or less"
   - Submit valid name (2-50 chars) → Should succeed

2. **Edit Profile**
   - Try to clear display name field → Should show validation error
   - Try to save single character → Should show "at least 2 characters"
   - Try to save 51+ characters → Should show "50 characters or less"
   - Save valid name → Should update successfully

3. **Backend Validation**
   - Check logs for validation messages
   - Confirm trimming happens (spaces removed)
   - Confirm database insert succeeds with valid data

## Impact Analysis

### Breaking Changes
- ✅ Existing users with NULL display_name will be updated to `User_<id>` (first 8 chars of UUID)
- ✅ Profile edit form now requires display_name (cannot be empty)
- ✅ Signup requires valid display_name (cannot proceed without it)

### Non-Breaking Changes
- ✅ Validation messages improve UX
- ✅ Database constraint prevents invalid data
- ✅ Consistent validation across all entry points

### Migration Safety
The migration handles existing NULL values automatically by:
1. Setting them to `User_<id>` format
2. Then applying the NOT NULL constraint
3. Users can update their names later in profile edit

### Rollback Plan
If needed, remove the constraint:
```sql
ALTER TABLE public.users 
ALTER COLUMN display_name DROP NOT NULL;

ALTER TABLE public.users 
DROP CONSTRAINT IF EXISTS display_name_not_empty;
```

## Summary

### Before
- ❌ display_name could be NULL
- ❌ Empty strings allowed
- ❌ No validation in code
- ❌ Users seeing "Player" as fallback

### After
- ✅ display_name is NOT NULL (database enforced)
- ✅ Empty strings prevented (check constraint)
- ✅ Length validation (2-50 characters)
- ✅ Validation at all entry points (form, signup, update)
- ✅ Clear error messages
- ✅ Users must provide real names

### Files Modified
1. ✅ `supabase/migrations/make_display_name_required.sql` - Database migration
2. ✅ `lib/core/services/auth_service.dart` - Backend validation
3. ✅ `lib/screens/profile/edit_profile_screen.dart` - Form validation
4. ✅ `lib/screens/onboarding/set_password_screen.dart` - Signup validation

### Next Steps
1. **Run the SQL migration** in Supabase Dashboard
2. **Test the complete flow** - create account, edit profile
3. **Monitor logs** for any validation errors
4. **Update existing users** who have placeholder names (`User_<id>`)
