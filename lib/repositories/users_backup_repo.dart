// GENERATED repository stubs for table: users_backup
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/users_backup.dart';

class UsersBackupRepo {
  final SupabaseClient _db;
  UsersBackupRepo(this._db);

  Future<List<UsersBackup>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('users_backup')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(UsersBackup.fromJson).toList();
  }

  Future<UsersBackup?> getById(dynamic id) async {
    final res = await _db.from('users_backup')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return UsersBackup.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
