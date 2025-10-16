import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../widgets/friend_action_button.dart';

import '../../../../../models/friendships.dart';
import '../../../../../repositories/friendships_repo.dart';
import '../../../../../utils/constants/route_constants.dart';
import '../../../../profile/domain/entities/user_profile.dart';
import '../../../../profile/domain/entities/profile_statistics.dart';
import '../../../../profile/presentation/providers/profile_providers_simple.dart';
import '../../../data/models/post_model.dart';
import '../../widgets/feed/post_card.dart';

// Provider to fetch user profile data
final socialProfileProvider = FutureProvider.autoDispose
    .family<UserProfile?, String>((ref, userId) async {
      final getProfile = ref.watch(getProfileUseCaseProvider);
      var profile = await getProfile(userId);

      if (profile != null) {
        return profile;
      }

      final client = Supabase.instance.client;
      try {
        final publicData = await client
            .from('users_public')
            .select()
            .eq('id', userId)
            .maybeSingle();

        if (publicData == null) {
          return null;
        }

        final now = DateTime.now();
        profile = UserProfile(
          id: publicData['id'] as String,
          email: '',
          displayName: publicData['display_name'] as String? ?? 'User',
          avatarUrl: publicData['avatar_url'] as String?,
          createdAt: publicData['created_at'] != null
              ? DateTime.parse(publicData['created_at'] as String)
              : now,
          updatedAt: now,
          profileCompletionPercentage:
              (publicData['profile_completion_percentage'] as num?)
                  ?.toDouble() ??
              0.0,
          statistics: ProfileStatistics(
            totalGamesPlayed: publicData['games_played'] as int? ?? 0,
          ),
        );
        return profile;
      } catch (e) {
        return null;
      }
    });

// Provider to fetch user's posts
final socialProfilePostsProvider = FutureProvider.autoDispose
    .family<List<PostModel>, String>((ref, userId) async {
      final client = Supabase.instance.client;
      try {
        final response = await client
            .from('posts')
            .select(
              'id, author_id, content, media_urls, created_at, updated_at, visibility, likes_count, comments_count, shares_count, location_name, tags, author:users_public(id, display_name, avatar_url)',
            )
            .eq('author_id', userId)
            .eq('is_deleted', false)
            .order('created_at', ascending: false)
            .limit(20);

        final data = (response as List<dynamic>).cast<Map<String, dynamic>>();
        return data
            .map((row) => PostModel.fromJson(row))
            .toList(growable: false);
      } catch (error, stackTrace) {
        Error.throwWithStackTrace(
          Exception('Failed to load profile posts'),
          stackTrace,
        );
      }
    });

// Friendships repository provider
final friendshipsRepoProvider = Provider<FriendshipsRepo>((ref) {
  return FriendshipsRepo(Supabase.instance.client);
});

// Provider to check friendship status between current user and profile user
final friendshipStatusProvider = FutureProvider.autoDispose
    .family<Friendships?, String>((ref, friendId) async {
      final client = Supabase.instance.client;
      final currentUserId = client.auth.currentUser?.id;

      if (currentUserId == null || currentUserId == friendId) {
        return null;
      }

      final repo = ref.watch(friendshipsRepoProvider);
      return repo.getFriendshipRecord(me: currentUserId, other: friendId);
    });

// State notifier for managing friend request actions with optimistic updates
class FriendRequestController extends StateNotifier<AsyncValue<String?>> {
  final FriendshipsRepo _repo;
  bool _isProcessing = false;

  FriendRequestController(this._repo) : super(const AsyncValue.data(null));

  Future<void> sendFriendRequest(String friendId, {String? message}) async {
    // Prevent overlapping requests
    if (_isProcessing) {
      if (kDebugMode) {
        print(
          '[FRIEND] sendFriendRequest - blocked, already processing: friendId=$friendId',
        );
      }
      return;
    }

    _isProcessing = true;

    if (kDebugMode) {
      print('[FRIEND] sendFriendRequest - start: friendId=$friendId');
    }

    // Optimistic update: immediately show success state
    state = const AsyncValue.data('Friend request sent!');

    try {
      final currentUserId = Supabase.instance.client.auth.currentUser?.id;

      if (currentUserId == null) {
        throw Exception('Not authenticated');
      }

      try {
        await _repo.sendFriendRequest(
          me: currentUserId,
          other: friendId,
        );
      } catch (insertError) {
        final errorString = insertError.toString();

        if (errorString.contains('already exists') ||
            errorString.contains('P0001') ||
            errorString.contains('duplicate')) {
          state = const AsyncValue.data('Friend request already pending');
          if (kDebugMode) {
            print(
              '[FRIEND] sendFriendRequest - duplicate detected: friendId=$friendId',
            );
          }
          return;
        }

        try {
          await _repo.sendFriendRequestViaFunction(
            friendId: friendId,
            message: message,
          );
        } catch (rpcError) {
          final rpcErrorString = rpcError.toString();
          if (rpcErrorString.contains('already exists') ||
              rpcErrorString.contains('P0001') ||
              rpcErrorString.contains('duplicate')) {
            state = const AsyncValue.data('Friend request already pending');
            if (kDebugMode) {
              print(
                '[FRIEND] sendFriendRequest - duplicate detected via RPC: friendId=$friendId',
              );
            }
            return;
          }
          rethrow;
        }
      }

      // Confirm success
      state = const AsyncValue.data('Friend request sent!');

      if (kDebugMode) {
        print('[FRIEND] sendFriendRequest - success: friendId=$friendId');
      }
    } catch (e, stack) {
      if (kDebugMode) {
        print('[FRIEND] sendFriendRequest - error: $e');
      }
      // Rollback on failure
      state = AsyncValue.error(e, stack);
      rethrow; // Let UI handle error
    } finally {
      _isProcessing = false;
      if (kDebugMode) {
        print(
          '[FRIEND] sendFriendRequest - processing finished: friendId=$friendId',
        );
      }
    }
  }

