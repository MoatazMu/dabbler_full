import 'dart:async';
import 'package:dabbler/core/config/environment.dart';
import 'package:dabbler/themes/app_theme.dart';
import 'package:dabbler/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'app/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'widgets/app_background.dart';
import 'example/feed_example.dart';

// Feature flags for future functionality
class AppFeatures {
  static const bool enableReferralProgram = false; // ✅ Toggle for future use
  static const bool enableDeepLinks =
      enableReferralProgram; // Links to referral feature
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Disable inspector features for web debugging
  if (kIsWeb && kDebugMode) {
    debugProfileBuildsEnabled = false;
  }

  try {
    await Environment.load();

    await ThemeService().init();

    final anonKey = Environment.supabaseAnonKey;

    // Initialize Supabase with conditional deep link detection
    await Supabase.initialize(
      url: Environment.supabaseUrl,
      anonKey: anonKey,
      authOptions: FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
        detectSessionInUri: AppFeatures
            .enableDeepLinks, // ✅ Disabled for now, ready for referrals
        autoRefreshToken: true,
      ),
    );
    // Log the Supabase authorization token (JWT) after initialization
    final session = Supabase.instance.client.auth.currentSession;
    debugPrint('USER_JWT: ${session?.accessToken}');

    if (kDebugMode) {
      try {
        await demoFetchFeed();
      } catch (e, stack) {
        debugPrint('demoFetchFeed failed: $e');
        debugPrint(stack.toString());
      }
    }

    runApp(const ProviderScope(child: MyApp()));
  } catch (e) {
    // Log minimal error information without excessive debug output
    // ignore: avoid_print
    // ...existing code...
    // Still try to run the app even if there's an error
    runApp(const ProviderScope(child: MyApp()));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Use a single ThemeService instance to avoid recreating listeners on rebuilds
  static final ThemeService _themeService = ThemeService();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _themeService,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Dabbler',
          routerConfig: appRouter,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeService.effectiveThemeMode,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            // Mount a single global background behind all app content
            return Stack(
              children: [const AppBackground(), if (child != null) child],
            );
          },
        );
      },
    );
  }
}
