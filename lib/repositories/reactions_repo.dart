import 'package:supabase_flutter/supabase_flutter.dart';

class ReactionsRepo {
  final SupabaseClient _client;
  ReactionsRepo({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  /// Check if the current user has liked a post.
  Future<bool> hasLikedPost(String postId) async {
    final user = _client.auth.currentUser;
    if (user == null) return false;

    final resp = await _client
        .from('reactions')
        .select('id')
        .eq('post_id', postId)
        .eq('user_id', user.id)
        .eq('reaction_type', 'like')
        .limit(1);

    // resp is a List; check if not empty
    return resp.isNotEmpty;
  }

  /// Add a like for the current user. Returns true if inserted.
  Future<bool> likePost(String postId) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw StateError('Not authenticated');
    }

    final insertPayload = {
      'post_id': postId,
      'user_id': user.id,
      'reaction_type': 'like',
    };

    final resp = await _client
        .from('reactions')
        .insert(insertPayload)
        .select('id')
        .maybeSingle();

    if (resp == null) return false;
    return true;
  }

  /// Remove the current user’s like. Returns true if a row was deleted.
  Future<bool> unlikePost(String postId) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw StateError('Not authenticated');
    }

    await _client
        .from('reactions')
        .delete()
        .eq('post_id', postId)
        .eq('user_id', user.id)
        .eq('reaction_type', 'like');
    // Supabase returns the deleted rows unless you disable returning; treat non-error as success.
    return true;
  }

  /// Toggle like: if already liked → unlike; else like. Returns the new liked state.
  Future<bool> toggleLikePost(String postId) async {
    final already = await hasLikedPost(postId);
    if (already) {
      await unlikePost(postId);
      return false;
    } else {
      await likePost(postId);
      return true;
    }
  }

  /// ----- Comment Reactions (like) -----

  /// Check if the current user has liked a comment.
  Future<bool> hasLikedComment(String commentId) async {
    final user = _client.auth.currentUser;
    if (user == null) return false;

    final resp = await _client
        .from('reactions')
        .select('id')
        .eq('comment_id', commentId)
        .eq('user_id', user.id)
        .eq('reaction_type', 'like')
        .limit(1);

    return resp.isNotEmpty;
  }

  /// Add a like for the current user on a comment. Returns true if inserted.
  Future<bool> likeComment(String commentId) async {
    final user = _client.auth.currentUser;
    if (user == null) throw StateError('Not authenticated');

    final insertPayload = {
      'comment_id': commentId,
      'user_id': user.id,
      'reaction_type': 'like',
    };

    final resp = await _client
        .from('reactions')
        .insert(insertPayload)
        .select('id')
        .maybeSingle();

    return resp != null;
  }

  /// Remove the current user’s like from a comment.
  Future<bool> unlikeComment(String commentId) async {
    final user = _client.auth.currentUser;
    if (user == null) throw StateError('Not authenticated');

    await _client
        .from('reactions')
        .delete()
        .eq('comment_id', commentId)
        .eq('user_id', user.id)
        .eq('reaction_type', 'like');

    return true;
  }

  /// Toggle like on a comment. Returns the new liked state.
  Future<bool> toggleLikeComment(String commentId) async {
    final already = await hasLikedComment(commentId);
    if (already) {
      await unlikeComment(commentId);
      return false;
    } else {
      await likeComment(commentId);
      return true;
    }
  }
}
