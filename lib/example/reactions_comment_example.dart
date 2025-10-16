import 'package:flutter/foundation.dart';
import '../repositories/reactions_repo.dart';

Future<void> demoToggleCommentLike(String commentId) async {
  final repo = ReactionsRepo();
  try {
    final newState = await repo.toggleLikeComment(commentId);
    debugPrint('toggleLikeComment: comment=$commentId now liked=$newState');
  } catch (e) {
    debugPrint('toggleLikeComment failed: $e');
  }
}
