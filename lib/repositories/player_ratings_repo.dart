// GENERATED repository stubs for table: player_ratings
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/player_ratings.dart';

class PlayerRatingsRepo {
  final SupabaseClient _db;
  PlayerRatingsRepo(this._db);

  Future<List<PlayerRatings>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('player_ratings')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(PlayerRatings.fromJson).toList();
  }

  Future<PlayerRatings?> getById(dynamic id) async {
    final res = await _db.from('player_ratings')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return PlayerRatings.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
