import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/validation/validation_exception.dart';
import 'package:characters_mirror_server/src/rate_limiting/character_save_rate_limiter.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Conditional generic cantrip grants', (sessions, endpoints) {
    final owner = sessions.copyWith(
        authentication:
            AuthenticationOverride.authenticationInfo(9515, <Scope>{}));
    setUp(CharacterSaveRateLimiter.resetForTests);

    Future<(ClassData, SubclassData, ChoiceGroupData, List<SpellData>)>
        fixture() async {
      final db = sessions.build();
      try {
        final data = await ClassData.db.insertRow(
            db,
            ClassData(
                name: 'Conditional caster',
                referenceKey: 'conditional_caster_fixture',
                hitDieValue: 6,
                spellcastingProgression: SpellcastingProgression.full,
                spellcastingAbilityValue: Ability.intelligence,
                spellSelectionMode: ClassSpellSelectionMode.known,
                subclassChoiceLevel: 2));
        final sub = await SubclassData.db.insertRow(
            db,
            SubclassData(
                parentClassId: data.id!,
                name: 'Conditional school',
                referenceKey: 'conditional_school_fixture',
                levelRequired: 2));
        final feature = await SubclassFeatureData.db.insertRow(
            db,
            SubclassFeatureData(
                parentSubclassId: sub.id!,
                name: 'Conditional feature',
                level: 2,
                referenceKey: 'conditional_feature_fixture'));
        final spells = <SpellData>[];
        for (final key in ['default', 'fallback', 'duplicate']) {
          spells.add(await SpellData.db.insertRow(
              db,
              SpellData(
                  name: key,
                  referenceKey: 'conditional_$key',
                  level: 0,
                  availableForClassIds: [data.id!])));
        }
        for (final level in [1, 2, 3]) {
          await ClassLevelData.db.insertRow(
              db,
              ClassLevelData(
                  classDataId: data.id!,
                  level: level,
                  knownCantrips: 2,
                  knownSpells: 0));
        }
        final group = await ChoiceGroupData.db.insertRow(
            db,
            ChoiceGroupData(
                referenceKey: 'conditional_cantrip_fixture',
                name: 'Conditional cantrip',
                sourceSubclassFeatureId: feature.id,
                level: 2,
                type: ChoiceType.custom,
                selectionCount: 1,
                minimumSelectionCount: 1,
                autoSelectSingleEligible: true));
        for (final spell in spells) {
          await ChoiceOptionData.db.insertRow(
              db,
              ChoiceOptionData(
                  choiceGroupId: group.id!,
                  optionKey: spell.referenceKey,
                  automaticSelection: spell == spells.first,
                  name: spell.name,
                  grantedSpellKeys: [
                    spell.referenceKey
                  ],
                  requirements: [
                    ChoiceRequirementData(
                        type: ChoiceRequirementType.knownCantrip,
                        referenceKey: spells.first.referenceKey,
                        negate: spell == spells.first),
                    if (spell != spells.first)
                      ChoiceRequirementData(
                          type: ChoiceRequirementType.knownCantrip,
                          referenceKey: spell.referenceKey,
                          negate: true),
                  ]));
        }
        return (data, sub, group, spells);
      } finally {
        await db.close();
      }
    }

    CharacterData draft(ClassData data, SubclassData sub, List<SpellData> known,
            {String? selected}) =>
        CharacterData(name: 'Conditional fixture', classEntries: [
          CharacterClassEntryData(
              id: 'conditional-entry',
              classData: data,
              subclass: sub,
              level: 2,
              isStartingClass: true),
        ], spellSelections: [
          for (var i = 0; i < known.length; i++)
            CharacterSpellSelectionData(
                classDataId: data.id,
                spellKey: known[i].referenceKey,
                kind: CharacterSpellSelectionKind.knownCantrip,
                selectionIndex: i),
        ], choices: [
          if (selected != null)
            CharacterChoiceData(
                groupKey: 'conditional_cantrip_fixture',
                optionKey: selected,
                selectionIndex: 0)
        ]);

    test(
        'automatic grant is persisted, displayed and outside the cantrip quota',
        () async {
      final (data, sub, _, spells) = await fixture();
      final c = await endpoints.characterData
          .saveCharacter(owner, draft(data, sub, [spells[1], spells[2]]));
      expect(c.spellSelections, hasLength(2));
      expect(c.choices!.single.optionKey, spells.first.referenceKey);
      expect(c.derived!.resolvedSpells, hasLength(3));
      expect(
          c.derived!.activeFeatures!.single.selectedChoiceDetails!.single.name,
          'default');
      final loaded = await endpoints.characterData.getCharacter(owner, c.id!);
      expect(loaded.choices!.single.id, c.choices!.single.id);
      expect(loaded.derived!.grantedSpellKeys,
          contains(spells.first.referenceKey));
    });

    test('known default requires a new eligible choice and rejects duplicates',
        () async {
      final (data, sub, _, spells) = await fixture();
      await expectLater(
          endpoints.characterData
              .saveCharacter(owner, draft(data, sub, [spells.first])),
          throwsA(isA<InputValidationException>()));
      CharacterSaveRateLimiter.resetForTests();
      await expectLater(
          endpoints.characterData.saveCharacter(
              owner,
              draft(data, sub, [spells.first, spells[2]],
                  selected: spells[2].referenceKey)),
          throwsA(isA<InputValidationException>()));
      CharacterSaveRateLimiter.resetForTests();
      await expectLater(
          endpoints.characterData.saveCharacter(
              owner, draft(data, sub, [spells.first, spells[2]])),
          throwsA(isA<InputValidationException>()));
      CharacterSaveRateLimiter.resetForTests();
      final c = await endpoints.characterData.saveCharacter(
          owner,
          draft(data, sub, [spells.first, spells[2]],
              selected: spells[1].referenceKey));
      expect(c.spellSelections, hasLength(2));
      expect(c.derived!.grantedSpellKeys, contains(spells[1].referenceKey));
      expect(
          c.derived!.activeFeatures!.single.selectedChoiceDetails!.single.name,
          'fallback');
      final down = await endpoints.characterData.applyLevelDown(
          owner,
          LevelDownRequest(
              characterId: c.id!,
              expectedVersion: c.version!,
              classEntryId: c.classEntries!.single.id!));
      expect(down.choices ?? [], isEmpty);
      expect(down.derived!.resolvedSpells!.map((s) => s.spellKey),
          contains(spells.first.referenceKey));
      expect(down.derived!.resolvedSpells!.map((s) => s.spellKey),
          isNot(contains(spells[1].referenceKey)));
    });

    test('other canonical class grant counts as known at acquisition',
        () async {
      final (data, sub, _, spells) = await fixture();
      final db = sessions.build();
      try {
        await ClassSpellGrantData.db.insertRow(
            db,
            ClassSpellGrantData(
                sourceClassId: data.id,
                spellId: spells.first.id,
                grantedAtLevel: 1));
      } finally {
        await db.close();
      }
      await expectLater(
          endpoints.characterData.saveCharacter(owner, draft(data, sub, [])),
          throwsA(isA<InputValidationException>()));
      CharacterSaveRateLimiter.resetForTests();
      final c = await endpoints.characterData.saveCharacter(
          owner, draft(data, sub, [], selected: spells[1].referenceKey));
      expect(c.derived!.resolvedSpells!.map((s) => s.spellKey),
          containsAll([spells.first.referenceKey, spells[1].referenceKey]));
    });

    test('level-up distinguishes automatic grant from a required replacement',
        () async {
      final (data, sub, group, spells) = await fixture();
      for (final alreadyKnown in [false, true]) {
        CharacterSaveRateLimiter.resetForTests();
        final initial = draft(data, sub, alreadyKnown ? [spells.first] : []);
        final before = await endpoints.characterData.saveCharacter(
            owner,
            initial.copyWith(classEntries: [
              initial.classEntries!.single.copyWith(level: 1, subclass: null)
            ]));
        final request = LevelUpRequest(
            characterId: before.id!,
            expectedVersion: before.version!,
            classEntryId: before.classEntries!.single.id!,
            subclassId: sub.id,
            hitDieRoll: 4);
        final preview =
            await endpoints.characterData.previewLevelUp(owner, request);
        expect(preview.missingDecisions.isEmpty, !alreadyKnown);
        final applied = await endpoints.characterData.applyLevelUp(
            owner,
            alreadyKnown
                ? request.copyWith(choices: {
                    group.referenceKey: [spells[1].referenceKey]
                  })
                : request);
        expect(applied.choices!.single.optionKey,
            alreadyKnown ? spells[1].referenceKey : spells.first.referenceKey);
        expect(applied.spellSelections?.length ?? 0, alreadyKnown ? 1 : 0);
      }
    });

    test('acquired decision survives a later grant of the default cantrip',
        () async {
      final (data, sub, _, spells) = await fixture();
      final c = await endpoints.characterData
          .saveCharacter(owner, draft(data, sub, []));
      final db = sessions.build();
      try {
        await ClassFeatureData.db.insertRow(
            db,
            ClassFeatureData(
                parentClassId: data.id!,
                name: 'Later grant',
                level: 3,
                referenceKey: 'conditional_later_grant',
                grantedSpellKeys: [spells.first.referenceKey]));
      } finally {
        await db.close();
      }
      CharacterSaveRateLimiter.resetForTests();
      final later = await endpoints.characterData.saveCharacter(
          owner,
          c.copyWith(
              classEntries: [c.classEntries!.single.copyWith(level: 3)]));
      expect(later.choices!.single.id, c.choices!.single.id);
      expect(later.choices!.single.optionKey, spells.first.referenceKey);
      expect(
          later.derived!.resolvedSpells!
              .where((s) => s.spellKey == spells.first.referenceKey),
          hasLength(1));
    });

    test('conditional choice group enforces prerequisites and minimum count',
        () async {
      final (data, sub, existingGroup, _) = await fixture();
      final db = sessions.build();
      late ChoiceGroupData parent;
      late ChoiceGroupData child;
      try {
        parent = await ChoiceGroupData.db.insertRow(
            db,
            ChoiceGroupData(
              referenceKey: 'conditional_parent_group_fixture',
              sourceSubclassFeatureId: existingGroup.sourceSubclassFeatureId,
              level: 2,
              selectionCount: 1,
              minimumSelectionCount: 1,
            ));
        child = await ChoiceGroupData.db.insertRow(
            db,
            ChoiceGroupData(
              referenceKey: 'conditional_child_group_fixture',
              sourceSubclassFeatureId: existingGroup.sourceSubclassFeatureId,
              level: 2,
              selectionCount: 3,
              minimumSelectionCount: 3,
              requirements: [
                ChoiceRequirementData(
                  type: ChoiceRequirementType.selectedChoiceOption,
                  choiceGroupKey: parent.referenceKey,
                  optionKey: 'tome',
                ),
              ],
            ));
        for (final key in ['tome', 'chain']) {
          await ChoiceOptionData.db.insertRow(
              db,
              ChoiceOptionData(
                  choiceGroupId: parent.id!, optionKey: key, name: key));
        }
        for (var index = 0; index < 3; index++) {
          await ChoiceOptionData.db.insertRow(
              db,
              ChoiceOptionData(
                  choiceGroupId: child.id!, optionKey: 'cantrip_$index'));
        }
      } finally {
        await db.close();
      }
      CharacterData withChoices(String parentOption, int childCount) {
        final value = draft(data, sub, []);
        return value.copyWith(choices: [
          CharacterChoiceData(
              groupKey: parent.referenceKey, optionKey: parentOption),
          for (var index = 0; index < childCount; index++)
            CharacterChoiceData(
                groupKey: child.referenceKey,
                optionKey: 'cantrip_$index',
                selectionIndex: index),
        ]);
      }

      await expectLater(
        endpoints.characterData.saveCharacter(owner, withChoices('chain', 3)),
        throwsA(isA<InputValidationException>()),
      );
      CharacterSaveRateLimiter.resetForTests();
      await expectLater(
        endpoints.characterData.saveCharacter(owner, withChoices('tome', 2)),
        throwsA(isA<InputValidationException>()),
      );
      CharacterSaveRateLimiter.resetForTests();
      final saved = await endpoints.characterData
          .saveCharacter(owner, withChoices('tome', 3));
      expect(
          saved.choices!.where((choice) =>
              choice.groupKey == parent.referenceKey ||
              choice.groupKey == child.referenceKey),
          hasLength(4));
      expect(
          saved.choices!
              .where((choice) => choice.groupKey == child.referenceKey),
          hasLength(3));
    });
  });
}
