import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/level_up/application/level_up_controller.dart';
import 'package:characters_mirror_flutter/features/level_up/application/level_up_overview.dart';
import 'package:characters_mirror_flutter/core/character/feature_presentation.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/sheet_outline_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'level_up_hub_test.dart' as hub;

void main() {
  for (final scenario in {
    'Barbarian': ['Безрассудная атака', 'Чувство опасности'],
    'Bard': ['Мастер на все руки', 'Песнь отдыха'],
    'Paladin': [
      'Боевой стиль',
      'Использование заклинаний',
      'Божественная кара'
    ],
    'Ranger': ['Боевой стиль', 'Использование заклинаний'],
  }.entries) {
    testWidgets('${scenario.key} 1→2 keeps every new feature in one outline',
        (tester) async {
      final base = hub.fixture(proficiency: false);
      final p = base.preview!;
      final data = p.classStep.classData!.copyWith(name: scenario.key);
      final before = p.before.copyWith(classEntries: [
        p.before.classEntries!.single.copyWith(level: 1, classData: data)
      ], derived: p.before.derived!.copyWith(totalLevel: 1));
      final after = p.character.copyWith(classEntries: [
        p.character.classEntries!.single.copyWith(level: 2, classData: data)
      ], derived: p.character.derived!.copyWith(totalLevel: 2));
      final features = [
        for (var i = 0; i < scenario.value.length; i++)
          ClassFeatureData(
              id: i + 10, parentClassId: 1, name: scenario.value[i], level: 2)
      ];
      final choices = [
        for (final f in features)
          if (f.name == 'Боевой стиль')
            ChoiceGroupView(
                group: ChoiceGroupData(
                    referenceKey: 'style',
                    sourceFeatureId: f.id,
                    name: f.name,
                    type: ChoiceType.fightingStyle,
                    selectionCount: 1),
                options: [
                  ChoiceOptionData(
                      choiceGroupId: 1, optionKey: 'a', name: 'Дуэлянт')
                ])
      ];
      await hub.pumpHub(
          tester,
          LevelUpFlowState(
              request: base.request,
              previewCurrent: true,
              preview: p.copyWith(
                  before: before,
                  character: after,
                  classStep: ClassStepView(
                      classData: data, currentLevelFeatures: features),
                  choiceGroups: choices)));
      final section = find.byKey(const ValueKey('level-up-features'));
      expect(section, findsOneWidget);
      for (final name in scenario.value) {
        expect(find.descendant(of: section, matching: find.text(name)),
            findsOneWidget);
        expect(
            find.ancestor(
                of: find.text(name), matching: find.byType(SheetOutlineCard)),
            findsOneWidget);
      }
      for (var i = 1; i < features.length; i++) {
        expect(tester.getTopLeft(find.text(features[i - 1].name!)).dy,
            lessThan(tester.getTopLeft(find.text(features[i].name!)).dy));
      }
      if (choices.isNotEmpty) {
        expect(
            find.descendant(
                of: section, matching: find.text('Обязательно · выбрать 1')),
            findsOneWidget);
      }
      expect(tester.takeException(), isNull);
    });
  }

  test('equal reference keys from different feature kinds are not merged', () {
    final base = hub.fixture().preview!;
    final p = base.copyWith(
        classStep: ClassStepView(currentLevelFeatures: [
      ClassFeatureData(
          id: 1,
          parentClassId: 1,
          level: 5,
          referenceKey: 'same',
          name: 'Class feature')
    ], currentSubclassFeatures: [
      SubclassFeatureData(
          id: 1,
          parentSubclassId: 1,
          level: 5,
          referenceKey: 'same',
          name: 'Subclass feature')
    ]));
    expect(newLevelUpFeatures(p, 'entry').map((f) => f.sourceKey),
        ['class:1', 'subclass:1']);
  });

  test('creation resource summaries include only selected option resources',
      () {
    final definitions = [
      FeatureResourceDefinitionData(
          key: 'pool',
          name: 'Pool',
          kind: FeatureResourceKind.points,
          maxRule: FeatureResourceMaxRule.fixed,
          maxValue: 2,
          choiceOptionId: 42)
    ];
    expect(
        referenceResourceSummaries(definitions,
            name: 'Feature', sourceLevel: 2),
        isEmpty);
    expect(
        referenceResourceSummaries(definitions,
            name: 'Feature',
            sourceLevel: 2,
            selectedOptionIds: {42}).single.max,
        2);
  });

  test('existing resource max growth stays out of a displayed feature', () {
    final base = hub.fixture().preview!;
    final current = CharacterFeatureViewData(
        sourceType: CharacterFeatureSourceType.classFeature,
        sourceId: 2,
        resources: [
          CharacterResourceViewData(
              key: 'pool',
              name: 'Pool',
              kind: FeatureResourceKind.points,
              current: 2,
              max: 3)
        ]);
    final p = base.copyWith(
        before: base.before.copyWith(
            derived: CharacterDerivedData(activeFeatures: [
          current
              .copyWith(resources: [current.resources!.single.copyWith(max: 2)])
        ])),
        character: base.character.copyWith(
            derived: CharacterDerivedData(activeFeatures: [current])));
    expect(newLevelUpFeatures(p, 'entry').single.resources, isEmpty);
  });
}
