// GENERATED repository stubs for table: messages
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/messages.dart';

class MessagesRepo {
  final SupabaseClient _db;
  MessagesRepo(this._db);

  Future<List<Messages>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('messages')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(Messages.fromJson).toList();
  }

  Future<Messages?> getById(dynamic id) async {
    final res = await _db
        .from('messages')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return Messages.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
