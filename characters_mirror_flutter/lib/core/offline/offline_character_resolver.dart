import 'dart:math';
import 'package:characters_mirror_flutter/core/character/armor_class_feature_modifiers.dart';
import 'package:characters_mirror_flutter/core/character/feature_grants.dart';
import 'package:characters_mirror_flutter/core/character_spells/spellcasting_source.dart';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_proficiency_state.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart'
    as feature_modifiers;

part 'offline_character_resolver/spell_equipment_helpers.dart';
part 'offline_character_resolver/resolved_spells.dart';
part 'offline_character_resolver/ability_proficiency_helpers.dart';
part 'offline_character_resolver/feature_helpers.dart';
part 'offline_character_resolver/armor_class_helpers.dart';
part 'offline_character_resolver/starting_equipment_helpers.dart';
part 'offline_character_resolver/offline_keys.dart';
part 'offline_character_resolver/weapon_proficiency_helpers.dart';
part 'offline_character_resolver/feature_modifier_helpers.dart';

Future<CharacterData> resolveOfflineCharacter(
  OfflineCacheDatabase cache,
  CharacterData character,
) async {
  final derived = await buildOfflineDerivedData(cache, character);
  return character.copyWith(
    experience: character.experience ?? 0,
    derived: derived,
    currentHp: min(character.currentHp ?? derived.maxHp ?? 0, derived.maxHp ?? 0),
    temporaryHp: character.temporaryHp,
  );
}

Map<CharacterSpeedKind, int> effectiveMovementSpeeds(CharacterData character) {
  final walking = baseWalkingSpeed(character);
  return {
    CharacterSpeedKind.walking: character.walkingSpeed ?? walking,
    CharacterSpeedKind.swimming: character.swimmingSpeed ?? walking ~/ 2,
    CharacterSpeedKind.climbing: character.climbingSpeed ?? walking ~/ 2,
    CharacterSpeedKind.flying: character.flyingSpeed ?? 0,
  };
}

int baseWalkingSpeed(CharacterData character) {
  return character.subrace?.speedOverride ?? character.race?.speed ?? 30;
}

int displayedMovementSpeed(
  CharacterSpeedKind? kind,
  Map<CharacterSpeedKind, int> movementSpeeds,
) {
  return movementSpeeds[kind ?? CharacterSpeedKind.walking] ??
      movementSpeeds[CharacterSpeedKind.walking] ??
      30;
}

