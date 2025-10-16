// GENERATED repository stubs for table: community_events
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/community_events.dart';

class CommunityEventsRepo {
  final SupabaseClient _db;
  CommunityEventsRepo(this._db);

  Future<List<CommunityEvents>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('community_events')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(CommunityEvents.fromJson).toList();
  }

  Future<CommunityEvents?> getById(dynamic id) async {
    final res = await _db
        .from('community_events')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return CommunityEvents.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
