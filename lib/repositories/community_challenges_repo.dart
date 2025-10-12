// GENERATED repository stubs for table: community_challenges
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/community_challenges.dart';

class CommunityChallengesRepo {
  final SupabaseClient _db;
  CommunityChallengesRepo(this._db);

  Future<List<CommunityChallenges>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('community_challenges')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(CommunityChallenges.fromJson).toList();
  }

  Future<CommunityChallenges?> getById(dynamic id) async {
    final res = await _db.from('community_challenges')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return CommunityChallenges.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
