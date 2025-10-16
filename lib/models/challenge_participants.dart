// GENERATED from introspect.json — do not edit by hand
class ChallengeParticipants {
  final String id;
  final String challenge_id;
  final String? user_id;
  final String? team_id;
  final double? current_value;
  final double? progress_percentage;
  final bool? is_completed;
  final DateTime? completed_at;
  final int? rank;
  final int? previous_rank;
  final DateTime? last_update;
  final int? update_count;
  final bool? is_verified;
  final String? verified_by;
  final DateTime? verified_at;
  final DateTime joined_at;
  final DateTime? left_at;

  const ChallengeParticipants({
    required this.id,
    required this.challenge_id,
    this.user_id,
    this.team_id,
    this.current_value,
    this.progress_percentage,
    this.is_completed,
    this.completed_at,
    this.rank,
    this.previous_rank,
    this.last_update,
    this.update_count,
    this.is_verified,
    this.verified_by,
    this.verified_at,
    required this.joined_at,
    this.left_at,
  });

  factory ChallengeParticipants.fromJson(Map<String, dynamic> json) {
    return ChallengeParticipants(
      id: json['id'],
      challenge_id: json['challenge_id'],
      user_id: json['user_id'],
      team_id: json['team_id'],
      current_value: json['current_value'],
      progress_percentage: json['progress_percentage'],
      is_completed: json['is_completed'],
      completed_at: (json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String)),
      rank: json['rank'],
      previous_rank: json['previous_rank'],
      last_update: (json['last_update'] == null
          ? null
          : DateTime.parse(json['last_update'] as String)),
      update_count: json['update_count'],
      is_verified: json['is_verified'],
      verified_by: json['verified_by'],
      verified_at: (json['verified_at'] == null
          ? null
          : DateTime.parse(json['verified_at'] as String)),
      joined_at: json['joined_at'] != null
          ? DateTime.parse(json['joined_at'] as String)
          : DateTime.now(),
      left_at: (json['left_at'] == null
          ? null
          : DateTime.parse(json['left_at'] as String)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'challenge_id': challenge_id,
      'user_id': user_id,
      'team_id': team_id,
      'current_value': current_value,
      'progress_percentage': progress_percentage,
      'is_completed': is_completed,
      'completed_at': completed_at?.toIso8601String(),
      'rank': rank,
      'previous_rank': previous_rank,
      'last_update': last_update?.toIso8601String(),
      'update_count': update_count,
      'is_verified': is_verified,
      'verified_by': verified_by,
      'verified_at': verified_at?.toIso8601String(),
      'joined_at': joined_at.toIso8601String(),
      'left_at': left_at?.toIso8601String(),
    };
  }
}
