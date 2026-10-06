import 'dart:async';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character/choice_group_presentation.dart';
import 'package:characters_mirror_flutter/core/character/feature_presentation.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/feature_tag_widgets.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/class_features.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/state/class_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/background_step/state/background_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/character_feature_card.dart';
import 'package:characters_mirror_flutter/features/level_up/application/level_up_controller.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'level_up_hub_test.dart' as hub;

ClassFeatureData feature(int id, String name, {int level = 1}) =>
    ClassFeatureData(
        id: id,
        parentClassId: 1,
        level: level,
        name: name,
        shortDescription: 'Short $name',
        description: 'Full $name',
        tags: [FeatureTag.action],
        relatedTable: '[{"title":"Technical table"}]');

ChoiceGroupView group(String key, int sourceId, String title,
        {ChoiceType type = ChoiceType.featureOption,
        int minimum = 1,
        int maximum = 1}) =>
    ChoiceGroupView(
        group: ChoiceGroupData(
            id: 10,
            referenceKey: key,
            name: title,
            sourceFeatureId: sourceId,
            type: type,
            minimumSelectionCount: minimum,
            selectionCount: maximum),
        options: [
          ChoiceOptionData(
              choiceGroupId: 10,
              optionKey: 'a',
              name: 'Option $key',
              shortDescription: 'Short option $key',
              description: 'Full option $key')
        ]);

Future<void> pumpCreation(WidgetTester tester, ClassStepView step,
    {Map<String, List<ChoiceOptionData>> selected = const {}}) async {
  await tester.pumpWidget(ProviderScope(
      overrides: [
        classStateProvider.overrideWith(() => _ClassState(ClassStateModel(
            stepView: step,
            selectedClass: step.classData,
            selectedLevel: 1,
            selectedOptions: selected))),
        backgroundStateProvider.overrideWith(_BackgroundState.new),
      ],
      child: MaterialApp(
          home: Scaffold(
              body: SingleChildScrollView(
                  child: ClassFeatures(stepView: step, selectedLevel: 1))))));
  await tester.pumpAndSettle();
}

