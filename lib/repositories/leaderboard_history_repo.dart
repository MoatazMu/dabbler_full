// GENERATED repository stubs for table: leaderboard_history
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/leaderboard_history.dart';

class LeaderboardHistoryRepo {
  final SupabaseClient _db;
  LeaderboardHistoryRepo(this._db);

  Future<List<LeaderboardHistory>> list({
    int limit = 50,
    int offset = 0,
  }) async {
    final res = await _db
        .from('leaderboard_history')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(LeaderboardHistory.fromJson).toList();
  }

  Future<LeaderboardHistory?> getById(dynamic id) async {
    final res = await _db
        .from('leaderboard_history')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return LeaderboardHistory.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
