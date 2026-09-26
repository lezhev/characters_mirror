part of '../character_data_endpoint.dart';

int _abilityModifier(int score) => ((score - 10) / 2).floor();

Future<CharacterDerivedData> _buildDerivedData(
  Session session,
  CharacterData character, {
  Transaction? transaction,
  _CharacterResolveContext? resolveContext,
}) async {
  final context = resolveContext ?? _CharacterResolveContext(session);
  final entries = character.classEntries ?? const <CharacterClassEntryData>[];
  final choices = character.choices ?? const <CharacterChoiceData>[];
  final totalLevel =
      entries.fold<int>(0, (sum, entry) => sum + (entry.level ?? 0));
  final proficiencyBonus = totalLevel <= 0 ? 2 : 2 + ((totalLevel - 1) ~/ 4);
  final resolvedSources = await _resolveDerivedSources(
    session,
    character,
    choices,
    transaction: transaction,
    resolveContext: context,
  );
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
  final defaultSavingThrowAbilities = {
    for (final ability in startingEntry?.classData?.savingThrowProficiencies ??
        const <Ability>[])
      ability.name,
  };
  final savingThrowAbilities = _effectiveSavingThrowAbilities(
    character,
    defaultSavingThrowAbilities,
  );
  final savingThrowProficiencies = [
    for (final ability in Ability.values)
      if (savingThrowAbilities.contains(ability.name)) ability,
  ];

  final skillProficiencies = _collectSkillProficiencies(
    character,
    character.skillSelections ?? const <CharacterSkillSelectionData>[],
    resolvedSources.classBackgroundOptions,
    resolvedSources.raceOptions,
  );
  final skillProficiencyLevels = _effectiveSkillProficiencyLevels(
    character,
    _defaultSkillProficiencyLevels(skillProficiencies),
  );
  final skillBonuses = <String, int>{};
  for (final skill in Skill.values) {
    final base = _abilityModifier(scores[_abilityForSkill(skill).name] ?? 10);
    final multiplier =
        _skillProficiencyMultiplier(skillProficiencyLevels[skill]);
    skillBonuses[skill.name] = base + (proficiencyBonus * multiplier);
  }

  final savingThrowBonuses = <String, int>{};
  for (final ability in Ability.values) {
    final base = _abilityModifier(scores[ability.name] ?? 10);
    final proficient = savingThrowAbilities.contains(ability.name);
    savingThrowBonuses[ability.name] =
        base + (proficient ? proficiencyBonus : 0);
  }

  final maxHp = _calculateMaxHp(character, entries, conMod);
  final passivePerception = 10 + (skillBonuses[Skill.perception.name] ?? 0);
  final passiveInvestigation =
      10 + (skillBonuses[Skill.investigation.name] ?? 0);
  final passiveInsight = 10 + (skillBonuses[Skill.insight.name] ?? 0);
  final spellData = await _resolveSpellSlots(
    session,
    entries,
    transaction: transaction,
    resolveContext: context,
  );
  final languages = _collectLanguages(
    character,
    choices,
    resolvedSources.classBackgroundOptions,
    resolvedSources.raceOptions,
  );
  final toolProficiencyKeys = _collectToolProficiencyKeys(
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
    entries,
    resolvedSources.classBackgroundOptions,
  );
  final weaponProficiencyKeys = _collectWeaponProficiencyKeys(character);
  final featIds = _collectFeatIds(choices, resolvedSources.raceOptions);
  final featTags = await _loadFeatTags(
    session,
    featIds,
    transaction: transaction,
    resolveContext: context,
  );
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
    totalLevel: totalLevel,
    proficiencyBonus: proficiencyBonus,
    abilityModifiers: abilityModifiers,
  );
  final grantedSpellKeys = _collectGrantedSpellKeys(
    character.spellSelections ?? const <CharacterSpellSelectionData>[],
    resolvedSources.classBackgroundOptions,
    resolvedSources.raceOptions,
    currentRaceFeatures,
    resolvedSources.alwaysPreparedSpellKeys,
  );
  final grantedEquipment = await _collectGrantedEquipment(
    session,
    character,
    transaction: transaction,
    resolveContext: context,
  );
  final hitDiceSummary = _hitDiceSummary(character, entries);

  final senses = <String>[
    if (character.race?.visionType != null) character.race!.visionType!.name,
  ];
  final resistances = _collectDamageTypes(character, choices);
  final movementSpeeds = _effectiveMovementSpeeds(character);

  return CharacterDerivedData(
    totalLevel: totalLevel,
    proficiencyBonus: proficiencyBonus,
    abilityScores: scores,
    abilityModifiers: abilityModifiers,
    activeFeatures: activeFeatures,
    armorClass: 10 + dexMod + (character.customArmorClassBonus ?? 0),
    initiative: dexMod + (character.customInitiativeBonus ?? 0),
    speed: _displayedSpeed(character.displayedSpeedKind, movementSpeeds),
    maxHp: maxHp,
    passivePerception: passivePerception,
    passiveInvestigation: passiveInvestigation,
    passiveInsight: passiveInsight,
    savingThrowBonuses: savingThrowBonuses,
    skillBonuses: skillBonuses,
    skillProficiencyLevels: _skillProficiencyStateList(skillProficiencyLevels),
    savingThrowProficiencies: savingThrowProficiencies,
    spellSlots: spellData.spellSlots,
    pactSlots: spellData.pactSlots,
    hitDiceSummary: hitDiceSummary,
    languages: languages,
    toolProficiencyKeys: toolProficiencyKeys,
    armorTraining: armorTraining,
    weaponTraining: weaponTraining,
    weaponProficiencyKeys: weaponProficiencyKeys,
    featureTags: featureTags,
    featIds: featIds,
    grantedSpellKeys: grantedSpellKeys,
    alwaysPreparedSpellKeys: resolvedSources.alwaysPreparedSpellKeys,
    grantedEquipment: grantedEquipment,
    senses: senses,
    resistances: resistances,
    rebuiltAt: DateTime.now(),
  );
}

