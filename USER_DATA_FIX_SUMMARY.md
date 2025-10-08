# User Data Fix Summary

## Problem
- User onboarding data (name, age, gender, sports, intent) was not being saved to the database
- Display name showed "Player" instead of actual user name
- Hardcoded fallback values everywhere

## Root Cause
1. **AuthService** had incorrect field mapping and fallback to "Player"
2. **getUserProfile()** was creating dummy profiles with "Player" when profile missing
3. **No validation** that required fields were provided before signup

## Solution Applied

### 1. ✅ Fixed AuthService Profile Creation
**File:** `lib/core/services/auth_service.dart`

**Changes:**
- `_ensureUserProfileExists()` now validates required fields (name, age, gender)
- Maps all metadata correctly to `users` table schema:
  - `display_name` ← `metadata['name']` (trimmed, validated)
  - `age` ← `metadata['age']`
  - `gender` ← `metadata['gender']`
  - `sports` ← `metadata['sports']`
  - `intent` ← `metadata['intent']`
- Removed ALL hardcoded defaults like `'Player'`, `'beginner'`, dummy avatar URLs
- Added comprehensive logging to track data flow
- Throws error if profile creation fails (no silent failures)

### 2. ✅ Removed Hardcoded "Player" Fallbacks
**File:** `lib/core/services/auth_service.dart`

**Changes:**
- `getUserProfile()` no longer creates dummy profiles
- Returns `null` if profile doesn't exist (forces proper error handling)
- No fallback to `'Player'` anywhere in AuthService

### 3. ✅ Updated HomeScreen
**File:** `lib/screens/home/home_screen.dart`

**Changes:**
- Removed fallback to `'Player'`
- Shows "Complete your profile" if `display_name` is null
- Properly handles null values without crashing

### 4. ✅ Added Validation in Onboarding
**File:** `lib/screens/onboarding/set_password_screen.dart`

**Changes:**
- Validates that `name`, `age`, and `gender` are provided before signup
- Shows clear error messages if required data is missing
- Trims whitespace from name before saving

### 5. ✅ Profile Edit Screen
**File:** `lib/screens/profile/edit_profile_screen.dart`

**Status:** Already correct!
- Reads from `users` table
- Writes to `users` table via `AuthService.updateUserProfile()`

## Users Table Schema Mapping

```sql
public.users (
  id,                           -- UUID from auth
  email,                        -- From signup
  display_name,                 -- From metadata['name']
  age,                          -- From metadata['age']
  gender,                       -- From metadata['gender']
  sports,                       -- From metadata['sports']
  intent,                       -- From metadata['intent']
  phone,                        -- null (set later)
  avatar_url,                   -- null (set later)
  skill_level,                  -- null (set later)
  bio,                          -- null (set later)
  date_of_birth,                -- null (using age instead)
  games_played,                 -- 0
  onboarding_completed,         -- false
  onboarding_step,              -- 'password_created'
  language,                     -- 'en'
  timezone,                     -- 'UTC'
  is_profile_complete,          -- false
  is_email_verified,            -- false
  is_phone_verified,            -- false
  profile_completion_percentage, -- 0
  created_at,                   -- now()
  updated_at,                   -- now()
  ...other fields
)
```

## Data Flow

### User Registration Flow
```
1. User enters name, age, gender → CreateUserInformation
   ↓
2. User selects sports → SportsSelectionScreen
   ↓
3. User selects intent → IntentSelectionScreen
   ↓
4. User sets password → SetPasswordScreen
   ↓ (validates all required fields)
5. AuthService.signUpWithEmailAndMetadata(metadata)
   ↓
6. Supabase Auth creates user
   ↓
7. AuthService._ensureUserProfileExists()
   ↓ (validates metadata, maps fields)
8. Insert into users table
   ↓
9. Profile created with real data!
```

### Profile Display Flow
```
HomeScreen.initState()
   ↓
_loadUserProfile()
   ↓
AuthService.getUserProfile()
   ↓
SELECT * FROM users WHERE id = current_user_id
   ↓
Returns profile data or null
   ↓
Display name or "Complete your profile"
```

## Testing Checklist

### ✅ Create New Account
1. Go through full onboarding flow
2. Enter: Name, Age, Gender, Sports, Intent, Password
3. Check browser console for debug logs:
   - `📋 [DEBUG] AuthService: Metadata received: ...` 
   - `📤 [DEBUG] AuthService: Inserting profile data with display_name=...`
   - `✅ [DEBUG] AuthService: User profile created successfully`
4. Check database: `SELECT * FROM users WHERE email = 'test@example.com'`
5. Verify `display_name` is set to actual name (not "Player")

### ✅ View Profile on Home
1. Login with test account
2. Home screen should show actual name
3. If profile incomplete, shows "Complete your profile"
4. No "Player" text anywhere

### ✅ Edit Profile
1. Go to Edit Profile screen
2. Fields should be pre-filled with database values
3. Update display name
4. Save
5. Check database for updated values

## Debug Console Messages

### Success Path
```
📋 [DEBUG] SetPasswordScreen: Creating account with name="John Doe", age=25, gender=male
🔐 [DEBUG] AuthService: Signing up user with email and metadata
📋 [DEBUG] AuthService: User metadata: {name: John Doe, age: 25, gender: male, ...}
👤 [DEBUG] AuthService: Ensuring user profile exists for: <uuid>
📤 [DEBUG] AuthService: Inserting profile data with display_name="John Doe", age=25, gender=male
✅ [DEBUG] AuthService: User profile created successfully
```

### Error Path (Missing Data)
```
❌ Exception: Name is required but missing from metadata
```

## Files Modified
1. ✅ `lib/core/services/auth_service.dart` - Profile creation & validation
2. ✅ `lib/screens/home/home_screen.dart` - Display name handling
3. ✅ `lib/screens/onboarding/set_password_screen.dart` - Metadata validation
4. ✅ `lib/screens/profile/edit_profile_screen.dart` - Already correct

## No More Dummy Data!
❌ Removed all instances of:
- `'Player'` as default display name
- `'beginner'` as default skill level
- `'assets/Avatar/default-avatar.svg'` hardcoded avatar
- Any other fallback values

✅ All data now comes from:
- User input during onboarding
- Database `users` table
- Explicit user actions (profile edit)
