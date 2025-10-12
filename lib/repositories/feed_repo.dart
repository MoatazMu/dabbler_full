import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/post_feed_item.dart';

class FeedRepo {
  final SupabaseClient _client;
  FeedRepo({SupabaseClient? client}) : _client = client ?? Supabase.instance.client;

  /// Fetch a mixed feed (public + friends) via edge function.
  /// If the user is authenticated, pass the access token automatically via Supabase client.
  Future<PostFeedPage> fetchFeed({int page = 1, int limit = 20}) async {
    final res = await _client.functions.invoke(
      'public-feed',
      queryParameters: {'page': page.toString(), 'limit': limit.toString()},
    );

    if (res.data == null) {
      throw StateError('public-feed returned no data');
    }

    // res.data can be Map or JSON string depending on supabase_flutter version; handle both
    final Map<String, dynamic> map = switch (res.data) {
      final Map<String, dynamic> m => m,
      final String s => jsonDecode(s) as Map<String, dynamic>,
      _ => throw StateError('Unexpected response type: ${res.data.runtimeType}'),
    };

    return PostFeedPage.fromMap(map);
  }
}
