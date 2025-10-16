# Friend Requests - Debugging Guide

## Issue Fixed: Missing Success Messages & Button Not Responding

### Problem Description
- User couldn't see "Friend request sent!" message after clicking Add Friend
- Button press appeared to have no action (no loading state)
- Receiver didn't get notification on the other side

### Root Cause
The `ref.listen()` callback was incorrectly placed **inside** the `friendshipAsync.when()` data callback. This caused:
1. Listener being recreated on every widget rebuild
2. State changes not being caught properly
3. Success/error messages never displayed

### Solution Applied

#### Code Change Location
File: `lib/features/social/presentation/screens/placeholders/social_profile_screen.dart`

#### Before (Broken)
```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final friendshipAsync = ref.watch(friendshipStatusProvider(profile.id));
  
  return friendshipAsync.when(
    data: (friendship) {
      // ❌ Listener inside when() - gets recreated on rebuild
      ref.listen(friendRequestControllerProvider(profile.id), (prev, next) {
        // Show success/error messages
      });
      
      if (friendship == null) {
        return AddFriendButton();
      }
    },
  );
}
```

#### After (Fixed)
```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final friendshipAsync = ref.watch(friendshipStatusProvider(profile.id));
  final friendRequestState = ref.watch(friendRequestControllerProvider(profile.id));
  
  // ✅ Listener at widget level - persists across rebuilds
  ref.listen(friendRequestControllerProvider(profile.id), (prev, next) {
    next.whenOrNull(
      data: (message) {
        if (message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.green, // ✅ Visual feedback
            ),
          );
          ref.invalidate(friendshipStatusProvider(profile.id));
          ref.read(friendRequestControllerProvider(profile.id).notifier).reset();
        }
      },
      error: (error, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${error.toString()}'),
            backgroundColor: Colors.red, // ✅ Error feedback
          ),
        );
      },
    );
  });
  
  return friendshipAsync.when(
    data: (friendship) {
      if (friendship == null) {
        return AddFriendButton();
      }
    },
  );
}
```

## Testing Procedure

### Prerequisites
- Two authenticated accounts
- Both apps running (two simulators/devices)

### Step-by-Step Test

#### 1. Send Friend Request (Device A)
```
Action: Navigate to Device B's profile → Click [Add Friend]

Expected Console Output:
🔵 [ActionButtons] _sendFriendRequest called for profile: <friend-id>
🔵 [ActionButtons] Got controller, calling sendFriendRequest...
🔵 [Controller] ========== START sendFriendRequest ==========
🔍 [Controller] Current user ID: <your-id>
📤 [Controller] Attempting direct INSERT method...
✅ [Controller] Friend request sent successfully via INSERT!
🎉 [Controller] Setting state to success: "Friend request sent!"
🎉 [ActionButtons] Showing success message: Friend request sent!

Expected UI:
✅ Green SnackBar appears: "Friend request sent!"
✅ Button changes to: [Cancel Request] (gray outline)
✅ Loading indicator shows briefly during request
```

#### 2. Receive Notification (Device B)
```
Action: Navigate to Notifications tab

Expected UI:
✅ Red badge appears on 👥 icon showing "1"
✅ Badge is positioned top-right of icon
✅ Badge has white text on red circle background
```

#### 3. View Request (Device B)
```
Action: Click 👥 icon in Notifications screen

Expected Navigation:
✅ Navigates to Friend Requests screen
✅ Screen shows list of pending requests

Expected Request Card:
✅ Shows sender's avatar (or default user icon)
✅ Shows sender's display name
✅ Shows timestamp: "X minutes/hours ago"
✅ Shows optional message (if sent)
✅ Shows [Accept] button (green)
✅ Shows [Decline] button (red)
✅ Shows "View Profile" link
```

#### 4. Accept Request (Device B)
```
Action: Click [Accept] button

Expected Console Output:
🔵 Accepting friend request
✅ Friend request accepted successfully

Expected UI (Device B):
✅ Green SnackBar: "Friend request accepted!"
✅ Request card disappears from list
✅ Badge count decreases (or disappears if 0)
✅ Returns to empty state if no more requests

Expected UI (Device A):
✅ Button changes to: [Friends] (filled, primary color)
✅ Can now unfriend by clicking button
```

