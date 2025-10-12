// GENERATED repository stubs for table: tier_levels
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tier_levels.dart';

class TierLevelsRepo {
  final SupabaseClient _db;
  TierLevelsRepo(this._db);

  Future<List<TierLevels>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('tier_levels')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(TierLevels.fromJson).toList();
  }

  Future<TierLevels?> getById(dynamic id) async {
    final res = await _db.from('tier_levels')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return TierLevels.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
