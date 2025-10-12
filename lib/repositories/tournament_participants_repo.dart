// GENERATED repository stubs for table: tournament_participants
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tournament_participants.dart';

class TournamentParticipantsRepo {
  final SupabaseClient _db;
  TournamentParticipantsRepo(this._db);

  Future<List<TournamentParticipants>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('tournament_participants')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(TournamentParticipants.fromJson).toList();
  }

  Future<TournamentParticipants?> getById(dynamic id) async {
    final res = await _db.from('tournament_participants')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return TournamentParticipants.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
