// GENERATED repository stubs for table: challenge_progress_updates
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/challenge_progress_updates.dart';

class ChallengeProgressUpdatesRepo {
  final SupabaseClient _db;
  ChallengeProgressUpdatesRepo(this._db);

  Future<List<ChallengeProgressUpdates>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('challenge_progress_updates')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(ChallengeProgressUpdates.fromJson).toList();
  }

  Future<ChallengeProgressUpdates?> getById(dynamic id) async {
    final res = await _db.from('challenge_progress_updates')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return ChallengeProgressUpdates.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
