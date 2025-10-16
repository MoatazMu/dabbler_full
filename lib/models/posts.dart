// GENERATED from introspect.json — do not edit by hand
class Posts {
  final String id;
  final String author_id;
  final String type;
  final String? content;
  final List<dynamic>? media_urls;
  final String? game_id;
  final String? sport_id;
  final String? achievement_type;
  final String? visibility;
  final int? likes_count;
  final int? comments_count;
  final int? shares_count;
  final bool? is_deleted;
  final DateTime? deleted_at;
  final DateTime created_at;
  final DateTime updated_at;
  final String? location_name;
  final String? tags;

  const Posts({
    required this.id,
    required this.author_id,
    required this.type,
    this.content,
    this.media_urls,
    this.game_id,
    this.sport_id,
    this.achievement_type,
    this.visibility,
    this.likes_count,
    this.comments_count,
    this.shares_count,
    this.is_deleted,
    this.deleted_at,
    required this.created_at,
    required this.updated_at,
    this.location_name,
    this.tags,
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      id: json['id'],
      author_id: json['author_id'],
      type: json['type'],
      content: json['content'],
      media_urls: json['media_urls'],
      game_id: json['game_id'],
      sport_id: json['sport_id'],
      achievement_type: json['achievement_type'],
      visibility: json['visibility'],
      likes_count: json['likes_count'],
      comments_count: json['comments_count'],
      shares_count: json['shares_count'],
      is_deleted: json['is_deleted'],
      deleted_at: (json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String)),
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      updated_at: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : DateTime.now(),
      location_name: json['location_name'],
      tags: json['tags'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author_id': author_id,
      'type': type,
      'content': content,
      'media_urls': media_urls,
      'game_id': game_id,
      'sport_id': sport_id,
      'achievement_type': achievement_type,
      'visibility': visibility,
      'likes_count': likes_count,
      'comments_count': comments_count,
      'shares_count': shares_count,
      'is_deleted': is_deleted,
      'deleted_at': deleted_at?.toIso8601String(),
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
      'location_name': location_name,
      'tags': tags,
    };
  }
}
