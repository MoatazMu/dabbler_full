import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;
import '../controllers/auth_controller.dart';
import '../controllers/register_controller.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/auth_session.dart';
import '../../../../core/services/auth_service.dart';

// Use the working AuthService instead of unimplemented repository
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// Router refresh notifier - notifies router when auth state changes
class RouterRefreshNotifier extends ChangeNotifier {
  static final _instance = RouterRefreshNotifier._internal();
  factory RouterRefreshNotifier() => _instance;
  RouterRefreshNotifier._internal();

  void notifyAuthStateChanged() {
    print(
      '🔄 [DEBUG] RouterRefreshNotifier: Notifying router of auth state change',
    );
    print('🔄 [DEBUG] RouterRefreshNotifier: Has listeners: $hasListeners');
    notifyListeners();
  }
}

// Global instance for easier access
final routerRefreshNotifier = RouterRefreshNotifier();

final routerRefreshProvider = Provider<RouterRefreshNotifier>((ref) {
  return routerRefreshNotifier;
});

// Simple auth state provider that works with AuthService
final simpleAuthProvider =
    StateNotifierProvider<SimpleAuthNotifier, SimpleAuthState>((ref) {
      return SimpleAuthNotifier(ref.read(authServiceProvider));
    });

// Simple auth state
class SimpleAuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final bool isGuest;
  final String? error;

  const SimpleAuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.isGuest = false,
    this.error,
  });

  SimpleAuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    bool? isGuest,
    String? error,
  }) {
    return SimpleAuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      isGuest: isGuest ?? this.isGuest,
      error: error ?? this.error,
    );
  }
}

// Simple auth notifier that works with AuthService
class SimpleAuthNotifier extends StateNotifier<SimpleAuthState> {
  final AuthService _authService;
  StreamSubscription<supa.AuthState>? _authSubscription;
  bool _isCheckingAuth = false;

  SimpleAuthNotifier(this._authService) : super(const SimpleAuthState()) {
    print('🔐 [DEBUG] SimpleAuthNotifier: Constructor called');
    _setupAuthListener();
    Future.microtask(() async {
      await _checkAuthState();
    });
    print('🔐 [DEBUG] SimpleAuthNotifier: Constructor completed');
  }

