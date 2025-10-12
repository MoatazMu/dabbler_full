// GENERATED from introspect.json — do not edit by hand
class Regions {
  final String id;
  final String name;
  final String? code;
  final String? country_code;
  final String? parent_id;
  final DateTime created_at;
  final DateTime updated_at;

  const Regions({
    required this.id,
    required this.name,
    this.code,
    this.country_code,
    this.parent_id,
    required this.created_at,
    required this.updated_at,
  });

  factory Regions.fromJson(Map<String, dynamic> json) {
    return Regions(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      country_code: json['country_code'],
      parent_id: json['parent_id'],
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
      'name': name,
      'code': code,
      'country_code': country_code,
      'parent_id': parent_id,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
