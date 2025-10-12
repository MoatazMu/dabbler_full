// GENERATED from introspect.json — do not edit by hand
class CommunityGrowthMetrics {
  final String id;
  final DateTime metric_week;
  final int? total_groups;
  final int? active_groups;
  final int? total_members;
  final int? weekly_active_members;
  final int? events_created;
  final int? event_participants;
  final double? event_completion_rate;
  final Map<String, dynamic>? metrics_by_region;
  final Map<String, dynamic>? metrics_by_sport;
  final DateTime created_at;

  const CommunityGrowthMetrics({
    required this.id,
    required this.metric_week,
    this.total_groups,
    this.active_groups,
    this.total_members,
    this.weekly_active_members,
    this.events_created,
    this.event_participants,
    this.event_completion_rate,
    this.metrics_by_region,
    this.metrics_by_sport,
    required this.created_at,
  });

  factory CommunityGrowthMetrics.fromJson(Map<String, dynamic> json) {
    return CommunityGrowthMetrics(
      id: json['id'],
    metric_week: json['metric_week'] != null
      ? DateTime.parse(json['metric_week'] as String)
      : DateTime.now(),
      total_groups: json['total_groups'],
      active_groups: json['active_groups'],
      total_members: json['total_members'],
      weekly_active_members: json['weekly_active_members'],
      events_created: json['events_created'],
      event_participants: json['event_participants'],
      event_completion_rate: json['event_completion_rate'],
      metrics_by_region: json['metrics_by_region'],
      metrics_by_sport: json['metrics_by_sport'],
    created_at: json['created_at'] != null
      ? DateTime.parse(json['created_at'] as String)
      : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'metric_week': metric_week.toIso8601String(),
      'total_groups': total_groups,
      'active_groups': active_groups,
      'total_members': total_members,
      'weekly_active_members': weekly_active_members,
      'events_created': events_created,
      'event_participants': event_participants,
      'event_completion_rate': event_completion_rate,
      'metrics_by_region': metrics_by_region,
      'metrics_by_sport': metrics_by_sport,
      'created_at': created_at.toIso8601String(),
    };
  }
}
