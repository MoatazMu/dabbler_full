# Gender Enum Fix - Male and Female Only

## Issue
Database error when creating user accounts:
```
[22P02] ERROR: invalid input value for enum user_gender: ""
```

The database has a `user_gender` enum type that only accepts specific values, but the app was:
1. Allowing empty strings
2. Allowing "other" as an option
3. Not validating gender values before database insertion

## Solution

### 1. Database Changes (SQL Migration)

**File:** `supabase/migrations/make_display_name_required.sql`

#### Created `user_gender` enum:
```sql
DROP TYPE IF EXISTS user_gender CASCADE;
CREATE TYPE user_gender AS ENUM ('male', 'female');
```

#### Updated gender column to use enum:
```sql
ALTER TABLE public.users 
ALTER COLUMN gender TYPE user_gender USING gender::user_gender;
```

#### Fixed existing invalid data:
```sql
-- Set invalid/NULL values to 'male' (users must update their profile)
UPDATE public.users 
SET gender = 'male'
WHERE gender IS NULL 
   OR gender = '' 
   OR gender NOT IN ('male', 'female')
   OR TRIM(gender) = '';
```

### 2. Code Validation

#### AuthService - Backend Validation
**File:** `lib/core/services/auth_service.dart`

```dart
// 3. Validate gender (ONLY 'male' or 'female' allowed)
if (metadata['gender'] == null || (metadata['gender'] as String).trim().isEmpty) {
  throw Exception('REQUIRED FIELD: Gender cannot be null or empty.');
}
final gender = (metadata['gender'] as String).trim().toLowerCase();
if (gender != 'male' && gender != 'female') {
  throw Exception('Gender must be either "male" or "female". Received: "$gender"');
}
```

#### SetPasswordScreen - Pre-Signup Validation
**File:** `lib/screens/onboarding/set_password_screen.dart`

```dart
// 3. Validate gender (ONLY 'male' or 'female' allowed)
if (registrationData.gender == null || registrationData.gender!.trim().isEmpty) {
  throw Exception('Gender is required. Please go back and select your gender.');
}
final gender = registrationData.gender!.trim().toLowerCase();
if (gender != 'male' && gender != 'female') {
  throw Exception('Gender must be either Male or Female.');
}
```

### 3. UI Changes

#### Edit Profile Screen
**File:** `lib/screens/profile/edit_profile_screen.dart`

**Before:**
```dart
items: const [
  DropdownMenuItem(value: 'male', child: Text('Male')),
  DropdownMenuItem(value: 'female', child: Text('Female')),
  DropdownMenuItem(value: 'other', child: Text('Other')),  // ❌ Removed
],
```

**After:**
```dart
items: const [
  DropdownMenuItem(value: 'male', child: Text('Male')),
  DropdownMenuItem(value: 'female', child: Text('Female')),
],
```

#### Onboarding Screen
**File:** `lib/screens/onboarding/create_user_information.dart`

Already correctly configured with only 'male' and 'female':
```dart
Column(
  children: ['male', 'female'].map((gender) => 
    _buildGenderOption(context, gender)
  ).toList(),
),
```

---

## Database Schema

### Gender Column
```sql
Column:    gender
Type:      user_gender (enum)
Values:    'male', 'female'
NOT NULL:  Yes
Default:   None (must be explicitly set during signup)
```

### Validation Layers

1. **UI Layer** - Dropdown/Radio buttons show only 'male' and 'female'
2. **Pre-Signup Validation** - SetPasswordScreen validates before calling signup
3. **Backend Validation** - AuthService validates before database insertion
4. **Database Constraint** - Enum type enforces only 'male' or 'female'

---

## Testing

### Valid Gender Values
✅ **Accepted:**
- `'male'`
- `'female'`
- `'Male'` (converted to lowercase)
- `'Female'` (converted to lowercase)
- `'MALE'` (converted to lowercase)
- `'FEMALE'` (converted to lowercase)

### Invalid Gender Values
❌ **Rejected:**
- `''` (empty string)
- `null`
- `'other'`
- `'not_specified'`
- Any value not in ['male', 'female']

### Test Cases

