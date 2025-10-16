import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/notifications/data/notifications_repository.dart';

class NotificationNavigator {
  static Future<void> open(
    BuildContext context,
    NotificationItem notification,
  ) async {
    // First try action_route if it exists
    if (notification.actionRoute != null &&
        notification.actionRoute!.isNotEmpty) {
      final route = notification.actionRoute!;
      if (kDebugMode) {
        print('[NAV] Trying action_route: $route');
      }

      if (await _navigateToRoute(context, route)) {
        return;
      }
    }

    // Fallback to type-based routing
    final route = _getRouteFromType(notification.type, notification.data);
    if (route != null) {
      if (kDebugMode) {
        print('[NAV] Trying type-based route: $route');
      }

      if (await _navigateToRoute(context, route)) {
        return;
      }
    }

    // Default fallback to activities
    if (kDebugMode) {
      print('[NAV] Using default fallback to /activities');
    }
    await _navigateToRoute(context, '/activities');
  }

  static Future<bool> _navigateToRoute(
    BuildContext context,
    String route,
  ) async {
    try {
      context.push(route);
      if (kDebugMode) {
        print('[NAV] ✅ Successfully navigated to: $route');
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('[NAV] ❌ Navigation failed for $route: $e');
      }

      // Show "Coming soon" for unknown routes
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Coming soon'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
      }
      return false;
    }
  }

  static String? _getRouteFromType(
    NotificationType type,
    Map<String, dynamic>? data,
  ) {
    switch (type) {
      case NotificationType.friendRequest:
        return '/friends/requests';

      case NotificationType.gameInvite:
      case NotificationType.gameUpdate:
        final gameId = data?['game_id'] ?? data?['gameId'];
        if (gameId != null) {
          return '/game-detail/$gameId';
        }
        return '/activities';

      case NotificationType.bookingConfirmation:
      case NotificationType.bookingReminder:
        final bookingId = data?['booking_id'] ?? data?['bookingId'];
        if (bookingId != null) {
          return '/booking-detail/$bookingId';
        }
        return '/activities';

      case NotificationType.loyaltyPoints:
        return '/wallet/points';

      case NotificationType.achievement:
      case NotificationType.generalUpdate:
      case NotificationType.systemAlert:
        return '/activities';
    }
  }
}
