import 'package:characters_mirror_flutter/core/offline/offline_services.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          leading: CircularUserImage(
            userInfo: sessionManager.signedInUser,
            size: 42,
          ),
          title: Text(sessionManager.signedInUser!.userName ?? ''),
          subtitle: Text(sessionManager.signedInUser!.email ?? ''),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () async {
              final repository = CharacterRepository();
              final offlineUserId = currentOfflineUserId();
              if (await repository.hasUnsyncedChanges()) {
                if (!context.mounted) return;
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Есть несинхронизированные изменения'),
                    content: const Text(
                      'При выходе локальный кэш персонажей и очередь синхронизации будут очищены.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Отмена'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Выйти'),
                      ),
                    ],
                  ),
                );
                if (confirmed != true) return;
              }
              final success = await sessionManager.signOutDevice();
              if (success && offlineUserId != null) {
                await repository.clearLocalUserCacheForUser(offlineUserId);
              }
            },
            child: const Text('Sign out'),
          ),
        ),
      ],
    );
  }
}
