import 'dart:math';

import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class CharacterDataEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<CharacterData>> getAll(Session session) async {
    final userId = await _requireCurrentUserId(session);
    final records = await CharacterRecord.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.updatedAt,
      orderDescending: true,
      include: _characterRecordInclude(),
    );

    return Future.wait(
      records.map((record) => _buildCharacterAggregate(session, record)),
    );
  }

  Future<CharacterData> saveCharacter(
    Session session,
    CharacterData character,
  ) async {
    final userId = await _requireCurrentUserId(session);
    final normalizedCharacter = character.copyWith(
      featureOverrides: await _pruneFeatureOverrides(session, character),
    );
    final savedRecord =
        await _upsertCharacterRecord(session, normalizedCharacter, userId);

    await CharacterChoiceRecord.db.deleteWhere(
      session,
      where: (t) => t.characterId.equals(savedRecord.id),
    );
    await CharacterClassEntryRecord.db.deleteWhere(
      session,
      where: (t) => t.characterId.equals(savedRecord.id),
    );

    final savedEntries = await _insertClassEntryRecords(
      session,
      savedRecord,
      normalizedCharacter.classEntries ?? const <CharacterClassEntryData>[],
    );
    await _insertChoiceRecords(
      session,
      savedRecord,
      savedEntries,
      normalizedCharacter.choices ?? const <CharacterChoiceData>[],
    );

    final hydratedRecord = await _requireOwnedCharacterRecord(
      session,
      savedRecord.id!,
      userId: userId,
    );
    return _buildCharacterAggregate(session, hydratedRecord);
  }

  Future<CharacterData> getCharacter(Session session, int id) async {
    final record = await _requireOwnedCharacterRecord(session, id);
    return _buildCharacterAggregate(session, record);
  }

  Future<void> delete(Session session, int id) async {
    await _requireOwnedCharacterRecord(session, id);
    await CharacterChoiceRecord.db.deleteWhere(
      session,
      where: (t) => t.characterId.equals(id),
    );
    await CharacterClassEntryRecord.db.deleteWhere(
      session,
      where: (t) => t.characterId.equals(id),
    );
    await CharacterRecord.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
  }
}

Future<List<CharacterFeatureOverrideData>> _pruneFeatureOverrides(
  Session session,
  CharacterData character,
) async {
  final normalizedOverrides = _normalizedFeatureOverrides(
    character.featureOverrides,
  );
  if (normalizedOverrides.isEmpty) {
    return const <CharacterFeatureOverrideData>[];
  }

  final entries = character.classEntries ?? const <CharacterClassEntryData>[];
  final choices = character.choices ?? const <CharacterChoiceData>[];
  final totalLevel =
      entries.fold<int>(0, (sum, entry) => sum + (entry.level ?? 0));
  final resolvedSources =
      await _resolveDerivedSources(session, character, choices);
  final currentRaceFeatures =
      _currentRaceFeaturesBySource(character, totalLevel);
  final defaultFeatures = _buildActiveFeatures(
    character: character.copyWith(
      featureOverrides: const <CharacterFeatureOverrideData>[],
    ),
    resolvedSources: resolvedSources,
    currentRaceFeatures: currentRaceFeatures,
  );
  final defaultByKey = {
    for (final feature in defaultFeatures)
      _featureOverrideKey(feature.sourceType, feature.sourceId): feature,
  };

  return [
    for (final override in normalizedOverrides)
      if (_isMeaningfulFeatureOverride(
        override,
        defaultByKey[
            _featureOverrideKey(override.sourceType, override.sourceId)],
      ))
        override,
  ];
}

Future<CharacterRecord> _upsertCharacterRecord(
  Session session,
  CharacterData character,
  int userId,
) async {
  final now = DateTime.now();

  if (character.id == null) {
    return CharacterRecord.db.insertRow(
      session,
      _toCharacterRecord(
        character,
        userId: userId,
        version: character.version ?? 1,
        createdAt: character.createdAt ?? now,
        updatedAt: now,
      ),
    );
  }

  final ownedRecord = await _findOwnedCharacterRecord(
    session,
    character.id!,
    userId,
  );
  if (ownedRecord != null) {
    final updatedRecord = _toCharacterRecord(
      character,
      id: ownedRecord.id,
      userId: ownedRecord.userId ?? userId,
      version: (ownedRecord.version ?? 0) + 1,
      createdAt: ownedRecord.createdAt ?? now,
      updatedAt: now,
    );
    await CharacterRecord.db.updateRow(session, updatedRecord);
    return updatedRecord;
  }

  final existingById = await CharacterRecord.db.find(
    session,
    where: (t) => t.id.equals(character.id),
    limit: 1,
  );
  if (existingById.isNotEmpty) {
    throw Exception('Access denied to character id=${character.id}.');
  }

  return CharacterRecord.db.insertRow(
    session,
    _toCharacterRecord(
      character,
      userId: userId,
      version: character.version ?? 1,
      createdAt: character.createdAt ?? now,
      updatedAt: now,
    ),
  );
}

CharacterRecord _toCharacterRecord(
  CharacterData character, {
  int? id,
  required int userId,
  required int version,
  required DateTime createdAt,
  required DateTime updatedAt,
}) {
  return CharacterRecord(
    id: id,
    name: character.name,
    age: character.age,
    height: character.height,
    weight: character.weight,
    eyes: character.eyes,
    skin: character.skin,
    hair: character.hair,
    appearance: character.appearance,
    backstory: character.backstory,
    goals: character.goals,
    alliesOrganizations: character.alliesOrganizations,
    personalityTraits: character.personalityTraits,
    ideals: character.ideals,
    bonds: character.bonds,
    flaws: character.flaws,
    version: version,
    createdAt: createdAt,
    updatedAt: updatedAt,
    userId: userId,
    experience: character.experience,
    alignmentValue: character.alignmentValue,
    raceId: character.race?.id,
    subraceId: character.subrace?.id,
    backgroundId: character.background?.id,
    baseAbilityScores: character.baseAbilityScores,
    useFlexibleAbilityBonuses: character.useFlexibleAbilityBonuses,
    temporaryHp: character.temporaryHp,
    currentHp: character.currentHp,
    inspiration: character.inspiration,
    notes: character.notes,
    attacks: character.attacks,
    featureOverrides: _normalizedFeatureOverrides(character.featureOverrides),
  );
}

Future<List<CharacterClassEntryRecord>> _insertClassEntryRecords(
  Session session,
  CharacterRecord characterRecord,
  List<CharacterClassEntryData> entries,
) async {
  final savedEntries = <CharacterClassEntryRecord>[];
  for (final entry in entries) {
    final classDataId = entry.classData?.id;
    if (classDataId == null) {
      throw Exception('Character class entry requires classData.id.');
    }
    final saved = await CharacterClassEntryRecord.db.insertRow(
      session,
      CharacterClassEntryRecord(
        characterId: characterRecord.id!,
        character: characterRecord,
        classDataId: classDataId,
        subclassId: entry.subclass?.id,
        level: entry.level ?? 1,
        isStartingClass: entry.isStartingClass,
        classOrder: entry.classOrder,
        hpMode: entry.hpMode,
        hpRolledValues: entry.hpRolledValues,
        notes: entry.notes,
      ),
    );
    savedEntries.add(saved);
  }
  return savedEntries;
}

