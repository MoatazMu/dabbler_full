// GENERATED repository stubs for table: game_players
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/game_players.dart';

class GamePlayersRepo {
  final SupabaseClient _db;
  GamePlayersRepo(this._db);

  Future<List<GamePlayers>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('game_players')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(GamePlayers.fromJson).toList();
  }

  Future<GamePlayers?> getById(dynamic id) async {
    final res = await _db.from('game_players')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return GamePlayers.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
