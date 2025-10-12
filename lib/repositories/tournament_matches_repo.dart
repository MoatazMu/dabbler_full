// GENERATED repository stubs for table: tournament_matches
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tournament_matches.dart';

class TournamentMatchesRepo {
  final SupabaseClient _db;
  TournamentMatchesRepo(this._db);

  Future<List<TournamentMatches>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('tournament_matches')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(TournamentMatches.fromJson).toList();
  }

  Future<TournamentMatches?> getById(dynamic id) async {
    final res = await _db.from('tournament_matches')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return TournamentMatches.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
