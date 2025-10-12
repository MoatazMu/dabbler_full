// GENERATED repository stubs for table: leaderboards
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/leaderboards.dart';

class LeaderboardsRepo {
  final SupabaseClient _db;
  LeaderboardsRepo(this._db);

  Future<List<Leaderboards>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('leaderboards')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(Leaderboards.fromJson).toList();
  }

  Future<Leaderboards?> getById(dynamic id) async {
    final res = await _db.from('leaderboards')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return Leaderboards.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
