// GENERATED from introspect.json — do not edit by hand
class BadgeShowcaseSettings {
  final String id;
  final String user_id;
  final int? max_showcase_badges;
  final String? showcase_style;
  final bool? show_rarity;
  final bool? show_earn_date;
  final DateTime created_at;
  final DateTime updated_at;

  const BadgeShowcaseSettings({
    required this.id,
    required this.user_id,
    this.max_showcase_badges,
    this.showcase_style,
    this.show_rarity,
    this.show_earn_date,
    required this.created_at,
    required this.updated_at,
  });

  factory BadgeShowcaseSettings.fromJson(Map<String, dynamic> json) {
    return BadgeShowcaseSettings(
      id: json['id'],
      user_id: json['user_id'],
      max_showcase_badges: json['max_showcase_badges'],
      showcase_style: json['showcase_style'],
      show_rarity: json['show_rarity'],
      show_earn_date: json['show_earn_date'],
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
      'user_id': user_id,
      'max_showcase_badges': max_showcase_badges,
      'showcase_style': showcase_style,
      'show_rarity': show_rarity,
      'show_earn_date': show_earn_date,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
