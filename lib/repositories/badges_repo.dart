// GENERATED repository stubs for table: badges
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/badges.dart';

class BadgesRepo {
  final SupabaseClient _db;
  BadgesRepo(this._db);

  Future<List<Badges>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('badges')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(Badges.fromJson).toList();
  }

  Future<Badges?> getById(dynamic id) async {
    final res = await _db.from('badges').select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return Badges.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
