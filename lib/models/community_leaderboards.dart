// GENERATED from introspect.json — do not edit by hand
class CommunityLeaderboards {
  final String id;
  final String name;
  final String category;
  final String period;
  final String? group_id;
  final String? sport_id;
  final String? region_id;
  final String? challenge_id;
  final String? tournament_id;
  final int? skill_level_min;
  final int? skill_level_max;
  final int? age_min;
  final int? age_max;
  final DateTime period_start;
  final DateTime period_end;
  final int? min_activities;
  final String? scoring_method;
  final bool? is_active;
  final DateTime? last_calculated;
  final DateTime? next_calculation;
  final DateTime created_at;

  const CommunityLeaderboards({
    required this.id,
    required this.name,
    required this.category,
    required this.period,
    this.group_id,
    this.sport_id,
    this.region_id,
    this.challenge_id,
    this.tournament_id,
    this.skill_level_min,
    this.skill_level_max,
    this.age_min,
    this.age_max,
    required this.period_start,
    required this.period_end,
    this.min_activities,
    this.scoring_method,
    this.is_active,
    this.last_calculated,
    this.next_calculation,
    required this.created_at,
  });

  factory CommunityLeaderboards.fromJson(Map<String, dynamic> json) {
    return CommunityLeaderboards(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      period: json['period'],
      group_id: json['group_id'],
      sport_id: json['sport_id'],
      region_id: json['region_id'],
      challenge_id: json['challenge_id'],
      tournament_id: json['tournament_id'],
      skill_level_min: json['skill_level_min'],
      skill_level_max: json['skill_level_max'],
      age_min: json['age_min'],
      age_max: json['age_max'],
      period_start: json['period_start'] != null
          ? DateTime.parse(json['period_start'] as String)
          : DateTime.now(),
      period_end: json['period_end'] != null
          ? DateTime.parse(json['period_end'] as String)
          : DateTime.now(),
      min_activities: json['min_activities'],
      scoring_method: json['scoring_method'],
      is_active: json['is_active'],
      last_calculated: (json['last_calculated'] == null
          ? null
          : DateTime.parse(json['last_calculated'] as String)),
      next_calculation: (json['next_calculation'] == null
          ? null
          : DateTime.parse(json['next_calculation'] as String)),
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'period': period,
      'group_id': group_id,
      'sport_id': sport_id,
      'region_id': region_id,
      'challenge_id': challenge_id,
      'tournament_id': tournament_id,
      'skill_level_min': skill_level_min,
      'skill_level_max': skill_level_max,
      'age_min': age_min,
      'age_max': age_max,
      'period_start': period_start.toIso8601String(),
      'period_end': period_end.toIso8601String(),
      'min_activities': min_activities,
      'scoring_method': scoring_method,
      'is_active': is_active,
      'last_calculated': last_calculated?.toIso8601String(),
      'next_calculation': next_calculation?.toIso8601String(),
      'created_at': created_at.toIso8601String(),
    };
  }
}
