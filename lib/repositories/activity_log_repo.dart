// GENERATED repository stubs for table: activity_log
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/activity_log.dart';

class ActivityLogRepo {
  final SupabaseClient _db;
  ActivityLogRepo(this._db);

  Future<List<ActivityLog>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('activity_log')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(ActivityLog.fromJson).toList();
  }

  Future<ActivityLog?> getById(dynamic id) async {
    final res = await _db.from('activity_log')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return ActivityLog.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
