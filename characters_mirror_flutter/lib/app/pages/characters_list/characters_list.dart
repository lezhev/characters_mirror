import 'package:characters_mirror_flutter/app/auth/src/auth_provider.dart';
import 'package:characters_mirror_flutter/app/pages/characters_list/widgets/character_tile_view.dart';
import 'package:characters_mirror_flutter/app/widgets/authenticated_header.dart';
import 'package:characters_mirror_flutter/app/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

class CharactersList extends ConsumerWidget {
  const CharactersList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    if (authState.isChecking) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          AuthenticatedHeader(
            title: 'Список персонажей',
            trailing: _CharacterSheetsMenuButton(
              user: authState.user,
              showAdminAction: authState.hasScope('admin'),
            ),
          ),
          Expanded(
            child: PageSizeLimiter(
              maxWidth: 1120,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
                child: CharacterTileView(
                  onCreateCharacter: () => context.go('/create'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _CharacterSheetsMenuAction {
  admin,
  signOut,
}

class _CharacterSheetsMenuButton extends ConsumerWidget {
  const _CharacterSheetsMenuButton({
    required this.user,
    required this.showAdminAction,
  });

  final dynamic user;
  final bool showAdminAction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<_CharacterSheetsMenuAction>(
      onSelected: (action) => _handleAction(context, ref, action),
      itemBuilder: (context) => [
        PopupMenuItem<_CharacterSheetsMenuAction>(
          enabled: false,
          padding: EdgeInsets.zero,
          child: _AccountMenuHeader(user: user),
        ),
        const PopupMenuDivider(),
        if (showAdminAction)
          const PopupMenuItem<_CharacterSheetsMenuAction>(
            value: _CharacterSheetsMenuAction.admin,
            child: _AccountMenuItem(
              icon: Icons.admin_panel_settings_outlined,
              label: 'Админ',
            ),
          ),
        const PopupMenuItem<_CharacterSheetsMenuAction>(
          value: _CharacterSheetsMenuAction.signOut,
          child: _AccountMenuItem(
            icon: Icons.logout,
            label: 'Выйти',
          ),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: _AccountMenuAvatar(user: user),
      ),
    );
  }

  Future<void> _handleAction(
    BuildContext context,
    WidgetRef ref,
    _CharacterSheetsMenuAction action,
  ) async {
    switch (action) {
      case _CharacterSheetsMenuAction.admin:
        context.go('/admin');
        return;
      case _CharacterSheetsMenuAction.signOut:
        final messenger = ScaffoldMessenger.of(context);
        final result = await ref.read(authProvider.notifier).signOut();

        if (!context.mounted) {
          return;
        }

        messenger.showSnackBar(
          SnackBar(content: Text(result.message)),
        );

        if (result.success) {
          context.go('/sign-in');
        }
        return;
    }
  }
}

class _AccountMenuHeader extends StatelessWidget {
  const _AccountMenuHeader({required this.user});

  final dynamic user;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final email = (user?.email as String?)?.trim();

    return SizedBox(
      width: 240,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _AccountMenuAvatar(user: user),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayNameForUser(user),
                    style: textTheme.labelLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (email != null && email.isNotEmpty)
                    Text(
                      email,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.66),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountMenuAvatar extends StatelessWidget {
  const _AccountMenuAvatar({required this.user});

  final dynamic user;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: colorScheme.primary.withValues(alpha: 0.16),
          child: Text(
            initialsForUser(user),
            style: textTheme.labelLarge?.copyWith(
              color: colorScheme.primary,
            ),
          ),
        ),
        CircularUserImage(userInfo: user, size: 40),
      ],
    );
  }
}

class _AccountMenuItem extends StatelessWidget {
  const _AccountMenuItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 12),
        Text(label),
      ],
    );
  }
}