Future<List<CharacterChoiceRecord>> _insertChoiceRecords(
  Session session,
  CharacterRecord characterRecord,
  List<CharacterClassEntryRecord> savedEntries,
  List<CharacterChoiceData> choices,
) async {
  final savedChoices = <CharacterChoiceRecord>[];
  for (final choice in choices) {
    final matchedEntry =
        _matchSavedEntryRecord(choice.classEntry, savedEntries);
    final saved = await CharacterChoiceRecord.db.insertRow(
      session,
      CharacterChoiceRecord(
        characterId: characterRecord.id!,
        character: characterRecord,
        classEntryId: matchedEntry?.id,
        classEntry: matchedEntry,
        sourceType: choice.sourceType,
        sourceId: choice.sourceId,
        groupKey: choice.groupKey,
        optionKey: choice.optionKey,
        selectionIndex: choice.selectionIndex,
        selectedAbility: choice.selectedAbility,
        selectedLanguage: choice.selectedLanguage,
        selectedToolKey: choice.selectedToolKey,
        selectedSpellKey: choice.selectedSpellKey,
        selectedItemKey: choice.selectedItemKey,
        selectedFeatId: choice.selectedFeatId,
        selectedText: choice.selectedText,
        selectedCount: choice.selectedCount,
      ),
    );
    savedChoices.add(saved);
  }
  return savedChoices;
}

CharacterClassEntryRecord? _matchSavedEntryRecord(
  CharacterClassEntryData? draftEntry,
  List<CharacterClassEntryRecord> savedEntries,
) {
  if (draftEntry == null) return null;
  if (draftEntry.id != null) {
    for (final saved in savedEntries) {
      if (saved.id == draftEntry.id) {
        return saved;
      }
    }
  }
  for (final saved in savedEntries) {
    final sameClass = saved.classDataId == draftEntry.classData?.id;
    final sameOrder = saved.classOrder == draftEntry.classOrder;
    if (sameClass && sameOrder) {
      return saved;
    }
  }
  return null;
}

Future<int> _requireCurrentUserId(Session session) async {
  final userId = (await session.authenticated)?.userId;
  if (userId == null) {
    throw Exception('Authentication required.');
  }
  return userId;
}

Future<CharacterRecord?> _findOwnedCharacterRecord(
  Session session,
  int characterId,
  int userId,
) async {
  final rows = await CharacterRecord.db.find(
    session,
    where: (t) => t.id.equals(characterId) & t.userId.equals(userId),
    limit: 1,
    include: _characterRecordInclude(),
  );
  if (rows.isEmpty) {
    return null;
  }
  return rows.first;
}

Future<CharacterRecord> _requireOwnedCharacterRecord(
  Session session,
  int characterId, {
  int? userId,
}) async {
  final resolvedUserId = userId ?? await _requireCurrentUserId(session);
  final record = await _findOwnedCharacterRecord(
    session,
    characterId,
    resolvedUserId,
  );
  if (record != null) {
    return record;
  }

  final existing = await CharacterRecord.db.find(
    session,
    where: (t) => t.id.equals(characterId),
    limit: 1,
  );
  if (existing.isNotEmpty) {
    throw Exception('Access denied to character id=$characterId.');
  }

  throw Exception('CharacterData with id=$characterId was not found.');
}

Future<CharacterData> _buildCharacterAggregate(
  Session session,
  CharacterRecord record,
) async {
  final entryRecords = await CharacterClassEntryRecord.db.find(
    session,
    where: (t) => t.characterId.equals(record.id),
    orderBy: (t) => t.classOrder,
    include: CharacterClassEntryRecord.include(
      classData: ClassData.include(),
      subclass: SubclassData.include(),
    ),
  );
  final entries = entryRecords.map(_toCharacterClassEntryData).toList();
  final entriesById = {
    for (final entry in entries)
      if (entry.id != null) entry.id!: entry,
  };
  final choiceRecords = await CharacterChoiceRecord.db.find(
    session,
    where: (t) => t.characterId.equals(record.id),
  );
  final choices = choiceRecords
      .map((record) => _toCharacterChoiceData(record, entriesById))
      .toList()
    ..sort(_compareCharacterChoices);

  final character = _toCharacterData(record).copyWith(
    classEntries: entries,
    choices: choices,
  );
  final derived = await _buildDerivedData(session, character);
  return character.copyWith(derived: derived);
}

CharacterData _toCharacterData(CharacterRecord record) {
  return CharacterData(
    id: record.id,
    name: record.name,
    age: record.age,
    height: record.height,
    weight: record.weight,
    eyes: record.eyes,
    skin: record.skin,
    hair: record.hair,
    appearance: record.appearance,
    backstory: record.backstory,
    goals: record.goals,
    alliesOrganizations: record.alliesOrganizations,
    personalityTraits: record.personalityTraits,
    ideals: record.ideals,
    bonds: record.bonds,
    flaws: record.flaws,
    version: record.version,
    createdAt: record.createdAt,
    updatedAt: record.updatedAt,
    experience: record.experience,
    alignmentValue: record.alignmentValue,
    race: record.race,
    subrace: record.subrace,
    background: record.background,
    baseAbilityScores: record.baseAbilityScores,
    useFlexibleAbilityBonuses: record.useFlexibleAbilityBonuses,
    temporaryHp: record.temporaryHp,
    currentHp: record.currentHp,
    inspiration: record.inspiration,
    notes: record.notes,
    attacks: record.attacks,
    featureOverrides: record.featureOverrides,
  );
}

CharacterClassEntryData _toCharacterClassEntryData(
  CharacterClassEntryRecord record,
) {
  return CharacterClassEntryData(
    id: record.id,
    classData: record.classData,
    subclass: record.subclass,
    level: record.level,
    isStartingClass: record.isStartingClass,
    classOrder: record.classOrder,
    hpMode: record.hpMode,
    hpRolledValues: record.hpRolledValues,
    notes: record.notes,
  );
}

CharacterChoiceData _toCharacterChoiceData(
  CharacterChoiceRecord record,
  Map<int, CharacterClassEntryData> entriesById,
) {
  return CharacterChoiceData(
    id: record.id,
    classEntry:
        record.classEntryId == null ? null : entriesById[record.classEntryId!],
    sourceType: record.sourceType,
    sourceId: record.sourceId,
    groupKey: record.groupKey,
    optionKey: record.optionKey,
    selectionIndex: record.selectionIndex,
    selectedAbility: record.selectedAbility,
    selectedLanguage: record.selectedLanguage,
    selectedToolKey: record.selectedToolKey,
    selectedSpellKey: record.selectedSpellKey,
    selectedItemKey: record.selectedItemKey,
    selectedFeatId: record.selectedFeatId,
    selectedText: record.selectedText,
    selectedCount: record.selectedCount,
  );
}

