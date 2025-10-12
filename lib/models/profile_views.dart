// GENERATED from introspect.json — do not edit by hand
class ProfileViews {
  final String id;
  final String profile_id;
  final String? viewer_id;
  final DateTime viewed_at;
  final String? source;
  final int? duration_seconds;

  const ProfileViews({
    required this.id,
    required this.profile_id,
    this.viewer_id,
    required this.viewed_at,
    this.source,
    this.duration_seconds,
  });

  factory ProfileViews.fromJson(Map<String, dynamic> json) {
    return ProfileViews(
      id: json['id'],
      profile_id: json['profile_id'],
      viewer_id: json['viewer_id'],
      viewed_at: json['viewed_at'] != null
          ? DateTime.parse(json['viewed_at'] as String)
          : DateTime.now(),
      source: json['source'],
      duration_seconds: json['duration_seconds'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile_id': profile_id,
      'viewer_id': viewer_id,
      'viewed_at': viewed_at.toIso8601String(),
      'source': source,
      'duration_seconds': duration_seconds,
    };
  }
}
