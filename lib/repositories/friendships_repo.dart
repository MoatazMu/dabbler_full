// GENERATED repository stubs for table: friendships
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/friendships.dart';
import '../widgets/friend_action_button.dart';

class FriendshipsRepo {
  final SupabaseClient _db;
  FriendshipsRepo(this._db);

  Future<List<Friendships>> list({int limit = 50, int offset = 0}) async {
    if (kDebugMode) {
      print('[FRIEND-REPO] list() - select: limit=$limit, offset=$offset');
    }

    final res = await _db
        .from('friendships')
        .select(
          'id,user_id,friend_id,status,initiated_by,became_friends_at,blocked_at,blocked_by,message,created_at,updated_at',
        )
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);

    final rows = (res as List).cast<Map<String, dynamic>>();

    if (kDebugMode) {
      print('[FRIEND-REPO] list() - fetched ${rows.length} rows');
    }

    // Defensively map rows, collecting failures
    final items = <Friendships>[];
    Exception? firstError;

    for (var i = 0; i < rows.length; i++) {
      try {
        final item = Friendships.fromJson(rows[i]);
        items.add(item);
      } catch (e) {
        if (kDebugMode) {
          print('[FRIENDSHIP-REPO] list() - failed to map row $i: $e');
          print('[FRIENDSHIP-REPO] list() - raw row: ${rows[i]}');
        }
        // Capture first error but continue processing
        firstError ??= Exception('Failed to map friendship at index $i: $e');
      }
    }

