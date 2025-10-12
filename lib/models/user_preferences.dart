// GENERATED from introspect.json — do not edit by hand
class UserPreferences {
  final String id;
  final String user_id;
  final List<dynamic>? preferred_game_types;
  final int? preferred_game_duration;
  final int? preferred_team_size_min;
  final int? preferred_team_size_max;
  final int? preferred_radius_km;
  final List<dynamic>? preferred_venues;
  final String? travel_willingness;
  final Map<String, dynamic>? weekly_availability;
  final int? advance_booking_days;
  final bool? last_minute_availability;
  final bool? open_to_new_players;
  final int? preferred_age_range_min;
  final int? preferred_age_range_max;
  final String? preferred_gender_mix;
  final bool? equipment_sharing;
  final bool? coaching_interest;
  final bool? tournament_interest;
  final DateTime created_at;
  final DateTime updated_at;

  const UserPreferences({
    required this.id,
    required this.user_id,
    this.preferred_game_types,
    this.preferred_game_duration,
    this.preferred_team_size_min,
    this.preferred_team_size_max,
    this.preferred_radius_km,
    this.preferred_venues,
    this.travel_willingness,
    this.weekly_availability,
    this.advance_booking_days,
    this.last_minute_availability,
    this.open_to_new_players,
    this.preferred_age_range_min,
    this.preferred_age_range_max,
    this.preferred_gender_mix,
    this.equipment_sharing,
    this.coaching_interest,
    this.tournament_interest,
    required this.created_at,
    required this.updated_at,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      id: json['id'],
      user_id: json['user_id'],
      preferred_game_types: json['preferred_game_types'],
      preferred_game_duration: json['preferred_game_duration'],
      preferred_team_size_min: json['preferred_team_size_min'],
      preferred_team_size_max: json['preferred_team_size_max'],
      preferred_radius_km: json['preferred_radius_km'],
      preferred_venues: json['preferred_venues'],
      travel_willingness: json['travel_willingness'],
      weekly_availability: json['weekly_availability'],
      advance_booking_days: json['advance_booking_days'],
      last_minute_availability: json['last_minute_availability'],
      open_to_new_players: json['open_to_new_players'],
      preferred_age_range_min: json['preferred_age_range_min'],
      preferred_age_range_max: json['preferred_age_range_max'],
      preferred_gender_mix: json['preferred_gender_mix'],
      equipment_sharing: json['equipment_sharing'],
      coaching_interest: json['coaching_interest'],
      tournament_interest: json['tournament_interest'],
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
      'preferred_game_types': preferred_game_types,
      'preferred_game_duration': preferred_game_duration,
      'preferred_team_size_min': preferred_team_size_min,
      'preferred_team_size_max': preferred_team_size_max,
      'preferred_radius_km': preferred_radius_km,
      'preferred_venues': preferred_venues,
      'travel_willingness': travel_willingness,
      'weekly_availability': weekly_availability,
      'advance_booking_days': advance_booking_days,
      'last_minute_availability': last_minute_availability,
      'open_to_new_players': open_to_new_players,
      'preferred_age_range_min': preferred_age_range_min,
      'preferred_age_range_max': preferred_age_range_max,
      'preferred_gender_mix': preferred_gender_mix,
      'equipment_sharing': equipment_sharing,
      'coaching_interest': coaching_interest,
      'tournament_interest': tournament_interest,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
