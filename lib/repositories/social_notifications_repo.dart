// GENERATED repository stubs for table: social_notifications
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/social_notifications.dart';

class SocialNotificationsRepo {
  final SupabaseClient _db;
  SocialNotificationsRepo(this._db);

  Future<List<SocialNotifications>> list({
    int limit = 50,
    int offset = 0,
  }) async {
    final res = await _db
        .from('social_notifications')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(SocialNotifications.fromJson).toList();
  }

  Future<SocialNotifications?> getById(dynamic id) async {
    final res = await _db
        .from('social_notifications')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return SocialNotifications.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
