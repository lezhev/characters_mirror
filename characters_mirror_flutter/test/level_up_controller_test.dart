import 'dart:async';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/level_up/application/level_up_controller.dart';
import 'package:characters_mirror_flutter/features/level_up/data/level_up_gateway.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeGateway implements LevelUpGateway {
  final pending = <Completer<LevelUpPreview>>[];
  int applied = 0;
  bool failApply = false;
  @override
  Future<LevelUpPreview> preview(LevelUpRequest request) {
    final c = Completer<LevelUpPreview>();
    pending.add(c);
    return c.future;
  }

  @override
  Future<CharacterData> apply(LevelUpRequest request) async {
    applied++;
    if (failApply) throw StateError('Connection failed');
    return CharacterData(
        id: request.characterId, derived: CharacterDerivedData(totalLevel: 5));
  }
}

LevelUpPreview preview({List<String> missing = const []}) => LevelUpPreview(
      before:
          CharacterData(id: 1, derived: CharacterDerivedData(totalLevel: 4)),
      character:
          CharacterData(id: 1, derived: CharacterDerivedData(totalLevel: 5)),
      classStep: ClassStepView(),
      choiceGroups: [],
      missingDecisions: missing,
      spellDelta: ClassSpellDeltaView(
          cantripsToAdd: 0,
          knownSpellsToAdd: 0,
          spellbookSpellsToAdd: 0,
          knownSpellReplacements: 0),
    );

LevelUpPreview optimisticFixture() {
  final data = ClassData(id: 1, hitDieValue: 8);
  final entry = CharacterClassEntryData(
      id: 'entry', classData: data, level: 1, hpRolledValues: [8]);
  final scores = {for (final a in Ability.values) a: 15};
  return preview().copyWith(
      before: CharacterData(
          classEntries: [entry],
          derived: CharacterDerivedData(
              totalLevel: 1,
              maxHp: 10,
              abilityScores: scores,
              abilityModifiers: {Ability.constitution: 2})),
      character: CharacterData(
          classEntries: [
            entry.copyWith(level: 2, hpRolledValues: [8, 5])
          ],
          derived: CharacterDerivedData(
              totalLevel: 2,
              maxHp: 17,
              abilityScores: scores,
              abilityModifiers: {Ability.constitution: 2})),
      classStep: ClassStepView(
          classData: data,
          subclassChoice: ClassStepSubclassChoiceView(
              requiredLevel: 2,
              subclasses: [
                SubclassData(id: 3, parentClassId: 1, name: 'New subclass')
              ]),
          spellSelectionGroups: [
            ClassSpellSelectionGroupView(
                kind: CharacterSpellSelectionKind.knownSpell,
                options: [
                  SpellData(id: 7, referenceKey: 'spell', name: 'Spell')
                ])
          ]),
      choiceGroups: [
        ChoiceGroupView(
            group: ChoiceGroupData(
                referenceKey: 'asi',
                type: ChoiceType.abilityIncrease,
                selectionCount: 2,
                allowDuplicates: true),
            options: [
              ChoiceOptionData(
                  choiceGroupId: 1,
                  optionKey: 'con',
                  grantedAbilityBonuses: {'constitution': 1})
            ])
      ]);
}

