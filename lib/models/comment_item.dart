class CommentItem {
  final String id;
  final String postId;
  final String authorId;
  final String? content;
  final String? parentCommentId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  CommentItem({
    required this.id,
    required this.postId,
    required this.authorId,
    required this.createdAt,
    this.content,
    this.parentCommentId,
    this.updatedAt,
  });

  factory CommentItem.fromMap(Map<String, dynamic> map) {
    return CommentItem(
      id: map['id'] as String,
      postId: map['post_id'] as String,
      authorId: map['author_id'] as String,
      content: map['content'] as String?,
      parentCommentId: map['parent_comment_id'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: (map['updated_at'] != null)
          ? DateTime.tryParse(map['updated_at'] as String)
          : null,
    );
  }

  static List<CommentItem> listFromJson(dynamic jsonItems) {
    if (jsonItems is List) {
      return jsonItems
          .cast<Map<String, dynamic>>()
          .map(CommentItem.fromMap)
          .toList();
    }
    return const <CommentItem>[];
  }
}

class CommentPage {
  final int page;
  final int limit;
  final int count;
  final List<CommentItem> items;

  CommentPage({
    required this.page,
    required this.limit,
    required this.count,
    required this.items,
  });

  factory CommentPage.fromMap(Map<String, dynamic> map) {
    return CommentPage(
      page: (map['page'] ?? 1) as int,
      limit: (map['limit'] ?? 50) as int,
      count: (map['count'] ?? 0) as int,
      items: CommentItem.listFromJson(map['items']),
    );
  }
}
