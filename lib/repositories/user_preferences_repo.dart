// GENERATED repository stubs for table: user_preferences
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_preferences.dart';

class UserPreferencesRepo {
  final SupabaseClient _db;
  UserPreferencesRepo(this._db);

  Future<List<UserPreferences>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('user_preferences')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(UserPreferences.fromJson).toList();
  }

  Future<UserPreferences?> getById(dynamic id) async {
    final res = await _db.from('user_preferences')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return UserPreferences.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
