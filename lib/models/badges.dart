// GENERATED from introspect.json — do not edit by hand
class Badges {
  final String id;
  final String achievement_id;
  final String tier;
  final String name;
  final String? description;
  final String icon_url;
  final Map<String, dynamic>? design_metadata;
  final String? unlock_message;
  final int? rarity_score;
  final DateTime created_at;

  const Badges({
    required this.id,
    required this.achievement_id,
    required this.tier,
    required this.name,
    this.description,
    required this.icon_url,
    this.design_metadata,
    this.unlock_message,
    this.rarity_score,
    required this.created_at,
  });

  factory Badges.fromJson(Map<String, dynamic> json) {
    return Badges(
      id: json['id'],
      achievement_id: json['achievement_id'],
      tier: json['tier'],
      name: json['name'],
      description: json['description'],
      icon_url: json['icon_url'],
      design_metadata: json['design_metadata'],
      unlock_message: json['unlock_message'],
      rarity_score: json['rarity_score'],
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'achievement_id': achievement_id,
      'tier': tier,
      'name': name,
      'description': description,
      'icon_url': icon_url,
      'design_metadata': design_metadata,
      'unlock_message': unlock_message,
      'rarity_score': rarity_score,
      'created_at': created_at.toIso8601String(),
    };
  }
}
