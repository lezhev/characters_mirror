import 'dart:math';

import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class CharacterDataEndpoint extends Endpoint {
  Future<List<CharacterData>> getAll(Session session) async {
    return CharacterData.db.find(session);
  }

  Future<CharacterBuildData> upsertBuild(
    Session session,
    CharacterBuildData build,
  ) async {
    final character = build.character;
    if (character == null) {
      throw Exception('Character payload is required.');
    }

    final savedCharacter = await _upsertCharacter(session, character);

    await CharacterClassEntryData.db.deleteWhere(
      session,
      where: (t) => t.characterId.equals(savedCharacter.id),
    );

    final insertedEntries = <CharacterClassEntryData>[];
    for (final entry in build.classEntries ?? const <CharacterClassEntryData>[]) {
      final mutable = entry.copyWith();
      mutable.id = null;
      mutable.character = savedCharacter;
      insertedEntries.add(await CharacterClassEntryData.db.insertRow(session, mutable));
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
      mutable.classEntry = _matchSavedEntry(mutable.classEntry, insertedEntries);
      insertedChoices.add(await CharacterChoiceData.db.insertRow(session, mutable));
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
    final character = await _requireCharacter(session, characterId);
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
) async {
  final now = DateTime.now();
  if (character.id == null) {
    character.version ??= 1;
    character.createdAt ??= now;
    character.updatedAt ??= now;
    return CharacterData.db.insertRow(session, character);
  }

  final existing = await CharacterData.db.find(
    session,
    where: (t) => t.id.equals(character.id),
    limit: 1,
  );
  if (existing.isEmpty) {
    character.version ??= 1;
    character.createdAt ??= now;
    character.updatedAt ??= now;
    return CharacterData.db.insertRow(session, character);
  }

  final old = existing.first;
  character.id = old.id;
  character.version = (old.version ?? 0) + 1;
  character.createdAt = old.createdAt ?? now;
  character.updatedAt = now;
  await CharacterData.db.updateRow(session, character);
  return character;
}

Future<CharacterData> _requireCharacter(Session session, int characterId) async {
  final rows = await CharacterData.db.find(
    session,
    where: (t) => t.id.equals(characterId),
    limit: 1,
    include: CharacterData.include(
      race: RaceData.include(),
      subrace: SubraceData.include(),
      background: BackgroundData.include(),
    ),
  );
  if (rows.isEmpty) {
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
    for (final ability in startingEntry?.classData?.savingThrowProficiencies ?? const <Ability>[])
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
    savingThrowBonuses[ability.name] = base + (proficient ? proficiencyBonus : 0);
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
    if (character.race?.visionType?.isNotEmpty == true) character.race!.visionType!,
  ];
  final resistances = _collectDamageTypes(character);

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

  void applyBonuses(Map<String, int>? bonuses) {
    if (bonuses == null) return;
    bonuses.forEach((key, value) {
      scores[key] = (scores[key] ?? 10) + value;
    });
  }

  applyBonuses(character.race?.abilityBonuses);
  applyBonuses(character.subrace?.abilityBonuses);
  for (final choice in choices) {
    final key = choice.optionKey;
    if (key == null) continue;
  }
  return scores;
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

    if (classData.spellcastingProgression == SpellcastingProgression.pactMagic) {
      pactSlots = match.spellSlots;
    } else if (spellSlots == null) {
      spellSlots = match.spellSlots;
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

List<DamageType> _collectDamageTypes(CharacterData character) {
  final values = <DamageType>{};
  for (final raw in [
    ...?character.race?.resistances,
    ...?character.subrace?.resistances,
  ]) {
    final damageType = _damageTypeFromName(raw);
    if (damageType != null) {
      values.add(damageType);
    }
  }
  return values.toList();
}

DamageType? _damageTypeFromName(String raw) {
  final normalized = raw.trim();
  for (final value in DamageType.values) {
    if (value.name == normalized) {
      return value;
    }
  }
  return null;
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
