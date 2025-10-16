// GENERATED repository stubs for table: game_sessions
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/game_sessions.dart';

class GameSessionsRepo {
  final SupabaseClient _db;
  GameSessionsRepo(this._db);

  Future<List<GameSessions>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('game_sessions')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(GameSessions.fromJson).toList();
  }

  Future<GameSessions?> getById(dynamic id) async {
    final res = await _db
        .from('game_sessions')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return GameSessions.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
