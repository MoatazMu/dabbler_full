import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../repositories/feed_repo.dart';

Future<void> demoFetchFeed() async {
  final user = Supabase.instance.client.auth.currentUser;
  debugPrint('Feed: current user: ${user?.id ?? 'anonymous'}');

  final repo = FeedRepo();
  final page = await repo.fetchFeed(limit: 10);

  debugPrint('Feed items=${page.items.length} next=${page.next != null}');
  for (final item in page.items) {
    debugPrint(
      ' • ${item.id} by ${item.authorId} vis=${item.visibility} at ${item.createdAt.toIso8601String()}',
    );
  }
}
