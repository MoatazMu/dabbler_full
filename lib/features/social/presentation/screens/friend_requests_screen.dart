import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../repositories/friendships_repo.dart';
import '../../../../models/friendships.dart';

/// Provider to fetch pending friend requests for current user
final pendingFriendRequestsProvider =
    FutureProvider.autoDispose<List<Friendships>>((ref) async {
      final client = Supabase.instance.client;
      final currentUserId = client.auth.currentUser?.id;

      if (currentUserId == null) {
        throw Exception('User must be authenticated');
      }

      final repo = FriendshipsRepo(client);
      return repo.getPendingFriendRequests(currentUserId);
    });

/// Provider to count pending friend requests
final pendingFriendRequestsCountProvider = FutureProvider.autoDispose<int>((
  ref,
) async {
  final client = Supabase.instance.client;
  final currentUserId = client.auth.currentUser?.id;

  if (currentUserId == null) {
    return 0;
  }

  final repo = FriendshipsRepo(client);
  return repo.getPendingFriendRequestsCount(currentUserId);
});

/// Provider to fetch user info for a friend request
final friendRequestUserProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>?, String>((ref, userId) async {
      final client = Supabase.instance.client;

      try {
        final response = await client
            .from('users_public')
            .select('id, display_name, avatar_url')
            .eq('id', userId)
            .maybeSingle();

        return response;
      } catch (e) {
        return null;
      }
    });

/// State notifier for managing friend request actions with optimistic updates
class FriendRequestActionController extends StateNotifier<AsyncValue<String?>> {
  final FriendshipsRepo _repo;
  bool _isProcessing = false;

  FriendRequestActionController(this._repo)
    : super(const AsyncValue.data(null));

  Future<void> acceptRequest(String friendshipId) async {
    // Prevent overlapping requests
    if (_isProcessing) return;

    _isProcessing = true;

    if (kDebugMode) {
      print('[FRIEND] acceptRequest - start: friendshipId=$friendshipId');
    }

    // Optimistic update: immediately show success
    state = const AsyncValue.data('Friend request accepted!');

    try {
      await _repo.acceptFriendById(friendshipId);
      // Confirm success
      state = const AsyncValue.data('Friend request accepted!');

      if (kDebugMode) {
        print('[FRIEND] acceptRequest - success: friendshipId=$friendshipId');
      }
    } catch (e, stack) {
      if (kDebugMode) {
        print('[FRIEND] acceptRequest - error: $e');
      }
      // Rollback on failure
      state = AsyncValue.error(e, stack);
      rethrow; // Let UI handle error
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> rejectRequest(String friendshipId) async {
    if (_isProcessing) return;

    _isProcessing = true;

    if (kDebugMode) {
      print('[FRIEND] rejectRequest - start: friendshipId=$friendshipId');
    }

    // Optimistic update
    state = const AsyncValue.data('Friend request declined');

    try {
      await _repo.rejectFriendRequest(friendshipId);
      // Confirm success
      state = const AsyncValue.data('Friend request declined');

      if (kDebugMode) {
        print('[FRIEND] rejectRequest - success: friendshipId=$friendshipId');
      }
    } catch (e, stack) {
      if (kDebugMode) {
        print('[FRIEND] rejectRequest - error: $e');
      }
      // Rollback on failure
      state = AsyncValue.error(e, stack);
      rethrow;
    } finally {
      _isProcessing = false;
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

final friendRequestActionControllerProvider =
    StateNotifierProvider.autoDispose<
      FriendRequestActionController,
      AsyncValue<String?>
    >((ref) {
      final client = Supabase.instance.client;
      final repo = FriendshipsRepo(client);
      return FriendRequestActionController(repo);
    });

/// Friend Requests Screen - Shows all pending friend requests
class FriendRequestsScreen extends ConsumerWidget {
  const FriendRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(pendingFriendRequestsProvider);

    // Listen to action controller for feedback
    ref.listen(friendRequestActionControllerProvider, (previous, next) {
      next.whenOrNull(
        data: (message) {
          if (message != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
            // Refresh the list after action
            ref.invalidate(pendingFriendRequestsProvider);
            ref.invalidate(pendingFriendRequestsCountProvider);
            ref.read(friendRequestActionControllerProvider.notifier).reset();
          }
        },
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${error.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
          ref.read(friendRequestActionControllerProvider.notifier).reset();
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Friend Requests'), elevation: 0),
      body: requestsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  LucideIcons.alertCircle,
                  size: 48,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Error Loading Requests',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () =>
                      ref.invalidate(pendingFriendRequestsProvider),
                  icon: const Icon(LucideIcons.refreshCw),
                  label: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (requests) {
          if (requests.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      LucideIcons.userCheck,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No Friend Requests',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'You don\'t have any pending friend requests',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(pendingFriendRequestsProvider);
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: requests.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final request = requests[index];
                return _FriendRequestCard(request: request);
              },
            ),
          );
        },
      ),
    );
  }
}

/// Individual Friend Request Card
class _FriendRequestCard extends ConsumerWidget {
  final Friendships request;

  const _FriendRequestCard({required this.request});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(friendRequestUserProvider(request.user_id));
    final actionState = ref.watch(friendRequestActionControllerProvider);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: userAsync.when(
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, _) => ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: const Icon(LucideIcons.user, color: Colors.grey),
            ),
            title: const Text('Unknown User'),
            subtitle: Text('Error: ${error.toString()}'),
          ),
          data: (userData) {
            if (userData == null) {
              return const ListTile(
                leading: CircleAvatar(child: Icon(LucideIcons.user)),
                title: Text('Unknown User'),
              );
            }

            final displayName =
                userData['display_name'] as String? ?? 'Unknown';
            final avatarUrl = userData['avatar_url'] as String?;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Info Row
                InkWell(
                  onTap: () {
                    context.push('/social-profile/${request.user_id}');
                  },
                  child: Row(
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: avatarUrl != null
                            ? NetworkImage(avatarUrl)
                            : null,
                        child: avatarUrl == null
                            ? Text(
                                displayName.isNotEmpty
                                    ? displayName[0].toUpperCase()
                                    : '?',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: 12),

                      // Name and Time
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              displayName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _formatTimeAgo(request.created_at),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // View Profile Button
                      IconButton(
                        icon: const Icon(LucideIcons.externalLink, size: 18),
                        onPressed: () {
                          context.push('/social-profile/${request.user_id}');
                        },
                        tooltip: 'View Profile',
                      ),
                    ],
                  ),
                ),

                // Message (if exists)
                if (request.message != null && request.message!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      request.message!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 16),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: actionState.isLoading
                            ? null
                            : () async {
                                try {
                                  await ref
                                      .read(
                                        friendRequestActionControllerProvider
                                            .notifier,
                                      )
                                      .acceptRequest(request.id);
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Failed to accept request: $e',
                                        ),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                }
                              },
                        icon: actionState.isLoading
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(LucideIcons.userCheck, size: 18),
                        label: const Text('Accept'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: actionState.isLoading
                            ? null
                            : () {
                                _showDeclineDialog(context, ref, request.id);
                              },
                        icon: const Icon(LucideIcons.x, size: 18),
                        label: const Text('Decline'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showDeclineDialog(
    BuildContext context,
    WidgetRef ref,
    String friendshipId,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Decline Friend Request'),
        content: const Text(
          'Are you sure you want to decline this friend request?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              try {
                await ref
                    .read(friendRequestActionControllerProvider.notifier)
                    .rejectRequest(friendshipId);
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to decline request: $e'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Decline'),
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
}
