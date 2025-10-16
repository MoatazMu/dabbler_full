// GENERATED from introspect.json — do not edit by hand
class GameInvitations {
  final String id;
  final String game_id;
  final String inviter_id;
  final String? invitee_email;
  final String? invitee_phone;
  final String? invitee_id;
  final String? status;
  final String? message;
  final DateTime invited_at;
  final DateTime? responded_at;
  final DateTime? expires_at;

  const GameInvitations({
    required this.id,
    required this.game_id,
    required this.inviter_id,
    this.invitee_email,
    this.invitee_phone,
    this.invitee_id,
    this.status,
    this.message,
    required this.invited_at,
    this.responded_at,
    this.expires_at,
  });

  factory GameInvitations.fromJson(Map<String, dynamic> json) {
    return GameInvitations(
      id: json['id'],
      game_id: json['game_id'],
      inviter_id: json['inviter_id'],
      invitee_email: json['invitee_email'],
      invitee_phone: json['invitee_phone'],
      invitee_id: json['invitee_id'],
      status: json['status'],
      message: json['message'],
      invited_at: json['invited_at'] != null
          ? DateTime.parse(json['invited_at'] as String)
          : DateTime.now(),
      responded_at: (json['responded_at'] == null
          ? null
          : DateTime.parse(json['responded_at'] as String)),
      expires_at: (json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'game_id': game_id,
      'inviter_id': inviter_id,
      'invitee_email': invitee_email,
      'invitee_phone': invitee_phone,
      'invitee_id': invitee_id,
      'status': status,
      'message': message,
      'invited_at': invited_at.toIso8601String(),
      'responded_at': responded_at?.toIso8601String(),
      'expires_at': expires_at?.toIso8601String(),
    };
  }
}
