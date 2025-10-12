// GENERATED repository stubs for table: users
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/users.dart';

class UsersRepo {
  final SupabaseClient _db;
  UsersRepo(this._db);

  Future<List<Users>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('users')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(Users.fromJson).toList();
  }

  Future<Users?> getById(dynamic id) async {
    final res = await _db.from('users')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return Users.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
