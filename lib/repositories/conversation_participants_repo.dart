// GENERATED repository stubs for table: conversation_participants
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/conversation_participants.dart';

class ConversationParticipantsRepo {
  final SupabaseClient _db;
  ConversationParticipantsRepo(this._db);

  Future<List<ConversationParticipants>> list({int limit = 50, int offset = 0}) async {
    final res = await _db.from('conversation_participants')
      .select('*')
      .range(offset, offset + limit - 1)
      .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(ConversationParticipants.fromJson).toList();
  }

  Future<ConversationParticipants?> getById(dynamic id) async {
    final res = await _db.from('conversation_participants')
      .select('*').eq('id', id).maybeSingle();
    if (res == null) return null;
    return ConversationParticipants.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
