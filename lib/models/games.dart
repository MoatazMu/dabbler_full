// GENERATED from introspect.json — do not edit by hand
class Games {
  final String id;
  final String title;
  final String? description;
  final String sport_id;
  final String? venue_id;
  final String organizer_id;
  final DateTime scheduled_date;
  final String start_time;
  final String end_time;
  final int min_players;
  final int max_players;
  final int? current_players;
  final String? skill_level_id;
  final double? price_per_player;
  final String? currency;
  final String? status;
  final bool? is_public;
  final bool? allows_waitlist;
  final bool? check_in_enabled;
  final DateTime? cancellation_deadline;
  final DateTime created_at;
  final DateTime updated_at;
  final String? sport;
  final String? skill_level;

  const Games({
    required this.id,
    required this.title,
    this.description,
    required this.sport_id,
    this.venue_id,
    required this.organizer_id,
    required this.scheduled_date,
    required this.start_time,
    required this.end_time,
    required this.min_players,
    required this.max_players,
    this.current_players,
    this.skill_level_id,
    this.price_per_player,
    this.currency,
    this.status,
    this.is_public,
    this.allows_waitlist,
    this.check_in_enabled,
    this.cancellation_deadline,
    required this.created_at,
    required this.updated_at,
    this.sport,
    this.skill_level,
  });

  factory Games.fromJson(Map<String, dynamic> json) {
    return Games(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      sport_id: json['sport_id'],
      venue_id: json['venue_id'],
      organizer_id: json['organizer_id'],
      scheduled_date: json['scheduled_date'] != null
          ? DateTime.parse(json['scheduled_date'] as String)
          : DateTime.now(),
      start_time: json['start_time'],
      end_time: json['end_time'],
      min_players: json['min_players'],
      max_players: json['max_players'],
      current_players: json['current_players'],
      skill_level_id: json['skill_level_id'],
      price_per_player: json['price_per_player'],
      currency: json['currency'],
      status: json['status'],
      is_public: json['is_public'],
      allows_waitlist: json['allows_waitlist'],
      check_in_enabled: json['check_in_enabled'],
      cancellation_deadline: (json['cancellation_deadline'] == null
          ? null
          : DateTime.parse(json['cancellation_deadline'] as String)),
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      updated_at: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : DateTime.now(),
      sport: json['sport'],
      skill_level: json['skill_level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'sport_id': sport_id,
      'venue_id': venue_id,
      'organizer_id': organizer_id,
      'scheduled_date': scheduled_date.toIso8601String(),
      'start_time': start_time,
      'end_time': end_time,
      'min_players': min_players,
      'max_players': max_players,
      'current_players': current_players,
      'skill_level_id': skill_level_id,
      'price_per_player': price_per_player,
      'currency': currency,
      'status': status,
      'is_public': is_public,
      'allows_waitlist': allows_waitlist,
      'check_in_enabled': check_in_enabled,
      'cancellation_deadline': cancellation_deadline?.toIso8601String(),
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
      'sport': sport,
      'skill_level': skill_level,
    };
  }
}