Set<String> _effectiveSavingThrowAbilities(
  CharacterData character,
  Set<String> defaults,
) {
  final overrides = character.manualSavingThrowProficiencyOverrides;
  if (overrides != null) {
    final result = {...defaults};
    for (final value in overrides) {
      if (value.state == CharacterSavingThrowProficiencyOverride.add) {
        result.add(value.ability.name);
      } else {
        result.remove(value.ability.name);
      }
    }
    return result;
  }
  final legacy = character.manualSavingThrowProficiencies;
  if (legacy == null) return defaults;
  return {for (final ability in legacy) ability.name};
}

Map<Skill, CharacterSkillProficiencyLevel> _effectiveSkillProficiencyLevels(
  CharacterData character,
  Map<Skill, CharacterSkillProficiencyLevel> defaults,
) {
  final overrides = character.manualSkillProficiencyOverrides;
  if (overrides != null) {
    final result = {...defaults};
    for (final value in overrides) {
      result[value.skill] = value.level;
    }
    return result;
  }
  if (character.manualSkillProficiencies == null) return defaults;
  return _normalizedSkillProficiencyLevels(character.manualSkillProficiencies);
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

  if (!usesFlexibleBonuses) {
    _applyFixedRaceBonuses(
      scores,
      _abilityBonusesFromRace(character.race),
    );
  }
  _applyRacialChoiceBonuses(scores, activeRaceChoices);

  if (usesFlexibleBonuses) {
    // Flexible +2/+1 replaces both the race and subrace default bonuses.
  } else {
    _applyFixedRaceBonuses(
      scores,
      _abilityBonusesFromSubrace(character.subrace),
    );
  }
  _applyRacialChoiceBonuses(scores, activeSubraceChoices);

  _applyCustomAbilityBonuses(scores, character.customAbilityBonuses);

  return scores;
}

