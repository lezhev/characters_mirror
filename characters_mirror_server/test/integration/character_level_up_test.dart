import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/rate_limiting/character_save_rate_limiter.dart';
import 'package:characters_mirror_server/src/validation/character_validator.dart';
import 'package:characters_mirror_server/src/validation/validation_exception.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Atomic level-up', (sessions, endpoints) {
    setUp(CharacterSaveRateLimiter.resetForTests);
    final owner = sessions.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(941, <Scope>{}),
    );

    Future<CharacterData> fixture({int level = 4, bool asi = false}) async {
      final session = owner.build();
      try {
        final data = await ClassData.db.insertRow(
            session,
            ClassData(
                name: 'Test class',
                referenceKey: 'test_level_up',
                hitDieValue: 8));
        final feature = await ClassFeatureData.db.insertRow(
            session,
            ClassFeatureData(
                parentClassId: data.id!, referenceKey: 'test_pool', level: 1));
        await FeatureResourceDefinitionData.db.insertRow(
            session,
            FeatureResourceDefinitionData(
                classFeatureId: feature.id!,
                key: 'pool',
                kind: FeatureResourceKind.points,
                maxRule: FeatureResourceMaxRule.sourceClassLevel));
        final newFeature = await ClassFeatureData.db.insertRow(
            session,
            ClassFeatureData(
                parentClassId: data.id!,
                referenceKey: 'new_pool',
                level: level + 1));
        await FeatureResourceDefinitionData.db.insertRow(
            session,
            FeatureResourceDefinitionData(
                classFeatureId: newFeature.id!,
                key: 'new',
                kind: FeatureResourceKind.points,
                maxRule: FeatureResourceMaxRule.fixed,
                maxValue: 2));
        if (asi) {
          final group = await ChoiceGroupData.db.insertRow(
              session,
              ChoiceGroupData(
                  referenceKey: 'test_asi',
                  sourceClassId: data.id!,
                  level: level + 1,
                  type: ChoiceType.abilityIncrease,
                  selectionCount: 1));
          await ChoiceOptionData.db.insertRow(
              session,
              ChoiceOptionData(
                  choiceGroupId: group.id!,
                  optionKey: 'con2',
                  grantedAbilityBonuses: {'constitution': 2}));
        }
        return endpoints.characterData.saveCharacter(
            owner,
            CharacterData(
                name: 'Level-up test',
                baseAbilityScores: {'constitution': 14},
                currentHp: 7,
                classEntries: [
                  CharacterClassEntryData(
                      id: 'entry',
                      classData: data,
                      level: level,
                      isStartingClass: true,
                      hpRolledValues: [8, ...List.filled(level - 1, 5)])
                ],
                currentHitDice: {'d8': 1},
                resourceStates: [
                  CharacterResourceStateData(
                      sourceType: CharacterFeatureSourceType.classFeature,
                      sourceId: feature.id!,
                      resourceKey: 'pool',
                      current: 1)
                ]));
      } finally {
        await session.close();
      }
    }

    Future<({CharacterData character, List<SpellData> spells})> spellFixture({
      required int nextKnownSpells,
      int replacements = 0,
      bool withOtherScopes = false,
    }) async {
      final session = owner.build();
      late ClassData data;
      late List<SpellData> spells;
      late ClassData? otherData;
      late SpellData? cantrip;
      late SpellData? spellbookSpell;
      late SpellData? otherEntrySpell;
      try {
        data = await ClassData.db.insertRow(
          session,
          ClassData(
            name: 'Spell slot test class',
            referenceKey:
                'spell_slots_${DateTime.now().microsecondsSinceEpoch}',
            hitDieValue: 8,
            spellSelectionMode: ClassSpellSelectionMode.known,
            spellcastingProgression: SpellcastingProgression.full,
          ),
        );
        await ClassLevelData.db.insertRow(
          session,
          ClassLevelData(
            classDataId: data.id!,
            level: 4,
            knownSpells: 10,
          ),
        );
        await ClassLevelData.db.insertRow(
          session,
          ClassLevelData(
            classDataId: data.id!,
            level: 5,
            knownSpells: nextKnownSpells,
            knownSpellReplacements: replacements,
          ),
        );
        spells = [
          for (var i = 0; i < 12; i++)
            await SpellData.db.insertRow(
              session,
              SpellData(
                referenceKey: 'level_up_slot_spell_$i',
                name: 'Slot spell $i',
                level: 1,
                availableForClassIds: [data.id!],
              ),
            ),
        ];
        otherData = null;
        cantrip = null;
        spellbookSpell = null;
        otherEntrySpell = null;
        if (withOtherScopes) {
          otherData = await ClassData.db.insertRow(
            session,
            ClassData(
              name: 'Other spell slot class',
              referenceKey:
                  'other_spell_slots_${DateTime.now().microsecondsSinceEpoch}',
              hitDieValue: 6,
            ),
          );
          cantrip = await SpellData.db.insertRow(
            session,
            SpellData(
                referenceKey: 'other_kind_cantrip',
                name: 'Other cantrip',
                level: 0),
          );
          spellbookSpell = await SpellData.db.insertRow(
            session,
            SpellData(
                referenceKey: 'other_kind_book',
                name: 'Other book spell',
                level: 1),
          );
          otherEntrySpell = await SpellData.db.insertRow(
            session,
            SpellData(
                referenceKey: 'other_entry_spell',
                name: 'Other entry spell',
                level: 1),
          );
        }
      } finally {
        await session.close();
      }
      final entry = CharacterClassEntryData(
        id: 'entry',
        classData: data,
        level: 4,
        isStartingClass: true,
        hpRolledValues: [8, 5, 5, 5],
      );
      final otherEntry = withOtherScopes
          ? CharacterClassEntryData(
              id: 'other-entry',
              classData: otherData,
              level: 1,
              isStartingClass: false,
              hpRolledValues: [4],
            )
          : null;
      final selections = <CharacterSpellSelectionData>[
        for (var i = 0; i < 10; i++)
          CharacterSpellSelectionData(
            id: 'known-$i',
            classEntry: entry,
            classDataId: data.id,
            spell: spells[i],
            spellId: spells[i].id,
            spellKey: spells[i].referenceKey,
            kind: CharacterSpellSelectionKind.knownSpell,
            selectionIndex: i,
          ),
        if (withOtherScopes) ...[
          CharacterSpellSelectionData(
            id: 'cantrip-40',
            classEntry: entry,
            classDataId: data.id,
            spell: cantrip,
            spellId: cantrip!.id,
            spellKey: cantrip.referenceKey,
            kind: CharacterSpellSelectionKind.knownCantrip,
            selectionIndex: 40,
          ),
          CharacterSpellSelectionData(
            id: 'book-30',
            classEntry: entry,
            classDataId: data.id,
            spell: spellbookSpell,
            spellId: spellbookSpell!.id,
            spellKey: spellbookSpell.referenceKey,
            kind: CharacterSpellSelectionKind.spellbookSpell,
            selectionIndex: 30,
          ),
          CharacterSpellSelectionData(
            id: 'other-entry-50',
            classEntry: otherEntry,
            classDataId: otherData!.id,
            spell: otherEntrySpell,
            spellId: otherEntrySpell!.id,
            spellKey: otherEntrySpell.referenceKey,
            kind: CharacterSpellSelectionKind.knownSpell,
            selectionIndex: 50,
          ),
        ],
      ];
      final character = await endpoints.characterData.saveCharacter(
        owner,
        CharacterData(
          name: 'Spell slot test',
          currentHp: 20,
          baseAbilityScores: {'charisma': 14},
          classEntries: [entry, if (otherEntry != null) otherEntry],
          spellSelections: selections,
        ),
      );
      return (character: character, spells: spells);
    }

    LevelUpRequest request(CharacterData c,
            {Map<String, List<String>>? choices, int? roll}) =>
        LevelUpRequest(
            characterId: c.id!,
            expectedVersion: c.version!,
            classEntryId: 'entry',
            hitDieRoll: roll ?? 5,
            choices: choices);

    test(
        'preview is transient, application increments once and preserves spent resources',
        () async {
      final before = await fixture();
      final preview =
          await endpoints.characterData.previewLevelUp(owner, request(before));
      expect(preview.character.derived?.totalLevel, 5);
      expect(preview.before.derived?.proficiencyBonus, 2);
      expect(preview.character.derived?.proficiencyBonus, 3);
      expect(
          (await endpoints.characterData.getCharacter(owner, before.id!))
              .derived
              ?.totalLevel,
          4);
      final after =
          await endpoints.characterData.applyLevelUp(owner, request(before));
      expect(after.derived?.maxHp, before.derived!.maxHp! + 7);
      expect(after.currentHp, 7);
      expect(after.currentHitDice?['d8'], 1);
      final resources = after.derived!.activeFeatures!
          .expand((f) => f.resources ?? <CharacterResourceViewData>[]);
      expect(resources.firstWhere((r) => r.key == 'pool').current, 1);
      expect(resources.firstWhere((r) => r.key == 'pool').max, 5);
      expect(resources.firstWhere((r) => r.key == 'new').current, 2);
      await expectLater(
          endpoints.characterData.applyLevelUp(owner, request(before)),
          throwsA(isA<InputValidationException>()));
      expect(
          (await endpoints.characterData.getCharacter(owner, before.id!))
              .derived
              ?.totalLevel,
          5);
    });

    test('full existing resources also preserve their old current', () async {
      final base = await fixture();
      final full = await endpoints.characterData
          .saveCharacter(owner, base.copyWith(resourceStates: []));
      final after =
          await endpoints.characterData.applyLevelUp(owner, request(full));
      final pool = after.derived!.activeFeatures!
          .expand((f) => f.resources ?? <CharacterResourceViewData>[])
          .firstWhere((r) => r.key == 'pool');
      expect(pool.current, 4);
      expect(pool.max, 5);
    });

    test('ASI is required and CON changes HP retroactively without healing',
        () async {
      final before = await fixture(level: 3, asi: true);
      final preview =
          await endpoints.characterData.previewLevelUp(owner, request(before));
      expect(preview.missingDecisions, isNotEmpty);
      await expectLater(
          endpoints.characterData.applyLevelUp(owner, request(before)),
          throwsA(isA<InputValidationException>()));
      final after = await endpoints.characterData.applyLevelUp(
          owner,
          request(before, choices: {
            'test_asi': ['con2']
          }));
      expect(after.derived?.abilityScores?[Ability.constitution], 16);
      expect(after.derived?.maxHp, before.derived!.maxHp! + 8 + 3);
      expect(after.currentHp, 7);
    });

    test('rejects out-of-die rolls, foreign choices, and foreign ownership',
        () async {
      final before = await fixture();
      for (final roll in [0, 9]) {
        await expectLater(
            endpoints.characterData
                .applyLevelUp(owner, request(before, roll: roll)),
            throwsA(isA<InputValidationException>()));
      }
      await expectLater(
          endpoints.characterData.applyLevelUp(
              owner,
              request(before, choices: {
                'unknown': ['x']
              })),
          throwsA(isA<InputValidationException>()));
      final other = sessions.copyWith(
          authentication:
              AuthenticationOverride.authenticationInfo(942, <Scope>{}));
      await expectLater(
          endpoints.characterData.applyLevelUp(other, request(before)),
          throwsA(isA<Exception>()));
      expect(
          (await endpoints.characterData.getCharacter(owner, before.id!))
              .version,
          before.version);
    });

    test('selecting an exclusive ASI does not bypass its two-point budget',
        () async {
      final before = await fixture(level: 3, asi: true);
      final session = owner.build();
      try {
        final group = (await ChoiceGroupData.db
                .find(session, where: (t) => t.referenceKey.equals('test_asi')))
            .single;
        await ChoiceGroupData.db
            .updateRow(session, group.copyWith(exclusiveKey: 'asi_or_feat'));
        await ChoiceOptionData.db.insertRow(
            session,
            ChoiceOptionData(
                choiceGroupId: group.id!,
                optionKey: 'con1',
                grantedAbilityBonuses: {'constitution': 1}));
      } finally {
        await session.close();
      }
      final incomplete = request(before, choices: {
        'test_asi': ['con1']
      });
      expect(
          (await endpoints.characterData.previewLevelUp(owner, incomplete))
              .missingDecisions,
          isNotEmpty);
      await expectLater(endpoints.characterData.applyLevelUp(owner, incomplete),
          throwsA(isA<InputValidationException>()));
      expect(
          (await endpoints.characterData.getCharacter(owner, before.id!))
              .version,
          before.version);
    });

    test(
        'subclass choice unlocks subclass features and multiple mandatory choices',
        () async {
      final base = await fixture(level: 2);
      final session = owner.build();
      late SubclassData subclass;
      late CharacterData before;
      try {
        final data = base.classEntries!.single.classData!;
        await ClassData.db
            .updateRow(session, data.copyWith(subclassChoiceLevel: 3));
        subclass = await SubclassData.db.insertRow(
            session,
            SubclassData(
                parentClassId: data.id!,
                levelRequired: 3,
                name: 'Test subclass'));
        final feature = await SubclassFeatureData.db.insertRow(
            session,
            SubclassFeatureData(
                parentSubclassId: subclass.id!,
                referenceKey: 'sub_new',
                level: 3));
        for (final key in ['first', 'second']) {
          final group = await ChoiceGroupData.db.insertRow(
              session,
              ChoiceGroupData(
                  referenceKey: key,
                  sourceSubclassFeatureId: feature.id!,
                  type: ChoiceType.featureOption,
                  selectionCount: 1));
          await ChoiceOptionData.db.insertRow(session,
              ChoiceOptionData(choiceGroupId: group.id!, optionKey: 'a'));
        }
        before = await endpoints.characterData.getCharacter(owner, base.id!);
      } finally {
        await session.close();
      }
      expect(
          (await endpoints.characterData.previewLevelUp(owner, request(before)))
              .missingDecisions,
          contains('Выберите подкласс'));
      final selected = request(before).copyWith(subclassId: subclass.id);
      final preview =
          await endpoints.characterData.previewLevelUp(owner, selected);
      expect(preview.choiceGroups.length, 2);
      expect(preview.missingDecisions.length, 2);
      await expectLater(
          endpoints.characterData.applyLevelUp(
              owner,
              selected.copyWith(choices: {
                'first': ['a']
              })),
          throwsA(isA<InputValidationException>()));
      final after = await endpoints.characterData.applyLevelUp(
          owner,
          selected.copyWith(choices: {
            'first': ['a'],
            'second': ['a']
          }));
      expect(after.classEntries!.single.subclass?.id, subclass.id);
      expect(after.choices!.length, 2);
      expect(
          after.derived!.activeFeatures!.any((f) =>
              f.sourceType == CharacterFeatureSourceType.subclassFeature),
          true);
    });

    test(
        'a missing earlier subclass does not block this level-up or get assigned automatically',
        () async {
      final base = await fixture(level: 1);
      final session = owner.build();
      try {
        final data = base.classEntries!.single.classData!;
        await ClassData.db
            .updateRow(session, data.copyWith(subclassChoiceLevel: 1));
        await SubclassData.db.insertRow(
            session, SubclassData(parentClassId: data.id!, levelRequired: 1));
      } finally {
        await session.close();
      }
      final before =
          await endpoints.characterData.getCharacter(owner, base.id!);
      final preview =
          await endpoints.characterData.previewLevelUp(owner, request(before));
      expect(preview.missingDecisions, isNot(contains('Выберите подкласс')));
      final after =
          await endpoints.characterData.applyLevelUp(owner, request(before));
      expect(after.classEntries!.single.level, 2);
      expect(after.classEntries!.single.subclass, isNull);
    });

    test(
        'new spells use canonical IDs and new slot levels fill without restoring existing slots',
        () async {
      final session = owner.build();
      late ClassData data;
      late SpellData spell;
      try {
        data = await ClassData.db.insertRow(
            session,
            ClassData(
                name: 'Test caster',
                hitDieValue: 6,
                spellSelectionMode: ClassSpellSelectionMode.known,
                spellcastingProgression: SpellcastingProgression.full));
        for (final (level, count) in [(4, 4), (5, 5)]) {
          await ClassLevelData.db.insertRow(
              session,
              ClassLevelData(
                  classDataId: data.id!, level: level, knownSpells: count));
        }
        for (final (level, slots) in [
          (4, {1: 4, 2: 3}),
          (5, {1: 4, 2: 3, 3: 2})
        ]) {
          final existing = await SpellSlotProgressionData.db.find(session,
              where: (t) =>
                  t.tableKey.equals('standard') & t.level.equals(level));
          if (existing.isEmpty) {
            await SpellSlotProgressionData.db.insertRow(
                session,
                SpellSlotProgressionData(
                    tableKey: 'standard', level: level, spellSlots: slots));
          }
        }
        spell = await SpellData.db.insertRow(
            session,
            SpellData(
                referenceKey: 'level_up_spell',
                name: 'New spell',
                level: 3,
                availableForClassIds: [data.id!]));
      } finally {
        await session.close();
      }
      final before = await endpoints.characterData.saveCharacter(
          owner,
          CharacterData(name: 'Caster', currentHp: 8, classEntries: [
            CharacterClassEntryData(
                id: 'entry', classData: data, level: 4, isStartingClass: true)
          ], currentSpellSlots: {
            1: 1,
            2: 0
          }));
      final preview =
          await endpoints.characterData.previewLevelUp(owner, request(before));
      expect(preview.spellDelta.knownSpellsToAdd, 1);
      expect(preview.character.currentSpellSlots, {1: 1, 2: 0, 3: 2});
      await expectLater(
          endpoints.characterData.applyLevelUp(owner, request(before)),
          throwsA(isA<InputValidationException>()));
      final after = await endpoints.characterData.applyLevelUp(
          owner,
          request(before).copyWith(spells: [
            LevelUpSpellChoice(
                spellId: spell.id!,
                kind: CharacterSpellSelectionKind.knownSpell)
          ]));
      expect(after.currentSpellSlots, {1: 1, 2: 0, 3: 2});
      expect(after.currentHp, 8);
      expect(after.spellSelections!.single.spellId, spell.id);
      expect(
          after.spellSelections!.single.spell?.referenceKey, 'level_up_spell');
    });

    test('replacement inherits a middle known-spell slot without renumbering',
        () async {
      final setup = await spellFixture(nextKnownSpells: 10, replacements: 1);
      final before = setup.character;
      final after = await endpoints.characterData.applyLevelUp(
        owner,
        request(before).copyWith(spells: [
          LevelUpSpellChoice(
            spellId: setup.spells[10].id!,
            kind: CharacterSpellSelectionKind.knownSpell,
            replacesSelectionId: 'known-4',
          ),
        ]),
      );

      final known = after.spellSelections!
          .where((s) =>
              s.classEntry?.id == 'entry' &&
              s.kind == CharacterSpellSelectionKind.knownSpell)
          .toList();
      expect(known, hasLength(10));
      expect(known.singleWhere((s) => s.selectionIndex == 4).spellKey,
          setup.spells[10].referenceKey);
      expect(known.singleWhere((s) => s.selectionIndex == 9).spellKey,
          setup.spells[9].referenceKey);
      expect(known.map((s) => s.selectionIndex).toSet(),
          Set<int>.from(List.generate(10, (i) => i)));
      CharacterValidator.validate(after);
    });

    test('replacement of the last known-spell slot retains its index',
        () async {
      final setup = await spellFixture(nextKnownSpells: 10, replacements: 1);
      final after = await endpoints.characterData.applyLevelUp(
        owner,
        request(setup.character).copyWith(spells: [
          LevelUpSpellChoice(
            spellId: setup.spells[10].id!,
            kind: CharacterSpellSelectionKind.knownSpell,
            replacesSelectionId: 'known-9',
          ),
        ]),
      );

      final known = after.spellSelections!
          .where((s) =>
              s.classEntry?.id == 'entry' &&
              s.kind == CharacterSpellSelectionKind.knownSpell)
          .toList();
      expect(known, hasLength(10));
      expect(known.singleWhere((s) => s.selectionIndex == 9).spellKey,
          setup.spells[10].referenceKey);
      expect(known.map((s) => s.selectionIndex).toSet(),
          Set<int>.from(List.generate(10, (i) => i)));
      CharacterValidator.validate(after);
    });

    test('new known spell uses max index within its entry and kind', () async {
      final setup = await spellFixture(
        nextKnownSpells: 11,
        withOtherScopes: true,
      );
      final after = await endpoints.characterData.applyLevelUp(
        owner,
        request(setup.character).copyWith(spells: [
          LevelUpSpellChoice(
            spellId: setup.spells[10].id!,
            kind: CharacterSpellSelectionKind.knownSpell,
          ),
        ]),
      );

      final added = after.spellSelections!.singleWhere(
        (s) => s.spellKey == setup.spells[10].referenceKey,
      );
      expect(added.classEntry?.id, 'entry');
      expect(added.kind, CharacterSpellSelectionKind.knownSpell);
      expect(added.selectionIndex, 10);
      expect(
        after.spellSelections!
            .singleWhere((s) => s.id == 'cantrip-40')
            .selectionIndex,
        40,
      );
      expect(
        after.spellSelections!
            .singleWhere((s) => s.id == 'book-30')
            .selectionIndex,
        30,
      );
      expect(
        after.spellSelections!
            .singleWhere((s) => s.id == 'other-entry-50')
            .selectionIndex,
        50,
      );
      CharacterValidator.validate(after);
    });
  });
}
