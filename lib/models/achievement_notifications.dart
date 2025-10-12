// GENERATED from introspect.json — do not edit by hand
class AchievementNotifications {
  final String id;
  final String user_id;
  final String achievement_id;
  final String? notification_type;
  final String title;
  final String? message;
  final bool? is_read;
  final DateTime? read_at;
  final DateTime created_at;

  const AchievementNotifications({
    required this.id,
    required this.user_id,
    required this.achievement_id,
    this.notification_type,
    required this.title,
    this.message,
    this.is_read,
    this.read_at,
    required this.created_at,
  });

  factory AchievementNotifications.fromJson(Map<String, dynamic> json) {
    return AchievementNotifications(
      id: json['id'],
      user_id: json['user_id'],
      achievement_id: json['achievement_id'],
      notification_type: json['notification_type'],
      title: json['title'],
      message: json['message'],
      is_read: json['is_read'],
      read_at: (json['read_at'] == null ? null : DateTime.parse(json['read_at'] as String)),
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'achievement_id': achievement_id,
      'notification_type': notification_type,
      'title': title,
      'message': message,
      'is_read': is_read,
      'read_at': read_at?.toIso8601String(),
      'created_at': created_at.toIso8601String(),
    };
  }
}
