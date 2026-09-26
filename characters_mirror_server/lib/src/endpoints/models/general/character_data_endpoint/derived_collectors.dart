part of '../character_data_endpoint.dart';

List<String> _collectAlwaysPreparedSpellKeys(
  List<ClassSpellGrantData> grants, {
  required Map<int, int> classLevels,
  required Map<int, int> subclassLevels,
  required Set<int> currentClassFeatureIds,
  required Set<int> currentSubclassFeatureIds,
  required Map<int, int> currentClassFeatureLevels,
  required Map<int, int> currentSubclassFeatureLevels,
}) {
  final values = <String>{};
  for (final grant in grants) {
    if (grant.alwaysPrepared == false ||
        !_isClassSpellGrantActive(
          grant,
          classLevels: classLevels,
          subclassLevels: subclassLevels,
          currentClassFeatureIds: currentClassFeatureIds,
          currentSubclassFeatureIds: currentSubclassFeatureIds,
          currentClassFeatureLevels: currentClassFeatureLevels,
          currentSubclassFeatureLevels: currentSubclassFeatureLevels,
        )) {
      continue;
    }

    final spellKey = _normalizedTextOrNull(grant.spell?.referenceKey) ??
        _normalizedTextOrNull(grant.spell?.name);
    if (spellKey != null) {
      values.add(spellKey);
    }
  }
  return values.toList()..sort();
}

bool _isClassSpellGrantActive(
  ClassSpellGrantData grant, {
  required Map<int, int> classLevels,
  required Map<int, int> subclassLevels,
  required Set<int> currentClassFeatureIds,
  required Set<int> currentSubclassFeatureIds,
  required Map<int, int> currentClassFeatureLevels,
  required Map<int, int> currentSubclassFeatureLevels,
}) {
  final requiredLevel = grant.grantedAtLevel ?? 1;
  var hasSource = false;
  var active = false;

  final sourceClassId = grant.sourceClassId;
  if (sourceClassId != null) {
    hasSource = true;
    active = active || (classLevels[sourceClassId] ?? 0) >= requiredLevel;
  }

  final sourceSubclassId = grant.sourceSubclassId;
  if (sourceSubclassId != null) {
    hasSource = true;
    active = active || (subclassLevels[sourceSubclassId] ?? 0) >= requiredLevel;
  }

  final sourceFeatureId = grant.sourceFeatureId;
  if (sourceFeatureId != null) {
    hasSource = true;
    active = active ||
        (currentClassFeatureIds.contains(sourceFeatureId) &&
            (currentClassFeatureLevels[sourceFeatureId] ?? 0) >= requiredLevel);
  }

  final sourceSubclassFeatureId = grant.sourceSubclassFeatureId;
  if (sourceSubclassFeatureId != null) {
    hasSource = true;
    active = active ||
        (currentSubclassFeatureIds.contains(sourceSubclassFeatureId) &&
            (currentSubclassFeatureLevels[sourceSubclassFeatureId] ?? 0) >=
                requiredLevel);
  }

  return hasSource && active;
}

List<String> _collectLanguages(
  CharacterData character,
  List<CharacterChoiceData> choices,
  List<ClassChoiceOptionData> classBackgroundOptions,
  List<RaceChoiceOptionData> raceOptions,
) {
  final values = <String>{};
  values.addAll([
    for (final language in character.race?.languages ?? const <Language>[])
      language.name,
  ]);

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

List<String> _collectToolProficiencyKeys(
  CharacterData character,
  List<CharacterClassEntryData> entries,
  List<CharacterChoiceData> choices,
  List<ClassChoiceOptionData> classBackgroundOptions,
  List<RaceChoiceOptionData> raceOptions,
) {
  final values = <String>{};
  values.addAll(_normalizedTexts(character.race?.toolProficiencyKeys));
  values.addAll(_normalizedTexts(character.subrace?.toolProficiencyKeys));
  values.addAll(_normalizedTexts(character.background?.toolProficiencyKeys));

  for (final entry in entries) {
    final classData = entry.classData;
    if (classData == null) continue;
    final isStarting = entry.isStartingClass ?? false;
    values.addAll(_normalizedTexts(
      isStarting
          ? classData.toolTrainingKeys
          : classData.multiclassToolTrainingKeys,
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
  values.addAll([
    for (final training
        in character.race?.armorProficiencies ?? const <ArmorCategory>[])
      training.name,
    for (final training
        in character.subrace?.armorProficiencies ?? const <ArmorCategory>[])
      training.name,
  ]);

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

List<WeaponCategory> _collectWeaponTraining(
  List<CharacterClassEntryData> entries,
  List<ClassChoiceOptionData> classBackgroundOptions,
) {
  final values = <WeaponCategory>{};

  for (final entry in entries) {
    final classData = entry.classData;
    if (classData == null) continue;
    final source = (entry.isStartingClass ?? false)
        ? classData.weaponTraining
        : classData.multiclassWeaponTraining;
    values.addAll(source ?? const <WeaponCategory>[]);
  }
  for (final option in classBackgroundOptions) {
    values.addAll(option.grantedWeaponTraining ?? const <WeaponCategory>[]);
  }

  return values.toList()..sort((a, b) => a.name.compareTo(b.name));
}

List<String> _collectWeaponProficiencyKeys(CharacterData character) {
  final values = <String>{
    ..._normalizedTexts(character.race?.weaponProficiencyKeys),
    ..._normalizedTexts(character.subrace?.weaponProficiencyKeys),
  };
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
  List<int> featIds, {
  Transaction? transaction,
  _CharacterResolveContext? resolveContext,
}) async {
  if (featIds.isEmpty) {
    return const <FeatureTag>{};
  }

  final feats =
      await (resolveContext ?? _CharacterResolveContext(session)).feats(
    featIds.toSet(),
    transaction: transaction,
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
    for (final option in resolvedSources.raceOptions)
      ...?option.grantedFeatureTags,
  };

  final list = values.toList()..sort((a, b) => a.name.compareTo(b.name));
  return list;
}

List<String> _collectGrantedSpellKeys(
  List<CharacterSpellSelectionData> spellSelections,
  List<ClassChoiceOptionData> classBackgroundOptions,
  List<RaceChoiceOptionData> raceOptions,
  _CurrentRaceFeatures currentRaceFeatures,
  List<String> alwaysPreparedSpellKeys,
) {
  final values = <String>{};
  values.addAll(alwaysPreparedSpellKeys);
  for (final selection in spellSelections) {
    final spellKey = _normalizedTextOrNull(selection.spellKey) ??
        _normalizedTextOrNull(selection.spell?.referenceKey) ??
        _normalizedTextOrNull(selection.spell?.name);
    if (spellKey != null) {
      values.add(spellKey);
    }
  }
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
  return values.toList()..sort();
}
