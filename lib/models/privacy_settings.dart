// GENERATED from introspect.json — do not edit by hand
class PrivacySettings {
  final String id;
  final String user_id;
  final String? profile_visibility;
  final bool? show_real_name;
  final bool? show_email;
  final bool? show_phone;
  final bool? show_location;
  final bool? show_age;
  final bool? show_sports_stats;
  final bool? show_game_history;
  final bool? show_upcoming_games;
  final bool? show_favorite_venues;
  final bool? searchable;
  final bool? allow_friend_requests;
  final bool? allow_game_invites;
  final bool? allow_messages;
  final bool? share_analytics;
  final bool? share_location_data;
  final bool? marketing_emails;
  final DateTime created_at;
  final DateTime updated_at;

  const PrivacySettings({
    required this.id,
    required this.user_id,
    this.profile_visibility,
    this.show_real_name,
    this.show_email,
    this.show_phone,
    this.show_location,
    this.show_age,
    this.show_sports_stats,
    this.show_game_history,
    this.show_upcoming_games,
    this.show_favorite_venues,
    this.searchable,
    this.allow_friend_requests,
    this.allow_game_invites,
    this.allow_messages,
    this.share_analytics,
    this.share_location_data,
    this.marketing_emails,
    required this.created_at,
    required this.updated_at,
  });

  factory PrivacySettings.fromJson(Map<String, dynamic> json) {
    return PrivacySettings(
      id: json['id'],
      user_id: json['user_id'],
      profile_visibility: json['profile_visibility'],
      show_real_name: json['show_real_name'],
      show_email: json['show_email'],
      show_phone: json['show_phone'],
      show_location: json['show_location'],
      show_age: json['show_age'],
      show_sports_stats: json['show_sports_stats'],
      show_game_history: json['show_game_history'],
      show_upcoming_games: json['show_upcoming_games'],
      show_favorite_venues: json['show_favorite_venues'],
      searchable: json['searchable'],
      allow_friend_requests: json['allow_friend_requests'],
      allow_game_invites: json['allow_game_invites'],
      allow_messages: json['allow_messages'],
      share_analytics: json['share_analytics'],
      share_location_data: json['share_location_data'],
      marketing_emails: json['marketing_emails'],
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
      'profile_visibility': profile_visibility,
      'show_real_name': show_real_name,
      'show_email': show_email,
      'show_phone': show_phone,
      'show_location': show_location,
      'show_age': show_age,
      'show_sports_stats': show_sports_stats,
      'show_game_history': show_game_history,
      'show_upcoming_games': show_upcoming_games,
      'show_favorite_venues': show_favorite_venues,
      'searchable': searchable,
      'allow_friend_requests': allow_friend_requests,
      'allow_game_invites': allow_game_invites,
      'allow_messages': allow_messages,
      'share_analytics': share_analytics,
      'share_location_data': share_location_data,
      'marketing_emails': marketing_emails,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
