// GENERATED repository stubs for table: password_reset_attempts
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/password_reset_attempts.dart';

class PasswordResetAttemptsRepo {
  final SupabaseClient _db;
  PasswordResetAttemptsRepo(this._db);

  Future<List<PasswordResetAttempts>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('password_reset_attempts')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(PasswordResetAttempts.fromJson).toList();
  }

  Future<PasswordResetAttempts?> getById(dynamic id) async {
    final res = await _db.from('password_reset_attempts')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return PasswordResetAttempts.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
