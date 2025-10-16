import 'package:flutter/foundation.dart';
import '../repositories/reactions_repo.dart';

Future<void> demoToggleLike(String postId) async {
  final repo = ReactionsRepo();
  try {
    final newState = await repo.toggleLikePost(postId);
    debugPrint('toggleLike: post=$postId now liked=$newState');
  } catch (e) {
    debugPrint('toggleLike failed: $e');
  }
}
