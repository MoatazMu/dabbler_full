// GENERATED from introspect.json — do not edit by hand
class LeaderboardHistory {
  final String id;
  final String leaderboard_id;
  final String user_id;
  final int rank;
  final double score;
  final DateTime snapshot_date;
  final DateTime created_at;

  const LeaderboardHistory({
    required this.id,
    required this.leaderboard_id,
    required this.user_id,
    required this.rank,
    required this.score,
    required this.snapshot_date,
    required this.created_at,
  });

  factory LeaderboardHistory.fromJson(Map<String, dynamic> json) {
    return LeaderboardHistory(
      id: json['id'],
      leaderboard_id: json['leaderboard_id'],
      user_id: json['user_id'],
      rank: json['rank'],
      score: json['score'],
      snapshot_date: json['snapshot_date'] != null
          ? DateTime.parse(json['snapshot_date'] as String)
          : DateTime.now(),
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'leaderboard_id': leaderboard_id,
      'user_id': user_id,
      'rank': rank,
      'score': score,
      'snapshot_date': snapshot_date.toIso8601String(),
      'created_at': created_at.toIso8601String(),
    };
  }
}
