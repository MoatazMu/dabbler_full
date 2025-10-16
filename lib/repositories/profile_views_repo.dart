// GENERATED repository stubs for table: profile_views
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile_views.dart';

class ProfileViewsRepo {
  final SupabaseClient _db;
  ProfileViewsRepo(this._db);

  Future<List<ProfileViews>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('profile_views')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(ProfileViews.fromJson).toList();
  }

  Future<ProfileViews?> getById(dynamic id) async {
    final res = await _db
        .from('profile_views')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return ProfileViews.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
