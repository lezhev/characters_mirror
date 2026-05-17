import 'dart:math';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_proficiency_state.dart';

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

  return CharacterDerivedData(
    totalLevel: totalLevel,
    proficiencyBonus: proficiencyBonus,
    abilityScores: abilityScores,
    abilityModifiers: abilityModifiers,
    activeFeatures: activeFeatures,
    armorClass: 10 + dexterityModifier,
    initiative: dexterityModifier,
    speed: character.subrace?.speedOverride ?? character.race?.speed ?? 30,
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
      ...?character.race?.languages,
    ]),
    toolProficiencies: _uniqueStrings([
      ...?character.race?.toolProficiencies,
      ...?character.subrace?.toolProficiencies,
    ]),
    armorTraining: _uniqueStrings([
      ...?character.race?.armorProficiencies,
      ...?character.subrace?.armorProficiencies,
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

List<String> _collectAlwaysPreparedSpellKeys(CharacterData character) {
  return _uniqueStrings(character.derived?.alwaysPreparedSpellKeys ?? const []);
}

List<String> _collectGrantedSpellKeys(
  CharacterData character,
  List<String> alwaysPreparedSpellKeys,
) {
  return _uniqueStrings([
    ...alwaysPreparedSpellKeys,
    for (final selection
        in character.spellSelections ?? const <CharacterSpellSelectionData>[])
      if (_spellSelectionKey(selection) != null) _spellSelectionKey(selection)!,
  ]);
}

String? _spellSelectionKey(CharacterSpellSelectionData selection) {
  return _normalizedTextOrNull(selection.spellKey) ??
      _normalizedTextOrNull(selection.spell?.referenceKey) ??
      _normalizedTextOrNull(selection.spell?.name);
}

Future<List<CharacterEquipmentEntryView>> _collectGrantedEquipment(
  OfflineCacheDatabase cache,
  CharacterData character,
) async {
  final weapons = await cache.getReferenceList(
        'weapon',
        offlineAllKey,
        WeaponData.fromJson,
      ) ??
      const <WeaponData>[];
  final items = await cache.getReferenceList(
        'item',
        offlineAllKey,
        ItemData.fromJson,
      ) ??
      const <ItemData>[];
  final armor = await cache.getReferenceList(
        'armor',
        offlineAllKey,
        ArmorData.fromJson,
      ) ??
      const <ArmorData>[];

  final startingEntry = _startingClassEntry(
    character.classEntries ?? const <CharacterClassEntryData>[],
  );
  final startingClass = startingEntry?.classData;
  final startingClassId = startingClass?.id;
  final backgroundId = character.background?.id;
  final classStepView = startingClassId == null
      ? null
      : await cache.getReference<ClassStepView>(
          offlineClassStepKind,
          offlineClassStepKey(
            startingClassId,
            selectedLevel: startingEntry?.level ?? 1,
            selectedSubclassId: startingEntry?.subclass?.id,
          ),
          ClassStepView.fromJson,
        );
  final backgroundStepView = backgroundId == null
      ? null
      : await cache.getReference<BackgroundStepView>(
          offlineBackgroundStepKind,
          offlineBackgroundStepKey(backgroundId),
          BackgroundStepView.fromJson,
        );
  final relevantBlocks = <_StartingEquipmentSourceBlock>[
    if (startingClassId != null)
      ..._sourceBlocksFor(
        sourceType: ChoiceSourceType.classData,
        sourceId: startingClassId,
        blocks: classStepView?.startingEquipmentBlocks,
      ),
    if (backgroundId != null)
      ..._sourceBlocksFor(
        sourceType: ChoiceSourceType.background,
        sourceId: backgroundId,
        blocks: backgroundStepView?.startingEquipmentBlocks,
      ),
  ]..sort((a, b) {
      final sourceCompare = a.sourceType.name.compareTo(b.sourceType.name);
      if (sourceCompare != 0) return sourceCompare;
      final idCompare = a.sourceId.compareTo(b.sourceId);
      if (idCompare != 0) return idCompare;
      return (a.blockView.block?.orderIndex ?? 0)
          .compareTo(b.blockView.block?.orderIndex ?? 0);
    });
  if (relevantBlocks.isEmpty) {
    return const <CharacterEquipmentEntryView>[];
  }

  final selections = character.startingEquipmentSelections ??
      const <CharacterStartingEquipmentSelectionData>[];
  final accumulated = <String, _GrantedEquipmentAccumulator>{};
  for (final sourceBlock in relevantBlocks) {
    final blockView = sourceBlock.blockView;
    final block = blockView.block;
    if (block == null) continue;
    final sourceSelections = _matchingStartingEquipmentSelections(
      selections,
      sourceType: sourceBlock.sourceType,
      sourceId: sourceBlock.sourceId,
      block: block,
    );
    final blockLines = _sortedStartingEquipmentLines(
      block.fixedLines ?? blockView.fixedLines,
    );
    if (block.kind == StartingEquipmentBlockKind.choice) {
      _applyStartingEquipmentLines(
        blockLines,
        _collectBlockLevelResolutions(sourceSelections),
        weapons,
        items,
        armor,
        accumulated,
      );
      for (final selection in sourceSelections) {
        if (selection.isSelected == false) continue;
        final option = _startingEquipmentOptionForEntryId(
          blockView.options,
          selection.choiceOptionEntryId,
        );
        if (option == null) continue;
        _applyStartingEquipmentLines(
          _sortedStartingEquipmentLines(option.option?.lines ?? option.lines),
          selection.resolutions ??
              const <CharacterStartingEquipmentResolutionData>[],
          weapons,
          items,
          armor,
          accumulated,
        );
      }
      continue;
    }
    if (sourceSelections.any((selection) => selection.isSelected == false)) {
      continue;
    }

    _applyStartingEquipmentLines(
      blockLines,
      _collectBlockLevelResolutions(sourceSelections),
      weapons,
      items,
      armor,
      accumulated,
    );
  }

  final result = [
    for (final item in accumulated.values)
      CharacterEquipmentEntryView(
        catalogType: item.catalogType,
        referenceKey: item.referenceKey,
        displayText: item.displayText,
        quantity: item.quantity,
      ),
  ]..sort((a, b) {
      final textCompare = (a.displayText ?? '').compareTo(b.displayText ?? '');
      if (textCompare != 0) return textCompare;
      final typeCompare =
          (a.catalogType?.name ?? '').compareTo(b.catalogType?.name ?? '');
      if (typeCompare != 0) return typeCompare;
      return (a.referenceKey ?? '').compareTo(b.referenceKey ?? '');
    });
  return result;
}

Map<String, int> _abilityScores(CharacterData character) {
  final scores = {
    for (final ability in Ability.values) ability.name: 10,
    ...?character.baseAbilityScores,
  };
  if (character.useFlexibleAbilityBonuses != true) {
    _addBonus(scores, Ability.strength, character.race?.strengthBonus);
    _addBonus(scores, Ability.dexterity, character.race?.dexterityBonus);
    _addBonus(scores, Ability.constitution, character.race?.constitutionBonus);
    _addBonus(scores, Ability.intelligence, character.race?.intelligenceBonus);
    _addBonus(scores, Ability.wisdom, character.race?.wisdomBonus);
    _addBonus(scores, Ability.charisma, character.race?.charismaBonus);
    _addBonus(scores, Ability.strength, character.subrace?.strengthBonus);
    _addBonus(scores, Ability.dexterity, character.subrace?.dexterityBonus);
    _addBonus(
        scores, Ability.constitution, character.subrace?.constitutionBonus);
    _addBonus(
        scores, Ability.intelligence, character.subrace?.intelligenceBonus);
    _addBonus(scores, Ability.wisdom, character.subrace?.wisdomBonus);
    _addBonus(scores, Ability.charisma, character.subrace?.charismaBonus);
  }
  for (final entry in character.customAbilityBonuses?.entries ??
      const Iterable<MapEntry<String, int>>.empty()) {
    scores[entry.key] = (scores[entry.key] ?? 10) + entry.value;
  }
  return scores;
}

void _addBonus(Map<String, int> scores, Ability ability, int? bonus) {
  if (bonus == null) return;
  scores[ability.name] = (scores[ability.name] ?? 10) + bonus;
}

int _modifier(int score) => ((score - 10) / 2).floor();

Set<Ability> _savingThrowProficiencies(CharacterData character) {
  final result = <Ability>{};
  for (final entry
      in character.classEntries ?? const <CharacterClassEntryData>[]) {
    result.addAll(entry.classData?.savingThrowProficiencies ?? const []);
  }
  result.addAll(character.manualSavingThrowProficiencies ?? const []);
  return result;
}

Map<Skill, CharacterSkillProficiencyLevel> _skillProficiencyLevels(
  CharacterData character,
) {
  final result = {
    for (final skill in Skill.values)
      skill: CharacterSkillProficiencyLevel.none,
  };
  for (final name in [
    ...?character.race?.skillProficiencies,
    ...?character.subrace?.skillProficiencies,
    ...?character.background?.skillProficiencies,
  ]) {
    final skill = _skillFromName(name);
    if (skill != null) {
      result[skill] = CharacterSkillProficiencyLevel.proficient;
    }
  }
  for (final selection
      in character.skillSelections ?? const <CharacterSkillSelectionData>[]) {
    final skill = selection.skill;
    if (skill != null) {
      result[skill] = CharacterSkillProficiencyLevel.proficient;
    }
  }
  for (final state in character.manualSkillProficiencies ??
      const <CharacterSkillProficiencyState>[]) {
    result[state.skill] = state.level;
  }
  return result;
}

Skill? _skillFromName(String value) {
  final normalized = value.trim();
  for (final skill in Skill.values) {
    if (skill.name == normalized) return skill;
  }
  return null;
}

int _skillMultiplier(CharacterSkillProficiencyLevel level) {
  switch (level) {
    case CharacterSkillProficiencyLevel.none:
      return 0;
    case CharacterSkillProficiencyLevel.proficient:
      return 1;
    case CharacterSkillProficiencyLevel.expertise:
      return 2;
  }
}

Future<List<CharacterFeatureViewData>> _activeFeatures(
  OfflineCacheDatabase cache,
  CharacterData character,
  int totalLevel,
  int proficiencyBonus,
  Map<String, int> abilityModifiers,
) async {
  final result = <CharacterFeatureViewData>[];
  final resourceStatesByKey = {
    for (final state
        in character.resourceStates ?? const <CharacterResourceStateData>[])
      _featureResourceKey(state.sourceType, state.sourceId, state.resourceKey):
          state,
  };
  void addFeature({
    required CharacterFeatureSourceType sourceType,
    required int? sourceId,
    required String? sourceName,
    required int? level,
    required String? name,
    required String? description,
    required List<FeatureTag>? tags,
    required List<FeatureResourceDefinitionData>? resources,
    required int sourceClassLevel,
  }) {
    if (sourceId == null || (level ?? 1) > totalLevel) return;
    final override =
        (character.featureOverrides ?? const <CharacterFeatureOverrideData>[])
            .where(
              (item) =>
                  item.sourceType == sourceType && item.sourceId == sourceId,
            )
            .firstOrNull;
    final resolvedName = override?.name ?? name;
    result.add(
      CharacterFeatureViewData(
        sourceType: sourceType,
        sourceId: sourceId,
        sourceName: sourceName,
        level: level,
        defaultName: name,
        defaultDescription: description,
        defaultTags: tags,
        name: resolvedName,
        description: override?.description ?? description,
        tags: override?.tags ?? tags,
        isCustomized: override != null,
        resources: _resourceViews(
          defaultName: resolvedName,
          sourceType: sourceType,
          sourceId: sourceId,
          resources: resources,
          sourceClassLevel: sourceClassLevel,
          totalLevel: totalLevel,
          proficiencyBonus: proficiencyBonus,
          abilityModifiers: abilityModifiers,
          resourceStatesByKey: resourceStatesByKey,
        ),
      ),
    );
  }

  for (final feature in character.race?.features ?? const <RaceFeatureData>[]) {
    addFeature(
      sourceType: CharacterFeatureSourceType.raceFeature,
      sourceId: feature.id,
      sourceName: character.race?.name,
      level: feature.level,
      name: feature.name,
      description: feature.shortDescription ?? feature.description,
      tags: feature.tags,
      resources: feature.resources,
      sourceClassLevel: totalLevel,
    );
  }
  for (final feature
      in character.subrace?.features ?? const <RaceFeatureData>[]) {
    addFeature(
      sourceType: CharacterFeatureSourceType.subraceFeature,
      sourceId: feature.id,
      sourceName: character.subrace?.name,
      level: feature.level,
      name: feature.name,
      description: feature.shortDescription ?? feature.description,
      tags: feature.tags,
      resources: feature.resources,
      sourceClassLevel: totalLevel,
    );
  }
  for (final entry
      in character.classEntries ?? const <CharacterClassEntryData>[]) {
    final classId = entry.classData?.id;
    if (classId == null) continue;
    final stepView = await cache.getReference<ClassStepView>(
      offlineClassStepKind,
      offlineClassStepKey(
        classId,
        selectedLevel: entry.level ?? 1,
        selectedSubclassId: entry.subclass?.id,
      ),
      ClassStepView.fromJson,
    );
    for (final feature
        in stepView?.currentLevelFeatures ?? const <ClassFeatureData>[]) {
      addFeature(
        sourceType: CharacterFeatureSourceType.classFeature,
        sourceId: feature.id,
        sourceName: entry.classData?.name,
        level: feature.level,
        name: feature.name,
        description: feature.shortDescription ?? feature.description,
        tags: feature.tags,
        resources: feature.resources,
        sourceClassLevel: entry.level ?? feature.level,
      );
    }
    for (final feature
        in stepView?.currentSubclassFeatures ?? const <SubclassFeatureData>[]) {
      addFeature(
        sourceType: CharacterFeatureSourceType.subclassFeature,
        sourceId: feature.id,
        sourceName: entry.subclass?.name,
        level: feature.level,
        name: feature.name,
        description: feature.shortDescription ?? feature.description,
        tags: feature.tags,
        resources: feature.resources,
        sourceClassLevel: entry.level ?? feature.level,
      );
    }
  }

  result.sort((a, b) {
    final levelCompare = (a.level ?? 1).compareTo(b.level ?? 1);
    if (levelCompare != 0) return levelCompare;
    return (a.name ?? a.defaultName ?? '')
        .compareTo(b.name ?? b.defaultName ?? '');
  });
  return result;
}

List<CharacterResourceViewData>? _resourceViews({
  required String? defaultName,
  required CharacterFeatureSourceType sourceType,
  required int sourceId,
  required List<FeatureResourceDefinitionData>? resources,
  required int sourceClassLevel,
  required int totalLevel,
  required int proficiencyBonus,
  required Map<String, int> abilityModifiers,
  required Map<String, CharacterResourceStateData> resourceStatesByKey,
}) {
  if (resources == null || resources.isEmpty) return null;
  final result = <CharacterResourceViewData>[];
  final sortedResources = [...resources]
    ..sort((a, b) => a.key.compareTo(b.key));
  for (final resource in sortedResources) {
    final isUnlimited = _isResourceUnlimited(resource, sourceClassLevel);
    final maxValue = isUnlimited
        ? 0
        : _resourceMax(
            rule: resource.maxRule,
            value: resource.maxValue,
            ability: resource.maxAbility,
            progressionValues: resource.progressionValues,
            sourceClassLevel: sourceClassLevel,
            totalLevel: totalLevel,
            proficiencyBonus: proficiencyBonus,
            abilityModifiers: abilityModifiers,
          );
    if (!isUnlimited && maxValue <= 0) continue;
    final state = resourceStatesByKey[
        _featureResourceKey(sourceType, sourceId, resource.key)];
    result.add(
      CharacterResourceViewData(
        key: resource.key,
        name: resource.name ?? defaultName,
        kind: resource.kind,
        current: isUnlimited
            ? 0
            : (state?.current ?? maxValue).clamp(0, maxValue).toInt(),
        max: isUnlimited ? 0 : maxValue,
        isUnlimited: isUnlimited ? true : null,
        resetOn: resource.resetOn,
        usageResetOn: resource.usageResetOn,
        activationTrigger: resource.activationTrigger,
      ),
    );
  }
  return result.isEmpty ? null : result;
}

int _resourceMax({
  required FeatureResourceMaxRule rule,
  required int? value,
  required Ability? ability,
  required List<FeatureResourceProgressionValueData>? progressionValues,
  required int sourceClassLevel,
  required int totalLevel,
  required int proficiencyBonus,
  required Map<String, int> abilityModifiers,
}) {
  final normalizedValue = max(value ?? 1, 1);
  final additiveValue = value ?? 0;
  switch (rule) {
    case FeatureResourceMaxRule.fixed:
      return normalizedValue;
    case FeatureResourceMaxRule.proficiencyBonus:
      return proficiencyBonus;
    case FeatureResourceMaxRule.abilityModifier:
      return (ability == null ? 0 : abilityModifiers[ability.name] ?? 0) +
          additiveValue;
    case FeatureResourceMaxRule.abilityModifierMinOne:
      return max(
        1,
        (ability == null ? 0 : abilityModifiers[ability.name] ?? 0) +
            additiveValue,
      );
    case FeatureResourceMaxRule.sourceClassLevel:
      return max(sourceClassLevel, 0);
    case FeatureResourceMaxRule.sourceClassLevelTimesValue:
      return max(sourceClassLevel, 0) * normalizedValue;
    case FeatureResourceMaxRule.totalLevel:
      return max(totalLevel, 0);
    case FeatureResourceMaxRule.totalLevelTimesValue:
      return max(totalLevel, 0) * normalizedValue;
    case FeatureResourceMaxRule.sourceClassLevelTable:
      final sortedValues = [...?progressionValues]
        ..sort((a, b) => a.level.compareTo(b.level));
      var resolved = 0;
      for (final item in sortedValues) {
        if (item.level <= sourceClassLevel) {
          resolved = item.value;
        }
      }
      return max(resolved, 0);
  }
}

bool _isResourceUnlimited(
  FeatureResourceDefinitionData resource,
  int sourceClassLevel,
) {
  final unlimitedAtLevel = resource.becomesUnlimitedAtLevel;
  return unlimitedAtLevel != null && sourceClassLevel >= unlimitedAtLevel;
}

String _featureResourceKey(
  CharacterFeatureSourceType sourceType,
  int sourceId,
  String resourceKey,
) {
  return '${sourceType.name}:$sourceId:$resourceKey';
}

Map<String, int> _hitDiceSummary(
  CharacterData character,
  List<CharacterClassEntryData> entries,
) {
  final result = <String, int>{};
  for (final entry in entries) {
    final hitDie = entry.classData?.hitDieValue;
    if (hitDie == null) continue;
    final key = 'd$hitDie';
    result[key] = (result[key] ?? 0) + (entry.level ?? 1);
  }

  for (final override in character.hitDiceMaxOverrides?.entries ??
      const Iterable<MapEntry<String, int>>.empty()) {
    final key = override.key.trim();
    if (key.isEmpty || !result.containsKey(key)) {
      continue;
    }
    result[key] = max(0, override.value);
  }

  final keys = result.keys.toList()..sort();
  return {
    for (final key in keys) key: result[key] ?? 0,
  };
}

int _maxHp(
  CharacterData character,
  List<CharacterClassEntryData> entries,
  int constitutionModifier,
) {
  var total = 0;
  var totalLevel = 0;
  final sortedEntries = [...entries]
    ..sort((a, b) => (a.classOrder ?? 0).compareTo(b.classOrder ?? 0));
  for (final entry in sortedEntries) {
    final level = max(0, entry.level ?? 0);
    final hitDie = max(1, entry.classData?.hitDieValue ?? 8);
    final fixedGain = max(1, (hitDie ~/ 2) + 1);
    final rolledValues = entry.hpRolledValues ?? const <int>[];
    for (var levelIndex = 0; levelIndex < level; levelIndex++) {
      totalLevel++;
      final defaultGain = totalLevel == 1 ? hitDie : fixedGain;
      final rawGain = levelIndex < rolledValues.length
          ? rolledValues[levelIndex]
          : defaultGain;
      total += rawGain.clamp(1, hitDie).toInt() + constitutionModifier;
    }
  }
  total += totalLevel * (character.hpPerLevelBonus ?? 0);
  total += character.hpFlatBonus ?? 0;
  return max(total, 1);
}

List<String> _uniqueStrings(Iterable<String> values) {
  return {
    for (final value in values)
      if (value.trim().isNotEmpty) value.trim(),
  }.toList()
    ..sort();
}

List<DamageType> _uniqueDamageTypes(Iterable<DamageType> values) {
  return {...values}.toList()..sort((a, b) => a.name.compareTo(b.name));
}

List<FeatureTag> _featureTags(List<CharacterFeatureViewData> features) {
  return {
    for (final feature in features) ...?feature.tags,
  }.toList()
    ..sort((a, b) => a.name.compareTo(b.name));
}

String _senseLabel(SenseType type, int? range) {
  final suffix = range == null ? '' : ' $range';
  return '${type.name}$suffix';
}

CharacterClassEntryData? _startingClassEntry(
  List<CharacterClassEntryData> entries,
) {
  for (final entry in entries) {
    if (entry.isStartingClass == true) return entry;
  }
  if (entries.isEmpty) return null;
  final sortedEntries = [...entries]
    ..sort((a, b) => (a.classOrder ?? 0).compareTo(b.classOrder ?? 0));
  return sortedEntries.first;
}

List<_StartingEquipmentSourceBlock> _sourceBlocksFor({
  required ChoiceSourceType sourceType,
  required int sourceId,
  required List<StartingEquipmentBlockView>? blocks,
}) {
  final result = <_StartingEquipmentSourceBlock>[];
  for (final blockView in blocks ?? const <StartingEquipmentBlockView>[]) {
    if (blockView.block?.entryId == null) continue;
    result.add(
      _StartingEquipmentSourceBlock(
        sourceType: sourceType,
        sourceId: sourceId,
        blockView: blockView,
      ),
    );
  }
  return result
    ..sort((a, b) => (a.blockView.block?.orderIndex ?? 0)
        .compareTo(b.blockView.block?.orderIndex ?? 0));
}

List<CharacterStartingEquipmentSelectionData>
    _matchingStartingEquipmentSelections(
  List<CharacterStartingEquipmentSelectionData> selections, {
  required ChoiceSourceType sourceType,
  required int sourceId,
  required StartingEquipmentBlockData block,
}) {
  final sourceEntryId = block.entryId;
  if (sourceEntryId == null) {
    return const <CharacterStartingEquipmentSelectionData>[];
  }

  return [
    for (final selection in selections)
      if (selection.sourceType == sourceType &&
          selection.sourceId == sourceId &&
          selection.sourceEntryId == sourceEntryId)
        selection,
  ]..sort((a, b) => (a.selectionIndex ?? 0).compareTo(b.selectionIndex ?? 0));
}

StartingEquipmentOptionView? _startingEquipmentOptionForEntryId(
  List<StartingEquipmentOptionView>? options,
  int? entryId,
) {
  if (entryId == null) return null;
  for (final option in options ?? const <StartingEquipmentOptionView>[]) {
    if (option.option?.entryId == entryId) {
      return option;
    }
  }
  return null;
}

List<StartingEquipmentLineData> _sortedStartingEquipmentLines(
  List<StartingEquipmentLineData>? lines,
) {
  return [...?lines]
    ..sort((a, b) => (a.orderIndex ?? 0).compareTo(b.orderIndex ?? 0));
}

List<CharacterStartingEquipmentResolutionData> _collectBlockLevelResolutions(
  List<CharacterStartingEquipmentSelectionData> selections,
) {
  final resolutions = <CharacterStartingEquipmentResolutionData>[];
  for (final selection in selections) {
    if (selection.choiceOptionEntryId != null) continue;
    resolutions.addAll(
      selection.resolutions ??
          const <CharacterStartingEquipmentResolutionData>[],
    );
  }
  return resolutions
    ..sort((a, b) =>
        (a.sourceLineEntryId ?? 0).compareTo(b.sourceLineEntryId ?? 0));
}

void _applyStartingEquipmentLines(
  List<StartingEquipmentLineData> lines,
  List<CharacterStartingEquipmentResolutionData> resolutions,
  List<WeaponData> weapons,
  List<ItemData> items,
  List<ArmorData> armor,
  Map<String, _GrantedEquipmentAccumulator> accumulated,
) {
  final resolutionsByLineEntryId = {
    for (final resolution in resolutions)
      if (resolution.sourceLineEntryId != null)
        resolution.sourceLineEntryId!: resolution,
  };

  for (final line in lines) {
    switch (line.kind) {
      case StartingEquipmentLineKind.catalogRef:
        final catalogType = line.catalogType;
        final referenceKey = _normalizedTextOrNull(line.referenceKey);
        if (catalogType == null || referenceKey == null) continue;
        _accumulateGrantedEquipment(
          accumulated,
          catalogType: catalogType,
          referenceKey: referenceKey,
          displayText: _catalogRefDisplayText(
            catalogType,
            referenceKey,
            weapons,
            items,
            armor,
          ),
          quantity: _positiveQuantity(line.quantity),
        );
        break;
      case StartingEquipmentLineKind.weaponCategory:
        final lineEntryId = line.entryId;
        if (lineEntryId == null) continue;
        final resolution = resolutionsByLineEntryId[lineEntryId];
        final referenceKey = _normalizedTextOrNull(resolution?.referenceKey);
        if (resolution?.catalogType != EquipmentCatalogType.weapon ||
            referenceKey == null) {
          continue;
        }
        final weapon = weapons
            .where((item) =>
                _normalizedTextOrNull(item.referenceKey) == referenceKey)
            .firstOrNull;
        if (weapon == null) continue;
        final allowed =
            line.allowedWeaponCategories ?? const <WeaponCategory>[];
        if (allowed.isNotEmpty && !allowed.contains(weapon.category)) {
          continue;
        }
        _accumulateGrantedEquipment(
          accumulated,
          catalogType: EquipmentCatalogType.weapon,
          referenceKey: referenceKey,
          displayText: _normalizedTextOrNull(weapon.name) ?? referenceKey,
          quantity: _positiveQuantity(
            resolution?.quantity,
            fallback: line.quantity,
          ),
        );
        break;
      case StartingEquipmentLineKind.itemCategory:
        final lineEntryId = line.entryId;
        if (lineEntryId == null) continue;
        final resolution = resolutionsByLineEntryId[lineEntryId];
        final referenceKey = _normalizedTextOrNull(resolution?.referenceKey);
        if (referenceKey == null) {
          continue;
        }
        final expectedType = line.catalogType ?? EquipmentCatalogType.item;
        if (resolution?.catalogType != expectedType) {
          continue;
        }

        if (expectedType == EquipmentCatalogType.armor) {
          final armorItem = armor
              .where((item) =>
                  _normalizedTextOrNull(item.referenceKey) == referenceKey)
              .firstOrNull;
          if (armorItem == null) continue;
          final allowed = {
            for (final value in line.allowedItemCategories ?? const <String>[])
              if (_normalizedTextOrNull(value) != null)
                _normalizedTextOrNull(value)!,
          };
          if (allowed.isNotEmpty &&
              !allowed.contains(armorItem.categoryValue?.name)) {
            continue;
          }
          _accumulateGrantedEquipment(
            accumulated,
            catalogType: EquipmentCatalogType.armor,
            referenceKey: referenceKey,
            displayText: _normalizedTextOrNull(armorItem.name) ?? referenceKey,
            quantity: _positiveQuantity(
              resolution?.quantity,
              fallback: line.quantity,
            ),
          );
          continue;
        }

        if (expectedType != EquipmentCatalogType.item) {
          continue;
        }
        final item = items
            .where((item) =>
                _normalizedTextOrNull(item.referenceKey) == referenceKey)
            .firstOrNull;
        if (item == null) continue;
        final category = _normalizedTextOrNull(item.category);
        final allowed = {
          for (final value in line.allowedItemCategories ?? const <String>[])
            if (_normalizedTextOrNull(value) != null)
              _normalizedTextOrNull(value)!,
        };
        if (allowed.isNotEmpty &&
            (category == null || !allowed.contains(category))) {
          continue;
        }
        _accumulateGrantedEquipment(
          accumulated,
          catalogType: EquipmentCatalogType.item,
          referenceKey: referenceKey,
          displayText: _normalizedTextOrNull(item.name) ?? referenceKey,
          quantity: _positiveQuantity(
            resolution?.quantity,
            fallback: line.quantity,
          ),
        );
        break;
      case null:
        break;
    }
  }
}

void _accumulateGrantedEquipment(
  Map<String, _GrantedEquipmentAccumulator> accumulated, {
  required EquipmentCatalogType catalogType,
  required String referenceKey,
  required String displayText,
  required int quantity,
}) {
  final key = '${catalogType.name}:$referenceKey';
  final existing = accumulated[key];
  if (existing == null) {
    accumulated[key] = _GrantedEquipmentAccumulator(
      catalogType: catalogType,
      referenceKey: referenceKey,
      displayText: displayText,
      quantity: quantity,
    );
    return;
  }

  existing.quantity += quantity;
  if (existing.displayText.trim().isEmpty) {
    existing.displayText = displayText;
  }
}

String _catalogRefDisplayText(
  EquipmentCatalogType catalogType,
  String referenceKey,
  List<WeaponData> weapons,
  List<ItemData> items,
  List<ArmorData> armor,
) {
  switch (catalogType) {
    case EquipmentCatalogType.weapon:
      final weapon = weapons
          .where(
            (item) => _normalizedTextOrNull(item.referenceKey) == referenceKey,
          )
          .firstOrNull;
      return _normalizedTextOrNull(weapon?.name) ?? referenceKey;
    case EquipmentCatalogType.armor:
      final armorItem = armor
          .where(
            (item) => _normalizedTextOrNull(item.referenceKey) == referenceKey,
          )
          .firstOrNull;
      return _normalizedTextOrNull(armorItem?.name) ?? referenceKey;
    case EquipmentCatalogType.item:
    case EquipmentCatalogType.magicItem:
      final item = items
          .where(
            (item) => _normalizedTextOrNull(item.referenceKey) == referenceKey,
          )
          .firstOrNull;
      return _normalizedTextOrNull(item?.name) ?? referenceKey;
  }
}

int _positiveQuantity(int? value, {int? fallback}) {
  final candidate = value ?? fallback ?? 1;
  return candidate > 0 ? candidate : 1;
}

String? _normalizedTextOrNull(String? value) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}

class _GrantedEquipmentAccumulator {
  _GrantedEquipmentAccumulator({
    required this.catalogType,
    required this.referenceKey,
    required this.displayText,
    required this.quantity,
  });

  final EquipmentCatalogType catalogType;
  final String referenceKey;
  String displayText;
  int quantity;
}

class _StartingEquipmentSourceBlock {
  const _StartingEquipmentSourceBlock({
    required this.sourceType,
    required this.sourceId,
    required this.blockView,
  });

  final ChoiceSourceType sourceType;
  final int sourceId;
  final StartingEquipmentBlockView blockView;
}

const offlineClassStepKind = 'class_step';

String offlineClassStepKey(
  int classId, {
  int selectedLevel = 1,
  int? selectedSubclassId,
  Map<String, int>? abilityScores,
}) {
  final abilityScoreKey = abilityScores == null || abilityScores.isEmpty
      ? 'none'
      : (abilityScores.entries.toList()
            ..sort((left, right) => left.key.compareTo(right.key)))
          .map((entry) => '${entry.key}=${entry.value}')
          .join(',');
  return [
    classId,
    selectedLevel,
    true,
    selectedSubclassId ?? 0,
    abilityScoreKey,
  ].join(':');
}
