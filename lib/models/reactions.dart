// GENERATED from introspect.json — do not edit by hand
class Reactions {
  final String id;
  final String user_id;
  final String? post_id;
  final String? comment_id;
  final String reaction_type;
  final DateTime created_at;

  const Reactions({
    required this.id,
    required this.user_id,
    this.post_id,
    this.comment_id,
    required this.reaction_type,
    required this.created_at,
  });

  factory Reactions.fromJson(Map<String, dynamic> json) {
    return Reactions(
      id: json['id'],
      user_id: json['user_id'],
      post_id: json['post_id'],
      comment_id: json['comment_id'],
      reaction_type: json['reaction_type'],
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'post_id': post_id,
      'comment_id': comment_id,
      'reaction_type': reaction_type,
      'created_at': created_at.toIso8601String(),
    };
  }
}
