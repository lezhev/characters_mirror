import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_app_bar.dart';
import 'package:characters_mirror_flutter/features/level_up/application/level_up_controller.dart';
import 'package:characters_mirror_flutter/features/level_up/presentation/level_up_hub.dart';
import 'package:characters_mirror_flutter/features/level_up/presentation/level_up_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';

LevelUpFlowState fixture(
    {bool asi = false,
    bool complete = true,
    bool proficiency = true,
    List<ChoiceGroupView> groups = const []}) {
  final data = ClassData(id: 1, name: 'Тестовый класс', hitDieValue: 8);
  return LevelUpFlowState(
      request: LevelUpRequest(
          characterId: 1,
          expectedVersion: 1,
          classEntryId: 'entry',
          hitDieRoll: 7),
      previewCurrent: true,
      asi: asi
          ? {
              'asi': {Ability.constitution: 1}
            }
          : {},
      preview: LevelUpPreview(
        before: CharacterData(
            classEntries: [
              CharacterClassEntryData(id: 'entry', classData: data, level: 4)
            ],
            derived: CharacterDerivedData(
                totalLevel: 4,
                proficiencyBonus: 2,
                maxHp: 24,
                abilityScores: {for (final a in Ability.values) a: 15})),
        character: CharacterData(
            classEntries: [
              CharacterClassEntryData(id: 'entry', classData: data, level: 5)
            ],
            derived: CharacterDerivedData(
                totalLevel: 5,
                proficiencyBonus: proficiency ? 3 : 2,
                maxHp: 33,
                abilityModifiers: {Ability.constitution: 2})),
        classStep: ClassStepView(classData: data, currentLevelFeatures: [
          ClassFeatureData(
              id: 1,
              parentClassId: 1,
              referenceKey: 'old',
              name: 'Старая механика',
              level: 1),
          ClassFeatureData(
              id: 2,
              parentClassId: 1,
              referenceKey: 'new',
              name: 'Новая возможность',
              shortDescription: 'Новое действие.',
              level: 5),
          ClassFeatureData(
              id: 3,
              parentClassId: 1,
              referenceKey: 'old',
              name: 'Автоматический рост',
              level: 5),
        ]),
        choiceGroups: asi
            ? [
                ChoiceGroupView(
                    group: ChoiceGroupData(
                        referenceKey: 'asi',
                        name: 'Характеристики',
                        type: ChoiceType.abilityIncrease,
                        selectionCount: 2))
              ]
            : groups,
        spellDelta: ClassSpellDeltaView(
            cantripsToAdd: 0,
            knownSpellsToAdd: 0,
            spellbookSpellsToAdd: 0,
            knownSpellReplacements: 0),
        missingDecisions: complete ? [] : ['Выберите подкласс'],
      ));
}

Future<void> pumpHub(WidgetTester tester, LevelUpFlowState state,
        {void Function(int?)? onRoll,
        void Function(String, Ability)? onAbility,
        void Function(String, List<String>)? onChoice}) =>
    tester.pumpWidget(MaterialApp(
        home: LevelUpHub(
            state: state,
            onRoll: onRoll ?? (_) {},
            onAbilityTap: onAbility ?? (_, __) {},
            onChoice: onChoice ?? (_, __) {},
            onSubclass: (_) {},
            onSpells: (_, __, ___) {},
            onApply: () {})));

