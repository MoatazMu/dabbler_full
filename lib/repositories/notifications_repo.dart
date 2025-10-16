// GENERATED repository stubs for table: notifications
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/notifications.dart';

class NotificationsRepo {
  final SupabaseClient _db;
  NotificationsRepo(this._db);

  Future<List<Notifications>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('notifications')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(Notifications.fromJson).toList();
  }

  Future<Notifications?> getById(dynamic id) async {
    final res = await _db
        .from('notifications')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return Notifications.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
