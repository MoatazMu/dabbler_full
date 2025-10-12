// GENERATED repository stubs for table: profile_feature_flags
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile_feature_flags.dart';

class ProfileFeatureFlagsRepo {
  final SupabaseClient _db;
  ProfileFeatureFlagsRepo(this._db);

  Future<List<ProfileFeatureFlags>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('profile_feature_flags')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(ProfileFeatureFlags.fromJson).toList();
  }

  Future<ProfileFeatureFlags?> getById(dynamic id) async {
    final res = await _db.from('profile_feature_flags')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return ProfileFeatureFlags.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
