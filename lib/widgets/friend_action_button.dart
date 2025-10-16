import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../repositories/friendships_repo.dart';
import '../models/friendships.dart';

/// Enum representing the current friendship state
enum FriendState {
  /// No friendship exists - show "Add Friend"
  none,

  /// Pending request sent by current user - show "Pending (tap to cancel)"
  pendingOutgoing,

  /// Pending request received from other user - show "Accept/Decline"
  pendingIncoming,

  /// Friendship is accepted - show "Remove Friend"
  accepted,

  /// User is blocked - hide button or show blocked state
  blocked,

  /// Loading initial state
  loading,

  /// Error loading state
  error,
}

/// Callback when friendship state changes
typedef OnFriendStateChanged =
    void Function(FriendState newState, Friendships? friendship);

/// A reusable, composable widget that handles all friendship actions for a given user.
///
/// Supports:
/// - Add friend (no row exists)
/// - Pending outgoing (cancel request)
/// - Pending incoming (accept/decline)
/// - Accepted (remove friend)
/// - Real-time updates via Supabase subscriptions
/// - Optimistic UI with rollback on error
/// - Accessibility and theming
class FriendActionButton extends StatefulWidget {
  /// The user ID of the other person (not the current user)
  final String otherUserId;

  /// Whether to show a compact version of the button(s)
  final bool compact;

  /// Callback when the friendship state changes
  final OnFriendStateChanged? onStateChanged;

  /// Optional initial state override (useful for list virtualization to avoid flicker)
  final FriendState? initialOverrideState;

  /// Optional custom shape
  final OutlinedBorder? shape;

  /// Optional custom button style
  final ButtonStyle? style;

  /// Optional repository override (for testing)
  final FriendshipsRepo? repositoryOverride;

  const FriendActionButton({
    super.key,
    required this.otherUserId,
    this.compact = false,
    this.onStateChanged,
    this.initialOverrideState,
    this.shape,
    this.style,
    this.repositoryOverride,
  });

  @override
  State<FriendActionButton> createState() => _FriendActionButtonState();
}

class _FriendActionButtonState extends State<FriendActionButton> {
  late final FriendshipsRepo _repo;
  late final SupabaseClient _supabase;

  FriendState _state = FriendState.loading;
  Friendships? _friendship;
  bool _isProcessing = false;
  RealtimeChannel? _friendshipChannel;

  // Debouncing
  DateTime? _lastActionTime;
  static const _debounceDuration = Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    _supabase = Supabase.instance.client;
    _repo = widget.repositoryOverride ?? FriendshipsRepo(_supabase);

    if (widget.initialOverrideState != null) {
      _state = widget.initialOverrideState!;
    }

