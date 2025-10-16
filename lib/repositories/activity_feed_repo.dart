// GENERATED repository stubs for table: activity_feed
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/activity_feed.dart';

class ActivityFeedRepo {
  final SupabaseClient _db;
  ActivityFeedRepo(this._db);

  Future<List<ActivityFeed>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('activity_feed')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(ActivityFeed.fromJson).toList();
  }

  Future<ActivityFeed?> getById(dynamic id) async {
    final res = await _db
        .from('activity_feed')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return ActivityFeed.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
