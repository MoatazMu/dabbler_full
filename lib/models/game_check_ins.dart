// GENERATED from introspect.json — do not edit by hand
class GameCheckIns {
  final String id;
  final String game_id;
  final String player_id;
  final DateTime check_in_time;
  final String? check_in_method;
  final double? location_latitude;
  final double? location_longitude;
  final String? device_id;

  const GameCheckIns({
    required this.id,
    required this.game_id,
    required this.player_id,
    required this.check_in_time,
    this.check_in_method,
    this.location_latitude,
    this.location_longitude,
    this.device_id,
  });

  factory GameCheckIns.fromJson(Map<String, dynamic> json) {
    return GameCheckIns(
      id: json['id'],
      game_id: json['game_id'],
      player_id: json['player_id'],
      check_in_time: json['check_in_time'] != null
          ? DateTime.parse(json['check_in_time'] as String)
          : DateTime.now(),
      check_in_method: json['check_in_method'],
      location_latitude: json['location_latitude'],
      location_longitude: json['location_longitude'],
      device_id: json['device_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'game_id': game_id,
      'player_id': player_id,
      'check_in_time': check_in_time.toIso8601String(),
      'check_in_method': check_in_method,
      'location_latitude': location_latitude,
      'location_longitude': location_longitude,
      'device_id': device_id,
    };
  }
}
