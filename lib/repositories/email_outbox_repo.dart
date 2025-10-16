// GENERATED repository stubs for table: email_outbox
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/email_outbox.dart';

class EmailOutboxRepo {
  final SupabaseClient _db;
  EmailOutboxRepo(this._db);

  Future<List<EmailOutbox>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('email_outbox')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(EmailOutbox.fromJson).toList();
  }

  Future<EmailOutbox?> getById(dynamic id) async {
    final res = await _db
        .from('email_outbox')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return EmailOutbox.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
