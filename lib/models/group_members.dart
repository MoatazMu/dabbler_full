// GENERATED from introspect.json — do not edit by hand
class GroupMembers {
  final String id;
  final String group_id;
  final String user_id;
  final String? role;
  final String? status;
  final bool? can_create_events;
  final bool? can_invite_members;
  final bool? can_moderate_content;
  final int? contribution_score;
  final DateTime? last_active;
  final DateTime joined_at;
  final DateTime? left_at;

  const GroupMembers({
    required this.id,
    required this.group_id,
    required this.user_id,
    this.role,
    this.status,
    this.can_create_events,
    this.can_invite_members,
    this.can_moderate_content,
    this.contribution_score,
    this.last_active,
    required this.joined_at,
    this.left_at,
  });

  factory GroupMembers.fromJson(Map<String, dynamic> json) {
    return GroupMembers(
      id: json['id'],
      group_id: json['group_id'],
      user_id: json['user_id'],
      role: json['role'],
      status: json['status'],
      can_create_events: json['can_create_events'],
      can_invite_members: json['can_invite_members'],
      can_moderate_content: json['can_moderate_content'],
      contribution_score: json['contribution_score'],
      last_active: (json['last_active'] == null ? null : DateTime.parse(json['last_active'] as String)),
      joined_at: json['joined_at'] != null
          ? DateTime.parse(json['joined_at'] as String)
          : DateTime.now(),
      left_at: (json['left_at'] == null ? null : DateTime.parse(json['left_at'] as String)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': group_id,
      'user_id': user_id,
      'role': role,
      'status': status,
      'can_create_events': can_create_events,
      'can_invite_members': can_invite_members,
      'can_moderate_content': can_moderate_content,
      'contribution_score': contribution_score,
      'last_active': last_active?.toIso8601String(),
      'joined_at': joined_at.toIso8601String(),
      'left_at': left_at?.toIso8601String(),
    };
  }
}
