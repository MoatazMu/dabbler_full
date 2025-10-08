# Mandatory Fields NOT NULL Enforcement

## Overview
Enforces NOT NULL constraints on ALL mandatory user fields to ensure complete data collection during onboarding.

## Mandatory Fields (NOT NULL)

| Field | Type | Validation | Example |
|-------|------|------------|---------|
| `id` | UUID | From auth.users | `876177e5-5349-4ce4-8898-77df2c9ab867` |
| `email` | text | From auth.users | `user@example.com` |
| `display_name` | text | 2-50 characters | `John Doe` |
| `age` | integer | 13-120 | `25` |
| `gender` | user_gender (enum) | 'male' OR 'female' only | `male`, `female` |
| `sports` | text[] | Array (can be empty) | `['football', 'basketball']` or `[]` |
| `intent` | text | Not empty | `competitive`, `social`, `fitness` |

## Optional Field
| Field | Type | Note |
|-------|------|------|
| `avatar_url` | text | Has default value in database |

---

## 📋 SQL Migration Script

**File:** `supabase/migrations/make_display_name_required.sql`

### What it does:
1. **Updates existing NULL values** with placeholders
2. **Applies NOT NULL constraints** on all mandatory fields
3. **Adds check constraints** for data validation
4. **Creates indexes** for performance
5. **Verifies** all changes were successful

### To Apply:
1. Go to **Supabase Dashboard** → **SQL Editor**
2. Copy content from `supabase/migrations/make_display_name_required.sql`
3. Click **Run**
4. Check the output messages for verification

---

## 🔧 Code Changes

### 1. AuthService - Profile Creation
**File:** `lib/core/services/auth_service.dart`
**Method:** `_ensureUserProfileExists()`

**Validates ALL mandatory fields:**
```dart
// 1. display_name: 2-50 characters
if (displayName.length < 2 || displayName.length > 50) {
  throw Exception('Display name must be 2-50 characters');
}

// 2. age: 13-120
if (age < 13 || age > 120) {
  throw Exception('Age must be between 13 and 120');
}

// 3. gender: 'male' or 'female' only (database enum)
if (gender.trim().isEmpty) {
  throw Exception('Gender cannot be empty');
}
if (gender != 'male' && gender != 'female') {
  throw Exception('Gender must be "male" or "female"');
}

// 4. sports: must be array (can be empty)
if (sports is! List) {
  throw Exception('Sports must be an array');
}

// 5. intent: not empty
if (intent.trim().isEmpty) {
  throw Exception('Intent cannot be empty');
}
```

### 2. Onboarding - Pre-Signup Validation
**File:** `lib/screens/onboarding/set_password_screen.dart`

**Validates before calling signup:**
```dart
// All fields validated with helpful error messages
if (name == null || name.trim().isEmpty) {
  throw Exception('Name is required. Please go back and enter your name.');
}

if (age == null || age < 13 || age > 120) {
  throw Exception('Age must be between 13 and 120.');
}

if (gender == null || gender.trim().isEmpty) {
  throw Exception('Gender is required. Please go back and select your gender.');
}

final genderValue = gender.trim().toLowerCase();
if (genderValue != 'male' && genderValue != 'female') {
  throw Exception('Gender must be either Male or Female.');
}

if (intent == null || intent.trim().isEmpty) {
  throw Exception('Intent is required. Please go back and select.');
}
```

---

## 📊 Database Constraints Summary

### NOT NULL Constraints
All these fields CANNOT be NULL:
- ✅ `id`
- ✅ `email`
- ✅ `display_name`
- ✅ `age`
- ✅ `gender`
- ✅ `sports`
- ✅ `intent`

### Check Constraints
| Constraint Name | Rule |
|----------------|------|
| `display_name_not_empty` | 2-50 characters |
| `age_valid_range` | 13-120 years |
| `gender` (enum type) | Only 'male' or 'female' allowed |
| `intent_not_empty` | Length > 0 |

### Indexes Created
```sql
idx_users_display_name
idx_users_age
idx_users_gender
idx_users_sports (GIN index for array)
idx_users_intent
```

---

## 🧪 Testing

### 1. Database Tests

**Test NULL insertion (should fail):**
```sql
-- Should fail with NOT NULL constraint
INSERT INTO users (id, email, display_name) 
VALUES (gen_random_uuid(), 'test@test.com', NULL);
```

**Test invalid gender (should fail):**
```sql
-- Should fail with enum constraint
INSERT INTO users (id, email, display_name, age, gender, sports, intent) 
VALUES (gen_random_uuid(), 'test@test.com', 'Test User', 25, 'other', ARRAY[]::text[], 'social');
-- Error: invalid input value for enum user_gender: "other"

-- Should fail with enum constraint
INSERT INTO users (id, email, display_name, age, gender, sports, intent) 
VALUES (gen_random_uuid(), 'test@test.com', 'Test User', 25, '', ARRAY[]::text[], 'social');
-- Error: invalid input value for enum user_gender: ""
```

**Test valid insertion (should succeed):**
```sql
INSERT INTO users (id, email, display_name, age, gender, sports, intent) 
VALUES (
  gen_random_uuid(), 
  'test@test.com', 
  'Test User', 
  25, 
  'male', 
  ARRAY['football', 'basketball'], 
  'competitive'
);
```

### 2. App Tests

