// GENERATED from introspect.json — do not edit by hand
class Tournaments {
  final String id;
  final String? event_id;
  final String format;
  final String? status;
  final int? rounds;
  final int? current_round;
  final int? matches_per_round;
  final int? points_for_win;
  final int? points_for_draw;
  final int? points_for_loss;
  final bool? is_seeded;
  final String? seeding_method;
  final int? match_duration_minutes;
  final int? break_duration_minutes;
  final String? rules_url;
  final Map<String, dynamic>? bracket_data;
  final int? total_matches;
  final int? completed_matches;
  final DateTime? started_at;
  final DateTime? completed_at;
  final DateTime created_at;
  final DateTime updated_at;

  const Tournaments({
    required this.id,
    this.event_id,
    required this.format,
    this.status,
    this.rounds,
    this.current_round,
    this.matches_per_round,
    this.points_for_win,
    this.points_for_draw,
    this.points_for_loss,
    this.is_seeded,
    this.seeding_method,
    this.match_duration_minutes,
    this.break_duration_minutes,
    this.rules_url,
    this.bracket_data,
    this.total_matches,
    this.completed_matches,
    this.started_at,
    this.completed_at,
    required this.created_at,
    required this.updated_at,
  });

  factory Tournaments.fromJson(Map<String, dynamic> json) {
    return Tournaments(
      id: json['id'],
      event_id: json['event_id'],
      format: json['format'],
      status: json['status'],
      rounds: json['rounds'],
      current_round: json['current_round'],
      matches_per_round: json['matches_per_round'],
      points_for_win: json['points_for_win'],
      points_for_draw: json['points_for_draw'],
      points_for_loss: json['points_for_loss'],
      is_seeded: json['is_seeded'],
      seeding_method: json['seeding_method'],
      match_duration_minutes: json['match_duration_minutes'],
      break_duration_minutes: json['break_duration_minutes'],
      rules_url: json['rules_url'],
      bracket_data: json['bracket_data'],
      total_matches: json['total_matches'],
      completed_matches: json['completed_matches'],
      started_at: (json['started_at'] == null ? null : DateTime.parse(json['started_at'] as String)),
      completed_at: (json['completed_at'] == null ? null : DateTime.parse(json['completed_at'] as String)),
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
      'event_id': event_id,
      'format': format,
      'status': status,
      'rounds': rounds,
      'current_round': current_round,
      'matches_per_round': matches_per_round,
      'points_for_win': points_for_win,
      'points_for_draw': points_for_draw,
      'points_for_loss': points_for_loss,
      'is_seeded': is_seeded,
      'seeding_method': seeding_method,
      'match_duration_minutes': match_duration_minutes,
      'break_duration_minutes': break_duration_minutes,
      'rules_url': rules_url,
      'bracket_data': bracket_data,
      'total_matches': total_matches,
      'completed_matches': completed_matches,
      'started_at': started_at?.toIso8601String(),
      'completed_at': completed_at?.toIso8601String(),
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
