// GENERATED from introspect.json — do not edit by hand
class UserRankings {
  final String id;
  final String user_id;
  final String leaderboard_type;
  final String? sport_id;
  final String? time_period;
  final int rank;
  final int total_points;
  final int? movement;
  final int? previous_rank;
  final DateTime updated_at;

  const UserRankings({
    required this.id,
    required this.user_id,
    required this.leaderboard_type,
    this.sport_id,
    this.time_period,
    required this.rank,
    required this.total_points,
    this.movement,
    this.previous_rank,
    required this.updated_at,
  });

  factory UserRankings.fromJson(Map<String, dynamic> json) {
    return UserRankings(
      id: json['id'],
      user_id: json['user_id'],
      leaderboard_type: json['leaderboard_type'],
      sport_id: json['sport_id'],
      time_period: json['time_period'],
      rank: json['rank'],
      total_points: json['total_points'],
      movement: json['movement'],
      previous_rank: json['previous_rank'],
      updated_at: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'leaderboard_type': leaderboard_type,
      'sport_id': sport_id,
      'time_period': time_period,
      'rank': rank,
      'total_points': total_points,
      'movement': movement,
      'previous_rank': previous_rank,
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
