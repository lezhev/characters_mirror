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
  final scores = _buildAbilityScores(
    character,
    resolvedSources.selectedOptions,
  );
  final abilityScores = <Ability, int>{
    for (final ability in Ability.values) ability: scores[ability.name] ?? 10,
  };
  final abilityModifiers = <Ability, int>{
    for (final ability in Ability.values)
      ability: _abilityModifier(abilityScores[ability]!),
  };
  final dexMod = abilityModifiers[Ability.dexterity]!;
  final conMod = abilityModifiers[Ability.constitution]!;

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
    resolvedSources.selectedOptions,
  );
  final automaticSkillProficiencyLevels =
      _defaultSkillProficiencyLevels(skillProficiencies);
  for (final option in resolvedSources.selectedOptions) {
    for (final skill in option.grantedExpertiseSkills ?? const <Skill>[]) {
      if (automaticSkillProficiencyLevels[skill] !=
          CharacterSkillProficiencyLevel.none) {
        automaticSkillProficiencyLevels[skill] =
            CharacterSkillProficiencyLevel.expertise;
      }
    }
  }
  final skillProficiencyLevels = _effectiveSkillProficiencyLevels(
    character,
    automaticSkillProficiencyLevels,
  );
  final skillBonuses = <Skill, int>{};
  for (final skill in Skill.values) {
    final base = abilityModifiers[_abilityForSkill(skill)]!;
    final multiplier =
        _skillProficiencyMultiplier(skillProficiencyLevels[skill]);
    final abilityCheckBonus = _featureModifierTotal(
      resolvedSources.featureModifiers,
      character,
      entries,
      resolvedSources.currentClassFeatures,
      resolvedSources.currentSubclassFeatures,
      proficiencyBonus: proficiencyBonus,
      abilityCheckIncludesProficiency: multiplier > 0,
      target: FeatureModifierTarget.abilityCheck,
    );
    skillBonuses[skill] =
        base + (proficiencyBonus * multiplier) + abilityCheckBonus;
  }

  final savingThrowBonuses = <Ability, int>{};
  for (final ability in Ability.values) {
    final base = abilityModifiers[ability]!;
    final proficient = savingThrowAbilities.contains(ability.name);
    savingThrowBonuses[ability] = base + (proficient ? proficiencyBonus : 0);
  }

  final maxHp = _calculateMaxHp(character, entries, conMod);
  final passivePerception = 10 + skillBonuses[Skill.perception]!;
  final passiveInvestigation = 10 + skillBonuses[Skill.investigation]!;
  final passiveInsight = 10 + skillBonuses[Skill.insight]!;
  final spellData = await _resolveSpellSlots(
    session,
    entries,
    transaction: transaction,
    resolveContext: context,
  );
  final languages = _applyProficiencyOverrides<Language>(
    automatic: _collectLanguages(
      character,
      resolvedSources.selectedOptions,
      resolvedSources.currentClassFeatures,
    ),
    added: character.manualLanguageOverrides?.added,
    removed: character.manualLanguageOverrides?.removed,
    sortKey: (value) => value.name,
  );
  final toolProficiencyKeys = _applyProficiencyOverrides<String>(
    automatic: _collectToolProficiencyKeys(
      character,
      entries,
      resolvedSources.selectedOptions,
    ),
    added: character.manualToolProficiencyOverrides?.addedKeys,
    removed: character.manualToolProficiencyOverrides?.removedKeys,
    sortKey: (value) => value,
  );
  final toolExpertiseKeys = {
    for (final option in resolvedSources.selectedOptions)
      ...?option.grantedExpertiseToolKeys,
  }.intersection(toolProficiencyKeys.toSet()).toList()
    ..sort();
  final armorTraining = _applyProficiencyOverrides<ArmorCategory>(
    automatic: _collectArmorTraining(
      character,
      entries,
      resolvedSources.selectedOptions,
    ),
    added: character.manualArmorTrainingOverrides?.addedCategories,
    removed: character.manualArmorTrainingOverrides?.removedCategories,
    sortKey: (value) => value.name,
  );
  final weaponTraining = _applyProficiencyOverrides<WeaponCategory>(
    automatic: _collectWeaponTraining(
      entries,
      resolvedSources.selectedOptions,
    ),
    added: character.manualWeaponProficiencyOverrides?.addedCategories,
    removed: character.manualWeaponProficiencyOverrides?.removedCategories,
    sortKey: (value) => value.name,
  );
  final weaponProficiencyKeys = _applyProficiencyOverrides<String>(
    automatic: _collectWeaponProficiencyKeys(character),
    added: character.manualWeaponProficiencyOverrides?.addedKeys,
    removed: character.manualWeaponProficiencyOverrides?.removedKeys,
    sortKey: (value) => value,
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
    resolvedSources.selectedOptions,
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

  final resistances = _collectDamageTypes(
    character,
    resolvedSources.selectedOptions,
  );
  final movementSpeeds = _effectiveMovementSpeeds(character);
  movementSpeeds[CharacterSpeedKind.walking] =
      (movementSpeeds[CharacterSpeedKind.walking] ?? 30) +
          _featureModifierTotal(
            resolvedSources.featureModifiers,
            character,
            entries,
            resolvedSources.currentClassFeatures,
            resolvedSources.currentSubclassFeatures,
            proficiencyBonus: proficiencyBonus,
            target: FeatureModifierTarget.speed,
          );
  final initiativeBonus = _featureModifierTotal(
    resolvedSources.featureModifiers,
    character,
    entries,
    resolvedSources.currentClassFeatures,
    resolvedSources.currentSubclassFeatures,
    proficiencyBonus: proficiencyBonus,
    abilityCheckIncludesProficiency: false,
    target: FeatureModifierTarget.abilityCheck,
  );
  final armorClass = await _calculateArmorClass(
    character,
    abilityModifiers,
    resolvedSources.currentClassFeatures
        .map((feature) => feature.unarmoredDefenseRule)
        .whereType<UnarmoredDefenseRule>(),
    resolveContext: context,
    transaction: transaction,
  );

  return CharacterDerivedData(
    totalLevel: totalLevel,
    proficiencyBonus: proficiencyBonus,
    abilityScores: abilityScores,
    abilityModifiers: abilityModifiers,
    activeFeatures: activeFeatures,
    armorClass: armorClass.value,
    armorClassSource: armorClass.source,
    armorClassFormula: armorClass.formula,
    initiative:
        dexMod + (character.customInitiativeBonus ?? 0) + initiativeBonus,
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
    toolExpertiseKeys: toolExpertiseKeys,
    armorTraining: armorTraining,
    weaponTraining: weaponTraining,
    weaponProficiencyKeys: weaponProficiencyKeys,
    customLanguages:
        _normalizedCustomValues(character.manualLanguageOverrides?.custom),
    customToolProficiencies: _normalizedCustomValues(
      character.manualToolProficiencyOverrides?.custom,
    ),
    customWeaponProficiencies: _normalizedCustomValues(
      character.manualWeaponProficiencyOverrides?.custom,
    ),
    customArmorTraining: _normalizedCustomValues(
      character.manualArmorTrainingOverrides?.custom,
    ),
    grantedSpellKeys: grantedSpellKeys,
    alwaysPreparedSpellKeys: resolvedSources.alwaysPreparedSpellKeys,
    grantedEquipment: grantedEquipment,
    resistances: resistances,
  );
}

