// GENERATED from introspect.json — do not edit by hand
class CommunityAnalytics {
  final String id;
  final String? group_id;
  final DateTime metric_date;
  final int? total_members;
  final int? new_members;
  final int? active_members;
  final int? churned_members;
  final int? events_created;
  final int? events_completed;
  final int? total_participants;
  final double? average_event_size;
  final int? posts_created;
  final int? comments_created;
  final int? reactions_count;
  final double? average_engagement_rate;
  final int? challenges_created;
  final int? challenge_participants;
  final double? challenge_completion_rate;
  final int? tournaments_hosted;
  final int? tournament_participants;
  final int? matches_played;
  final double? growth_rate;
  final double? retention_rate;
  final DateTime created_at;

  const CommunityAnalytics({
    required this.id,
    this.group_id,
    required this.metric_date,
    this.total_members,
    this.new_members,
    this.active_members,
    this.churned_members,
    this.events_created,
    this.events_completed,
    this.total_participants,
    this.average_event_size,
    this.posts_created,
    this.comments_created,
    this.reactions_count,
    this.average_engagement_rate,
    this.challenges_created,
    this.challenge_participants,
    this.challenge_completion_rate,
    this.tournaments_hosted,
    this.tournament_participants,
    this.matches_played,
    this.growth_rate,
    this.retention_rate,
    required this.created_at,
  });

  factory CommunityAnalytics.fromJson(Map<String, dynamic> json) {
    return CommunityAnalytics(
      id: json['id'],
      group_id: json['group_id'],
    metric_date: json['metric_date'] != null
      ? DateTime.parse(json['metric_date'] as String)
      : DateTime.now(),
      total_members: json['total_members'],
      new_members: json['new_members'],
      active_members: json['active_members'],
      churned_members: json['churned_members'],
      events_created: json['events_created'],
      events_completed: json['events_completed'],
      total_participants: json['total_participants'],
      average_event_size: json['average_event_size'],
      posts_created: json['posts_created'],
      comments_created: json['comments_created'],
      reactions_count: json['reactions_count'],
      average_engagement_rate: json['average_engagement_rate'],
      challenges_created: json['challenges_created'],
      challenge_participants: json['challenge_participants'],
      challenge_completion_rate: json['challenge_completion_rate'],
      tournaments_hosted: json['tournaments_hosted'],
      tournament_participants: json['tournament_participants'],
      matches_played: json['matches_played'],
      growth_rate: json['growth_rate'],
      retention_rate: json['retention_rate'],
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': group_id,
      'metric_date': metric_date.toIso8601String(),
      'total_members': total_members,
      'new_members': new_members,
      'active_members': active_members,
      'churned_members': churned_members,
      'events_created': events_created,
      'events_completed': events_completed,
      'total_participants': total_participants,
      'average_event_size': average_event_size,
      'posts_created': posts_created,
      'comments_created': comments_created,
      'reactions_count': reactions_count,
      'average_engagement_rate': average_engagement_rate,
      'challenges_created': challenges_created,
      'challenge_participants': challenge_participants,
      'challenge_completion_rate': challenge_completion_rate,
      'tournaments_hosted': tournaments_hosted,
      'tournament_participants': tournament_participants,
      'matches_played': matches_played,
      'growth_rate': growth_rate,
      'retention_rate': retention_rate,
      'created_at': created_at.toIso8601String(),
    };
  }
}
