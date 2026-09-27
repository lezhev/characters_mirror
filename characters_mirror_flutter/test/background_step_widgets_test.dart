import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/background_step/background_step.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/background_step/state/background_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/background_step/widgets/background_features.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/starting_equipment_section.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_choice_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'legacy equipment items are not the source for structured starting gear',
      (tester) async {
    const backgrounds = [
      'Послушник',
      'Народный герой',
      'Артист',
      'Солдат',
      'Шарлатан',
      'Чужеземец',
    ];

    for (final name in backgrounds) {
      final background = BackgroundData(
        id: name.hashCode,
        name: name,
        items: ['legacy equipment: $name'],
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            backgroundStateProvider.overrideWith(
              () => _FakeBackgroundState(
                BackgroundStateModel(
                  selectedBackground: background,
                  stepView: BackgroundStepView(background: background),
                ),
              ),
            ),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: BackgroundFeatures(
                selectedBackground: background,
                stepView: BackgroundStepView(background: background),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('legacy equipment: $name'), findsNothing, reason: name);
    }
  });

  testWidgets(
      'structured equipment blocks render for six representative backgrounds',
      (tester) async {
    final cases = <(String, StartingEquipmentBlockView)>[
      (
        'Послушник',
        _choiceEquipmentBlock(101, [
          (
            'prayer_book',
            StartingEquipmentLineData(
              kind: StartingEquipmentLineKind.catalogRef,
              catalogType: EquipmentCatalogType.item,
              referenceKey: 'prayer_book',
            )
          ),
          (
            'prayer_drum',
            StartingEquipmentLineData(
              kind: StartingEquipmentLineKind.catalogRef,
              catalogType: EquipmentCatalogType.item,
              referenceKey: 'prayer_drum',
            )
          ),
        ]),
      ),
      (
        'Народный герой',
        _choiceEquipmentBlock(102, [
          (
            'artisan',
            StartingEquipmentLineData(
              kind: StartingEquipmentLineKind.itemCategory,
              catalogType: EquipmentCatalogType.tool,
              allowedItemCategories: [ToolCategory.artisan.name],
            )
          ),
        ]),
      ),
      (
        'Артист',
        _choiceEquipmentBlock(103, [
          (
            'musicalInstrument',
            StartingEquipmentLineData(
              kind: StartingEquipmentLineKind.itemCategory,
              catalogType: EquipmentCatalogType.tool,
              allowedItemCategories: [ToolCategory.musicalInstrument.name],
            )
          ),
        ]),
      ),
      (
        'Солдат',
        _choiceEquipmentBlock(104, [
          (
            'gamingSet',
            StartingEquipmentLineData(
              kind: StartingEquipmentLineKind.itemCategory,
              catalogType: EquipmentCatalogType.tool,
              allowedItemCategories: [ToolCategory.gamingSet.name],
            )
          ),
        ]),
      ),
      (
        'Шарлатан',
        _choiceEquipmentBlock(105, [
          for (final key in [
            'dyed_liquid_bottle',
            'rigged_dice',
            'marked_cards',
            'fake_duke_signet_ring',
          ])
            (
              key,
              StartingEquipmentLineData(
                kind: StartingEquipmentLineKind.catalogRef,
                catalogType: EquipmentCatalogType.item,
                referenceKey: key,
              )
            ),
        ]),
      ),
      (
        'Чужеземец',
        StartingEquipmentBlockView(
          block: StartingEquipmentBlockData(
            entryId: 106,
            kind: StartingEquipmentBlockKind.fixedGrant,
          ),
          fixedLines: [
            StartingEquipmentLineData(
              kind: StartingEquipmentLineKind.catalogRef,
              catalogType: EquipmentCatalogType.weapon,
              referenceKey: 'quarterstaff',
            ),
          ],
        ),
      ),
    ];

    for (final (name, equipmentBlock) in cases) {
      final background = BackgroundData(
        id: name.hashCode,
        name: name,
        coins: 10,
        items: ['legacy equipment: $name'],
      );
      final stepView = BackgroundStepView(
        background: background,
        startingEquipmentBlocks: [equipmentBlock],
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            backgroundStateProvider.overrideWith(
              () => _FakeBackgroundState(
                BackgroundStateModel(
                  selectedBackground: background,
                  stepView: stepView,
                ),
              ),
            ),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: BackgroundFeatures(
                  selectedBackground: background,
                  stepView: stepView,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(StartingEquipmentSection), findsOneWidget,
          reason: name);
      expect(find.text('legacy equipment: $name'), findsNothing, reason: name);
      expect(find.text('Монеты: 10'), findsOneWidget, reason: name);
    }
  });

  testWidgets('background tile shows selected border by id', (tester) async {
    final tileBackground = BackgroundData(id: 7, name: 'Артист');
    final selectedBackground = BackgroundData(id: 7, name: 'Артист');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          backgroundStateProvider.overrideWith(
            () => _FakeBackgroundState(
              BackgroundStateModel(
                allBackgrounds: [tileBackground],
                selectedBackground: selectedBackground,
              ),
            ),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: BackgroundTile(background: tileBackground),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final ink = tester.widget<Ink>(find.byType(Ink).first);
    final decoration = ink.decoration! as BoxDecoration;
    final border = decoration.border! as Border;
    expect(border.top.width, 2);
  });

  testWidgets(
      'background features use structured choices and keep legacy items hidden',
      (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final background = BackgroundData(
      id: 3,
      name: 'Народный герой',
      skillProficiencies: const [Skill.animalHandling],
      languageCount: 1,
      items: ['Комплект путешественника'],
      suggestedPersonality: const [
        'Я всегда сначала смеюсь. Потом задаю вопросы.',
      ],
    );
    final languageGroup = ChoiceGroupData(
      referenceKey: 'folk_hero_language',
      id: 42,
      sourceBackgroundId: background.id,
      type: ChoiceType.language,
      name: 'Языки',
      selectionCount: 1,
      exclusiveKey: 'background_language_pick',
      allowDuplicates: false,
    );
    final stepView = BackgroundStepView(
      background: background,
      skillSelectionGroups: [
        SkillSelectionGroupView(
          kind: CharacterSkillSelectionKind.backgroundSkill,
          selectionCount: 1,
          backgroundDataId: background.id,
          options: const [Skill.survival],
        ),
      ],
      choiceGroups: [
        ChoiceGroupView(
          group: languageGroup,
          options: [
            ChoiceOptionData(
              choiceGroupId: 42,
              optionKey: 'celestial',
              name: 'celestial',
              grantedLanguages: const [Language.celestial],
            ),
          ],
        ),
        ChoiceGroupView(
          group: ChoiceGroupData(
            id: 43,
            referenceKey: 'folk_hero_artisan_tool',
            sourceBackgroundId: background.id,
            type: ChoiceType.tool,
            name: 'Инструменты ремесленника',
            selectionCount: 1,
            allowDuplicates: false,
          ),
          options: [
            ChoiceOptionData(
              choiceGroupId: 43,
              optionKey: 'smith_tools',
              name: 'Инструменты ремесленника',
              grantedToolKeys: const ['smith_tools'],
            ),
          ],
        ),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: ProviderScope(
          overrides: [
            backgroundStateProvider.overrideWith(
              () => _FakeBackgroundState(
                BackgroundStateModel(
                  selectedBackground: background,
                  stepView: stepView,
                ),
              ),
            ),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: BackgroundFeatures(
                  selectedBackground: background,
                  stepView: stepView,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Владения предыстории'), findsOneWidget);
    expect(find.text('Владения и языки'), findsOneWidget);
    expect(find.text('Навыки'), findsOneWidget);
    expect(find.text('Языки'), findsOneWidget);
    expect(find.byType(CreationChoiceSelector), findsWidgets);
    expect(find.text('Уход за животными'), findsOneWidget);
    expect(find.text('Инструменты ремесленника'), findsNWidgets(2));
    expect(find.text('Языков на выбор: 1'), findsNothing);
    expect(find.text('Небесный'), findsOneWidget);
    expect(find.text('Комплект путешественника'), findsNothing);
    expect(find.text('Я всегда сначала смеюсь'), findsOneWidget);

    final skillTop = tester.getTopLeft(find.text('Владение навыками')).dy;
    final languageTop = tester.getTopLeft(find.text('Языки')).dy;
    final toolTop =
        tester.getTopLeft(find.text('Инструменты ремесленника').first).dy;
    expect(skillTop, lessThan(languageTop));
    expect(languageTop, lessThan(toolTop));

    final promptCard = find.byKey(
      const ValueKey('choice-card-Черты характера_Я всегда сначала смеюсь'),
    );
    await tester.ensureVisible(promptCard);
    await tester.pumpAndSettle();
    await tester.tap(promptCard);
    await tester.pumpAndSettle();

    expect(
      container.read(characterCreationProvider).character.personalityTraits,
      'Я всегда сначала смеюсь. Потом задаю вопросы.',
    );

    final promptInfo = find.byKey(
      const ValueKey('choice-info-Черты характера_Я всегда сначала смеюсь'),
    );
    await tester.ensureVisible(promptInfo);
    await tester.pumpAndSettle();
    await tester.tap(promptInfo);
    await tester.pumpAndSettle();

    expect(find.text('Я всегда сначала смеюсь'), findsWidgets);
    expect(find.text('Потом задаю вопросы.'), findsOneWidget);
  });
}

class _FakeBackgroundState extends BackgroundState {
  _FakeBackgroundState(this.initialState);

  final BackgroundStateModel initialState;

  @override
  Future<BackgroundStateModel> build() async => initialState;
}

StartingEquipmentBlockView _choiceEquipmentBlock(
  int groupId,
  List<(String, StartingEquipmentLineData)> options,
) {
  final optionViews = [
    for (var index = 0; index < options.length; index++)
      StartingEquipmentOptionView(
        option: StartingEquipmentOptionData(
          entryId: groupId * 10 + index,
          parentEntryId: groupId,
          orderIndex: index,
          lines: [options[index].$2],
        ),
        lines: [options[index].$2],
      ),
  ];
  return StartingEquipmentBlockView(
    block: StartingEquipmentBlockData(
      entryId: groupId,
      kind: StartingEquipmentBlockKind.choice,
      selectionCount: 1,
      options: [for (final option in optionViews) option.option!],
    ),
    options: optionViews,
  );
}
