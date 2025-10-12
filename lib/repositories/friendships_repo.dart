// GENERATED repository stubs for table: friendships
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/friendships.dart';

class FriendshipsRepo {
  final SupabaseClient _db;
  FriendshipsRepo(this._db);

  Future<List<Friendships>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('friendships')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(Friendships.fromJson).toList();
  }

  Future<Friendships?> getById(dynamic id) async {
    final res = await _db.from('friendships')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return Friendships.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
