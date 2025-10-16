// GENERATED repository stubs for table: regions
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/regions.dart';

class RegionsRepo {
  final SupabaseClient _db;
  RegionsRepo(this._db);

  Future<List<Regions>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('regions')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(Regions.fromJson).toList();
  }

  Future<Regions?> getById(dynamic id) async {
    final res = await _db
        .from('regions')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return Regions.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
