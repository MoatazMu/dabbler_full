// GENERATED from introspect.json — do not edit by hand
class EventRegistrations {
  final String id;
  final String event_id;
  final String user_id;
  final String? status;
  final String? team_name;
  final String? position;
  final String? notes;
  final String? payment_status;
  final double? payment_amount;
  final DateTime? payment_date;
  final bool? checked_in;
  final DateTime? checked_in_at;
  final DateTime registered_at;
  final DateTime? cancelled_at;

  const EventRegistrations({
    required this.id,
    required this.event_id,
    required this.user_id,
    this.status,
    this.team_name,
    this.position,
    this.notes,
    this.payment_status,
    this.payment_amount,
    this.payment_date,
    this.checked_in,
    this.checked_in_at,
    required this.registered_at,
    this.cancelled_at,
  });

  factory EventRegistrations.fromJson(Map<String, dynamic> json) {
    return EventRegistrations(
      id: json['id'],
      event_id: json['event_id'],
      user_id: json['user_id'],
      status: json['status'],
      team_name: json['team_name'],
      position: json['position'],
      notes: json['notes'],
      payment_status: json['payment_status'],
      payment_amount: json['payment_amount'],
      payment_date: (json['payment_date'] == null ? null : DateTime.parse(json['payment_date'] as String)),
      checked_in: json['checked_in'],
      checked_in_at: (json['checked_in_at'] == null ? null : DateTime.parse(json['checked_in_at'] as String)),
    registered_at: json['registered_at'] != null
      ? DateTime.parse(json['registered_at'] as String)
      : DateTime.now(),
      cancelled_at: (json['cancelled_at'] == null ? null : DateTime.parse(json['cancelled_at'] as String)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_id': event_id,
      'user_id': user_id,
      'status': status,
      'team_name': team_name,
      'position': position,
      'notes': notes,
      'payment_status': payment_status,
      'payment_amount': payment_amount,
      'payment_date': payment_date?.toIso8601String(),
      'checked_in': checked_in,
      'checked_in_at': checked_in_at?.toIso8601String(),
      'registered_at': registered_at.toIso8601String(),
      'cancelled_at': cancelled_at?.toIso8601String(),
    };
  }
}