void main() {
  testWidgets('hub puts new spell levels inside the spell outline only',
      (tester) async {
    final base = fixture();
    final preview = base.preview!;
    await pumpHub(
        tester,
        LevelUpFlowState(
            request: base.request,
            previewCurrent: true,
            preview: preview.copyWith(
                character: preview.character.copyWith(
                    derived: preview.character.derived!
                        .copyWith(spellSlots: {2: 2})),
                spellDelta: preview.spellDelta.copyWith(
                    cantripsToAdd: 1,
                    knownSpellsToAdd: 1,
                    spellbookSpellsToAdd: 1,
                    knownSpellReplacements: 1))));
    final block = find.byKey(const ValueKey('level-up-spells'));
    expect(block, findsOneWidget);
    expect(find.text('Заклинания'), findsOneWidget);
    for (final label in [
      'Выбрать заговоры',
      'Выбрать заклинания',
      'Добавить в книгу заклинаний',
      'Заменить заклинание',
      'Доступны заклинания 2 уровня'
    ]) {
      expect(find.descendant(of: block, matching: find.text(label)),
          findsOneWidget);
    }
    expect(find.text('Доступны заклинания 2 уровня'), findsOneWidget);
    expect(
        tester.getTopLeft(block).dy -
            tester
                .getBottomLeft(find.byKey(const ValueKey('level-up-features')))
                .dy,
        12);
  });

  for (final minimum in [0, 1, 2]) {
    testWidgets('standalone decision shares minimum=$minimum wording',
        (tester) async {
      final group = ChoiceGroupView(
          group: ChoiceGroupData(
              referenceKey: 'standalone',
              name: 'Standalone',
              minimumSelectionCount: minimum,
              selectionCount: 2),
          options: [ChoiceOptionData(choiceGroupId: 1, optionKey: 'a')]);
      await pumpHub(tester, fixture(groups: [group], complete: false));
      final prompt = minimum == 0
          ? 'Необязательно · до 2'
          : 'Обязательно · выбрать ${minimum == 2 ? '2' : '1–2'}';
      expect(find.text(prompt), findsOneWidget);
      expect(tester.widget<Text>(find.text(prompt)).style?.color,
          isNot(Theme.of(tester.element(find.text(prompt))).colorScheme.error));
    });
  }

  testWidgets('hub shows decisions and new features, hides numeric scaling',
      (tester) async {
    await pumpHub(tester, fixture());
    expect(find.text('4 → 5'), findsOneWidget);
    expect(find.text('Бонус мастерства +2 → +3'), findsOneWidget);
    expect(find.text('Новая возможность'), findsOneWidget);
    expect(find.text('Автоматический рост'), findsNothing);
    expect(find.text('Старая механика'), findsNothing);
    expect(find.textContaining('Шаг'), findsNothing);
    expect(
        tester
            .widget<FilledButton>(find.byKey(const ValueKey('level-up-apply')))
            .onPressed,
        isNotNull);
    expect(tester.takeException(), isNull);
  });

  testWidgets('incomplete choices disable application without footer prompts',
      (tester) async {
    await pumpHub(tester, fixture(complete: false, proficiency: false));
    expect(find.textContaining('Бонус мастерства'), findsNothing);
    expect(find.text('Выберите подкласс'), findsNothing);
    expect(
        tester
            .widget<FilledButton>(find.byKey(const ValueKey('level-up-apply')))
            .onPressed,
        isNull);
  });

  testWidgets(
      'physical HP input represents the die result and shows CON separately',
      (tester) async {
    int? roll;
    await pumpHub(tester, fixture(), onRoll: (v) => roll = v);
    await tester.tap(find.text('Ввести вручную'));
    await tester.pump();
    await tester.enterText(find.byKey(const ValueKey('level-up-hp-roll')), '6');
    expect(roll, 6);
    expect(find.text('7 от кости + 2 Телосложение = +9'), findsOneWidget);
    expect(find.text('Максимум хитов'), findsOneWidget);
    expect(find.text('24 → 33'), findsOneWidget);
  });

  testWidgets('ASI uses six accessible cells with explicit +1 state',
      (tester) async {
    Ability? tapped;
    await pumpHub(tester, fixture(asi: true, complete: false),
        onAbility: (_, a) => tapped = a);
    expect(find.byKey(const ValueKey('asi-constitution')), findsOneWidget);
    expect(find.text('15 → 16'), findsOneWidget);
    await tester.ensureVisible(find.byKey(const ValueKey('asi-constitution')));
    await tester.tap(find.byKey(const ValueKey('asi-constitution')));
    expect(tapped, Ability.constitution);
    expect(find.text('Выбрать черту'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('complex choice returns to hub with selected value',
      (tester) async {
    List<String>? selected;
    final group = ChoiceGroupView(
        group: ChoiceGroupData(
            referenceKey: 'invocation',
            name: 'Воззвания',
            type: ChoiceType.invocation,
            selectionCount: 1),
        options: [
          ChoiceOptionData(
              choiceGroupId: 1,
              optionKey: 'a',
              name: 'Первое воззвание',
              description: 'Описание'),
          ChoiceOptionData(
              choiceGroupId: 1, optionKey: 'b', name: 'Второе воззвание'),
        ]);
    await pumpHub(tester, fixture(groups: [group]),
        onChoice: (_, keys) => selected = keys);
    await tester.ensureVisible(find.text('Воззвания'));
    await tester.tap(find.text('Воззвания'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Первое воззвание'));
    await tester.pump();
    await tester.tap(find.text('Готово'));
    await tester.pumpAndSettle();
    expect(selected, ['a']);
    expect(find.text('4 → 5'), findsOneWidget);
  });

  testWidgets('empty feat catalog still has a visible return route to hub',
      (tester) async {
    await pumpHub(tester, fixture(asi: true, complete: false));
    await tester.ensureVisible(find.text('Выбрать черту'));
    await tester.tap(find.text('Выбрать черту'));
    await tester.pumpAndSettle();
    expect(find.text('Черты'), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('4 → 5'), findsOneWidget);
  });

  testWidgets('hub fits a narrow viewport with ASI and manual HP',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await pumpHub(tester, fixture(asi: true, complete: false));
    await tester.tap(find.text('Ввести вручную'));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('an in-flight apply cannot open a child picker', (tester) async {
    final base = fixture(groups: [
      ChoiceGroupView(
          group: ChoiceGroupData(
              referenceKey: 'complex',
              name: 'Complex',
              type: ChoiceType.invocation),
          options: [ChoiceOptionData(choiceGroupId: 1, optionKey: 'a')])
    ]);
    await pumpHub(
        tester,
        LevelUpFlowState(
            request: base.request,
            preview: base.preview,
            previewCurrent: true,
            busy: true));
    await tester.ensureVisible(find.text('Complex'));
    await tester.tap(find.text('Complex'), warnIfMissed: false);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    expect(find.byType(LevelUpPicker, skipOffstage: false), findsNothing);
    expect(find.byType(LinearProgressIndicator), findsNothing);
  });

  testWidgets(
      'short hub starts directly under app bar and keeps multiclass in class card',
      (tester) async {
    final base = fixture();
    final preview = base.preview!;
    await pumpHub(
        tester,
        LevelUpFlowState(
            request: base.request,
            previewCurrent: true,
            preview: preview.copyWith(
                classStep:
                    preview.classStep.copyWith(currentLevelFeatures: []))));
    final appBarBottom = tester.getBottomLeft(find.byType(PageSizeAppBar)).dy;
    final classTop = tester.getTopLeft(find.text('Тестовый класс')).dy;
    expect(classTop - appBarBottom, lessThan(24));
    final multiclass = find.text('Добавить уровень другого класса');
    expect(multiclass, findsOneWidget);
    expect(tester.getTopLeft(multiclass).dy,
        lessThan(tester.getTopLeft(find.text('Максимум хитов')).dy));
    final classCard = find.byKey(const ValueKey('level-up-class-card'));
    expect(
        find.descendant(of: classCard, matching: multiclass), findsOneWidget);
    expect(
        tester
            .widget<OutlinedButton>(find.ancestor(
                of: multiclass, matching: find.byType(OutlinedButton)))
            .onPressed,
        isNull);
  });

  testWidgets(
      'class header SVG follows the class catalog image rather than its name',
      (tester) async {
    final base = fixture();
    final beforeEntry = base.preview!.before.classEntries!.single;
    final afterEntry = base.preview!.character.classEntries!.single;
    final data = beforeEntry.classData!.copyWith(imageURL: 'fighter');
    await pumpHub(
        tester,
        LevelUpFlowState(
            request: base.request,
            previewCurrent: true,
            preview: base.preview!.copyWith(
                before: base.preview!.before.copyWith(
                    classEntries: [beforeEntry.copyWith(classData: data)]),
                character: base.preview!.character.copyWith(
                    classEntries: [afterEntry.copyWith(classData: data)]))));
    final svg = tester.widget<SvgPicture>(find.byType(SvgPicture));
    expect((svg.bytesLoader as SvgAssetLoader).assetName,
        'assets/svg/classes/fighter.svg');
    expect(find.text('Тестовый класс'), findsOneWidget);
  });

  testWidgets(
      'missing subclass unlocked on an earlier level is not a new level-up choice',
      (tester) async {
    final base = fixture();
    await pumpHub(
        tester,
        LevelUpFlowState(
            request: base.request,
            previewCurrent: true,
            preview: base.preview!.copyWith(
                classStep: base.preview!.classStep.copyWith(
                    subclassChoice: ClassStepSubclassChoiceView(
                        requiredLevel: 1, subclasses: [])))));
    expect(find.text('Подкласс'), findsNothing);
  });

  testWidgets('subclass is offered when this progression level unlocks it',
      (tester) async {
    final base = fixture();
    await pumpHub(
        tester,
        LevelUpFlowState(
            request: base.request,
            previewCurrent: true,
            preview: base.preview!.copyWith(
                classStep: base.preview!.classStep.copyWith(
                    subclassChoice: ClassStepSubclassChoiceView(
                        requiredLevel: 5, subclasses: [])))));
    expect(find.text('Подкласс'), findsOneWidget);
  });

  testWidgets('feature-backed choice is composed into one visual block',
      (tester) async {
    final group = ChoiceGroupView(
        group: ChoiceGroupData(
            referenceKey: 'warlock_eldritch_invocations_5',
            name: 'Мистические воззвания',
            sourceFeatureId: 2,
            level: 5,
            type: ChoiceType.invocation,
            selectionCount: 2),
        options: [
          ChoiceOptionData(
              choiceGroupId: 10, optionKey: 'a', name: 'Первое воззвание'),
          ChoiceOptionData(
              choiceGroupId: 10, optionKey: 'b', name: 'Второе воззвание'),
        ]);
    final base = fixture(groups: [group], proficiency: false);
    final preview = base.preview!;
    await pumpHub(
        tester,
        LevelUpFlowState(
            request: base.request,
            previewCurrent: true,
            preview: preview.copyWith(
                classStep: preview.classStep.copyWith(currentLevelFeatures: [
              ClassFeatureData(
                  id: 1,
                  parentClassId: 1,
                  referenceKey: 'old',
                  name: 'Старая механика',
                  level: 1),
              ClassFeatureData(
                  id: 2,
                  parentClassId: 1,
                  referenceKey: 'eldritch_invocations',
                  name: 'Таинственные воззвания',
                  shortDescription: 'Выберите мистические воззвания.',
                  level: 2),
            ]))));

    final block = find.byKey(const ValueKey('level-up-feature-class:2'));
    expect(block, findsOneWidget);
    expect(find.text('Таинственные воззвания'), findsOneWidget);
    expect(find.text('Мистические воззвания'), findsNothing);
    expect(find.text('Обязательно · выбрать 2'), findsOneWidget);

    await tester.ensureVisible(find.text('Обязательно · выбрать 2'));
    await tester.tap(find.text('Обязательно · выбрать 2'));
    await tester.pumpAndSettle();
    expect(find.text('Мистические воззвания'), findsOneWidget);
  });
}