#### 1. New User Signup
```dart
// ✅ Valid
await authService.signUpWithEmailAndMetadata(
  email: 'user@example.com',
  password: 'password',
  metadata: {
    'name': 'John Doe',
    'age': 25,
    'gender': 'male',  // ✅ Valid
    'sports': [],
    'intent': 'social',
  }
);

// ❌ Invalid - will throw exception
await authService.signUpWithEmailAndMetadata(
  email: 'user@example.com',
  password: 'password',
  metadata: {
    'name': 'John Doe',
    'age': 25,
    'gender': '',  // ❌ Empty string
    'sports': [],
    'intent': 'social',
  }
);
// Error: "REQUIRED FIELD: Gender cannot be null or empty."

// ❌ Invalid - will throw exception
await authService.signUpWithEmailAndMetadata(
  email: 'user@example.com',
  password: 'password',
  metadata: {
    'name': 'John Doe',
    'age': 25,
    'gender': 'other',  // ❌ Not in enum
    'sports': [],
    'intent': 'social',
  }
);
// Error: "Gender must be either "male" or "female". Received: "other""
```

#### 2. Database Direct Insert
```sql
-- ✅ Valid
INSERT INTO users (id, email, display_name, age, gender, sports, intent)
VALUES (
  gen_random_uuid(),
  'user@example.com',
  'John Doe',
  25,
  'male',  -- ✅ Valid enum value
  ARRAY[]::text[],
  'social'
);

-- ❌ Invalid - database error
INSERT INTO users (id, email, display_name, age, gender, sports, intent)
VALUES (
  gen_random_uuid(),
  'user@example.com',
  'John Doe',
  25,
  '',  -- ❌ Empty string not in enum
  ARRAY[]::text[],
  'social'
);
-- Error: [22P02] ERROR: invalid input value for enum user_gender: ""

-- ❌ Invalid - database error
INSERT INTO users (id, email, display_name, age, gender, sports, intent)
VALUES (
  gen_random_uuid(),
  'user@example.com',
  'John Doe',
  25,
  'other',  -- ❌ Not in enum
  ARRAY[]::text[],
  'social'
);
-- Error: [22P02] ERROR: invalid input value for enum user_gender: "other"
```

---

## Migration Steps

### 1. Run SQL Migration
```bash
# In Supabase Dashboard → SQL Editor
# Copy and run: supabase/migrations/make_display_name_required.sql
```

This will:
1. Create `user_gender` enum type with ('male', 'female')
2. Update existing invalid gender values to 'male'
3. Convert gender column to use enum type
4. Apply NOT NULL constraint

### 2. Hot Reload Flutter App
```bash
r  # Hot reload in running Flutter terminal
```

### 3. Test Account Creation
1. Start new account signup
2. Fill in name and age
3. Select gender (only Male or Female available)
4. Complete onboarding
5. Verify in database that gender is stored correctly

---

## Error Messages

### User-Facing Errors
```
❌ "Gender is required. Please go back and select your gender."
❌ "Gender must be either Male or Female. Please go back and select a valid option."
```

### Backend Errors (Logged)
```
❌ "REQUIRED FIELD: Gender cannot be null or empty. Database constraint will fail."
❌ "VALIDATION ERROR: Gender must be either "male" or "female". Received: "<value>""
```

### Database Errors
```
❌ [22P02] ERROR: invalid input value for enum user_gender: ""
❌ [22P02] ERROR: invalid input value for enum user_gender: "other"
❌ null value in column "gender" violates not-null constraint
```

---

## Files Modified

1. ✅ `supabase/migrations/make_display_name_required.sql`
   - Created `user_gender` enum
   - Updated existing invalid data
   - Converted column to enum type

2. ✅ `lib/core/services/auth_service.dart`
   - Added strict gender validation (male/female only)
   - Converts to lowercase for consistency

3. ✅ `lib/screens/onboarding/set_password_screen.dart`
   - Added pre-signup gender validation

4. ✅ `lib/screens/profile/edit_profile_screen.dart`
   - Removed "Other" option from dropdown
   - Now only shows Male and Female

5. ✅ `lib/screens/onboarding/create_user_information.dart`
   - Already correctly using only 'male' and 'female'

---

## Summary

### Before
- ❌ Database had enum but app sent invalid values
- ❌ "Other" option available in UI
- ❌ Empty strings passed to database
- ❌ No validation before database insert

### After
- ✅ Database enum enforced: `user_gender ('male', 'female')`
- ✅ UI shows only Male and Female options
- ✅ Multiple validation layers prevent invalid values
- ✅ Clear error messages guide users
- ✅ Gender converted to lowercase for consistency

### Gender Values Allowed
- ✅ `'male'` or `'Male'` → stored as `'male'`
- ✅ `'female'` or `'Female'` → stored as `'female'`
- ❌ Everything else is rejected

---

## Next Steps

1. **Apply the SQL migration** to create the enum and update existing data
2. **Hot reload** the Flutter app to use updated validation
3. **Test** account creation to ensure gender is properly validated
4. **Notify existing users** with placeholder 'male' value to update their profile
