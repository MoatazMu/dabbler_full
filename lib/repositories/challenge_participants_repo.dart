// GENERATED repository stubs for table: challenge_participants
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/challenge_participants.dart';

class ChallengeParticipantsRepo {
  final SupabaseClient _db;
  ChallengeParticipantsRepo(this._db);

  Future<List<ChallengeParticipants>> list({
    int limit = 50,
    int offset = 0,
  }) async {
    final res = await _db
        .from('challenge_participants')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(ChallengeParticipants.fromJson).toList();
  }

  Future<ChallengeParticipants?> getById(dynamic id) async {
    final res = await _db
        .from('challenge_participants')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return ChallengeParticipants.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
