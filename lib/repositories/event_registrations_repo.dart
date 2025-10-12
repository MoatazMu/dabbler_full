// GENERATED repository stubs for table: event_registrations
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/event_registrations.dart';

class EventRegistrationsRepo {
  final SupabaseClient _db;
  EventRegistrationsRepo(this._db);

  Future<List<EventRegistrations>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('event_registrations')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(EventRegistrations.fromJson).toList();
  }

  Future<EventRegistrations?> getById(dynamic id) async {
    final res = await _db.from('event_registrations')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return EventRegistrations.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
