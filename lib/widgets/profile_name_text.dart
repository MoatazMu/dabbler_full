import 'package:flutter/material.dart';
import '../services/public_users_api.dart';

/// Displays a user's display name fetched from the `/public-users` endpoint.
/// - Shows a customizable placeholder while loading or if no name is found.
/// - Safe fallback to avoid crashes on network errors.
/// - Allows passing custom text style and max lines.
class ProfileNameText extends StatelessWidget {
  final String userId;

  /// Placeholder text shown while loading or if name is empty.
  final String placeholder;

  /// Optional custom text style. Defaults to Theme.titleMedium.
  final TextStyle? style;

  /// Max lines for the text widget (defaults to 1 with ellipsis).
  final int maxLines;

  const ProfileNameText({
    super.key,
    required this.userId,
    this.placeholder = 'Add your name',
    this.style,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: PublicUsersApi.fetchDisplayNameById(userId),
      builder: (context, snap) {
        // While loading, render placeholder (keeps layout stable without spinners)
        if (snap.connectionState == ConnectionState.waiting) {
          return Text(
            placeholder,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: style ?? Theme.of(context).textTheme.titleMedium,
          );
        }

        // If any error occurred, gracefully fall back to placeholder
        if (snap.hasError) {
          return Text(
            placeholder,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: style ?? Theme.of(context).textTheme.titleMedium,
          );
        }

        final name = (snap.data ?? '').trim();
        return Text(
          name.isNotEmpty ? name : placeholder,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: style ?? Theme.of(context).textTheme.titleMedium,
        );
      },
    );
  }
}
