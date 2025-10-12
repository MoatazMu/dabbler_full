// GENERATED from introspect.json — do not edit by hand
class UserSportsProfiles {
  final String id;
  final String user_id;
  final String sport_id;
  final int? skill_level;
  final int? years_playing;
  final List<dynamic>? preferred_positions;
  final List<dynamic>? certifications;
  final List<dynamic>? achievements;
  final bool? is_primary_sport;
  final DateTime created_at;
  final DateTime updated_at;

  const UserSportsProfiles({
    required this.id,
    required this.user_id,
    required this.sport_id,
    this.skill_level,
    this.years_playing,
    this.preferred_positions,
    this.certifications,
    this.achievements,
    this.is_primary_sport,
    required this.created_at,
    required this.updated_at,
  });

  factory UserSportsProfiles.fromJson(Map<String, dynamic> json) {
    return UserSportsProfiles(
      id: json['id'],
      user_id: json['user_id'],
      sport_id: json['sport_id'],
      skill_level: json['skill_level'],
      years_playing: json['years_playing'],
      preferred_positions: json['preferred_positions'],
      certifications: json['certifications'],
      achievements: json['achievements'],
      is_primary_sport: json['is_primary_sport'],
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
      'sport_id': sport_id,
      'skill_level': skill_level,
      'years_playing': years_playing,
      'preferred_positions': preferred_positions,
      'certifications': certifications,
      'achievements': achievements,
      'is_primary_sport': is_primary_sport,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
