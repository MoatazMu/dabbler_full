// GENERATED repository stubs for table: auth_sessions
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/auth_sessions.dart';

class AuthSessionsRepo {
  final SupabaseClient _db;
  AuthSessionsRepo(this._db);

  Future<List<AuthSessions>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('auth_sessions')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(AuthSessions.fromJson).toList();
  }

  Future<AuthSessions?> getById(dynamic id) async {
    final res = await _db.from('auth_sessions')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return AuthSessions.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
