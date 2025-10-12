// GENERATED repository stubs for table: badge_showcase_settings
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/badge_showcase_settings.dart';

class BadgeShowcaseSettingsRepo {
  final SupabaseClient _db;
  BadgeShowcaseSettingsRepo(this._db);

  Future<List<BadgeShowcaseSettings>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('badge_showcase_settings')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(BadgeShowcaseSettings.fromJson).toList();
  }

  Future<BadgeShowcaseSettings?> getById(dynamic id) async {
    final res = await _db.from('badge_showcase_settings')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return BadgeShowcaseSettings.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
