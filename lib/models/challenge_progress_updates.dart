// GENERATED from introspect.json — do not edit by hand
class ChallengeProgressUpdates {
  final String id;
  final String participant_id;
  final double value_added;
  final double new_total;
  final String? evidence_type;
  final String? evidence_id;
  final String? evidence_url;
  final bool? is_verified;
  final String? verified_by;
  final String? notes;
  final DateTime created_at;

  const ChallengeProgressUpdates({
    required this.id,
    required this.participant_id,
    required this.value_added,
    required this.new_total,
    this.evidence_type,
    this.evidence_id,
    this.evidence_url,
    this.is_verified,
    this.verified_by,
    this.notes,
    required this.created_at,
  });

  factory ChallengeProgressUpdates.fromJson(Map<String, dynamic> json) {
    return ChallengeProgressUpdates(
      id: json['id'],
      participant_id: json['participant_id'],
      value_added: json['value_added'],
      new_total: json['new_total'],
      evidence_type: json['evidence_type'],
      evidence_id: json['evidence_id'],
      evidence_url: json['evidence_url'],
      is_verified: json['is_verified'],
      verified_by: json['verified_by'],
      notes: json['notes'],
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participant_id': participant_id,
      'value_added': value_added,
      'new_total': new_total,
      'evidence_type': evidence_type,
      'evidence_id': evidence_id,
      'evidence_url': evidence_url,
      'is_verified': is_verified,
      'verified_by': verified_by,
      'notes': notes,
      'created_at': created_at.toIso8601String(),
    };
  }
}
