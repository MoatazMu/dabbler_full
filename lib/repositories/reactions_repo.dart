// GENERATED repository stubs for table: reactions
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/reactions.dart';

class ReactionsRepo {
  final SupabaseClient _db;
  ReactionsRepo(this._db);

  Future<List<Reactions>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('reactions')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(Reactions.fromJson).toList();
  }

  Future<Reactions?> getById(dynamic id) async {
    final res = await _db.from('reactions')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return Reactions.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
