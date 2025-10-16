// GENERATED repository stubs for table: point_transactions
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/point_transactions.dart';

class PointTransactionsRepo {
  final SupabaseClient _db;
  PointTransactionsRepo(this._db);

  Future<List<PointTransactions>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('point_transactions')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(PointTransactions.fromJson).toList();
  }

  Future<PointTransactions?> getById(dynamic id) async {
    final res = await _db
        .from('point_transactions')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return PointTransactions.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
