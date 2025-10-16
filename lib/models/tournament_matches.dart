// GENERATED from introspect.json — do not edit by hand
class TournamentMatches {
  final String id;
  final String tournament_id;
  final int round_number;
  final int match_number;
  final String? participant1_id;
  final String? participant2_id;
  final DateTime? scheduled_time;
  final DateTime? actual_start_time;
  final DateTime? actual_end_time;
  final String? status;
  final int? participant1_score;
  final int? participant2_score;
  final String? winner_id;
  final String? venue_court;
  final String? referee_id;
  final String? notes;
  final String? next_match_id;
  final int? next_match_position;
  final DateTime created_at;
  final DateTime updated_at;

  const TournamentMatches({
    required this.id,
    required this.tournament_id,
    required this.round_number,
    required this.match_number,
    this.participant1_id,
    this.participant2_id,
    this.scheduled_time,
    this.actual_start_time,
    this.actual_end_time,
    this.status,
    this.participant1_score,
    this.participant2_score,
    this.winner_id,
    this.venue_court,
    this.referee_id,
    this.notes,
    this.next_match_id,
    this.next_match_position,
    required this.created_at,
    required this.updated_at,
  });

  factory TournamentMatches.fromJson(Map<String, dynamic> json) {
    return TournamentMatches(
      id: json['id'],
      tournament_id: json['tournament_id'],
      round_number: json['round_number'],
      match_number: json['match_number'],
      participant1_id: json['participant1_id'],
      participant2_id: json['participant2_id'],
      scheduled_time: (json['scheduled_time'] == null
          ? null
          : DateTime.parse(json['scheduled_time'] as String)),
      actual_start_time: (json['actual_start_time'] == null
          ? null
          : DateTime.parse(json['actual_start_time'] as String)),
      actual_end_time: (json['actual_end_time'] == null
          ? null
          : DateTime.parse(json['actual_end_time'] as String)),
      status: json['status'],
      participant1_score: json['participant1_score'],
      participant2_score: json['participant2_score'],
      winner_id: json['winner_id'],
      venue_court: json['venue_court'],
      referee_id: json['referee_id'],
      notes: json['notes'],
      next_match_id: json['next_match_id'],
      next_match_position: json['next_match_position'],
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
      'tournament_id': tournament_id,
      'round_number': round_number,
      'match_number': match_number,
      'participant1_id': participant1_id,
      'participant2_id': participant2_id,
      'scheduled_time': scheduled_time?.toIso8601String(),
      'actual_start_time': actual_start_time?.toIso8601String(),
      'actual_end_time': actual_end_time?.toIso8601String(),
      'status': status,
      'participant1_score': participant1_score,
      'participant2_score': participant2_score,
      'winner_id': winner_id,
      'venue_court': venue_court,
      'referee_id': referee_id,
      'notes': notes,
      'next_match_id': next_match_id,
      'next_match_position': next_match_position,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
