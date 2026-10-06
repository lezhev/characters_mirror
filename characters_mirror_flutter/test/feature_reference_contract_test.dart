import 'dart:convert';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character_spells/spell_selection_support.dart';
import 'package:characters_mirror_flutter/core/character_spells/spellcasting_source.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/application/expertise_owned_proficiencies.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_fixtures/feature_reference_contract.dart';

void main() {
  late OfflineCacheDatabase cache;
  final data = ClassData(
      id: 1,
      referenceKey: 'fixture_class',
      spellcastingProgression: SpellcastingProgression.none,
      spellSelectionMode: ClassSpellSelectionMode.none);
  final subclass = SubclassData(
      id: 2,
      parentClassId: 1,
      referenceKey: 'fixture_subclass',
      levelRequired: 3,
      spellcastingProgression: SpellcastingProgression.third,
      spellSelectionMode: ClassSpellSelectionMode.known,
      spellcastingAbilityValue: Ability.intelligence);
  final base = ClassFeatureData(
      id: 3,
      parentClassId: 1,
      referenceKey: 'fixture_base',
      level: 1,
      grantedSkills: [
        Skill.history
      ],
      grantedExpertiseSkills: [
        Skill.history
      ],
      grantedLanguages: [
        Language.common
      ],
      grantedSpellKeys: [
        'fixture_fixed'
      ],
      resources: [
        FeatureResourceDefinitionData(
            classFeatureId: 3,
            key: 'fixture_pool',
            kind: FeatureResourceKind.points,
            maxRule: FeatureResourceMaxRule.fixed,
            maxValue: 2)
      ]);
  final feature = SubclassFeatureData(
      id: 4,
      parentSubclassId: 2,
      referenceKey: 'fixture_subfeature',
      level: 3,
      grantedSkills: [
        Skill.stealth
      ],
      grantedLanguages: [
        Language.elvish
      ],
      grantedArmorTraining: [
        ArmorCategory.heavy
      ],
      grantedWeaponTraining: [
        WeaponCategory.martialMelee,
        WeaponCategory.martialRanged
      ],
      grantedToolKeys: [
        'fixture_disguise',
        'fixture_poison'
      ],
      grantedExpertiseToolKeys: [
        'fixture_poison'
      ],
      resources: [
        FeatureResourceDefinitionData(
            subclassFeatureId: 4,
            key: 'fixture_choice_pool',
            kind: FeatureResourceKind.uses,
            maxRule: FeatureResourceMaxRule.fixed,
            maxValue: 1,
            choiceOptionId: 6)
      ],
      resourceEffects: [
        FeatureResourceEffectData(
            subclassFeatureId: 4,
            type: FeatureResourceEffectType.modify,
            targetResourceKey: 'fixture_pool',
            addMaxValue: 3,
            choiceOptionId: 6),
        FeatureResourceEffectData(
            subclassFeatureId: 4,
            type: FeatureResourceEffectType.spend,
            targetResourceKey: 'fixture_pool',
            amountRule: FeatureResourceMaxRule.fixed,
            amountValue: 1,
            choiceOptionId: 6)
      ]);
  final rows = [
    for (final level in [1, 2, 3])
      ClassLevelData(classDataId: 1, level: level, knownSpells: 0),
    ClassLevelData(
        classDataId: 1,
        subclassDataId: 2,
        level: 3,
        knownCantrips: 1,
        knownSpells: 2)
  ];

  setUp(() async {
    cache = OfflineCacheDatabase.openInMemory();
    for (final level in [2, 3]) {
      await cache.putReference(
          offlineClassStepKind,
          offlineClassStepKey(1,
              selectedLevel: level, selectedSubclassId: level == 3 ? 2 : null),
          ClassStepView(
              classData: data,
              selectedLevel: level,
              currentLevelFeatures: [base],
              currentSubclassFeatures: level == 3 ? [feature] : []),
          (value) => value.toJson());
    }
    await cache.putReferenceList(
        'class_feature', offlineAllKey, [base], (value) => value.toJson());
    await cache.putReferenceList('subclass_feature', offlineAllKey, [feature],
        (value) => value.toJson());
    await cache.putReferenceList(
        'choice_group',
        offlineAllKey,
        [
          ChoiceGroupData(
              id: 5, referenceKey: 'fixture_group', sourceSubclassFeatureId: 4)
        ],
        (value) => value.toJson());
    await cache.putReferenceList(
        'choice_option',
        offlineAllKey,
        [
          ChoiceOptionData(
              id: 6,
              choiceGroupId: 5,
              optionKey: 'fixture_option',
              grantedToolKeys: ['fixture_choice_tool'],
              grantedSpellKeys: ['fixture_choice'])
        ],
        (value) => value.toJson());
    await cache.putReferenceList(
        'class_spell_grant',
        offlineAllKey,
        [
          ClassSpellGrantData(
              sourceSubclassFeatureId: 4,
              spell: SpellData(referenceKey: 'fixture_prepared'),
              alwaysPrepared: true,
              choiceOptionId: 6),
          ClassSpellGrantData(
              sourceSubclassFeatureId: 4,
              spell: SpellData(referenceKey: 'fixture_null')),
          ClassSpellGrantData(
              sourceSubclassFeatureId: 4,
              spell: SpellData(referenceKey: 'fixture_null'),
              alwaysPrepared: false),
        ],
        (value) => value.toJson());
    await cache.putReferenceList(
        'spell_slot_progression',
        offlineAllKey,
        [
          SpellSlotProgressionData(
              tableKey: 'standard', level: 1, spellSlots: {1: 2})
        ],
        (value) => value.toJson());
  });
  tearDown(() => cache.close());

  CharacterData character({bool selected = true, int level = 3}) =>
      CharacterData(
          classEntries: [
            CharacterClassEntryData(
                id: 'entry',
                classData: data,
                subclass: level >= 3 ? subclass : null,
                level: level,
                isStartingClass: true)
          ],
          choices: selected && level >= 3
              ? [
                  CharacterChoiceData(
                      groupKey: 'fixture_group', optionKey: 'fixture_option')
                ]
              : []);

  test('fixed and selected grants match the server contract', () async {
    final derived = await buildOfflineDerivedData(cache, character());
    final json =
        jsonDecode(jsonEncode(derived.toJson())) as Map<String, dynamic>;
    expect(featureReferenceProjection(json), selectedFeatureReferenceContract);
    expect(
        derived.activeFeatures!
            .firstWhere((f) => f.sourceId == base.id)
            .resources!
            .single
            .current,
        2);
    final entry = character().classEntries!.single;
    expect(spellcastingClassForEntry(entry)!.spellcastingAbilityValue,
        Ability.intelligence);
    expect(
        spellMode(
            spellcastingClassForEntry(entry), spellLevelForEntry(entry, rows)),
        ClassSpellSelectionMode.known);
    expect(spellLevelForEntry(entry, rows)!.knownSpells, 2);
  });

  test('unselected options revoke grants and resource modifications', () async {
    final derived =
        await buildOfflineDerivedData(cache, character(selected: false));
    expect(
        featureReferenceProjection(
            jsonDecode(jsonEncode(derived.toJson())) as Map<String, dynamic>),
        unselectedFeatureReferenceContract);
  });

  test('level down revokes subclass grants and spellcasting', () async {
    final lower = character(level: 2);
    final derived = await buildOfflineDerivedData(cache, lower);
    expect(derived.toolProficiencyKeys, isEmpty);
    expect(derived.armorTraining, isEmpty);
    expect(derived.spellSlots, isNull);
    expect(derived.grantedSpellKeys, ['fixture_fixed']);
    expect(
        spellcastingClassForEntry(lower.classEntries!.single)!
            .spellSelectionMode,
        ClassSpellSelectionMode.none);
  });

  test('manual proficiency overrides retain precedence over fixed grants',
      () async {
    final derived = await buildOfflineDerivedData(
        cache,
        character().copyWith(
          manualSkillProficiencyOverrides: [
            CharacterSkillProficiencyState(
                skill: Skill.history,
                level: CharacterSkillProficiencyLevel.none)
          ],
          manualArmorTrainingOverrides: CharacterArmorTrainingOverridesData(
              removedCategories: [ArmorCategory.heavy]),
          manualToolProficiencyOverrides: CharacterToolProficiencyOverridesData(
              removedKeys: ['fixture_poison']),
        ));
    expect(
        derived.skillProficiencyLevels!
            .firstWhere((s) => s.skill == Skill.history)
            .level,
        CharacterSkillProficiencyLevel.none);
    expect(derived.armorTraining, isEmpty);
    expect(derived.toolExpertiseKeys, isEmpty);
  });

  test('subclass activation level and parent relation gate spellcasting', () {
    expect(
        effectiveSpellcastingClass(data, subclass, 2).spellcastingProgression,
        SpellcastingProgression.none);
    expect(
        effectiveSpellcastingClass(
                data, subclass.copyWith(spellcastingStartLevel: 4), 3)
            .spellcastingProgression,
        SpellcastingProgression.none);
    expect(
        effectiveSpellcastingClass(data, subclass.copyWith(parentClassId: 9), 3)
            .spellcastingProgression,
        SpellcastingProgression.none);
    expect(
        effectiveSpellProgression(
            data, subclass, [rows.last.copyWith(classDataId: 9)]),
        isEmpty);
  });

  test('subclass third caster uses multiclass floor rounding', () async {
    await cache.putReferenceList(
        'spell_slot_progression',
        offlineAllKey,
        [
          SpellSlotProgressionData(
              tableKey: 'standard', level: 1, spellSlots: {1: 2}),
          SpellSlotProgressionData(
              tableKey: 'standard', level: 2, spellSlots: {1: 3}),
        ],
        (value) => value.toJson());
    final mixed = character().copyWith(classEntries: [
      character().classEntries!.single,
      CharacterClassEntryData(
          classData: ClassData(
              id: 9, spellcastingProgression: SpellcastingProgression.full),
          level: 1),
    ]);
    expect((await buildOfflineDerivedData(cache, mixed)).spellSlots, {1: 3});
  });

  test('creation expertise eligibility includes fixed feature proficiencies',
      () {
    final owned = resolveExpertiseOwnedProficiencies(
      character: character(),
      selectedBackground: null,
      selectedClass: data,
      classSkillSelections: [],
      backgroundSkillSelections: [],
      selectedOptions: {},
      expertiseGroupKey: 'fixture_expertise',
      classStep: ClassStepView(
          currentLevelFeatures: [base], currentSubclassFeatures: [feature]),
    );
    expect(owned.skills, containsAll([Skill.history, Skill.stealth]));
    expect(owned.toolKeys, containsAll(['fixture_disguise', 'fixture_poison']));
  });
}
