// GENERATED from introspect.json — do not edit by hand
class ActivityLog {
  final String id;
  final String user_id;
  final String activity_type;
  final String? activity_subtype;
  final String title;
  final String? description;
  final String? venue;
  final double? amount;
  final String? currency;
  final int? points;
  final String? status;
  final String? target_id;
  final String? target_type;
  final String? target_user_id;
  final String? target_user_name;
  final String? target_user_avatar;
  final int? count;
  final Map<String, dynamic> metadata;
  final String? action_route;
  final DateTime created_at;

  const ActivityLog({
    required this.id,
    required this.user_id,
    required this.activity_type,
    this.activity_subtype,
    required this.title,
    this.description,
    this.venue,
    this.amount,
    this.currency,
    this.points,
    this.status,
    this.target_id,
    this.target_type,
    this.target_user_id,
    this.target_user_name,
    this.target_user_avatar,
    this.count,
    required this.metadata,
    this.action_route,
    required this.created_at,
  });

  factory ActivityLog.fromJson(Map<String, dynamic> json) {
    return ActivityLog(
      id: json['id'],
      user_id: json['user_id'],
      activity_type: json['activity_type'],
      activity_subtype: json['activity_subtype'],
      title: json['title'],
      description: json['description'],
      venue: json['venue'],
      amount: json['amount'],
      currency: json['currency'],
      points: json['points'],
      status: json['status'],
      target_id: json['target_id'],
      target_type: json['target_type'],
      target_user_id: json['target_user_id'],
      target_user_name: json['target_user_name'],
      target_user_avatar: json['target_user_avatar'],
      count: json['count'],
      metadata: json['metadata'],
      action_route: json['action_route'],
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'activity_type': activity_type,
      'activity_subtype': activity_subtype,
      'title': title,
      'description': description,
      'venue': venue,
      'amount': amount,
      'currency': currency,
      'points': points,
      'status': status,
      'target_id': target_id,
      'target_type': target_type,
      'target_user_id': target_user_id,
      'target_user_name': target_user_name,
      'target_user_avatar': target_user_avatar,
      'count': count,
      'metadata': metadata,
      'action_route': action_route,
      'created_at': created_at.toIso8601String(),
    };
  }
}
