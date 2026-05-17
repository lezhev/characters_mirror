import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/core/offline/offline_services.dart';
import 'package:characters_mirror_flutter/features/settings/application/keep_screen_awake.dart';
import 'package:characters_mirror_flutter/features/settings/application/server_connection_status_provider.dart';
import 'package:characters_mirror_flutter/features/settings/application/user_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Назад',
          onPressed: () {
            if (context.canPop()) {
              context.pop();
              return;
            }
            context.go('/characters');
          },
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
              'Режим работы',
              style: textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            AppSurfaceCard(
              padding: EdgeInsets.zero,
              border: Border.all(color: colorScheme.outline),
              child: const _AppModeSection(),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenSettingsSection extends ConsumerWidget {
  const ScreenSettingsSection({
    this.titleStyle,
    super.key,
  });

  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!isAndroidKeepScreenAwakeSupported) {
      return const SizedBox.shrink();
    }

    final settings = ref.watch(userSettingsControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Экран',
          style: titleStyle ?? Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        AppSurfaceCard(
          padding: EdgeInsets.zero,
          border: Border.all(color: colorScheme.outline),
          child: settings.when(
            data: (value) => SwitchListTile(
              secondary: const Icon(Icons.screen_lock_portrait_outlined),
              title: const Text('Не гасить экран'),
              subtitle: const Text(
                'Пока приложение открыто, Android не будет выключать экран.',
              ),
              value: value.keepScreenAwake,
              onChanged: (enabled) => _setKeepScreenAwake(
                context,
                ref,
                enabled,
              ),
            ),
            loading: () => const Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => _SettingsError(
              onRetry: () => ref.invalidate(userSettingsControllerProvider),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _setKeepScreenAwake(
    BuildContext context,
    WidgetRef ref,
    bool enabled,
  ) async {
    final messenger = ScaffoldMessenger.of(context);

    try {
      await ref
          .read(userSettingsControllerProvider.notifier)
          .setKeepScreenAwake(enabled);
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Не удалось сохранить настройки. Попробуйте ещё раз.'),
        ),
      );
    }
  }
}

class AppearanceSettingsSection extends ConsumerWidget {
  const AppearanceSettingsSection({
    this.titleStyle,
    super.key,
  });

  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(userSettingsControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Внешний вид',
          style: titleStyle ?? Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        AppSurfaceCard(
          padding: EdgeInsets.zero,
          border: Border.all(color: colorScheme.outline),
          child: settings.when(
            data: (value) => _ThemeModeSection(
              themeMode: value.themeMode,
              onChanged: (themeMode) => _setThemeMode(
                context,
                ref,
                themeMode,
              ),
            ),
            loading: () => const Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => _SettingsError(
              onRetry: () => ref.invalidate(userSettingsControllerProvider),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _setThemeMode(
    BuildContext context,
    WidgetRef ref,
    ThemeMode themeMode,
  ) async {
    final messenger = ScaffoldMessenger.of(context);

    try {
      await ref
          .read(userSettingsControllerProvider.notifier)
          .setThemeMode(themeMode);
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Не удалось сохранить настройки. Попробуйте ещё раз.'),
        ),
      );
    }
  }
}

class _AppModeSection extends ConsumerWidget {
  const _AppModeSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(serverConnectionStatusProvider);
    final mode = status.when(
      data: _resolveAppModeText,
      loading: () => const _AppModeText(
        icon: Icons.sync_outlined,
        title: 'Проверяем соединение',
        description: 'Проверяем доступность сервера.',
      ),
      error: (_, __) => _resolveAppModeText(ServerConnectionStatus.offline),
    );

    return ListTile(
      leading: Icon(mode.icon),
      title: Text(mode.title),
      subtitle: Text(mode.description),
      trailing: IconButton(
        icon: const Icon(Icons.refresh),
        tooltip: 'Проверить снова',
        onPressed: () {
          ref.invalidate(serverConnectionStatusProvider);
        },
      ),
    );
  }

  _AppModeText _resolveAppModeText(ServerConnectionStatus status) {
    final isOnline = status == ServerConnectionStatus.online;
    if (!isAndroidOfflineCacheEnabled) {
      return _AppModeText(
        icon: isOnline ? Icons.cloud_done_outlined : Icons.cloud_off_outlined,
        title: isOnline ? 'Онлайн' : 'Оффлайн',
        description: isOnline
            ? 'Сервер доступен.'
            : 'Сервер недоступен. Проверьте соединение.',
      );
    }

    if (offlineCacheDatabase == null) {
      return _AppModeText(
        icon: isOnline ? Icons.cloud_done_outlined : Icons.cloud_off_outlined,
        title: isOnline ? 'Онлайн' : 'Оффлайн',
        description: isOnline
            ? 'Сервер доступен. Android-кэш ещё не инициализирован.'
            : 'Сервер недоступен. Android-кэш ещё не инициализирован.',
      );
    }

    if (currentOfflineUserId() == null) {
      return _AppModeText(
        icon: isOnline ? Icons.cloud_done_outlined : Icons.cloud_off_outlined,
        title: isOnline ? 'Онлайн' : 'Оффлайн',
        description: isOnline
            ? 'Сервер доступен. Войдите в аккаунт, чтобы включить синхронизацию.'
            : 'Сервер недоступен. Войдите в аккаунт, чтобы читать сохранённые данные без сети.',
      );
    }

    return _AppModeText(
      icon: isOnline ? Icons.cloud_done_outlined : Icons.cloud_off_outlined,
      title: isOnline ? 'Онлайн' : 'Оффлайн',
      description: isOnline
          ? 'Сервер доступен. Android-кэш включён, изменения синхронизируются.'
          : 'Сервер недоступен. Доступны сохранённые данные Android-кэша.',
    );
  }
}

class _AppModeText {
  const _AppModeText({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

class _ThemeModeSection extends StatelessWidget {
  const _ThemeModeSection({
    required this.themeMode,
    required this.onChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<ThemeMode>(
      groupValue: themeMode,
      onChanged: _handleChanged,
      child: const Column(
        children: [
          RadioListTile<ThemeMode>(
            title: Text('Как в системе'),
            subtitle: Text('Следовать настройке устройства'),
            value: ThemeMode.system,
          ),
          Divider(height: 1),
          RadioListTile<ThemeMode>(
            title: Text('Тёмная'),
            subtitle: Text('Тёплая тёмная тема листа персонажа'),
            value: ThemeMode.dark,
          ),
          Divider(height: 1),
          RadioListTile<ThemeMode>(
            title: Text('Светлая'),
            subtitle: Text('Контрастная пергаментная тема'),
            value: ThemeMode.light,
          ),
        ],
      ),
    );
  }

  void _handleChanged(ThemeMode? value) {
    if (value == null || value == themeMode) {
      return;
    }
    onChanged(value);
  }
}

class _SettingsError extends StatelessWidget {
  const _SettingsError({
    required this.onRetry,
  });

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            color: colorScheme.error,
            size: 40,
          ),
          const SizedBox(height: 8),
          const Text(
            'Не удалось загрузить настройки.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onRetry,
            child: const Text('Попробовать снова'),
          ),
        ],
      ),
    );
  }
}
