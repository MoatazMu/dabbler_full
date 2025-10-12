// GENERATED repository stubs for table: profile_statistics
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile_statistics.dart';

class ProfileStatisticsRepo {
  final SupabaseClient _db;
  ProfileStatisticsRepo(this._db);

  Future<List<ProfileStatistics>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('profile_statistics')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(ProfileStatistics.fromJson).toList();
  }

  Future<ProfileStatistics?> getById(dynamic id) async {
    final res = await _db.from('profile_statistics')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return ProfileStatistics.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
