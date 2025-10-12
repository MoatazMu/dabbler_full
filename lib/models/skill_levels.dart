// GENERATED from introspect.json — do not edit by hand
class SkillLevels {
  final String id;
  final String name;
  final String code;
  final int level;
  final String? description;

  const SkillLevels({
    required this.id,
    required this.name,
    required this.code,
    required this.level,
    this.description,
  });

  factory SkillLevels.fromJson(Map<String, dynamic> json) {
    return SkillLevels(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      level: json['level'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'level': level,
      'description': description,
    };
  }
}
