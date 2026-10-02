import 'package:characters_mirror_flutter/features/auth/application/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as auth;

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    required this.user,
    this.size = 40,
    super.key,
  });

  final auth.UserInfo? user;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final imageUrl = userWithReachableImageUrl(user)?.imageUrl?.trim();
    final fallback = _UserAvatarFallback(
      user: user,
      size: size,
      colorScheme: colorScheme,
      textTheme: textTheme,
    );

    return SizedBox.square(
      dimension: size,
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        color: colorScheme.surfaceContainerHigh,
        child: imageUrl == null || imageUrl.isEmpty
            ? fallback
            : Image.network(
                imageUrl,
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => fallback,
              ),
      ),
    );
  }
}

class _UserAvatarFallback extends StatelessWidget {
  const _UserAvatarFallback({
    required this.user,
    required this.size,
    required this.colorScheme,
    required this.textTheme,
  });

  final auth.UserInfo? user;
  final double size;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        initialsForUser(user),
        style: textTheme.labelLarge?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontSize: size * 0.38,
        ),
      ),
    );
  }
}
