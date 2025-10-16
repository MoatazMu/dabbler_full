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
    // Local helpers for null-safe parsing
    String? _s(dynamic v) => v == null ? null : v as String;
    DateTime? _dt(dynamic v) => v == null ? null : DateTime.parse(v as String);

    // Validate required fields
    final id = _s(json['id']);
    if (id == null || id.isEmpty) {
      throw Exception('Friendships.fromJson: missing or empty id. Row: $json');
    }

    final userId = _s(json['user_id']);
    if (userId == null || userId.isEmpty) {
      throw Exception('Friendships.fromJson: missing user_id. Row: $json');
    }

    final friendId = _s(json['friend_id']);
    if (friendId == null || friendId.isEmpty) {
      throw Exception('Friendships.fromJson: missing friend_id. Row: $json');
    }

    final status = _s(json['status']);
    if (status == null || status.isEmpty) {
      throw Exception('Friendships.fromJson: missing status. Row: $json');
    }

    final initiatedBy = _s(json['initiated_by']);
    if (initiatedBy == null || initiatedBy.isEmpty) {
      throw Exception('Friendships.fromJson: missing initiated_by. Row: $json');
    }

    final createdAtStr = _s(json['created_at']);
    if (createdAtStr == null) {
      throw Exception('Friendships.fromJson: missing created_at. Row: $json');
    }

    final updatedAtStr = _s(json['updated_at']);
    if (updatedAtStr == null) {
      throw Exception('Friendships.fromJson: missing updated_at. Row: $json');
    }

    return Friendships(
      id: id,
      user_id: userId,
      friend_id: friendId,
      status: status,
      initiated_by: initiatedBy,
      became_friends_at: _dt(json['became_friends_at']),
      blocked_at: _dt(json['blocked_at']),
      blocked_by: _s(json['blocked_by']),
      message: _s(json['message']),
      created_at: DateTime.parse(createdAtStr),
      updated_at: DateTime.parse(updatedAtStr),
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
