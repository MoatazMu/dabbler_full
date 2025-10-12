// GENERATED from introspect.json — do not edit by hand
class Users {
  final String id;
  final String email;
  final String? display_name;
  final DateTime created_at;
  final int? age;
  final String? intent;
  final String? avatar_url;
  final DateTime? updated_at;
  final List<dynamic>? sports;
  final String? phone;
  final DateTime? phone_confirmed_at;
  final DateTime? email_confirmed_at;
  final DateTime? last_sign_in_at;
  final bool? is_anonymous;
  final bool onboarding_completed;
  final String onboarding_step;
  final String? language;
  final String? timezone;
  final Map<String, dynamic>? notification_settings;
  final Map<String, dynamic>? privacy_settings;
  final String? skill_level;
  final int? games_played;
  final String? bio;
  final DateTime? date_of_birth;
  final bool? is_profile_complete;
  final bool? is_email_verified;
  final bool? is_phone_verified;
  final int? profile_completion_percentage;
  final String? gender;
  final String auth_id;

  const Users({
    required this.id,
    required this.email,
    this.display_name,
    required this.created_at,
    this.age,
    this.intent,
    this.avatar_url,
    this.updated_at,
    this.sports,
    this.phone,
    this.phone_confirmed_at,
    this.email_confirmed_at,
    this.last_sign_in_at,
    this.is_anonymous,
    required this.onboarding_completed,
    required this.onboarding_step,
    this.language,
    this.timezone,
    this.notification_settings,
    this.privacy_settings,
    this.skill_level,
    this.games_played,
    this.bio,
    this.date_of_birth,
    this.is_profile_complete,
    this.is_email_verified,
    this.is_phone_verified,
    this.profile_completion_percentage,
    this.gender,
    required this.auth_id,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      email: json['email'],
      display_name: json['display_name'],
    created_at: json['created_at'] != null
      ? DateTime.parse(json['created_at'] as String)
      : DateTime.now(),
      age: json['age'],
      intent: json['intent'],
      avatar_url: json['avatar_url'],
      updated_at: (json['updated_at'] == null ? null : DateTime.parse(json['updated_at'] as String)),
      sports: json['sports'],
      phone: json['phone'],
      phone_confirmed_at: (json['phone_confirmed_at'] == null ? null : DateTime.parse(json['phone_confirmed_at'] as String)),
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
      date_of_birth: (json['date_of_birth'] == null ? null : DateTime.parse(json['date_of_birth'] as String)),
      is_profile_complete: json['is_profile_complete'],
      is_email_verified: json['is_email_verified'],
      is_phone_verified: json['is_phone_verified'],
      profile_completion_percentage: json['profile_completion_percentage'],
      gender: json['gender'],
      auth_id: json['auth_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'display_name': display_name,
      'created_at': created_at.toIso8601String(),
      'age': age,
      'intent': intent,
      'avatar_url': avatar_url,
      'updated_at': updated_at?.toIso8601String(),
      'sports': sports,
      'phone': phone,
      'phone_confirmed_at': phone_confirmed_at?.toIso8601String(),
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
      'date_of_birth': date_of_birth?.toIso8601String(),
      'is_profile_complete': is_profile_complete,
      'is_email_verified': is_email_verified,
      'is_phone_verified': is_phone_verified,
      'profile_completion_percentage': profile_completion_percentage,
      'gender': gender,
      'auth_id': auth_id,
    };
  }
}
