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
    final savedRecord = await _upsertCharacterRecord(session, character, userId);

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
      character.classEntries ?? const <CharacterClassEntryData>[],
    );
    await _insertChoiceRecords(
      session,
      savedRecord,
      savedEntries,
      character.choices ?? const <CharacterChoiceData>[],
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
    temporaryHp: character.temporaryHp,
    currentHp: character.currentHp,
    inspiration: character.inspiration,
    notes: character.notes,
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
    final matchedEntry = _matchSavedEntryRecord(choice.classEntry, savedEntries);
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
        selectedSpellKey: choice.selectedSpellKey,
        selectedItemKey: choice.selectedItemKey,
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
      .toList();

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
    temporaryHp: record.temporaryHp,
    currentHp: record.currentHp,
    inspiration: record.inspiration,
    notes: record.notes,
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
    classEntry: record.classEntryId == null
        ? null
        : entriesById[record.classEntryId!],
    sourceType: record.sourceType,
    sourceId: record.sourceId,
    groupKey: record.groupKey,
    optionKey: record.optionKey,
    selectedSpellKey: record.selectedSpellKey,
    selectedItemKey: record.selectedItemKey,
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
  final totalLevel = entries.fold<int>(0, (sum, entry) => sum + (entry.level ?? 0));
  final proficiencyBonus = totalLevel <= 0 ? 2 : 2 + ((totalLevel - 1) ~/ 4);
  final scores = _buildAbilityScores(character, choices);
  final dexMod = _abilityModifier(scores['dexterity'] ?? 10);
  final conMod = _abilityModifier(scores['constitution'] ?? 10);

  final startingEntry = _resolveStartingEntry(entries);
  final savingThrowAbilities = {
    for (final ability in startingEntry?.classData?.savingThrowProficiencies ??
        const <Ability>[])
      ability.name,
  };

  final skillProficiencies = _collectSkillProficiencies(character, choices);
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
    final key = choice.optionKey?.trim();
    final bonus = choice.selectedCount ?? 0;
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
) {
  final skills = <Skill>{};
  _addSkillNames(skills, character.race?.skillProficiencies);
  _addSkillNames(skills, character.subrace?.skillProficiencies);
  _addSkillNames(skills, character.background?.skillProficiencies);

  for (final choice in choices) {
    if (choice.selectedText == null) continue;
    final skill = _skillFromName(choice.selectedText!);
    if (skill != null) {
      skills.add(skill);
    }
  }
  for (final option in _selectedRaceChoiceOptions(character, choices)) {
    if (option.skill != null) {
      skills.add(option.skill!);
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
    if (race?.strengthBonus != null) Ability.strength.name: race!.strengthBonus!,
    if (race?.dexterityBonus != null)
      Ability.dexterity.name: race!.dexterityBonus!,
    if (race?.constitutionBonus != null)
      Ability.constitution.name: race!.constitutionBonus!,
    if (race?.intelligenceBonus != null)
      Ability.intelligence.name: race!.intelligenceBonus!,
    if (race?.wisdomBonus != null) Ability.wisdom.name: race!.wisdomBonus!,
    if (race?.charismaBonus != null) Ability.charisma.name: race!.charismaBonus!,
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
      for (final choiceSet in feature.choiceSets ?? const <RaceChoiceSetData>[]) {
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
          ),
        ),
      ),
    ),
  );
}
