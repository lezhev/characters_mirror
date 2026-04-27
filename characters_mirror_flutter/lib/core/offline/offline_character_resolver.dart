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
  final activeFeatures = await _activeFeatures(cache, character, totalLevel);
  final hitDice = _hitDiceSummary(entries);
  final maxHp =
      _maxHp(entries, abilityModifiers[Ability.constitution.name] ?? 0);
  final dexterityModifier = abilityModifiers[Ability.dexterity.name] ?? 0;
  final grantedEquipment = await _collectGrantedEquipment(cache, character);
  final grantedSpellKeys = _collectGrantedSpellKeys(character);

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

List<String> _collectGrantedSpellKeys(CharacterData character) {
  return _uniqueStrings([
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
  final blocks = await cache.getReferenceList(
        'starting_equipment_block',
        offlineAllKey,
        StartingEquipmentBlockData.fromJson,
      ) ??
      const <StartingEquipmentBlockData>[];
  if (blocks.isEmpty) {
    return character.derived?.grantedEquipment ??
        const <CharacterEquipmentEntryView>[];
  }

  final options = await cache.getReferenceList(
        'starting_equipment_option',
        offlineAllKey,
        StartingEquipmentOptionData.fromJson,
      ) ??
      const <StartingEquipmentOptionData>[];
  final lines = await cache.getReferenceList(
        'starting_equipment_line',
        offlineAllKey,
        StartingEquipmentLineData.fromJson,
      ) ??
      const <StartingEquipmentLineData>[];
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

  final startingClassId = _startingClassEntry(
    character.classEntries ?? const <CharacterClassEntryData>[],
  )?.classData?.id;
  final backgroundId = character.background?.id;
  final relevantBlocks = [
    for (final block in blocks)
      if ((startingClassId != null && block.sourceClassId == startingClassId) ||
          (backgroundId != null && block.sourceBackgroundId == backgroundId))
        block,
  ]..sort((a, b) => (a.orderIndex ?? 0).compareTo(b.orderIndex ?? 0));
  if (relevantBlocks.isEmpty) {
    return const <CharacterEquipmentEntryView>[];
  }

  final blockById = {
    for (final block in relevantBlocks)
      if (block.id != null) block.id!: block,
  };
  final optionsByBlockId = <int, List<StartingEquipmentOptionData>>{};
  for (final option in options) {
    if (!blockById.containsKey(option.blockId)) continue;
    optionsByBlockId.putIfAbsent(
      option.blockId,
      () => <StartingEquipmentOptionData>[],
    );
    optionsByBlockId[option.blockId]!.add(option);
  }
  for (final value in optionsByBlockId.values) {
    value.sort((a, b) => (a.orderIndex ?? 0).compareTo(b.orderIndex ?? 0));
  }

  final fixedLinesByBlockId = <int, List<StartingEquipmentLineData>>{};
  final linesByOptionId = <int, List<StartingEquipmentLineData>>{};
  for (final line in lines) {
    final blockId = line.blockId;
    if (blockId != null && blockById.containsKey(blockId)) {
      fixedLinesByBlockId.putIfAbsent(
        blockId,
        () => <StartingEquipmentLineData>[],
      );
      fixedLinesByBlockId[blockId]!.add(line);
    }
    final optionId = line.optionId;
    if (optionId != null) {
      linesByOptionId.putIfAbsent(
        optionId,
        () => <StartingEquipmentLineData>[],
      );
      linesByOptionId[optionId]!.add(line);
    }
  }

  final selections = character.startingEquipmentSelections ??
      const <CharacterStartingEquipmentSelectionData>[];
  final accumulated = <String, _GrantedEquipmentAccumulator>{};
  for (final block in relevantBlocks) {
    if (block.id == null) continue;
    final sourceSelections = _matchingStartingEquipmentSelections(
      selections,
      block,
    );
    final blockLines =
        fixedLinesByBlockId[block.id!] ?? const <StartingEquipmentLineData>[];
    if (block.kind == StartingEquipmentBlockKind.choice) {
      _applyStartingEquipmentLines(
        blockLines,
        _collectBlockLevelResolutions(sourceSelections),
        weapons,
        items,
        accumulated,
      );
      for (final selection in sourceSelections) {
        final optionKey = _normalizedTextOrNull(selection.optionKey);
        if (optionKey == null) continue;
        final option = (optionsByBlockId[block.id!] ??
                const <StartingEquipmentOptionData>[])
            .where((item) => _normalizedTextOrNull(item.optionKey) == optionKey)
            .firstOrNull;
        if (option?.id == null) continue;
        _applyStartingEquipmentLines(
          linesByOptionId[option!.id!] ?? const <StartingEquipmentLineData>[],
          selection.resolutions ??
              const <CharacterStartingEquipmentResolutionData>[],
          weapons,
          items,
          accumulated,
        );
      }
      continue;
    }

    _applyStartingEquipmentLines(
      blockLines,
      _collectBlockLevelResolutions(sourceSelections),
      weapons,
      items,
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
  ]) {
    final skill = _skillFromName(name);
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
) async {
  final result = <CharacterFeatureViewData>[];
  void addFeature({
    required CharacterFeatureSourceType sourceType,
    required int? sourceId,
    required String? sourceName,
    required int? level,
    required String? name,
    required String? description,
    required List<FeatureTag>? tags,
  }) {
    if (sourceId == null || (level ?? 1) > totalLevel) return;
    final override =
        (character.featureOverrides ?? const <CharacterFeatureOverrideData>[])
            .where(
              (item) =>
                  item.sourceType == sourceType && item.sourceId == sourceId,
            )
            .firstOrNull;
    result.add(
      CharacterFeatureViewData(
        sourceType: sourceType,
        sourceId: sourceId,
        sourceName: sourceName,
        level: level,
        defaultName: name,
        defaultDescription: description,
        defaultTags: tags,
        name: override?.name ?? name,
        description: override?.description ?? description,
        tags: override?.tags ?? tags,
        isCustomized: override != null,
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
      description: feature.description,
      tags: feature.tags,
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
      description: feature.description,
      tags: feature.tags,
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
        description: feature.description,
        tags: feature.tags,
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
        description: feature.description,
        tags: feature.tags,
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

Map<String, int> _hitDiceSummary(List<CharacterClassEntryData> entries) {
  final result = <String, int>{};
  for (final entry in entries) {
    final hitDie = entry.classData?.hitDieValue;
    if (hitDie == null) continue;
    final key = 'd$hitDie';
    result[key] = (result[key] ?? 0) + (entry.level ?? 1);
  }
  return result;
}

int _maxHp(List<CharacterClassEntryData> entries, int constitutionModifier) {
  var total = 0;
  for (final entry in entries) {
    final level = max(1, entry.level ?? 1);
    final hitDie = entry.classData?.hitDieValue ?? 8;
    total += hitDie + constitutionModifier;
    if (level > 1) {
      total += (level - 1) * ((hitDie ~/ 2) + 1 + constitutionModifier);
    }
  }
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

List<CharacterStartingEquipmentSelectionData>
    _matchingStartingEquipmentSelections(
  List<CharacterStartingEquipmentSelectionData> selections,
  StartingEquipmentBlockData block,
) {
  final blockKey = _normalizedTextOrNull(block.blockKey);
  final sourceType = _startingEquipmentSourceTypeForBlock(block);
  final sourceId = _startingEquipmentSourceIdForBlock(block);
  if (blockKey == null || sourceType == null || sourceId == null) {
    return const <CharacterStartingEquipmentSelectionData>[];
  }

  return [
    for (final selection in selections)
      if (selection.sourceType == sourceType &&
          selection.sourceId == sourceId &&
          _normalizedTextOrNull(selection.blockKey) == blockKey)
        selection,
  ]..sort((a, b) => (a.selectionIndex ?? 0).compareTo(b.selectionIndex ?? 0));
}

List<CharacterStartingEquipmentResolutionData> _collectBlockLevelResolutions(
  List<CharacterStartingEquipmentSelectionData> selections,
) {
  final resolutions = <CharacterStartingEquipmentResolutionData>[];
  for (final selection in selections) {
    if (_normalizedTextOrNull(selection.optionKey) != null) continue;
    resolutions.addAll(
      selection.resolutions ??
          const <CharacterStartingEquipmentResolutionData>[],
    );
  }
  return resolutions
    ..sort((a, b) => (_normalizedTextOrNull(a.lineKey) ?? '')
        .compareTo(_normalizedTextOrNull(b.lineKey) ?? ''));
}

void _applyStartingEquipmentLines(
  List<StartingEquipmentLineData> lines,
  List<CharacterStartingEquipmentResolutionData> resolutions,
  List<WeaponData> weapons,
  List<ItemData> items,
  Map<String, _GrantedEquipmentAccumulator> accumulated,
) {
  final resolutionsByLineKey = {
    for (final resolution in resolutions)
      if (_normalizedTextOrNull(resolution.lineKey) != null)
        _normalizedTextOrNull(resolution.lineKey)!: resolution,
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
          displayText: _normalizedTextOrNull(line.displayText) ?? referenceKey,
          quantity: _positiveQuantity(line.quantity),
        );
        break;
      case StartingEquipmentLineKind.weaponCategory:
        final lineKey = _normalizedTextOrNull(line.lineKey);
        if (lineKey == null) continue;
        final resolution = resolutionsByLineKey[lineKey];
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
        final lineKey = _normalizedTextOrNull(line.lineKey);
        if (lineKey == null) continue;
        final resolution = resolutionsByLineKey[lineKey];
        final referenceKey = _normalizedTextOrNull(resolution?.referenceKey);
        if (resolution?.catalogType != EquipmentCatalogType.item ||
            referenceKey == null) {
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

ChoiceSourceType? _startingEquipmentSourceTypeForBlock(
  StartingEquipmentBlockData block,
) {
  if (block.sourceClassId != null) return ChoiceSourceType.classData;
  if (block.sourceBackgroundId != null) return ChoiceSourceType.background;
  return null;
}

int? _startingEquipmentSourceIdForBlock(StartingEquipmentBlockData block) {
  return block.sourceClassId ?? block.sourceBackgroundId;
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

const offlineClassStepKind = 'class_step';

String offlineClassStepKey(
  int classId, {
  int selectedLevel = 1,
  int? selectedSubclassId,
}) {
  return [
    classId,
    selectedLevel,
    true,
    selectedSubclassId ?? 0,
  ].join(':');
}
