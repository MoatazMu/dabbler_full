// Model for post feed items returned by the public-feed edge function

class PostFeedItem {
  final String id;
  final String authorId;
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
    return PostFeedItem(
      id: map['id'] as String,
      authorId: map['author_id'] as String,
      type: map['type'] as String?,
      content: map['content'] as String?,
      mediaUrls: (map['media_urls'] as List?)?.map((e) => e.toString()).toList(),
      gameId: map['game_id'] as String?,
      sportId: map['sport_id'] as String?,
      achievementType: map['achievement_type'] as String?,
      visibility: map['visibility'] as String?,
      likesCount: map['likes_count'] as int?,
      commentsCount: map['comments_count'] as int?,
      sharesCount: map['shares_count'] as int?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: (map['updated_at'] != null) ? DateTime.tryParse(map['updated_at'] as String) : null,
      locationName: map['location_name'] as String?,
      tags: map['tags'] as String?,
    );
  }

  static List<PostFeedItem> listFromJson(dynamic jsonItems) {
    if (jsonItems is List) {
      return jsonItems.map((e) => PostFeedItem.fromMap(e as Map<String, dynamic>)).toList();
    }
    return const <PostFeedItem>[];
  }
}

class PostFeedPage {
  final int page;
  final int limit;
  final int countPublic;
  final int countFriends;
  final int totalItemsEstimate;
  final List<PostFeedItem> items;

  PostFeedPage({
    required this.page,
    required this.limit,
    required this.countPublic,
    required this.countFriends,
    required this.totalItemsEstimate,
    required this.items,
  });

  factory PostFeedPage.fromMap(Map<String, dynamic> map) {
    return PostFeedPage(
      page: (map['page'] ?? 1) as int,
      limit: (map['limit'] ?? 20) as int,
      countPublic: (map['count_public'] ?? 0) as int,
      countFriends: (map['count_friends'] ?? 0) as int,
      totalItemsEstimate: (map['total_items_estimate'] ?? 0) as int,
      items: PostFeedItem.listFromJson(map['items']),
    );
  }
}
