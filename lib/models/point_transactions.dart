// GENERATED from introspect.json — do not edit by hand
class PointTransactions {
  final String id;
  final String? user_id;
  final String type;
  final int points;
  final String? achievement_id;
  final String? game_id;
  final String? description;
  final Map<String, dynamic>? metadata;
  final Map<String, dynamic>? multipliers_applied;
  final int final_points;
  final int balance_before;
  final int balance_after;
  final DateTime created_at;
  final DateTime? created_date_utc;

  const PointTransactions({
    required this.id,
    this.user_id,
    required this.type,
    required this.points,
    this.achievement_id,
    this.game_id,
    this.description,
    this.metadata,
    this.multipliers_applied,
    required this.final_points,
    required this.balance_before,
    required this.balance_after,
    required this.created_at,
    this.created_date_utc,
  });

  factory PointTransactions.fromJson(Map<String, dynamic> json) {
    return PointTransactions(
      id: json['id'],
      user_id: json['user_id'],
      type: json['type'],
      points: json['points'],
      achievement_id: json['achievement_id'],
      game_id: json['game_id'],
      description: json['description'],
      metadata: json['metadata'],
      multipliers_applied: json['multipliers_applied'],
      final_points: json['final_points'],
      balance_before: json['balance_before'],
      balance_after: json['balance_after'],
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      created_date_utc: (json['created_date_utc'] == null
          ? null
          : DateTime.parse(json['created_date_utc'] as String)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'type': type,
      'points': points,
      'achievement_id': achievement_id,
      'game_id': game_id,
      'description': description,
      'metadata': metadata,
      'multipliers_applied': multipliers_applied,
      'final_points': final_points,
      'balance_before': balance_before,
      'balance_after': balance_after,
      'created_at': created_at.toIso8601String(),
      'created_date_utc': created_date_utc?.toIso8601String(),
    };
  }
}
