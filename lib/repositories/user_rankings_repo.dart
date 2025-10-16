// GENERATED repository stubs for table: user_rankings
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_rankings.dart';

class UserRankingsRepo {
  final SupabaseClient _db;
  UserRankingsRepo(this._db);

  Future<List<UserRankings>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('user_rankings')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(UserRankings.fromJson).toList();
  }

  Future<UserRankings?> getById(dynamic id) async {
    final res = await _db
        .from('user_rankings')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return UserRankings.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
