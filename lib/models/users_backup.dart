// GENERATED from introspect.json — do not edit by hand
class UsersBackup {
  final String? id;
  final String? email;
  final String? display_name;
  final DateTime? created_at;
  final int? age;
  final List<dynamic>? preferred_sports;
  final String? intent;
  final String? avatar_url;
  final DateTime? updated_at;
  final List<dynamic>? sports;
  final String? phone;
  final DateTime? phone_confirmed_at;
  final bool? phone_confirmed;
  final DateTime? email_confirmed_at;
  final DateTime? last_sign_in_at;
  final bool? is_anonymous;
  final bool? onboarding_completed;
  final String? onboarding_step;
  final String? language;
  final String? timezone;
  final Map<String, dynamic>? notification_settings;
  final Map<String, dynamic>? privacy_settings;
  final String? skill_level;
  final int? games_played;
  final String? bio;

  const UsersBackup({
    this.id,
    this.email,
    this.display_name,
    this.created_at,
    this.age,
    this.preferred_sports,
    this.intent,
    this.avatar_url,
    this.updated_at,
    this.sports,
    this.phone,
    this.phone_confirmed_at,
    this.phone_confirmed,
    this.email_confirmed_at,
    this.last_sign_in_at,
    this.is_anonymous,
    this.onboarding_completed,
    this.onboarding_step,
    this.language,
    this.timezone,
    this.notification_settings,
    this.privacy_settings,
    this.skill_level,
    this.games_played,
    this.bio,
  });

  factory UsersBackup.fromJson(Map<String, dynamic> json) {
    return UsersBackup(
      id: json['id'],
      email: json['email'],
      display_name: json['display_name'],
      created_at: (json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String)),
      age: json['age'],
      preferred_sports: json['preferred_sports'],
      intent: json['intent'],
      avatar_url: json['avatar_url'],
      updated_at: (json['updated_at'] == null ? null : DateTime.parse(json['updated_at'] as String)),
      sports: json['sports'],
      phone: json['phone'],
      phone_confirmed_at: (json['phone_confirmed_at'] == null ? null : DateTime.parse(json['phone_confirmed_at'] as String)),
      phone_confirmed: json['phone_confirmed'],
      email_confirmed_at: (json['email_confirmed_at'] == null ? null : DateTime.parse(json['email_confirmed_at'] as String)),
      last_sign_in_at: (json['last_sign_in_at'] == null ? null : DateTime.parse(json['last_sign_in_at'] as String)),
      is_anonymous: json['is_anonymous'],
      onboarding_completed: json['onboarding_completed'],
      onboarding_step: json['onboarding_step'],
      language: json['language'],
      timezone: json['timezone'],
      notification_settings: json['notification_settings'],
      privacy_settings: json['privacy_settings'],
      skill_level: json['skill_level'],
      games_played: json['games_played'],
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'display_name': display_name,
      'created_at': created_at?.toIso8601String(),
      'age': age,
      'preferred_sports': preferred_sports,
      'intent': intent,
      'avatar_url': avatar_url,
      'updated_at': updated_at?.toIso8601String(),
      'sports': sports,
      'phone': phone,
      'phone_confirmed_at': phone_confirmed_at?.toIso8601String(),
      'phone_confirmed': phone_confirmed,
      'email_confirmed_at': email_confirmed_at?.toIso8601String(),
      'last_sign_in_at': last_sign_in_at?.toIso8601String(),
      'is_anonymous': is_anonymous,
      'onboarding_completed': onboarding_completed,
      'onboarding_step': onboarding_step,
      'language': language,
      'timezone': timezone,
      'notification_settings': notification_settings,
      'privacy_settings': privacy_settings,
      'skill_level': skill_level,
      'games_played': games_played,
      'bio': bio,
    };
  }
}
