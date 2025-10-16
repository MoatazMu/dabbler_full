// GENERATED repository stubs for table: scheduled_rewards
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/scheduled_rewards.dart';

class ScheduledRewardsRepo {
  final SupabaseClient _db;
  ScheduledRewardsRepo(this._db);

  Future<List<ScheduledRewards>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('scheduled_rewards')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(ScheduledRewards.fromJson).toList();
  }

  Future<ScheduledRewards?> getById(dynamic id) async {
    final res = await _db
        .from('scheduled_rewards')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return ScheduledRewards.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