**Create New Account:**
1. Go through onboarding
2. Try to skip name → Should show error
3. Try to skip age → Should show error
4. Try to skip gender → Should show error
5. Try to skip intent → Should show error
6. Provide all fields → Should succeed
7. Check database: `SELECT * FROM users WHERE email = 'your@email.com'`
8. Verify all mandatory fields are populated

**Field Validation:**
- Name < 2 chars → Error
- Name > 50 chars → Error
- Age < 13 → Error
- Age > 120 → Error
- Empty gender → Error
- Gender not 'male' or 'female' → Error
- Empty intent → Error

---

## 🚨 Error Messages

### User-Facing (Onboarding)
```
❌ "Name is required. Please go back and enter your name."
❌ "Name must be at least 2 characters. Please go back and update."
❌ "Name must be 50 characters or less. Please go back and update."
❌ "Age is required. Please go back and enter your age."
❌ "Age must be between 13 and 120. Please go back and update."
❌ "Gender is required. Please go back and select your gender."
❌ "Gender must be either Male or Female. Please go back and select a valid option."
❌ "Intent is required. Please go back and select your intent."
```

### Backend (AuthService)
```
❌ "REQUIRED FIELD: Name cannot be null or empty. Database constraint will fail."
❌ "Display name must be at least 2 characters long"
❌ "Display name must be 50 characters or less"
❌ "REQUIRED FIELD: Age cannot be null. Database constraint will fail."
❌ "Age must be between 13 and 120"
❌ "REQUIRED FIELD: Gender cannot be null or empty. Database constraint will fail."
❌ "VALIDATION ERROR: Gender must be either \"male\" or \"female\". Received: \"<value>\""
❌ "Sports must be an array/list"
❌ "REQUIRED FIELD: Intent cannot be null or empty. Database constraint will fail."
```

### Database
```
❌ null value in column "display_name" violates not-null constraint
❌ null value in column "age" violates not-null constraint
❌ null value in column "gender" violates not-null constraint
❌ new row violates check constraint "age_valid_range"
❌ new row violates check constraint "display_name_not_empty"
❌ invalid input value for enum user_gender: ""
❌ invalid input value for enum user_gender: "other"
```

---

## 📝 Migration Steps

### Step 1: Run SQL Migration
```bash
# In Supabase Dashboard → SQL Editor
# Copy and run: supabase/migrations/make_display_name_required.sql
```

**Expected Output:**
```
NOTICE: NULL display_name count: 0
NOTICE: NULL age count: 0
NOTICE: NULL gender count: 0
NOTICE: NULL sports count: 0
NOTICE: NULL intent count: 0
NOTICE: ✅ All mandatory fields are populated!
```

### Step 2: Hot Reload App
```bash
# In terminal running Flutter
r  # Hot reload
```

### Step 3: Test
1. Create new account
2. Fill all onboarding fields
3. Check database for complete data
4. Try editing profile - all fields should be present

---

## 🔄 Data Flow

### Onboarding → Database
```
User Input (Screens)
   ↓
CreateUserInformation → name, age, gender
   ↓
SportsSelection → sports[]
   ↓
IntentSelection → intent
   ↓
SetPassword → Validates ALL fields
   ↓
AuthService.signUpWithEmailAndMetadata()
   ↓
AuthService._ensureUserProfileExists()
   ↓
Validates: display_name, age, gender, sports, intent
   ↓
INSERT INTO users (id, email, display_name, age, gender, sports, intent, ...)
   ↓
✅ Profile created with ALL mandatory data
```

---

## ✅ Success Criteria

After applying this migration:

1. **Database Level**
   - ✅ Cannot insert user without display_name
   - ✅ Cannot insert user without age (13-120)
   - ✅ Cannot insert user without gender
   - ✅ Cannot insert user without sports array
   - ✅ Cannot insert user without intent

2. **Application Level**
   - ✅ Onboarding validates all fields before signup
   - ✅ Clear error messages guide user
   - ✅ Profile creation validates all constraints
   - ✅ No silent failures

3. **User Experience**
   - ✅ Cannot complete signup without required info
   - ✅ Helpful error messages
   - ✅ Avatar is optional (has default)
   - ✅ Sports can be empty array initially

---

## 📦 Files Modified

1. ✅ `supabase/migrations/make_display_name_required.sql` - Complete migration for all fields
2. ✅ `lib/core/services/auth_service.dart` - Validates all mandatory fields
3. ✅ `lib/screens/onboarding/set_password_screen.dart` - Pre-signup validation

---

## 🎯 Summary

### Before
- ❌ Only some fields validated
- ❌ Users could be created with NULL data
- ❌ Database allowed incomplete profiles
- ❌ "Player" shown as fallback

### After
- ✅ ALL mandatory fields validated
- ✅ Database enforces NOT NULL + constraints
- ✅ Complete profiles on signup
- ✅ Users see their real data
- ✅ Clear validation at all levels

### Required Fields Enforced
1. ✅ `id` (UUID from auth)
2. ✅ `email` (from auth)
3. ✅ `display_name` (2-50 chars)
4. ✅ `age` (13-120)
5. ✅ `gender` (not empty)
6. ✅ `sports` (array, can be empty)
7. ✅ `intent` (not empty)

### Optional Field
- ✅ `avatar_url` (has database default)

---

## 🚀 Next Steps

1. **Run the SQL migration** (copy/paste from the file)
2. **Hot reload** the Flutter app
3. **Test** by creating a new account
4. **Verify** in database that all fields are populated
5. **Monitor** logs for any validation errors

All done! 🎉
