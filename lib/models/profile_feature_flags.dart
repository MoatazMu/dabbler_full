// GENERATED from introspect.json — do not edit by hand
class ProfileFeatureFlags {
  final String id;
  final String feature_name;
  final bool? is_enabled;
  final int? rollout_percentage;
  final List<dynamic>? user_whitelist;
  final DateTime created_at;
  final DateTime updated_at;

  const ProfileFeatureFlags({
    required this.id,
    required this.feature_name,
    this.is_enabled,
    this.rollout_percentage,
    this.user_whitelist,
    required this.created_at,
    required this.updated_at,
  });

  factory ProfileFeatureFlags.fromJson(Map<String, dynamic> json) {
    return ProfileFeatureFlags(
      id: json['id'],
      feature_name: json['feature_name'],
      is_enabled: json['is_enabled'],
      rollout_percentage: json['rollout_percentage'],
      user_whitelist: json['user_whitelist'],
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
      'feature_name': feature_name,
      'is_enabled': is_enabled,
      'rollout_percentage': rollout_percentage,
      'user_whitelist': user_whitelist,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