Future<CharacterDerivedData> buildOfflineDerivedData(
  OfflineCacheDatabase cache,
  CharacterData character,
) async {
  final entries = character.classEntries ?? const <CharacterClassEntryData>[];
  final totalLevel =
      max(1, entries.fold<int>(0, (sum, entry) => sum + (entry.level ?? 0)));
  final proficiencyBonus = 2 + ((totalLevel - 1) ~/ 4);
  final selectedOptions =
      await _selectedChoiceOptions(cache, character, entries);
  final currentClassFeatures = await _currentClassFeatures(cache, entries);
  final currentSubclassFeatures =
      await _currentSubclassFeatures(cache, entries);
  final fixedGrants =
      collectFixedFeatureGrants(currentClassFeatures, currentSubclassFeatures);
  final abilityScoreValues = _abilityScores(character, selectedOptions);
  final abilityScores = <Ability, int>{
    for (final ability in Ability.values)
      ability: abilityScoreValues[ability.name] ?? 10,
  };
  final abilityModifiers = <Ability, int>{
    for (final entry in abilityScores.entries)
      entry.key: _modifier(entry.value),
  };
  final savingThrowProficiencies = _savingThrowProficiencies(character);
  final skillLevels = _skillProficiencyLevels(character, selectedOptions,
      fixedSkills: fixedGrants.grantedSkills,
      fixedExpertiseSkills: fixedGrants.grantedExpertiseSkills);
  final savingThrowBonuses = <Ability, int>{
    for (final ability in Ability.values)
      ability: (abilityModifiers[ability] ?? 0) +
          (savingThrowProficiencies.contains(ability) ? proficiencyBonus : 0),
  };
  final skillBonuses = <Skill, int>{};
  for (final skill in Skill.values) {
    final multiplier = _skillMultiplier(skillLevels[skill]!);
    skillBonuses[skill] = (abilityModifiers[abilityForSkill(skill)] ?? 0) +
        multiplier * proficiencyBonus +
        await _offlineFeatureModifierTotal(
          cache,
          entries,
          character,
          proficiencyBonus: proficiencyBonus,
          target: FeatureModifierTarget.abilityCheck,
          abilityCheckIncludesProficiency: multiplier > 0,
        );
  }
  final activeFeatures = await _activeFeatures(
    cache,
    character,
    totalLevel,
    proficiencyBonus,
    abilityModifiers,
    selectedOptions,
  );
  final activeFeatureModifiers =
      await _offlineCurrentFeatureModifiers(cache, entries);
  final hitDice = _hitDiceSummary(character, entries);
  final spellSlots = await _spellSlots(cache, entries);
  final maxHp = max(
    1,
    _maxHp(character, entries, abilityModifiers[Ability.constitution] ?? 0) +
        await _offlineFeatureModifierTotal(
          cache, entries, character,
          proficiencyBonus: proficiencyBonus,
          target: FeatureModifierTarget.hitPointMaximum,
        ),
  );
  final dexterityModifier = abilityModifiers[Ability.dexterity] ?? 0;
  final armorClassModifiers = armorClassFeatureModifiers(
      activeFeatureModifiers, currentClassFeatures, currentSubclassFeatures);
  final armorClass = await _calculateArmorClass(cache, character,
      abilityModifiers, armorClassModifiers, proficiencyBonus);
  final grantedEquipment = await _collectGrantedEquipment(cache, character);
  final alwaysPreparedSpellKeys = await _collectAlwaysPreparedSpellKeys(
    cache,
    character,
    entries,
    totalLevel,
    selectedOptionIds: {
      for (final option in selectedOptions)
        if (option.id != null) option.id!
    },
  );
  final grantedClassSpellKeys = await _collectAlwaysPreparedSpellKeys(
    cache,
    character,
    entries,
    totalLevel,
    selectedOptionIds: {
      for (final option in selectedOptions)
        if (option.id != null) option.id!
    },
    onlyAlwaysPrepared: false,
  );
  final racialSpellKeys = _racialSpellKeys(character, totalLevel);
  final grantedSpellKeys = _collectGrantedSpellKeys(
    character,
    alwaysPreparedSpellKeys,
    racialSpellKeys,
    selectedOptions,
  )..addAll([...fixedGrants.grantedSpellKeys, ...grantedClassSpellKeys]);
  final uniqueGrantedSpellKeys = _uniqueStrings(grantedSpellKeys);
  final automaticLanguages = _languages(
    character,
    selectedOptions,
    currentClassFeatures,
  );
  final languages = _effectiveProficiencyValues<Language>(
    [...automaticLanguages, ...fixedGrants.grantedLanguages],
    character.manualLanguageOverrides?.added,
    character.manualLanguageOverrides?.removed,
    (value) => value.name,
  );
  final automaticToolKeys = await _toolProficiencyKeys(
    cache,
    character,
    entries,
  );
  final toolProficiencyKeys = _effectiveProficiencyValues<String>(
    [...automaticToolKeys, ...fixedGrants.grantedToolKeys],
    character.manualToolProficiencyOverrides?.addedKeys,
    character.manualToolProficiencyOverrides?.removedKeys,
    (value) => value,
  );
  final toolExpertiseKeys = {
    ...fixedGrants.grantedExpertiseToolKeys,
    for (final option in selectedOptions) ...?option.grantedExpertiseToolKeys,
  }.intersection(toolProficiencyKeys.toSet()).toList()
    ..sort();
  final automaticArmorTraining = await _armorTraining(
    cache,
    character,
    entries,
  );
  final armorTraining = _effectiveProficiencyValues<ArmorCategory>(
    [...automaticArmorTraining, ...fixedGrants.grantedArmorTraining],
    character.manualArmorTrainingOverrides?.addedCategories,
    character.manualArmorTrainingOverrides?.removedCategories,
    (value) => value.name,
  );
  final automaticWeaponTraining =
      await _weaponTraining(cache, character, entries);
  final weaponTraining = _effectiveProficiencyValues<WeaponCategory>(
    [...automaticWeaponTraining, ...fixedGrants.grantedWeaponTraining],
    character.manualWeaponProficiencyOverrides?.addedCategories,
    character.manualWeaponProficiencyOverrides?.removedCategories,
    (value) => value.name,
  );
  final weaponProficiencyKeys = _uniqueStrings([
    ...?character.race?.weaponProficiencyKeys,
    ...?character.subrace?.weaponProficiencyKeys,
    for (final entry in entries)
      ..._weaponKeysFromTrainingValues(
        (entry.isStartingClass ?? false)
            ? entry.classData?.weaponTraining
            : entry.classData?.multiclassWeaponTraining,
      ),
  ]);
  final effectiveWeaponKeys = _effectiveProficiencyValues<String>(
    weaponProficiencyKeys,
    character.manualWeaponProficiencyOverrides?.addedKeys,
    character.manualWeaponProficiencyOverrides?.removedKeys,
    (value) => value,
  );
  final movementSpeeds = effectiveMovementSpeeds(character);
  movementSpeeds[CharacterSpeedKind.walking] =
      (movementSpeeds[CharacterSpeedKind.walking] ?? 30) +
          await _offlineFeatureModifierTotal(
            cache,
            entries,
            character,
            proficiencyBonus: proficiencyBonus,
            target: FeatureModifierTarget.speed,
          );
  final initiativeBonus = await _offlineFeatureModifierTotal(
    cache,
    entries,
    character,
    proficiencyBonus: proficiencyBonus,
    target: FeatureModifierTarget.abilityCheck,
  );

  return CharacterDerivedData(
    totalLevel: totalLevel,
    proficiencyBonus: proficiencyBonus,
    abilityScores: abilityScores,
    abilityModifiers: abilityModifiers,
    activeFeatures: activeFeatures,
    featureModifiers: [
      ...feature_modifiers.activeFeatureModifierRows(
        character.toJson(),
        activeFeatureModifiers
            .where((modifier) =>
                modifier.target != FeatureModifierTarget.armorClass)
            .map((modifier) => modifier.toJson()),
        classFeatures: currentClassFeatures.map((f) => f.toJson()),
        subclassFeatures: currentSubclassFeatures.map((f) => f.toJson()),
      ).map(FeatureModifierData.fromJson),
      ...armorClassModifiers,
    ],
    armorClass: armorClass.value,
    armorClassSource: armorClass.source,
    armorClassFormula: armorClass.formula,
    initiative: dexterityModifier +
        (character.customInitiativeBonus ?? 0) +
        initiativeBonus,
    speed: displayedMovementSpeed(character.displayedSpeedKind, movementSpeeds),
    maxHp: maxHp,
    passivePerception: 10 + skillBonuses[Skill.perception]!,
    passiveInvestigation: 10 + skillBonuses[Skill.investigation]!,
    passiveInsight: 10 + skillBonuses[Skill.insight]!,
    savingThrowBonuses: savingThrowBonuses,
    skillBonuses: skillBonuses,
    skillProficiencyLevels: [
      for (final skill in Skill.values)
        CharacterSkillProficiencyState(
            skill: skill, level: skillLevels[skill]!),
    ],
    savingThrowProficiencies: savingThrowProficiencies.toList()
      ..sort((a, b) =>
          Ability.values.indexOf(a).compareTo(Ability.values.indexOf(b))),
    spellSlots: spellSlots.$1,
    pactSlots: spellSlots.$2,
    hitDiceSummary: hitDice,
    languages: languages,
    toolProficiencyKeys: toolProficiencyKeys,
    toolExpertiseKeys: toolExpertiseKeys,
    armorTraining: armorTraining,
    weaponTraining: weaponTraining,
    weaponProficiencyKeys: effectiveWeaponKeys,
    customLanguages: _normalizedCustomValues(
      character.manualLanguageOverrides?.custom,
    ),
    customToolProficiencies: _normalizedCustomValues(
      character.manualToolProficiencyOverrides?.custom,
    ),
    customWeaponProficiencies: _normalizedCustomValues(
      character.manualWeaponProficiencyOverrides?.custom,
    ),
    customArmorTraining: _normalizedCustomValues(
      character.manualArmorTrainingOverrides?.custom,
    ),
    resolvedSpells: await _resolveCharacterSpells(cache, character,
        currentClassFeatures, currentSubclassFeatures, selectedOptions),
    grantedSpellKeys: uniqueGrantedSpellKeys,
    alwaysPreparedSpellKeys: alwaysPreparedSpellKeys,
    grantedEquipment: grantedEquipment,
    resistances: _uniqueDamageTypes([
      ...?character.race?.resistances,
      ...?character.subrace?.resistances,
      for (final option in selectedOptions)
        if (option.damageType != null) option.damageType!,
    ]),
  );
}
