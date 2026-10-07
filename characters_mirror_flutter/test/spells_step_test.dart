import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/spells_step/spells_step.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/choice_picker.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/creation_spell_selection_presentation.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/state/class_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/class_features.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_progression.dart';
import 'package:characters_mirror_flutter/core/router/app_router.dart';
import 'package:characters_mirror_flutter/features/auth/auth.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as auth;
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'widget_test.dart' as router_test;

void main() {
  test('casters use the same creation steps without a separate spells step',
      () {
    for (final hasSpellStep in [false, true]) {
      expect(creationVisibleSteps(hasSpellStep: hasSpellStep), [
        Step.classStep,
        Step.race,
        Step.background,
        Step.attributes,
        Step.personal,
        Step.summary,
      ]);
    }
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final creation = container.read(characterCreationProvider.notifier);
    creation.syncPrimaryClassDraft(
        classData: ClassData(id: 1), hasSpellCreationStep: true);
    expect(creation.nextVisibleStep(Step.attributes), Step.personal);
    expect(creation.previousVisibleStep(Step.personal), Step.attributes);
  });

  testWidgets(
      'legacy spells route returns to class launchers without a wizard step',
      (tester) async {
    final data = ClassData(id: 1, name: 'Caster');
    final group = ClassSpellSelectionGroupView(
        classDataId: 1,
        kind: CharacterSpellSelectionKind.knownSpell,
        selectionCount: 1,
        options: [SpellData(id: 1, referenceKey: 'spell', name: 'Spell')]);
    final container = ProviderContainer(overrides: [
      classRepositoryProvider.overrideWithValue(_SpellRepository(data, group)),
      raceRepositoryProvider.overrideWithValue(_EmptyRaceRepository()),
      characterRepositoryProvider
          .overrideWithValue(router_test.FakeCharacterRepository()),
      authServiceProvider.overrideWithValue(
          router_test.FakeAuthService.signedIn(auth.UserInfo(
              id: 1,
              userIdentifier: 'test',
              created: DateTime(2026),
              scopeNames: [],
              blocked: false))),
    ]);
    addTearDown(container.dispose);
    await container.read(classStateProvider.future);
    await container.read(classStateProvider.notifier).selectClass(data);
    final router = container.read(routerProvider);
    await tester.pumpWidget(UncontrolledProviderScope(
        container: container, child: MaterialApp.router(routerConfig: router)));
    await tester.pumpAndSettle();
    router.go('/create/spells');
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/create');
    expect(container.read(characterCreationProvider).step, Step.classStep);
    final progression = find.byType(CreationProgression);
    expect(
        find.descendant(of: progression, matching: find.byType(StepIndicator)),
        findsNWidgets(6));
    await tester.ensureVisible(find.text('Известные заклинания'));
    await tester.tap(find.text('Известные заклинания'));
    await tester.pumpAndSettle();
    expect(find.byType(ChoicePicker), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/create');
    expect(
        container.read(classStateProvider).requireValue.selectedSpellSelections,
        isEmpty);
    await tester.ensureVisible(find.text('Известные заклинания'));
    await tester.tap(find.text('Известные заклинания'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Spell'));
    await tester.pump();
    await tester.tap(find.text('Готово'));
    await tester.pumpAndSettle();
    expect(find.text('Выбрано 1 из 1'), findsOneWidget);
    await tester.tap(find.text('Далее'));
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/create/race');
    expect(
        container
            .read(characterCreationProvider)
            .character
            .spellSelections!
            .single
            .spellKey,
        'spell');
    router.go('/create/attributes');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Далее'));
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/create/personal');
    expect(
        container
            .read(characterCreationProvider)
            .character
            .spellSelections!
            .single
            .spellKey,
        'spell');
    await tester.tap(find.text('Назад'));
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/create/attributes');
    router.go('/create');
    await tester.pumpAndSettle();
    expect(find.text('Выбрано 1 из 1'), findsOneWidget);
  });

  test('creation picker uses stable keys, scoped selections and result order',
      () {
    final spells = [
      SpellData(id: 1, referenceKey: 'first', name: 'Одинаковое имя'),
      SpellData(id: 2, referenceKey: 'second', name: 'Одинаковое имя'),
      SpellData(id: 3, name: 'Одинаковое имя'),
      SpellData(name: 'Без ключа'),
    ];
    final p = CreationSpellSelectionPresentation(
        ClassSpellSelectionGroupView(
            classDataId: 1,
            kind: CharacterSpellSelectionKind.knownSpell,
            selectionCount: 2,
            options: spells),
        [
          CharacterSpellSelectionData(
              classDataId: 1,
              kind: CharacterSpellSelectionKind.knownSpell,
              spellId: 2),
          CharacterSpellSelectionData(
              classDataId: 2,
              kind: CharacterSpellSelectionKind.knownSpell,
              spellId: 1),
          CharacterSpellSelectionData(
              classDataId: 1,
              kind: CharacterSpellSelectionKind.knownCantrip,
              spellId: 1),
        ]);
    expect(p.options.map(pickerKey), ['first', 'second', '3']);
    expect(p.selectedKeys, ['second']);
    expect(p.removedSpells(['3', 'first']).map((s) => s.id), [2]);
    expect(p.addedSpells(['3', 'first']).map((s) => s.id), [3, 1]);
    expect(p.addedSpells(['second']), isEmpty);
    expect(p.removedSpells(['second']), isEmpty);
  });

  for (final fromClassStep in [false, true]) {
    testWidgets(
        'creation shared picker round-trip from class step=$fromClassStep',
        (tester) async {
      final data = ClassData(id: 1, name: 'Caster');
      final spells = [
        for (var id = 1; id <= 3; id++)
          SpellData(
              id: id, referenceKey: 'spell_$id', name: 'Spell $id', level: 1)
      ];
      final group = ClassSpellSelectionGroupView(
          classDataId: 1,
          kind: CharacterSpellSelectionKind.knownSpell,
          selectionCount: 2,
          options: spells);
      final container = ProviderContainer(overrides: [
        classRepositoryProvider.overrideWithValue(_SpellRepository(data, group))
      ]);
      addTearDown(container.dispose);
      await container.read(classStateProvider.future);
      final controller = container.read(classStateProvider.notifier);
      await controller.selectClass(data);
      await tester.pumpWidget(UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
              home: Scaffold(body: Consumer(builder: (context, ref, _) {
            final selections = ref
                .watch(classStateProvider)
                .requireValue
                .selectedSpellSelections;
            return fromClassStep
                ? ClassFeatures(
                    stepView:
                        ref.watch(classStateProvider).requireValue.stepView,
                    selectedLevel: 1)
                : ClassSpellSelectionSection(
                    groups: [group],
                    selections: selections,
                    onToggleSpell: controller.toggleSpellSelection,
                    onClearGroup: controller.clearSpellSelectionGroup);
          })))));
      await tester.tap(find.text('Известные заклинания'));
      await tester.pumpAndSettle();
      final picker = tester.widget<ChoicePicker>(find.byType(ChoicePicker));
      expect(
          picker.minimum, 0); // Creation still allows skipping/partial choices.
      expect(picker.maximum, 2);
      await tester.tap(find.text('Spell 1'));
      await tester.pump();
      await tester.tap(find.text('Spell 2'));
      await tester.pump();
      final third = find.descendant(
          of: find.widgetWithText(Card, 'Spell 3'),
          matching: find.byType(Checkbox));
      expect(tester.widget<Checkbox>(third).onChanged, isNull);
      expect(
          container
              .read(classStateProvider)
              .requireValue
              .selectedSpellSelections,
          isEmpty);
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(
          container
              .read(classStateProvider)
              .requireValue
              .selectedSpellSelections,
          isEmpty);
      await tester.tap(find.text('Известные заклинания'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Spell 2'));
      await tester.pump();
      await tester.tap(find.text('Готово'));
      await tester.pumpAndSettle();
      expect(find.text('Выбрано 1 из 2'), findsOneWidget);
      expect(find.text('Spell 2'), findsOneWidget);
      controller.syncSpellSelectionsToCreationDraft();
      expect(
          container
              .read(characterCreationProvider)
              .character
              .spellSelections!
              .single
              .spellKey,
          'spell_2');
      // Reopen a full selection and replace it; removals must precede additions.
      controller.toggleSpellSelection(group, spells.first);
      await tester.pump();
      await tester.tap(find.text('Известные заклинания'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Spell 1'));
      await tester.pump();
      await tester.tap(find.text('Spell 3'));
      await tester.pump();
      await tester.tap(find.text('Готово'));
      await tester.pumpAndSettle();
      expect(
          container
              .read(classStateProvider)
              .requireValue
              .selectedSpellSelections
              .map((s) => s.spellId),
          [2, 3]);
      expect(find.textContaining('Обязательно'), findsNothing);
    });
  }

  testWidgets('spell selector shows details dialog from info button',
      (tester) async {
    final group = ClassSpellSelectionGroupView(
      kind: CharacterSpellSelectionKind.preparedSpell,
      selectionCount: 2,
      classDataId: 1,
      classLevel: 1,
      options: [
        SpellData(
          referenceKey: 'bless',
          name: 'Bless',
          description: 'Вы благословляете до трёх существ на дистанции.',
          higherLevel: 'Когда вы накладываете это заклинание ячейкой 2 круга.',
          level: 1,
          schoolValue: SpellSchool.enchantment,
          castingTime: '1 действие',
          range: '30 футов',
          duration: 'Концентрация, до 1 минуты',
          concentration: true,
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ClassSpellSelectionSection(
            groups: [group],
            selections: const [],
            onToggleSpell: (_, __) {},
            onClearGroup: (_) {},
          ),
        ),
      ),
    );

    expect(find.text('Подготовленные заклинания'), findsOneWidget);
    expect(find.text('Выбрано 0 из 2'), findsOneWidget);
    expect(find.textContaining('Обязательно'), findsNothing);
    expect(find.text('Bless'), findsNothing);
    await tester.tap(find.text('Подготовленные заклинания'));
    await tester.pumpAndSettle();
    expect(find.byType(ChoicePicker), findsOneWidget);
    expect(find.text('Bless'), findsOneWidget);
    expect(find.text('1 уровень · Очарование'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.info_outline));
    await tester.pumpAndSettle();

    expect(find.text('Bless'), findsWidgets);
    expect(find.descendant(of: find.byType(AlertDialog),
        matching: find.text('1 уровень · Очарование')), findsOneWidget);
    expect(
        find.descendant(
            of: find.byType(AlertDialog), matching: find.textContaining('1 действие')),
        findsOneWidget);
    expect(find.descendant(of: find.byType(AlertDialog),
        matching: find.textContaining('Концентрация')), findsOneWidget);
    expect(
      find.text('Вы благословляете до трёх существ на дистанции.'),
      findsOneWidget,
    );
    expect(find.text('На высоких уровнях'), findsOneWidget);
  });
}

class _SpellRepository extends ClassRepository {
  _SpellRepository(this.data, this.group);
  final ClassData data;
  final ClassSpellSelectionGroupView group;
  @override
  Future<List<ClassData>> getAll() async => [data];
  @override
  Future<ClassStepView> getStepView(int classId,
          {int selectedLevel = 1,
          bool isStartingClass = true,
          int? selectedSubclassId,
          Map<String, int>? abilityScores}) async =>
      ClassStepView(
          classData: data,
          selectedLevel: selectedLevel,
          spellSelectionGroups: [group]);
}

class _EmptyRaceRepository extends RaceRepository {
  @override
  Future<List<RaceData>> getAll() async => [];
}
