// GENERATED from introspect.json — do not edit by hand
class UserSettings {
  final String id;
  final String user_id;
  final String? theme_mode;
  final String? language;
  final bool? notification_enabled;
  final bool? email_notifications;
  final bool? push_notifications;
  final bool? sms_notifications;
  final bool? two_factor_enabled;
  final DateTime created_at;
  final DateTime updated_at;

  const UserSettings({
    required this.id,
    required this.user_id,
    this.theme_mode,
    this.language,
    this.notification_enabled,
    this.email_notifications,
    this.push_notifications,
    this.sms_notifications,
    this.two_factor_enabled,
    required this.created_at,
    required this.updated_at,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      id: json['id'],
      user_id: json['user_id'],
      theme_mode: json['theme_mode'],
      language: json['language'],
      notification_enabled: json['notification_enabled'],
      email_notifications: json['email_notifications'],
      push_notifications: json['push_notifications'],
      sms_notifications: json['sms_notifications'],
      two_factor_enabled: json['two_factor_enabled'],
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
      'user_id': user_id,
      'theme_mode': theme_mode,
      'language': language,
      'notification_enabled': notification_enabled,
      'email_notifications': email_notifications,
      'push_notifications': push_notifications,
      'sms_notifications': sms_notifications,
      'two_factor_enabled': two_factor_enabled,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