Future<CharacterDerivedData> _buildDerivedData(
  Session session,
  CharacterData character,
) async {
  final entries = character.classEntries ?? const <CharacterClassEntryData>[];
  final choices = character.choices ?? const <CharacterChoiceData>[];
  final totalLevel =
      entries.fold<int>(0, (sum, entry) => sum + (entry.level ?? 0));
  final proficiencyBonus = totalLevel <= 0 ? 2 : 2 + ((totalLevel - 1) ~/ 4);
  final resolvedSources =
      await _resolveDerivedSources(session, character, choices);
  final currentRaceFeatures =
      _currentRaceFeaturesBySource(character, totalLevel);
  final scores = _buildAbilityScores(character, choices);
  final abilityModifiers = {
    for (final ability in Ability.values)
      ability.name: _abilityModifier(scores[ability.name] ?? 10),
  };
  final dexMod = _abilityModifier(scores['dexterity'] ?? 10);
  final conMod = _abilityModifier(scores['constitution'] ?? 10);

  final startingEntry = _resolveStartingEntry(entries);
  final savingThrowAbilities = {
    for (final ability in startingEntry?.classData?.savingThrowProficiencies ??
        const <Ability>[])
      ability.name,
  };

  final skillProficiencies = _collectSkillProficiencies(
    character,
    choices,
    resolvedSources.classBackgroundOptions,
    resolvedSources.raceOptions,
  );
  final skillBonuses = <String, int>{};
  for (final skill in Skill.values) {
    final base = _abilityModifier(scores[_abilityForSkill(skill).name] ?? 10);
    final proficient = skillProficiencies.contains(skill);
    skillBonuses[skill.name] = base + (proficient ? proficiencyBonus : 0);
  }

  final savingThrowBonuses = <String, int>{};
  for (final ability in Ability.values) {
    final base = _abilityModifier(scores[ability.name] ?? 10);
    final proficient = savingThrowAbilities.contains(ability.name);
    savingThrowBonuses[ability.name] =
        base + (proficient ? proficiencyBonus : 0);
  }

  final maxHp = _calculateMaxHp(entries, conMod);
  final passivePerception = 10 + (skillBonuses[Skill.perception.name] ?? 0);
  final passiveInvestigation =
      10 + (skillBonuses[Skill.investigation.name] ?? 0);
  final passiveInsight = 10 + (skillBonuses[Skill.insight.name] ?? 0);
  final spellData = await _resolveSpellSlots(session, entries);
  final languages = _collectLanguages(
    character,
    choices,
    resolvedSources.classBackgroundOptions,
    resolvedSources.raceOptions,
  );
  final toolProficiencies = _collectToolProficiencies(
    character,
    entries,
    choices,
    resolvedSources.classBackgroundOptions,
    resolvedSources.raceOptions,
  );
  final armorTraining = _collectArmorTraining(
    character,
    entries,
    resolvedSources.classBackgroundOptions,
  );
  final weaponTraining = _collectWeaponTraining(
    character,
    entries,
    resolvedSources.classBackgroundOptions,
  );
  final featIds = _collectFeatIds(choices, resolvedSources.raceOptions);
  final featTags = await _loadFeatTags(session, featIds);
  final featureTags = _collectFeatureTags(
    character: character,
    resolvedSources: resolvedSources,
    currentRaceFeatures: currentRaceFeatures,
    featTags: featTags,
  );
  final activeFeatures = _buildActiveFeatures(
    character: character,
    resolvedSources: resolvedSources,
    currentRaceFeatures: currentRaceFeatures,
  );
  final grantedSpellKeys = _collectGrantedSpellKeys(
    choices,
    resolvedSources.classBackgroundOptions,
    resolvedSources.raceOptions,
    currentRaceFeatures,
  );
  final grantedItemKeys = _collectGrantedItemKeys(
    choices,
    resolvedSources.classBackgroundOptions,
  );
  final hitDiceSummary = <String, int>{};
  for (final entry in entries) {
    final hitDie = _resolveHitDie(entry.classData);
    final level = entry.level ?? 0;
    if (hitDie != null && level > 0) {
      final key = 'd$hitDie';
      hitDiceSummary[key] = (hitDiceSummary[key] ?? 0) + level;
    }
  }

  final senses = <String>[
    if (character.race?.visionType != null) character.race!.visionType!.name,
  ];
  final resistances = _collectDamageTypes(character, choices);

  return CharacterDerivedData(
    totalLevel: totalLevel,
    proficiencyBonus: proficiencyBonus,
    abilityScores: scores,
    abilityModifiers: abilityModifiers,
    activeFeatures: activeFeatures,
    armorClass: 10 + dexMod,
    initiative: dexMod,
    speed: character.race?.speed ?? 30,
    maxHp: maxHp,
    passivePerception: passivePerception,
    passiveInvestigation: passiveInvestigation,
    passiveInsight: passiveInsight,
    savingThrowBonuses: savingThrowBonuses,
    skillBonuses: skillBonuses,
    spellSlots: spellData.spellSlots,
    pactSlots: spellData.pactSlots,
    hitDiceSummary: hitDiceSummary,
    languages: languages,
    toolProficiencies: toolProficiencies,
    armorTraining: armorTraining,
    weaponTraining: weaponTraining,
    featureTags: featureTags,
    featIds: featIds,
    grantedSpellKeys: grantedSpellKeys,
    grantedItemKeys: grantedItemKeys,
    senses: senses,
    resistances: resistances,
    rebuiltAt: DateTime.now(),
  );
}

Map<String, int> _buildAbilityScores(
  CharacterData character,
  List<CharacterChoiceData> choices,
) {
  final scores = <String, int>{
    for (final ability in Ability.values) ability.name: 10,
    ...?character.baseAbilityScores,
  };

  final raceChoices = _racialChoicesForSource(
    choices,
    ChoiceSourceType.race,
    character.race?.id,
  );
  final subraceChoices = _racialChoicesForSource(
    choices,
    ChoiceSourceType.subrace,
    character.subrace?.id,
  );
  final activeBonusMode = _resolveActiveBonusMode(raceChoices);
  final activeRaceChoices = _filterChoicesForActiveBonusMode(
    raceChoices,
    activeBonusMode,
  );
  final activeSubraceChoices = _filterChoicesForActiveBonusMode(
    subraceChoices,
    activeBonusMode,
  );
  final usesFlexibleBonuses =
      activeBonusMode == _BonusMode.flexiblePlusTwoOne ||
          activeBonusMode == _BonusMode.flexibleThreePlusOne;

  if (activeRaceChoices.isEmpty) {
    _applyFixedRaceBonuses(
      scores,
      _abilityBonusesFromRace(character.race),
    );
  } else {
    _applyRacialChoiceBonuses(scores, activeRaceChoices);
  }

  if (usesFlexibleBonuses) {
    // Flexible +2/+1 replaces both the race and subrace default bonuses.
  } else if (activeSubraceChoices.isEmpty) {
    _applyFixedRaceBonuses(
      scores,
      _abilityBonusesFromSubrace(character.subrace),
    );
  } else {
    _applyRacialChoiceBonuses(scores, activeSubraceChoices);
  }

  return scores;
}

