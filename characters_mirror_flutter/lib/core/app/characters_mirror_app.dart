import 'package:characters_mirror_flutter/core/router/app_router.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/roll_results_overlay.dart';
import 'package:characters_mirror_flutter/features/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharactersMirrorApp extends ConsumerWidget {
  const CharactersMirrorApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final settings = ref.watch(userSettingsControllerProvider);
    final keepScreenAwake = settings.maybeWhen(
      data: (value) => value.keepScreenAwake,
      orElse: () => false,
    );

    return MaterialApp.router(
      title: 'Characters Mirror',
      routerConfig: router,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: settings.maybeWhen(
        data: (value) => value.themeMode,
        orElse: () => ThemeMode.system,
      ),
      builder: (context, child) {
        final adaptiveTheme = adaptThemeForWidth(
          Theme.of(context),
          MediaQuery.sizeOf(context).width,
        );

        return Theme(
          data: adaptiveTheme,
          child: AndroidKeepScreenAwakeApplier(
            enabled: keepScreenAwake,
            child: RollResultsOverlay(
              child: child ?? const SizedBox.shrink(),
            ),
          ),
        );
      },
    );
  }
}
