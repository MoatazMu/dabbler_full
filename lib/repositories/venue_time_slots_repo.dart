// GENERATED repository stubs for table: venue_time_slots
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/venue_time_slots.dart';

class VenueTimeSlotsRepo {
  final SupabaseClient _db;
  VenueTimeSlotsRepo(this._db);

  Future<List<VenueTimeSlots>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('venue_time_slots')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(VenueTimeSlots.fromJson).toList();
  }

  Future<VenueTimeSlots?> getById(dynamic id) async {
    final res = await _db
        .from('venue_time_slots')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return VenueTimeSlots.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
