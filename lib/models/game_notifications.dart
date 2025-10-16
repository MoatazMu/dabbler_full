// GENERATED from introspect.json — do not edit by hand
class GameNotifications {
  final String id;
  final String game_id;
  final String recipient_id;
  final String type;
  final String title;
  final String message;
  final bool? is_read;
  final DateTime sent_at;
  final DateTime? read_at;
  final Map<String, dynamic>? metadata;

  const GameNotifications({
    required this.id,
    required this.game_id,
    required this.recipient_id,
    required this.type,
    required this.title,
    required this.message,
    this.is_read,
    required this.sent_at,
    this.read_at,
    this.metadata,
  });

  factory GameNotifications.fromJson(Map<String, dynamic> json) {
    return GameNotifications(
      id: json['id'],
      game_id: json['game_id'],
      recipient_id: json['recipient_id'],
      type: json['type'],
      title: json['title'],
      message: json['message'],
      is_read: json['is_read'],
      sent_at: json['sent_at'] != null
          ? DateTime.parse(json['sent_at'] as String)
          : DateTime.now(),
      read_at: (json['read_at'] == null
          ? null
          : DateTime.parse(json['read_at'] as String)),
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'game_id': game_id,
      'recipient_id': recipient_id,
      'type': type,
      'title': title,
      'message': message,
      'is_read': is_read,
      'sent_at': sent_at.toIso8601String(),
      'read_at': read_at?.toIso8601String(),
      'metadata': metadata,
    };
  }
}
