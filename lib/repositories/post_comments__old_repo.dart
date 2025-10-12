// GENERATED repository stubs for table: post_comments__old
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/post_comments__old.dart';

class PostCommentsOldRepo {
  final SupabaseClient _db;
  PostCommentsOldRepo(this._db);

  Future<List<PostCommentsOld>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('post_comments__old')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(PostCommentsOld.fromJson).toList();
  }

  Future<PostCommentsOld?> getById(dynamic id) async {
    final res = await _db.from('post_comments__old')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return PostCommentsOld.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