enum _BonusMode { racial, flexiblePlusTwoOne, flexibleThreePlusOne }

_BonusMode _resolveActiveBonusMode(List<CharacterChoiceData> raceChoices) {
  for (final choice in raceChoices) {
    if (choice.groupKey != 'race_bonus_mode') continue;

    switch (choice.selectedText) {
      case 'flexiblePlusTwoOne':
        return _BonusMode.flexiblePlusTwoOne;
      case 'flexibleThreePlusOne':
        return _BonusMode.flexibleThreePlusOne;
      case 'racial':
      default:
        return _BonusMode.racial;
    }
  }

  return _BonusMode.racial;
}

List<CharacterChoiceData> _filterChoicesForActiveBonusMode(
  List<CharacterChoiceData> choices,
  _BonusMode activeMode,
) {
  return choices.where((choice) {
    final groupKey = choice.groupKey;
    if (groupKey == null || groupKey == 'race_bonus_mode') {
      return false;
    }

    final isFlexible = groupKey.startsWith('race_flexible_bonus');
    switch (activeMode) {
      case _BonusMode.racial:
        return !isFlexible;
      case _BonusMode.flexiblePlusTwoOne:
        return groupKey == 'race_flexible_bonus_plus2' ||
            groupKey == 'race_flexible_bonus_plus1';
      case _BonusMode.flexibleThreePlusOne:
        return groupKey == 'race_flexible_bonus_three_plus1';
    }
  }).toList();
}

List<CharacterChoiceData> _racialChoicesForSource(
  List<CharacterChoiceData> choices,
  ChoiceSourceType sourceType,
  int? sourceId,
) {
  if (sourceId == null) {
    return const [];
  }

  return choices.where((choice) {
    return choice.sourceType == sourceType && choice.sourceId == sourceId;
  }).toList();
}

void _applyRacialChoiceBonuses(
  Map<String, int> scores,
  List<CharacterChoiceData> choices,
) {
  for (final choice in choices) {
    final bonus = choice.selectedCount ?? 0;
    final key = choice.selectedAbility?.name ?? choice.optionKey?.trim();
    if (key == null || key.isEmpty || bonus == 0) {
      continue;
    }

    final abilityKey = _normalizeAbilityKey(key);
    if (abilityKey == null) continue;

    scores[abilityKey] = (scores[abilityKey] ?? 10) + bonus;
  }
}

String? _normalizeAbilityKey(String raw) {
  for (final ability in Ability.values) {
    if (ability.name == raw) {
      return ability.name;
    }
  }
  return null;
}

Set<Skill> _collectSkillProficiencies(
  CharacterData character,
  List<CharacterChoiceData> choices,
  List<ClassChoiceOptionData> classBackgroundOptions,
  List<RaceChoiceOptionData> raceOptions,
) {
  final skills = <Skill>{};
  _addSkillNames(skills, character.race?.skillProficiencies);
  _addSkillNames(skills, character.subrace?.skillProficiencies);
  _addSkillNames(skills, character.background?.skillProficiencies);

  for (final option in classBackgroundOptions) {
    skills.addAll(option.grantedSkills ?? const <Skill>[]);
  }

  for (final option in raceOptions) {
    if (option.skill != null) {
      skills.add(option.skill!);
    }
  }

  for (final choice in choices) {
    final skill = _skillFromName(choice.selectedText ?? '');
    if (skill != null) {
      skills.add(skill);
    }
  }

  return skills;
}

CharacterClassEntryData? _resolveStartingEntry(
  List<CharacterClassEntryData> entries,
) {
  for (final entry in entries) {
    if (entry.isStartingClass == true) {
      return entry;
    }
  }
  if (entries.isEmpty) return null;
  final sortedEntries = [...entries]
    ..sort((a, b) => (a.classOrder ?? 0).compareTo(b.classOrder ?? 0));
  return sortedEntries.first;
}

int _calculateMaxHp(List<CharacterClassEntryData> entries, int conModifier) {
  final sortedEntries = [...entries]
    ..sort((a, b) => (a.classOrder ?? 0).compareTo(b.classOrder ?? 0));
  var total = 0;
  var consumedFirstCharacterLevel = false;

  for (final entry in sortedEntries) {
    final hitDie = _resolveHitDie(entry.classData) ?? 0;
    final fixedGain = max(1, (hitDie ~/ 2) + 1);
    final rolledValues = entry.hpRolledValues ?? const <int>[];
    final level = entry.level ?? 0;

    for (var levelIndex = 0; levelIndex < level; levelIndex++) {
      final isFirstCharacterLevel = !consumedFirstCharacterLevel;
      final rollValue = levelIndex < rolledValues.length
          ? rolledValues[levelIndex]
          : fixedGain;

      total += (isFirstCharacterLevel ? hitDie : rollValue) + conModifier;
      consumedFirstCharacterLevel = true;
    }
  }

  return max(total, 1);
}

Future<_SpellSlotData> _resolveSpellSlots(
  Session session,
  List<CharacterClassEntryData> entries,
) async {
  Map<int, int>? spellSlots;
  Map<int, int>? pactSlots;

  for (final entry in entries) {
    final classData = entry.classData;
    final level = entry.level;
    if (classData == null ||
        classData.spellcastingProgression == null ||
        classData.id == null ||
        level == null) {
      continue;
    }

    final rows = await ClassLevelData.db.find(
      session,
      where: (t) => t.classDataId.equals(classData.id),
    );
    ClassLevelData? match;
    for (final row in rows) {
      if (row.level == level) {
        match = row;
        break;
      }
    }
    if (match == null) continue;

    if (classData.spellcastingProgression ==
        SpellcastingProgression.pactMagic) {
      pactSlots = match.spellSlots;
    } else {
      spellSlots ??= match.spellSlots;
    }
  }

  return _SpellSlotData(
    spellSlots: spellSlots,
    pactSlots: pactSlots,
  );
}

class _SpellSlotData {
  final Map<int, int>? spellSlots;
  final Map<int, int>? pactSlots;

  const _SpellSlotData({
    required this.spellSlots,
    required this.pactSlots,
  });
}

int _abilityModifier(int score) => ((score - 10) / 2).floor();

class _ResolvedDerivedSources {
  final List<ClassChoiceOptionData> classBackgroundOptions;
  final List<RaceChoiceOptionData> raceOptions;
  final List<ClassFeatureData> currentClassFeatures;
  final List<SubclassFeatureData> currentSubclassFeatures;

  const _ResolvedDerivedSources({
    required this.classBackgroundOptions,
    required this.raceOptions,
    required this.currentClassFeatures,
    required this.currentSubclassFeatures,
  });
}

class _CurrentRaceFeatures {
  final List<RaceFeatureData> raceFeatures;
  final List<RaceFeatureData> subraceFeatures;

  const _CurrentRaceFeatures({
    required this.raceFeatures,
    required this.subraceFeatures,
  });
}

