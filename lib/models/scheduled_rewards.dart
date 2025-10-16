// GENERATED from introspect.json — do not edit by hand
class ScheduledRewards {
  final String id;
  final String user_id;
  final String reward_type;
  final DateTime scheduled_date;
  final int? points_amount;
  final Map<String, dynamic>? metadata;
  final bool? claimed;
  final DateTime? claimed_at;
  final DateTime? expires_at;
  final DateTime created_at;

  const ScheduledRewards({
    required this.id,
    required this.user_id,
    required this.reward_type,
    required this.scheduled_date,
    this.points_amount,
    this.metadata,
    this.claimed,
    this.claimed_at,
    this.expires_at,
    required this.created_at,
  });

  factory ScheduledRewards.fromJson(Map<String, dynamic> json) {
    return ScheduledRewards(
      id: json['id'],
      user_id: json['user_id'],
      reward_type: json['reward_type'],
      scheduled_date: json['scheduled_date'] != null
          ? DateTime.parse(json['scheduled_date'] as String)
          : DateTime.now(),
      points_amount: json['points_amount'],
      metadata: json['metadata'],
      claimed: json['claimed'],
      claimed_at: (json['claimed_at'] == null
          ? null
          : DateTime.parse(json['claimed_at'] as String)),
      expires_at: (json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String)),
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'reward_type': reward_type,
      'scheduled_date': scheduled_date.toIso8601String(),
      'points_amount': points_amount,
      'metadata': metadata,
      'claimed': claimed,
      'claimed_at': claimed_at?.toIso8601String(),
      'expires_at': expires_at?.toIso8601String(),
      'created_at': created_at.toIso8601String(),
    };
  }
}
