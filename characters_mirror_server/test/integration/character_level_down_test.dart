import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/rate_limiting/character_save_rate_limiter.dart';
import 'package:characters_mirror_server/src/validation/validation_exception.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Atomic level-down', (sessions, endpoints) {
    setUp(CharacterSaveRateLimiter.resetForTests);
    final owner = sessions.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(951, <Scope>{}),
    );

    Future<CharacterData> fixture({
      int level = 3,
      int hitDie = 8,
      int currentHp = 20,
      int? subclassChoiceLevel,
      int? subclassRequiredLevel,
      bool withSubclass = false,
      List<int>? hpRolls,
      List<CharacterChoiceData> choices = const [],
      List<CharacterSpellSelectionData> spells = const [],
      Map<int, int>? slots,
      List<CharacterResourceStateData> resources = const [],
      List<CharacterFeatureOverrideData> overrides = const [],
      bool asi = false,
      int? secondClassLevel,
    }) async {
      final session = owner.build();
      try {
        final classData = await ClassData.db.insertRow(
          session,
          ClassData(
            name: 'Level-down test class',
            referenceKey: 'level_down_${DateTime.now().microsecondsSinceEpoch}',
            hitDieValue: hitDie,
            subclassChoiceLevel: subclassChoiceLevel,
          ),
        );
        String featureKey(String suffix) => '${suffix}_${classData.id}';
        await ClassFeatureData.db.insertRow(
          session,
          ClassFeatureData(
            parentClassId: classData.id!,
            referenceKey: featureKey('stable_feature'),
            level: 1,
          ),
        );
        await ClassFeatureData.db.insertRow(
          session,
          ClassFeatureData(
            parentClassId: classData.id!,
            referenceKey: featureKey('removed_feature'),
            level: level,
          ),
        );
        final poolFeature = await ClassFeatureData.db.insertRow(
          session,
          ClassFeatureData(
            parentClassId: classData.id!,
            referenceKey: featureKey('pool_feature'),
            level: 1,
          ),
        );
        await FeatureResourceDefinitionData.db.insertRow(
          session,
          FeatureResourceDefinitionData(
            classFeatureId: poolFeature.id!,
            key: 'pool',
            kind: FeatureResourceKind.points,
            maxRule: FeatureResourceMaxRule.sourceClassLevel,
          ),
        );
        if (asi) {
          final group = await ChoiceGroupData.db.insertRow(
            session,
            ChoiceGroupData(
              referenceKey: 'level_down_asi_${classData.id}',
              sourceClassId: classData.id!,
              level: level,
              type: ChoiceType.abilityIncrease,
              selectionCount: 1,
            ),
          );
          await ChoiceOptionData.db.insertRow(
            session,
            ChoiceOptionData(
              choiceGroupId: group.id!,
              optionKey: 'con2',
              grantedAbilityBonuses: {'constitution': 2},
            ),
          );
        }
        final subclass = withSubclass
            ? await SubclassData.db.insertRow(
                session,
                SubclassData(
                  parentClassId: classData.id!,
                  levelRequired:
                      subclassRequiredLevel ?? subclassChoiceLevel ?? 1,
                  name: 'Test subclass',
                ),
              )
            : null;
        if (subclass != null) {
          await SubclassFeatureData.db.insertRow(
            session,
            SubclassFeatureData(
              parentSubclassId: subclass.id!,
              referenceKey: 'subclass_feature',
              level: 1,
            ),
          );
        }
        final entry = CharacterClassEntryData(
          id: 'entry',
          classData: classData,
          level: level,
          subclass: subclass,
          isStartingClass: true,
          hpRolledValues: hpRolls ?? [8, ...List.filled(level - 1, 5)],
        );
        return endpoints.characterData.saveCharacter(
          owner,
          CharacterData(
            name: 'Level-down test',
            baseAbilityScores: {'constitution': 14},
            currentHp: currentHp,
            classEntries: [
              entry,
              if (secondClassLevel != null)
                CharacterClassEntryData(
                  id: 'other',
                  classData: classData.copyWith(
                    referenceKey: 'other_class_${classData.id}',
                  ),
                  level: secondClassLevel,
                  isStartingClass: false,
                  hpRolledValues: List.filled(secondClassLevel, 4),
                ),
            ],
            choices: [
              ...choices,
              if (asi)
                CharacterChoiceData(
                  classEntry: entry,
                  groupKey: 'level_down_asi_${classData.id}',
                  optionKey: 'con2',
                  selectionIndex: 0,
                ),
            ],
            spellSelections: spells,
            currentSpellSlots: slots,
            resourceStates: resources,
            featureOverrides: overrides,
            currentHitDice: {'d$hitDie': level},
          ),
        );
      } finally {
        await session.close();
      }
    }

    LevelDownRequest request(CharacterData c,
            {List<LevelDownChoiceRepair>? repairs}) =>
        LevelDownRequest(
          characterId: c.id!,
          classEntryId: 'entry',
          expectedVersion: c.version!,
          repairs: repairs,
        );

    Future<CharacterData> addChoice(
      CharacterData character, {
      required String groupKey,
      required int groupLevel,
      required String optionKey,
      List<ChoiceRequirementData> requirements = const [],
      String? alternativeKey,
      List<ChoiceRequirementData> alternativeRequirements = const [],
    }) async {
      final entry =
          character.classEntries!.firstWhere((entry) => entry.id == 'entry');
      final session = owner.build();
      try {
        final group = await ChoiceGroupData.db.insertRow(
          session,
          ChoiceGroupData(
            referenceKey: groupKey,
            sourceClassId: entry.classData!.id!,
            level: groupLevel,
            type: ChoiceType.featureOption,
            selectionCount: 1,
          ),
        );
        await ChoiceOptionData.db.insertRow(
          session,
          ChoiceOptionData(
            choiceGroupId: group.id!,
            optionKey: optionKey,
            requirements: requirements,
          ),
        );
        if (alternativeKey != null) {
          await ChoiceOptionData.db.insertRow(
            session,
            ChoiceOptionData(
              choiceGroupId: group.id!,
              optionKey: alternativeKey,
              requirements: alternativeRequirements,
            ),
          );
        }
      } finally {
        await session.close();
      }
      return endpoints.characterData.saveCharacter(
        owner,
        character.copyWith(choices: [
          ...?character.choices,
          CharacterChoiceData(
            classEntry: entry,
            groupKey: groupKey,
            optionKey: optionKey,
            selectionIndex: 0,
          ),
        ]),
      );
    }

    test('preview is transient, decrements one level and removes last HP roll',
        () async {
      final before = await fixture();
      final preview = await endpoints.characterData
          .previewLevelDown(owner, request(before));
      expect(preview.targetLevel, 2);
      expect(preview.character.classEntries!.single.level, 2);
      expect(preview.character.classEntries!.single.hpRolledValues, [8, 5]);
      expect(
          (await endpoints.characterData.getCharacter(owner, before.id!))
              .derived
              ?.totalLevel,
          3);
    });

    test('level one to zero is rejected', () async {
      final before = await fixture(level: 1);
      await expectLater(
        endpoints.characterData.previewLevelDown(owner, request(before)),
        throwsA(isA<InputValidationException>()),
      );
    });

    test('partial HP roll history retains entries through target level',
        () async {
      final before = await fixture(level: 5, hpRolls: [8, 5]);
      final preview = await endpoints.characterData
          .previewLevelDown(owner, request(before));
      expect(preview.character.classEntries!.single.hpRolledValues, [8, 5]);
    });

    test('applying a simple level-down increments version exactly once',
        () async {
      final before = await fixture();
      final after =
          await endpoints.characterData.applyLevelDown(owner, request(before));
      expect(after.classEntries!.single.level, 2);
      expect(after.version, before.version! + 1);
    });

    test('current HP is clamped to the lower maximum without healing',
        () async {
      final before = await fixture(level: 4, currentHp: 28);
      final preview = await endpoints.characterData
          .previewLevelDown(owner, request(before));
      expect(preview.character.currentHp, preview.newMaxHp);
      expect(preview.character.currentHp, lessThan(28));
    });

    test('current HP below the new maximum is preserved', () async {
      final before = await fixture(level: 4, currentHp: 17);
      final preview = await endpoints.characterData
          .previewLevelDown(owner, request(before));
      expect(preview.character.currentHp, 17);
    });

    test('proficiency bonus recalculates across total level five', () async {
      final before = await fixture(level: 5);
      final preview = await endpoints.characterData
          .previewLevelDown(owner, request(before));
      expect(preview.oldProficiencyBonus, 3);
      expect(preview.newProficiencyBonus, 2);
    });

    test('features gained only at the removed level disappear', () async {
      final before = await fixture();
      final preview = await endpoints.characterData
          .previewLevelDown(owner, request(before));
      expect(preview.removedClassFeatures.map((f) => f.referenceKey),
          contains(startsWith('removed_feature_')));
      final removedId = preview.removedClassFeatures
          .singleWhere((f) => f.referenceKey!.startsWith('removed_feature_'))
          .id;
      expect(
          preview.character.derived!.activeFeatures!
              .where((f) => f.sourceId == removedId),
          isEmpty);
    });

    test('subclass clears when target level is below unlock level', () async {
      final before =
          await fixture(level: 3, subclassChoiceLevel: 3, withSubclass: true);
      final preview = await endpoints.characterData
          .previewLevelDown(owner, request(before));
      expect(preview.character.classEntries!.single.subclass, isNull);
      expect(preview.removedSubclassFeatures, isNotEmpty);
    });

    test('selected subclass level requirement is respected independently',
        () async {
      final before = await fixture(
        level: 4,
        subclassChoiceLevel: 3,
        subclassRequiredLevel: 4,
        withSubclass: true,
      );
      final preview = await endpoints.characterData
          .previewLevelDown(owner, request(before));
      expect(preview.character.classEntries!.single.subclass, isNull);
    });

    test('ASI group and its ability bonus disappear automatically', () async {
      final before = await fixture(level: 4, asi: true);
      final preview = await endpoints.characterData
          .previewLevelDown(owner, request(before));
      expect(
          preview.removedChoiceGroups.map((g) => g.referenceKey),
          contains(
              'level_down_asi_${before.classEntries!.single.classData!.id}'));
      expect(preview.character.choices, isEmpty);
      expect(
          preview.character.derived!.abilityScores![Ability.constitution], 14);
    });

    test('removing CON ASI recalculates remaining HP retroactively', () async {
      final before = await fixture(level: 4, asi: true, currentHp: 99);
      final preview = await endpoints.characterData
          .previewLevelDown(owner, request(before));
      expect(preview.newMaxHp, lessThan(preview.oldMaxHp!));
      expect(preview.character.currentHp, preview.newMaxHp);
    });

    test('Fighting Style choice at the removed level is deleted', () async {
      final base = await fixture(level: 2);
      final before = await addChoice(base,
          groupKey: 'fighter_style_${base.id}',
          groupLevel: 2,
          optionKey: 'style');
      final preview = await endpoints.characterData
          .previewLevelDown(owner, request(before));
      expect(preview.removedChoices.map((c) => c.groupKey),
          contains('fighter_style_${base.id}'));
    });

    test('level five removes only level five invocation group', () async {
      final base = await fixture(level: 5);
      final atTwo = await addChoice(base,
          groupKey: 'invocations_two_${base.id}',
          groupLevel: 2,
          optionKey: 'old');
      final before = await addChoice(atTwo,
          groupKey: 'invocations_five_${base.id}',
          groupLevel: 5,
          optionKey: 'new');
      final preview = await endpoints.characterData
          .previewLevelDown(owner, request(before));
      expect(preview.removedChoices.map((c) => c.groupKey),
          ['invocations_five_${base.id}']);
      expect(preview.character.choices!.map((c) => c.groupKey),
          contains('invocations_two_${base.id}'));
    });

    test('Pact Boon choice is removed at level three to two', () async {
      final base = await fixture(level: 3);
      final before = await addChoice(base,
          groupKey: 'pact_boon_${base.id}', groupLevel: 3, optionKey: 'boon');
      final preview = await endpoints.characterData
          .previewLevelDown(owner, request(before));
      expect(preview.removedChoices.single.groupKey, 'pact_boon_${base.id}');
    });

    test('an option whose prerequisite is lost requires replacement', () async {
      final base = await fixture(level: 5);
      final before = await addChoice(
        base,
        groupKey: 'invocations_two_${base.id}',
        groupLevel: 2,
        optionKey: 'high_level',
        requirements: [
          ChoiceRequirementData(
            type: ChoiceRequirementType.minimumClassLevel,
            classKey: base.classEntries!.single.classData!.referenceKey,
            value: 5,
          ),
        ],
        alternativeKey: 'basic',
      );
      final preview = await endpoints.characterData
          .previewLevelDown(owner, request(before));
      expect(preview.invalidChoices.single.optionKey, 'high_level');
      expect(preview.invalidChoices.single.eligibleAlternativeOptionKeys,
          contains('basic'));
      expect(preview.missingDecisions, isNotEmpty);
      await expectLater(
          endpoints.characterData.applyLevelDown(owner, request(before)),
          throwsA(isA<InputValidationException>()));
    });

    test('known-spell prerequisite remains valid after snapshot normalization',
        () async {
      final session = owner.build();
      late SpellData spell;
      try {
        spell = await SpellData.db.insertRow(
          session,
          SpellData(referenceKey: 'linked_known_spell', name: 'Known spell'),
        );
      } finally {
        await session.close();
      }
      final base = await fixture(
        level: 5,
        spells: [
          CharacterSpellSelectionData(
            spell: spell,
            spellId: spell.id,
            kind: CharacterSpellSelectionKind.knownSpell,
            selectionIndex: 0,
          ),
        ],
      );
      final before = await addChoice(
        base,
        groupKey: 'known_spell_choice_${base.id}',
        groupLevel: 2,
        optionKey: 'requires_spell',
        requirements: [
          ChoiceRequirementData(
            type: ChoiceRequirementType.knownSpell,
            referenceKey: 'linked_known_spell',
          ),
        ],
        alternativeKey: 'fallback',
      );
      final preview = await endpoints.characterData
          .previewLevelDown(owner, request(before));
      expect(preview.invalidChoices, isEmpty);
    });

    test(
        'colliding class and subclass feature ids preserve foreign feature facts',
        () async {
      final base = await fixture(level: 5);
      final session = owner.build();
      late ClassData otherClass;
      late SubclassData otherSubclass;
      late int collidingFeatureId;
      try {
        final targetClass = base.classEntries!.first.classData!;
        collidingFeatureId = (await ClassFeatureData.db.find(
          session,
          where: (t) =>
              t.parentClassId.equals(targetClass.id!) &
              t.referenceKey.like('removed_feature_%'),
        ))
            .single
            .id!;
        otherClass = await ClassData.db.insertRow(
          session,
          ClassData(
            name: 'Other class',
            referenceKey: 'other_class_${base.id}',
            hitDieValue: 6,
          ),
        );
        otherSubclass = await SubclassData.db.insertRow(
          session,
          SubclassData(
            parentClassId: otherClass.id!,
            name: 'Other subclass',
            levelRequired: 1,
          ),
        );
        await SubclassFeatureData.db.insertRow(
          session,
          SubclassFeatureData(
            id: collidingFeatureId,
            parentSubclassId: otherSubclass.id!,
            referenceKey: 'other_active_subclass_feature',
            level: 1,
          ),
        );
      } finally {
        await session.close();
      }
      final withOtherSubclass = await endpoints.characterData.saveCharacter(
        owner,
        base.copyWith(classEntries: [
          ...base.classEntries!,
          CharacterClassEntryData(
            id: 'other',
            classData: otherClass,
            subclass: otherSubclass,
            level: 1,
            isStartingClass: false,
            hpRolledValues: [5],
          ),
        ]),
      );
      final before = await addChoice(
        withOtherSubclass,
        groupKey: 'foreign_feature_choice_${base.id}',
        groupLevel: 2,
        optionKey: 'requires_other_feature',
        requirements: [
          ChoiceRequirementData(
            type: ChoiceRequirementType.feature,
            referenceKey: 'other_active_subclass_feature',
          ),
        ],
        alternativeKey: 'fallback',
      );

      final preview = await endpoints.characterData
          .previewLevelDown(owner, request(before));
      expect(preview.invalidChoices, isEmpty);
    });

    test('eligible replacement keeps the same logical choice slot', () async {
      final base = await fixture(level: 5);
      final before = await addChoice(
        base,
        groupKey: 'invocations_two_${base.id}',
        groupLevel: 2,
        optionKey: 'high_level',
        requirements: [
          ChoiceRequirementData(
            type: ChoiceRequirementType.minimumClassLevel,
            classKey: base.classEntries!.single.classData!.referenceKey,
            value: 5,
          ),
        ],
        alternativeKey: 'basic',
      );
      final original = before.choices!.single;
      final after = await endpoints.characterData.applyLevelDown(
        owner,
        request(before, repairs: [
          LevelDownChoiceRepair(
            groupKey: original.groupKey!,
            selectionIndex: original.selectionIndex!,
            currentOptionKey: original.optionKey!,
            replacementOptionKey: 'basic',
          ),
        ]),
      );
      expect(after.choices!.single.id, original.id);
      expect(after.choices!.single.selectionIndex, original.selectionIndex);
      expect(after.choices!.single.optionKey, 'basic');
    });

    test('feature resources preserve spent values and clamp to new maximum',
        () async {
      final base = await fixture(level: 4);
      final classId = base.classEntries!.single.classData!.id!;
      final session = owner.build();
      late int sourceId;
      try {
        sourceId = (await ClassFeatureData.db.find(session,
                where: (t) =>
                    t.parentClassId.equals(classId) &
                    t.referenceKey.like('pool_feature_%')))
            .single
            .id!;
      } finally {
        await session.close();
      }
      final spent = await endpoints.characterData.saveCharacter(
        owner,
        base.copyWith(resourceStates: [
          CharacterResourceStateData(
            sourceType: CharacterFeatureSourceType.classFeature,
            sourceId: sourceId,
            resourceKey: 'pool',
            current: 2,
          ),
        ]),
      );
      final preview =
          await endpoints.characterData.previewLevelDown(owner, request(spent));
      final resource = preview.character.derived!.activeFeatures!
          .expand((feature) =>
              feature.resources ?? const <CharacterResourceViewData>[])
          .singleWhere((item) => item.key == 'pool');
      expect(resource.current, 2);
      expect(resource.max, 3);

      final fullBase = await fixture(level: 4);
      final fullClassId = fullBase.classEntries!.single.classData!.id!;
      final fullSession = owner.build();
      late int fullSourceId;
      try {
        fullSourceId = (await ClassFeatureData.db.find(fullSession,
                where: (t) =>
                    t.parentClassId.equals(fullClassId) &
                    t.referenceKey.like('pool_feature_%')))
            .single
            .id!;
      } finally {
        await fullSession.close();
      }
      final full = await endpoints.characterData.saveCharacter(
        owner,
        fullBase.copyWith(resourceStates: [
          CharacterResourceStateData(
            sourceType: CharacterFeatureSourceType.classFeature,
            sourceId: fullSourceId,
            resourceKey: 'pool',
            current: 4,
          ),
        ]),
      );
      final clamped =
          await endpoints.characterData.previewLevelDown(owner, request(full));
      final clampedResource = clamped.character.derived!.activeFeatures!
          .expand((feature) =>
              feature.resources ?? const <CharacterResourceViewData>[])
          .singleWhere((item) => item.key == 'pool');
      expect(clampedResource.current, 3);
      expect(clampedResource.max, 3);
      expect(clamped.character.currentHitDice?['d8'], 3);
    });

    test('resource state for a removed feature is pruned', () async {
      final base = await fixture(level: 3);
      final session = owner.build();
      late int sourceId;
      try {
        final feature = (await ClassFeatureData.db.find(session,
                where: (t) =>
                    t.parentClassId
                        .equals(base.classEntries!.single.classData!.id!) &
                    t.referenceKey.like('removed_feature_%')))
            .single;
        sourceId = feature.id!;
        await FeatureResourceDefinitionData.db.insertRow(
          session,
          FeatureResourceDefinitionData(
            classFeatureId: sourceId,
            key: 'removed_pool',
            kind: FeatureResourceKind.points,
            maxRule: FeatureResourceMaxRule.fixed,
            maxValue: 3,
          ),
        );
      } finally {
        await session.close();
      }
      final before = await endpoints.characterData.saveCharacter(
        owner,
        base.copyWith(resourceStates: [
          CharacterResourceStateData(
            sourceType: CharacterFeatureSourceType.classFeature,
            sourceId: sourceId,
            resourceKey: 'removed_pool',
            current: 1,
          ),
        ]),
      );
      final preview = await endpoints.characterData
          .previewLevelDown(owner, request(before));
      expect(
        preview.character.resourceStates!
            .where((state) => state.resourceKey == 'removed_pool'),
        isEmpty,
      );
    });

    test('user spell selections remain unchanged', () async {
      final spell = CharacterSpellSelectionData(
        id: 'user-spell',
        spellKey: 'manual_spell',
        kind: CharacterSpellSelectionKind.knownSpell,
        selectionIndex: 0,
      );
      final before = await fixture(level: 5, spells: [spell]);
      final after =
          await endpoints.characterData.applyLevelDown(owner, request(before));
      expect(after.spellSelections!.map((s) => s.spellKey), ['manual_spell']);
    });

    test('spell slots clamp to the target level maximum', () async {
      final base = await fixture(level: 4, slots: {1: 4, 2: 3});
      final session = owner.build();
      try {
        final classData = base.classEntries!.single.classData!;
        await ClassData.db.updateRow(
          session,
          classData.copyWith(
            spellcastingProgression: SpellcastingProgression.full,
          ),
        );
        for (final (level, slots) in [
          (3, {1: 4, 2: 2}),
          (4, {1: 4, 2: 3}),
        ]) {
          final existing = await SpellSlotProgressionData.db.find(
            session,
            where: (t) => t.tableKey.equals('standard') & t.level.equals(level),
          );
          if (existing.isEmpty) {
            await SpellSlotProgressionData.db.insertRow(
              session,
              SpellSlotProgressionData(
                tableKey: 'standard',
                level: level,
                spellSlots: slots,
              ),
            );
          }
          await ClassLevelData.db.insertRow(
            session,
            ClassLevelData(classDataId: classData.id!, level: level),
          );
        }
      } finally {
        await session.close();
      }
      final before =
          await endpoints.characterData.getCharacter(owner, base.id!);
      final preview = await endpoints.characterData
          .previewLevelDown(owner, request(before));
      expect(preview.newSpellSlots[2], 2);
      expect(preview.character.currentSpellSlots?[2], 2);
    });

    test('override for a feature that disappears is pruned', () async {
      final base = await fixture(level: 3);
      final session = owner.build();
      late int sourceId;
      try {
        sourceId = (await ClassFeatureData.db.find(session,
                where: (t) =>
                    t.parentClassId
                        .equals(base.classEntries!.single.classData!.id!) &
                    t.referenceKey.like('removed_feature_%')))
            .single
            .id!;
      } finally {
        await session.close();
      }
      final before = await endpoints.characterData.saveCharacter(
        owner,
        base.copyWith(featureOverrides: [
          CharacterFeatureOverrideData(
            sourceType: CharacterFeatureSourceType.classFeature,
            sourceId: sourceId,
            name: 'Custom name',
          ),
        ]),
      );
      final after =
          await endpoints.characterData.applyLevelDown(owner, request(before));
      expect(after.featureOverrides, isEmpty);
    });

    test('only the chosen class entry changes in a multiclass snapshot',
        () async {
      final before = await fixture(level: 3, secondClassLevel: 2);
      final after =
          await endpoints.characterData.applyLevelDown(owner, request(before));
      expect(after.classEntries!.map((e) => e.level), [2, 2]);
      expect(after.classEntries!.map((e) => e.id), ['entry', 'other']);
    });
  });
}
