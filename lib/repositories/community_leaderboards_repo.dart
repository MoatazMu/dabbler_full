// GENERATED repository stubs for table: community_leaderboards
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/community_leaderboards.dart';

class CommunityLeaderboardsRepo {
  final SupabaseClient _db;
  CommunityLeaderboardsRepo(this._db);

  Future<List<CommunityLeaderboards>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('community_leaderboards')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(CommunityLeaderboards.fromJson).toList();
  }

  Future<CommunityLeaderboards?> getById(dynamic id) async {
    final res = await _db.from('community_leaderboards')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return CommunityLeaderboards.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
