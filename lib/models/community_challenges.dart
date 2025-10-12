// GENERATED from introspect.json — do not edit by hand
class CommunityChallenges {
  final String id;
  final String? group_id;
  final String? created_by;
  final String title;
  final String? description;
  final String type;
  final String? status;
  final DateTime start_date;
  final DateTime end_date;
  final String metric_type;
  final double target_value;
  final String? unit;
  final int? min_participants;
  final int? max_participants;
  final int? current_participants;
  final String? sport_id;
  final int? skill_level_min;
  final int? skill_level_max;
  final String? region_id;
  final bool? has_rewards;
  final int? reward_points;
  final List<dynamic>? reward_badges;
  final Map<String, dynamic>? custom_rewards;
  final String? rules;
  final String? verification_method;
  final bool? allow_team_participation;
  final int? team_size_min;
  final int? team_size_max;
  final String? banner_image_url;
  final String? icon_url;
  final double? total_progress;
  final double? completion_rate;
  final DateTime created_at;
  final DateTime updated_at;

  const CommunityChallenges({
    required this.id,
    this.group_id,
    this.created_by,
    required this.title,
    this.description,
    required this.type,
    this.status,
    required this.start_date,
    required this.end_date,
    required this.metric_type,
    required this.target_value,
    this.unit,
    this.min_participants,
    this.max_participants,
    this.current_participants,
    this.sport_id,
    this.skill_level_min,
    this.skill_level_max,
    this.region_id,
    this.has_rewards,
    this.reward_points,
    this.reward_badges,
    this.custom_rewards,
    this.rules,
    this.verification_method,
    this.allow_team_participation,
    this.team_size_min,
    this.team_size_max,
    this.banner_image_url,
    this.icon_url,
    this.total_progress,
    this.completion_rate,
    required this.created_at,
    required this.updated_at,
  });

  factory CommunityChallenges.fromJson(Map<String, dynamic> json) {
    return CommunityChallenges(
      id: json['id'],
      group_id: json['group_id'],
      created_by: json['created_by'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      status: json['status'],
    start_date: json['start_date'] != null
      ? DateTime.parse(json['start_date'] as String)
      : DateTime.now(),
    end_date: json['end_date'] != null
      ? DateTime.parse(json['end_date'] as String)
      : DateTime.now(),
      metric_type: json['metric_type'],
      target_value: json['target_value'],
      unit: json['unit'],
      min_participants: json['min_participants'],
      max_participants: json['max_participants'],
      current_participants: json['current_participants'],
      sport_id: json['sport_id'],
      skill_level_min: json['skill_level_min'],
      skill_level_max: json['skill_level_max'],
      region_id: json['region_id'],
      has_rewards: json['has_rewards'],
      reward_points: json['reward_points'],
      reward_badges: json['reward_badges'],
      custom_rewards: json['custom_rewards'],
      rules: json['rules'],
      verification_method: json['verification_method'],
      allow_team_participation: json['allow_team_participation'],
      team_size_min: json['team_size_min'],
      team_size_max: json['team_size_max'],
      banner_image_url: json['banner_image_url'],
      icon_url: json['icon_url'],
      total_progress: json['total_progress'],
      completion_rate: json['completion_rate'],
    created_at: json['created_at'] != null
      ? DateTime.parse(json['created_at'] as String)
      : DateTime.now(),
    updated_at: json['updated_at'] != null
      ? DateTime.parse(json['updated_at'] as String)
      : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': group_id,
      'created_by': created_by,
      'title': title,
      'description': description,
      'type': type,
      'status': status,
      'start_date': start_date.toIso8601String(),
      'end_date': end_date.toIso8601String(),
      'metric_type': metric_type,
      'target_value': target_value,
      'unit': unit,
      'min_participants': min_participants,
      'max_participants': max_participants,
      'current_participants': current_participants,
      'sport_id': sport_id,
      'skill_level_min': skill_level_min,
      'skill_level_max': skill_level_max,
      'region_id': region_id,
      'has_rewards': has_rewards,
      'reward_points': reward_points,
      'reward_badges': reward_badges,
      'custom_rewards': custom_rewards,
      'rules': rules,
      'verification_method': verification_method,
      'allow_team_participation': allow_team_participation,
      'team_size_min': team_size_min,
      'team_size_max': team_size_max,
      'banner_image_url': banner_image_url,
      'icon_url': icon_url,
      'total_progress': total_progress,
      'completion_rate': completion_rate,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
