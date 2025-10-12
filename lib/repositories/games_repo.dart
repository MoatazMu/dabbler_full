// GENERATED repository stubs for table: games
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/games.dart';

class GamesRepo {
  final SupabaseClient _db;
  GamesRepo(this._db);

  Future<List<Games>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('games')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(Games.fromJson).toList();
  }

  Future<Games?> getById(dynamic id) async {
    final res = await _db.from('games')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return Games.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
