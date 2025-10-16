// GENERATED from introspect.json — do not edit by hand
class ProfileMetrics {
  final String id;
  final DateTime metric_date;
  final int? total_profiles;
  final int? completed_profiles;
  final int? active_users_daily;
  final int? active_users_weekly;
  final int? new_profiles_count;
  final double? avg_completion_percentage;
  final double? avg_sports_per_user;
  final DateTime created_at;

  const ProfileMetrics({
    required this.id,
    required this.metric_date,
    this.total_profiles,
    this.completed_profiles,
    this.active_users_daily,
    this.active_users_weekly,
    this.new_profiles_count,
    this.avg_completion_percentage,
    this.avg_sports_per_user,
    required this.created_at,
  });

  factory ProfileMetrics.fromJson(Map<String, dynamic> json) {
    return ProfileMetrics(
      id: json['id'],
      metric_date: json['metric_date'] != null
          ? DateTime.parse(json['metric_date'] as String)
          : DateTime.now(),
      total_profiles: json['total_profiles'],
      completed_profiles: json['completed_profiles'],
      active_users_daily: json['active_users_daily'],
      active_users_weekly: json['active_users_weekly'],
      new_profiles_count: json['new_profiles_count'],
      avg_completion_percentage: json['avg_completion_percentage'],
      avg_sports_per_user: json['avg_sports_per_user'],
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'metric_date': metric_date.toIso8601String(),
      'total_profiles': total_profiles,
      'completed_profiles': completed_profiles,
      'active_users_daily': active_users_daily,
      'active_users_weekly': active_users_weekly,
      'new_profiles_count': new_profiles_count,
      'avg_completion_percentage': avg_completion_percentage,
      'avg_sports_per_user': avg_sports_per_user,
      'created_at': created_at.toIso8601String(),
    };
  }
}
