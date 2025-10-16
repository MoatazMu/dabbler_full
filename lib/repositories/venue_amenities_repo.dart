// GENERATED repository stubs for table: venue_amenities
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/venue_amenities.dart';

class VenueAmenitiesRepo {
  final SupabaseClient _db;
  VenueAmenitiesRepo(this._db);

  Future<List<VenueAmenities>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('venue_amenities')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(VenueAmenities.fromJson).toList();
  }

  Future<VenueAmenities?> getById(dynamic id) async {
    final res = await _db
        .from('venue_amenities')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return VenueAmenities.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
