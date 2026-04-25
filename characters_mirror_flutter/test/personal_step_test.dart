import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/introduction.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/personal_step/personal.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('personal step autosaves short fields when focus changes',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: '/create/personal',
            routes: [
              GoRoute(
                path: '/create/personal',
                builder: (_, __) => const PersonalStep(),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextField && widget.decoration?.labelText == 'Имя',
      ),
      'Мелифаро',
    );
    await tester.tap(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextField && widget.decoration?.labelText == 'Возраст',
      ),
    );
    await tester.pumpAndSettle();

    expect(
        container.read(characterCreationProvider).character.name, 'Мелифаро');
  });

  testWidgets('personal step saves additional notes as first note',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: '/create/personal',
            routes: [
              GoRoute(
                path: '/create/personal',
                builder: (_, __) => const PersonalStep(),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextField &&
            widget.decoration?.labelText == 'Доп. заметки',
      ),
      'Носит письмо в нагрудном кармане',
    );
    await tester.tap(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextField && widget.decoration?.labelText == 'Имя',
      ),
    );
    await tester.pumpAndSettle();

    expect(
      container
          .read(characterCreationProvider)
          .character
          .notes
          ?.map((note) => note.text)
          .toList(),
      const ['Носит письмо в нагрудном кармане'],
    );
  });

  testWidgets('personal step shows values chosen on background step',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(characterCreationProvider.notifier);
    notifier
        .setPersonalityTraits('Я всегда сначала смеюсь. Потом задаю вопросы.');
    notifier.setIdeals('Свобода превыше всего.');
    notifier.setBonds('Я обязан семье всем.');
    notifier.setFlaws('Я слишком доверчив.');

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: '/create/personal',
            routes: [
              GoRoute(
                path: '/create/personal',
                builder: (_, __) => const PersonalStep(),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final personalityField = tester.widget<TextField>(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextField &&
            widget.decoration?.labelText == 'Черты характера',
      ),
    );
    final idealsField = tester.widget<TextField>(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextField && widget.decoration?.labelText == 'Идеалы',
      ),
    );
    final bondsField = tester.widget<TextField>(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextField &&
            widget.decoration?.labelText == 'Привязанности',
      ),
    );
    final flawsField = tester.widget<TextField>(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextField && widget.decoration?.labelText == 'Слабости',
      ),
    );

    expect(personalityField.controller?.text,
        'Я всегда сначала смеюсь. Потом задаю вопросы.');
    expect(idealsField.controller?.text, 'Свобода превыше всего.');
    expect(bondsField.controller?.text, 'Я обязан семье всем.');
    expect(flawsField.controller?.text, 'Я слишком доверчив.');
  });

  testWidgets('creation step supports swipe navigation to next route',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: '/create',
            routes: [
              GoRoute(
                path: '/create',
                builder: (_, __) => const IntroductionStep(),
              ),
              GoRoute(
                path: '/create/race',
                builder: (_, __) => const Scaffold(
                  body: Center(child: Text('Race route')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.drag(
      find.text('Как будет устроено создание персонажа'),
      const Offset(-700, 0),
    );
    await tester.pumpAndSettle();

    expect(find.text('Race route'), findsOneWidget);
  });
}
