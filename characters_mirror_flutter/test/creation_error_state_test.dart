import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/background_step/background_step.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/background_step/state/background_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/class_step.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/state/class_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/race_step.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/state/race_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  for (final (name, page) in <(String, Widget)>[
    ('class', const ClassStep()),
    ('race', const RaceStep()),
    ('background', const BackgroundStep()),
  ]) {
    for (final theme in [lightTheme, darkTheme]) {
      for (final size in [
        const Size(487, 568),
        const Size(1280, 720),
        const Size(320, 120),
      ]) {
        testWidgets('$name error uses ${theme.brightness.name} theme at $size',
            (tester) async {
          await tester.binding.setSurfaceSize(size);
          addTearDown(() => tester.binding.setSurfaceSize(null));
          var loadCount = 0;
          void onLoad() => loadCount++;

          final container = ProviderContainer(
            overrides: [
              classStateProvider.overrideWith(
                () => _TestClassState(name == 'class' ? onLoad : null),
              ),
              raceStateProvider.overrideWith(() => _TestRaceState(onLoad)),
              backgroundStateProvider.overrideWith(
                () => _TestBackgroundState(onLoad),
              ),
            ],
          );
          addTearDown(container.dispose);
          // Begin with the error resolved so short viewports test this state
          // without also exercising the creation loading scaffold.
          try {
            switch (name) {
              case 'class':
                await container.read(classStateProvider.future);
              case 'race':
                await container.read(raceStateProvider.future);
              case 'background':
                await container.read(classStateProvider.future);
                await container.read(backgroundStateProvider.future);
            }
          } on ServerpodClientException catch (_) {}
          final router = GoRouter(
            initialLocation: '/create/$name',
            routes: [
              GoRoute(path: '/create/$name', builder: (_, __) => page),
            ],
          );
          addTearDown(router.dispose);

          await tester.pumpWidget(
            UncontrolledProviderScope(
              container: container,
              child: MaterialApp.router(
                theme: theme,
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: TextScaler.linear(size.height < 200 ? 2 : 1),
                  ),
                  child: child!,
                ),
                routerConfig: router,
              ),
            ),
          );
          await tester.pumpAndSettle();

          expect(
            find.text(
                'Не удалось подключиться к серверу. Проверьте соединение.'),
            findsOneWidget,
          );
          expect(find.byType(Scaffold), findsOneWidget);
          final messageStyle =
              tester.widget<EditableText>(find.byType(EditableText)).style;
          expect(messageStyle.fontSize, theme.textTheme.bodyLarge!.fontSize);
          expect(messageStyle.color, theme.colorScheme.onSurfaceVariant);
          expect(messageStyle.decoration, TextDecoration.none);
          expect(tester.takeException(), isNull);

          final retry = find.text('Попробовать снова');
          await tester.ensureVisible(retry);
          expect(tester.getRect(retry).bottom, lessThanOrEqualTo(size.height));
          expect(loadCount, 1);
          if (size.height >= 200) {
            await tester.tap(retry);
            await tester.pumpAndSettle();
            expect(loadCount, 2);
          }
          expect(tester.takeException(), isNull);
        });
      }
    }
  }
}

class _TestClassState extends ClassState {
  _TestClassState(this.onLoad);

  final VoidCallback? onLoad;

  @override
  Future<ClassStateModel> build() async {
    if (onLoad == null) return const ClassStateModel();
    onLoad!();
    throw const ServerpodClientException('Failed to fetch', 0);
  }
}

class _TestRaceState extends RaceState {
  _TestRaceState(this.onLoad);

  final VoidCallback onLoad;

  @override
  Future<RaceStateModel> build() async {
    onLoad();
    throw const ServerpodClientException('Failed to fetch', 0);
  }
}

class _TestBackgroundState extends BackgroundState {
  _TestBackgroundState(this.onLoad);

  final VoidCallback onLoad;

  @override
  Future<BackgroundStateModel> build() async {
    onLoad();
    throw const ServerpodClientException('Failed to fetch', 0);
  }
}
