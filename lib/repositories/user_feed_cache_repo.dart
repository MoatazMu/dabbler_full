// GENERATED repository stubs for table: user_feed_cache
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_feed_cache.dart';

class UserFeedCacheRepo {
  final SupabaseClient _db;
  UserFeedCacheRepo(this._db);

  Future<List<UserFeedCache>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('user_feed_cache')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(UserFeedCache.fromJson).toList();
  }

  Future<UserFeedCache?> getById(dynamic id) async {
    final res = await _db
        .from('user_feed_cache')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return UserFeedCache.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
