// GENERATED repository stubs for table: user_sports_profiles
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_sports_profiles.dart';

class UserSportsProfilesRepo {
  final SupabaseClient _db;
  UserSportsProfilesRepo(this._db);

  Future<List<UserSportsProfiles>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('user_sports_profiles')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(UserSportsProfiles.fromJson).toList();
  }

  Future<UserSportsProfiles?> getById(dynamic id) async {
    final res = await _db.from('user_sports_profiles')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return UserSportsProfiles.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