void _applyCustomAbilityBonuses(
  Map<String, int> scores,
  Map<String, int>? bonuses,
) {
  if (bonuses == null) {
    return;
  }

  for (final entry in bonuses.entries) {
    final abilityKey = _normalizeAbilityKey(entry.key);
    if (abilityKey == null || entry.value == 0) {
      continue;
    }
    scores[abilityKey] = (scores[abilityKey] ?? 10) + entry.value;
  }
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
  List<CharacterSkillSelectionData> skillSelections,
  List<ClassChoiceOptionData> classBackgroundOptions,
  List<RaceChoiceOptionData> raceOptions,
) {
  final skills = <Skill>{};
  skills.addAll(character.race?.skillProficiencies ?? const <Skill>[]);
  skills.addAll(character.subrace?.skillProficiencies ?? const <Skill>[]);
  skills.addAll(character.background?.skillProficiencies ?? const <Skill>[]);

  for (final selection in skillSelections) {
    final skill = selection.skill;
    if (skill != null) {
      skills.add(skill);
    }
  }

  for (final option in classBackgroundOptions) {
    skills.addAll(option.grantedSkills ?? const <Skill>[]);
  }

  for (final option in raceOptions) {
    if (option.skill != null) {
      skills.add(option.skill!);
    }
  }

  return skills;
}

Map<Skill, CharacterSkillProficiencyLevel> _defaultSkillProficiencyLevels(
  Set<Skill> skillProficiencies,
) {
  return {
    for (final skill in Skill.values)
      skill: skillProficiencies.contains(skill)
          ? CharacterSkillProficiencyLevel.proficient
          : CharacterSkillProficiencyLevel.none,
  };
}

Map<Skill, CharacterSkillProficiencyLevel> _normalizedSkillProficiencyLevels(
  List<CharacterSkillProficiencyState>? states,
) {
  final levels = {
    for (final skill in Skill.values)
      skill: CharacterSkillProficiencyLevel.none,
  };
  for (final state in states ?? const <CharacterSkillProficiencyState>[]) {
    levels[state.skill] = state.level;
  }
  return levels;
}

List<CharacterSkillProficiencyState> _skillProficiencyStateList(
  Map<Skill, CharacterSkillProficiencyLevel> levels,
) {
  return [
    for (final skill in Skill.values)
      CharacterSkillProficiencyState(
        skill: skill,
        level: levels[skill] ?? CharacterSkillProficiencyLevel.none,
      ),
  ];
}

int _skillProficiencyMultiplier(CharacterSkillProficiencyLevel? level) {
  switch (level) {
    case CharacterSkillProficiencyLevel.proficient:
      return 1;
    case CharacterSkillProficiencyLevel.expertise:
      return 2;
    case CharacterSkillProficiencyLevel.none:
    case null:
      return 0;
  }
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

int _calculateMaxHp(
  CharacterData character,
  List<CharacterClassEntryData> entries,
  int conModifier,
) {
  final sortedEntries = [...entries]
    ..sort((a, b) => (a.classOrder ?? 0).compareTo(b.classOrder ?? 0));
  var total = 0;
  var consumedFirstCharacterLevel = false;
  var totalLevel = 0;

  for (final entry in sortedEntries) {
    final hitDie = max(1, _resolveHitDie(entry.classData) ?? 8);
    final fixedGain = max(1, (hitDie ~/ 2) + 1);
    final rolledValues = entry.hpRolledValues ?? const <int>[];
    final level = entry.level ?? 0;

    for (var levelIndex = 0; levelIndex < level; levelIndex++) {
      final isFirstCharacterLevel = !consumedFirstCharacterLevel;
      final defaultGain = isFirstCharacterLevel ? hitDie : fixedGain;
      final rollValue = levelIndex < rolledValues.length
          ? rolledValues[levelIndex]
          : defaultGain;

      total += rollValue.clamp(1, hitDie).toInt() + conModifier;
      consumedFirstCharacterLevel = true;
      totalLevel++;
    }
  }

  total += totalLevel * (character.hpPerLevelBonus ?? 0);
  total += character.hpFlatBonus ?? 0;

  return max(total, 1);
}

Map<String, int> _hitDiceSummary(
  CharacterData character,
  List<CharacterClassEntryData> entries,
) {
  final result = <String, int>{};
  for (final entry in entries) {
    final hitDie = _resolveHitDie(entry.classData);
    final level = entry.level ?? 0;
    if (hitDie != null && level > 0) {
      final key = 'd$hitDie';
      result[key] = (result[key] ?? 0) + level;
    }
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
