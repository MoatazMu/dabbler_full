// GENERATED repository stubs for table: game_check_ins
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/game_check_ins.dart';

class GameCheckInsRepo {
  final SupabaseClient _db;
  GameCheckInsRepo(this._db);

  Future<List<GameCheckIns>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('game_check_ins')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(GameCheckIns.fromJson).toList();
  }

  Future<GameCheckIns?> getById(dynamic id) async {
    final res = await _db
        .from('game_check_ins')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return GameCheckIns.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
