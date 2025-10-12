// GENERATED from introspect.json — do not edit by hand
class UserTierProgress {
  final String id;
  final String user_id;
  final String current_tier_id;
  final int? total_points;
  final int? points_to_next_tier;
  final double? tier_progress_percentage;
  final String? highest_tier_achieved;
  final int? tier_up_count;
  final DateTime? last_tier_up;
  final DateTime created_at;
  final DateTime updated_at;

  const UserTierProgress({
    required this.id,
    required this.user_id,
    required this.current_tier_id,
    this.total_points,
    this.points_to_next_tier,
    this.tier_progress_percentage,
    this.highest_tier_achieved,
    this.tier_up_count,
    this.last_tier_up,
    required this.created_at,
    required this.updated_at,
  });

  factory UserTierProgress.fromJson(Map<String, dynamic> json) {
    return UserTierProgress(
      id: json['id'],
      user_id: json['user_id'],
      current_tier_id: json['current_tier_id'],
      total_points: json['total_points'],
      points_to_next_tier: json['points_to_next_tier'],
      tier_progress_percentage: json['tier_progress_percentage'],
      highest_tier_achieved: json['highest_tier_achieved'],
      tier_up_count: json['tier_up_count'],
      last_tier_up: (json['last_tier_up'] == null ? null : DateTime.parse(json['last_tier_up'] as String)),
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
      'current_tier_id': current_tier_id,
      'total_points': total_points,
      'points_to_next_tier': points_to_next_tier,
      'tier_progress_percentage': tier_progress_percentage,
      'highest_tier_achieved': highest_tier_achieved,
      'tier_up_count': tier_up_count,
      'last_tier_up': last_tier_up?.toIso8601String(),
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
