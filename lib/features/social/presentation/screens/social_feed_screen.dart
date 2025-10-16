import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../utils/constants/route_constants.dart';
import '../../../../controllers/feed_controller.dart' as app_feed;
import '../../data/models/post_model.dart';
import '../widgets/feed/post_card.dart';
import '../../../../utils/enums/social_enums.dart';

/// Main social feed screen
// Local provider wrapping the app-level FeedController (keyset + reactions)
final feedControllerProvider = ChangeNotifierProvider<app_feed.FeedController>(
  (ref) => app_feed.FeedController(),
);

class SocialFeedScreen extends ConsumerStatefulWidget {
  const SocialFeedScreen({super.key});

  @override
  ConsumerState<SocialFeedScreen> createState() => _SocialFeedScreenState();
}

class _SocialFeedScreenState extends ConsumerState<SocialFeedScreen>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();
  String _scope = 'public'; // 'public' | 'friends'
  bool _initialLoadDone = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Pick default scope based on auth state, then load
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = Supabase.instance.client.auth.currentUser;
      setState(() {
        _scope = user == null ? 'public' : 'friends';
      });
      await ref
          .read(feedControllerProvider)
          .loadFirstPage(scope: _scope, probeLiked: user != null);
      setState(() => _initialLoadDone = true);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final ctrl = ref.read(feedControllerProvider);
    if (!ctrl.isLoading && ctrl.hasMore) {
      final threshold = _scrollController.position.maxScrollExtent * 0.9;
      if (_scrollController.position.pixels >= threshold) {
        ctrl.loadNextPage(scope: _scope, probeLiked: true);
      }
    }
  }

  Future<void> _onRefresh() async {
    final user = Supabase.instance.client.auth.currentUser;
    await ref
        .read(feedControllerProvider)
        .loadFirstPage(scope: _scope, probeLiked: user != null);
  }

  void _onScopeChanged(String newScope) async {
    if (_scope == newScope) return;
    setState(() => _scope = newScope);
    final user = Supabase.instance.client.auth.currentUser;
    await ref
        .read(feedControllerProvider)
        .loadFirstPage(scope: _scope, probeLiked: user != null);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final feed = ref.watch(feedControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Social'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              context.push(RoutePaths.socialSearch);
            },
            icon: const Icon(LucideIcons.search),
          ),
          IconButton(
            onPressed: () {
              context.push(RoutePaths.socialNotifications);
            },
            icon: const Icon(LucideIcons.bell),
          ),
          IconButton(
            onPressed: () {
              context.push(RoutePaths.socialCreatePost);
            },
            icon: const Icon(LucideIcons.plus),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Scope segmented control
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: _ScopeSelector(
                  scope: _scope,
                  onChanged: _onScopeChanged,
                ),
              ),
            ),

            // First-load progress
            if (!_initialLoadDone && feed.items.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (feed.items.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    _scope == 'friends'
                        ? 'No posts from friends yet'
                        : 'No public posts yet',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final isLoadingRow = index == feed.items.length;
                    if (isLoadingRow) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: feed.hasMore && feed.isLoading
                              ? const CircularProgressIndicator()
                              : const SizedBox.shrink(),
                        ),
                      );
                    }

                    final item = feed.items[index];
                    final liked = feed.isPostLiked(item.id) ?? false;
                    final model = PostModel(
                      id: item.id,
                      authorId: item.authorId,
                      authorName: item.authorName ?? 'Unknown User',
                      authorAvatar: item.authorAvatar ?? '',
                      content: item.content ?? '',
                      mediaUrls: item.mediaUrls ?? const <String>[],
                      createdAt: item.createdAt,
                      updatedAt: item.updatedAt ?? item.createdAt,
                      likesCount: item.likesCount ?? 0,
                      commentsCount: item.commentsCount ?? 0,
                      sharesCount: item.sharesCount ?? 0,
                      visibility: _visibilityFromString(item.visibility),
                      gameId: item.gameId,
                      locationName: item.locationName,
                      isLiked: liked,
                      isBookmarked: false,
                      authorBio: null,
                      authorVerified: false,
                      tags: item.tags != null && item.tags!.isNotEmpty
                          ? item.tags!.split(',').map((e) => e.trim()).toList()
                          : const <String>[],
                      mentionedUsers: const <String>[],
                      isEdited:
                          item.updatedAt != null &&
                          item.updatedAt != item.createdAt,
                      editedAt: item.updatedAt,
                      replyToPostId: null,
                      shareOriginalId: null,
                      activityType: null,
                      activityData: null,
                    );

                    return PostCard(
                      post: model,
                      onLike: () =>
                          ref.read(feedControllerProvider).toggleLike(item.id),
                      onComment: () {
                        context.push(
                          '${RoutePaths.socialPostDetail}/${item.id}',
                        );
                      },
                      onShare: () {
                        // TODO: Hook into share flow
                      },
                      onPostTap: () {
                        context.push(
                          '${RoutePaths.socialPostDetail}/${item.id}',
                        );
                      },
                      onProfileTap: () {
                        context.push(
                          '${RoutePaths.socialProfile}/${item.authorId}',
                        );
                      },
                    );
                  },
                  childCount: feed.items.length + 1, // +1 loading row
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RoutePaths.socialCreatePost);
        },
        child: const Icon(LucideIcons.plus),
      ),
    );
  }
}

// Local helper to map visibility string to PostVisibility enum used by PostModel
PostVisibility _visibilityFromString(String? v) {
  switch ((v ?? 'public').toLowerCase()) {
    case 'friends':
      return PostVisibility.friends;
    case 'private':
      return PostVisibility.private;
    case 'game_participants':
      return PostVisibility.gameParticipants;
    default:
      return PostVisibility.public;
  }
}

class _ScopeSelector extends StatelessWidget {
  final String scope; // 'public' | 'friends'
  final ValueChanged<String> onChanged;

  const _ScopeSelector({required this.scope, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      segments: const [
        ButtonSegment(
          value: 'public',
          label: Text('Public'),
          icon: Icon(Icons.public),
        ),
        ButtonSegment(
          value: 'friends',
          label: Text('Friends'),
          icon: Icon(Icons.group),
        ),
      ],
      selected: {scope},
      onSelectionChanged: (sel) {
        if (sel.isNotEmpty) onChanged(sel.first);
      },
    );
  }
}

// Removed temporary _FeedListTile in favor of rich PostCard UI
