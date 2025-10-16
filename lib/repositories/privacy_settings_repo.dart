// GENERATED repository stubs for table: privacy_settings
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/privacy_settings.dart';

class PrivacySettingsRepo {
  final SupabaseClient _db;
  PrivacySettingsRepo(this._db);

  Future<List<PrivacySettings>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('privacy_settings')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(PrivacySettings.fromJson).toList();
  }

  Future<PrivacySettings?> getById(dynamic id) async {
    final res = await _db
        .from('privacy_settings')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return PrivacySettings.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
