// GENERATED repository stubs for table: skill_levels
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/skill_levels.dart';

class SkillLevelsRepo {
  final SupabaseClient _db;
  SkillLevelsRepo(this._db);

  Future<List<SkillLevels>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('skill_levels')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(SkillLevels.fromJson).toList();
  }

  Future<SkillLevels?> getById(dynamic id) async {
    final res = await _db.from('skill_levels')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return SkillLevels.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
