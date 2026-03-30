import 'dart:math';

import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class CharacterDataEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<CharacterData>> getAll(Session session) async {
    final userId = await _requireCurrentUserId(session);
    return CharacterData.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );
  }

  Future<CharacterBuildData> upsertBuild(
    Session session,
    CharacterBuildData build,
  ) async {
    final userId = await _requireCurrentUserId(session);
    final character = build.character;
    if (character == null) {
      throw Exception('Character payload is required.');
    }

    final savedCharacter = await _upsertCharacter(session, character, userId);

    await CharacterClassEntryData.db.deleteWhere(
      session,
      where: (t) => t.characterId.equals(savedCharacter.id),
    );

    final insertedEntries = <CharacterClassEntryData>[];
    for (final entry
        in build.classEntries ?? const <CharacterClassEntryData>[]) {
      final mutable = entry.copyWith();
      mutable.id = null;
      mutable.character = savedCharacter;
      insertedEntries
          .add(await CharacterClassEntryData.db.insertRow(session, mutable));
    }

    await CharacterChoiceData.db.deleteWhere(
      session,
      where: (t) => t.characterId.equals(savedCharacter.id),
    );

    final insertedChoices = <CharacterChoiceData>[];
    for (final choice in build.choices ?? const <CharacterChoiceData>[]) {
      final mutable = choice.copyWith();
      mutable.id = null;
      mutable.character = savedCharacter;
      mutable.classEntry =
          _matchSavedEntry(mutable.classEntry, insertedEntries);
      insertedChoices
          .add(await CharacterChoiceData.db.insertRow(session, mutable));
    }

    final snapshot = await _rebuildSnapshot(
      session,
      savedCharacter,
      insertedEntries,
      insertedChoices,
    );

    return CharacterBuildData(
      character: savedCharacter,
      classEntries: insertedEntries,
      choices: insertedChoices,
      snapshot: snapshot,
    );
  }

  Future<CharacterBuildData> getBuild(Session session, int characterId) async {
    final character = await _requireOwnedCharacter(session, characterId);
    final entries = await CharacterClassEntryData.db.find(
      session,
      where: (t) => t.characterId.equals(characterId),
      orderBy: (t) => t.classOrder,
      include: CharacterClassEntryData.include(
        classData: ClassData.include(),
        subclass: SubclassData.include(),
      ),
    );
    final choices = await CharacterChoiceData.db.find(
      session,
      where: (t) => t.characterId.equals(characterId),
    );
    final snapshot = await _findSnapshot(session, characterId);

    return CharacterBuildData(
      character: character,
      classEntries: entries,
      choices: choices,
      snapshot: snapshot,
    );
  }

  Future<CharacterSheetView> getCharacterSheet(
    Session session,
    int characterId,
  ) async {
    final build = await getBuild(session, characterId);
    return CharacterSheetView(
      character: build.character,
      classEntries: build.classEntries,
      choices: build.choices,
      snapshot: build.snapshot,
    );
  }

  Future<void> delete(Session session, int id) async {
    await _requireOwnedCharacter(session, id);
    await CharacterChoiceData.db.deleteWhere(
      session,
      where: (t) => t.characterId.equals(id),
    );
    await CharacterClassEntryData.db.deleteWhere(
      session,
      where: (t) => t.characterId.equals(id),
    );
    await CharacterSheetSnapshotData.db.deleteWhere(
      session,
      where: (t) => t.characterId.equals(id),
    );
    await CharacterData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}

Future<CharacterData> _upsertCharacter(
  Session session,
  CharacterData character,
  int userId,
) async {
  final now = DateTime.now();
  character.userId = userId;

  if (character.id == null) {
    character.id = null;
    character.version ??= 1;
    character.createdAt ??= now;
    character.updatedAt ??= now;
    return CharacterData.db.insertRow(session, character);
  }

  final ownedCharacter = await _findOwnedCharacter(
    session,
    character.id!,
    userId,
  );
  if (ownedCharacter != null) {
    character.id = ownedCharacter.id;
    character.userId = ownedCharacter.userId ?? userId;
    character.version = (ownedCharacter.version ?? 0) + 1;
    character.createdAt = ownedCharacter.createdAt ?? now;
    character.updatedAt = now;
    await CharacterData.db.updateRow(session, character);
    return character;
  }

  final existingById = await CharacterData.db.find(
    session,
    where: (t) => t.id.equals(character.id),
    limit: 1,
  );
  if (existingById.isNotEmpty) {
    throw Exception('Access denied to character id=${character.id}.');
  }

  character.id = null;
  character.version ??= 1;
  character.createdAt ??= now;
  character.updatedAt ??= now;
  return CharacterData.db.insertRow(session, character);
}