## Debug Console Markers

### Flow Markers
- 🔵 = Info/Flow tracking
- 🔍 = Inspection/Checking values
- 📤 = Outgoing request
- ⚠️ = Warning/Fallback
- ✅ = Success
- ❌ = Error
- 🎉 = User-visible success

### Key Log Points

#### Button Click
```
🔵 [ActionButtons] _sendFriendRequest called for profile: <id>
🔵 [ActionButtons] Profile display name: <name>
🔵 [ActionButtons] Got controller, calling sendFriendRequest...
```

#### Controller Processing
```
🔵 [Controller] ========== START sendFriendRequest ==========
🔵 [Controller] friendId: <id>
🔵 [Controller] Setting state to loading...
🔍 [Controller] Current user ID: <your-id>
```

#### Repository Insert
```
🔵 [FriendshipsRepo] sendFriendRequest called
🔍 [Auth Debug] Current user: <your-id>
🔍 [Auth Debug] Session exists: true
📤 [FriendshipsRepo] Inserting data: {user_id: ..., friend_id: ...}
```

#### Success Path
```
✅ [FriendshipsRepo] Friend request inserted successfully
✅ [Controller] Friend request sent successfully via INSERT!
🎉 [Controller] Setting state to success: "Friend request sent!"
✅ [ActionButtons] sendFriendRequest method completed
🎉 [ActionButtons] Showing success message: Friend request sent!
```

#### Fallback Path (if RLS fails)
```
⚠️ [Controller] Direct INSERT failed, trying RPC function...
⚠️ [Controller] Error was: <error>
🔵 [FriendshipsRepo] sendFriendRequestViaFunction called
✅ [FriendshipsRepo] Friend request sent via function
✅ [Controller] Friend request sent successfully via RPC function!
```

## Common Issues & Solutions

### Issue 1: Button Click Has No Effect
**Symptoms:**
- No console logs appear when clicking Add Friend
- Button doesn't show loading state

**Possible Causes:**
1. Controller provider not properly initialized
2. Button `onPressed` handler not called

**Debug Steps:**
```dart
// Add to button onPressed:
onPressed: () {
  print('🔵 BUTTON CLICKED!'); // If this doesn't appear, button is disabled
  _sendFriendRequest(context, ref);
}
```

**Solution:**
- Check `friendRequestState.isLoading` - button might be disabled
- Verify button isn't wrapped in `IgnorePointer` or similar

### Issue 2: No Success Message Appears
**Symptoms:**
- Console shows success logs
- No green SnackBar appears

**Possible Causes:**
1. `ref.listen()` placed inside `when()` block (this was the bug!)
2. Context is invalid when trying to show SnackBar

**Solution:**
- Ensure `ref.listen()` is at widget level, **before** `return` statement
- Check that `ScaffoldMessenger.of(context)` can find a Scaffold ancestor

### Issue 3: Receiver Doesn't See Request
**Symptoms:**
- Sender sees success message
- Receiver has no badge, no request in list

**Possible Causes:**
1. Database insert actually failed (check Supabase dashboard)
2. RLS policies blocking SELECT for receiver
3. Provider not refreshing on receiver side

**Debug Steps:**
1. Check Supabase Dashboard → Table Editor → friendships
   - Look for row with matching user_id/friend_id
   - Verify status = 'pending'
   
2. Check console on receiver device:
   ```
   Are there any PostgrestException errors?
   Do you see SELECT queries in logs?
   ```

3. Manually refresh receiver's Friend Requests screen:
   - Pull down to refresh
   - Check console for query logs

**Solution:**
- Verify RLS policies with `TO authenticated` clause:
  ```sql
  CREATE POLICY "Enable read for users" ON friendships
    FOR SELECT TO authenticated
    USING (auth.uid() = user_id OR auth.uid() = friend_id);
  ```

