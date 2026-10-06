import 'dart:convert';

import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/rate_limiting/character_save_rate_limiter.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../../../test_fixtures/feature_reference_contract.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Feature reference contracts', (sessions, endpoints) {
    setUp(CharacterSaveRateLimiter.resetForTests);
    final owner = sessions.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(965, <Scope>{}),
    );

    test(
        'fixed and selected grants match the offline contract; level down removes them',
        () async {
      final session = owner.build();
      try {
        final data = await ClassData.db.insertRow(
            session,
            ClassData(
              referenceKey: 'fixture_class',
              name: 'Arbitrary class label',
              hitDieValue: 8,
              subclassChoiceLevel: 3,
              spellcastingProgression: SpellcastingProgression.none,
              spellSelectionMode: ClassSpellSelectionMode.none,
            ));
        final subclass = await SubclassData.db.insertRow(
            session,
            SubclassData(
              referenceKey: 'fixture_subclass',
              parentClassId: data.id!,
              name: 'Arbitrary subclass label',
              levelRequired: 3,
              spellcastingProgression: SpellcastingProgression.third,
              spellSelectionMode: ClassSpellSelectionMode.known,
              spellcastingAbilityValue: Ability.intelligence,
            ));
        final base = await ClassFeatureData.db.insertRow(
            session,
            ClassFeatureData(
              parentClassId: data.id!,
              referenceKey: 'fixture_base',
              level: 1,
              grantedSkills: [Skill.history],
              grantedExpertiseSkills: [Skill.history],
              grantedLanguages: [Language.common],
              grantedSpellKeys: ['fixture_fixed'],
            ));
        final feature = await SubclassFeatureData.db.insertRow(
            session,
            SubclassFeatureData(
              parentSubclassId: subclass.id!,
              referenceKey: 'fixture_subfeature',
              level: 3,
              grantedSkills: [Skill.stealth],
              grantedLanguages: [Language.elvish],
              grantedArmorTraining: [ArmorCategory.heavy],
              grantedWeaponTraining: [
                WeaponCategory.martialMelee,
                WeaponCategory.martialRanged
              ],
              grantedToolKeys: ['fixture_disguise', 'fixture_poison'],
              grantedExpertiseToolKeys: ['fixture_poison'],
            ));
        for (final key in [
          'fixture_disguise',
          'fixture_poison',
          'fixture_choice_tool'
        ]) {
          await ToolData.db
              .insertRow(session, ToolData(referenceKey: key, name: key));
        }
        final spells = <String, SpellData>{};
        for (final key in [
          'fixture_fixed',
          'fixture_choice',
          'fixture_prepared',
          'fixture_null',
          'fixture_cantrip',
          'fixture_known_a',
          'fixture_known_b'
        ]) {
          spells[key] = await SpellData.db.insertRow(
              session,
              SpellData(
                referenceKey: key,
                name: key,
                level: key == 'fixture_cantrip' ? 0 : 1,
                availableForSubclassIds: [subclass.id!],
              ));
        }
        final group = await ChoiceGroupData.db.insertRow(
            session,
            ChoiceGroupData(
              referenceKey: 'fixture_group',
              sourceSubclassFeatureId: feature.id!,
              selectionCount: 1,
              minimumSelectionCount: 0,
            ));
        final option = await ChoiceOptionData.db.insertRow(
            session,
            ChoiceOptionData(
              choiceGroupId: group.id!,
              optionKey: 'fixture_option',
              grantedToolKeys: ['fixture_choice_tool'],
              grantedSpellKeys: ['fixture_choice'],
            ));
        await ClassSpellGrantData.db.insertRow(
            session,
            ClassSpellGrantData(
              sourceSubclassFeatureId: feature.id!,
              spellId: spells['fixture_prepared']!.id!,
              alwaysPrepared: true,
              choiceOptionId: option.id,
            ));
        await ClassSpellGrantData.db.insertRow(
            session,
            ClassSpellGrantData(
              sourceSubclassFeatureId: feature.id!,
              spellId: spells['fixture_null']!.id!,
            ));
        await ClassSpellGrantData.db.insertRow(
            session,
            ClassSpellGrantData(
              sourceSubclassFeatureId: feature.id!,
              spellId: spells['fixture_null']!.id!,
              alwaysPrepared: false,
            ));
        await FeatureResourceDefinitionData.db.insertRow(
            session,
            FeatureResourceDefinitionData(
              classFeatureId: base.id!,
              key: 'fixture_pool',
              kind: FeatureResourceKind.points,
              maxRule: FeatureResourceMaxRule.fixed,
              maxValue: 2,
            ));
        await FeatureResourceDefinitionData.db.insertRow(
            session,
            FeatureResourceDefinitionData(
              subclassFeatureId: feature.id!,
              key: 'fixture_choice_pool',
              kind: FeatureResourceKind.uses,
              maxRule: FeatureResourceMaxRule.fixed,
              maxValue: 1,
              choiceOptionId: option.id,
            ));
        await FeatureResourceEffectData.db.insertRow(
            session,
            FeatureResourceEffectData(
              subclassFeatureId: feature.id!,
              type: FeatureResourceEffectType.modify,
              targetResourceKey: 'fixture_pool',
              addMaxValue: 3,
              choiceOptionId: option.id,
            ));
        // Declarative spends must not execute during character resolution.
        await FeatureResourceEffectData.db.insertRow(
            session,
            FeatureResourceEffectData(
              subclassFeatureId: feature.id!,
              type: FeatureResourceEffectType.spend,
              targetResourceKey: 'fixture_pool',
              amountRule: FeatureResourceMaxRule.fixed,
              amountValue: 1,
              choiceOptionId: option.id,
            ));
        for (final level in [1, 2, 3]) {
          await ClassLevelData.db.insertRow(
              session,
              ClassLevelData(
                classDataId: data.id!,
                level: level,
                knownCantrips: 0,
                knownSpells: 0,
              ));
        }
        await ClassLevelData.db.insertRow(
            session,
            ClassLevelData(
              classDataId: data.id!,
              subclassDataId: subclass.id!,
              level: 3,
              knownCantrips: 1,
              knownSpells: 2,
            ));
        if (await SpellSlotProgressionData.db.findFirstRow(session,
                where: (t) =>
                    t.tableKey.equals('standard') & t.level.equals(1)) ==
            null) {
          await SpellSlotProgressionData.db.insertRow(
              session,
              SpellSlotProgressionData(
                tableKey: 'standard',
                level: 1,
                spellSlots: {1: 2},
              ));
        }
        final step = await endpoints.classData.getStepView(owner, data.id!,
            selectedLevel: 3,
            selectedSubclassId: subclass.id!,
            isStartingClass: true,
            abilityScores: null);
        expect(
            step.spellSelectionGroups!
                .firstWhere(
                    (g) => g.kind == CharacterSpellSelectionKind.knownSpell)
                .selectionCount,
            2);
        final delta = await endpoints.classData.getSpellDelta(
            owner, data.id!, 2, 3, {'intelligence': 16},
            selectedSubclassId: subclass.id!);
        expect(delta.cantripsToAdd, 1);
        expect(delta.knownSpellsToAdd, 2);
        final earlier = await endpoints.classData.getStepView(owner, data.id!,
            selectedLevel: 2,
            selectedSubclassId: subclass.id!,
            isStartingClass: true,
            abilityScores: null);
        expect(earlier.spellSelectionGroups, isEmpty);
        final saved = await endpoints.characterData.saveCharacter(
            owner,
            CharacterData(
              name: 'Feature contract',
              classEntries: [
                CharacterClassEntryData(
                  id: 'entry',
                  classData: data,
                  subclass: subclass,
                  level: 3,
                  isStartingClass: true,
                  hpRolledValues: [8, 5, 5],
                )
              ],
              choices: [
                CharacterChoiceData(
                    groupKey: group.referenceKey, optionKey: option.optionKey)
              ],
            ));
        Map<String, dynamic> json(CharacterData character) =>
            jsonDecode(jsonEncode(character.derived!.toJson()))
                as Map<String, dynamic>;
        expect(featureReferenceProjection(json(saved)),
            selectedFeatureReferenceContract);
        expect(
            saved.derived!.activeFeatures!
                .firstWhere((f) =>
                    f.sourceId == base.id &&
                    f.sourceType == CharacterFeatureSourceType.classFeature)
                .resources!
                .single
                .current,
            2);
        final withoutChoice = await endpoints.characterData
            .saveCharacter(owner, saved.copyWith(choices: []));
        expect(featureReferenceProjection(json(withoutChoice)),
            unselectedFeatureReferenceContract);
        final down = await endpoints.characterData.applyLevelDown(
            owner,
            LevelDownRequest(
              characterId: withoutChoice.id!,
              expectedVersion: withoutChoice.version!,
              classEntryId: withoutChoice.classEntries!.single.id!,
            ));
        expect(down.derived!.toolProficiencyKeys, isEmpty);
        expect(down.derived!.armorTraining, isEmpty);
        expect(down.derived!.spellSlots, isNull);
        expect(down.derived!.grantedSpellKeys, ['fixture_fixed']);
        expect(
            down.derived!.skillProficiencyLevels!
                .where((s) => s.level != CharacterSkillProficiencyLevel.none)
                .map((s) => s.skill),
            [Skill.history]);
        final up = await endpoints.characterData.applyLevelUp(
            owner,
            LevelUpRequest(
              characterId: down.id!,
              expectedVersion: down.version!,
              classEntryId: down.classEntries!.single.id!,
              subclassId: subclass.id!,
              hitDieRoll: 5,
              choices: {
                group.referenceKey: [option.optionKey]
              },
              spells: [
                LevelUpSpellChoice(
                    spellId: spells['fixture_cantrip']!.id!,
                    kind: CharacterSpellSelectionKind.knownCantrip),
                for (final key in ['fixture_known_a', 'fixture_known_b'])
                  LevelUpSpellChoice(
                      spellId: spells[key]!.id!,
                      kind: CharacterSpellSelectionKind.knownSpell),
              ],
            ));
        expect(up.derived!.spellSlots, {1: 2});
        expect(up.spellSelections, hasLength(3));
        expect(up.derived!.alwaysPreparedSpellKeys, ['fixture_prepared']);
        final downAgain = await endpoints.characterData.applyLevelDown(
            owner,
            LevelDownRequest(
              characterId: up.id!,
              expectedVersion: up.version!,
              classEntryId: up.classEntries!.single.id!,
            ));
        expect(downAgain.derived!.spellSlots, isNull);
        expect(downAgain.derived!.alwaysPreparedSpellKeys, isEmpty);
        expect(downAgain.spellSelections!.map((s) => s.id),
            up.spellSelections!.map((s) => s.id));
      } finally {
        await session.close();
      }
    });
  });
}
