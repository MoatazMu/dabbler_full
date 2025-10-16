import 'package:flutter/foundation.dart';
import '../repositories/comments_repo.dart';

Future<void> demoCreateComment(String postId, String text) async {
  final repo = CommentsRepo();
  try {
    final created = await repo.create(postId: postId, content: text);
    debugPrint(
      'Created comment ${created.id} on post ${created.postId} by ${created.authorId}',
    );
  } catch (e) {
    debugPrint('Failed to create comment: $e');
  }
}
