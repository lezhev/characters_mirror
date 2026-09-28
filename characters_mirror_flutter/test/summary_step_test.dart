import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/state/race_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_step_transition.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/summary_step/application/summary_overview_data.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/summary_step/summary.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/summary_step/widgets/summary_overview.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/button.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('summary keeps completion active when important data is missing',
      (tester) async {
    final container = _createContainer();
    addTearDown(container.dispose);

    await _pumpSummary(tester, container);

    expect(find.text('Новый персонаж'), findsOneWidget);
    expect(find.byKey(const ValueKey('summary-missing-info')), findsOneWidget);
    expect(find.text('Создать персонажа'), findsOneWidget);
    final finishButton = find.ancestor(
      of: find.text('Создать персонажа'),
      matching: find.byType(Button),
    );
    expect(finishButton, findsOneWidget);
    expect(tester.widget<Button>(finishButton).onPressed, isNotNull);
    expect(find.text('Не выбрано: Класс, Раса, Предыстория, Характеристики'),
        findsOneWidget);
    expect(find.byKey(const ValueKey('summary-missing-info')), findsOneWidget);
    expect(
      find.ancestor(
        of: find.byKey(const ValueKey('summary-missing-info')),
        matching: find.byKey(const ValueKey('summary-hero-card')),
      ),
      findsOneWidget,
    );
    expect(find.text('Назад'), findsNothing);
    expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
    expect(
      tester.getSize(finishButton).width,
      closeTo(
          tester.view.physicalSize.width / tester.view.devicePixelRatio - 32,
          1),
    );
  });

  testWidgets('summary app bar back opens the previous wizard step',
      (tester) async {
    final container = _createContainer();
    addTearDown(container.dispose);
    await _pumpSummary(tester, container);

    await tester.tap(find.byKey(const ValueKey('creation-appbar-back')));
    await tester.pumpAndSettle();

    expect(container.read(characterCreationProvider).step, Step.personal);
    expect(
      GoRouter.of(tester.element(find.byKey(const ValueKey('step-next'))))
          .state
          .uri
          .path,
      '/create/personal',
    );
  });

  testWidgets('portrait area stays tappable without a select button',
      (tester) async {
    var portraitTapCount = 0;
    final container = _createContainer();
    addTearDown(container.dispose);
    await _pumpOverview(
      tester,
      SummaryOverviewData.fromState(
        state: container.read(characterCreationProvider),
        hasSubraceOptions: false,
      ),
      onEdit: (_) {},
      onPortraitTap: () => portraitTapCount++,
    );
    final portrait = find.byKey(const ValueKey('summary-portrait-placeholder'));

    await tester.tap(portrait);
    await tester.pumpAndSettle();
    expect(portraitTapCount, 1);

    expect(find.text('Выбрать портрет'), findsNothing);
    await tester.tapAt(tester.getBottomLeft(portrait) + const Offset(12, -12));
    await tester.pumpAndSettle();
    expect(portraitTapCount, 2);
  });

  testWidgets('summary shows selected details and six ability scores',
      (tester) async {
    final container = _createContainer();
    addTearDown(container.dispose);
    final notifier = container.read(characterCreationProvider.notifier);
    notifier.setName('Мелифаро');
    notifier.setRace(
      RaceData(id: 1, name: 'Человек', size: CreatureSize.medium, speed: 30),
    );
    notifier.setBackground(BackgroundData(id: 2, name: 'Путешественник'));
    notifier.applyPrimaryClassSelection(
      classData: ClassData(id: 3, name: 'Волшебник'),
      level: 3,
    );
    notifier.syncAttributesDraft(const {
      'strength': 10,
      'dexterity': 12,
      'constitution': 13,
      'intelligence': 16,
      'wisdom': 14,
      'charisma': 8,
    });

    await _pumpSummary(tester, container);

    expect(find.text('Мелифаро'), findsOneWidget);
    expect(find.text('Волшебник'), findsOneWidget);
    expect(find.text('Человек'), findsOneWidget);
    expect(find.text('Путешественник'), findsOneWidget);
    expect(find.text('Уровень 3'), findsOneWidget);
    expect(find.byKey(const ValueKey('summary-ability-grid')), findsOneWidget);
    expect(find.byKey(const ValueKey('summary-missing-info')), findsNothing);
    final classIconSize = tester.getSize(
      find.byKey(const ValueKey('summary-icon-class')),
    );
    expect(classIconSize, const Size(84, 84));
    expect(
      tester.getSize(find.byKey(const ValueKey('summary-icon-race'))),
      classIconSize,
    );
    expect(
      tester.getSize(find.byKey(const ValueKey('summary-icon-background'))),
      classIconSize,
    );
    expect(
      tester.getSize(find.byKey(const ValueKey('summary-icon-attributes'))),
      classIconSize,
    );
  });

  testWidgets('summary icons use the same primary circles as selection steps',
      (tester) async {
    final container = _createContainer();
    addTearDown(container.dispose);
    await _pumpOverview(
      tester,
      SummaryOverviewData.fromState(
        state: container.read(characterCreationProvider),
        hasSubraceOptions: false,
      ),
      onEdit: (_) {},
      onPortraitTap: () {},
      theme: ThemeData(colorScheme: darkColorScheme, useMaterial3: true),
    );

    final iconTile = tester.widget<Container>(
      find.descendant(
        of: find.byKey(const ValueKey('summary-icon-class')),
        matching: find.byType(Container),
      ),
    );
    final decoration = iconTile.decoration! as BoxDecoration;
    expect(decoration.color, darkColorScheme.primary);
    expect(decoration.shape, BoxShape.circle);
    final icon = tester.widget<Icon>(
      find.descendant(
        of: find.byKey(const ValueKey('summary-icon-class')),
        matching: find.byType(Icon),
      ),
    );
    expect(icon.color, darkColorScheme.surfaceContainerLowest);
  });

  testWidgets('ability cells stay centered and fit a narrow viewport',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 720));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final container = _createContainer();
    addTearDown(container.dispose);
    container.read(characterCreationProvider.notifier).syncAttributesDraft(
      const {
        'strength': 17,
        'dexterity': 12,
        'constitution': 13,
        'intelligence': 14,
        'wisdom': 15,
        'charisma': 8,
      },
    );

    await _pumpSummary(tester, container);
    final grid = find.byKey(const ValueKey('summary-ability-grid'));
    await tester.ensureVisible(grid);

    final cell = find.byKey(const ValueKey('summary-ability-cell-strength'));
    final label = find.byKey(const ValueKey('summary-ability-label-strength'));
    final score = find.byKey(const ValueKey('summary-ability-score-strength'));
    expect(tester.getRect(score).center.dx,
        closeTo(tester.getRect(cell).center.dx, 1));
    expect(tester.getRect(label).top, lessThan(tester.getRect(score).top));
  });

  testWidgets('race without subraces has no subrace status', (tester) async {
    final race = RaceData(id: 1, name: 'Человек');
    final container = _createContainer(
      raceState: RaceStateModel(selectedRace: race),
    );
    addTearDown(container.dispose);
    container.read(characterCreationProvider.notifier).setRace(race);

    await _pumpSummary(tester, container);
    expect(find.text('Подраса не выбрана'), findsNothing);
  });

  testWidgets('race with subraces shows a neutral missing status',
      (tester) async {
    final race = RaceData(id: 1, name: 'Человек');
    final container = _createContainer(
      raceState: RaceStateModel(
        selectedRace: race,
        subraces: [
          SubraceData(id: 4, parentRaceId: 1, name: 'Лесной вариант'),
        ],
      ),
    );
    addTearDown(container.dispose);
    container.read(characterCreationProvider.notifier).setRace(race);

    await _pumpSummary(tester, container);
    expect(find.text('Подраса не выбрана'), findsOneWidget);
  });

  testWidgets('overview cards request their matching edit steps',
      (tester) async {
    final container = _createContainer();
    addTearDown(container.dispose);
    final requestedSteps = <Step>[];
    await _pumpOverview(
      tester,
      SummaryOverviewData.fromState(
        state: container.read(characterCreationProvider),
        hasSubraceOptions: false,
      ),
      onEdit: requestedSteps.add,
      onPortraitTap: () {},
    );

    const stepCards = <(String, Step)>[
      ('summary-class-card', Step.classStep),
      ('summary-race-card', Step.race),
      ('summary-background-card', Step.background),
      ('summary-attributes-card', Step.attributes),
    ];
    for (final (key, expectedStep) in stepCards) {
      final card = find.byKey(ValueKey(key));
      await tester.ensureVisible(card);
      await tester.tap(card);
      await tester.pumpAndSettle();
      expect(requestedSteps.last, expectedStep);
    }
  });

  testWidgets('missing information action opens the first incomplete step',
      (tester) async {
    final container = _createContainer();
    addTearDown(container.dispose);
    var targetStep = Step.summary;
    await _pumpOverview(
      tester,
      SummaryOverviewData.fromState(
        state: container.read(characterCreationProvider),
        hasSubraceOptions: false,
      ),
      onEdit: (step) => targetStep = step,
      onPortraitTap: () {},
    );

    await tester.tap(find.byKey(const ValueKey('summary-missing-info')));
    await tester.pumpAndSettle();

    expect(targetStep, Step.classStep);
  });

  test('subclass and subrace missing states are conditional', () {
    final state = CharacterCreationState.initial().copyWith(
      character: CharacterData(
        classEntries: [
          CharacterClassEntryData(
            classData: ClassData(
              id: 3,
              name: 'Волшебник',
              subclassChoiceLevel: 2,
            ),
            level: 1,
            isStartingClass: true,
          ),
        ],
        race: RaceData(id: 1, name: 'Человек'),
      ),
    );

    final beforeSubclassLevel = SummaryOverviewData.fromState(
      state: state,
      hasSubraceOptions: false,
    );
    final atSubclassLevel = SummaryOverviewData.fromState(
      state: state.copyWith(
        character: state.character.copyWith(
          classEntries: [
            state.character.classEntries!.single.copyWith(level: 2)
          ],
        ),
      ),
      hasSubraceOptions: false,
    );
    final withSubraceOptions = SummaryOverviewData.fromState(
      state: state,
      hasSubraceOptions: true,
    );

    expect(beforeSubclassLevel.subclassIsLocked, isTrue);
    expect(beforeSubclassLevel.subclassIsMissing, isFalse);
    expect(atSubclassLevel.subclassIsMissing, isTrue);
    expect(withSubraceOptions.missingFields.map((field) => field.label),
        contains('Подраса'));
    expect(beforeSubclassLevel.missingFields.map((field) => field.label),
        isNot(contains('Подраса')));
  });
}

