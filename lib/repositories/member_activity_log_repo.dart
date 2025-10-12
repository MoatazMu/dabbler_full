// GENERATED repository stubs for table: member_activity_log
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/member_activity_log.dart';

class MemberActivityLogRepo {
  final SupabaseClient _db;
  MemberActivityLogRepo(this._db);

  Future<List<MemberActivityLog>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('member_activity_log')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(MemberActivityLog.fromJson).toList();
  }

  Future<MemberActivityLog?> getById(dynamic id) async {
    final res = await _db.from('member_activity_log')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return MemberActivityLog.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
