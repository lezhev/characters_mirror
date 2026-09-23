import 'dart:math';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_proficiency_state.dart';

part 'offline_character_resolver/spell_equipment_helpers.dart';
part 'offline_character_resolver/ability_proficiency_helpers.dart';
part 'offline_character_resolver/feature_helpers.dart';
part 'offline_character_resolver/starting_equipment_helpers.dart';
part 'offline_character_resolver/offline_keys.dart';

Future<CharacterData> resolveOfflineCharacter(
  OfflineCacheDatabase cache,
  CharacterData character,
) async {
  final derived = await buildOfflineDerivedData(cache, character);
  return character.copyWith(
    derived: derived,
    currentHp: character.currentHp ?? derived.maxHp,
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
  final totalLevel = max(
    1,
    entries.fold<int>(0, (sum, entry) => sum + (entry.level ?? 0)),
  );
  final proficiencyBonus = 2 + ((totalLevel - 1) ~/ 4);
  final abilityScores = _abilityScores(character);
  final abilityModifiers = {
    for (final entry in abilityScores.entries)
      entry.key: _modifier(entry.value),
  };
  final savingThrowProficiencies = _savingThrowProficiencies(character);
  final skillLevels = _skillProficiencyLevels(character);
  final savingThrowBonuses = {
    for (final ability in Ability.values)
      ability.name: (abilityModifiers[ability.name] ?? 0) +
          (savingThrowProficiencies.contains(ability) ? proficiencyBonus : 0),
  };
  final skillBonuses = {
    for (final skill in Skill.values)
      skill.name: (abilityModifiers[abilityForSkill(skill).name] ?? 0) +
          _skillMultiplier(skillLevels[skill]!) * proficiencyBonus,
  };
  final activeFeatures = await _activeFeatures(
    cache,
    character,
    totalLevel,
    proficiencyBonus,
    abilityModifiers,
  );
  final hitDice = _hitDiceSummary(character, entries);
  final maxHp = _maxHp(
    character,
    entries,
    abilityModifiers[Ability.constitution.name] ?? 0,
  );
  final dexterityModifier = abilityModifiers[Ability.dexterity.name] ?? 0;
  final grantedEquipment = await _collectGrantedEquipment(cache, character);
  final alwaysPreparedSpellKeys = _collectAlwaysPreparedSpellKeys(character);
  final grantedSpellKeys = _collectGrantedSpellKeys(
    character,
    alwaysPreparedSpellKeys,
  );
  final movementSpeeds = effectiveMovementSpeeds(character);

  return CharacterDerivedData(
    totalLevel: totalLevel,
    proficiencyBonus: proficiencyBonus,
    abilityScores: abilityScores,
    abilityModifiers: abilityModifiers,
    activeFeatures: activeFeatures,
    armorClass: 10 + dexterityModifier + (character.customArmorClassBonus ?? 0),
    initiative: dexterityModifier + (character.customInitiativeBonus ?? 0),
    speed: displayedMovementSpeed(character.displayedSpeedKind, movementSpeeds),
    maxHp: maxHp,
    passivePerception: 10 + (skillBonuses[Skill.perception.name] ?? 0),
    passiveInvestigation: 10 + (skillBonuses[Skill.investigation.name] ?? 0),
    passiveInsight: 10 + (skillBonuses[Skill.insight.name] ?? 0),
    savingThrowBonuses: savingThrowBonuses,
    skillBonuses: skillBonuses,
    skillProficiencyLevels: [
      for (final skill in Skill.values)
        CharacterSkillProficiencyState(
            skill: skill, level: skillLevels[skill]!),
    ],
    savingThrowProficiencies: savingThrowProficiencies.toList()
      ..sort((a, b) => a.name.compareTo(b.name)),
    hitDiceSummary: hitDice,
    languages: _uniqueStrings([
      for (final language in character.race?.languages ?? const <Language>[])
        language.name,
    ]),
    toolProficiencies: _uniqueStrings([
      ...?character.race?.toolProficiencies,
      ...?character.subrace?.toolProficiencies,
    ]),
    armorTraining: _uniqueStrings([
      for (final training
          in character.race?.armorProficiencies ?? const <ArmorCategory>[])
        training.name,
      for (final training
          in character.subrace?.armorProficiencies ?? const <ArmorCategory>[])
        training.name,
      for (final entry in entries)
        ...?entry.classData?.armorTraining?.map((item) => item.name),
    ]),
    weaponTraining: _uniqueStrings([
      ...?character.race?.weaponProficiencies,
      ...?character.subrace?.weaponProficiencies,
      for (final entry in entries)
        ...?entry.classData?.weaponTraining?.map((item) => item.name),
    ]),
    featureTags: _featureTags(activeFeatures),
    grantedSpellKeys: grantedSpellKeys,
    alwaysPreparedSpellKeys: alwaysPreparedSpellKeys,
    grantedEquipment: grantedEquipment,
    senses: _uniqueStrings([
      if (character.race?.visionType != null)
        _senseLabel(
          character.race!.visionType!,
          character.subrace?.visionRangeOverride ?? character.race?.visionRange,
        ),
    ]),
    resistances: _uniqueDamageTypes([
      ...?character.race?.resistances,
      ...?character.subrace?.resistances,
    ]),
    rebuiltAt: DateTime.now().toUtc(),
  );
}
