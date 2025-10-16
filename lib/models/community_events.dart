// GENERATED from introspect.json — do not edit by hand
class CommunityEvents {
  final String id;
  final String? group_id;
  final String organizer_id;
  final String? sport_id;
  final String? venue_id;
  final String title;
  final String? description;
  final String type;
  final String? status;
  final DateTime start_date;
  final DateTime end_date;
  final DateTime? registration_deadline;
  final int? min_participants;
  final int? max_participants;
  final int? current_participants;
  final int? skill_level_min;
  final int? skill_level_max;
  final int? age_min;
  final int? age_max;
  final String? gender_restriction;
  final bool? is_free;
  final double? entry_fee;
  final String? currency;
  final bool? has_prizes;
  final Map<String, dynamic>? prizes;
  final String? rules;
  final List<dynamic>? equipment_required;
  final String? cover_image_url;
  final List<dynamic>? gallery_urls;
  final bool? is_public;
  final bool? requires_approval;
  final bool? allow_waitlist;
  final int? view_count;
  final int? share_count;
  final DateTime created_at;
  final DateTime updated_at;

  const CommunityEvents({
    required this.id,
    this.group_id,
    required this.organizer_id,
    this.sport_id,
    this.venue_id,
    required this.title,
    this.description,
    required this.type,
    this.status,
    required this.start_date,
    required this.end_date,
    this.registration_deadline,
    this.min_participants,
    this.max_participants,
    this.current_participants,
    this.skill_level_min,
    this.skill_level_max,
    this.age_min,
    this.age_max,
    this.gender_restriction,
    this.is_free,
    this.entry_fee,
    this.currency,
    this.has_prizes,
    this.prizes,
    this.rules,
    this.equipment_required,
    this.cover_image_url,
    this.gallery_urls,
    this.is_public,
    this.requires_approval,
    this.allow_waitlist,
    this.view_count,
    this.share_count,
    required this.created_at,
    required this.updated_at,
  });

  factory CommunityEvents.fromJson(Map<String, dynamic> json) {
    return CommunityEvents(
      id: json['id'],
      group_id: json['group_id'],
      organizer_id: json['organizer_id'],
      sport_id: json['sport_id'],
      venue_id: json['venue_id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      status: json['status'],
      start_date: json['start_date'] != null
          ? DateTime.parse(json['start_date'] as String)
          : DateTime.now(),
      end_date: json['end_date'] != null
          ? DateTime.parse(json['end_date'] as String)
          : DateTime.now(),
      registration_deadline: (json['registration_deadline'] == null
          ? null
          : DateTime.parse(json['registration_deadline'] as String)),
      min_participants: json['min_participants'],
      max_participants: json['max_participants'],
      current_participants: json['current_participants'],
      skill_level_min: json['skill_level_min'],
      skill_level_max: json['skill_level_max'],
      age_min: json['age_min'],
      age_max: json['age_max'],
      gender_restriction: json['gender_restriction'],
      is_free: json['is_free'],
      entry_fee: json['entry_fee'],
      currency: json['currency'],
      has_prizes: json['has_prizes'],
      prizes: json['prizes'],
      rules: json['rules'],
      equipment_required: json['equipment_required'],
      cover_image_url: json['cover_image_url'],
      gallery_urls: json['gallery_urls'],
      is_public: json['is_public'],
      requires_approval: json['requires_approval'],
      allow_waitlist: json['allow_waitlist'],
      view_count: json['view_count'],
      share_count: json['share_count'],
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
      'group_id': group_id,
      'organizer_id': organizer_id,
      'sport_id': sport_id,
      'venue_id': venue_id,
      'title': title,
      'description': description,
      'type': type,
      'status': status,
      'start_date': start_date.toIso8601String(),
      'end_date': end_date.toIso8601String(),
      'registration_deadline': registration_deadline?.toIso8601String(),
      'min_participants': min_participants,
      'max_participants': max_participants,
      'current_participants': current_participants,
      'skill_level_min': skill_level_min,
      'skill_level_max': skill_level_max,
      'age_min': age_min,
      'age_max': age_max,
      'gender_restriction': gender_restriction,
      'is_free': is_free,
      'entry_fee': entry_fee,
      'currency': currency,
      'has_prizes': has_prizes,
      'prizes': prizes,
      'rules': rules,
      'equipment_required': equipment_required,
      'cover_image_url': cover_image_url,
      'gallery_urls': gallery_urls,
      'is_public': is_public,
      'requires_approval': requires_approval,
      'allow_waitlist': allow_waitlist,
      'view_count': view_count,
      'share_count': share_count,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }
}
