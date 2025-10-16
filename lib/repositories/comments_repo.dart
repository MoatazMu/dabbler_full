import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/comment_item.dart';

class CommentsRepo {
  final SupabaseClient _client;
  CommentsRepo({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  Future<CommentPage> listForPost({
    required String postId,
    int page = 1,
    int limit = 50,
  }) async {
    final res = await _client.functions.invoke(
      'public-comments',
      queryParameters: {'post_id': postId, 'page': '$page', 'limit': '$limit'},
    );

    if (res.data == null) {
      throw StateError('public-comments returned no data');
    }

    final Map<String, dynamic> map = switch (res.data) {
      final Map<String, dynamic> m => m,
      final String s => jsonDecode(s) as Map<String, dynamic>,
      _ => throw StateError(
        'Unexpected response type: ${res.data.runtimeType}',
      ),
    };

    return CommentPage.fromMap(map);
  }

  /// Create a new comment for a post. RLS enforces that author_id == auth.uid().
  /// Returns the created CommentItem.
  Future<CommentItem> create({
    required String postId,
    required String content,
    String? parentCommentId,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw StateError('Not authenticated');
    }
    // Basic client-side validation. Server RLS + DB constraints still apply.
    final trimmed = content.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError.value(content, 'content', 'must not be empty');
    }
    if (trimmed.length > 1000) {
      throw ArgumentError.value(content, 'content', 'exceeds 1000 chars');
    }

    final insertPayload = <String, dynamic>{
      'post_id': postId,
      'author_id': user.id, // must match RLS
      'content': trimmed,
      if (parentCommentId != null) 'parent_comment_id': parentCommentId,
    };

    try {
      final resp = await _client
          .from('comments')
          .insert(insertPayload)
          .select(
            'id, post_id, author_id, content, parent_comment_id, created_at, updated_at',
          )
          .single();
      // resp is the inserted row as Map<String, dynamic>
      return CommentItem.fromMap(resp);
    } on PostgrestException catch (e) {
      throw StateError('Insert failed: ${e.message}');
    } catch (e) {
      rethrow;
    }
  }
}
