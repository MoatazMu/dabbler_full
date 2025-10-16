# FriendActionButton - Reusable Friendship Control Widget

## Overview

A production-ready, composable Flutter widget that handles all friendship states and transitions with real-time updates, optimistic UI, and comprehensive error handling.

## Features

✅ **Complete State Management**
- Add Friend (no friendship exists)
- Pending (outgoing - tap to cancel)
- Pending (incoming - accept/decline)
- Remove Friend (accepted friendships)
- Blocked state handling

✅ **Real-time Updates** via Supabase subscriptions
✅ **Optimistic UI** with rollback on error
✅ **Debounce Protection** against duplicate taps
✅ **Accessibility** compliant with semantic labels
✅ **Theme-aware** styling
✅ **Error Handling** with user-friendly SnackBar messages
✅ **Customizable** shape, style, and layout

## Files Created

### 1. `/lib/widgets/friend_action_button.dart` (600+ lines)

The main reusable widget with:
- `FriendState` enum (none, pendingOutgoing, pendingIncoming, accepted, blocked, loading, error)
- `FriendActionButton` stateful widget
- Private methods for each action:
  - `_loadFriendshipState()` - Initial query
  - `_addFriend()` - Send request
  - `_cancelRequest()` - Cancel outgoing request
  - `_acceptRequest()` - Accept incoming request
  - `_declineRequest()` - Decline incoming request
  - `_removeFriend()` - Unfriend with confirmation
- Real-time subscription management
- Optimistic updates with rollback
- Error handling with proper user feedback

### 2. `/lib/screens/demo/friend_action_button_demo.dart` (450+ lines)

Interactive demo screen with:
- User selector (dropdown + manual UUID input)
- Side-by-side button comparison (regular + compact)
- Live state transition log with timestamps
- Color-coded state icons
- Sample test user IDs
- Instructions and usage guide

### 3. `/test/widgets/friend_action_button_test.dart` (600+ lines)

Comprehensive integration tests covering:
- All four main states (none, pending outgoing, pending incoming, accepted)
- State transitions (add → pending → accepted → removed)
- Compact mode rendering
- Error handling and retry
- Callback invocation
- Button disabling during processing
- Edge cases (409 duplicate, blocked users)

## Usage

### Basic Usage

```dart
FriendActionButton(
  otherUserId: 'user-uuid-here',
  onStateChanged: (state, friendship) {
    print('State changed to: $state');
  },
)
```

### Compact Mode

```dart
FriendActionButton(
  otherUserId: 'user-uuid-here',
  compact: true, // Shows "Add" instead of "Add Friend"
)
```

### Custom Styling

```dart
FriendActionButton(
  otherUserId: 'user-uuid-here',
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  ),
)
```

### In a User Profile

```dart
class UserProfileScreen extends StatelessWidget {
  final String userId;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: Column(
        children: [
          // Avatar, name, bio, etc.
          SizedBox(height: 16),
          FriendActionButton(
            otherUserId: userId,
            onStateChanged: (state, friendship) {
              // Optionally refresh friend count, etc.
              if (state == FriendState.accepted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You are now friends!')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
```

### In a List (with virtualization hint)

```dart
ListView.builder(
  itemCount: users.length,
  itemBuilder: (context, index) {
    final user = users[index];
    return ListTile(
      title: Text(user.name),
      trailing: FriendActionButton(
        key: ValueKey('friend_${user.id}'),
        otherUserId: user.id,
        compact: true,
        // Optional: provide initial state to avoid flicker
        initialOverrideState: user.friendState,
      ),
    );
  },
)
```

## API Reference

### FriendActionButton Widget

#### Required Parameters
- `otherUserId`: String - The UUID of the other user (not current user)

#### Optional Parameters
- `compact`: bool (default: false) - Show compact labels
- `onStateChanged`: OnFriendStateChanged? - Callback when state changes
- `initialOverrideState`: FriendState? - Skip initial load (for lists)
- `shape`: OutlinedBorder? - Custom button shape
- `style`: ButtonStyle? - Custom button style
- `repositoryOverride`: FriendshipsRepo? - For testing only

### FriendState Enum

```dart
enum FriendState {
  none,              // No friendship - show Add Friend
  pendingOutgoing,   // Sent request - show Pending (tap to cancel)
  pendingIncoming,   // Received request - show Accept/Decline
  accepted,          // Friends - show Remove Friend
  blocked,           // Blocked - hide button
  loading,           // Loading initial state
  error,             // Error loading state
}
```

### OnFriendStateChanged Callback

```dart
typedef OnFriendStateChanged = void Function(
  FriendState newState,
  Friendships? friendship,
);
```

## Database Schema

The widget relies on the existing `friendships` table:

```sql
CREATE TABLE friendships (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id),
  friend_id UUID NOT NULL REFERENCES auth.users(id),
  status friendship_status NOT NULL, -- 'pending', 'accepted', 'blocked'
  initiated_by UUID NOT NULL REFERENCES auth.users(id),
  message TEXT,
  became_friends_at TIMESTAMPTZ,
  blocked_at TIMESTAMPTZ,
  blocked_by UUID,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, friend_id)
);
```

