// GENERATED from introspect.json — do not edit by hand
class MemberActivityLog {
  final String id;
  final String group_id;
  final String user_id;
  final String activity_type;
  final String? activity_id;
  final int? points_earned;
  final DateTime created_at;

  const MemberActivityLog({
    required this.id,
    required this.group_id,
    required this.user_id,
    required this.activity_type,
    this.activity_id,
    this.points_earned,
    required this.created_at,
  });

  factory MemberActivityLog.fromJson(Map<String, dynamic> json) {
    return MemberActivityLog(
      id: json['id'],
      group_id: json['group_id'],
      user_id: json['user_id'],
      activity_type: json['activity_type'],
      activity_id: json['activity_id'],
      points_earned: json['points_earned'],
    created_at: json['created_at'] != null
      ? DateTime.parse(json['created_at'] as String)
      : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': group_id,
      'user_id': user_id,
      'activity_type': activity_type,
      'activity_id': activity_id,
      'points_earned': points_earned,
      'created_at': created_at.toIso8601String(),
    };
  }
}
