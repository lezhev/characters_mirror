part of '../character_data_endpoint.dart';

List<T> _applyProficiencyOverrides<T extends Object>({
  required Iterable<T> automatic,
  Iterable<T>? added,
  Iterable<T>? removed,
  required String Function(T value) sortKey,
}) {
  final values = automatic.toSet();
  values.removeAll(removed ?? const []);
  values.addAll(added ?? const []);
  final result = values.toList()
    ..sort((left, right) => sortKey(left).compareTo(sortKey(right)));
  return result;
}

List<String> _normalizedCustomValues(Iterable<String>? values) {
  final unique = <String, String>{};
  for (final value in values ?? const <String>[]) {
    final trimmed = value.trim();
    if (trimmed.isNotEmpty) {
      unique.putIfAbsent(trimmed.toLowerCase(), () => trimmed);
    }
  }
  return unique.values.toList()..sort();
}

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

    final spellKey = _normalizedTextOrNull(grant.spell?.referenceKey);
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

List<Language> _collectLanguages(
  CharacterData character,
  List<ChoiceOptionData> selectedOptions,
  List<ClassFeatureData> currentClassFeatures,
) {
  final values = <Language>{};
  values.addAll([
    for (final language in character.race?.languages ?? const <Language>[])
      language,
  ]);

  for (final option in selectedOptions) {
    values.addAll(option.grantedLanguages ?? const <Language>[]);
  }
  for (final feature in currentClassFeatures) {
    values.addAll(feature.grantedLanguages ?? const <Language>[]);
  }
  return values.toList()..sort((a, b) => a.name.compareTo(b.name));
}

List<String> _collectToolProficiencyKeys(
  CharacterData character,
  List<CharacterClassEntryData> entries,
  List<ChoiceOptionData> selectedOptions,
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
  for (final option in selectedOptions) {
    values.addAll(_normalizedTexts(option.grantedToolKeys));
  }
  return values.toList()..sort();
}

List<ArmorCategory> _collectArmorTraining(
  CharacterData character,
  List<CharacterClassEntryData> entries,
  List<ChoiceOptionData> selectedOptions,
) {
  final values = <ArmorCategory>{};
  values.addAll([
    for (final training
        in character.race?.armorProficiencies ?? const <ArmorCategory>[])
      training,
    for (final training
        in character.subrace?.armorProficiencies ?? const <ArmorCategory>[])
      training,
  ]);

  for (final entry in entries) {
    final classData = entry.classData;
    if (classData == null) continue;
    final source = (entry.isStartingClass ?? false)
        ? classData.armorTraining
        : classData.multiclassArmorTraining;
    values.addAll([
      ...?source,
    ]);
  }
  for (final option in selectedOptions) {
    values.addAll([
      for (final training
          in option.grantedArmorTraining ?? const <ArmorCategory>[])
        training,
    ]);
  }

  return values.toList()..sort((a, b) => a.name.compareTo(b.name));
}

List<WeaponCategory> _collectWeaponTraining(
  List<CharacterClassEntryData> entries,
  List<ChoiceOptionData> selectedOptions,
) {
  final values = <WeaponCategory>{};

  for (final entry in entries) {
    final classData = entry.classData;
    if (classData == null) continue;
    final source = (entry.isStartingClass ?? false)
        ? classData.weaponTraining
        : classData.multiclassWeaponTraining;
    values.addAll(weaponCategoriesFromTrainingValues(source));
  }
  for (final option in selectedOptions) {
    values.addAll(option.grantedWeaponTraining ?? const <WeaponCategory>[]);
  }

  return values.toList()..sort((a, b) => a.name.compareTo(b.name));
}

List<String> _collectWeaponProficiencyKeys(CharacterData character) {
  final values = <String>{
    ..._normalizedTexts(character.race?.weaponProficiencyKeys),
    ..._normalizedTexts(character.subrace?.weaponProficiencyKeys),
  };
  for (final entry in character.classEntries ?? const <CharacterClassEntryData>[]) {
    final classData = entry.classData;
    if (classData == null) continue;
    final source = (entry.isStartingClass ?? false)
        ? classData.weaponTraining
        : classData.multiclassWeaponTraining;
    values.addAll(weaponKeysFromTrainingValues(source));
  }
  return values.toList()..sort();
}

List<String> _collectGrantedSpellKeys(
  List<CharacterSpellSelectionData> spellSelections,
  List<ChoiceOptionData> selectedOptions,
  _CurrentRaceFeatures currentRaceFeatures,
  List<String> alwaysPreparedSpellKeys,
) {
  final values = <String>{};
  values.addAll(alwaysPreparedSpellKeys);
  for (final selection in spellSelections) {
    final spellKey = _normalizedTextOrNull(selection.spellKey) ??
        _normalizedTextOrNull(selection.spell?.referenceKey);
    if (spellKey != null) {
      values.add(spellKey);
    }
  }
  for (final option in selectedOptions) {
    values.addAll(_normalizedTexts(option.grantedSpellKeys));
  }
  for (final feature in [
    ...currentRaceFeatures.raceFeatures,
    ...currentRaceFeatures.subraceFeatures,
  ]) {
    for (final grant
        in feature.spellGrants ?? const <RaceFeatureSpellGrantData>[]) {
      final spellKey = _normalizedTextOrNull(grant.spell?.referenceKey);
      if (spellKey != null) {
        values.add(spellKey);
      }
    }
  }
  return values.toList()..sort();
}
