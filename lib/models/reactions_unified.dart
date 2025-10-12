// GENERATED from introspect.json — do not edit by hand
class ReactionsUnified {
  final String id;
  final String user_id;
  final String target_type;
  final String target_id;
  final String reaction;
  final DateTime created_at;

  const ReactionsUnified({
    required this.id,
    required this.user_id,
    required this.target_type,
    required this.target_id,
    required this.reaction,
    required this.created_at,
  });

  factory ReactionsUnified.fromJson(Map<String, dynamic> json) {
    return ReactionsUnified(
      id: json['id'],
      user_id: json['user_id'],
      target_type: json['target_type'],
      target_id: json['target_id'],
      reaction: json['reaction'],
    created_at: json['created_at'] != null
      ? DateTime.parse(json['created_at'] as String)
      : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'target_type': target_type,
      'target_id': target_id,
      'reaction': reaction,
      'created_at': created_at.toIso8601String(),
    };
  }
}
