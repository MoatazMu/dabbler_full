// GENERATED from introspect.json — do not edit by hand
class RewardsConfig {
  final String id;
  final String config_key;
  final Map<String, dynamic> config_value;
  final String? description;
  final bool? is_active;
  final DateTime created_at;
  final DateTime updated_at;

  const RewardsConfig({
    required this.id,
    required this.config_key,
    required this.config_value,
    this.description,
    this.is_active,
    required this.created_at,
    required this.updated_at,
  });

  factory RewardsConfig.fromJson(Map<String, dynamic> json) {
    return RewardsConfig(
      id: json['id'],
      config_key: json['config_key'],
      config_value: json['config_value'],
      description: json['description'],
      is_active: json['is_active'],
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
      'config_key': config_key,
      'config_value': config_value,
      'description': description,
      'is_active': is_active,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