  Future<void> removeFriendship(String friendshipId) async {
    if (_isProcessing) return;

    _isProcessing = true;

    if (kDebugMode) {
      print('[FRIEND] removeFriendship - start: friendshipId=$friendshipId');
    }

    // Optimistic update
    state = const AsyncValue.data('Friendship removed');

    try {
      await _repo.removeFriendById(friendshipId);
      // Confirm success
      state = const AsyncValue.data('Friendship removed');

      if (kDebugMode) {
        print(
          '[FRIEND] removeFriendship - success: friendshipId=$friendshipId',
        );
      }
    } catch (e, stack) {
      if (kDebugMode) {
        print('[FRIEND] removeFriendship - error: $e');
      }
      // Rollback on failure
      state = AsyncValue.error(e, stack);
      rethrow;
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> acceptFriendRequest(String friendshipId) async {
    if (_isProcessing) return;

    _isProcessing = true;

    if (kDebugMode) {
      print('[FRIEND] acceptFriendRequest - start: friendshipId=$friendshipId');
    }

    // Optimistic update
    state = const AsyncValue.data('Friend request accepted!');

    try {
      await _repo.acceptFriendById(friendshipId);
      // Confirm success
      state = const AsyncValue.data('Friend request accepted!');

      if (kDebugMode) {
        print(
          '[FRIEND] acceptFriendRequest - success: friendshipId=$friendshipId',
        );
      }
    } catch (e, stack) {
      if (kDebugMode) {
        print('[FRIEND] acceptFriendRequest - error: $e');
      }
      // Rollback on failure
      state = AsyncValue.error(e, stack);
      rethrow;
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> rejectFriendRequest(String friendshipId) async {
    if (_isProcessing) return;

    _isProcessing = true;

    if (kDebugMode) {
      print('[FRIEND] rejectFriendRequest - start: friendshipId=$friendshipId');
    }

    // Optimistic update
    state = const AsyncValue.data('Friend request declined');

    try {
      await _repo.rejectFriendRequest(friendshipId);
      // Confirm success
      state = const AsyncValue.data('Friend request declined');

      if (kDebugMode) {
        print(
          '[FRIEND] rejectFriendRequest - success: friendshipId=$friendshipId',
        );
      }
    } catch (e, stack) {
      if (kDebugMode) {
        print('[FRIEND] rejectFriendRequest - error: $e');
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

final friendRequestControllerProvider = StateNotifierProvider.autoDispose
    .family<FriendRequestController, AsyncValue<String?>, String>((
      ref,
      userId,
    ) {
      final repo = ref.watch(friendshipsRepoProvider);
      return FriendRequestController(repo);
    });

/// Social profile screen showing user's social information and posts
class SocialProfileScreen extends ConsumerStatefulWidget {
  final String userId;

  const SocialProfileScreen({super.key, required this.userId});

  @override
  ConsumerState<SocialProfileScreen> createState() =>
      _SocialProfileScreenState();
}

class _SocialProfileScreenState extends ConsumerState<SocialProfileScreen> {
  Future<void> _refresh() async {
    await Future.wait([
      ref.refresh(socialProfileProvider(widget.userId).future),
      ref.refresh(socialProfilePostsProvider(widget.userId).future),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(socialProfileProvider(widget.userId));
    final postsAsync = ref.watch(socialProfilePostsProvider(widget.userId));

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            IconButton(
              icon: const Icon(LucideIcons.share),
              onPressed: () {
                // TODO: Share profile
              },
            ),
            IconButton(
              icon: const Icon(LucideIcons.moreHorizontal),
              onPressed: () {
                // TODO: Show profile options
              },
            ),
          ],
        ),
        body: profileAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) {
            return Center(
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
                      'Error Loading Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          },
          data: (profile) {
            if (profile == null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        LucideIcons.userX,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Profile Not Found',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'User ID: ${widget.userId}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'This user profile doesn\'t exist or may have been deleted.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            }
            return _buildProfileContent(context, profile, postsAsync);
          },
        ),
      ),
    );
  }

  Widget _buildProfileContent(
    BuildContext context,
    UserProfile profile,
    AsyncValue<List<PostModel>> postsAsync,
  ) {
    final name = profile.getFullName().isNotEmpty
        ? profile.getFullName()
        : profile.displayName;
    final handle = profile.email.isNotEmpty
        ? '@${profile.email.split('@').first}'
        : '@player';
    final bio = profile.bio?.trim();
    final location = profile.location?.trim();
    final viewerId = Supabase.instance.client.auth.currentUser?.id;
    final isSelf = viewerId == profile.id;
    final stats = profile.statistics;

    return RefreshIndicator(
      onRefresh: _refresh,
      child: CustomScrollView(
        slivers: [
          // Profile Header
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.1),
                    backgroundImage:
                        profile.avatarUrl != null &&
                            profile.avatarUrl!.isNotEmpty
                        ? NetworkImage(profile.avatarUrl!)
                        : null,
                    child:
                        profile.avatarUrl == null || profile.avatarUrl!.isEmpty
                        ? Icon(
                            LucideIcons.user,
                            size: 40,
                            color: Theme.of(context).colorScheme.primary,
                          )
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // User Info
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        handle,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                      ),
                      // Friendship status badge
                      if (!isSelf) _FriendshipStatusBadge(userId: profile.id),
                    ],
                  ),
                  if (location != null && location.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.mapPin,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(location),
                      ],
                    ),
                  ],
                  if (bio != null && bio.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(bio, textAlign: TextAlign.center),
                  ],
                  const SizedBox(height: 24),

                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _StatColumn(
                        title: 'Posts',
                        value: postsAsync.maybeWhen(
                          data: (posts) => posts.length.toString(),
                          orElse: () => '0',
                        ),
                      ),
                      _StatColumn(
                        title: 'Friends',
                        value: stats.uniqueTeammates.toString(),
                      ),
                      _StatColumn(
                        title: 'Games',
                        value: stats.totalGamesPlayed.toString(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons
                  if (isSelf)
                    // Show edit/settings buttons for own profile
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => context.push(RoutePaths.profile),
                            icon: const Icon(LucideIcons.edit),
                            label: const Text('Edit profile'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => context.push('/settings'),
                            icon: const Icon(LucideIcons.settings),
                            label: const Text('Settings'),
                          ),
                        ),
                      ],
                    )
                  else
                    // Use the reusable FriendActionButton for other users
                    FriendActionButton(
                      key: ValueKey('friend-button-${profile.id}'),
                      otherUserId: profile.id,
                      onStateChanged: (state, friendship) {
                        if (kDebugMode) {
                          print(
                            '[SOCIAL-PROFILE] Friend state changed: $state',
                          );
                        }
                      },
                    ),
                ],
              ),
            ),
          ),

