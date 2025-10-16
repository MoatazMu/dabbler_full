// GENERATED from introspect.json — do not edit by hand
class GameSessions {
  final String id;
  final String game_id;
  final String? status;
  final DateTime? actual_start_time;
  final DateTime? actual_end_time;
  final int? team_a_score;
  final int? team_b_score;
  final String? weather_condition;
  final double? temperature;
  final String? notes;
  final DateTime created_at;
  final DateTime updated_at;

  const GameSessions({
    required this.id,
    required this.game_id,
    this.status,
    this.actual_start_time,
    this.actual_end_time,
    this.team_a_score,
    this.team_b_score,
    this.weather_condition,
    this.temperature,
    this.notes,
    required this.created_at,
    required this.updated_at,
  });

  factory GameSessions.fromJson(Map<String, dynamic> json) {
    return GameSessions(
      id: json['id'],
      game_id: json['game_id'],
      status: json['status'],
      actual_start_time: (json['actual_start_time'] == null
          ? null
          : DateTime.parse(json['actual_start_time'] as String)),
      actual_end_time: (json['actual_end_time'] == null
          ? null
          : DateTime.parse(json['actual_end_time'] as String)),
      team_a_score: json['team_a_score'],
      team_b_score: json['team_b_score'],
      weather_condition: json['weather_condition'],
      temperature: json['temperature'],
      notes: json['notes'],
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
      'game_id': game_id,
      'status': status,
      'actual_start_time': actual_start_time?.toIso8601String(),
      'actual_end_time': actual_end_time?.toIso8601String(),
      'team_a_score': team_a_score,
      'team_b_score': team_b_score,
      'weather_condition': weather_condition,
      'temperature': temperature,
      'notes': notes,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
