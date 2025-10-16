// GENERATED from introspect.json — do not edit by hand
class SocialNotifications {
  final String id;
  final String user_id;
  final String type;
  final String? actor_id;
  final String? post_id;
  final String? comment_id;
  final String? friendship_id;
  final String? conversation_id;
  final String title;
  final String? body;
  final Map<String, dynamic>? data;
  final bool? is_read;
  final DateTime? read_at;
  final DateTime created_at;

  const SocialNotifications({
    required this.id,
    required this.user_id,
    required this.type,
    this.actor_id,
    this.post_id,
    this.comment_id,
    this.friendship_id,
    this.conversation_id,
    required this.title,
    this.body,
    this.data,
    this.is_read,
    this.read_at,
    required this.created_at,
  });

  factory SocialNotifications.fromJson(Map<String, dynamic> json) {
    return SocialNotifications(
      id: json['id'],
      user_id: json['user_id'],
      type: json['type'],
      actor_id: json['actor_id'],
      post_id: json['post_id'],
      comment_id: json['comment_id'],
      friendship_id: json['friendship_id'],
      conversation_id: json['conversation_id'],
      title: json['title'],
      body: json['body'],
      data: json['data'],
      is_read: json['is_read'],
      read_at: (json['read_at'] == null
          ? null
          : DateTime.parse(json['read_at'] as String)),
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'type': type,
      'actor_id': actor_id,
      'post_id': post_id,
      'comment_id': comment_id,
      'friendship_id': friendship_id,
      'conversation_id': conversation_id,
      'title': title,
      'body': body,
      'data': data,
      'is_read': is_read,
      'read_at': read_at?.toIso8601String(),
      'created_at': created_at.toIso8601String(),
    };
  }
}