    // If we got at least some items, return them; otherwise throw first error
    if (items.isNotEmpty || firstError == null) {
      return items;
    } else {
      throw firstError;
    }
  }

  Future<Friendships?> getById(dynamic id) async {
    if (kDebugMode) {
      print('[FRIEND-REPO] getById() - select: id=$id');
    }

    final res = await _db
        .from('friendships')
        .select(
          'id,user_id,friend_id,status,initiated_by,became_friends_at,blocked_at,blocked_by,message,created_at,updated_at',
        )
        .eq('id', id)
        .maybeSingle();

    if (res == null) {
      if (kDebugMode) {
        print('[FRIEND-REPO] getById() - not found: id=$id');
      }
      return null;
    }

    try {
      return Friendships.fromJson(res);
    } catch (e) {
      if (kDebugMode) {
        print('[FRIENDSHIP-REPO] getById() - failed to map: $e');
        print('[FRIENDSHIP-REPO] getById() - raw row: $res');
      }
      rethrow;
    }
  }

  /// Status fetch: always select the most recent row; if none → none
  Future<FriendState> getFriendshipStatus({required String me, required String other, bool forceNetwork = false}) async {
    print('[FRIEND-REPO] getFriendshipStatus() - $me <-> $other');
    final res = await _db.from('friendships')
      .select('user_id,friend_id,status,initiated_by,updated_at,became_friends_at')
      .or('and(user_id.eq.$me,friend_id.eq.$other),and(user_id.eq.$other,friend_id.eq.$me)')
      .order('updated_at', ascending: false)
      .limit(1)
      .maybeSingle();
    if (res == null) return FriendState.none;
    final status = (res['status'] as String);
    if (status == 'pending') {
      return (res['user_id'] == me) ? FriendState.pendingOutgoing : FriendState.pendingIncoming;
    }
    if (status == 'accepted') return FriendState.accepted;
    return FriendState.none;
  }

  /// Get friendship record between two users
  Future<Friendships?> getFriendshipRecord({required String me, required String other}) async {
    print('[FRIEND-REPO] getFriendshipRecord() - $me <-> $other');
    final res = await _db.from('friendships')
      .select('id,user_id,friend_id,status,initiated_by,became_friends_at,blocked_at,blocked_by,message,created_at,updated_at')
      .or('and(user_id.eq.$me,friend_id.eq.$other),and(user_id.eq.$other,friend_id.eq.$me)')
      .order('updated_at', ascending: false)
      .limit(1)
      .maybeSingle();
    
    if (res == null) return null;
    
    try {
      return Friendships.fromJson(res);
    } catch (e) {
      if (kDebugMode) {
        print('[FRIENDSHIP-REPO] getFriendshipRecord() - failed to map: $e');
        print('[FRIENDSHIP-REPO] getFriendshipRecord() - raw row: $res');
      }
      rethrow;
    }
  }

  /// Get pending friend requests received by the current user
  Future<List<Friendships>> getPendingFriendRequests(String userId) async {
    if (kDebugMode) {
      print(
        '[FRIEND-REPO] getPendingFriendRequests() - select: userId=$userId',
      );
    }

    final res = await _db
        .from('friendships')
        .select(
          'id,user_id,friend_id,status,initiated_by,became_friends_at,blocked_at,blocked_by,message,created_at,updated_at',
        )
        .eq('friend_id', userId)
        .eq('status', 'pending')
        .order('created_at', ascending: false);

    final rows = (res as List).cast<Map<String, dynamic>>();

    if (kDebugMode) {
      print(
        '[FRIEND-REPO] getPendingFriendRequests() - fetched ${rows.length} pending requests',
      );
    }
    final items = <Friendships>[];
    Exception? firstError;

    // Defensive mapping - collect failures but don't crash entire query
    for (int i = 0; i < rows.length; i++) {
      try {
        final item = Friendships.fromJson(rows[i]);
        items.add(item);
      } catch (e) {
        if (kDebugMode) {
          print(
            '[FRIENDSHIP-REPO] getPendingFriendRequests() - failed to map row $i: $e',
          );
          print(
            '[FRIENDSHIP-REPO] getPendingFriendRequests() - raw row: ${rows[i]}',
          );
        }
        firstError ??= Exception('Failed to map friendship at index $i: $e');
      }
    }

    // If nothing succeeded, throw the first error
    if (items.isEmpty && firstError != null) {
      throw firstError;
    }

    return items;
  }

  /// Get count of pending friend requests
  Future<int> getPendingFriendRequestsCount(String userId) async {
    if (kDebugMode) {
      print(
        '[FRIEND-REPO] getPendingFriendRequestsCount() - count: userId=$userId',
      );
    }

    // Use count() with head mode - fetches only count, not data
    final response = await _db
        .from('friendships')
        .select('id')
        .eq('friend_id', userId)
        .eq('status', 'pending')
        .count(CountOption.exact);

    final count = response.count;

    if (kDebugMode) {
      print(
        '[FRIEND-REPO] getPendingFriendRequestsCount() - result: $count pending requests',
      );
    }

    return count;
  }

  /// Send a friend request - treat duplicates as success and then refetch status
  Future<void> sendFriendRequest({required String me, required String other}) async {
    print('[FRIEND-REPO] sendFriendRequest() - $me -> $other');
    try {
      await _db.from('friendships').insert({
        'user_id': me,
        'friend_id': other,
        'status': 'pending',
        'initiated_by': me,
        'created_at': DateTime.now().toUtc().toIso8601String(),
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      });
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        print('[FRIEND-REPO] duplicate insert -> treat as pending');
      } else {
        rethrow;
      }
    }
    await Future.delayed(const Duration(milliseconds: 120)); // let trigger mirror
    await getFriendshipStatus(me: me, other: other, forceNetwork: true);
  }

  /// Accept: only recipient performs, then refetch
  Future<void> acceptFriend({required String recipient, required String requester}) async {
    print('[FRIEND-REPO] acceptFriend() - $recipient accepts $requester');
    try {
      await _db.from('friendships')
        .update({
          'status': 'accepted',
          'became_friends_at': DateTime.now().toUtc().toIso8601String(),
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        })
        .match({'user_id': requester, 'friend_id': recipient, 'status': 'pending'});
    } on PostgrestException catch (e) {
      // Fallback if RLS or trigger-side effects block the update (e.g., user_achievements policies)
      print('[FRIEND-REPO] acceptFriend() - direct update failed (${e.code}): ${e.message} -> trying RPC accept_friendship_between');
      await _db.rpc('accept_friendship_between', params: {
        'p_requester': requester,
      });
    }
    await Future.delayed(const Duration(milliseconds: 120));
    await getFriendshipStatus(me: recipient, other: requester, forceNetwork: true);
  }

  /// Accept friend request by ID
  Future<void> acceptFriendById(String friendshipId) async {
    print('[FRIEND-REPO] acceptFriendById() - friendshipId=$friendshipId');
    try {
      await _db.from('friendships')
        .update({
          'status': 'accepted',
          'became_friends_at': DateTime.now().toUtc().toIso8601String(),
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', friendshipId)
        .eq('status', 'pending');
      print('[FRIEND-REPO] acceptFriendById() - accepted friendship: $friendshipId');
    } on PostgrestException catch (e) {
      print('[FRIEND-REPO] acceptFriendById() - direct update failed (${e.code}): ${e.message} -> trying RPC accept_friendship_by_id');
      await _db.rpc('accept_friendship_by_id', params: {
        'p_friendship_id': friendshipId,
      });
    }
  }

  /// Reject a friend request
  Future<void> rejectFriendRequest(String friendshipId) async {
    if (kDebugMode) {
      print(
        '[FRIEND-REPO] rejectFriendRequest() - update: friendshipId=$friendshipId',
      );
    }

    await _db
        .from('friendships')
        .update({'status': 'rejected'})
        .eq('id', friendshipId);

    if (kDebugMode) {
      print(
        '[FRIEND-REPO] rejectFriendRequest() - updated: friendshipId=$friendshipId',
      );
    }
  }

  /// Send friend request using database function (bypasses RLS)
  /// Use this if direct INSERT keeps failing due to RLS issues
  Future<Friendships> sendFriendRequestViaFunction({
    required String friendId,
    String? message,
  }) async {
    final res = await _db.rpc(
      'create_friendship_request',
      params: {'p_friend_id': friendId, 'p_message': message},
    );

    return Friendships.fromJson(res);
  }

  /// Remove/unfriend - Delete should remove both rows in one call
  Future<void> removeFriend({required String me, required String other}) async {
    print('[FRIEND-REPO] removeFriend() - delete both directions: $me <-> $other');
    final res = await _db.from('friendships')
      .delete()
      .or('and(user_id.eq.$me,friend_id.eq.$other),and(user_id.eq.$other,friend_id.eq.$me)')
      .select('id'); // force execution + get count
    print('[FRIEND-REPO] removeFriend() - deleted rows: ${res.length}');
  }

  /// Remove/unfriend via a Postgres function (SECURITY DEFINER) to bypass RLS mismatch
  Future<void> removeFriendViaFunction({required String other}) async {
    print('[FRIEND-REPO] removeFriendViaFunction() - other: $other');
    await _db.rpc('delete_friendship_between', params: {
      'p_other': other,
    });
  }

  /// Remove friendship by ID
  Future<void> removeFriendById(String friendshipId) async {
    print('[FRIEND-REPO] removeFriendById() - delete: friendshipId=$friendshipId');
    await _db.from('friendships')
      .delete()
      .eq('id', friendshipId);
    print('[FRIEND-REPO] removeFriendById() - deleted friendship: $friendshipId');
  }

  /// Clean up duplicate friendships between two users
  /// Keeps the most recent record and removes older duplicates
  Future<void> cleanupDuplicateFriendships(
    String userId,
    String friendId,
  ) async {
    if (kDebugMode) {
      print(
        '[FRIEND-REPO] cleanupDuplicateFriendships() - start: userId=$userId, friendId=$friendId',
      );
    }

    final allRows = await _db
        .from('friendships')
        .select('id,user_id,friend_id,status,updated_at')
        .or(
          'and(user_id.eq.$userId,friend_id.eq.$friendId),and(user_id.eq.$friendId,friend_id.eq.$userId)',
        )
        .order('updated_at', ascending: false);

    if (allRows.length <= 1) {
      if (kDebugMode) {
        print(
          '[FRIEND-REPO] cleanupDuplicateFriendships() - no duplicates found',
        );
      }
      return;
    }

    // Keep the most recent record (first in the ordered list)
    final keepId = allRows.first['id'];
    final duplicateIds = allRows.skip(1).map((row) => row['id']).toList();

    if (kDebugMode) {
      print(
        '[FRIEND-REPO] cleanupDuplicateFriendships() - keeping $keepId, removing ${duplicateIds.length} duplicates',
      );
    }

    // Remove duplicates
    for (final duplicateId in duplicateIds) {
      await _db.from('friendships').delete().eq('id', duplicateId);
      if (kDebugMode) {
        print(
          '[FRIEND-REPO] cleanupDuplicateFriendships() - removed duplicate: $duplicateId',
        );
      }
    }

    if (kDebugMode) {
      print('[FRIEND-REPO] cleanupDuplicateFriendships() - cleanup complete');
    }
  }

  /// Block a user
  Future<void> blockUser(String friendshipId, String blockedBy) async {
    if (kDebugMode) {
      print(
        '[FRIEND-REPO] blockUser() - update: friendshipId=$friendshipId, blockedBy=$blockedBy',
      );
    }

    await _db
        .from('friendships')
        .update({
          'status': 'blocked',
          'blocked_at': DateTime.now().toIso8601String(),
          'blocked_by': blockedBy,
        })
        .eq('id', friendshipId);

    if (kDebugMode) {
      print('[FRIEND-REPO] blockUser() - updated: friendshipId=$friendshipId');
    }
  }
}
