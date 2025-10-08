# Dabbler - AI Agent Instructions

## Project Overview
Dabbler is a Flutter mobile app for social gaming experiences with **phone-first authentication**. Uses **Clean Architecture** with feature-based modules, **Riverpod** for state management, **Supabase** for backend, and **GoRouter** for navigation.

## Architecture Patterns

### Feature Structure
```
lib/features/{feature}/
├── data/          # Data sources, repositories impl
├── domain/        # Entities, use cases, repo interfaces  
├── presentation/  # UI, controllers, providers
└── services/      # Feature-specific services
```

### Key Services
- **AuthService**: Singleton at `lib/core/services/auth_service.dart` - use directly, not via providers
- **ThemeService**: Global theme management with persistence
- **Environment**: Config management via `.env` file

### State Management
- **Riverpod** providers in `{feature}/presentation/providers/`
- **StateNotifierProvider** for complex state (AuthController, RegisterController)
- **Provider** for simple derivations (isAuthenticated, currentUser)

## Authentication Flow (Critical)

**Phone-first onboarding**: 
1. Splash → `PhoneInputScreen` (not LoginScreen!)
2. Phone → OTP → Profile creation OR existing user flow
3. "Continue with Email" switches to `EmailInputScreen`
4. Both screens can switch between each other

**Router redirects**: Unauthenticated users → `/phone-input` (defined in `app_router.dart`)

### Auth Implementation
```dart
// Use AuthService directly (singleton)
final authService = AuthService();
await authService.signInWithEmail(email: email, password: password);

// Check auth state via providers
final isAuth = ref.watch(isAuthenticatedProvider);
```

## Development Workflows

### Environment Setup
```bash
# Required .env variables
SUPABASE_URL=your_url
SUPABASE_ANON_KEY=your_key  
APP_NAME=Dabbler
ENVIRONMENT=development
```

### Testing
```bash
flutter test                          # Unit tests
flutter test --coverage              # With coverage
scripts/run_integration_tests.sh     # Integration tests
```

### Key Commands
```bash
flutter pub get                      # Dependencies
flutter clean && flutter pub get    # Reset deps
flutter run                         # Dev server
flutter build apk --release         # Android build
```

## Navigation & Routing

**GoRouter** configuration in `lib/app/app_router.dart`:
- Routes defined as static list `_routes`
- Auth redirects in `_handleRedirect()`
- Route constants in `utils/constants/route_constants.dart`

### Navigation Patterns
```dart
context.go('/phone-input');           # Direct navigation
context.go('/profile', extra: userId); # With parameters
```

## Code Conventions

### File Organization
- `lib/screens/` - Simple screens (onboarding, home)
- `lib/features/` - Complex features with Clean Architecture
- `lib/core/` - Shared services, config, utilities
- `lib/widgets/` - Reusable UI components

### Import Style
```dart
// External packages first
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Relative imports
import '../services/auth_service.dart';
import '../../utils/constants.dart';
```

### Error Handling
- Use try-catch with specific error types
- Display user-friendly messages via SnackBar
- Log detailed errors for debugging (avoid `print` in production)

## Common Pitfalls

1. **Don't use LoginScreen** - removed, use phone-first flow
2. **AuthService is singleton** - call `AuthService()` directly, no provider needed
3. **Route redirects** - check `app_router.dart` `_handleRedirect()` for auth logic
4. **Environment vars** - must be in `.env`, validated on startup
5. **Phone validation** - UAE format required: `5XXXXXXXX` (9 digits starting with 5)

## Integration Points

- **Supabase**: Auth, database, real-time subscriptions
- **Image uploads**: via `image_picker` → Supabase Storage
- **Push notifications**: Firebase (via Supabase)
- **Maps/Location**: `geolocator` + `geocoding` for venue features

## Testing Strategy

- **Unit tests**: Domain logic, services
- **Widget tests**: UI components
- **Integration tests**: Full user flows in `integration_test/`
- **Mocking**: Use test doubles for Supabase calls
