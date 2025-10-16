// GENERATED from introspect.json — do not edit by hand
class ProfileAuditLog {
  final String id;
  final String user_id;
  final String table_name;
  final String action;
  final DateTime changed_at;
  final String? changed_by;
  final Map<String, dynamic>? changed_to;

  const ProfileAuditLog({
    required this.id,
    required this.user_id,
    required this.table_name,
    required this.action,
    required this.changed_at,
    this.changed_by,
    this.changed_to,
  });

  factory ProfileAuditLog.fromJson(Map<String, dynamic> json) {
    return ProfileAuditLog(
      id: json['id'],
      user_id: json['user_id'],
      table_name: json['table_name'],
      action: json['action'],
      changed_at: json['changed_at'] != null
          ? DateTime.parse(json['changed_at'] as String)
          : DateTime.now(),
      changed_by: json['changed_by'],
      changed_to: json['changed_to'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'table_name': table_name,
      'action': action,
      'changed_at': changed_at.toIso8601String(),
      'changed_by': changed_by,
      'changed_to': changed_to,
    };
  }
}