### RLS Policies (Already Implemented)

- Users can insert rows where `user_id = auth.uid()`
- Users can select rows where `user_id = auth.uid()` OR `friend_id = auth.uid()`
- Users can update rows where `user_id = auth.uid()`
- Users can delete rows where `user_id = auth.uid()`

### Triggers (Already Implemented)

1. **Reciprocal Row Management**: Automatically creates/updates/deletes the reciprocal friendship row
2. **Timestamps**: Sets `became_friends_at` when status changes to 'accepted'
3. **Notifications**: Sends notifications for friend requests, acceptances, etc.

## Real-time Updates

The widget subscribes to Supabase Realtime on the `friendships` table filtered by:
- `user_id = currentUserId` AND `friend_id = otherUserId`

Events handled:
- **INSERT**: New friendship created (by this or another device)
- **UPDATE**: Status changed (accepted, blocked, etc.)
- **DELETE**: Friendship removed

This ensures both users see updates instantly when either party makes a change.

## Error Handling

### Duplicate Insert (409)
When adding a friend that already exists (race condition or other device):
- Treated as success
- Reloads state from server
- No error shown to user

### Permission Errors
When RLS denies the action:
- Shows error SnackBar: "Couldn't [action]. Try again."
- Rolls back optimistic update
- Button returns to previous state

### Network Errors
When request fails due to connectivity:
- Shows error SnackBar
- Rolls back optimistic update
- User can retry

### State Reconciliation
If server state differs from expected (e.g., accepted on another device during action):
- Reloads current state
- Updates UI to match server
- No error shown (seamless reconciliation)

## Testing

### Running Tests

```bash
flutter test test/widgets/friend_action_button_test.dart
```

### Test Coverage

- ✅ State rendering for all 7 states
- ✅ State transitions between all valid paths
- ✅ Optimistic updates and rollbacks
- ✅ Error handling (network, permission, duplicate)
- ✅ Callback invocation
- ✅ Button disabling during processing
- ✅ Compact mode rendering
- ✅ Edge cases (409, blocked users)

### Manual Testing with Demo

```bash
# Run the app
flutter run

# Navigate to demo screen (add route to router)
context.push('/demo/friend-action-button');
```

Use the demo screen to:
1. Test with multiple user IDs
2. Observe state transitions in real-time
3. View the state log with timestamps
4. Test on multiple devices simultaneously

## Demo Screen Integration

Add to your router:

```dart
GoRoute(
  path: '/demo/friend-action-button',
  name: 'friend-action-button-demo',
  builder: (context, state) => const FriendActionButtonDemo(),
),
```

Or navigate directly:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const FriendActionButtonDemo(),
  ),
);
```

## Performance Considerations

### List Virtualization

When using in long lists:

```dart
// Provide initialOverrideState to skip load flicker
FriendActionButton(
  otherUserId: user.id,
  initialOverrideState: user.cachedFriendState, // From list data
  onStateChanged: (state, friendship) {
    // Update local cache
    user.cachedFriendState = state;
  },
)
```

### Real-time Subscriptions

Each button instance creates one Supabase Realtime channel. For lists with many users:
- Consider a single channel at screen level filtering all relevant friendships
- Pass state via provider/controller to individual buttons
- Use `initialOverrideState` to avoid N database queries

### Debouncing

Built-in 500ms debounce prevents:
- Accidental double-taps
- Rapid state cycling
- Multiple simultaneous requests

## Accessibility

- ✅ All buttons have semantic labels
- ✅ Minimum 48px tap targets (Material guidelines)
- ✅ Loading indicators for screen readers
- ✅ Color not sole indicator (icons + text)
- ✅ Error messages announced via SnackBar

## Future Enhancements

Potential additions:
- [ ] Block/unblock functionality
- [ ] Custom friend request messages
- [ ] Animation transitions between states
- [ ] Haptic feedback on state changes
- [ ] Friend list count badge
- [ ] Mutual friends indicator
- [ ] Undo action after decline/remove

## Troubleshooting

### Button not updating in real-time

**Check**:
1. Supabase Realtime enabled for `friendships` table
2. RLS policies allow SELECT for both `user_id` and `friend_id`
3. No errors in console about channel subscription

### "Couldn't add friend" error

**Check**:
1. RLS policy allows INSERT where `user_id = auth.uid()`
2. Current user is authenticated (`Supabase.instance.client.auth.currentUser != null`)
3. `otherUserId` is a valid UUID from your users table

### State stuck on "Loading"

**Check**:
1. Network connectivity
2. Supabase URL and anon key configured
3. RLS policies allow SELECT
4. Console for query errors

## License

This component is part of the Dabbler app codebase.

## Support

For issues or questions:
1. Check the demo screen for working examples
2. Review test cases for expected behavior
3. Enable debug logging with `kDebugMode` prints
