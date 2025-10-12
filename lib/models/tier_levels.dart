// GENERATED from introspect.json — do not edit by hand
class TierLevels {
  final String id;
  final int level;
  final String name;
  final String? description;
  final String? icon_url;
  final String? color_hex;
  final int min_points;
  final int max_points;
  final Map<String, dynamic>? benefits;
  final Map<String, dynamic>? privileges;
  final DateTime created_at;

  const TierLevels({
    required this.id,
    required this.level,
    required this.name,
    this.description,
    this.icon_url,
    this.color_hex,
    required this.min_points,
    required this.max_points,
    this.benefits,
    this.privileges,
    required this.created_at,
  });

  factory TierLevels.fromJson(Map<String, dynamic> json) {
    return TierLevels(
      id: json['id'],
      level: json['level'],
      name: json['name'],
      description: json['description'],
      icon_url: json['icon_url'],
      color_hex: json['color_hex'],
      min_points: json['min_points'],
      max_points: json['max_points'],
      benefits: json['benefits'],
      privileges: json['privileges'],
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'level': level,
      'name': name,
      'description': description,
      'icon_url': icon_url,
      'color_hex': color_hex,
      'min_points': min_points,
      'max_points': max_points,
      'benefits': benefits,
      'privileges': privileges,
      'created_at': created_at.toIso8601String(),
    };
  }
}
