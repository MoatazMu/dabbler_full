// GENERATED repository stubs for table: profile_audit
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile_audit.dart';

class ProfileAuditRepo {
  final SupabaseClient _db;
  ProfileAuditRepo(this._db);

  Future<List<ProfileAudit>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('profile_audit')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(ProfileAudit.fromJson).toList();
  }

  Future<ProfileAudit?> getById(dynamic id) async {
    final res = await _db
        .from('profile_audit')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return ProfileAudit.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
