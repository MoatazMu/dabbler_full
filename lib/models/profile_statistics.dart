// GENERATED from introspect.json — do not edit by hand
class ProfileStatistics {
  final String id;
  final String user_id;
  final int? total_games_played;
  final int? total_games_organized;
  final int? total_wins;
  final int? total_losses;
  final int? total_draws;
  final String? favorite_sport_id;
  final double? total_hours_played;
  final int? average_game_duration;
  final int? longest_streak;
  final int? current_streak;
  final int? total_teammates;
  final int? total_venues_visited;
  final double? sportsmanship_rating;
  final double? reliability_rating;
  final int? achievements_unlocked;
  final List<dynamic>? badges_earned;
  final DateTime? last_game_date;
  final DateTime? last_active;
  final DateTime created_at;
  final DateTime updated_at;

  const ProfileStatistics({
    required this.id,
    required this.user_id,
    this.total_games_played,
    this.total_games_organized,
    this.total_wins,
    this.total_losses,
    this.total_draws,
    this.favorite_sport_id,
    this.total_hours_played,
    this.average_game_duration,
    this.longest_streak,
    this.current_streak,
    this.total_teammates,
    this.total_venues_visited,
    this.sportsmanship_rating,
    this.reliability_rating,
    this.achievements_unlocked,
    this.badges_earned,
    this.last_game_date,
    this.last_active,
    required this.created_at,
    required this.updated_at,
  });

  factory ProfileStatistics.fromJson(Map<String, dynamic> json) {
    return ProfileStatistics(
      id: json['id'],
      user_id: json['user_id'],
      total_games_played: json['total_games_played'],
      total_games_organized: json['total_games_organized'],
      total_wins: json['total_wins'],
      total_losses: json['total_losses'],
      total_draws: json['total_draws'],
      favorite_sport_id: json['favorite_sport_id'],
      total_hours_played: json['total_hours_played'],
      average_game_duration: json['average_game_duration'],
      longest_streak: json['longest_streak'],
      current_streak: json['current_streak'],
      total_teammates: json['total_teammates'],
      total_venues_visited: json['total_venues_visited'],
      sportsmanship_rating: json['sportsmanship_rating'],
      reliability_rating: json['reliability_rating'],
      achievements_unlocked: json['achievements_unlocked'],
      badges_earned: json['badges_earned'],
      last_game_date: (json['last_game_date'] == null
          ? null
          : DateTime.parse(json['last_game_date'] as String)),
      last_active: (json['last_active'] == null
          ? null
          : DateTime.parse(json['last_active'] as String)),
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
      'total_games_played': total_games_played,
      'total_games_organized': total_games_organized,
      'total_wins': total_wins,
      'total_losses': total_losses,
      'total_draws': total_draws,
      'favorite_sport_id': favorite_sport_id,
      'total_hours_played': total_hours_played,
      'average_game_duration': average_game_duration,
      'longest_streak': longest_streak,
      'current_streak': current_streak,
      'total_teammates': total_teammates,
      'total_venues_visited': total_venues_visited,
      'sportsmanship_rating': sportsmanship_rating,
      'reliability_rating': reliability_rating,
      'achievements_unlocked': achievements_unlocked,
      'badges_earned': badges_earned,
      'last_game_date': last_game_date?.toIso8601String(),
      'last_active': last_active?.toIso8601String(),
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