ProviderContainer _createContainer({
  RaceStateModel raceState = const RaceStateModel(),
}) =>
    ProviderContainer(
      overrides: [
        raceStateProvider.overrideWith(() => _FakeRaceState(raceState)),
      ],
    );

Future<void> _pumpSummary(
  WidgetTester tester,
  ProviderContainer container,
) async {
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(
        routerConfig: GoRouter(
          initialLocation: '/create/summary',
          routes: [
            GoRoute(
              path: '/create/summary',
              pageBuilder: (_, state) =>
                  _creationPage(state, const SummaryStep()),
            ),
            for (final path in [
              '/create',
              '/create/race',
              '/create/background',
              '/create/attributes',
              '/create/personal',
            ])
              GoRoute(
                path: path,
                pageBuilder: (context, state) => _creationPage(
                  state,
                  Builder(
                    builder: (context) => Scaffold(
                      body: Center(
                        child: ElevatedButton(
                          key: const ValueKey('step-next'),
                          onPressed: () => container
                              .read(characterCreationProvider.notifier)
                              .nextStep(context),
                          child: const Text('Далее'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _pumpOverview(
  WidgetTester tester,
  SummaryOverviewData data, {
  required ValueChanged<Step> onEdit,
  required VoidCallback onPortraitTap,
  ThemeData? theme,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: theme,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SummaryOverview(
              data: data,
              onEdit: onEdit,
              onPortraitTap: onPortraitTap,
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

CustomTransitionPage<void> _creationPage(GoRouterState state, Widget child) =>
    CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 280),
      reverseTransitionDuration: const Duration(milliseconds: 280),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          CreationStepTransitionScope(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      ),
    );

class _FakeRaceState extends RaceState {
  _FakeRaceState(this.model);

  final RaceStateModel model;

  @override
  Future<RaceStateModel> build() async => model;
}