Future<_ResolvedDerivedSources> _resolveDerivedSources(
  Session session,
  CharacterData character,
  List<CharacterChoiceData> choices,
) async {
  final entries = character.classEntries ?? const <CharacterClassEntryData>[];
  final currentClassFeatures = <ClassFeatureData>[];
  final currentSubclassFeatures = <SubclassFeatureData>[];
  final classLevels = <int, int>{};
  final subclassLevels = <int, int>{};

  for (final entry in entries) {
    final level = entry.level ?? 0;
    final classId = entry.classData?.id;
    if (classId != null) {
      classLevels[classId] = max(classLevels[classId] ?? 0, level);
      currentClassFeatures.addAll(
        await ClassFeatureData.db.find(
          session,
          where: (t) => t.parentClassId.equals(classId) & (t.level <= level),
          orderBy: (t) => t.level,
        ),
      );
    }

    final subclassId = entry.subclass?.id;
    if (subclassId != null) {
      subclassLevels[subclassId] = max(subclassLevels[subclassId] ?? 0, level);
      currentSubclassFeatures.addAll(
        await SubclassFeatureData.db.find(
          session,
          where: (t) =>
              t.parentSubclassId.equals(subclassId) & (t.level <= level),
          orderBy: (t) => t.level,
        ),
      );
    }
  }

  final currentClassFeatureIds = {
    for (final feature in currentClassFeatures)
      if (feature.id != null) feature.id!,
  };
  final currentSubclassFeatureIds = {
    for (final feature in currentSubclassFeatures)
      if (feature.id != null) feature.id!,
  };

  final allGroups = await ClassChoiceGroupData.db.find(
    session,
    orderBy: (t) => t.id,
  );
  final relevantGroups = allGroups.where((group) {
    final groupLevel = group.level ?? 1;
    final byClass = group.sourceClassId != null &&
        (classLevels[group.sourceClassId!] ?? 0) >= groupLevel;
    final bySubclass = group.sourceSubclassId != null &&
        (subclassLevels[group.sourceSubclassId!] ?? 0) >= groupLevel;
    final byFeature = group.sourceFeatureId != null &&
        currentClassFeatureIds.contains(group.sourceFeatureId);
    final bySubclassFeature = group.sourceSubclassFeatureId != null &&
        currentSubclassFeatureIds.contains(group.sourceSubclassFeatureId);
    final byBackground = group.sourceBackgroundId != null &&
        group.sourceBackgroundId == character.background?.id;

    return byClass ||
        bySubclass ||
        byFeature ||
        bySubclassFeature ||
        byBackground;
  }).toList();

  final optionsByGroupKey = <String, Map<String, ClassChoiceOptionData>>{};
  for (final group in relevantGroups) {
    final groupId = group.id;
    if (groupId == null) continue;

    final options = await ClassChoiceOptionData.db.find(
      session,
      where: (t) => t.choiceGroupId.equals(groupId),
    );
    optionsByGroupKey[_classChoiceGroupKey(group)] = {
      for (final option in options)
        if (_normalizedTextOrNull(option.optionKey) != null)
          option.optionKey!.trim(): option,
    };
  }

  final classBackgroundOptions = <ClassChoiceOptionData>[];
  for (final choice in choices.where(_isClassOrBackgroundChoice)) {
    final groupKey = choice.groupKey;
    final optionKey = _normalizedTextOrNull(choice.optionKey);
    if (groupKey == null || optionKey == null) continue;

    final option = optionsByGroupKey[groupKey]?[optionKey];
    if (option != null) {
      classBackgroundOptions.add(option);
    }
  }

  return _ResolvedDerivedSources(
    classBackgroundOptions: classBackgroundOptions,
    raceOptions: _selectedRaceChoiceOptions(character, choices),
    currentClassFeatures: currentClassFeatures,
    currentSubclassFeatures: currentSubclassFeatures,
  );
}

void _addSkillNames(Set<Skill> target, List<String>? names) {
  for (final name in names ?? const <String>[]) {
    final skill = _skillFromName(name);
    if (skill != null) {
      target.add(skill);
    }
  }
}

Skill? _skillFromName(String raw) {
  final normalized = raw.trim();
  for (final value in Skill.values) {
    if (value.name == normalized) {
      return value;
    }
  }
  return null;
}

List<String> _collectLanguages(
  CharacterData character,
  List<CharacterChoiceData> choices,
  List<ClassChoiceOptionData> classBackgroundOptions,
  List<RaceChoiceOptionData> raceOptions,
) {
  final values = <String>{};
  values.addAll(_normalizedTexts(character.race?.languages));
  values.addAll(_normalizedTexts(character.background?.languages));

  for (final option in classBackgroundOptions) {
    values.addAll([
      for (final language in option.grantedLanguages ?? const <Language>[])
        language.name,
    ]);
  }
  for (final option in raceOptions) {
    if (option.language != null) {
      values.add(option.language!.name);
    }
  }
  for (final choice in choices) {
    if (choice.selectedLanguage != null) {
      values.add(choice.selectedLanguage!.name);
      continue;
    }

    final legacyLanguage = _languageFromName(choice.selectedText ?? '');
    if (legacyLanguage != null) {
      values.add(legacyLanguage.name);
    }
  }

  return values.toList()..sort();
}

List<String> _collectToolProficiencies(
  CharacterData character,
  List<CharacterClassEntryData> entries,
  List<CharacterChoiceData> choices,
  List<ClassChoiceOptionData> classBackgroundOptions,
  List<RaceChoiceOptionData> raceOptions,
) {
  final values = <String>{};
  values.addAll(_normalizedTexts(character.race?.toolProficiencies));
  values.addAll(_normalizedTexts(character.subrace?.toolProficiencies));
  values.addAll(_normalizedTexts(character.background?.toolProficiencies));

  for (final entry in entries) {
    final classData = entry.classData;
    if (classData == null) continue;
    final isStarting = entry.isStartingClass ?? false;
    values.addAll(_normalizedTexts(
      isStarting ? classData.toolTraining : classData.multiclassToolTraining,
    ));
  }
  for (final option in classBackgroundOptions) {
    values.addAll(_normalizedTexts(option.grantedToolKeys));
  }
  for (final option in raceOptions) {
    final toolKey = _normalizedTextOrNull(option.toolKey);
    if (toolKey != null) {
      values.add(toolKey);
    }
  }
  for (final choice in choices) {
    final toolKey = _normalizedTextOrNull(choice.selectedToolKey);
    if (toolKey != null) {
      values.add(toolKey);
    }
  }

  return values.toList()..sort();
}

List<String> _collectArmorTraining(
  CharacterData character,
  List<CharacterClassEntryData> entries,
  List<ClassChoiceOptionData> classBackgroundOptions,
) {
  final values = <String>{};
  values.addAll(_normalizedTexts(character.race?.armorProficiencies));
  values.addAll(_normalizedTexts(character.subrace?.armorProficiencies));

  for (final entry in entries) {
    final classData = entry.classData;
    if (classData == null) continue;
    final source = (entry.isStartingClass ?? false)
        ? classData.armorTraining
        : classData.multiclassArmorTraining;
    values.addAll([
      for (final training in source ?? const <ArmorCategory>[]) training.name,
    ]);
  }
  for (final option in classBackgroundOptions) {
    values.addAll([
      for (final training
          in option.grantedArmorTraining ?? const <ArmorCategory>[])
        training.name,
    ]);
  }

  return values.toList()..sort();
}

