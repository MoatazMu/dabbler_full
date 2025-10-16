// GENERATED from introspect.json — do not edit by hand
class NotificationsUnified {
  final String id;
  final String user_id;
  final String? actor_id;
  final String category;
  final String kind;
  final Map<String, dynamic> data;
  final bool is_read;
  final DateTime created_at;

  const NotificationsUnified({
    required this.id,
    required this.user_id,
    this.actor_id,
    required this.category,
    required this.kind,
    required this.data,
    required this.is_read,
    required this.created_at,
  });

  factory NotificationsUnified.fromJson(Map<String, dynamic> json) {
    return NotificationsUnified(
      id: json['id'],
      user_id: json['user_id'],
      actor_id: json['actor_id'],
      category: json['category'],
      kind: json['kind'],
      data: json['data'],
      is_read: json['is_read'],
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'actor_id': actor_id,
      'category': category,
      'kind': kind,
      'data': data,
      'is_read': is_read,
      'created_at': created_at.toIso8601String(),
    };
  }
}
