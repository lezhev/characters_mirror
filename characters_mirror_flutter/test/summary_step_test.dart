import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/summary_step/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('summary step renders grouped sections from draft state',
      (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(characterCreationProvider.notifier);
    notifier.setName('Мелифаро');
    notifier.setRace(
      RaceData(
        id: 1,
        name: 'Человек',
        size: CreatureSize.medium,
        speed: 30,
      ),
    );
    notifier.setBackground(
      BackgroundData(
        id: 2,
        name: 'Мудрец',
      ),
    );
    notifier.applyPrimaryClassSelection(
      classData: ClassData(
        id: 3,
        name: 'Wizard',
        imageURL: 'wizard',
      ),
      level: 3,
      spellSelections: [
        CharacterSpellSelectionData(
          classDataId: 3,
          spell: SpellData(
            referenceKey: 'magic_missile',
            name: 'Magic Missile',
          ),
          spellKey: 'magic_missile',
          kind: CharacterSpellSelectionKind.knownSpell,
          selectionIndex: 0,
        ),
      ],
    );
    notifier.syncAttributesDraft(const {
      'strength': 10,
      'intelligence': 16,
    });
    final dragonbornGroup = ChoiceGroupData(
      id: 10,
      referenceKey: 'dragonborn_draconic_ancestry',
      sourceRaceId: 1,
      selectionCount: 1,
    );
    notifier.syncRaceDraft(
      selectedRace: notifier.state.character.race,
      choiceGroups: [
        ChoiceGroupView(
          group: dragonbornGroup,
          options: [
            ChoiceOptionData(
              choiceGroupId: 10,
              optionKey: 'red_dragon',
              name: 'Драконий',
            ),
          ],
        ),
      ],
      raceChoices: [
        CharacterChoiceData(
          groupKey: 'dragonborn_draconic_ancestry',
          optionKey: 'red_dragon',
          selectionIndex: 0,
        ),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: '/create/summary',
            routes: [
              GoRoute(
                path: '/create/summary',
                builder: (_, __) => const SummaryStep(),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Сводка персонажа'), findsOneWidget);
    expect(find.text('Выборы'), findsOneWidget);
    expect(find.text('Базовые характеристики'), findsOneWidget);
    expect(find.text('Мелифаро'), findsOneWidget);
    expect(find.text('Человек'), findsOneWidget);
    expect(find.text('Wizard'), findsOneWidget);
    expect(find.text('Драконий'), findsOneWidget);
    expect(find.text('Magic Missile'), findsOneWidget);
  });

  testWidgets('summary step includes racial ability bonuses', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(characterCreationProvider.notifier);
    notifier.syncRaceDraft(
      selectedRace: RaceData(
        id: 1,
        name: 'Человек',
        size: CreatureSize.medium,
        speed: 30,
        strengthBonus: 2,
      ),
      selectedSubrace: SubraceData(
        id: 2,
        parentRaceId: 1,
        name: 'Вариант',
        dexterityBonus: 1,
      ),
    );
    notifier.syncAttributesDraft(const {
      'strength': 10,
      'dexterity': 14,
      'wisdom': 12,
    });
    final abilityGroup = ChoiceGroupData(
      id: 11,
      referenceKey: 'test_race_ability_choice',
      sourceRaceId: 1,
      type: ChoiceType.abilityIncrease,
      selectionCount: 1,
    );
    notifier.syncRaceDraft(
      selectedRace: notifier.state.character.race,
      selectedSubrace: notifier.state.character.subrace,
      choiceGroups: [
        ChoiceGroupView(
          group: abilityGroup,
          options: [
            ChoiceOptionData(
              choiceGroupId: 11,
              optionKey: 'wisdom_plus_one',
              grantedAbilityBonuses: const {'wisdom': 1},
            ),
          ],
        ),
      ],
    );
    notifier.syncRacialAttributeChoicesDraft([
      CharacterChoiceData(
        groupKey: 'test_race_ability_choice',
        optionKey: 'wisdom_plus_one',
        selectionIndex: 0,
      ),
    ]);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: '/create/summary',
            routes: [
              GoRoute(
                path: '/create/summary',
                builder: (_, __) => const SummaryStep(),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('12'), findsOneWidget);
    expect(find.text('13'), findsOneWidget);
    expect(find.text('15'), findsOneWidget);
  });
}