    _loadFriendshipState();
  }

  @override
  void dispose() {
    _friendshipChannel?.unsubscribe();
    _friendshipChannel = null;
    debugPrint('[FRIEND] unsubscribed');
    super.dispose();
  }

  String? get _currentUserId => _supabase.auth.currentUser?.id;

  /// Load the current friendship state from the database
  Future<void> _loadFriendshipState() async {
    final currentUserId = _currentUserId;
    if (currentUserId == null) {
      _setState(FriendState.error);
      return;
    }

    // Prevent concurrent loads
    if (_isProcessing) return;

    try {
      // Use the repository to get friendship status (returns FriendState directly)
      final friendState = await _repo.getFriendshipStatus(
        me: currentUserId,
        other: widget.otherUserId,
      );

      // Update state directly since getFriendshipStatus returns FriendState
      _setState(friendState, null);

      // Call _ensureSubscription after loading state
      _ensureSubscription();
    } catch (e) {
      debugPrint('[FRIEND] Error loading state: $e');
      _setState(FriendState.error);

      // Provide specific error messages for different types of issues
      String errorMessage = 'Failed to load friendship status';
      if (e.toString().contains('multiple (or no) rows returned')) {
        errorMessage = 'Database sync issue - please try again';
      } else if (e.toString().contains('406')) {
        errorMessage = 'Data conflict detected - refreshing...';
        // Auto-retry after a short delay for this specific error
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) _loadFriendshipState();
        });
      }

      _showError(errorMessage);
    }
  }

  /// Ensure subscription exists for this friendship pair
  void _ensureSubscription() {
    if (_friendshipChannel != null) return; // already subscribed
    final currentUserId = Supabase.instance.client.auth.currentUser?.id;
    final otherId = widget.otherUserId;
    if (currentUserId == null || otherId.isEmpty) return;

    final channelName = 'friendships:${[currentUserId, otherId]..sort()}';
    _friendshipChannel = Supabase.instance.client
        .channel(channelName)
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'friendships',
          callback: (payload) {
            debugPrint('[FRIEND] realtime event: ${payload.eventType}');
            _handleRealtimeChange(
              payload.eventType,
              payload.newRecord,
              payload.oldRecord,
            );
          },
        )
        .subscribe();
    debugPrint('[FRIEND] subscription created for $channelName');
  }

  /// Handle real-time updates from Supabase
  void _handleRealtimeChange(
    PostgresChangeEvent eventType,
    Map<String, dynamic>? newRecord,
    Map<String, dynamic>? oldRecord,
  ) {
    if (!mounted) return;

    try {
      final currentUserId = _currentUserId;
      if (currentUserId == null) return;

      // Handle DELETE events
      if (eventType == PostgresChangeEvent.delete) {
        if (oldRecord != null) {
          final deletedFriendship = Friendships.fromJson(oldRecord);
          // Check if this delete is for our user pair
          if ((deletedFriendship.user_id == currentUserId &&
                  deletedFriendship.friend_id == widget.otherUserId) ||
              (deletedFriendship.user_id == widget.otherUserId &&
                  deletedFriendship.friend_id == currentUserId)) {
            debugPrint('[FRIEND] friendship deleted via realtime');
            // Prevent redundant setState
            if (_state == FriendState.none) return;
            _friendship = null;
            setState(() => _state = FriendState.none);
            debugPrint('[FRIEND] state=none after realtime delete');
            widget.onStateChanged?.call(FriendState.none, null);
          }
        }
        return;
      }

      // Handle INSERT and UPDATE events
      if (newRecord == null) return;

      final friendship = Friendships.fromJson(newRecord);

      // Only process if this record is for our user pair
      if ((friendship.user_id != currentUserId &&
              friendship.friend_id != currentUserId) ||
          (friendship.user_id != widget.otherUserId &&
              friendship.friend_id != widget.otherUserId)) {
        return;
      }

      FriendState incomingStatus;
      if (friendship.status == 'blocked') {
        incomingStatus = FriendState.blocked;
      } else if (friendship.status == 'accepted') {
        incomingStatus = FriendState.accepted;
      } else if (friendship.status == 'pending') {
        if (friendship.initiated_by == currentUserId) {
          incomingStatus = FriendState.pendingOutgoing;
        } else {
          incomingStatus = FriendState.pendingIncoming;
        }
      } else {
        incomingStatus = FriendState.none;
      }

      // Prevent redundant setState
      if (incomingStatus == _state) return;

      _friendship = friendship;
      setState(() => _state = incomingStatus);
      debugPrint('[FRIEND] state=$_state after realtime sync');

      widget.onStateChanged?.call(_state, friendship);
    } catch (e) {
      debugPrint('[FRIEND] Error handling realtime update: $e');
    }
  }

  /// Update state and notify parent
  void _setState(FriendState newState, [Friendships? friendship]) {
    if (!mounted) return;

    setState(() {
      _state = newState;
      _friendship = friendship;
    });

    widget.onStateChanged?.call(newState, friendship);
  }

  /// Check if action should be debounced
  bool _shouldDebounce() {
    final now = DateTime.now();
    if (_lastActionTime != null) {
      final diff = now.difference(_lastActionTime!);
      if (diff < _debounceDuration) {
        return true;
      }
    }
    _lastActionTime = now;
    return false;
  }

  /// Refresh state from server with tiny backoff for realtime
  Future<void> _refreshFromServer() async {
    final currentUserId = _currentUserId;
    if (currentUserId == null) return;
    
    // Tiny backoff when waiting for realtime
    await Future.any([
      Future.delayed(const Duration(milliseconds: 400)),
      Future.delayed(const Duration(milliseconds: 250)),
    ]);
    
    final newState = await _repo.getFriendshipStatus(
      me: currentUserId,
      other: widget.otherUserId,
      forceNetwork: true,
    );
    
    debugPrint('[FRIEND-ACTION] refreshed state: $newState');
    _setState(newState);
  }

  /// Add friend (send friend request)
  Future<void> _addFriend() async {
    final shouldDebounce = _shouldDebounce();
    if (shouldDebounce) {
      debugPrint('[FRIEND-ACTION] debounce active for add');
      return;
    }
    if (_isProcessing) return;

    final currentUserId = _currentUserId;
    if (currentUserId == null) {
      _showError('You must be logged in');
      return;
    }

    setState(() => _isProcessing = true);

    // Optimistic update
    final previousState = _state;
    _setState(FriendState.pendingOutgoing);

    try {
      await _repo.sendFriendRequest(
        me: currentUserId,
        other: widget.otherUserId,
      );
      
      debugPrint('[FRIEND-ACTION] action=add result=success');
      
      // Always refetch after optimistic change
      await _refreshFromServer();
    } catch (e) {
      debugPrint('[FRIEND-ACTION] Error adding friend: $e');

      if (e is PostgrestException) {
        if (e.code == '42501') {
          // RLS policy violation - fallback to RPC that uses auth.uid()
          try {
            await _repo.sendFriendRequestViaFunction(
              friendId: widget.otherUserId,
            );
            debugPrint('[FRIEND-ACTION] action=add via RPC result=success');
            await _refreshFromServer();
            return;
          } catch (rpcErr) {
            debugPrint('[FRIEND-ACTION] RPC add failed: $rpcErr');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Permissions blocked by RLS')),
            );
            await _refreshFromServer(); // rollback UI
            return;
          }
        }
        if (e.code == '23505') {
          // Duplicate - treat as success
          debugPrint('[FRIEND-ACTION] duplicate -> treat as success');
          await _refreshFromServer();
          return;
        }
      }
      
      // Other errors - rollback
      _setState(previousState);
      _showError('Couldn\'t add friend. Try again.');
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  /// Cancel pending outgoing friend request
  Future<void> _cancelRequest() async {
    final shouldDebounce = _shouldDebounce();
    if (shouldDebounce) {
      debugPrint('[FRIEND-ACTION] debounce active for cancel');
      return;
    }
    if (_isProcessing) {
      debugPrint('[FRIEND-ACTION] cancel blocked - already processing');
      return;
    }

    final currentUserId = _currentUserId;
    if (currentUserId == null) return;

    setState(() => _isProcessing = true);

    // Optimistic update
    final previousState = _state;
    _setState(FriendState.none, null);

    try {
      await _repo.removeFriend(
        me: currentUserId,
        other: widget.otherUserId,
      );
      debugPrint('[FRIEND-ACTION] action=cancel result=success');

      // Always refetch after optimistic change
      await _refreshFromServer();
    } catch (e) {
      debugPrint('[FRIEND-ACTION] Error cancelling request: $e');

      if (e is PostgrestException) {
        if (e.code == '42501' || e.code == '42703') {
          // RLS or column-reference issues - try RPC fallback
          try {
            await _repo.removeFriendViaFunction(other: widget.otherUserId);
            debugPrint('[FRIEND-ACTION] action=cancel via RPC result=success');
            await _refreshFromServer();
            return;
          } catch (rpcErr) {
            debugPrint('[FRIEND-ACTION] RPC cancel failed: $rpcErr');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Permissions blocked by RLS')),
            );
            await _refreshFromServer();
            return;
          }
        }
      }

      // Rollback
      _setState(previousState);
      _showError('Couldn\'t cancel request. Try again.');
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  /// Accept incoming friend request
  Future<void> _acceptRequest() async {
    final shouldDebounce = _shouldDebounce();
    if (shouldDebounce) {
      debugPrint('[FRIEND-ACTION] debounce active for accept');
      return;
    }
    if (_isProcessing) return;

    final currentUserId = _currentUserId;
    if (currentUserId == null) return;

    setState(() => _isProcessing = true);

    // Optimistic update
    final previousState = _state;
    _setState(FriendState.accepted);

    try {
      await _repo.acceptFriend(
        recipient: currentUserId,
        requester: widget.otherUserId,
      );
      
      debugPrint('[FRIEND-ACTION] action=accept result=success');
      
      // Always refetch after optimistic change
      await _refreshFromServer();
    } catch (e) {
      debugPrint('[FRIEND-ACTION] Error accepting request: $e');

      if (e is PostgrestException) {
        if (e.code == '42501') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Permissions blocked by RLS')),
          );
          await _refreshFromServer();
          return;
        }
      }

      // Rollback
      _setState(previousState);
      _showError('Couldn\'t accept request. Try again.');
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  /// Decline incoming friend request
  Future<void> _declineRequest() async {
    final shouldDebounce = _shouldDebounce();
    if (shouldDebounce) {
      debugPrint('[FRIEND-ACTION] debounce active for decline');
      return;
    }
    if (_isProcessing) return;

    final currentUserId = _currentUserId;
    if (currentUserId == null) return;

    setState(() => _isProcessing = true);

    // Optimistic update
    final previousState = _state;
    _setState(FriendState.none, null);

    try {
      await _repo.removeFriend(
        me: currentUserId,
        other: widget.otherUserId,
      );
      debugPrint('[FRIEND-ACTION] action=decline result=success');
      
      // Always refetch after optimistic change
      await _refreshFromServer();
    } catch (e) {
      debugPrint('[FRIEND-ACTION] Error declining request: $e');

      if (e is PostgrestException) {
        if (e.code == '42501' || e.code == '42703') {
          // RLS or column-reference issues - try RPC fallback
          try {
            await _repo.removeFriendViaFunction(other: widget.otherUserId);
            debugPrint('[FRIEND-ACTION] action=decline via RPC result=success');
            await _refreshFromServer();
            return;
          } catch (rpcErr) {
            debugPrint('[FRIEND-ACTION] RPC decline failed: $rpcErr');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Permissions blocked by RLS')),
            );
            await _refreshFromServer();
            return;
          }
        }
      }

      // Rollback
      _setState(previousState);
      _showError('Couldn\'t decline request. Try again.');
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  /// Remove friend (unfriend)
  Future<void> _removeFriend() async {
    // Do not debounce removals; rely on processing guard + confirmation
    if (_isProcessing) return;

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Friend'),
        content: const Text('Are you sure you want to remove this friend?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Remove',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );

  if (confirmed != true) return;

    final currentUserId = Supabase.instance.client.auth.currentUser?.id;
    if (currentUserId == null) return;

    setState(() => _isProcessing = true);

    // Optimistic update
  final previousState = _state;
  final previousFriendship = _friendship;
    _setState(FriendState.none, null);

    try {
      await _repo.removeFriend(me: currentUserId, other: widget.otherUserId);
      debugPrint('[FRIEND-ACTION] action=remove result=success');
      
      // Refresh from server
      await _loadFriendshipState();
    } catch (e) {
      debugPrint('[FRIEND-ACTION] Error removing friend: $e');

      // Enhanced error handling for PostgrestException
      if (e is PostgrestException) {
        // Handle RLS or column issues with RPC fallback
        if (e.code == '42703' || e.code == '42501') {
          try {
            await _repo.removeFriendViaFunction(other: widget.otherUserId);
            debugPrint('[FRIEND-ACTION] action=remove via RPC result=success');
            await _loadFriendshipState();
            return;
          } catch (rpcErr) {
            debugPrint('[FRIEND-ACTION] RPC remove failed: $rpcErr');
          }
        }
        // Handle other specific codes as needed
      }

      // Rollback on any error
      _setState(previousState, previousFriendship);
      _showError('Couldn\'t remove friend. Try again.');
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  /// Show error message via SnackBar
  void _showError(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Loading state
    if (_state == FriendState.loading) {
      return SizedBox(
        height: widget.compact ? 32 : 40,
        width: widget.compact ? 32 : 40,
        child: const Center(
          child: SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    // Error state
    if (_state == FriendState.error) {
      return IconButton(
        icon: const Icon(Icons.error_outline),
        tooltip: 'Error loading friendship status',
        onPressed: _loadFriendshipState,
        color: colorScheme.error,
      );
    }

    // Blocked state - hide button
    if (_state == FriendState.blocked) {
      return const SizedBox.shrink();
    }

    // Processing indicator
    Widget? processingIndicator = _isProcessing
        ? const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : null;

    switch (_state) {
      case FriendState.none:
        // Add Friend button
        return ElevatedButton.icon(
          onPressed: _isProcessing ? null : _addFriend,
          icon: processingIndicator ?? const Icon(Icons.person_add, size: 18),
          label: Text(widget.compact ? 'Add' : 'Add Friend'),
          style:
              widget.style ??
              ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                shape: widget.shape,
              ),
        );

      case FriendState.pendingOutgoing:
        // Pending (tap to cancel) button
        return OutlinedButton.icon(
          onPressed: _isProcessing ? null : _cancelRequest,
          icon: processingIndicator ?? const Icon(Icons.schedule, size: 18),
          label: Text(widget.compact ? 'Pending' : 'Pending (tap to cancel)'),
          style:
              widget.style ??
              OutlinedButton.styleFrom(
                foregroundColor: colorScheme.primary,
                side: BorderSide(color: colorScheme.primary),
                shape: widget.shape,
              ),
        );

      case FriendState.pendingIncoming:
        // Accept and Decline buttons side by side
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: _isProcessing ? null : _acceptRequest,
              icon: processingIndicator ?? const Icon(Icons.check, size: 18),
              label: const Text('Accept'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                shape: widget.shape,
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: _isProcessing ? null : _declineRequest,
              icon: const Icon(Icons.close, size: 18),
              label: const Text('Decline'),
              style: OutlinedButton.styleFrom(
                foregroundColor: colorScheme.error,
                side: BorderSide(color: colorScheme.error),
                shape: widget.shape,
              ),
            ),
          ],
        );

      case FriendState.accepted:
        // Remove Friend button
        return TextButton.icon(
          onPressed: _isProcessing ? null : _removeFriend,
          icon:
              processingIndicator ?? const Icon(Icons.person_remove, size: 18),
          label: Text(widget.compact ? 'Remove' : 'Remove Friend'),
          style:
              widget.style ??
              TextButton.styleFrom(
                foregroundColor: colorScheme.error,
                shape: widget.shape,
              ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
