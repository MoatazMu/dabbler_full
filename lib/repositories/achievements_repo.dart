// GENERATED repository stubs for table: achievements
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/achievements.dart';

class AchievementsRepo {
  final SupabaseClient _db;
  AchievementsRepo(this._db);

  Future<List<Achievements>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('achievements')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(Achievements.fromJson).toList();
  }

  Future<Achievements?> getById(dynamic id) async {
    final res = await _db
        .from('achievements')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return Achievements.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
