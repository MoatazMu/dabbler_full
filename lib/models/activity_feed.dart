// GENERATED from introspect.json — do not edit by hand
class ActivityFeed {
  final String id;
  final String user_id;
  final String kind;
  final String title;
  final String message;
  final String? action_route;
  final DateTime created_at;
  final String? notification_id;
  final bool is_read;
  final DateTime? read_at;

  const ActivityFeed({
    required this.id,
    required this.user_id,
    required this.kind,
    required this.title,
    required this.message,
    this.action_route,
    required this.created_at,
    this.notification_id,
    required this.is_read,
    this.read_at,
  });

  factory ActivityFeed.fromJson(Map<String, dynamic> json) {
    return ActivityFeed(
      id: json['id'],
      user_id: json['user_id'],
      kind: json['kind'],
      title: json['title'],
      message: json['message'],
      action_route: json['action_route'],
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      notification_id: json['notification_id'],
      is_read: json['is_read'],
      read_at: (json['read_at'] == null
          ? null
          : DateTime.parse(json['read_at'] as String)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'kind': kind,
      'title': title,
      'message': message,
      'action_route': action_route,
      'created_at': created_at.toIso8601String(),
      'notification_id': notification_id,
      'is_read': is_read,
      'read_at': read_at?.toIso8601String(),
    };
  }
}
