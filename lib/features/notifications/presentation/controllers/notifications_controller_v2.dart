import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/notifications_repository.dart';

/// State for notifications with pagination support
class NotificationsState {
  final List<NotificationItem> notifications;
  final bool isLoading;
  final bool hasMore;
  final String? error;
  final NotificationCursor? cursor;
  final int unreadCount;

  const NotificationsState({
    this.notifications = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.error,
    this.cursor,
    this.unreadCount = 0,
  });

  NotificationsState copyWith({
    List<NotificationItem>? notifications,
    bool? isLoading,
    bool? hasMore,
    String? error,
    NotificationCursor? cursor,
    int? unreadCount,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      error: error,
      cursor: cursor ?? this.cursor,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  List<NotificationItem> get unreadNotifications =>
      notifications.where((n) => !n.isRead).toList();
}

/// Controller for notifications with keyset pagination and realtime
class NotificationsController extends StateNotifier<NotificationsState> {
  final NotificationsRepository _repository;
  final String _userId;
  StreamSubscription<NotificationItem>? _realtimeSub;
  bool _isLoadingMore = false;

  NotificationsController({
    required NotificationsRepository repository,
    required String userId,
  }) : _repository = repository,
       _userId = userId,
       super(const NotificationsState()) {
    _init();
  }

  void _init() {
    if (kDebugMode) {
      print('[NOTIF] Initializing controller for user: $_userId');
    }

    // Load initial notifications
    loadNotifications();

    // Subscribe to realtime updates
    _realtimeSub = _repository
        .subscribeUserNotifications(_userId)
        .listen(
          (notification) {
            if (kDebugMode) {
              print(
                '[NOTIF] Realtime event: ${notification.id}, isRead: ${notification.isRead}',
              );
            }

            // Handle INSERT: prepend new notification
            if (!state.notifications.any(
              (item) => item.id == notification.id,
            )) {
              final updatedList = [notification, ...state.notifications];
              final unreadCount = updatedList.where((n) => !n.isRead).length;

              if (kDebugMode) {
                print(
                  '[NOTIF] Added new notification, total: ${updatedList.length}, unread: $unreadCount',
                );
              }

              state = state.copyWith(
                notifications: updatedList,
                unreadCount: unreadCount,
              );
            } else {
              // Handle UPDATE: patch existing item
              final index = state.notifications.indexWhere(
                (item) => item.id == notification.id,
              );
              if (index != -1) {
                final updatedList = [...state.notifications];
                updatedList[index] = notification;
                final unreadCount = updatedList.where((n) => !n.isRead).length;

                if (kDebugMode) {
                  print(
                    '[NOTIF] Updated notification at index $index, unread: $unreadCount',
                  );
                }

                state = state.copyWith(
                  notifications: updatedList,
                  unreadCount: unreadCount,
                );
              }
            }
          },
          onError: (error) {
            if (kDebugMode) {
              print('[NOTIF] Realtime error: $error');
            }
            state = state.copyWith(error: error.toString());
          },
        );
  }

  /// Load notifications (initial or refresh)
  Future<void> loadNotifications({bool refresh = false}) async {
    // Prevent overlapping requests
    if (state.isLoading || _isLoadingMore) {
      if (kDebugMode) {
        print('[NOTIF] Load already in progress, skipping');
      }
      return;
    }

    _isLoadingMore = true;

    if (refresh) {
      if (kDebugMode) {
        print('[NOTIF] Loading notifications (refresh)');
      }
      state = const NotificationsState(isLoading: true);
    } else {
      if (kDebugMode) {
        print('[NOTIF] Loading notifications (cursor: ${state.cursor?.id})');
      }
      state = state.copyWith(isLoading: true, error: null);
    }

    try {
      final notifications = await _repository.list(
        userId: _userId,
        limit: 20,
        cursor: refresh ? null : state.cursor,
      );

      if (kDebugMode) {
        print('[NOTIF] Loaded ${notifications.length} notifications');
      }

      if (notifications.isEmpty) {
        state = state.copyWith(isLoading: false, hasMore: false);
      } else {
        // Deduplicate by ID when merging new pages
        final existingIds = state.notifications.map((n) => n.id).toSet();
        final newNotifications = notifications
            .where((n) => !existingIds.contains(n.id))
            .toList();

        final updatedList = refresh
            ? notifications
            : [...state.notifications, ...newNotifications];
        final unreadCount = updatedList.where((n) => !n.isRead).length;

        if (kDebugMode) {
          print(
            '[NOTIF] After dedup: ${newNotifications.length} new, total: ${updatedList.length}',
          );
        }

        state = state.copyWith(
          notifications: updatedList,
          cursor: notifications.last.cursor,
          isLoading: false,
          hasMore: notifications.length >= 20,
          unreadCount: unreadCount,
          error: null,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('[NOTIF] Load error: $e');
      }
      state = state.copyWith(isLoading: false, error: e.toString());
    } finally {
      _isLoadingMore = false;
    }
  }

  /// Load more notifications (pagination)
  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;
    await loadNotifications();
  }

  /// Refresh notifications (pull to refresh)
  Future<void> refresh() async {
    await loadNotifications(refresh: true);
  }

  /// Mark notification as read (optimistic update)
  Future<void> markAsRead(String notificationId) async {
    if (kDebugMode) {
      print('[NOTIF] Marking as read: $notificationId');
    }

    // Find the notification
    final index = state.notifications.indexWhere((n) => n.id == notificationId);
    if (index == -1) {
      if (kDebugMode) {
        print('[NOTIF] Notification not found: $notificationId');
      }
      return;
    }

    final notification = state.notifications[index];
    if (notification.isRead) {
      if (kDebugMode) {
        print('[NOTIF] Notification already read: $notificationId');
      }
      return;
    }

    // Optimistic update: immediately update local state
    final updatedList = [...state.notifications];
    updatedList[index] = notification.copyWith(
      isRead: true,
      readAt: DateTime.now(),
    );
    final unreadCount = updatedList.where((n) => !n.isRead).length;

    state = state.copyWith(
      notifications: updatedList,
      unreadCount: unreadCount,
    );

    if (kDebugMode) {
      print('[NOTIF] Optimistic update applied, unread: $unreadCount');
    }

    // Then sync to server
    try {
      await _repository.markRead(notificationId: notificationId);
      if (kDebugMode) {
        print('[NOTIF] Server sync successful: $notificationId');
      }
      // Realtime subscription will confirm the update
    } catch (e) {
      if (kDebugMode) {
        print('[NOTIF] Server sync failed: $e');
      }

      // Rollback on failure
      final rollbackList = [...state.notifications];
      rollbackList[index] = notification;
      final rollbackUnread = rollbackList.where((n) => !n.isRead).length;

      state = state.copyWith(
        notifications: rollbackList,
        unreadCount: rollbackUnread,
        error: e.toString(),
      );

      if (kDebugMode) {
        print('[NOTIF] Rolled back optimistic update');
      }

      // Rethrow so UI can handle
      rethrow;
    }
  }

  /// Mark all notifications as read (optimistic update)
  Future<void> markAllAsRead() async {
    if (kDebugMode) {
      print('[NOTIF] Marking all as read');
    }

    final unreadNotifications = state.notifications
        .where((n) => !n.isRead)
        .toList();
    if (unreadNotifications.isEmpty) {
      if (kDebugMode) {
        print('[NOTIF] No unread notifications');
      }
      return;
    }

    if (kDebugMode) {
      print(
        '[NOTIF] Marking ${unreadNotifications.length} notifications as read',
      );
    }

    // Optimistic update: mark all as read locally
    final now = DateTime.now();
    final updatedList = state.notifications.map((n) {
      if (!n.isRead) {
        return n.copyWith(isRead: true, readAt: now);
      }
      return n;
    }).toList();

    state = state.copyWith(notifications: updatedList, unreadCount: 0);

    if (kDebugMode) {
      print('[NOTIF] Optimistic update applied, unread: 0');
    }

    // Then sync to server
    try {
      await _repository.markAllReadForUser(userId: _userId);
      if (kDebugMode) {
        print('[NOTIF] Mark all as read successful');
      }
      // Realtime subscription will confirm updates
    } catch (e) {
      if (kDebugMode) {
        print('[NOTIF] Mark all as read failed: $e');
      }

      // Rollback on failure
      state = state.copyWith(
        notifications: state.notifications,
        unreadCount: unreadNotifications.length,
        error: e.toString(),
      );

      if (kDebugMode) {
        print('[NOTIF] Rolled back mark all as read');
      }

      // Rethrow so UI can handle
      rethrow;
    }
  }

  /// Delete notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _repository.delete(notificationId: notificationId);

      // Remove from local state
      final updatedList = state.notifications
          .where((n) => n.id != notificationId)
          .toList();
      final unreadCount = updatedList.where((n) => !n.isRead).length;

      state = state.copyWith(
        notifications: updatedList,
        unreadCount: unreadCount,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Filter notifications by type
  List<NotificationItem> filterByType(NotificationType? type) {
    if (type == null) return state.notifications;
    return state.notifications.where((n) => n.type == type).toList();
  }

  /// Filter notifications by priority
  List<NotificationItem> filterByPriority(NotificationPriority? priority) {
    if (priority == null) return state.notifications;
    return state.notifications.where((n) => n.priority == priority).toList();
  }

  /// Filter unread notifications
  List<NotificationItem> get unreadNotifications {
    return state.notifications.where((n) => !n.isRead).toList();
  }

  @override
  void dispose() {
    _realtimeSub?.cancel();
    super.dispose();
  }
}
