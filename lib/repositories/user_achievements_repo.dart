// GENERATED repository stubs for table: user_achievements
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_achievements.dart';

class UserAchievementsRepo {
  final SupabaseClient _db;
  UserAchievementsRepo(this._db);

  Future<List<UserAchievements>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('user_achievements')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(UserAchievements.fromJson).toList();
  }

  Future<UserAchievements?> getById(dynamic id) async {
    final res = await _db
        .from('user_achievements')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return UserAchievements.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
