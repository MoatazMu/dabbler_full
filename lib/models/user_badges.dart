// GENERATED from introspect.json — do not edit by hand
class UserBadges {
  final String id;
  final String user_id;
  final String badge_id;
  final String achievement_id;
  final String tier;
  final DateTime earned_at;
  final bool? is_showcased;
  final int? showcase_order;
  final int? times_earned;

  const UserBadges({
    required this.id,
    required this.user_id,
    required this.badge_id,
    required this.achievement_id,
    required this.tier,
    required this.earned_at,
    this.is_showcased,
    this.showcase_order,
    this.times_earned,
  });

  factory UserBadges.fromJson(Map<String, dynamic> json) {
    return UserBadges(
      id: json['id'],
      user_id: json['user_id'],
      badge_id: json['badge_id'],
      achievement_id: json['achievement_id'],
      tier: json['tier'],
    earned_at: json['earned_at'] != null
      ? DateTime.parse(json['earned_at'] as String)
      : DateTime.now(),
      is_showcased: json['is_showcased'],
      showcase_order: json['showcase_order'],
      times_earned: json['times_earned'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'badge_id': badge_id,
      'achievement_id': achievement_id,
      'tier': tier,
      'earned_at': earned_at.toIso8601String(),
      'is_showcased': is_showcased,
      'showcase_order': showcase_order,
      'times_earned': times_earned,
    };
  }
}
