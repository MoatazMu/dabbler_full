// GENERATED repository stubs for table: posts
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/posts.dart';

class PostsRepo {
  final SupabaseClient _db;
  PostsRepo(this._db);

  Future<List<Posts>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('posts')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(Posts.fromJson).toList();
  }

  Future<Posts?> getById(dynamic id) async {
    final res = await _db.from('posts')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return Posts.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
