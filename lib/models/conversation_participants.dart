// GENERATED from introspect.json — do not edit by hand
class ConversationParticipants {
  final String id;
  final String conversation_id;
  final String user_id;
  final String? role;
  final String? last_read_message_id;
  final DateTime? last_read_at;
  final bool? is_muted;
  final DateTime? muted_until;
  final DateTime joined_at;
  final DateTime? left_at;

  const ConversationParticipants({
    required this.id,
    required this.conversation_id,
    required this.user_id,
    this.role,
    this.last_read_message_id,
    this.last_read_at,
    this.is_muted,
    this.muted_until,
    required this.joined_at,
    this.left_at,
  });

  factory ConversationParticipants.fromJson(Map<String, dynamic> json) {
    return ConversationParticipants(
      id: json['id'],
      conversation_id: json['conversation_id'],
      user_id: json['user_id'],
      role: json['role'],
      last_read_message_id: json['last_read_message_id'],
      last_read_at: (json['last_read_at'] == null ? null : DateTime.parse(json['last_read_at'] as String)),
      is_muted: json['is_muted'],
      muted_until: (json['muted_until'] == null ? null : DateTime.parse(json['muted_until'] as String)),
    joined_at: json['joined_at'] != null
      ? DateTime.parse(json['joined_at'] as String)
      : DateTime.now(),
      left_at: (json['left_at'] == null ? null : DateTime.parse(json['left_at'] as String)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation_id': conversation_id,
      'user_id': user_id,
      'role': role,
      'last_read_message_id': last_read_message_id,
      'last_read_at': last_read_at?.toIso8601String(),
      'is_muted': is_muted,
      'muted_until': muted_until?.toIso8601String(),
      'joined_at': joined_at.toIso8601String(),
      'left_at': left_at?.toIso8601String(),
    };
  }
}
