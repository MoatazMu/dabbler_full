// GENERATED from introspect.json — do not edit by hand
class LeaderboardEntries {
  final String id;
  final String leaderboard_id;
  final String user_id;
  final int rank;
  final int? previous_rank;
  final int? rank_change;
  final double score;
  final int? activities_count;
  final int? wins_count;
  final Map<String, dynamic>? metrics;
  final double? best_score;
  final DateTime? best_score_date;
  final DateTime calculated_at;

  const LeaderboardEntries({
    required this.id,
    required this.leaderboard_id,
    required this.user_id,
    required this.rank,
    this.previous_rank,
    this.rank_change,
    required this.score,
    this.activities_count,
    this.wins_count,
    this.metrics,
    this.best_score,
    this.best_score_date,
    required this.calculated_at,
  });

  factory LeaderboardEntries.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntries(
      id: json['id'],
      leaderboard_id: json['leaderboard_id'],
      user_id: json['user_id'],
      rank: json['rank'],
      previous_rank: json['previous_rank'],
      rank_change: json['rank_change'],
      score: json['score'],
      activities_count: json['activities_count'],
      wins_count: json['wins_count'],
      metrics: json['metrics'],
      best_score: json['best_score'],
      best_score_date: json['best_score_date'] != null
          ? DateTime.parse(json['best_score_date'] as String)
          : null,
      calculated_at: json['calculated_at'] != null
          ? DateTime.parse(json['calculated_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'leaderboard_id': leaderboard_id,
      'user_id': user_id,
      'rank': rank,
      'previous_rank': previous_rank,
      'rank_change': rank_change,
      'score': score,
      'activities_count': activities_count,
      'wins_count': wins_count,
      'metrics': metrics,
      'best_score': best_score,
      'best_score_date': best_score_date?.toIso8601String(),
      'calculated_at': calculated_at.toIso8601String(),
    };
  }
}
