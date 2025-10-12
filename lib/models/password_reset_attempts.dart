// GENERATED from introspect.json — do not edit by hand
class PasswordResetAttempts {
  final String id;
  final String email;
  final String? ip_address;
  final String? status;
  final String? token_hash;
  final DateTime? attempted_at;
  final DateTime? completed_at;
  final DateTime? expires_at;

  const PasswordResetAttempts({
    required this.id,
    required this.email,
    this.ip_address,
    this.status,
    this.token_hash,
    this.attempted_at,
    this.completed_at,
    this.expires_at,
  });

  factory PasswordResetAttempts.fromJson(Map<String, dynamic> json) {
    return PasswordResetAttempts(
      id: json['id'],
      email: json['email'],
      ip_address: json['ip_address'],
      status: json['status'],
      token_hash: json['token_hash'],
      attempted_at: (json['attempted_at'] == null ? null : DateTime.parse(json['attempted_at'] as String)),
      completed_at: (json['completed_at'] == null ? null : DateTime.parse(json['completed_at'] as String)),
      expires_at: (json['expires_at'] == null ? null : DateTime.parse(json['expires_at'] as String)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'ip_address': ip_address,
      'status': status,
      'token_hash': token_hash,
      'attempted_at': attempted_at?.toIso8601String(),
      'completed_at': completed_at?.toIso8601String(),
      'expires_at': expires_at?.toIso8601String(),
    };
  }
}
