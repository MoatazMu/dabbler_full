// GENERATED repository stubs for table: sports
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/sports.dart';

class SportsRepo {
  final SupabaseClient _db;
  SportsRepo(this._db);

  Future<List<Sports>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('sports')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(Sports.fromJson).toList();
  }

  Future<Sports?> getById(dynamic id) async {
    final res = await _db.from('sports').select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return Sports.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
