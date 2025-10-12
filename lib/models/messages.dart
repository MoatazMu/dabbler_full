// GENERATED from introspect.json — do not edit by hand
class Messages {
  final String id;
  final String conversation_id;
  final String? sender_id;
  final String? content;
  final List<dynamic>? media_urls;
  final String? reply_to_message_id;
  final bool? is_edited;
  final DateTime? edited_at;
  final bool? is_deleted;
  final DateTime? deleted_at;
  final List<dynamic>? delivered_to;
  final List<dynamic>? read_by;
  final DateTime created_at;
  final String? topic;

  const Messages({
    required this.id,
    required this.conversation_id,
    this.sender_id,
    this.content,
    this.media_urls,
    this.reply_to_message_id,
    this.is_edited,
    this.edited_at,
    this.is_deleted,
    this.deleted_at,
    this.delivered_to,
    this.read_by,
    required this.created_at,
    this.topic,
  });

  factory Messages.fromJson(Map<String, dynamic> json) {
    return Messages(
      id: json['id'],
      conversation_id: json['conversation_id'],
      sender_id: json['sender_id'],
      content: json['content'],
      media_urls: json['media_urls'],
      reply_to_message_id: json['reply_to_message_id'],
      is_edited: json['is_edited'],
      edited_at: (json['edited_at'] == null ? null : DateTime.parse(json['edited_at'] as String)),
      is_deleted: json['is_deleted'],
      deleted_at: (json['deleted_at'] == null ? null : DateTime.parse(json['deleted_at'] as String)),
      delivered_to: json['delivered_to'],
      read_by: json['read_by'],
    created_at: json['created_at'] != null
      ? DateTime.parse(json['created_at'] as String)
      : DateTime.now(),
      topic: json['topic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation_id': conversation_id,
      'sender_id': sender_id,
      'content': content,
      'media_urls': media_urls,
      'reply_to_message_id': reply_to_message_id,
      'is_edited': is_edited,
      'edited_at': edited_at?.toIso8601String(),
      'is_deleted': is_deleted,
      'deleted_at': deleted_at?.toIso8601String(),
      'delivered_to': delivered_to,
      'read_by': read_by,
      'created_at': created_at.toIso8601String(),
      'topic': topic,
    };
  }
}
