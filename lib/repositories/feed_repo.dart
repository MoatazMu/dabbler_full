import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/post_feed_item.dart';

class FeedRepo {
  final SupabaseClient _client;
  FeedRepo({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  /// Keyset-friendly fetch: pass optional cursor (created_before + last_id).
  Future<PostFeedPage> fetchFeed({
    int limit = 20,
    String? createdBeforeIso,
    String? lastId,
    String scope = 'public',
  }) async {
    final qp = <String, String>{'limit': limit.toString(), 'scope': scope};
    if (createdBeforeIso != null) qp['created_before'] = createdBeforeIso;
    if (lastId != null) qp['last_id'] = lastId;

    final res = await _client.functions.invoke(
      'public-feed',
      queryParameters: qp,
    );

    if (res.data == null) {
      throw StateError('public-feed returned no data');
    }

    // res.data can be Map or JSON string depending on supabase_flutter version; handle both
    final Map<String, dynamic> map = switch (res.data) {
      final Map<String, dynamic> m => m,
      final String s => jsonDecode(s) as Map<String, dynamic>,
      _ => throw StateError(
        'Unexpected response type: ${res.data.runtimeType}',
      ),
    };

    return PostFeedPage.fromMap(
      map,
    ); // expects { items: [...], next: { created_before, last_id } | null }
  }
}
