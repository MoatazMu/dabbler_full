// GENERATED from introspect.json — do not edit by hand
class CommunityGroups {
  final String id;
  final String name;
  final String? description;
  final String? type;
  final String? status;
  final String? sport_id;
  final String? region_id;
  final String? created_by;
  final int? max_members;
  final int? min_age;
  final int? max_age;
  final int? skill_level_min;
  final int? skill_level_max;
  final bool? is_verified;
  final bool? requires_approval;
  final bool? is_visible;
  final bool? allow_guest_view;
  final String? avatar_url;
  final String? cover_image_url;
  final int? member_count;
  final int? event_count;
  final int? activity_score;
  final DateTime created_at;
  final DateTime updated_at;

  const CommunityGroups({
    required this.id,
    required this.name,
    this.description,
    this.type,
    this.status,
    this.sport_id,
    this.region_id,
    this.created_by,
    this.max_members,
    this.min_age,
    this.max_age,
    this.skill_level_min,
    this.skill_level_max,
    this.is_verified,
    this.requires_approval,
    this.is_visible,
    this.allow_guest_view,
    this.avatar_url,
    this.cover_image_url,
    this.member_count,
    this.event_count,
    this.activity_score,
    required this.created_at,
    required this.updated_at,
  });

  factory CommunityGroups.fromJson(Map<String, dynamic> json) {
    return CommunityGroups(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      status: json['status'],
      sport_id: json['sport_id'],
      region_id: json['region_id'],
      created_by: json['created_by'],
      max_members: json['max_members'],
      min_age: json['min_age'],
      max_age: json['max_age'],
      skill_level_min: json['skill_level_min'],
      skill_level_max: json['skill_level_max'],
      is_verified: json['is_verified'],
      requires_approval: json['requires_approval'],
      is_visible: json['is_visible'],
      allow_guest_view: json['allow_guest_view'],
      avatar_url: json['avatar_url'],
      cover_image_url: json['cover_image_url'],
      member_count: json['member_count'],
      event_count: json['event_count'],
      activity_score: json['activity_score'],
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
      'description': description,
      'type': type,
      'status': status,
      'sport_id': sport_id,
      'region_id': region_id,
      'created_by': created_by,
      'max_members': max_members,
      'min_age': min_age,
      'max_age': max_age,
      'skill_level_min': skill_level_min,
      'skill_level_max': skill_level_max,
      'is_verified': is_verified,
      'requires_approval': requires_approval,
      'is_visible': is_visible,
      'allow_guest_view': allow_guest_view,
      'avatar_url': avatar_url,
      'cover_image_url': cover_image_url,
      'member_count': member_count,
      'event_count': event_count,
      'activity_score': activity_score,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
