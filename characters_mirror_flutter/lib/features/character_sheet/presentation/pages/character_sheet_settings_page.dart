import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/settings/application/keep_screen_awake.dart';
import 'package:characters_mirror_flutter/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CharacterSheetSettingsPage extends ConsumerWidget {
  const CharacterSheetSettingsPage({
    required this.characterId,
    super.key,
  });

  final int characterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final character = ref.watch(characterSheetControllerProvider(characterId));
    final offlineRecord =
        ref.watch(offlineCharacterRecordProvider(characterId));
    final characterName = character.valueOrNull?.name?.trim();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки персонажа'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Назад',
          onPressed: () => context.go('/characters/sheet/$characterId'),
        ),
      ),
      body: PageSizeLimiter(
        maxWidth: 760,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          children: [
            const AppearanceSettingsSection(),
            if (isAndroidKeepScreenAwakeSupported) ...[
              const SizedBox(height: 24),
              const ScreenSettingsSection(),
            ],
            const SizedBox(height: 24),
            Text(
              'Настройки персонажа',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (characterName != null && characterName.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                characterName,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            const SizedBox(height: 12),
            CharacterSheetSettingsSection(
              characterId: characterId,
              offlineRecord: offlineRecord,
              showTitle: false,
            ),
          ],
        ),
      ),
    );
  }
}

class CharacterSheetSettingsSection extends StatelessWidget {
  const CharacterSheetSettingsSection({
    required this.characterId,
    required this.offlineRecord,
    this.showTitle = true,
    super.key,
  });

  final int characterId;
  final AsyncValue<OfflineCharacterRecord?> offlineRecord;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[
          Text(
            'Настройки персонажа',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
        ],
        AppSurfaceCard(
          padding: EdgeInsets.zero,
          border: Border.all(color: colorScheme.outline),
          child: offlineRecord.when(
            data: (record) => _SyncStatusSection(
              characterId: characterId,
              record: record,
            ),
            loading: () => const ListTile(
              leading: Icon(Icons.sync_outlined),
              title: Text('Проверяем синхронизацию'),
              subtitle: Text('Загружаем локальное состояние листа.'),
            ),
            error: (_, __) => const ListTile(
              leading: Icon(Icons.sync_problem_outlined),
              title: Text('Статус синхронизации недоступен'),
              subtitle: Text('Не удалось прочитать локальное состояние.'),
            ),
          ),
        ),
      ],
    );
  }
}

class _SyncStatusSection extends ConsumerWidget {
  const _SyncStatusSection({
    required this.characterId,
    required this.record,
  });

  final int characterId;
  final OfflineCharacterRecord? record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = _resolveSyncStatus(record);
    return ListTile(
      leading: Icon(status.icon),
      title: Text(status.title),
      subtitle: Text(status.description),
      trailing: IconButton(
        icon: const Icon(Icons.refresh),
        tooltip: 'Обновить статус',
        onPressed: () {
          ref.invalidate(offlineCharacterRecordProvider(characterId));
        },
      ),
    );
  }
}

_SyncStatusText _resolveSyncStatus(OfflineCharacterRecord? record) {
  if (record == null) {
    return const _SyncStatusText(
      icon: Icons.cloud_done_outlined,
      title: 'Синхронизировано',
      description: 'Лист персонажа совпадает с серверной версией.',
    );
  }

  if (record.status == OfflineCharacterSyncStatus.clean) {
    final error = record.lastSyncError;
    if (error != null && error.isNotEmpty) {
      return _SyncStatusText(
        icon: Icons.info_outline,
        title: 'Серверная версия новее',
        description: error,
      );
    }
    return const _SyncStatusText(
      icon: Icons.cloud_done_outlined,
      title: 'Синхронизировано',
      description: 'Лист персонажа совпадает с серверной версией.',
    );
  }

  if (record.status == OfflineCharacterSyncStatus.dirty) {
    final error = record.lastSyncError;
    return _SyncStatusText(
      icon: error == null ? Icons.cloud_upload_outlined : Icons.sync_problem,
      title: error == null
          ? 'Ожидает синхронизации'
          : 'Не удалось синхронизировать',
      description: error == null
          ? 'Изменения сохранены локально и будут отправлены на сервер при сети.'
          : 'Последняя ошибка: $error',
    );
  }

  if (record.status == OfflineCharacterSyncStatus.deleting) {
    final error = record.lastSyncError;
    return _SyncStatusText(
      icon: error == null ? Icons.delete_outline : Icons.sync_problem,
      title: error == null
          ? 'Удаление ожидает синхронизации'
          : 'Не удалось синхронизировать удаление',
      description: error == null
          ? 'Удаление сохранено локально и будет отправлено на сервер при сети.'
          : 'Последняя ошибка: $error',
    );
  }

  return _SyncStatusText(
    icon: Icons.info_outline,
    title: 'Серверная версия новее',
    description: record.lastSyncError ??
        'Локальное изменение не применено, потому что на сервере уже есть более свежая версия.',
  );
}

class _SyncStatusText {
  const _SyncStatusText({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}
