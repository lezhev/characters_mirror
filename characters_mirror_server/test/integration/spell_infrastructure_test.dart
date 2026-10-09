import 'dart:convert';
import 'dart:io';
import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/rate_limiting/character_save_rate_limiter.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Generic spell and progression contracts',
      (sessions, endpoints) {
    final owner = sessions.copyWith(
        authentication:
            AuthenticationOverride.authenticationInfo(9642, <Scope>{}));
    setUp(CharacterSaveRateLimiter.resetForTests);

    Future<CharacterData> caster(SpellActivationData activation,
        {bool choice = false}) async {
      final db = sessions.build();
      try {
        final data = await ClassData.db.insertRow(
            db, ClassData(referenceKey: 'activation_fixture', hitDieValue: 8));
        final feature = await ClassFeatureData.db.insertRow(
            db,
            ClassFeatureData(
                parentClassId: data.id!,
                referenceKey: 'activation_pool',
                level: 1));
        await FeatureResourceDefinitionData.db.insertRow(
            db,
            FeatureResourceDefinitionData(
                classFeatureId: feature.id!,
                key: 'ki',
                kind: FeatureResourceKind.points,
                maxRule: FeatureResourceMaxRule.sourceClassLevel,
                resetOn: RestType.shortRest));
        final spell = await SpellData.db.insertRow(
            db,
            SpellData(
                referenceKey: 'activation_spell',
                name: 'Activation spell',
                level: 1));
        ChoiceOptionData? option;
        ChoiceGroupData? group;
        if (choice) {
          group = await ChoiceGroupData.db.insertRow(
              db,
              ChoiceGroupData(
                  referenceKey: 'activation_choice',
                  sourceClassId: data.id!,
                  level: 1,
                  selectionCount: 1,
                  type: ChoiceType.custom));
          option = await ChoiceOptionData.db.insertRow(
              db,
              ChoiceOptionData(
                  choiceGroupId: group.id!,
                  optionKey: 'chosen',
                  grantedSpellKeys: [spell.referenceKey]));
        }
        await ClassSpellGrantData.db.insertRow(
            db,
            ClassSpellGrantData(
                spellId: spell.id!,
                sourceClassId: data.id!,
                choiceOptionId: option?.id,
                activation: activation,
                alwaysPrepared: true));
        final entry = CharacterClassEntryData(
            id: 'entry', classData: data, level: 3, isStartingClass: true);
        return await endpoints.characterData.saveCharacter(
            owner,
            CharacterData(
                name: 'Activation fixture',
                classEntries: [entry],
                choices: group == null
                    ? null
                    : [
                        CharacterChoiceData(
                            id: 'choice',
                            classEntry: entry,
                            groupKey: group.referenceKey,
                            optionKey: option!.optionKey,
                            selectionIndex: 0)
                      ]));
      } finally {
        await db.close();
      }
    }

    CharacterSyncOperationData op(
        CharacterData c,
        CharacterSyncOperationType type,
        CharacterSemanticActionData action,
        String id) {
      final targets = type == CharacterSyncOperationType.castSpell
          ? spellActivationActionTargets(c.toJson(), action.toJson())
          : [
              ...spellActivationRestTargets(c.toJson(), action.restType!.name),
              ...?c.syncTargetRevisions?.keys,
              ...?c.syncBarrierTokens?.keys,
              for (final die in c.derived?.hitDiceSummary?.keys ?? <String>[])
                'map:currentHitDice:$die',
              for (final level in c.derived?.spellSlots?.keys ?? <int>[])
                'map:currentSpellSlots:$level',
              for (final level in c.derived?.pactSlots?.keys ?? <int>[])
                'map:currentPactSlots:$level',
              for (final f
                  in c.derived?.activeFeatures ?? <CharacterFeatureViewData>[])
                for (final r in f.resources ?? <CharacterResourceViewData>[])
                  'resource:${f.sourceType.name}:${f.sourceId}:${r.key}'
            ];
      return CharacterSyncOperationData(
          id: id,
          characterId: c.id,
          localCharacterId: c.id,
          type: type,
          targetType: CharacterSyncTargetType.field,
          baseCharacterRevision: c.version,
          value: CharacterSyncValueData(
              semanticActionValue: action.copyWith(baseBarrierTokens: {
            for (final target in targets)
              target: c.syncBarrierTokens?[target] ??
                  'revision:${c.syncTargetRevisions?[target] ?? 0}'
          })),
          createdAt: DateTime.utc(2026, 10, 8));
    }

    Future<CharacterData> apply(
        CharacterData c,
        CharacterSyncOperationType type,
        CharacterSemanticActionData action,
        String id) async {
      final operation = op(c, type, action, id);
      final result = await endpoints.characterData.syncCharacters(
          owner,
          CharacterSyncRequest(
              syncProtocolVersion: 6, operations: [operation]));
      expect(result.rejectedChanges, isEmpty);
      final next = result.changedCharacters![id]!;
      final path = Platform.environment['SPELL_INFRASTRUCTURE_REPLAY'];
      if (path != null) {
        File(path).writeAsStringSync(
            '${jsonEncode({
                  'before': c.toJson(),
                  'operation': operation.toJson(),
                  'after': next.toJson()
                })}\n',
            mode: FileMode.append);
      }
      return next;
    }

    CharacterSemanticActionData cast(CharacterData c, String payment) =>
        CharacterSemanticActionData(
            spellKey: 'activation_spell',
            spellSourceKey:
                c.derived!.resolvedSpells!.single.sources.single.sourceKey,
            level: 1,
            slotSource: 'none',
            spellPayment: payment);

    test('Four Elements and Shadow Arts share atomic ki-only choice grants',
        () async {
      final c = await caster(
          SpellActivationData(
              canUseStandardSlots: false,
              canUsePactSlots: false,
              slotless: true,
              atWill: false,
              resourceKey: 'ki',
              resourceCost: 2),
          choice: true);
      expect(c.derived!.resolvedSpells!.single.sources, hasLength(1));
      final next = await apply(c, CharacterSyncOperationType.castSpell,
          cast(c, 'resource'), 'ki_cast');
      expect(next.resourceStates!.single.current, 1);
      expect(next.currentSpellSlots, c.currentSpellSlots);
      final rejected = await endpoints.characterData.syncCharacters(
          owner,
          CharacterSyncRequest(syncProtocolVersion: 6, operations: [
            op(c, CharacterSyncOperationType.castSpell, cast(c, 'resource'),
                'ki_retry')
          ]));
      expect(rejected.rejectedChanges, hasLength(1));
      final stored = await endpoints.characterData.getCharacter(owner, c.id!);
      expect(stored.resourceStates!.single.current, 1);
    });
    test('Mystic Arcanum counter is authoritative and long-rest resettable',
        () async {
      final c = await caster(SpellActivationData(
          canUseStandardSlots: false,
          canUsePactSlots: false,
          slotless: true,
          atWill: false,
          freeCasts: 1,
          resetOn: RestType.longRest));
      final spent = await apply(c, CharacterSyncOperationType.castSpell,
          cast(c, 'free'), 'free_cast');
      expect(spent.spellActivationUses!.values.single, 1);
      final forged = await endpoints.characterData.saveCharacter(
          owner,
          spent.copyWith(
              spellActivationUses: {}, updatedAt: DateTime.now().toUtc()));
      expect(forged.spellActivationUses!.values.single, 1);
      final short = await apply(
          forged,
          CharacterSyncOperationType.applyRest,
          CharacterSemanticActionData(restType: RestType.shortRest),
          'short_rest');
      expect(short.spellActivationUses!.values.single, 1);
      final long = await apply(
          short,
          CharacterSyncOperationType.applyRest,
          CharacterSemanticActionData(restType: RestType.longRest),
          'long_rest');
      expect(long.spellActivationUses, isNull);
      await apply(long, CharacterSyncOperationType.castSpell,
          cast(long, 'free'), 'free_again');
    });

    Future<(ClassData, List<SpellData>)> filteredFixture(
        List<SpellSchool> schools,
        {bool replacement = false}) async {
      final db = sessions.build();
      try {
        final list = await ClassData.db
            .insertRow(db, ClassData(referenceKey: 'reference_list_fixture'));
        final data = await ClassData.db.insertRow(
            db,
            ClassData(
                referenceKey: 'filtered_fixture',
                hitDieValue: 8,
                spellcastingProgression: SpellcastingProgression.full,
                spellcastingAbilityValue: Ability.intelligence,
                spellSelectionMode: ClassSpellSelectionMode.known,
                spellSelectionFilter: SpellSelectionFilterData(
                    spellListClassKey: list.referenceKey,
                    schools: schools,
                    kinds: [CharacterSpellSelectionKind.knownSpell],
                    unrestrictedChoicesByLevel:
                        replacement ? {1: 1, 2: 2} : {1: 1})));
        for (final level in [1, 2]) {
          await ClassLevelData.db.insertRow(
              db,
              ClassLevelData(
                  classDataId: data.id!,
                  level: level,
                  knownSpells: replacement ? 2 : level + 1,
                  knownSpellReplacements:
                      replacement && level == 2 ? 1 : null));
        }
        for (final level in [1, 2]) {
          if (await SpellSlotProgressionData.db.findFirstRow(db,
                  where: (t) =>
                      t.tableKey.equals('standard') & t.level.equals(level)) ==
              null) {
            await SpellSlotProgressionData.db.insertRow(
                db,
                SpellSlotProgressionData(
                    tableKey: 'standard', level: level, spellSlots: {1: 2}));
          }
        }
        final spells = <SpellData>[];
        for (var i = 0; i < 4; i++) {
          spells.add(await SpellData.db.insertRow(
              db,
              SpellData(
                  referenceKey: 'filter_spell_$i',
                  level: 1,
                  schoolValue: i < 2 ? schools.first : SpellSchool.necromancy,
                  availableForClassIds: [list.id!])));
        }
        return (data, spells);
      } finally {
        await db.close();
      }
    }

    CharacterData selected(ClassData data, List<SpellData> spells) {
      final entry = CharacterClassEntryData(
          id: 'entry', classData: data, level: 1, isStartingClass: true);
      return CharacterData(name: 'Filtered fixture', classEntries: [
        entry
      ], spellSelections: [
        for (var i = 0; i < spells.length; i++)
          CharacterSpellSelectionData(
              id: 'spell_$i',
              classEntry: entry,
              classDataId: data.id,
              spellId: spells[i].id,
              spellKey: spells[i].referenceKey,
              kind: CharacterSpellSelectionKind.knownSpell,
              selectionIndex: i)
      ]);
    }

    for (final schools in [
      [SpellSchool.abjuration, SpellSchool.evocation],
      [SpellSchool.enchantment, SpellSchool.illusion]
    ]) {
      test(
          'School quota applies to creation and level-up: ${schools.first.name}',
          () async {
        final (data, spells) = await filteredFixture(schools);
        final forged = selected(data, [spells[0]]);
        await expectLater(
            endpoints.characterData.saveCharacter(
                owner,
                forged.copyWith(spellSelections: [
                  forged.spellSelections!.single.copyWith(
                      spellId: spells[2].id, spellKey: spells[0].referenceKey)
                ])),
            throwsA(anything));
        await expectLater(
            endpoints.characterData
                .saveCharacter(owner, selected(data, spells.sublist(2))),
            throwsA(anything));
        final c = await endpoints.characterData
            .saveCharacter(owner, selected(data, [spells[0], spells[2]]));
        expect(
            c.spellSelections!
                .map((selection) => selection.selectionUnrestricted),
            [false, true]);
        final request = LevelUpRequest(
            characterId: c.id!,
            expectedVersion: c.version!,
            classEntryId: 'entry',
            hitDieRoll: 5,
            spells: [
              LevelUpSpellChoice(
                  spellId: spells[3].id!,
                  kind: CharacterSpellSelectionKind.knownSpell)
            ]);
        await expectLater(endpoints.characterData.applyLevelUp(owner, request),
            throwsA(anything));
        final valid = await endpoints.characterData.applyLevelUp(
            owner,
            request.copyWith(spells: [
              LevelUpSpellChoice(
                  spellId: spells[1].id!,
                  kind: CharacterSpellSelectionKind.knownSpell)
            ]));
        expect(valid.spellSelections, hasLength(3));
      });
    }

    test('level-up preserves server-validated spell replacement provenance',
        () async {
      final (data, spells) = await filteredFixture(
          [SpellSchool.abjuration, SpellSchool.evocation],
          replacement: true);
      final entry = CharacterClassEntryData(
          id: 'entry', classData: data, level: 1, isStartingClass: true);
      final rule = data.spellSelectionFilter!;
      final c = await endpoints.characterData.saveCharacter(
          owner,
          CharacterData(name: 'Spell replacement fixture', classEntries: [
            entry
          ], spellSelections: [
            CharacterSpellSelectionData(
                id: 'restricted-slot',
                classEntry: entry,
                classDataId: data.id,
                spell: spells[0],
                spellId: spells[0].id,
                spellKey: spells[0].referenceKey,
                kind: CharacterSpellSelectionKind.knownSpell,
                selectionIndex: 0,
                selectionFilter: rule,
                selectionRuleLevel: 1,
                selectionUnrestricted: false),
            CharacterSpellSelectionData(
                id: 'unrestricted-slot',
                classEntry: entry,
                classDataId: data.id,
                spell: spells[2],
                spellId: spells[2].id,
                spellKey: spells[2].referenceKey,
                kind: CharacterSpellSelectionKind.knownSpell,
                selectionIndex: 1,
                selectionFilter: rule,
                selectionRuleLevel: 1,
                selectionUnrestricted: true),
          ]));
      LevelUpRequest replacementRequest(String selectionId, SpellData spell) =>
          LevelUpRequest(
              characterId: c.id!,
              expectedVersion: c.version!,
              classEntryId: 'entry',
              hitDieRoll: 5,
              spells: [
                LevelUpSpellChoice(
                    spellId: spell.id!,
                    kind: CharacterSpellSelectionKind.knownSpell,
                    replacesSelectionId: selectionId)
              ]);
      await expectLater(
          endpoints.characterData.applyLevelUp(
              owner, replacementRequest('restricted-slot', spells[2])),
          throwsA(anything));
      final replaced = await endpoints.characterData.applyLevelUp(
          owner, replacementRequest('unrestricted-slot', spells[1]));
      final unrestricted = replaced.spellSelections!
          .singleWhere((selection) => selection.id == 'unrestricted-slot');
      expect(unrestricted.spellId, spells[1].id);
      expect(unrestricted.selectionUnrestricted, isTrue);
      expect(
          unrestricted.spellReplacementHistory!.single.spellId, spells[2].id);
      final restored = await endpoints.characterData.applyLevelDown(
          owner,
          LevelDownRequest(
              characterId: replaced.id!,
              expectedVersion: replaced.version!,
              classEntryId: 'entry'));
      final original = restored.spellSelections!
          .singleWhere((selection) => selection.id == 'unrestricted-slot');
      expect(original.spellId, spells[2].id);
      expect(original.selectionUnrestricted, isTrue);
      expect(original.spellReplacementHistory, isNull);
    });

    test(
        'Progression replacement is atomic, rejects duplicate and rollback restores old selection',
        () async {
      final db = sessions.build();
      late ClassData data;
      late List<ChoiceGroupData> groups;
      try {
        data = await ClassData.db.insertRow(
            db, ClassData(referenceKey: 'replacement_fixture', hitDieValue: 8));
        groups = [];
        for (final level in [1, 2]) {
          final group = await ChoiceGroupData.db.insertRow(
              db,
              ChoiceGroupData(
                  referenceKey: 'replacement_$level',
                  sourceClassId: data.id!,
                  level: level,
                  type: ChoiceType.custom,
                  selectionCount: 1,
                  progressionKey: 'replacement_line',
                  replacementsAllowed: level == 2 ? 1 : 0));
          groups.add(group);
          for (final key in ['old', 'new', 'added', 'locked']) {
            if (level == 1 && (key == 'new' || key == 'locked')) continue;
            await ChoiceOptionData.db.insertRow(
                db,
                ChoiceOptionData(
                    choiceGroupId: group.id!,
                    optionKey: key,
                    requirements: key == 'locked'
                        ? [
                            ChoiceRequirementData(
                                type: ChoiceRequirementType.minimumClassLevel,
                                classKey: data.referenceKey,
                                value: 3)
                          ]
                        : null));
          }
        }
      } finally {
        await db.close();
      }
      final entry = CharacterClassEntryData(
          id: 'entry', classData: data, level: 1, isStartingClass: true);
      final c = await endpoints.characterData.saveCharacter(
          owner,
          CharacterData(name: 'Replacement fixture', classEntries: [
            entry
          ], choices: [
            CharacterChoiceData(
                id: 'prior',
                classEntry: entry,
                groupKey: groups[0].referenceKey,
                optionKey: 'old',
                selectionIndex: 0)
          ]));
      LevelUpRequest request(String key) => LevelUpRequest(
              characterId: c.id!,
              expectedVersion: c.version!,
              classEntryId: 'entry',
              hitDieRoll: 5,
              choices: {
                groups[1].referenceKey: ['added']
              },
              choiceReplacements: [
                LevelUpChoiceReplacementData(
                    groupKey: groups[1].referenceKey,
                    selectionId: 'prior',
                    optionKey: key)
              ]);
      for (final invalid in ['added', 'locked']) {
        await expectLater(
            endpoints.characterData.applyLevelUp(owner, request(invalid)),
            throwsA(anything));
      }
      final next =
          await endpoints.characterData.applyLevelUp(owner, request('new'));
      expect(next.choices!.firstWhere((c) => c.id == 'prior').optionKey, 'new');
      expect(
          next.choices!
              .firstWhere((c) => c.id == 'prior')
              .replacementHistory!
              .single
              .previousOptionKey,
          'old');
      await expectLater(
          endpoints.characterData.saveCharacter(
              owner,
              next.copyWith(choices: [
                for (final choice in next.choices!)
                  if (choice.id == 'prior')
                    choice.copyWith(optionKey: 'old')
                  else
                    choice
              ], updatedAt: DateTime.now().toUtc())),
          throwsA(anything));
      final higher = await endpoints.characterData.applyLevelUp(
          owner,
          LevelUpRequest(
              characterId: next.id!,
              expectedVersion: next.version!,
              classEntryId: 'entry',
              hitDieRoll: 5));
      final retained = await endpoints.characterData.applyLevelDown(
          owner,
          LevelDownRequest(
              characterId: higher.id!,
              expectedVersion: higher.version!,
              classEntryId: 'entry'));
      expect(retained.choices!.firstWhere((c) => c.id == 'prior').optionKey,
          'new');
      final down = await endpoints.characterData.applyLevelDown(
          owner,
          LevelDownRequest(
              characterId: retained.id!,
              expectedVersion: retained.version!,
              classEntryId: 'entry'));
      expect(down.choices!.single.id, 'prior');
      expect(down.choices!.single.optionKey, 'old');
      expect(down.choices!.single.replacementHistory, isNull);
    });
  });
}