void main() {
  late FakeGateway gateway;
  late LevelUpController controller;
  setUp(() {
    gateway = FakeGateway();
    controller = LevelUpController(
        gateway,
        LevelUpRequest(
            characterId: 1,
            expectedVersion: 1,
            classEntryId: 'entry',
            hitDieRoll: 5));
  });
  tearDown(() => controller.dispose());

  test('an older async preview never replaces a newer draft', () async {
    final old = controller.refresh();
    final next = controller.setRoll(7);
    gateway.pending[1].complete(preview());
    await next;
    gateway.pending[0].complete(preview(missing: ['stale']));
    await old;
    expect(controller.state.request.hitDieRoll, 7);
    expect(controller.state.preview!.missingDecisions, isEmpty);
    expect(controller.state.canApply, true);
    expect(gateway.applied, 0);
  });

  test(
      'rolls and CON update HP immediately while further input remains available',
      () async {
    final load = controller.refresh();
    gateway.pending.last.complete(optimisticFixture());
    await load;
    final roll = controller.setRoll(7);
    expect(controller.state.busy, false);
    expect(controller.state.canApply, false);
    expect(controller.state.preview!.character.derived!.maxHp, 19);
    final asi = controller.cycleAbility('asi', Ability.constitution);
    expect(
        controller.state.preview!.character.derived!
            .abilityScores![Ability.constitution],
        16);
    expect(
        controller.state.preview!.character.derived!
            .abilityModifiers![Ability.constitution],
        3);
    expect(controller.state.preview!.character.derived!.maxHp, 21);
    gateway.pending[2].complete(optimisticFixture()
        .copyWith(character: controller.state.preview!.character));
    await asi;
    gateway.pending[1].complete(optimisticFixture());
    await roll;
    expect(controller.state.preview!.character.derived!.maxHp, 21);
    expect(controller.state.canApply, true);
    final more = controller.cycleAbility('asi', Ability.constitution);
    expect(
        controller.state.preview!.character.derived!
            .abilityScores![Ability.constitution],
        17);
    expect(controller.state.preview!.character.derived!.maxHp, 21);
    final clear = controller.cycleAbility('asi', Ability.constitution);
    expect(
        controller.state.preview!.character.derived!
            .abilityScores![Ability.constitution],
        15);
    expect(controller.state.preview!.character.derived!.maxHp, 19);
    gateway.pending.last.complete(optimisticFixture()
        .copyWith(character: controller.state.preview!.character));
    gateway.pending[gateway.pending.length - 2].complete(optimisticFixture());
    await Future.wait([more, clear]);
  });

  test(
      'subclass, choices and spell facts reflect the draft before server confirmation',
      () async {
    final load = controller.refresh();
    gateway.pending.last.complete(optimisticFixture());
    await load;
    final subclass = controller.chooseSubclass(3);
    expect(
        controller.state.preview!.character.classEntries!.single.subclass!.name,
        'New subclass');
    final choices = controller.choose('asi', ['con']);
    expect(
        controller.state.preview!.character.choices!.single.optionKey, 'con');
    final spells =
        controller.chooseSpells(CharacterSpellSelectionKind.knownSpell, [7]);
    expect(controller.state.preview!.character.spellSelections!.single.spellKey,
        'spell');
    expect(controller.state.busy, false);
    final latest = controller.state.preview!;
    for (final pending in gateway.pending.skip(1)) {
      pending.complete(latest);
    }
    await Future.wait([subclass, choices, spells]);
  });

  test('optimistic spell replacement retains the replaced logical slot',
      () async {
    final confirmed = optimisticFixture().copyWith(
      before: optimisticFixture().before.copyWith(spellSelections: [
        for (final index in [4, 9])
          CharacterSpellSelectionData(
            id: 'known-$index',
            classEntry: CharacterClassEntryData(id: 'entry'),
            kind: CharacterSpellSelectionKind.knownSpell,
            spellId: index,
            spellKey: 'old-$index',
            selectionIndex: index,
          ),
      ]),
      classStep: optimisticFixture().classStep.copyWith(
        spellSelectionGroups: [
          ClassSpellSelectionGroupView(
            kind: CharacterSpellSelectionKind.knownSpell,
            options: [SpellData(id: 7, referenceKey: 'replacement-spell')],
          ),
        ],
      ),
      spellDelta: ClassSpellDeltaView(
        cantripsToAdd: 0,
        knownSpellsToAdd: 0,
        spellbookSpellsToAdd: 0,
        knownSpellReplacements: 1,
      ),
    );
    final load = controller.refresh();
    gateway.pending.last.complete(confirmed);
    await load;

    final replacement = controller.chooseSpells(
      CharacterSpellSelectionKind.knownSpell,
      [7],
      replacesSelectionId: 'known-4',
    );
    final selections = controller.state.preview!.character.spellSelections!;
    expect(selections.map((s) => s.id), ['known-9', null]);
    expect(selections.last.selectionIndex, 4);
    expect(selections.last.spellKey, 'replacement-spell');
    gateway.pending.last.complete(confirmed);
    await replacement;
  });

  test(
      'a failed background preview keeps the draft editable and prevents saving unvalidated data',
      () async {
    final load = controller.refresh();
    gateway.pending.last.complete(optimisticFixture());
    await load;
    final roll = controller.setRoll(7);
    gateway.pending.last.completeError(StateError('Offline'));
    await roll;
    expect(controller.state.preview!.character.derived!.maxHp, 19);
    expect(controller.state.request.hitDieRoll, 7);
    expect(controller.state.busy, false);
    expect(controller.state.error, isA<StateError>());
    expect(await controller.apply(), isNull);
    expect(gateway.applied, 0);
    final retry = controller.setRoll(1);
    expect(controller.state.preview!.character.derived!.maxHp, 13);
    gateway.pending.last.complete(optimisticFixture()
        .copyWith(character: controller.state.preview!.character));
    await retry;
    expect(controller.state.canApply, true);
  });

  test('incomplete preview cannot apply and failure keeps draft available',
      () async {
    final load = controller.refresh();
    gateway.pending.last.complete(preview(missing: ['Choose subclass']));
    await load;
    expect(await controller.apply(), isNull);
    expect(gateway.applied, 0);
    final change = controller.setRoll(7);
    gateway.pending.last.complete(preview());
    await change;
    gateway.failApply = true;
    expect(await controller.apply(), isNull);
    expect(controller.state.preview!.before.derived!.totalLevel, 4);
    expect(controller.state.error, isA<StateError>());
    expect(controller.state.busy, false);
  });

  test('changing subclass preserves completed class choices', () async {
    controller.dispose();
    controller = LevelUpController(
        gateway,
        LevelUpRequest(
            characterId: 1,
            expectedVersion: 1,
            classEntryId: 'entry',
            hitDieRoll: 5,
            choices: {
              'class_pick': ['a'],
              'sub_pick': ['b']
            }));
    final current = preview().copyWith(choiceGroups: [
      ChoiceGroupView(
          group: ChoiceGroupData(referenceKey: 'class_pick', sourceClassId: 1)),
      ChoiceGroupView(
          group:
              ChoiceGroupData(referenceKey: 'sub_pick', sourceSubclassId: 2)),
    ]);
    final load = controller.refresh();
    gateway.pending.last.complete(current);
    await load;
    final changed = controller.chooseSubclass(3);
    gateway.pending.last.complete(current);
    await changed;
    expect(controller.state.request.choices, {
      'class_pick': ['a']
    });
  });

  test('draft input is locked while the atomic application is in flight',
      () async {
    final load = controller.refresh();
    gateway.pending.last.complete(preview());
    await load;
    final applied = controller.apply();
    final changed = controller.setRoll(1);
    expect(controller.state.request.hitDieRoll, 5);
    await changed;
    await applied;
  });
}