  Future<void> _checkAuthState() async {
    if (_isCheckingAuth) {
      print(
        '🔐 [DEBUG] SimpleAuthNotifier: _checkAuthState skipped (already running)',
      );
      return;
    }
    _isCheckingAuth = true;
    print('🔐 [DEBUG] SimpleAuthNotifier: _checkAuthState started');
    print(
      '🔐 [DEBUG] SimpleAuthNotifier: Current state before check - authenticated: ${state.isAuthenticated}',
    );
    state = state.copyWith(isLoading: true, error: null);

    try {
      print(
        '🔐 [DEBUG] SimpleAuthNotifier: Calling _authService.isAuthenticated()',
      );
      final isAuthenticated = _authService.isAuthenticated();
      print('🔐 [DEBUG] SimpleAuthNotifier: Auth result: $isAuthenticated');

      // Also check if we have a current user for additional verification
      final currentUser = _authService.getCurrentUser();
      print(
        '🔐 [DEBUG] SimpleAuthNotifier: Current user: ${currentUser?.email ?? 'None'}',
      );

      // Double check - if we have a user but isAuthenticated is false, something's wrong
      final finalAuthState = isAuthenticated && currentUser != null;
      print('🔐 [DEBUG] SimpleAuthNotifier: Final auth state: $finalAuthState');

      final previousState = state.isAuthenticated;
      state = state.copyWith(
        isAuthenticated: finalAuthState,
        isLoading: false,
        isGuest: false, // Clear guest mode when checking auth
        error: null,
      );
      print(
        '🔐 [DEBUG] SimpleAuthNotifier: State updated - was: $previousState, now: $finalAuthState',
      );

      // Only notify router if auth state actually changed
      if (previousState != finalAuthState) {
        print(
          '🔐 [DEBUG] SimpleAuthNotifier: Auth state changed, notifying router...',
        );
        routerRefreshNotifier.notifyAuthStateChanged();
      } else {
        print(
          '🔐 [DEBUG] SimpleAuthNotifier: Auth state unchanged, not notifying router',
        );
      }
    } catch (e) {
      print('❌ [DEBUG] SimpleAuthNotifier: Error checking auth state: $e');
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        error: e.toString(),
      );
    }
    _isCheckingAuth = false;
  }

  void _setupAuthListener() {
    print('🔐 [DEBUG] SimpleAuthNotifier: Setting up auth listener');
    _authSubscription?.cancel();
    _authSubscription = supa.Supabase.instance.client.auth.onAuthStateChange.listen((
      data,
    ) async {
      final event = data.event;
      print('🔐 [DEBUG] SimpleAuthNotifier: Auth event received -> $event');

      if (event == supa.AuthChangeEvent.signedOut) {
        final wasAuthenticated = state.isAuthenticated;
        state = const SimpleAuthState();
        if (wasAuthenticated) {
          routerRefreshNotifier.notifyAuthStateChanged();
        }
        return;
      }

      // For signedIn/tokenRefreshed/userUpdated/initialSession ensure state reflects persisted session
      await _checkAuthState();

      // If the restored session is missing (e.g. app resumed) try a refresh once
      if (!state.isAuthenticated &&
          event == supa.AuthChangeEvent.initialSession) {
        print(
          '🔐 [DEBUG] SimpleAuthNotifier: Initial session missing, attempting refresh',
        );
        await _authService.refreshSession();
        await _checkAuthState();
      }
    });
  }

  // Initialize auth state when needed
  Future<void> initialize() async {
    print('🔐 [DEBUG] SimpleAuthNotifier: initialize called');
    await _checkAuthState();
  }

  // Set guest mode
  Future<void> setGuestMode() async {
    print('👤 [DEBUG] SimpleAuthNotifier: Setting guest mode');
    state = state.copyWith(
      isAuthenticated: false,
      isGuest: true,
      isLoading: false,
      error: null,
    );
    print('👤 [DEBUG] SimpleAuthNotifier: Guest mode set successfully');

    // Notify router of auth state change
    RouterRefreshNotifier().notifyAuthStateChanged();
  }

  // Sign in as guest
  Future<void> signInAsGuest() async {
    print('👤 [DEBUG] SimpleAuthNotifier: Signing in as guest');
    try {
      // Set guest mode without authentication
      await setGuestMode();
      print('👤 [DEBUG] SimpleAuthNotifier: Guest sign in successful');
    } catch (e) {
      print('❌ [DEBUG] SimpleAuthNotifier: Guest sign in failed: $e');
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      state = const SimpleAuthState();

      // Notify router of auth state change
      routerRefreshNotifier.notifyAuthStateChanged();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> refreshAuthState() async {
    print('🔐 [DEBUG] SimpleAuthNotifier: refreshAuthState called');
    await _checkAuthState();
  }

  // Handle successful login - force a state refresh
  Future<void> handleSuccessfulLogin() async {
    print('🔐 [DEBUG] SimpleAuthNotifier: handleSuccessfulLogin called');
    print(
      '🔐 [DEBUG] SimpleAuthNotifier: State before login handling - authenticated: ${state.isAuthenticated}',
    );

    // Add a small delay to ensure Supabase session is fully established
    await Future.delayed(const Duration(milliseconds: 100));

    await _checkAuthState();

    // If still not authenticated after the check, there might be a session issue
    if (!state.isAuthenticated) {
      print(
        '⚠️ [DEBUG] SimpleAuthNotifier: Still not authenticated after login, retrying...',
      );
      await Future.delayed(const Duration(milliseconds: 500));
      await _checkAuthState();

      // Final check - if still not authenticated, something is seriously wrong
      if (!state.isAuthenticated) {
        print(
          '❌ [DEBUG] SimpleAuthNotifier: CRITICAL - Still not authenticated after retry!',
        );
      }
    } else {
      print(
        '✅ [DEBUG] SimpleAuthNotifier: Login handling successful - now authenticated',
      );
    }
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}

// Repository providers - keeping for compatibility but using working implementation
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  // TODO: Implement actual repository
  throw UnimplementedError('AuthRepository not implemented');
});

// Use case providers
final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return GetCurrentUserUseCase(repository);
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return LogoutUseCase(repository);
});

// Controller providers
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    final getCurrentUser = ref.read(getCurrentUserUseCaseProvider);
    return AuthController(getCurrentUser: getCurrentUser);
  },
);

final registerControllerProvider =
    StateNotifierProvider<RegisterController, RegisterFormState>((ref) {
      // TODO: Implement RegisterUseCase
      throw UnimplementedError('RegisterUseCase not implemented');
      // return RegisterController(registerUseCase);
    });

// Convenience providers - now using the working simple auth provider
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(simpleAuthProvider);
  return authState.isAuthenticated;
});

final isGuestProvider = Provider<bool>((ref) {
  final authState = ref.watch(simpleAuthProvider);
  return authState.isGuest;
});

final guestSignInProvider = Provider<Future<void> Function()>((ref) {
  final authNotifier = ref.read(simpleAuthProvider.notifier);
  return () => authNotifier.signInAsGuest();
});

final currentUserProvider = Provider<User?>((ref) {
  // For now, return null since we're using simple auth
  // TODO: Implement when full auth system is ready
  return null;
});

final authSessionProvider = Provider<AuthSession?>((ref) {
  // For now, return null since we're using simple auth
  // TODO: Implement when full auth system is ready
  return null;
});

final authLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(simpleAuthProvider);
  return authState.isLoading;
});

final authErrorProvider = Provider<String?>((ref) {
  final authState = ref.watch(simpleAuthProvider);
  return authState.error;
});
