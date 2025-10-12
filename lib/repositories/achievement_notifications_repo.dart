// GENERATED repository stubs for table: achievement_notifications
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/achievement_notifications.dart';

class AchievementNotificationsRepo {
  final SupabaseClient _db;
  AchievementNotificationsRepo(this._db);

  Future<List<AchievementNotifications>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('achievement_notifications')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(AchievementNotifications.fromJson).toList();
  }

  Future<AchievementNotifications?> getById(dynamic id) async {
    final res = await _db.from('achievement_notifications')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return AchievementNotifications.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
