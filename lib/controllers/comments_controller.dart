import 'package:flutter/foundation.dart';
import '../models/comment_item.dart';
import '../repositories/comments_repo.dart';
import '../repositories/reactions_repo.dart';

class CommentsController extends ChangeNotifier {
  final String postId;
  final CommentsRepo _commentsRepo;
  final ReactionsRepo _reactionsRepo;

  // Paging state
  final List<CommentItem> _items = <CommentItem>[];
  int _page = 1;
  final int _limit = 20;
  bool _isLoading = false;
  bool _hasMore = true;
  bool _initialLoaded = false;

  // Local like state per commentId (null = unknown)
  final Map<String, bool> _liked = <String, bool>{};

  // Local creating flag per parent (for UI spinners if needed)
  bool _isCreating = false;

  CommentsController({
    required this.postId,
    CommentsRepo? commentsRepo,
    ReactionsRepo? reactionsRepo,
  }) : _commentsRepo = commentsRepo ?? CommentsRepo(),
       _reactionsRepo = reactionsRepo ?? ReactionsRepo();

  List<CommentItem> get items => List.unmodifiable(_items);
  bool get isLoading => _isLoading;
  bool get isCreating => _isCreating;
  bool get hasMore => _hasMore;
  bool get initialLoaded => _initialLoaded;
  int get page => _page;
  int get limit => _limit;

  bool? isCommentLiked(String commentId) => _liked[commentId];

  /// Page 1
  Future<void> loadFirstPage({bool probeLiked = true}) async {
    if (_isLoading) return;
    _isLoading = true;
    _initialLoaded = false;
    _items.clear();
    _liked.clear();
    _page = 1;
    _hasMore = true;
    notifyListeners();

    try {
      final res = await _commentsRepo.listForPost(
        postId: postId,
        page: _page,
        limit: _limit,
      );
      _items.addAll(res.items);
      _hasMore = res.items.length >= _limit;
      if (probeLiked) {
        await _probeLikes(startIndex: 0);
      }
      _initialLoaded = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Next pages
  Future<void> loadNextPage({bool probeLiked = true}) async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    notifyListeners();

    try {
      final next = _page + 1;
      final res = await _commentsRepo.listForPost(
        postId: postId,
        page: next,
        limit: _limit,
      );
      if (res.items.isEmpty) {
        _hasMore = false;
      } else {
        final start = _items.length;
        _page = next;
        _items.addAll(res.items);
        _hasMore = res.items.length >= _limit;
        if (probeLiked) {
          await _probeLikes(startIndex: start);
        }
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Optimistic create (top-level or reply if parentCommentId provided)
  Future<void> createComment(String text, {String? parentCommentId}) async {
    if (_isCreating) return;
    _isCreating = true;
    notifyListeners();

    // Optimistic placeholder (id uses a temp marker)
    final now = DateTime.now();
    final tempId = 'temp-${now.microsecondsSinceEpoch}';
    final optimistic = CommentItem(
      id: tempId,
      postId: postId,
      authorId: 'me', // UI-only; real author comes back from server
      content: text,
      parentCommentId: parentCommentId,
      createdAt: now,
      updatedAt: null,
    );
    _items.insert(0, optimistic);
    notifyListeners();

    try {
      final created = await _commentsRepo.create(
        postId: postId,
        content: text,
        parentCommentId: parentCommentId,
      );
      // Replace optimistic with real row
      final idx = _items.indexWhere((c) => c.id == tempId);
      if (idx != -1) {
        _items[idx] = created;
      }
    } catch (e) {
      // Rollback
      _items.removeWhere((c) => c.id == tempId);
      debugPrint('createComment failed: $e');
      rethrow;
    } finally {
      _isCreating = false;
      notifyListeners();
    }
  }

  /// Optimistic toggle like
  Future<void> toggleLike(String commentId) async {
    final current = _liked[commentId] ?? false;
    _liked[commentId] = !current; // optimistic flip
    notifyListeners();

    try {
      final newState = await _reactionsRepo.toggleLikeComment(commentId);
      _liked[commentId] = newState;
      notifyListeners();
    } catch (e) {
      _liked[commentId] = current; // rollback
      notifyListeners();
      debugPrint('toggleLikeComment failed: $e');
    }
  }

  Future<void> _probeLikes({int startIndex = 0}) async {
    for (int i = startIndex; i < _items.length; i++) {
      final id = _items[i].id;
      try {
        final liked = await _reactionsRepo.hasLikedComment(id);
        _liked[id] = liked;
      } catch (_) {
        // anonymous user; ignore
      }
    }
    notifyListeners();
  }
}
