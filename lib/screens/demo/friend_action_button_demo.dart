import 'package:flutter/material.dart';
import '../../widgets/friend_action_button.dart';

/// Demo screen showcasing the FriendActionButton widget
///
/// This screen demonstrates all friendship states and transitions:
/// - Add Friend
/// - Pending (outgoing)
/// - Pending (incoming)
/// - Accept/Decline
/// - Remove Friend
/// - Real-time updates
class FriendActionButtonDemo extends StatefulWidget {
  const FriendActionButtonDemo({super.key});

  @override
  State<FriendActionButtonDemo> createState() => _FriendActionButtonDemoState();
}

class _FriendActionButtonDemoState extends State<FriendActionButtonDemo> {
  final _otherUserIdController = TextEditingController();
  String? _selectedUserId;
  final List<_StateTransition> _stateLog = [];

  // Sample user IDs for testing (replace with real IDs from your database)
  final Map<String, String> _sampleUsers = {
    'Test User 1': 'a1b2c3d4-0000-0000-0000-000000000001',
    'Test User 2': 'a1b2c3d4-0000-0000-0000-000000000002',
    'Test User 3': 'a1b2c3d4-0000-0000-0000-000000000003',
  };

  @override
  void dispose() {
    _otherUserIdController.dispose();
    super.dispose();
  }

  void _onStateChanged(FriendState newState, dynamic friendship) {
    setState(() {
      _stateLog.insert(
        0,
        _StateTransition(
          timestamp: DateTime.now(),
          state: newState,
          friendshipId: friendship?.id,
        ),
      );

      // Keep only last 20 transitions
      if (_stateLog.length > 20) {
        _stateLog.removeLast();
      }
    });

    debugPrint('[DEMO] State changed to: $newState');
    if (friendship != null) {
      debugPrint('[DEMO] Friendship details: $friendship');
    }
  }

  Widget _buildUserSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Test User',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Sample users dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Quick Select',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              value: _selectedUserId,
              items: _sampleUsers.entries.map((entry) {
                return DropdownMenuItem(
                  value: entry.value,
                  child: Text(entry.key),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedUserId = value;
                  _otherUserIdController.text = value ?? '';
                  _stateLog.clear();
                });
              },
            ),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // Manual UUID input
            TextField(
              controller: _otherUserIdController,
              decoration: const InputDecoration(
                labelText: 'Or Enter User ID (UUID)',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                hintText: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
              ),
              onChanged: (value) {
                setState(() {
                  _selectedUserId = value.isNotEmpty ? value : null;
                  _stateLog.clear();
                });
              },
            ),

            const SizedBox(height: 12),

            if (_selectedUserId != null) ...[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Testing friendship with: ${_selectedUserId!.substring(0, 8)}...',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildButtonDemo() {
    if (_selectedUserId == null || _selectedUserId!.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.arrow_upward,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'Select a user above to test',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Friend Action Button',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Regular button
            Row(
              children: [
                const SizedBox(width: 80, child: Text('Regular:')),
                FriendActionButton(
                  key: ValueKey('regular_$_selectedUserId'),
                  otherUserId: _selectedUserId!,
                  onStateChanged: _onStateChanged,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Compact button
            Row(
              children: [
                const SizedBox(width: 80, child: Text('Compact:')),
                FriendActionButton(
                  key: ValueKey('compact_$_selectedUserId'),
                  otherUserId: _selectedUserId!,
                  compact: true,
                  onStateChanged: _onStateChanged,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateLog() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'State Transition Log',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_stateLog.isNotEmpty)
                  TextButton.icon(
                    onPressed: () => setState(() => _stateLog.clear()),
                    icon: const Icon(Icons.clear_all, size: 16),
                    label: const Text('Clear'),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            if (_stateLog.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    'No state changes yet',
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _stateLog.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final transition = _stateLog[index];
                  return ListTile(
                    dense: true,
                    leading: _getStateIcon(transition.state),
                    title: Text(
                      _getStateLabel(transition.state),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      '${_formatTime(transition.timestamp)}${transition.friendshipId != null ? ' • ${transition.friendshipId!.substring(0, 8)}...' : ''}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Icon _getStateIcon(FriendState state) {
    IconData iconData;
    Color? color;

    switch (state) {
      case FriendState.none:
        iconData = Icons.person_add;
        color = Colors.blue;
        break;
      case FriendState.pendingOutgoing:
        iconData = Icons.schedule;
        color = Colors.orange;
        break;
      case FriendState.pendingIncoming:
        iconData = Icons.notifications_active;
        color = Colors.purple;
        break;
      case FriendState.accepted:
        iconData = Icons.check_circle;
        color = Colors.green;
        break;
      case FriendState.blocked:
        iconData = Icons.block;
        color = Colors.red;
        break;
      case FriendState.loading:
        iconData = Icons.hourglass_empty;
        color = Colors.grey;
        break;
      case FriendState.error:
        iconData = Icons.error;
        color = Colors.red;
        break;
    }

    return Icon(iconData, size: 20, color: color);
  }

  String _getStateLabel(FriendState state) {
    switch (state) {
      case FriendState.none:
        return 'No Friendship';
      case FriendState.pendingOutgoing:
        return 'Pending (Outgoing)';
      case FriendState.pendingIncoming:
        return 'Pending (Incoming)';
      case FriendState.accepted:
        return 'Friends';
      case FriendState.blocked:
        return 'Blocked';
      case FriendState.loading:
        return 'Loading...';
      case FriendState.error:
        return 'Error';
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inSeconds < 60) {
      return '${diff.inSeconds}s ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friend Action Button Demo'),
        elevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Instructions
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'How to Test',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimaryContainer,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '1. Select a test user or enter a UUID\n'
                        '2. Click the button to send a friend request\n'
                        '3. Test on another device/account to accept/decline\n'
                        '4. Watch the state transition log update in real-time\n'
                        '5. Try removing friends after acceptance',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // User selector
              _buildUserSelector(),

              const SizedBox(height: 16),

              // Button demo
              _buildButtonDemo(),

              const SizedBox(height: 16),

              // State log
              _buildStateLog(),
            ],
          ),
        ),
      ),
    );
  }
}

class _StateTransition {
  final DateTime timestamp;
  final FriendState state;
  final String? friendshipId;

  _StateTransition({
    required this.timestamp,
    required this.state,
    this.friendshipId,
  });
}
