// GENERATED from introspect.json — do not edit by hand
class PointsMultipliers {
  final String id;
  final String code;
  final String name;
  final String? description;
  final double multiplier;
  final Map<String, dynamic> conditions;
  final bool? is_active;
  final DateTime? valid_from;
  final DateTime? valid_until;
  final DateTime created_at;

  const PointsMultipliers({
    required this.id,
    required this.code,
    required this.name,
    this.description,
    required this.multiplier,
    required this.conditions,
    this.is_active,
    this.valid_from,
    this.valid_until,
    required this.created_at,
  });

  factory PointsMultipliers.fromJson(Map<String, dynamic> json) {
    return PointsMultipliers(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      description: json['description'],
      multiplier: json['multiplier'],
      conditions: json['conditions'],
      is_active: json['is_active'],
      valid_from: (json['valid_from'] == null
          ? null
          : DateTime.parse(json['valid_from'] as String)),
      valid_until: (json['valid_until'] == null
          ? null
          : DateTime.parse(json['valid_until'] as String)),
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'description': description,
      'multiplier': multiplier,
      'conditions': conditions,
      'is_active': is_active,
      'valid_from': valid_from?.toIso8601String(),
      'valid_until': valid_until?.toIso8601String(),
      'created_at': created_at.toIso8601String(),
    };
  }
}
