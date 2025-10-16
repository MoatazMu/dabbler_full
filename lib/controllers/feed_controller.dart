import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/post_feed_item.dart';
import '../repositories/feed_repo.dart';
import '../repositories/reactions_repo.dart';

class FeedController extends ChangeNotifier {
  final FeedRepo _feedRepo;
  final ReactionsRepo _reactionsRepo;

  // Paging
  final List<PostFeedItem> _items = <PostFeedItem>[];
  final int _limit = 20;
  bool _isLoading = false;
  bool _hasMore = true;
  // keyset cursor
  String? _cursorCreatedBefore;
  String? _cursorLastId;

  // UI state: optimistic like flags per postId
  // If a post wasn’t probed yet, it may be null. True/false when known/toggled.
  final Map<String, bool> _liked = <String, bool>{};

  FeedController({FeedRepo? feedRepo, ReactionsRepo? reactionsRepo})
    : _feedRepo = feedRepo ?? FeedRepo(),
      _reactionsRepo = reactionsRepo ?? ReactionsRepo();

  List<PostFeedItem> get items => List.unmodifiable(_items);
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  int get limit => _limit;

  bool? isPostLiked(String postId) => _liked[postId];

  /// Loads page 1 and resets state.
  Future<void> loadFirstPage({
    bool probeLiked = false,
    String scope = 'public',
  }) async {
    if (_isLoading) return;
    _isLoading = true;
    _items.clear();
    _liked.clear();
    _hasMore = true;
    _cursorCreatedBefore = null;
    _cursorLastId = null;
    notifyListeners();

    try {
      final res = await _feedRepo.fetchFeed(
        limit: _limit,
        createdBeforeIso: _cursorCreatedBefore,
        lastId: _cursorLastId,
        scope: scope,
      );
      _items.addAll(res.items);
      final next = res.next; // expects map with created_before, last_id
      if (next != null) {
        _cursorCreatedBefore = next.createdBefore;
        _cursorLastId = next.lastId;
        _hasMore = true;
      } else {
        _hasMore = false;
      }

      if (probeLiked) {
        await _probeLikesForVisible();
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Loads the next page using keyset cursor if available.
  Future<void> loadNextPage({
    bool probeLiked = false,
    String scope = 'public',
  }) async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    notifyListeners();

    try {
      final res = await _feedRepo.fetchFeed(
        limit: _limit,
        createdBeforeIso: _cursorCreatedBefore,
        lastId: _cursorLastId,
        scope: scope,
      );
      final start = _items.length;
      _items.addAll(res.items);
      final next = res.next;
      _hasMore = next != null;
      if (next != null) {
        _cursorCreatedBefore = next.createdBefore;
        _cursorLastId = next.lastId;
      }
      if (probeLiked && res.items.isNotEmpty) {
        await _probeLikesForVisible(startIndex: start);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Convenience: picks scope based on auth session and loads page 1.
  /// If a user is logged in → 'friends', otherwise 'public'.
  Future<void> loadForCurrentUser({bool probeLiked = false}) async {
    final user = Supabase.instance.client.auth.currentUser;
    final scope = (user == null) ? 'public' : 'friends';
    await loadFirstPage(probeLiked: probeLiked, scope: scope);
  }

  /// Toggle like with optimistic UI.
  Future<void> toggleLike(String postId) async {
    final wasLiked = _liked[postId] ?? false;
    final optimistic = !wasLiked;

    // Optimistically flip liked state
    _liked[postId] = optimistic;

    // Optimistically adjust likesCount on the item
    final idx = _items.indexWhere((e) => e.id == postId);
    if (idx != -1) {
      final item = _items[idx];
      final curr = item.likesCount ?? 0;
      final next = optimistic ? curr + 1 : (curr > 0 ? curr - 1 : 0);
      _items[idx] = PostFeedItem(
        id: item.id,
        authorId: item.authorId,
        createdAt: item.createdAt,
        authorName: item.authorName,
        authorAvatar: item.authorAvatar,
        type: item.type,
        content: item.content,
        mediaUrls: item.mediaUrls,
        gameId: item.gameId,
        sportId: item.sportId,
        achievementType: item.achievementType,
        visibility: item.visibility,
        likesCount: next,
        commentsCount: item.commentsCount,
        sharesCount: item.sharesCount,
        updatedAt: item.updatedAt,
        locationName: item.locationName,
        tags: item.tags,
      );
    }
    notifyListeners();

    try {
      final serverLiked = await _reactionsRepo.toggleLikePost(postId);
      // Reconcile liked state and count if server disagrees with optimistic
      if (serverLiked != optimistic) {
        _liked[postId] = serverLiked;
        final idx2 = _items.indexWhere((e) => e.id == postId);
        if (idx2 != -1) {
          final item = _items[idx2];
          final curr = item.likesCount ?? 0;
          final next = serverLiked
              ? curr +
                    1 // server says liked, ensure increment
              : (curr > 0 ? curr - 1 : 0); // server says unliked, decrement
          _items[idx2] = PostFeedItem(
            id: item.id,
            authorId: item.authorId,
            createdAt: item.createdAt,
            authorName: item.authorName,
            authorAvatar: item.authorAvatar,
            type: item.type,
            content: item.content,
            mediaUrls: item.mediaUrls,
            gameId: item.gameId,
            sportId: item.sportId,
            achievementType: item.achievementType,
            visibility: item.visibility,
            likesCount: next,
            commentsCount: item.commentsCount,
            sharesCount: item.sharesCount,
            updatedAt: item.updatedAt,
            locationName: item.locationName,
            tags: item.tags,
          );
        }
      }
      notifyListeners();
    } catch (e) {
      // rollback liked state and likesCount
      _liked[postId] = wasLiked;
      final idx3 = _items.indexWhere((e) => e.id == postId);
      if (idx3 != -1) {
        final item = _items[idx3];
        final curr = item.likesCount ?? 0;
        // Recompute correction based on optimistic flag
        final corrected = optimistic ? (curr > 0 ? curr - 1 : 0) : curr + 1;
        _items[idx3] = PostFeedItem(
          id: item.id,
          authorId: item.authorId,
          createdAt: item.createdAt,
          authorName: item.authorName,
          authorAvatar: item.authorAvatar,
          type: item.type,
          content: item.content,
          mediaUrls: item.mediaUrls,
          gameId: item.gameId,
          sportId: item.sportId,
          achievementType: item.achievementType,
          visibility: item.visibility,
          likesCount: corrected,
          commentsCount: item.commentsCount,
          sharesCount: item.sharesCount,
          updatedAt: item.updatedAt,
          locationName: item.locationName,
          tags: item.tags,
        );
      }
      notifyListeners();
      debugPrint('toggleLike failed for $postId: $e');
    }
  }

  /// Optional: for initial “filled hearts”. This probes in series; fine for small pages.
  Future<void> _probeLikesForVisible({int startIndex = 0}) async {
    for (int i = startIndex; i < _items.length; i++) {
      final postId = _items[i].id;
      try {
        final liked = await _reactionsRepo.hasLikedPost(postId);
        _liked[postId] = liked;
      } catch (_) {
        // ignore; user may be anonymous
      }
    }
    notifyListeners();
  }
}
