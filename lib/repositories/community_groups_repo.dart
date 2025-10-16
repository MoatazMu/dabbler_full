// GENERATED repository stubs for table: community_groups
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/community_groups.dart';

class CommunityGroupsRepo {
  final SupabaseClient _db;
  CommunityGroupsRepo(this._db);

  Future<List<CommunityGroups>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('community_groups')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(CommunityGroups.fromJson).toList();
  }

  Future<CommunityGroups?> getById(dynamic id) async {
    final res = await _db
        .from('community_groups')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return CommunityGroups.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
