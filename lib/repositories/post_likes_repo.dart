// GENERATED repository stubs for table: post_likes
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/post_likes.dart';

class PostLikesRepo {
  final SupabaseClient _db;
  PostLikesRepo(this._db);

  Future<List<PostLikes>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('post_likes')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(PostLikes.fromJson).toList();
  }

  Future<PostLikes?> getById(dynamic id) async {
    final res = await _db
        .from('post_likes')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return PostLikes.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
