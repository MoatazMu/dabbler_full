// GENERATED repository stubs for table: venue_images
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/venue_images.dart';

class VenueImagesRepo {
  final SupabaseClient _db;
  VenueImagesRepo(this._db);

  Future<List<VenueImages>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('venue_images')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(VenueImages.fromJson).toList();
  }

  Future<VenueImages?> getById(dynamic id) async {
    final res = await _db.from('venue_images')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return VenueImages.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
