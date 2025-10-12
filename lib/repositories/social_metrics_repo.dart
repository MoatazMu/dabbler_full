// GENERATED repository stubs for table: social_metrics
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/social_metrics.dart';

class SocialMetricsRepo {
  final SupabaseClient _db;
  SocialMetricsRepo(this._db);

  Future<List<SocialMetrics>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('social_metrics')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(SocialMetrics.fromJson).toList();
  }

  Future<SocialMetrics?> getById(dynamic id) async {
    final res = await _db.from('social_metrics')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return SocialMetrics.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
