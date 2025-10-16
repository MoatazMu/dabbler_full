// GENERATED from introspect.json — do not edit by hand
class ProfilesBackup {
  final String? id;
  final String? email;
  final String? username;
  final String? full_name;
  final String? avatar_url;
  final String? phone_number;
  final DateTime? date_of_birth;
  final String? bio;
  final bool? is_profile_complete;
  final bool? is_email_verified;
  final bool? is_phone_verified;
  final DateTime? created_at;
  final DateTime? updated_at;
  final int? profile_completion_percentage;
  final dynamic search_vector;
  final String? display_name;

  const ProfilesBackup({
    this.id,
    this.email,
    this.username,
    this.full_name,
    this.avatar_url,
    this.phone_number,
    this.date_of_birth,
    this.bio,
    this.is_profile_complete,
    this.is_email_verified,
    this.is_phone_verified,
    this.created_at,
    this.updated_at,
    this.profile_completion_percentage,
    this.search_vector,
    this.display_name,
  });

  factory ProfilesBackup.fromJson(Map<String, dynamic> json) {
    return ProfilesBackup(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      full_name: json['full_name'],
      avatar_url: json['avatar_url'],
      phone_number: json['phone_number'],
      date_of_birth: (json['date_of_birth'] == null
          ? null
          : DateTime.parse(json['date_of_birth'] as String)),
      bio: json['bio'],
      is_profile_complete: json['is_profile_complete'],
      is_email_verified: json['is_email_verified'],
      is_phone_verified: json['is_phone_verified'],
      created_at: (json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String)),
      updated_at: (json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String)),
      profile_completion_percentage: json['profile_completion_percentage'],
      search_vector: json['search_vector'],
      display_name: json['display_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'full_name': full_name,
      'avatar_url': avatar_url,
      'phone_number': phone_number,
      'date_of_birth': date_of_birth?.toIso8601String(),
      'bio': bio,
      'is_profile_complete': is_profile_complete,
      'is_email_verified': is_email_verified,
      'is_phone_verified': is_phone_verified,
      'created_at': created_at?.toIso8601String(),
      'updated_at': updated_at?.toIso8601String(),
      'profile_completion_percentage': profile_completion_percentage,
      'search_vector': search_vector,
      'display_name': display_name,
    };
  }
}
