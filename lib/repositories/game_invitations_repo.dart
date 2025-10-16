// GENERATED repository stubs for table: game_invitations
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/game_invitations.dart';

class GameInvitationsRepo {
  final SupabaseClient _db;
  GameInvitationsRepo(this._db);

  Future<List<GameInvitations>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('game_invitations')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(GameInvitations.fromJson).toList();
  }

  Future<GameInvitations?> getById(dynamic id) async {
    final res = await _db
        .from('game_invitations')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return GameInvitations.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
