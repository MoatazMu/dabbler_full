// GENERATED from introspect.json — do not edit by hand
class SocialMetrics {
  final String id;
  final DateTime metric_date;
  final int? daily_active_users;
  final int? weekly_active_users;
  final int? monthly_active_users;
  final int? posts_created;
  final int? posts_with_media;
  final int? total_likes;
  final int? total_comments;
  final int? total_shares;
  final double? avg_engagement_rate;
  final int? friend_requests_sent;
  final int? friend_requests_accepted;
  final int? friend_requests_declined;
  final double? avg_friends_per_user;
  final int? messages_sent;
  final int? conversations_started;
  final int? avg_response_time_minutes;
  final DateTime created_at;

  const SocialMetrics({
    required this.id,
    required this.metric_date,
    this.daily_active_users,
    this.weekly_active_users,
    this.monthly_active_users,
    this.posts_created,
    this.posts_with_media,
    this.total_likes,
    this.total_comments,
    this.total_shares,
    this.avg_engagement_rate,
    this.friend_requests_sent,
    this.friend_requests_accepted,
    this.friend_requests_declined,
    this.avg_friends_per_user,
    this.messages_sent,
    this.conversations_started,
    this.avg_response_time_minutes,
    required this.created_at,
  });

  factory SocialMetrics.fromJson(Map<String, dynamic> json) {
    return SocialMetrics(
      id: json['id'],
      metric_date: json['metric_date'] != null
          ? DateTime.parse(json['metric_date'] as String)
          : DateTime.now(),
      daily_active_users: json['daily_active_users'],
      weekly_active_users: json['weekly_active_users'],
      monthly_active_users: json['monthly_active_users'],
      posts_created: json['posts_created'],
      posts_with_media: json['posts_with_media'],
      total_likes: json['total_likes'],
      total_comments: json['total_comments'],
      total_shares: json['total_shares'],
      avg_engagement_rate: json['avg_engagement_rate'],
      friend_requests_sent: json['friend_requests_sent'],
      friend_requests_accepted: json['friend_requests_accepted'],
      friend_requests_declined: json['friend_requests_declined'],
      avg_friends_per_user: json['avg_friends_per_user'],
      messages_sent: json['messages_sent'],
      conversations_started: json['conversations_started'],
      avg_response_time_minutes: json['avg_response_time_minutes'],
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'metric_date': metric_date.toIso8601String(),
      'daily_active_users': daily_active_users,
      'weekly_active_users': weekly_active_users,
      'monthly_active_users': monthly_active_users,
      'posts_created': posts_created,
      'posts_with_media': posts_with_media,
      'total_likes': total_likes,
      'total_comments': total_comments,
      'total_shares': total_shares,
      'avg_engagement_rate': avg_engagement_rate,
      'friend_requests_sent': friend_requests_sent,
      'friend_requests_accepted': friend_requests_accepted,
      'friend_requests_declined': friend_requests_declined,
      'avg_friends_per_user': avg_friends_per_user,
      'messages_sent': messages_sent,
      'conversations_started': conversations_started,
      'avg_response_time_minutes': avg_response_time_minutes,
      'created_at': created_at.toIso8601String(),
    };
  }
}
