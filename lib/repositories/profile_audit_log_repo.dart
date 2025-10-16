// GENERATED repository stubs for table: profile_audit_log
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile_audit_log.dart';

class ProfileAuditLogRepo {
  final SupabaseClient _db;
  ProfileAuditLogRepo(this._db);

  Future<List<ProfileAuditLog>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('profile_audit_log')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(ProfileAuditLog.fromJson).toList();
  }

  Future<ProfileAuditLog?> getById(dynamic id) async {
    final res = await _db
        .from('profile_audit_log')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return ProfileAuditLog.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
