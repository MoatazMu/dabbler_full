// GENERATED repository stubs for table: user_badges
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_badges.dart';

class UserBadgesRepo {
  final SupabaseClient _db;
  UserBadgesRepo(this._db);

  Future<List<UserBadges>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('user_badges')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(UserBadges.fromJson).toList();
  }

  Future<UserBadges?> getById(dynamic id) async {
    final res = await _db.from('user_badges')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return UserBadges.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
