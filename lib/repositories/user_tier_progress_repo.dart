// GENERATED repository stubs for table: user_tier_progress
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_tier_progress.dart';

class UserTierProgressRepo {
  final SupabaseClient _db;
  UserTierProgressRepo(this._db);

  Future<List<UserTierProgress>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('user_tier_progress')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(UserTierProgress.fromJson).toList();
  }

  Future<UserTierProgress?> getById(dynamic id) async {
    final res = await _db.from('user_tier_progress')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return UserTierProgress.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
