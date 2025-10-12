// GENERATED repository stubs for table: comments
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/comments.dart';

class CommentsRepo {
  final SupabaseClient _db;
  CommentsRepo(this._db);

  Future<List<Comments>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('comments')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(Comments.fromJson).toList();
  }

  Future<Comments?> getById(dynamic id) async {
    final res = await _db.from('comments')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return Comments.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
