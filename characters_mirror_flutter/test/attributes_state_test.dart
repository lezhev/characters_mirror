import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/attribute_enum.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/selection_type.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/state/attribute_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/widgets/bonus_section.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
          selectedRace: RaceData(
            id: 1,
            features: [
              RaceFeatureData(
                id: 10,
                raceId: 1,
                level: 1,
                choiceSets: [
                  RaceChoiceSetData(
                    id: 11,
                    featureId: 10,
                    kind: RaceChoiceKind.abilityBonusChoice,
                    pickCount: 1,
                    mustBeDistinct: true,
                    choiceOptions: [
                      RaceChoiceOptionData(
                        choiceSetId: 11,
                        ability: Ability.charisma,
                        bonusValue: 2,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
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
          selectedRace: RaceData(
            id: 1,
            features: [
              RaceFeatureData(
                id: 10,
                raceId: 1,
                level: 1,
                choiceSets: [
                  RaceChoiceSetData(
                    id: 11,
                    featureId: 10,
                    kind: RaceChoiceKind.abilityBonusChoice,
                    pickCount: 1,
                    mustBeDistinct: true,
                    choiceOptions: [
                      RaceChoiceOptionData(
                        choiceSetId: 11,
                        ability: Ability.charisma,
                        bonusValue: 2,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
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
        RaceChoiceOptionData(
          choiceSetId: 11,
          optionKey: ability.name,
          ability: ability,
          bonusValue: 1,
        ),
    ];

    container.read(characterCreationProvider.notifier).syncRaceDraft(
          selectedRace: RaceData(
            id: 1,
            charismaBonus: 2,
            features: [
              RaceFeatureData(
                id: 10,
                raceId: 1,
                level: 1,
                choiceSets: [
                  RaceChoiceSetData(
                    id: 11,
                    featureId: 10,
                    kind: RaceChoiceKind.abilityBonusChoice,
                    pickCount: 1,
                    mustBeDistinct: true,
                    choiceOptions: choiceOptions,
                  ),
                ],
              ),
            ],
          ),
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

    final choiceSet = RaceChoiceSetData(
      id: 11,
      featureId: 10,
      kind: RaceChoiceKind.abilityBonusChoice,
      pickCount: 1,
      mustBeDistinct: true,
      choiceOptions: [
        RaceChoiceOptionData(
          choiceSetId: 11,
          ability: Ability.strength,
          bonusValue: 1,
        ),
      ],
    );

    final creation = container.read(characterCreationProvider.notifier);
    creation.syncRaceDraft(
      selectedRace: RaceData(
        id: 1,
        features: [
          RaceFeatureData(
            id: 10,
            raceId: 1,
            level: 1,
            choiceSets: [choiceSet],
          ),
        ],
      ),
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
      choices.where((choice) => choice.selectedAbility == Ability.strength),
      isEmpty,
    );
    expect(
      choices.where((choice) => choice.selectedAbility == Ability.charisma),
      hasLength(1),
    );
    expect(
      choices.where(
        (choice) => choice.groupKey == AttributeState.bonusModeGroupKey,
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
}

Map<String, int> _baseAttributes(ProviderContainer container) {
  return container
      .read(attributeStateProvider)
      .assignedAttributes
      .map((key, value) => MapEntry(key.name, value));
}
