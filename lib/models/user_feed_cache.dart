// GENERATED from introspect.json — do not edit by hand
class UserFeedCache {
  final String id;
  final String user_id;
  final String post_id;
  final double relevance_score;
  final DateTime cached_at;

  const UserFeedCache({
    required this.id,
    required this.user_id,
    required this.post_id,
    required this.relevance_score,
    required this.cached_at,
  });

  factory UserFeedCache.fromJson(Map<String, dynamic> json) {
    return UserFeedCache(
      id: json['id'],
      user_id: json['user_id'],
      post_id: json['post_id'],
      relevance_score: json['relevance_score'],
    cached_at: json['cached_at'] != null
      ? DateTime.parse(json['cached_at'] as String)
      : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'post_id': post_id,
      'relevance_score': relevance_score,
      'cached_at': cached_at.toIso8601String(),
    };
  }
}