int _featureModifierTotal(
  List<FeatureModifierData> data,
  CharacterData character,
  List<CharacterClassEntryData> entries,
  List<ClassFeatureData> classFeatures,
  List<SubclassFeatureData> subclassFeatures, {
  required int proficiencyBonus,
  required FeatureModifierTarget target,
  bool abilityCheckIncludesProficiency = false,
}) {
  final featureClassKeys = <int, String>{};
  for (final feature in classFeatures) {
    final classKey = entries
        .where((entry) => entry.classData?.id == feature.parentClassId)
        .map((entry) => entry.classData?.referenceKey)
        .whereType<String>()
        .firstOrNull;
    if (feature.id != null && classKey != null) {
      featureClassKeys[feature.id!] = classKey;
    }
  }
  for (final feature in subclassFeatures) {
    final classKey = entries
        .where((entry) => entry.subclass?.id == feature.parentSubclassId)
        .map((entry) => entry.classData?.referenceKey)
        .whereType<String>()
        .firstOrNull;
    if (feature.id != null && classKey != null) {
      featureClassKeys[feature.id!] = classKey;
    }
  }
  final classLevels = <String, int>{};
  for (final entry in entries) {
    final key = entry.classData?.referenceKey;
    if (key != null) {
      classLevels[key] = (classLevels[key] ?? 0) + (entry.level ?? 0);
    }
  }
  final specs = <feature_modifiers.FeatureModifierSpec>[];
  final activeKeys = <String>{};
  for (final feature in classFeatures) {
    if (feature.referenceKey case final key?) activeKeys.add(key);
  }
  for (final feature in subclassFeatures) {
    if (feature.referenceKey case final key?) activeKeys.add(key);
  }
  for (final modifier in data) {
    if ((modifier.classFeatureId == null) ==
        (modifier.subclassFeatureId == null)) {
      continue;
    }
    final featureKey = modifier.classFeature?.referenceKey ??
        classFeatures
            .where((feature) => feature.id == modifier.classFeatureId)
            .map((feature) => feature.referenceKey)
            .firstOrNull ??
        subclassFeatures
            .where((feature) => feature.id == modifier.subclassFeatureId)
            .map((feature) => feature.referenceKey)
            .firstOrNull;
    final sourceId = modifier.classFeatureId ?? modifier.subclassFeatureId;
    final classKey = sourceId == null ? null : featureClassKeys[sourceId];
    if (featureKey == null || classKey == null) continue;
    specs.add(feature_modifiers.FeatureModifierSpec(
      referenceKey: modifier.referenceKey,
      sourceFeatureKey: featureKey,
      sourceClassKey: classKey,
      target: switch (modifier.target) {
        FeatureModifierTarget.speed =>
          feature_modifiers.FeatureModifierTarget.speed,
        FeatureModifierTarget.abilityCheck =>
          feature_modifiers.FeatureModifierTarget.abilityCheck,
      },
      operation: feature_modifiers.FeatureModifierOperation.add,
      valueKind: switch (modifier.value.kind) {
        FeatureModifierValueKind.staticValue =>
          feature_modifiers.FeatureModifierValueKind.staticValue,
        FeatureModifierValueKind.classLevelProgression =>
          feature_modifiers.FeatureModifierValueKind.classLevelProgression,
        FeatureModifierValueKind.proficiencyBonusFraction =>
          feature_modifiers.FeatureModifierValueKind.proficiencyBonusFraction,
      },
      staticValue: modifier.value.staticValue,
      progression: modifier.value.progression ?? const {},
      numerator: modifier.value.numerator,
      denominator: modifier.value.denominator,
      rounding: modifier.value.rounding == FeatureModifierRounding.floor
          ? feature_modifiers.FeatureModifierRounding.floor
          : null,
      conditions: {
        for (final condition
            in modifier.conditions ?? const <FeatureModifierConditionData>[])
          switch (condition.type) {
            FeatureModifierConditionType.unarmored =>
              feature_modifiers.FeatureModifierCondition.unarmored,
            FeatureModifierConditionType.noShield =>
              feature_modifiers.FeatureModifierCondition.noShield,
            FeatureModifierConditionType.abilityCheckIsNotProficient =>
              feature_modifiers
                  .FeatureModifierCondition.abilityCheckIsNotProficient,
          },
      },
    ));
  }
  final evaluated = feature_modifiers.evaluateFeatureModifiers(
    modifiers: specs,
    context: feature_modifiers.FeatureModifierContext(
      proficiencyBonus: proficiencyBonus,
      classLevelsByKey: classLevels,
      activeFeatureKeys: activeKeys,
      isArmored: character.equippedArmor != null,
      hasShield: character.equippedShield != null,
      abilityCheckIncludesProficiency: abilityCheckIncludesProficiency,
    ),
  );
  return feature_modifiers.sumFeatureModifierValues(evaluated)[switch (target) {
        FeatureModifierTarget.speed =>
          feature_modifiers.FeatureModifierTarget.speed,
        FeatureModifierTarget.abilityCheck =>
          feature_modifiers.FeatureModifierTarget.abilityCheck,
      }] ??
      0;
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
  List<ChoiceOptionData> selectedOptions,
) {
  final scores = <String, int>{
    for (final ability in Ability.values) ability.name: 10,
    ...?character.baseAbilityScores,
  };

  if (character.useFlexibleAbilityBonuses != true) {
    _applyFixedRaceBonuses(scores, _abilityBonusesFromRace(character.race));
    _applyFixedRaceBonuses(
      scores,
      _abilityBonusesFromSubrace(character.subrace),
    );
  }
  _applyChoiceAbilityBonuses(scores, selectedOptions);

  _applyCustomAbilityBonuses(scores, character.customAbilityBonuses);

  return scores;
}

void _applyChoiceAbilityBonuses(
  Map<String, int> scores,
  List<ChoiceOptionData> selectedOptions,
) {
  for (final option in selectedOptions) {
    for (final entry in option.grantedAbilityBonuses?.entries ??
        const <MapEntry<String, int>>[]) {
      final ability = _normalizeAbilityKey(entry.key);
      if (ability == null || entry.value == 0) continue;
      scores[ability] = (scores[ability] ?? 10) + entry.value;
    }
  }
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
  List<ChoiceOptionData> selectedOptions,
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

  for (final option in selectedOptions) {
    skills.addAll(option.grantedSkills ?? const <Skill>[]);
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
