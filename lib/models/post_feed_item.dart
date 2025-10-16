// Model for post feed items returned by the public-feed edge function

class PostFeedItem {
  final String id;
  final String authorId;
  // Optional author display fields when edge function selects nested author
  final String? authorName;
  final String? authorAvatar;
  final String? type;
  final String? content;
  final List<String>? mediaUrls;
  final String? gameId;
  final String? sportId;
  final String? achievementType;
  final String? visibility;
  final int? likesCount;
  final int? commentsCount;
  final int? sharesCount;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? locationName;
  final String? tags;

  PostFeedItem({
    required this.id,
    required this.authorId,
    required this.createdAt,
    this.authorName,
    this.authorAvatar,
    this.type,
    this.content,
    this.mediaUrls,
    this.gameId,
    this.sportId,
    this.achievementType,
    this.visibility,
    this.likesCount,
    this.commentsCount,
    this.sharesCount,
    this.updatedAt,
    this.locationName,
    this.tags,
  });

  factory PostFeedItem.fromMap(Map<String, dynamic> map) {
    // Nested author info may appear under key 'author'
    final author = map['author'] as Map<String, dynamic>?;
    return PostFeedItem(
      id: map['id'] as String,
      authorId: map['author_id'] as String,
      authorName: author != null ? (author['display_name'] as String?) : null,
      authorAvatar: author != null ? (author['avatar_url'] as String?) : null,
      type: map['type'] as String?,
      content: map['content'] as String?,
      mediaUrls: (map['media_urls'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      gameId: map['game_id'] as String?,
      sportId: map['sport_id'] as String?,
      achievementType: map['achievement_type'] as String?,
      visibility: map['visibility'] as String?,
      likesCount: map['likes_count'] as int?,
      commentsCount: map['comments_count'] as int?,
      sharesCount: map['shares_count'] as int?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: (map['updated_at'] != null)
          ? DateTime.tryParse(map['updated_at'] as String)
          : null,
      locationName: map['location_name'] as String?,
      tags: map['tags'] as String?,
    );
  }

  static List<PostFeedItem> listFromJson(dynamic jsonItems) {
    if (jsonItems is List) {
      return jsonItems
          .map((e) => PostFeedItem.fromMap(e as Map<String, dynamic>))
          .toList();
    }
    return const <PostFeedItem>[];
  }
}

// ensure PostFeedPage can parse { items, next: { created_before, last_id } }
class PostFeedPage {
  final List<PostFeedItem> items;
  final _NextCursor? next;
  PostFeedPage({required this.items, required this.next});

  factory PostFeedPage.fromMap(Map<String, dynamic> m) {
    final items = (m['items'] as List<dynamic>? ?? const [])
        .map((e) => PostFeedItem.fromMap(e as Map<String, dynamic>))
        .toList();
    _NextCursor? next;
    final n = m['next'];
    if (n is Map<String, dynamic>) {
      next = _NextCursor(
        createdBefore: n['created_before'] as String?,
        lastId: n['last_id'] as String?,
      );
    } else {
      next = null;
    }
    return PostFeedPage(items: items, next: next);
  }
}

class _NextCursor {
  final String? createdBefore;
  final String? lastId;
  const _NextCursor({this.createdBefore, this.lastId});
}