List<String> _collectWeaponTraining(
  CharacterData character,
  List<CharacterClassEntryData> entries,
  List<ClassChoiceOptionData> classBackgroundOptions,
) {
  final values = <String>{};
  values.addAll(_normalizedTexts(character.race?.weaponProficiencies));
  values.addAll(_normalizedTexts(character.subrace?.weaponProficiencies));

  for (final entry in entries) {
    final classData = entry.classData;
    if (classData == null) continue;
    final source = (entry.isStartingClass ?? false)
        ? classData.weaponTraining
        : classData.multiclassWeaponTraining;
    values.addAll([
      for (final training in source ?? const <WeaponCategory>[]) training.name,
    ]);
  }
  for (final option in classBackgroundOptions) {
    values.addAll([
      for (final training
          in option.grantedWeaponTraining ?? const <WeaponCategory>[])
        training.name,
    ]);
  }

  return values.toList()..sort();
}

List<int> _collectFeatIds(
  List<CharacterChoiceData> choices,
  List<RaceChoiceOptionData> raceOptions,
) {
  final values = <int>{
    for (final choice in choices)
      if (choice.selectedFeatId != null) choice.selectedFeatId!,
    for (final option in raceOptions)
      if (option.featId != null) option.featId!,
  };
  return values.toList()..sort();
}

Future<Set<FeatureTag>> _loadFeatTags(
  Session session,
  List<int> featIds,
) async {
  if (featIds.isEmpty) {
    return const <FeatureTag>{};
  }

  final feats = await FeatData.db.find(
    session,
    where: (t) => t.id.inSet(featIds.toSet()),
  );
  return {
    for (final feat in feats) ...?feat.tags,
  };
}

List<FeatureTag> _collectFeatureTags({
  required CharacterData character,
  required _ResolvedDerivedSources resolvedSources,
  required _CurrentRaceFeatures currentRaceFeatures,
  required Set<FeatureTag> featTags,
}) {
  final values = <FeatureTag>{
    ...featTags,
    for (final feature in resolvedSources.currentClassFeatures)
      ...?feature.tags,
    for (final feature in resolvedSources.currentSubclassFeatures)
      ...?feature.tags,
    for (final feature in currentRaceFeatures.raceFeatures) ...?feature.tags,
    for (final feature in currentRaceFeatures.subraceFeatures) ...?feature.tags,
    for (final option in resolvedSources.classBackgroundOptions)
      ...?option.grantedFeatureTags,
  };

  final list = values.toList()..sort((a, b) => a.name.compareTo(b.name));
  return list;
}

List<String> _collectGrantedSpellKeys(
  List<CharacterChoiceData> choices,
  List<ClassChoiceOptionData> classBackgroundOptions,
  List<RaceChoiceOptionData> raceOptions,
  _CurrentRaceFeatures currentRaceFeatures,
) {
  final values = <String>{};
  for (final option in classBackgroundOptions) {
    values.addAll(_normalizedTexts(option.grantedSpellKeys));
  }
  for (final option in raceOptions) {
    final spellName = _normalizedTextOrNull(option.spell?.name);
    if (spellName != null) {
      values.add(spellName);
    }
  }
  for (final feature in [
    ...currentRaceFeatures.raceFeatures,
    ...currentRaceFeatures.subraceFeatures,
  ]) {
    for (final grant
        in feature.spellGrants ?? const <RaceFeatureSpellGrantData>[]) {
      final spellName = _normalizedTextOrNull(grant.spell?.name);
      if (spellName != null) {
        values.add(spellName);
      }
    }
  }
  for (final choice in choices) {
    final spellKey = _normalizedTextOrNull(choice.selectedSpellKey);
    if (spellKey != null) {
      values.add(spellKey);
    }
  }
  return values.toList()..sort();
}

List<String> _collectGrantedItemKeys(
  List<CharacterChoiceData> choices,
  List<ClassChoiceOptionData> classBackgroundOptions,
) {
  final values = <String>{};
  for (final option in classBackgroundOptions) {
    values.addAll(_normalizedTexts(option.grantedItemKeys));
  }
  for (final choice in choices) {
    final itemKey = _normalizedTextOrNull(choice.selectedItemKey);
    if (itemKey != null) {
      values.add(itemKey);
    }
  }
  return values.toList()..sort();
}

List<DamageType> _collectDamageTypes(
  CharacterData character,
  List<CharacterChoiceData> choices,
) {
  final values = <DamageType>{};
  values.addAll([
    ...?character.race?.resistances,
    ...?character.subrace?.resistances,
  ]);
  for (final option in _selectedRaceChoiceOptions(character, choices)) {
    if (option.damageType != null) {
      values.add(option.damageType!);
    }
  }
  return values.toList()..sort((a, b) => a.name.compareTo(b.name));
}

bool _isClassOrBackgroundChoice(CharacterChoiceData choice) {
  switch (choice.sourceType) {
    case ChoiceSourceType.background:
    case ChoiceSourceType.classData:
    case ChoiceSourceType.subclass:
    case ChoiceSourceType.classFeature:
    case ChoiceSourceType.subclassFeature:
      return true;
    case ChoiceSourceType.race:
    case ChoiceSourceType.subrace:
    case null:
      return false;
  }
}

String _classChoiceGroupKey(ClassChoiceGroupData group) {
  final explicitKey = _normalizedTextOrNull(group.exclusiveKey);
  if (explicitKey != null) {
    return explicitKey;
  }
  return 'group_${group.id ?? group.name ?? _safeEnumToken(group.type) ?? 'unknown'}';
}

String? _normalizedTextOrNull(String? value) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}

Iterable<String> _normalizedTexts(Iterable<String>? values) sync* {
  for (final value in values ?? const <String>[]) {
    final normalized = _normalizedTextOrNull(value);
    if (normalized != null) {
      yield normalized;
    }
  }
}

Language? _languageFromName(String raw) {
  final normalized = raw.trim();
  for (final value in Language.values) {
    if (value.name == normalized) {
      return value;
    }
  }
  return null;
}

_CurrentRaceFeatures _currentRaceFeaturesBySource(
  CharacterData character,
  int totalLevel,
) {
  final characterLevel = max(totalLevel, 1);

  List<RaceFeatureData> filterCurrent(List<RaceFeatureData>? features) {
    return [
      for (final feature in features ?? const <RaceFeatureData>[])
        if ((feature.level ?? 1) <= characterLevel) feature,
    ];
  }

  return _CurrentRaceFeatures(
    raceFeatures: filterCurrent(character.race?.features),
    subraceFeatures: filterCurrent(character.subrace?.features),
  );
}

