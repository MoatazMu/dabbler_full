// GENERATED from introspect.json — do not edit by hand
class GamePlayers {
  final String id;
  final String game_id;
  final String player_id;
  final String? status;
  final String? team;
  final String? position;
  final DateTime joined_at;
  final DateTime? checked_in_at;
  final String? check_in_code;
  final int? player_rating;
  final DateTime? rated_at;

  const GamePlayers({
    required this.id,
    required this.game_id,
    required this.player_id,
    this.status,
    this.team,
    this.position,
    required this.joined_at,
    this.checked_in_at,
    this.check_in_code,
    this.player_rating,
    this.rated_at,
  });

  factory GamePlayers.fromJson(Map<String, dynamic> json) {
    return GamePlayers(
      id: json['id'],
      game_id: json['game_id'],
      player_id: json['player_id'],
      status: json['status'],
      team: json['team'],
      position: json['position'],
      joined_at: json['joined_at'] != null
          ? DateTime.parse(json['joined_at'] as String)
          : DateTime.now(),
      checked_in_at: (json['checked_in_at'] == null
          ? null
          : DateTime.parse(json['checked_in_at'] as String)),
      check_in_code: json['check_in_code'],
      player_rating: json['player_rating'],
      rated_at: (json['rated_at'] == null
          ? null
          : DateTime.parse(json['rated_at'] as String)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'game_id': game_id,
      'player_id': player_id,
      'status': status,
      'team': team,
      'position': position,
      'joined_at': joined_at.toIso8601String(),
      'checked_in_at': checked_in_at?.toIso8601String(),
      'check_in_code': check_in_code,
      'player_rating': player_rating,
      'rated_at': rated_at?.toIso8601String(),
    };
  }
}
