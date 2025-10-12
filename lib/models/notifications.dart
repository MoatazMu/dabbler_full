// GENERATED from introspect.json — do not edit by hand
class Notifications {
  final String id;
  final String user_id;
  final String title;
  final String message;
  final String type;
  final String priority;
  final bool? is_read;
  final Map<String, dynamic>? data;
  final String? image_url;
  final String? action_text;
  final String? action_route;
  final DateTime? read_at;
  final DateTime? created_at;
  final DateTime? updated_at;

  const Notifications({
    required this.id,
    required this.user_id,
    required this.title,
    required this.message,
    required this.type,
    required this.priority,
    this.is_read,
    this.data,
    this.image_url,
    this.action_text,
    this.action_route,
    this.read_at,
    this.created_at,
    this.updated_at,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'],
      user_id: json['user_id'],
      title: json['title'],
      message: json['message'],
      type: json['type'],
      priority: json['priority'],
      is_read: json['is_read'],
      data: json['data'],
      image_url: json['image_url'],
      action_text: json['action_text'],
      action_route: json['action_route'],
      read_at: (json['read_at'] == null ? null : DateTime.parse(json['read_at'] as String)),
      created_at: (json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String)),
      updated_at: (json['updated_at'] == null ? null : DateTime.parse(json['updated_at'] as String)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'title': title,
      'message': message,
      'type': type,
      'priority': priority,
      'is_read': is_read,
      'data': data,
      'image_url': image_url,
      'action_text': action_text,
      'action_route': action_route,
      'read_at': read_at?.toIso8601String(),
      'created_at': created_at?.toIso8601String(),
      'updated_at': updated_at?.toIso8601String(),
    };
  }
}
