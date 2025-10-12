// GENERATED from introspect.json — do not edit by hand
class Leaderboards {
  final String id;
  final String type;
  final String? sport_id;
  final String? time_period;
  final Map<String, dynamic>? entries;
  final DateTime? last_calculated;
  final DateTime created_at;

  const Leaderboards({
    required this.id,
    required this.type,
    this.sport_id,
    this.time_period,
    this.entries,
    this.last_calculated,
    required this.created_at,
  });

  factory Leaderboards.fromJson(Map<String, dynamic> json) {
    return Leaderboards(
      id: json['id'],
      type: json['type'],
      sport_id: json['sport_id'],
      time_period: json['time_period'],
      entries: json['entries'],
      last_calculated: (json['last_calculated'] == null ? null : DateTime.parse(json['last_calculated'] as String)),
    created_at: json['created_at'] != null
      ? DateTime.parse(json['created_at'] as String)
      : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'sport_id': sport_id,
      'time_period': time_period,
      'entries': entries,
      'last_calculated': last_calculated?.toIso8601String(),
      'created_at': created_at.toIso8601String(),
    };
  }
}
