// GENERATED repository stubs for table: game_notifications
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/game_notifications.dart';

class GameNotificationsRepo {
  final SupabaseClient _db;
  GameNotificationsRepo(this._db);

  Future<List<GameNotifications>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('game_notifications')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(GameNotifications.fromJson).toList();
  }

  Future<GameNotifications?> getById(dynamic id) async {
    final res = await _db
        .from('game_notifications')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return GameNotifications.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
