// GENERATED from introspect.json — do not edit by hand
class UserAchievements {
  final String id;
  final String user_id;
  final String achievement_id;
  final Map<String, dynamic>? current_progress;
  final Map<String, dynamic>? required_progress;
  final double? progress_percentage;
  final bool? is_completed;
  final DateTime? completed_at;
  final int? completion_count;
  final DateTime started_at;
  final DateTime last_updated;

  const UserAchievements({
    required this.id,
    required this.user_id,
    required this.achievement_id,
    this.current_progress,
    this.required_progress,
    this.progress_percentage,
    this.is_completed,
    this.completed_at,
    this.completion_count,
    required this.started_at,
    required this.last_updated,
  });

  factory UserAchievements.fromJson(Map<String, dynamic> json) {
    return UserAchievements(
      id: json['id'],
      user_id: json['user_id'],
      achievement_id: json['achievement_id'],
      current_progress: json['current_progress'],
      required_progress: json['required_progress'],
      progress_percentage: json['progress_percentage'],
      is_completed: json['is_completed'],
      completed_at: (json['completed_at'] == null ? null : DateTime.parse(json['completed_at'] as String)),
      completion_count: json['completion_count'],
      started_at: json['started_at'] != null
          ? DateTime.parse(json['started_at'] as String)
          : DateTime.now(),
      last_updated: json['last_updated'] != null
          ? DateTime.parse(json['last_updated'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'achievement_id': achievement_id,
      'current_progress': current_progress,
      'required_progress': required_progress,
      'progress_percentage': progress_percentage,
      'is_completed': is_completed,
      'completed_at': completed_at?.toIso8601String(),
      'completion_count': completion_count,
      'started_at': started_at.toIso8601String(),
      'last_updated': last_updated.toIso8601String(),
    };
  }
}
