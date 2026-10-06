import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/level_up/application/level_up_choices.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ASI cycles 0 +1 +2 0 with two-point budget and maximum 20', () {
    final scores = {Ability.constitution: 15, Ability.intelligence: 19};
    var values = cycleAsi({}, Ability.constitution, scores);
    expect(values, {Ability.constitution: 1});
    values = cycleAsi(values, Ability.constitution, scores);
    expect(values, {Ability.constitution: 2});
    expect(cycleAsi(values, Ability.intelligence, scores), values);
    values = cycleAsi(values, Ability.constitution, scores);
    expect(values, isEmpty);
    values = cycleAsi(values, Ability.intelligence, scores);
    expect(values, {Ability.intelligence: 1});
    expect(cycleAsi(values, Ability.intelligence, scores), isEmpty);
  });

  test(
      'ASI maps to authoritative catalog options, including two distinct +1 options',
      () {
    final group = ChoiceGroupView(
        group: ChoiceGroupData(
            referenceKey: 'asi',
            type: ChoiceType.abilityIncrease,
            selectionCount: 2,
            allowDuplicates: true),
        options: [
          ChoiceOptionData(
              choiceGroupId: 1,
              optionKey: 'con',
              grantedAbilityBonuses: {'constitution': 1}),
          ChoiceOptionData(
              choiceGroupId: 1,
              optionKey: 'int',
              grantedAbilityBonuses: {'intelligence': 1}),
        ]);
    expect(asiOptionKeys(group, {Ability.constitution: 2}), ['con', 'con']);
    expect(
        asiOptionKeys(
            group, {Ability.constitution: 1, Ability.intelligence: 1}),
        ['con', 'int']);
    expect(asiOptionKeys(group, {Ability.strength: 2}), isNull);
  });

  test('choice presentation depends on complexity and permits an override', () {
    final short = ChoiceGroupView(
        group: ChoiceGroupData(
            referenceKey: 'style', type: ChoiceType.fightingStyle),
        options: [
          ChoiceOptionData(choiceGroupId: 1, optionKey: 'a'),
          ChoiceOptionData(choiceGroupId: 1, optionKey: 'b')
        ]);
    expect(choicePresentation(short), LevelUpChoicePresentation.inline);
    expect(
        choicePresentation(short, override: LevelUpChoicePresentation.picker),
        LevelUpChoicePresentation.picker);
    expect(
        choicePresentation(short.copyWith(options: [
          short.options!.first.copyWith(description: 'Detailed ' * 40)
        ])),
        LevelUpChoicePresentation.picker);
    expect(
        choicePresentation(short.copyWith(
            group: short.group!.copyWith(type: ChoiceType.invocation))),
        LevelUpChoicePresentation.picker);
  });
}
