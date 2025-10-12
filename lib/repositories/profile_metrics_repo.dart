// GENERATED repository stubs for table: profile_metrics
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile_metrics.dart';

class ProfileMetricsRepo {
  final SupabaseClient _db;
  ProfileMetricsRepo(this._db);

  Future<List<ProfileMetrics>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('profile_metrics')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(ProfileMetrics.fromJson).toList();
  }

  Future<ProfileMetrics?> getById(dynamic id) async {
    final res = await _db.from('profile_metrics')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return ProfileMetrics.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
