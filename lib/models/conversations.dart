// GENERATED from introspect.json — do not edit by hand
class Conversations {
  final String id;
  final String? type;
  final String? name;
  final String? avatar_url;
  final String? created_by;
  final String? last_message_id;
  final DateTime? last_message_at;
  final DateTime created_at;
  final DateTime updated_at;

  const Conversations({
    required this.id,
    this.type,
    this.name,
    this.avatar_url,
    this.created_by,
    this.last_message_id,
    this.last_message_at,
    required this.created_at,
    required this.updated_at,
  });

  factory Conversations.fromJson(Map<String, dynamic> json) {
    return Conversations(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      avatar_url: json['avatar_url'],
      created_by: json['created_by'],
      last_message_id: json['last_message_id'],
      last_message_at: (json['last_message_at'] == null
          ? null
          : DateTime.parse(json['last_message_at'] as String)),
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
      'type': type,
      'name': name,
      'avatar_url': avatar_url,
      'created_by': created_by,
      'last_message_id': last_message_id,
      'last_message_at': last_message_at?.toIso8601String(),
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