          // Tab Bar
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!, width: 0.5),
                ),
              ),
              child: const TabBar(
                tabs: [
                  Tab(text: 'Posts'),
                  Tab(text: 'Games'),
                  Tab(text: 'Photos'),
                ],
              ),
            ),
          ),

          // Posts List
          postsAsync.when(
            loading: () => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
            error: (error, _) => SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Column(
                    children: [
                      const Icon(LucideIcons.alertCircle, size: 40),
                      const SizedBox(height: 12),
                      Text('Error loading posts: ${error.toString()}'),
                    ],
                  ),
                ),
              ),
            ),
            data: (posts) {
              if (posts.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(48),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(LucideIcons.image, size: 48, color: Colors.grey),
                          SizedBox(height: 12),
                          Text(
                            'No posts yet',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'When this player shares something new, it will appear here.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final post = posts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: PostCard(
                      post: post,
                      onComment: () => context.push(
                        '${RoutePaths.socialPostDetail}/${post.id}',
                      ),
                      onPostTap: () => context.push(
                        '${RoutePaths.socialPostDetail}/${post.id}',
                      ),
                    ),
                  );
                }, childCount: posts.length),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FriendshipStatusBadge extends ConsumerWidget {
  final String userId;

  const _FriendshipStatusBadge({required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendshipAsync = ref.watch(friendshipStatusProvider(userId));

    return friendshipAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (friendship) {
        if (friendship == null) return const SizedBox.shrink();

        final currentUserId = Supabase.instance.client.auth.currentUser?.id;
        if (currentUserId == null) return const SizedBox.shrink();

        Widget badge;

        switch (friendship.status) {
          case 'pending':
            final isInitiator = friendship.initiated_by == currentUserId;
            if (isInitiator) {
              badge = Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.orange.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.clock,
                      size: 12,
                      color: Colors.orange[700],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Request Sent',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange[700],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              badge = Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.userPlus,
                      size: 12,
                      color: Colors.blue[700],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Wants to be Friends',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue[700],
                      ),
                    ),
                  ],
                ),
              );
            }
            return badge;

          case 'accepted':
            return Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    LucideIcons.userCheck,
                    size: 12,
                    color: Colors.green[700],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Friends',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            );

          case 'blocked':
            return Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(LucideIcons.userX, size: 12, color: Colors.red[700]),
                  const SizedBox(width: 4),
                  Text(
                    'Blocked',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.red[700],
                    ),
                  ),
                ],
              ),
            );

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String title;
  final String value;

  const _StatColumn({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
