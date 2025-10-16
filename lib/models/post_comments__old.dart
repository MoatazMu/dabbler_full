// GENERATED from introspect.json — do not edit by hand
class PostCommentsOld {
  final String id;
  final String post_id;
  final String author_id;
  final String content;
  final String? parent_comment_id;
  final DateTime? created_at;
  final DateTime? updated_at;

  const PostCommentsOld({
    required this.id,
    required this.post_id,
    required this.author_id,
    required this.content,
    this.parent_comment_id,
    this.created_at,
    this.updated_at,
  });

  factory PostCommentsOld.fromJson(Map<String, dynamic> json) {
    return PostCommentsOld(
      id: json['id'],
      post_id: json['post_id'],
      author_id: json['author_id'],
      content: json['content'],
      parent_comment_id: json['parent_comment_id'],
      created_at: (json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String)),
      updated_at: (json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post_id': post_id,
      'author_id': author_id,
      'content': content,
      'parent_comment_id': parent_comment_id,
      'created_at': created_at?.toIso8601String(),
      'updated_at': updated_at?.toIso8601String(),
    };
  }
}
