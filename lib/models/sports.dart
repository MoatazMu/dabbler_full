// GENERATED from introspect.json — do not edit by hand
class Sports {
  final String id;
  final String name;
  final String code;
  final String? icon_url;
  final int min_players;
  final int max_players;
  final int? default_duration;
  final bool? requires_venue;
  final bool? is_team_sport;
  final bool? is_active;
  final DateTime created_at;
  final String? icon_name;
  final String? category;
  final int? player_count_min;
  final int? player_count_max;

  const Sports({
    required this.id,
    required this.name,
    required this.code,
    this.icon_url,
    required this.min_players,
    required this.max_players,
    this.default_duration,
    this.requires_venue,
    this.is_team_sport,
    this.is_active,
    required this.created_at,
    this.icon_name,
    this.category,
    this.player_count_min,
    this.player_count_max,
  });

  factory Sports.fromJson(Map<String, dynamic> json) {
    return Sports(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      icon_url: json['icon_url'],
      min_players: json['min_players'],
      max_players: json['max_players'],
      default_duration: json['default_duration'],
      requires_venue: json['requires_venue'],
      is_team_sport: json['is_team_sport'],
      is_active: json['is_active'],
    created_at: json['created_at'] != null
      ? DateTime.parse(json['created_at'] as String)
      : DateTime.now(),
      icon_name: json['icon_name'],
      category: json['category'],
      player_count_min: json['player_count_min'],
      player_count_max: json['player_count_max'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'icon_url': icon_url,
      'min_players': min_players,
      'max_players': max_players,
      'default_duration': default_duration,
      'requires_venue': requires_venue,
      'is_team_sport': is_team_sport,
      'is_active': is_active,
      'created_at': created_at.toIso8601String(),
      'icon_name': icon_name,
      'category': category,
      'player_count_min': player_count_min,
      'player_count_max': player_count_max,
    };
  }
}
