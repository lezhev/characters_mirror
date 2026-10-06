import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/widgets/class_feature_cards.dart';
import 'package:characters_mirror_flutter/features/level_up/presentation/level_up_choice_section.dart';
import 'package:characters_mirror_flutter/features/level_up/application/level_up_controller.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/sheet_outline_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'level_up_hub_test.dart' as hub;

void main() {
  testWidgets('reference feature without short text never uses full text',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: Column(children: [
      ClassFeatureCard(
          feature: ClassFeatureData(
              parentClassId: 1,
              level: 1,
              name: 'Class feature',
              description: 'Full class description')),
      SubclassFeatureCard(
          feature: SubclassFeatureData(
              parentSubclassId: 1,
              level: 1,
              name: 'Subclass feature',
              description: 'Full subclass description',
              relatedTable:
                  '[{"title":"Technical table","headers":[],"rows":[]}]')),
    ]))));
    expect(find.text('Full class description'), findsNothing);
    expect(find.text('Full subclass description'), findsNothing);
    expect(find.byTooltip('Показать таблицы'), findsNothing);
  });

  for (final minimum in [0, 1]) {
    testWidgets('level-up decision exposes minimum=$minimum neutrally',
        (tester) async {
      final view = ChoiceGroupView(
          group: ChoiceGroupData(
              referenceKey: 'decision',
              name: 'Decision',
              selectionCount: 1,
              minimumSelectionCount: minimum),
          options: [
            ChoiceOptionData(choiceGroupId: 1, optionKey: 'a', name: 'A')
          ]);
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: LevelUpChoiceSection(
                  view: view,
                  preview: hub.fixture().preview!,
                  selected: const [],
                  onChanged: (_) {}))));
      expect(
          find.text(minimum == 0
              ? 'Необязательно · до 1'
              : 'Обязательно · выбрать 1'),
          findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('new features share one outline section in data order',
      (tester) async {
    final base = hub.fixture(proficiency: false);
    final first = base.preview!.classStep.currentLevelFeatures![1];
    final second = ClassFeatureData(
        parentClassId: 1,
        id: 4,
        level: 5,
        name: 'Second feature',
        shortDescription: 'Second short text');
    final preview = base.preview!.copyWith(
        classStep: base.preview!.classStep
            .copyWith(currentLevelFeatures: [first, second]));
    await hub.pumpHub(
        tester,
        LevelUpFlowState(
            request: base.request, preview: preview, previewCurrent: true));
    final section = find.ancestor(
        of: find.text(first.name!), matching: find.byType(SheetOutlineCard));
    expect(section, findsOneWidget);
    expect(find.descendant(of: section, matching: find.text('Second feature')),
        findsOneWidget);
    expect(find.text('Second short text'), findsOneWidget);
  });
}
