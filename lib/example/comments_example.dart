import 'package:flutter/foundation.dart';

import '../repositories/comments_repo.dart';

Future<void> demoFetchComments(String postId) async {
  final repo = CommentsRepo();
  final page = await repo.listForPost(postId: postId, page: 1, limit: 20);
  debugPrint('Comments: count=${page.count} items=${page.items.length}');
  for (final c in page.items) {
    debugPrint(
      ' • ${c.id} by ${c.authorId} @ ${c.createdAt.toIso8601String()}',
    );
  }
}
