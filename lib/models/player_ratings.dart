// GENERATED from introspect.json — do not edit by hand
class PlayerRatings {
  final String id;
  final String game_id;
  final String? rater_id;
  final String? rated_player_id;
  final int? skill_rating;
  final int? sportsmanship_rating;
  final int? punctuality_rating;
  final int? overall_rating;
  final String? comment;
  final DateTime created_at;

  const PlayerRatings({
    required this.id,
    required this.game_id,
    this.rater_id,
    this.rated_player_id,
    this.skill_rating,
    this.sportsmanship_rating,
    this.punctuality_rating,
    this.overall_rating,
    this.comment,
    required this.created_at,
  });

  factory PlayerRatings.fromJson(Map<String, dynamic> json) {
    return PlayerRatings(
      id: json['id'],
      game_id: json['game_id'],
      rater_id: json['rater_id'],
      rated_player_id: json['rated_player_id'],
      skill_rating: json['skill_rating'],
      sportsmanship_rating: json['sportsmanship_rating'],
      punctuality_rating: json['punctuality_rating'],
      overall_rating: json['overall_rating'],
      comment: json['comment'],
    created_at: json['created_at'] != null
      ? DateTime.parse(json['created_at'] as String)
      : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'game_id': game_id,
      'rater_id': rater_id,
      'rated_player_id': rated_player_id,
      'skill_rating': skill_rating,
      'sportsmanship_rating': sportsmanship_rating,
      'punctuality_rating': punctuality_rating,
      'overall_rating': overall_rating,
      'comment': comment,
      'created_at': created_at.toIso8601String(),
    };
  }
}
