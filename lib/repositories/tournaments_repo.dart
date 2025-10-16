// GENERATED repository stubs for table: tournaments
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tournaments.dart';

class TournamentsRepo {
  final SupabaseClient _db;
  TournamentsRepo(this._db);

  Future<List<Tournaments>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('tournaments')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(Tournaments.fromJson).toList();
  }

  Future<Tournaments?> getById(dynamic id) async {
    final res = await _db
        .from('tournaments')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return Tournaments.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
