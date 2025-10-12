// GENERATED from introspect.json — do not edit by hand
class TournamentParticipants {
  final String id;
  final String tournament_id;
  final String? user_id;
  final String? team_id;
  final String display_name;
  final int? seed_number;
  final int? skill_rating;
  final int? current_round;
  final bool? is_eliminated;
  final int? final_position;
  final int? matches_played;
  final int? matches_won;
  final int? matches_lost;
  final int? matches_drawn;
  final int? points_scored;
  final int? points_conceded;
  final int? total_points;
  final DateTime registered_at;
  final DateTime? eliminated_at;

  const TournamentParticipants({
    required this.id,
    required this.tournament_id,
    this.user_id,
    this.team_id,
    required this.display_name,
    this.seed_number,
    this.skill_rating,
    this.current_round,
    this.is_eliminated,
    this.final_position,
    this.matches_played,
    this.matches_won,
    this.matches_lost,
    this.matches_drawn,
    this.points_scored,
    this.points_conceded,
    this.total_points,
    required this.registered_at,
    this.eliminated_at,
  });

  factory TournamentParticipants.fromJson(Map<String, dynamic> json) {
    return TournamentParticipants(
      id: json['id'],
      tournament_id: json['tournament_id'],
      user_id: json['user_id'],
      team_id: json['team_id'],
      display_name: json['display_name'],
      seed_number: json['seed_number'],
      skill_rating: json['skill_rating'],
      current_round: json['current_round'],
      is_eliminated: json['is_eliminated'],
      final_position: json['final_position'],
      matches_played: json['matches_played'],
      matches_won: json['matches_won'],
      matches_lost: json['matches_lost'],
      matches_drawn: json['matches_drawn'],
      points_scored: json['points_scored'],
      points_conceded: json['points_conceded'],
      total_points: json['total_points'],
      registered_at: json['registered_at'] != null
          ? DateTime.parse(json['registered_at'] as String)
          : DateTime.now(),
      eliminated_at: (json['eliminated_at'] == null ? null : DateTime.parse(json['eliminated_at'] as String)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tournament_id': tournament_id,
      'user_id': user_id,
      'team_id': team_id,
      'display_name': display_name,
      'seed_number': seed_number,
      'skill_rating': skill_rating,
      'current_round': current_round,
      'is_eliminated': is_eliminated,
      'final_position': final_position,
      'matches_played': matches_played,
      'matches_won': matches_won,
      'matches_lost': matches_lost,
      'matches_drawn': matches_drawn,
      'points_scored': points_scored,
      'points_conceded': points_conceded,
      'total_points': total_points,
      'registered_at': registered_at.toIso8601String(),
      'eliminated_at': eliminated_at?.toIso8601String(),
    };
  }
}
