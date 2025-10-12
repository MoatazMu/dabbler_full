// GENERATED repository stubs for table: community_analytics
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/community_analytics.dart';

class CommunityAnalyticsRepo {
  final SupabaseClient _db;
  CommunityAnalyticsRepo(this._db);

  Future<List<CommunityAnalytics>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('community_analytics')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(CommunityAnalytics.fromJson).toList();
  }

  Future<CommunityAnalytics?> getById(dynamic id) async {
    final res = await _db.from('community_analytics')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return CommunityAnalytics.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
