// GENERATED repository stubs for table: conversations
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/conversations.dart';

class ConversationsRepo {
  final SupabaseClient _db;
  ConversationsRepo(this._db);

  Future<List<Conversations>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('conversations')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(Conversations.fromJson).toList();
  }

  Future<Conversations?> getById(dynamic id) async {
    final res = await _db
        .from('conversations')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return Conversations.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
