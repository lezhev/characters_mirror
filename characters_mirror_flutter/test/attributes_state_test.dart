import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/attribute_enum.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/selection_type.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/state/attribute_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/widgets/bonus_section.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ChoiceGroupView _abilityChoiceGroup(
  List<ChoiceOptionData> options, {
  int raceId = 1,
}) {
  return ChoiceGroupView(
    group: ChoiceGroupData(
      id: 11,
      referenceKey: 'half_elf_ability_score_increase',
      sourceRaceId: raceId,
      type: ChoiceType.abilityIncrease,
      selectionCount: 1,
      allowDuplicates: false,
    ),
    options: options,
  );
}

void main() {
  test('Half-Elf racial +2 and two distinct +1 choices survive draft restore',
      () {
    final group = ChoiceGroupView(
      group: ChoiceGroupData(
        id: 70,
        referenceKey: 'half_elf_ability_score_increase',
        sourceRaceId: 7,
        type: ChoiceType.abilityIncrease,
        selectionCount: 2,
        allowDuplicates: false,
      ),
      options: [
        ChoiceOptionData(
          choiceGroupId: 70,
          optionKey: 'strength',
          grantedAbilityBonuses: const {'strength': 1},
        ),
        ChoiceOptionData(
          choiceGroupId: 70,
          optionKey: 'dexterity',
          grantedAbilityBonuses: const {'dexterity': 1},
        ),
      ],
    );
    final race = RaceData(id: 7, name: 'Half-Elf', charismaBonus: 2);
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(characterCreationProvider.notifier).syncRaceDraft(
      selectedRace: race,
      choiceGroups: [group],
    );
    final attributes = container.read(attributeStateProvider.notifier);
    attributes.changeType(SelectType.manual);
    for (final attribute in [
      Attribute.strength,
      Attribute.dexterity,
      Attribute.charisma,
    ]) {
      attributes.updateManualAttribute(attribute, 10);
    }
    attributes.toggleBonus(
      attribute: Attribute.strength,
      bonusValue: 1,
      value: true,
    );
    attributes.toggleBonus(
      attribute: Attribute.strength,
      bonusValue: 1,
      value: true,
    );
    attributes.toggleBonus(
      attribute: Attribute.dexterity,
      bonusValue: 1,
      value: true,
    );
    expect(attributes.mergeStatsAndBonuses()[Attribute.strength], 11);
    expect(attributes.mergeStatsAndBonuses()[Attribute.dexterity], 11);
    expect(attributes.mergeStatsAndBonuses()[Attribute.charisma], 12);
    attributes.syncActiveDraftToCharacter();
    final saved = CharacterData.fromJson(
      container.read(characterCreationProvider).character.toJson(),
    );
    expect(
        saved.choices?.where(
            (choice) => choice.groupKey == 'half_elf_ability_score_increase'),
        hasLength(2));

    final restored = ProviderContainer();
    addTearDown(restored.dispose);
    restored.read(characterCreationProvider.notifier).syncRaceDraft(
          selectedRace: race,
          choiceGroups: [group],
          raceChoices: saved.choices!,
        );
    restored.read(characterCreationProvider.notifier).syncAttributesDraft(
          saved.baseAbilityScores!,
        );
    final restoredAttributes = restored.read(attributeStateProvider.notifier);
    expect(restoredAttributes.mergeStatsAndBonuses()[Attribute.strength], 11);
    expect(restoredAttributes.mergeStatsAndBonuses()[Attribute.dexterity], 11);
    expect(restoredAttributes.mergeStatsAndBonuses()[Attribute.charisma], 12);
  });

  test('attribute state resolves choices from generic option bonuses', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final creation = container.read(characterCreationProvider.notifier);
    final group = ChoiceGroupData(
      id: 70,
      referenceKey: 'half_elf_ability_score_increase',
      sourceRaceId: 7,
      type: ChoiceType.abilityIncrease,
      selectionCount: 1,
      allowDuplicates: false,
    );
    creation.syncRaceDraft(
      selectedRace: RaceData(id: 7, name: 'Half-Elf'),
      choiceGroups: [
        ChoiceGroupView(
          group: group,
          options: [
            ChoiceOptionData(
              choiceGroupId: 70,
              optionKey: 'strength_plus_one',
              grantedAbilityBonuses: const {'strength': 1},
            ),
          ],
        ),
      ],
    );

    final attributes = container.read(attributeStateProvider.notifier);

    expect(
      attributes.isBonusAvailable(
        attribute: Attribute.strength,
        bonusValue: 1,
      ),
      isTrue,
    );
  });

  test('attribute state keeps draft values while moving between steps', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final attributes = container.read(attributeStateProvider.notifier);
    attributes.changeType(SelectType.manual);
    attributes.updateManualAttribute(Attribute.strength, 16);

    final creation = container.read(characterCreationProvider.notifier);
    creation.syncAttributesDraft(_baseAttributes(container));
    creation.syncStep(Step.personal);

    final state = container.read(attributeStateProvider);

    expect(state.selectionType, SelectType.manual);
    expect(state.assignedAttributes[Attribute.strength], 16);
    expect(
      container
          .read(characterCreationProvider)
          .character
          .baseAbilityScores?['strength'],
      16,
    );
  });

  test('attribute state restores assigned values from saved draft', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(characterCreationProvider.notifier).syncAttributesDraft(
      const {'strength': 15, 'intelligence': 14},
    );

    final state = container.read(attributeStateProvider);

    expect(state.assignedAttributes[Attribute.strength], 15);
    expect(state.assignedAttributes[Attribute.intelligence], 14);
    expect(state.remainingValues, [13, 12, 10, 8]);
  });

  test('standard attributes can be applied repeatedly without shrinking slots',
      () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final attributes = container.read(attributeStateProvider.notifier);
    attributes.onAcceptWithDetailes(
      DragTargetDetails(data: 15, offset: Offset.zero),
      Attribute.strength,
    );
    attributes.onAcceptWithDetailes(
      DragTargetDetails(data: 14, offset: Offset.zero),
      Attribute.strength,
    );

    final state = container.read(attributeStateProvider);

    expect(state.assignedAttributes[Attribute.strength], 14);
    expect(state.remainingValues, [13, 12, 10, 8, 15]);
    expect(state.boxStates.length, 6);
  });

  test('random attributes keep six value slots when replacing an assignment',
      () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final attributes = container.read(attributeStateProvider.notifier);
    attributes.changeType(SelectType.random);

    attributes.rollValueAt(0);
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final firstValue =
        container.read(attributeStateProvider).remainingValues[0];
    expect(firstValue, isNotNull);

    attributes.onAcceptWithDetailes(
      DragTargetDetails(data: firstValue!, offset: Offset.zero),
      Attribute.strength,
    );

    attributes.rollValueAt(1);
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final secondValue =
        container.read(attributeStateProvider).remainingValues[1];
    expect(secondValue, isNotNull);

    attributes.onAcceptWithDetailes(
      DragTargetDetails(data: secondValue!, offset: Offset.zero),
      Attribute.strength,
    );

    final state = container.read(attributeStateProvider);

    expect(state.assignedAttributes[Attribute.strength], secondValue);
    expect(state.remainingValues.length, 6);
    expect(state.boxStates.length, 6);
    expect(state.remainingValues[1], firstValue);
    expect(state.boxStates[1], RollBoxState.filled);
  });

  test('fixed racial bonuses are shown and applied in racial mode', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(characterCreationProvider.notifier).syncRaceDraft(
          selectedRace: RaceData(
            id: 1,
            strengthBonus: 2,
            dexterityBonus: 1,
          ),
        );

    final attributes = container.read(attributeStateProvider.notifier);
    attributes.changeType(SelectType.manual);
    attributes.updateManualAttribute(Attribute.strength, 10);
    attributes.updateManualAttribute(Attribute.dexterity, 10);

    final state = container.read(attributeStateProvider);
    final totals = attributes.mergeStatsAndBonuses();

    expect(state.bonusMode, AttributeBonusMode.racial);
    expect(state.bonusesPlusTwo[Attribute.strength], isTrue);
    expect(state.bonusesPlusOne[Attribute.dexterity], isTrue);
    expect(totals[Attribute.strength], 12);
    expect(totals[Attribute.dexterity], 11);
  });

  test('bonuses update displayed totals for empty ability slots', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(characterCreationProvider.notifier).syncRaceDraft(
          selectedRace: RaceData(
            id: 1,
            charismaBonus: 2,
          ),
        );

    final attributes = container.read(attributeStateProvider.notifier);
    final totals = attributes.mergeStatsAndBonuses();

    expect(
        container
            .read(attributeStateProvider)
            .assignedAttributes[Attribute.charisma],
        0);
    expect(totals[Attribute.charisma], 2);
  });

  test('fixed racial bonuses are hidden and not applied in optional mode', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final creation = container.read(characterCreationProvider.notifier);
    creation.syncRaceDraft(
      selectedRace: RaceData(
        id: 1,
        strengthBonus: 2,
        dexterityBonus: 1,
      ),
      choiceGroups: [
        ChoiceGroupView(
          group: ChoiceGroupData(
            id: 13,
            referenceKey: 'race_flexible_bonus_plus2_dwarf',
            sourceRaceId: 1,
            type: ChoiceType.abilityIncrease,
            selectionCount: 1,
          ),
          options: [
            ChoiceOptionData(
              choiceGroupId: 13,
              optionKey: 'charisma_plus_two',
              grantedAbilityBonuses: const {'charisma': 2},
            ),
            ChoiceOptionData(
              choiceGroupId: 13,
              optionKey: 'strength_plus_two',
              grantedAbilityBonuses: const {'strength': 2},
            ),
          ],
        ),
        ChoiceGroupView(
          group: ChoiceGroupData(
            id: 14,
            referenceKey: 'race_flexible_bonus_plus1_dwarf',
            sourceRaceId: 1,
            type: ChoiceType.abilityIncrease,
            selectionCount: 1,
          ),
          options: [
            ChoiceOptionData(
              choiceGroupId: 14,
              optionKey: 'wisdom_plus_one',
              grantedAbilityBonuses: const {'wisdom': 1},
            ),
            ChoiceOptionData(
              choiceGroupId: 14,
              optionKey: 'dexterity_plus_one',
              grantedAbilityBonuses: const {'dexterity': 1},
            ),
          ],
        ),
      ],
    );
    creation.setUseFlexibleAbilityBonuses(true);

    final attributes = container.read(attributeStateProvider.notifier);
    attributes.changeType(SelectType.manual);
    attributes.updateManualAttribute(Attribute.strength, 10);
    attributes.updateManualAttribute(Attribute.dexterity, 10);
    attributes.updateManualAttribute(Attribute.charisma, 10);
    attributes.setBonusMode(AttributeBonusMode.flexiblePlusTwoOne);
    attributes.toggleBonus(
      attribute: Attribute.charisma,
      bonusValue: 2,
      value: true,
    );

    final state = container.read(attributeStateProvider);
    final totals = attributes.mergeStatsAndBonuses();

    expect(state.bonusMode, AttributeBonusMode.flexiblePlusTwoOne);
    expect(state.bonusesPlusTwo[Attribute.strength], isFalse);
    expect(state.bonusesPlusOne[Attribute.dexterity], isFalse);
    expect(state.bonusesPlusTwo[Attribute.charisma], isTrue);
    expect(totals[Attribute.strength], 10);
    expect(totals[Attribute.dexterity], 10);
    expect(totals[Attribute.charisma], 12);
  });

  test('single-option racial bonus rules are preselected and locked', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(characterCreationProvider.notifier).syncRaceDraft(
      selectedRace: RaceData(id: 1),
      choiceGroups: [
        _abilityChoiceGroup([
          ChoiceOptionData(
            choiceGroupId: 11,
            optionKey: 'charisma_plus_two',
            grantedAbilityBonuses: const {'charisma': 2},
          ),
        ]),
      ],
    );

    final attributes = container.read(attributeStateProvider.notifier);
    attributes.changeType(SelectType.manual);
    attributes.updateManualAttribute(Attribute.charisma, 10);

    final state = container.read(attributeStateProvider);
    final totals = attributes.mergeStatsAndBonuses();

    expect(state.bonusesPlusTwo[Attribute.charisma], isTrue);
    expect(
      attributes.isBonusEditable(
        attribute: Attribute.charisma,
        bonusValue: 2,
      ),
      isFalse,
    );
    expect(totals[Attribute.charisma], 12);
  });

  testWidgets('single-option racial bonus checkbox is checked and disabled',
      (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(characterCreationProvider.notifier).syncRaceDraft(
      selectedRace: RaceData(id: 1),
      choiceGroups: [
        _abilityChoiceGroup([
          ChoiceOptionData(
            choiceGroupId: 11,
            optionKey: 'charisma_plus_two',
            grantedAbilityBonuses: const {'charisma': 2},
          ),
        ]),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: BounsSection.plusTwo(),
          ),
        ),
      ),
    );

    final charismaCheckbox = tester.widget<Checkbox>(
      find.byType(Checkbox).at(Attribute.charisma.index),
    );

    expect(charismaCheckbox.value, isTrue);
    expect(charismaCheckbox.onChanged, isNull);
  });

  test('mixed fixed and any racial bonuses lock fixed and allow any choice',
      () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final choiceOptions = [
      for (final ability in Ability.values)
        ChoiceOptionData(
          choiceGroupId: 11,
          optionKey: ability.name,
          grantedAbilityBonuses: {ability.name: 1},
        ),
    ];

    container.read(characterCreationProvider.notifier).syncRaceDraft(
      selectedRace: RaceData(id: 1, charismaBonus: 2),
      choiceGroups: [_abilityChoiceGroup(choiceOptions)],
    );

    final attributes = container.read(attributeStateProvider.notifier);
    attributes.toggleBonus(
      attribute: Attribute.dexterity,
      bonusValue: 1,
      value: true,
    );
    final state = container.read(attributeStateProvider);
    final totals = attributes.mergeStatsAndBonuses();

    expect(state.bonusesPlusTwo[Attribute.charisma], isTrue);
    expect(
      attributes.isBonusEditable(
        attribute: Attribute.charisma,
        bonusValue: 2,
      ),
      isFalse,
    );
    expect(
      attributes.isBonusEditable(
        attribute: Attribute.dexterity,
        bonusValue: 1,
      ),
      isTrue,
    );
    expect(totals[Attribute.dexterity], 1);
  });

  test('optional mode exports only active flexible bonus choices', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final creation = container.read(characterCreationProvider.notifier);
    creation.syncRaceDraft(
      selectedRace: RaceData(id: 1),
      choiceGroups: [
        _abilityChoiceGroup([
          ChoiceOptionData(
            choiceGroupId: 11,
            optionKey: 'strength_plus_one',
            grantedAbilityBonuses: const {'strength': 1},
          ),
        ]),
        ChoiceGroupView(
          group: ChoiceGroupData(
            id: 12,
            referenceKey: 'half_elf_ability_bonus_mode',
            sourceRaceId: 1,
            type: ChoiceType.custom,
            selectionCount: 1,
          ),
          options: [
            for (final mode in AttributeBonusMode.values)
              ChoiceOptionData(
                choiceGroupId: 12,
                optionKey: mode.name,
                name: mode.name,
              ),
          ],
        ),
        ChoiceGroupView(
          group: ChoiceGroupData(
            id: 13,
            referenceKey: 'race_flexible_bonus_plus2_half_elf',
            sourceRaceId: 1,
            type: ChoiceType.abilityIncrease,
            selectionCount: 1,
          ),
          options: [
            ChoiceOptionData(
              choiceGroupId: 13,
              optionKey: 'strength_plus_two',
              grantedAbilityBonuses: const {'strength': 2},
            ),
            ChoiceOptionData(
              choiceGroupId: 13,
              optionKey: 'charisma_plus_two',
              grantedAbilityBonuses: const {'charisma': 2},
            ),
          ],
        ),
        ChoiceGroupView(
          group: ChoiceGroupData(
            id: 14,
            referenceKey: 'race_flexible_bonus_plus1_half_elf',
            sourceRaceId: 1,
            type: ChoiceType.abilityIncrease,
            selectionCount: 1,
          ),
          options: [
            ChoiceOptionData(
              choiceGroupId: 14,
              optionKey: 'wisdom_plus_one',
              grantedAbilityBonuses: const {'wisdom': 1},
            ),
            ChoiceOptionData(
              choiceGroupId: 14,
              optionKey: 'charisma_plus_one',
              grantedAbilityBonuses: const {'charisma': 1},
            ),
          ],
        ),
      ],
    );
    creation.setUseFlexibleAbilityBonuses(true);

    final attributes = container.read(attributeStateProvider.notifier);
    attributes.toggleBonus(
      attribute: Attribute.strength,
      bonusValue: 1,
      value: true,
    );
    attributes.setBonusMode(AttributeBonusMode.flexiblePlusTwoOne);
    attributes.toggleBonus(
      attribute: Attribute.charisma,
      bonusValue: 2,
      value: true,
    );

    final choices = attributes.buildRacialAttributeChoices();

    expect(
      choices.where((choice) => choice.optionKey == Ability.strength.name),
      isEmpty,
    );
    expect(
      choices.where(
        (choice) =>
            choice.groupKey == 'race_flexible_bonus_plus2_half_elf' &&
            choice.optionKey == 'charisma_plus_two',
      ),
      hasLength(1),
    );
    expect(
      choices.where(
        (choice) => choice.groupKey?.startsWith('race_flexible_bonus') == true,
      ),
      hasLength(1),
    );
    expect(
      choices.where(
        (choice) => choice.groupKey == 'half_elf_ability_bonus_mode',
      ),
      hasLength(1),
    );
  });

  test('creation reset clears kept-alive attribute draft', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final attributes = container.read(attributeStateProvider.notifier);
    attributes.changeType(SelectType.manual);
    attributes.updateManualAttribute(Attribute.strength, 16);

    container.read(characterCreationProvider.notifier).reset();
    final state = container.read(attributeStateProvider);

    expect(state.selectionType, SelectType.defaultType);
    expect(state.assignedAttributes[Attribute.strength], 0);
    expect(state.remainingValues, [15, 14, 13, 12, 10, 8]);
  });

  test('allocation methods keep independent drafts while switching', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final attributes = container.read(attributeStateProvider.notifier);
    attributes.onAcceptWithDetailes(
      DragTargetDetails(data: 15, offset: Offset.zero),
      Attribute.strength,
    );
    attributes.onAcceptWithDetailes(
      DragTargetDetails(data: 14, offset: Offset.zero),
      Attribute.dexterity,
    );
    final defaultDraft = container.read(attributeStateProvider).activeDraft;

    attributes.changeType(SelectType.manual);
    attributes.updateManualAttribute(Attribute.strength, 16);
    attributes.updateManualAttribute(Attribute.wisdom, 12);
    attributes.changeType(SelectType.defaultType);

    final restoredDefault = container.read(attributeStateProvider);
    expect(restoredDefault.assignedAttributes[Attribute.strength], 15);
    expect(restoredDefault.assignedAttributes[Attribute.dexterity], 14);
    expect(restoredDefault.activeDraft.remainingValues,
        defaultDraft.remainingValues);

    attributes.changeType(SelectType.manual);
    expect(container.read(attributeStateProvider).assignedAttributes,
        containsPair(Attribute.strength, 16));
    expect(container.read(attributeStateProvider).assignedAttributes,
        containsPair(Attribute.wisdom, 12));

    attributes.changeType(SelectType.defaultType);
    attributes.changeType(SelectType.manual);
    expect(container.read(attributeStateProvider).assignedAttributes,
        containsPair(Attribute.strength, 16));
  });

  test('optional rule changes preserve the active draft and selected mode', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final attributes = container.read(attributeStateProvider.notifier);
    attributes.changeType(SelectType.manual);
    attributes.updateManualAttribute(Attribute.strength, 16);
    final creation = container.read(characterCreationProvider.notifier);

    creation.setUseFlexibleAbilityBonuses(true);
    creation.setUseFlexibleAbilityBonuses(false);
    creation.setUseFlexibleAbilityBonuses(true);

    final state = container.read(attributeStateProvider);
    expect(state.selectionType, SelectType.manual);
    expect(state.assignedAttributes[Attribute.strength], 16);
  });

  test('pending random roll completes in its own draft after switching mode',
      () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final attributes = container.read(attributeStateProvider.notifier);
    attributes.changeType(SelectType.random);
    attributes.rollValueAt(0);
    attributes.changeType(SelectType.manual);
    await Future<void>.delayed(const Duration(milliseconds: 550));
    attributes.changeType(SelectType.random);

    final state = container.read(attributeStateProvider);
    expect(state.boxStates.first, RollBoxState.filled);
    expect(state.remainingValues.first, isNotNull);
  });

  test('active allocation is saved without resetting any method draft', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final attributes = container.read(attributeStateProvider.notifier);
    attributes.onAcceptWithDetailes(
      DragTargetDetails(data: 15, offset: Offset.zero),
      Attribute.strength,
    );
    attributes.changeType(SelectType.manual);
    attributes.updateManualAttribute(Attribute.strength, 16);

    attributes.syncActiveDraftToCharacter();

    final savedCharacter = container.read(characterCreationProvider).character;
    final stateAfterSave = container.read(attributeStateProvider);
    expect(savedCharacter.baseAbilityScores?['strength'], 16);
    expect(stateAfterSave.selectionType, SelectType.manual);
    expect(stateAfterSave.assignedAttributes[Attribute.strength], 16);
    expect(
      stateAfterSave.drafts[SelectType.defaultType]!
          .assignedAttributes[Attribute.strength],
      15,
    );

    container.read(characterCreationProvider.notifier).syncStep(Step.personal);
    container
        .read(characterCreationProvider.notifier)
        .syncStep(Step.attributes);
    final restored = container.read(attributeStateProvider);
    expect(restored.selectionType, SelectType.manual);
    expect(restored.assignedAttributes[Attribute.strength], 16);
    expect(
      restored.drafts[SelectType.defaultType]!
          .assignedAttributes[Attribute.strength],
      15,
    );
  });

  test('assigned scores move and swap without changing the remaining pool', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final attributes = container.read(attributeStateProvider.notifier);
    attributes.onAcceptWithDetailes(
      DragTargetDetails(data: 15, offset: Offset.zero),
      Attribute.strength,
    );
    attributes.onAcceptWithDetailes(
      DragTargetDetails(data: 14, offset: Offset.zero),
      Attribute.dexterity,
    );
    final remaining = container.read(attributeStateProvider).remainingValues;

    attributes.moveAssignedAttribute(Attribute.strength, Attribute.dexterity);
    var state = container.read(attributeStateProvider);
    expect(state.assignedAttributes[Attribute.strength], 14);
    expect(state.assignedAttributes[Attribute.dexterity], 15);
    expect(state.remainingValues, remaining);

    attributes.moveAssignedAttribute(Attribute.dexterity, Attribute.wisdom);
    state = container.read(attributeStateProvider);
    expect(state.assignedAttributes[Attribute.dexterity], 0);
    expect(state.assignedAttributes[Attribute.wisdom], 15);
    expect(state.remainingValues, remaining);
    expect(state.assignedAttributes.values.where((value) => value == 15),
        hasLength(1));
  });

  test('manual values above twenty are saved to the creation character', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final attributes = container.read(attributeStateProvider.notifier);
    attributes.changeType(SelectType.manual);
    attributes.updateManualAttribute(Attribute.strength, 25);
    attributes.syncActiveDraftToCharacter();

    expect(
      container.read(characterCreationProvider).character.baseAbilityScores,
      containsPair('strength', 25),
    );

    final serialized = CharacterData.fromJson(
      container.read(characterCreationProvider).character.toJson(),
    );
    final restored = ProviderContainer();
    addTearDown(restored.dispose);
    restored
        .read(characterCreationProvider.notifier)
        .syncAttributesDraft(serialized.baseAbilityScores!);
    expect(
      restored
          .read(attributeStateProvider)
          .assignedAttributes[Attribute.strength],
      25,
    );
  });
}

Map<String, int> _baseAttributes(ProviderContainer container) {
  return container
      .read(attributeStateProvider)
      .assignedAttributes
      .map((key, value) => MapEntry(key.name, value));
}