List<CharacterFeatureViewData> _buildActiveFeatures({
  required CharacterData character,
  required _ResolvedDerivedSources resolvedSources,
  required _CurrentRaceFeatures currentRaceFeatures,
}) {
  final normalizedOverrides = _normalizedFeatureOverrides(
    character.featureOverrides,
  );
  final overridesByKey = {
    for (final override in normalizedOverrides)
      _featureOverrideKey(override.sourceType, override.sourceId): override,
  };
  final activeFeatures = <CharacterFeatureViewData>[];

  void addFeature({
    required CharacterFeatureSourceType sourceType,
    required int? sourceId,
    required String? sourceName,
    required int? level,
    required String? defaultName,
    required String? defaultDescription,
    required List<FeatureTag>? defaultTags,
  }) {
    if (sourceId == null) {
      return;
    }

    final override = overridesByKey[_featureOverrideKey(sourceType, sourceId)];
    final resolvedName = override?.name ?? defaultName;
    final resolvedDescription = override?.description ?? defaultDescription;
    final normalizedDefaultTags = _normalizedFeatureTags(
      defaultTags,
      preserveEmpty: false,
    );
    final resolvedTags = override?.tags != null
        ? _normalizedFeatureTags(override!.tags, preserveEmpty: true)
        : normalizedDefaultTags;
    final isCustomized = override != null &&
        (_normalizedTextOrNull(resolvedName) !=
                _normalizedTextOrNull(defaultName) ||
            _normalizedTextOrNull(resolvedDescription) !=
                _normalizedTextOrNull(defaultDescription) ||
            !_featureTagsEqual(
              resolvedTags,
              normalizedDefaultTags,
              preserveEmpty: false,
            ));

    activeFeatures.add(
      CharacterFeatureViewData(
        sourceType: sourceType,
        sourceId: sourceId,
        sourceName: sourceName,
        level: level,
        defaultName: defaultName,
        defaultDescription: defaultDescription,
        defaultTags: normalizedDefaultTags,
        name: resolvedName,
        description: resolvedDescription,
        tags: resolvedTags,
        isCustomized: isCustomized,
      ),
    );
  }

  for (final feature in resolvedSources.currentClassFeatures) {
    addFeature(
      sourceType: CharacterFeatureSourceType.classFeature,
      sourceId: feature.id,
      sourceName: character.classEntries
          ?.firstWhere(
            (entry) => entry.classData?.id == feature.parentClassId,
            orElse: CharacterClassEntryData.new,
          )
          .classData
          ?.name,
      level: feature.level,
      defaultName: feature.name,
      defaultDescription: feature.description,
      defaultTags: feature.tags,
    );
  }
  for (final feature in resolvedSources.currentSubclassFeatures) {
    addFeature(
      sourceType: CharacterFeatureSourceType.subclassFeature,
      sourceId: feature.id,
      sourceName: character.classEntries
          ?.firstWhere(
            (entry) => entry.subclass?.id == feature.parentSubclassId,
            orElse: CharacterClassEntryData.new,
          )
          .subclass
          ?.name,
      level: feature.level,
      defaultName: feature.name,
      defaultDescription: feature.description,
      defaultTags: feature.tags,
    );
  }
  for (final feature in currentRaceFeatures.raceFeatures) {
    addFeature(
      sourceType: CharacterFeatureSourceType.raceFeature,
      sourceId: feature.id,
      sourceName: character.race?.name,
      level: feature.level,
      defaultName: feature.name,
      defaultDescription: feature.description,
      defaultTags: feature.tags,
    );
  }
  for (final feature in currentRaceFeatures.subraceFeatures) {
    addFeature(
      sourceType: CharacterFeatureSourceType.subraceFeature,
      sourceId: feature.id,
      sourceName: character.subrace?.name,
      level: feature.level,
      defaultName: feature.name,
      defaultDescription: feature.description,
      defaultTags: feature.tags,
    );
  }

  activeFeatures.sort(_compareActiveFeatures);
  return activeFeatures;
}

List<CharacterFeatureOverrideData> _normalizedFeatureOverrides(
  List<CharacterFeatureOverrideData>? overrides,
) {
  final normalized = <CharacterFeatureOverrideData>[];

  for (final override in overrides ?? const <CharacterFeatureOverrideData>[]) {
    final name = _normalizedTextOrNull(override.name);
    final description = _normalizedTextOrNull(override.description);
    final tags = _normalizedFeatureTags(override.tags, preserveEmpty: true);
    if (name == null && description == null && tags == null) {
      continue;
    }

    final candidate = CharacterFeatureOverrideData(
      sourceType: override.sourceType,
      sourceId: override.sourceId,
      name: name,
      description: description,
      tags: tags,
    );

    final existingIndex = normalized.indexWhere(
      (item) =>
          item.sourceType == candidate.sourceType &&
          item.sourceId == candidate.sourceId,
    );
    if (existingIndex >= 0) {
      normalized[existingIndex] = candidate;
    } else {
      normalized.add(candidate);
    }
  }

  normalized.sort((a, b) {
    final sourceCompare = _featureSourceOrder(a.sourceType)
        .compareTo(_featureSourceOrder(b.sourceType));
    if (sourceCompare != 0) {
      return sourceCompare;
    }
    return a.sourceId.compareTo(b.sourceId);
  });
  return normalized;
}

bool _isMeaningfulFeatureOverride(
  CharacterFeatureOverrideData override,
  CharacterFeatureViewData? defaultFeature,
) {
  if (defaultFeature == null) {
    return false;
  }

  return _normalizedTextOrNull(override.name) !=
          _normalizedTextOrNull(defaultFeature.defaultName) ||
      _normalizedTextOrNull(override.description) !=
          _normalizedTextOrNull(defaultFeature.defaultDescription) ||
      !_featureTagsEqual(
        override.tags,
        defaultFeature.defaultTags,
        preserveEmpty: false,
      );
}

List<FeatureTag>? _normalizedFeatureTags(
  List<FeatureTag>? tags, {
  required bool preserveEmpty,
}) {
  if (tags == null) {
    return null;
  }

  final normalized = {...tags}.toList()
    ..sort((a, b) => a.name.compareTo(b.name));
  if (normalized.isEmpty && !preserveEmpty) {
    return null;
  }
  return normalized;
}

bool _featureTagsEqual(
  List<FeatureTag>? left,
  List<FeatureTag>? right, {
  required bool preserveEmpty,
}) {
  final normalizedLeft = _normalizedFeatureTags(
    left,
    preserveEmpty: preserveEmpty,
  );
  final normalizedRight = _normalizedFeatureTags(
    right,
    preserveEmpty: preserveEmpty,
  );
  if (normalizedLeft == null || normalizedRight == null) {
    return normalizedLeft == normalizedRight;
  }
  if (normalizedLeft.length != normalizedRight.length) {
    return false;
  }
  for (var index = 0; index < normalizedLeft.length; index++) {
    if (normalizedLeft[index] != normalizedRight[index]) {
      return false;
    }
  }
  return true;
}

String _featureOverrideKey(
  CharacterFeatureSourceType sourceType,
  int sourceId,
) {
  return '${sourceType.name}:$sourceId';
}