void main() {
  test('subclass display name uses the stored grammatical form', () {
    expect(subclassDisplayName('Школа', 'Ограждения'), 'Школа ограждения');
    expect(subclassDisplayName('Клятва', 'Преданности'), 'Клятва преданности');
    expect(subclassDisplayName('Круг', 'Луны'), 'Круг Луны');
    expect(subclassDisplayName('Круг', 'Круг Луны'), 'Круг Луны');
    expect(subclassDisplayName(' ', 'School'), 'School');
    expect(subclassDisplayName(null, null), isNull);
  });

  test('choice contract shares modes, minimums, status and short text', () {
    final view = group('choice', 1, 'Choice', minimum: 1, maximum: 2);
    final p = ChoiceGroupPresentation.fromView(view, ['a']);
    expect(p.minimum, 1);
    expect(p.maximum, 2);
    expect(p.complete, isTrue);
    expect(p.selectionSummary, 'Выбрано 1 из 2');
    expect(p.prompt(ChoicePresentationContext.creation), 'Выберите 1–2');
    expect(p.prompt(ChoicePresentationContext.levelUp),
        'Обязательно · выбрать 1–2');
    expect(p.options.single.shortDescription, 'Short option choice');
    expect(p.options.single.selected, isTrue);
    expect(p.mode, ChoicePresentationMode.inline);
    expect(
        ChoiceGroupPresentation.fromView(
            view.copyWith(options: [
              view.options!.single
                  .copyWith(shortDescription: null, description: 'Long ' * 100)
            ]),
            []).mode,
        ChoicePresentationMode.inline);
    expect(
        ChoiceGroupPresentation.fromView(
            view.copyWith(options: [
              view.options!.single.copyWith(shortDescription: 'Long ' * 100)
            ]),
            []).mode,
        ChoicePresentationMode.picker);
  });

  for (final count in [1, 2]) {
    testWidgets(
        'creation composes $count canonical groups in the same feature surface',
        (tester) async {
      final f = feature(1, 'Избранный враг');
      final groups = [
        group('enemy', 1, count == 1 ? '  избранный   враг  ' : 'Тип врага'),
        if (count == 2) group('language', 1, 'Язык врага')
      ];
      final step = ClassStepView(
          classData: ClassData(id: 1, name: 'Ranger'),
          currentLevelFeatures: [f],
          choiceGroups: groups,
          currentLevelFeatureViews: [
            ClassStepFeatureView(classFeature: f, displayProperties: [
              FeatureDisplayPropertyView(
                  key: 'value', label: 'Value', value: '2')
            ], resources: [
              CharacterResourceViewData(
                  key: 'pool',
                  name: 'Pool',
                  kind: FeatureResourceKind.points,
                  current: 2,
                  max: 2,
                  resetOn: RestType.shortRest)
            ])
          ]);
      await pumpCreation(tester, step, selected: {
        'enemy': [groups.first.options!.single]
      });
      final surface = find.ancestor(
          of: find.text('Избранный враг'),
          matching: find.byType(AppSurfaceCard));
      expect(surface, findsOneWidget);
      expect(
          find.descendant(
              of: surface, matching: find.text('Short option enemy')),
          findsOneWidget);
      if (count == 2) {
        expect(find.descendant(of: surface, matching: find.text('Язык врага')),
            findsOneWidget);
        expect(find.text('Тип врага'), findsOneWidget);
      } else {
        expect(find.text('  избранный   враг  '), findsNothing);
      }
      expect(find.text('Value: 2'), findsOneWidget);
      expect(find.text('Pool: 2'), findsOneWidget);
      expect(find.text('Восстановление: короткий отдых'), findsOneWidget);
      expect(find.textContaining('Обязательно'), findsNothing);
      expect(find.text('Full Избранный враг'), findsNothing);
      expect(find.text('Full option enemy'), findsNothing);
      expect(find.byType(FeatureTagIconWrap), findsNothing);
      expect(find.text('Technical table'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  for (final label in [
    'Боевой стиль',
    'Избранная местность',
    'Дар договора',
    'Компетентность'
  ]) {
    testWidgets(
        'creation feature $label owns its decision without a second card',
        (tester) async {
      final f = feature(1, label);
      final decision = group('decision', 1, label);
      await pumpCreation(
          tester,
          ClassStepView(
              classData: ClassData(id: 1, name: 'Class'),
              currentLevelFeatures: [f],
              choiceGroups: [decision]));
      expect(find.text(label), findsOneWidget);
      expect(
          find.descendant(
              of: find.ancestor(
                  of: find.text(label), matching: find.byType(AppSurfaceCard)),
              matching: find.text('Выберите 1')),
          findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('creation subclass decision is inside its canonical feature',
      (tester) async {
    final f = feature(1, 'Archetype feature');
    await pumpCreation(
        tester,
        ClassStepView(
            classData: ClassData(id: 1, name: 'Class'),
            currentLevelFeatures: [f],
            subclassChoice: ClassStepSubclassChoiceView(
                requiredLevel: 1,
                sourceFeatureId: 1,
                subclasses: [
                  SubclassData(
                      id: 2,
                      parentClassId: 1,
                      name: 'Ограждения',
                      subclassName: 'Школа')
                ])));
    final surface = find.ancestor(
        of: find.text('Archetype feature'),
        matching: find.byType(AppSurfaceCard));
    expect(find.descendant(of: surface, matching: find.text('Подкласс')),
        findsOneWidget);
    await tester.tap(find.text('Подкласс'));
    await tester.pumpAndSettle();
    expect(find.text('Школа ограждения'), findsOneWidget);
    expect(find.textContaining('Обязательно'), findsNothing);
  });

  testWidgets('Rogue expertise uses owned proficiencies inside its feature',
      (tester) async {
    final f =
        feature(1, 'Компетентность').copyWith(grantedSkills: [Skill.stealth]);
    final decision =
        group('expertise', 1, 'Компетентность', type: ChoiceType.expertise)
            .copyWith(options: [
      ChoiceOptionData(
          choiceGroupId: 10,
          optionKey: 'stealth',
          name: 'Скрытность',
          requiredExistingSkill: Skill.stealth,
          grantedExpertiseSkills: [Skill.stealth])
    ]);
    await pumpCreation(
        tester,
        ClassStepView(
            classData: ClassData(id: 1, name: 'Rogue'),
            currentLevelFeatures: [f],
            choiceGroups: [decision]));
    expect(find.text('Компетентность'), findsOneWidget);
    final surface = find.ancestor(
        of: find.text('Компетентность'), matching: find.byType(AppSurfaceCard));
    expect(find.descendant(of: surface, matching: find.text('Скрытность')),
        findsOneWidget);
    await tester.tap(find.text('Скрытность'));
    await tester.pump();
    final container =
        ProviderScope.containerOf(tester.element(find.byType(ClassFeatures)));
    expect(
        container
            .read(classStateProvider)
            .value!
            .selectedOptions['expertise']!
            .single
            .optionKey,
        'stealth');
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'creation picker permits partial choices and replaces full selections',
      (tester) async {
    final f = feature(1, 'Catalog feature');
    final options = [
      for (var i = 0; i < 6; i++)
        ChoiceOptionData(
            choiceGroupId: 10, optionKey: '$i', name: 'Catalog option $i')
    ];
    final decision =
        group('catalog', 1, 'Catalog feature', minimum: 2, maximum: 2)
            .copyWith(options: options);
    final step = ClassStepView(
        classData: ClassData(id: 1, name: 'Class'),
        currentLevelFeatures: [f],
        choiceGroups: [decision]);
    await pumpCreation(tester, step, selected: {
      'catalog': [options[0], options[1]]
    });
    await tester.tap(find.text('Выберите 2'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Catalog option 0'));
    await tester.tap(find.text('Catalog option 1'));
    await tester.pump();
    // Creation can continue with an incomplete mandatory decision.
    expect(
        tester
            .widget<FilledButton>(find.widgetWithText(FilledButton, 'Готово'))
            .onPressed,
        isNotNull);
    await tester.tap(find.text('Catalog option 2'));
    await tester.tap(find.text('Catalog option 3'));
    await tester.pump();
    await tester.tap(find.text('Готово'));
    await tester.pumpAndSettle();
    final container =
        ProviderScope.containerOf(tester.element(find.byType(ClassFeatures)));
    expect(
        container
            .read(classStateProvider)
            .value!
            .selectedOptions['catalog']!
            .map((o) => o.optionKey),
        ['2', '3']);
    expect(find.text('Выбрано 2 из 2'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'sheet shows selected details, properties and tags without decision tasks',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: SingleChildScrollView(
                child: CharacterFeatureCard(
                    feature: CharacterFeatureViewData(
                        sourceType: CharacterFeatureSourceType.classFeature,
                        sourceId: 1,
                        name: 'Feature',
                        shortDescription: 'Short feature',
                        description: 'Full reference text',
                        tags: [
                          FeatureTag.action
                        ],
                        displayProperties: [
                          FeatureDisplayPropertyView(
                              key: 'amount', label: 'Amount', value: '2')
                        ],
                        selectedChoiceDetails: [
                          SelectedFeatureChoiceView(
                              groupKey: 'group',
                              groupTitle: 'Выберите 2',
                              optionKey: 'a',
                              name: 'Chosen option',
                              shortDescription: 'Chosen short text')
                        ]),
                    onSave: ({name, description, tags}) async {},
                    onReset: () async {},
                    onSetResource: (_, __) async {})))));
    await tester.tap(find.byIcon(Icons.expand_more));
    await tester.pumpAndSettle();
    expect(find.text('Short feature'), findsOneWidget);
    expect(find.text('Full reference text'), findsNothing);
    expect(find.text('Amount: 2'), findsOneWidget);
    expect(find.text('Chosen option'), findsOneWidget);
    expect(find.text('Chosen short text'), findsOneWidget);
    expect(find.text('Выберите 2'), findsNothing);
    expect(find.textContaining('Обязательно'), findsNothing);
    expect(find.byType(FeatureTagIconWrap), findsOneWidget);
  });

  testWidgets(
      'level-up composes linked and standalone features, properties and new resource',
      (tester) async {
    final base = hub.fixture(proficiency: false);
    final a = feature(1, 'Таинственные воззвания', level: 5);
    final b = feature(2, 'Standalone feature', level: 5);
    final decision = group('invocations', 1, 'Мистические воззвания',
        type: ChoiceType.invocation, maximum: 2, minimum: 2);
    final preview = base.preview!.copyWith(
        classStep: ClassStepView(
            classData: base.preview!.classStep.classData,
            selectedLevel: 5,
            currentLevelFeatures: [
              a,
              b
            ],
            currentLevelFeatureViews: [
              ClassStepFeatureView(classFeature: a, displayProperties: [
                FeatureDisplayPropertyView(
                    key: 'amount', label: 'Amount', value: '2')
              ], resources: [
                CharacterResourceViewData(
                    key: 'new',
                    name: 'New pool',
                    kind: FeatureResourceKind.points,
                    current: 2,
                    max: 2)
              ])
            ]),
        choiceGroups: [decision, group('other', 1, 'Refinement')]);
    await hub.pumpHub(
        tester,
        LevelUpFlowState(
            request: base.request, preview: preview, previewCurrent: true));
    final section = find.byKey(const ValueKey('level-up-features'));
    expect(
        find.descendant(
            of: section, matching: find.text('Таинственные воззвания')),
        findsOneWidget);
    expect(
        find.descendant(of: section, matching: find.text('Standalone feature')),
        findsOneWidget);
    expect(find.descendant(of: section, matching: find.text('Refinement')),
        findsOneWidget);
    expect(find.text('Amount: 2'), findsOneWidget);
    expect(find.text('New pool: 2'), findsOneWidget);
    expect(find.text('Обязательно · выбрать 2'), findsOneWidget);
    expect(find.text('Full Таинственные воззвания'), findsNothing);
    expect(find.byType(FeatureTagIconWrap), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('level-up subclass decision uses its source and shared name',
      (tester) async {
    final base = hub.fixture(proficiency: false);
    final f = feature(1, 'Archetype unlock', level: 5);
    final sub = SubclassData(
        id: 2, parentClassId: 1, subclassName: 'Клятва', name: 'Преданности');
    final p = base.preview!.copyWith(
        character: base.preview!.character.copyWith(classEntries: [
          base.preview!.character.classEntries!.single.copyWith(subclass: sub)
        ]),
        classStep: ClassStepView(
            currentLevelFeatures: [f],
            subclassChoice: ClassStepSubclassChoiceView(
                requiredLevel: 5, sourceFeatureId: 1, subclasses: [sub])));
    await hub.pumpHub(
        tester,
        LevelUpFlowState(
            request: base.request, preview: p, previewCurrent: true));
    final section = find.byKey(const ValueKey('level-up-features'));
    expect(find.descendant(of: section, matching: find.text('Подкласс')),
        findsOneWidget);
    expect(find.text('Клятва преданности'), findsOneWidget);
    expect(find.text('Обязательно · выбрать 1'), findsOneWidget);
  });

  test('partial feature view payload retains every feature', () {
    final a = feature(1, 'A');
    final b = feature(2, 'B');
    final views = stepFeatureViews(
        [a, b], null, [ClassStepFeatureView(classFeature: a)], null);
    expect(views.map((v) => v.classFeature!.id), [1, 2]);
  });
}

class _ClassState extends ClassState {
  _ClassState(this.model);
  final ClassStateModel model;
  @override
  FutureOr<ClassStateModel> build() => model;
}

class _BackgroundState extends BackgroundState {
  @override
  FutureOr<BackgroundStateModel> build() => const BackgroundStateModel();
}
