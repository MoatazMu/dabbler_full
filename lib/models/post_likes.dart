// GENERATED from introspect.json — do not edit by hand
class PostLikes {
  final String id;
  final String post_id;
  final String user_id;
  final DateTime? created_at;

  const PostLikes({
    required this.id,
    required this.post_id,
    required this.user_id,
    this.created_at,
  });

  factory PostLikes.fromJson(Map<String, dynamic> json) {
    return PostLikes(
      id: json['id'],
      post_id: json['post_id'],
      user_id: json['user_id'],
      created_at: (json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post_id': post_id,
      'user_id': user_id,
      'created_at': created_at?.toIso8601String(),
    };
  }
}
