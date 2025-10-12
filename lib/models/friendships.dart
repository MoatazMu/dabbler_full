// GENERATED from introspect.json — do not edit by hand
class Friendships {
  final String id;
  final String user_id;
  final String friend_id;
  final String status;
  final String initiated_by;
  final DateTime? became_friends_at;
  final DateTime? blocked_at;
  final String? blocked_by;
  final String? message;
  final DateTime created_at;
  final DateTime updated_at;

  const Friendships({
    required this.id,
    required this.user_id,
    required this.friend_id,
    required this.status,
    required this.initiated_by,
    this.became_friends_at,
    this.blocked_at,
    this.blocked_by,
    this.message,
    required this.created_at,
    required this.updated_at,
  });

  factory Friendships.fromJson(Map<String, dynamic> json) {
    return Friendships(
      id: json['id'],
      user_id: json['user_id'],
      friend_id: json['friend_id'],
      status: json['status'],
      initiated_by: json['initiated_by'],
      became_friends_at: (json['became_friends_at'] == null ? null : DateTime.parse(json['became_friends_at'] as String)),
      blocked_at: (json['blocked_at'] == null ? null : DateTime.parse(json['blocked_at'] as String)),
      blocked_by: json['blocked_by'],
      message: json['message'],
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
      'friend_id': friend_id,
      'status': status,
      'initiated_by': initiated_by,
      'became_friends_at': became_friends_at?.toIso8601String(),
      'blocked_at': blocked_at?.toIso8601String(),
      'blocked_by': blocked_by,
      'message': message,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