int _compareActiveFeatures(
  CharacterFeatureViewData a,
  CharacterFeatureViewData b,
) {
  final sourceCompare = _featureSourceOrder(a.sourceType)
      .compareTo(_featureSourceOrder(b.sourceType));
  if (sourceCompare != 0) {
    return sourceCompare;
  }

  final levelCompare = (a.level ?? 0).compareTo(b.level ?? 0);
  if (levelCompare != 0) {
    return levelCompare;
  }

  final nameCompare =
      (a.name ?? a.defaultName ?? '').compareTo(b.name ?? b.defaultName ?? '');
  if (nameCompare != 0) {
    return nameCompare;
  }

  return a.sourceId.compareTo(b.sourceId);
}

int _featureSourceOrder(CharacterFeatureSourceType sourceType) {
  switch (sourceType) {
    case CharacterFeatureSourceType.classFeature:
      return 0;
    case CharacterFeatureSourceType.subclassFeature:
      return 1;
    case CharacterFeatureSourceType.raceFeature:
      return 2;
    case CharacterFeatureSourceType.subraceFeature:
      return 3;
  }
}

String? _safeEnumToken(Object? value) {
  if (value == null) return null;
  final raw = value.toString();
  if (raw.trim().isEmpty) return null;
  final parts = raw.split('.');
  return parts.isEmpty ? raw : parts.last;
}

int? _resolveHitDie(ClassData? classData) {
  if (classData == null) return null;
  return classData.hitDieValue;
}

Ability _abilityForSkill(Skill skill) {
  switch (skill) {
    case Skill.acrobatics:
    case Skill.sleightOfHand:
    case Skill.stealth:
      return Ability.dexterity;
    case Skill.animalHandling:
    case Skill.insight:
    case Skill.medicine:
    case Skill.perception:
    case Skill.survival:
      return Ability.wisdom;
    case Skill.arcana:
    case Skill.history:
    case Skill.investigation:
    case Skill.nature:
    case Skill.religion:
      return Ability.intelligence;
    case Skill.athletics:
      return Ability.strength;
    case Skill.deception:
    case Skill.intimidation:
    case Skill.performance:
    case Skill.persuasion:
      return Ability.charisma;
  }
}

void _applyFixedRaceBonuses(
  Map<String, int> scores,
  Map<String, int> bonuses,
) {
  bonuses.forEach((key, value) {
    scores[key] = (scores[key] ?? 10) + value;
  });
}

Map<String, int> _abilityBonusesFromRace(RaceData? race) {
  return {
    if (race?.strengthBonus != null)
      Ability.strength.name: race!.strengthBonus!,
    if (race?.dexterityBonus != null)
      Ability.dexterity.name: race!.dexterityBonus!,
    if (race?.constitutionBonus != null)
      Ability.constitution.name: race!.constitutionBonus!,
    if (race?.intelligenceBonus != null)
      Ability.intelligence.name: race!.intelligenceBonus!,
    if (race?.wisdomBonus != null) Ability.wisdom.name: race!.wisdomBonus!,
    if (race?.charismaBonus != null)
      Ability.charisma.name: race!.charismaBonus!,
  };
}

Map<String, int> _abilityBonusesFromSubrace(SubraceData? subrace) {
  return {
    if (subrace?.strengthBonus != null)
      Ability.strength.name: subrace!.strengthBonus!,
    if (subrace?.dexterityBonus != null)
      Ability.dexterity.name: subrace!.dexterityBonus!,
    if (subrace?.constitutionBonus != null)
      Ability.constitution.name: subrace!.constitutionBonus!,
    if (subrace?.intelligenceBonus != null)
      Ability.intelligence.name: subrace!.intelligenceBonus!,
    if (subrace?.wisdomBonus != null)
      Ability.wisdom.name: subrace!.wisdomBonus!,
    if (subrace?.charismaBonus != null)
      Ability.charisma.name: subrace!.charismaBonus!,
  };
}

List<RaceChoiceOptionData> _selectedRaceChoiceOptions(
  CharacterData character,
  List<CharacterChoiceData> choices,
) {
  final optionsByGroupKey = <String, Map<String, RaceChoiceOptionData>>{};

  void registerFeatures(List<RaceFeatureData>? features) {
    for (final feature in features ?? const <RaceFeatureData>[]) {
      for (final choiceSet
          in feature.choiceSets ?? const <RaceChoiceSetData>[]) {
        final groupKey = _choiceSetGroupKey(choiceSet.id);
        if (groupKey == null) continue;

        optionsByGroupKey[groupKey] = {
          for (final option
              in choiceSet.choiceOptions ?? const <RaceChoiceOptionData>[])
            if (option.optionKey?.trim().isNotEmpty == true)
              option.optionKey!.trim(): option,
        };
      }
    }
  }

  registerFeatures(character.race?.features);
  registerFeatures(character.subrace?.features);

  final selected = <RaceChoiceOptionData>[];
  for (final choice in choices) {
    final groupKey = choice.groupKey;
    final optionKey = choice.optionKey?.trim();
    if (groupKey == null || optionKey == null || optionKey.isEmpty) {
      continue;
    }

    final option = optionsByGroupKey[groupKey]?[optionKey];
    if (option != null) {
      selected.add(option);
    }
  }

  return selected;
}

int _compareCharacterChoices(CharacterChoiceData a, CharacterChoiceData b) {
  final groupCompare = (a.groupKey ?? '').compareTo(b.groupKey ?? '');
  if (groupCompare != 0) return groupCompare;

  final selectionCompare =
      (a.selectionIndex ?? 0).compareTo(b.selectionIndex ?? 0);
  if (selectionCompare != 0) return selectionCompare;

  return (a.id ?? 0).compareTo(b.id ?? 0);
}

String? _choiceSetGroupKey(int? choiceSetId) {
  if (choiceSetId == null) return null;
  return 'race_choice_$choiceSetId';
}

CharacterRecordInclude _characterRecordInclude() {
  return CharacterRecord.include(
    race: _raceDataInclude(),
    subrace: _subraceDataInclude(),
    background: BackgroundData.include(),
  );
}

RaceDataInclude _raceDataInclude() {
  return RaceData.include(
    features: RaceFeatureData.includeList(
      include: _raceFeatureInclude(),
    ),
  );
}

SubraceDataInclude _subraceDataInclude() {
  return SubraceData.include(
    features: RaceFeatureData.includeList(
      include: _raceFeatureInclude(),
    ),
  );
}

RaceFeatureDataInclude _raceFeatureInclude() {
  return RaceFeatureData.include(
    spellGrants: RaceFeatureSpellGrantData.includeList(
      include: RaceFeatureSpellGrantData.include(
        spell: SpellData.include(),
      ),
    ),
    choiceSets: RaceChoiceSetData.includeList(
      include: RaceChoiceSetData.include(
        choiceOptions: RaceChoiceOptionData.includeList(
          include: RaceChoiceOptionData.include(
            spell: SpellData.include(),
            feat: FeatData.include(),
          ),
        ),
      ),
    ),
  );
}
