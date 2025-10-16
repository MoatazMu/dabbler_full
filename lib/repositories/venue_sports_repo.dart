// GENERATED repository stubs for table: venue_sports
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/venue_sports.dart';

class VenueSportsRepo {
  final SupabaseClient _db;
  VenueSportsRepo(this._db);

  Future<List<VenueSports>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('venue_sports')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(VenueSports.fromJson).toList();
  }

  Future<VenueSports?> getById(dynamic id) async {
    final res = await _db
        .from('venue_sports')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return VenueSports.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
