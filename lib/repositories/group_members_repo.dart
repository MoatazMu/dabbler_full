// GENERATED repository stubs for table: group_members
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/group_members.dart';

class GroupMembersRepo {
  final SupabaseClient _db;
  GroupMembersRepo(this._db);

  Future<List<GroupMembers>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('group_members')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(GroupMembers.fromJson).toList();
  }

  Future<GroupMembers?> getById(dynamic id) async {
    final res = await _db
        .from('group_members')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return GroupMembers.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
