// GENERATED from introspect.json — do not edit by hand
class EmailOutbox {
  final String id;
  final String user_id;
  final String to_email;
  final String subject;
  final String body;
  final String status;
  final DateTime created_at;
  final DateTime? sent_at;
  final String? fail_reason;

  const EmailOutbox({
    required this.id,
    required this.user_id,
    required this.to_email,
    required this.subject,
    required this.body,
    required this.status,
    required this.created_at,
    this.sent_at,
    this.fail_reason,
  });

  factory EmailOutbox.fromJson(Map<String, dynamic> json) {
    return EmailOutbox(
      id: json['id'],
      user_id: json['user_id'],
      to_email: json['to_email'],
      subject: json['subject'],
      body: json['body'],
      status: json['status'],
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      sent_at: (json['sent_at'] == null
          ? null
          : DateTime.parse(json['sent_at'] as String)),
      fail_reason: json['fail_reason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'to_email': to_email,
      'subject': subject,
      'body': body,
      'status': status,
      'created_at': created_at.toIso8601String(),
      'sent_at': sent_at?.toIso8601String(),
      'fail_reason': fail_reason,
    };
  }
}
