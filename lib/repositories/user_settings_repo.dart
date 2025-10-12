// GENERATED repository stubs for table: user_settings
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_settings.dart';

class UserSettingsRepo {
  final SupabaseClient _db;
  UserSettingsRepo(this._db);

  Future<List<UserSettings>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('user_settings')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(UserSettings.fromJson).toList();
  }

  Future<UserSettings?> getById(dynamic id) async {
    final res = await _db.from('user_settings')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return UserSettings.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