- Check that `create_friendship_request()` function exists:
  ```sql
  SELECT * FROM pg_proc WHERE proname = 'create_friendship_request';
  ```

### Issue 4: Badge Doesn't Update
**Symptoms:**
- Request visible in list
- Badge still shows "0" or wrong count

**Possible Causes:**
1. `pendingFriendRequestsCountProvider` not invalidated
2. Provider is cached

**Solution:**
```dart
// After accepting/declining, invalidate count:
ref.invalidate(pendingFriendRequestsCountProvider);
ref.invalidate(pendingFriendRequestsProvider);
```

### Issue 5: App Crashes on Button Click
**Symptoms:**
- App crashes immediately
- Error in console about null values or state

**Debug Steps:**
1. Check if user is authenticated:
   ```dart
   final user = Supabase.instance.client.auth.currentUser;
   print('Current user: ${user?.id}');
   ```

2. Check controller initialization:
   ```dart
   final controller = ref.read(friendRequestControllerProvider(profile.id).notifier);
   print('Controller initialized: ${controller != null}');
   ```

3. Look for null-safety issues in stack trace

## Verification Checklist

After applying fixes, verify:

- [ ] Clicking Add Friend shows loading indicator
- [ ] Console logs show complete flow (🔵 → ✅ → 🎉)
- [ ] Green SnackBar appears with "Friend request sent!"
- [ ] Button changes to [Cancel Request]
- [ ] Receiver sees red badge on 👥 icon
- [ ] Badge shows correct count (1, 2, 3...)
- [ ] Friend Requests screen shows request card
- [ ] Card shows avatar, name, timestamp
- [ ] [Accept] and [Decline] buttons work
- [ ] Badge updates after accepting/declining
- [ ] Database has correct rows in friendships table

## Additional Debugging Tips

### Enable Verbose Supabase Logging
```dart
// In main.dart
await Supabase.initialize(
  url: supabaseUrl,
  anonKey: supabaseAnonKey,
  debug: true, // ✅ Add this for SQL query logs
);
```

### Check Network Requests
```
flutter run --verbose
```

### Inspect Provider State
```dart
// Use Riverpod Inspector (if installed)
// Or add manual logging:
ref.listen(friendRequestControllerProvider(profile.id), (prev, next) {
  print('State changed from: $prev');
  print('State changed to: $next');
});
```

### Test RLS Policies in Supabase SQL Editor
```sql
-- Test as sender
SELECT * FROM friendships 
WHERE user_id = '<your-user-id>' 
  AND friend_id = '<friend-user-id>';

-- Test as receiver  
SELECT * FROM friendships
WHERE friend_id = '<your-user-id>'
  AND status = 'pending';
```

## Related Files

- `lib/features/social/presentation/screens/placeholders/social_profile_screen.dart` - Main button logic
- `lib/repositories/friendships_repo.dart` - Database operations
- `lib/features/social/presentation/screens/friend_requests_screen.dart` - Requests list
- `lib/features/social/presentation/screens/placeholders/notifications_screen.dart` - Badge display
- `supabase/migrations/20251013_fix_friendships_rls_v2.sql` - RLS policies
- `supabase/migrations/20251013_create_friendship_function.sql` - Fallback function

## Further Help

If issues persist after following this guide:

1. **Share console logs**: Copy full output from 🔵 START to 🔵 END markers
2. **Check Supabase logs**: Go to Supabase Dashboard → Logs → Database Logs
3. **Verify authentication**: Confirm both users are properly signed in
4. **Test with fresh accounts**: Sometimes cached state causes issues
5. **Try database function**: If INSERT keeps failing, RPC should work as fallback

## Changes Made (2024-10-14)

### Summary
Fixed missing success messages by moving `ref.listen()` from inside `when()` callback to widget level, preventing listener recreation on rebuilds.

### Files Modified
- `social_profile_screen.dart`: Moved listener, added colored SnackBars, enhanced debug logging

### Impact
- ✅ Success messages now display correctly
- ✅ Error messages show with red background
- ✅ Button states update properly
- ✅ Extensive logging for easier debugging
