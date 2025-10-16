// GENERATED from introspect.json — do not edit by hand
class Achievements {
  final String id;
  final String code;
  final String name;
  final String description;
  final String? icon_url;
  final String category;
  final String type;
  final String? tier;
  final int points;
  final Map<String, dynamic> criteria;
  final List<dynamic>? prerequisite_achievement_ids;
  final bool? is_active;
  final bool? is_hidden;
  final bool? is_repeatable;
  final int? max_repeats;
  final DateTime? available_from;
  final DateTime? available_until;
  final int? display_order;
  final DateTime created_at;
  final DateTime updated_at;

  const Achievements({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    this.icon_url,
    required this.category,
    required this.type,
    this.tier,
    required this.points,
    required this.criteria,
    this.prerequisite_achievement_ids,
    this.is_active,
    this.is_hidden,
    this.is_repeatable,
    this.max_repeats,
    this.available_from,
    this.available_until,
    this.display_order,
    required this.created_at,
    required this.updated_at,
  });

  factory Achievements.fromJson(Map<String, dynamic> json) {
    return Achievements(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      description: json['description'],
      icon_url: json['icon_url'],
      category: json['category'],
      type: json['type'],
      tier: json['tier'],
      points: json['points'],
      criteria: json['criteria'],
      prerequisite_achievement_ids: json['prerequisite_achievement_ids'],
      is_active: json['is_active'],
      is_hidden: json['is_hidden'],
      is_repeatable: json['is_repeatable'],
      max_repeats: json['max_repeats'],
      available_from: (json['available_from'] == null
          ? null
          : DateTime.parse(json['available_from'] as String)),
      available_until: (json['available_until'] == null
          ? null
          : DateTime.parse(json['available_until'] as String)),
      display_order: json['display_order'],
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
      'code': code,
      'name': name,
      'description': description,
      'icon_url': icon_url,
      'category': category,
      'type': type,
      'tier': tier,
      'points': points,
      'criteria': criteria,
      'prerequisite_achievement_ids': prerequisite_achievement_ids,
      'is_active': is_active,
      'is_hidden': is_hidden,
      'is_repeatable': is_repeatable,
      'max_repeats': max_repeats,
      'available_from': available_from?.toIso8601String(),
      'available_until': available_until?.toIso8601String(),
      'display_order': display_order,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
