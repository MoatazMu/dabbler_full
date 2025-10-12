// GENERATED from introspect.json — do not edit by hand
class Comments {
  final String id;
  final String post_id;
  final String author_id;
  final String? parent_comment_id;
  final String content;
  final int? likes_count;
  final bool? is_deleted;
  final DateTime created_at;
  final DateTime updated_at;

  const Comments({
    required this.id,
    required this.post_id,
    required this.author_id,
    this.parent_comment_id,
    required this.content,
    this.likes_count,
    this.is_deleted,
    required this.created_at,
    required this.updated_at,
  });

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      id: json['id'],
      post_id: json['post_id'],
      author_id: json['author_id'],
      parent_comment_id: json['parent_comment_id'],
      content: json['content'],
      likes_count: json['likes_count'],
      is_deleted: json['is_deleted'],
    created_at: json['created_at'] != null
      ? DateTime.parse(json['created_at'] as String)
      : DateTime.now(),
    updated_at: json['updated_at'] != null
      ? DateTime.parse(json['updated_at'] as String)
      : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post_id': post_id,
      'author_id': author_id,
      'parent_comment_id': parent_comment_id,
      'content': content,
      'likes_count': likes_count,
      'is_deleted': is_deleted,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