Future<int> _requireCurrentUserId(Session session) async {
  final userId = (await session.authenticated)?.userId;
  if (userId == null) {
    throw Exception('Authentication required.');
  }
  return userId;
}

Future<CharacterData?> _findOwnedCharacter(
  Session session,
  int characterId,
  int userId,
) async {
  final rows = await CharacterData.db.find(
    session,
    where: (t) => t.id.equals(characterId) & t.userId.equals(userId),
    limit: 1,
  );
  if (rows.isEmpty) {
    return null;
  }
  return rows.first;
}

Future<CharacterData> _requireOwnedCharacter(
  Session session,
  int characterId,
) async {
  final userId = await _requireCurrentUserId(session);
  final rows = await CharacterData.db.find(
    session,
    where: (t) => t.id.equals(characterId) & t.userId.equals(userId),
    limit: 1,
    include: CharacterData.include(
      race: _raceDataInclude(),
      subrace: _subraceDataInclude(),
      background: BackgroundData.include(),
    ),
  );
  if (rows.isEmpty) {
    final existing = await CharacterData.db.find(
      session,
      where: (t) => t.id.equals(characterId),
      limit: 1,
    );
    if (existing.isNotEmpty) {
      throw Exception('Access denied to character id=$characterId.');
    }

    throw Exception('CharacterData with id=$characterId was not found.');
  }
  return rows.first;
}

CharacterClassEntryData? _matchSavedEntry(
  CharacterClassEntryData? draftEntry,
  List<CharacterClassEntryData> savedEntries,
) {
  if (draftEntry == null) return null;
  for (final saved in savedEntries) {
    final sameClass = saved.classData?.id == draftEntry.classData?.id;
    final sameOrder = saved.classOrder == draftEntry.classOrder;
    if (sameClass && sameOrder) {
      return saved;
    }
  }
  return null;
}

Future<CharacterSheetSnapshotData?> _findSnapshot(
  Session session,
  int characterId,
) async {
  final rows = await CharacterSheetSnapshotData.db.find(
    session,
    where: (t) => t.characterId.equals(characterId),
    limit: 1,
  );
  return rows.isEmpty ? null : rows.first;
}

Future<CharacterSheetSnapshotData> _rebuildSnapshot(
  Session session,
  CharacterData character,
  List<CharacterClassEntryData> entries,
  List<CharacterChoiceData> choices,
) async {
  final totalLevel = entries.fold<int>(0, (sum, entry) => sum + entry.level);
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
  final initiative = dexMod;
  final speed = character.race?.speed ?? 30;
  final passivePerception = 10 + (skillBonuses[Skill.perception.name] ?? 0);
  final passiveInvestigation =
      10 + (skillBonuses[Skill.investigation.name] ?? 0);
  final passiveInsight = 10 + (skillBonuses[Skill.insight.name] ?? 0);
  final spellData = await _resolveSpellSlots(session, entries);
  final hitDiceSummary = <String, int>{};
  for (final entry in entries) {
    final hitDie = _resolveHitDie(entry.classData);
    if (hitDie != null) {
      final key = 'd$hitDie';
      hitDiceSummary[key] = (hitDiceSummary[key] ?? 0) + entry.level;
    }
  }

  final senses = <String>[
    if (character.race?.visionType != null) character.race!.visionType!.name,
  ];
  final resistances = _collectDamageTypes(character, choices);

  final existing = await _findSnapshot(session, character.id!);
  final snapshot = (existing ??
          CharacterSheetSnapshotData(
            characterId: character.id!,
            character: character,
          ))
      .copyWith(
    character: character,
    totalLevel: totalLevel,
    proficiencyBonus: proficiencyBonus,
    armorClass: 10 + dexMod,
    initiative: initiative,
    speed: speed,
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
    sheetVersion: (existing?.sheetVersion ?? 0) + 1,
    rebuiltAt: DateTime.now(),
  );

  if (existing == null) {
    return CharacterSheetSnapshotData.db.insertRow(session, snapshot);
  }

  snapshot.id = existing.id;
  await CharacterSheetSnapshotData.db.updateRow(session, snapshot);
  return snapshot;
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
      choices, ChoiceSourceType.race, character.race?.id);
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
  entries.sort((a, b) => (a.classOrder ?? 0).compareTo(b.classOrder ?? 0));
  return entries.first;
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

    for (var levelIndex = 0; levelIndex < entry.level; levelIndex++) {
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
    if (classData == null || classData.spellcastingProgression == null) {
      continue;
    }

    final rows = await ClassLevelData.db.find(
      session,
      where: (t) => t.classDataId.equals(classData.id),
    );
    ClassLevelData? match;
    for (final row in rows) {
      if (row.level == entry.level) {
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
