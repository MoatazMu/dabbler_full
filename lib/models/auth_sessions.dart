// GENERATED from introspect.json — do not edit by hand
class AuthSessions {
  final String id;
  final String user_id;
  final String device_id;
  final String? device_name;
  final String? device_type;
  final String? ip_address;
  final String? user_agent;
  final bool? is_active;
  final DateTime? last_activity;
  final DateTime created_at;
  final DateTime? expires_at;

  const AuthSessions({
    required this.id,
    required this.user_id,
    required this.device_id,
    this.device_name,
    this.device_type,
    this.ip_address,
    this.user_agent,
    this.is_active,
    this.last_activity,
    required this.created_at,
    this.expires_at,
  });

  factory AuthSessions.fromJson(Map<String, dynamic> json) {
    return AuthSessions(
      id: json['id'],
      user_id: json['user_id'],
      device_id: json['device_id'],
      device_name: json['device_name'],
      device_type: json['device_type'],
      ip_address: json['ip_address'],
      user_agent: json['user_agent'],
      is_active: json['is_active'],
      last_activity: (json['last_activity'] == null ? null : DateTime.parse(json['last_activity'] as String)),
    created_at: json['created_at'] != null
      ? DateTime.parse(json['created_at'] as String)
      : DateTime.now(),
      expires_at: (json['expires_at'] == null ? null : DateTime.parse(json['expires_at'] as String)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'device_id': device_id,
      'device_name': device_name,
      'device_type': device_type,
      'ip_address': ip_address,
      'user_agent': user_agent,
      'is_active': is_active,
      'last_activity': last_activity?.toIso8601String(),
      'created_at': created_at.toIso8601String(),
      'expires_at': expires_at?.toIso8601String(),
    };
  }
}
