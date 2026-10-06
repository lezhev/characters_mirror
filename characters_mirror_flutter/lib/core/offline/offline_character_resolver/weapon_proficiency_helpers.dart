part of '../offline_character_resolver.dart';

List<T> _effectiveProficiencyValues<T extends Object>(
  Iterable<T> automatic,
  Iterable<T>? added,
  Iterable<T>? removed,
  String Function(T value) sortKey,
) {
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

List<Language> _languages(
  CharacterData character,
  List<ChoiceOptionData> options,
  List<ClassFeatureData> currentClassFeatures,
) {
  final values = <Language>{...?character.race?.languages};
  for (final option in options) {
    values.addAll(option.grantedLanguages ?? const <Language>[]);
  }
  for (final feature in currentClassFeatures) {
    values.addAll(feature.grantedLanguages ?? const <Language>[]);
  }
  return values.toList()
    ..sort((left, right) => left.name.compareTo(right.name));
}

Future<List<ClassFeatureData>> _currentClassFeatures(
  OfflineCacheDatabase cache,
  List<CharacterClassEntryData> entries,
) async {
  final features = <ClassFeatureData>[];
  for (final entry in entries) {
    final classId = entry.classData?.id;
    if (classId == null) continue;
    final stepView = await cache.getReference<ClassStepView>(
      offlineClassStepKind,
      offlineClassStepKey(
        classId,
        selectedLevel: entry.level ?? 0,
        selectedSubclassId: entry.subclass?.id,
      ),
      ClassStepView.fromJson,
    );
    features.addAll(stepView?.currentLevelFeatures ?? const <ClassFeatureData>[]);
  }
  return features;
}

Future<List<ArmorCategory>> _armorTraining(
  OfflineCacheDatabase cache,
  CharacterData character,
  List<CharacterClassEntryData> entries,
) async {
  final values = <ArmorCategory>{
    ...?character.race?.armorProficiencies,
    ...?character.subrace?.armorProficiencies,
    for (final entry in entries)
      ...((entry.isStartingClass ?? false)
          ? entry.classData?.armorTraining ?? const <ArmorCategory>[]
          : entry.classData?.multiclassArmorTraining ??
              const <ArmorCategory>[]),
  };
  final options = await _selectedChoiceOptions(
    cache,
    character,
    entries,
  );
  for (final option in options) {
    values.addAll(option.grantedArmorTraining ?? const <ArmorCategory>[]);
  }
  return values.toList()
    ..sort((left, right) => left.name.compareTo(right.name));
}

Future<List<WeaponCategory>> _weaponTraining(
  OfflineCacheDatabase cache,
  CharacterData character,
  List<CharacterClassEntryData> entries,
) async {
  final values = <WeaponCategory>{
    for (final entry in entries)
      ..._weaponCategoriesFromTrainingValues(
        (entry.isStartingClass ?? false)
            ? entry.classData?.weaponTraining
            : entry.classData?.multiclassWeaponTraining,
      ),
  };

  final selectedOptions = await _selectedChoiceOptions(
    cache,
    character,
    entries,
  );
  for (final option in selectedOptions) {
    values.addAll(option.grantedWeaponTraining ?? const <WeaponCategory>[]);
  }

  return values.toList()..sort((a, b) => a.name.compareTo(b.name));
}

List<WeaponCategory> _weaponCategoriesFromTrainingValues(
  Iterable<String>? values,
) {
  return [
    for (final value in values ?? const <String>[])
      for (final category in WeaponCategory.values)
        if (category.name == value) category,
  ];
}

List<String> _weaponKeysFromTrainingValues(Iterable<String>? values) {
  return [
    for (final value in values ?? const <String>[])
      if (!WeaponCategory.values.any((category) => category.name == value))
        value,
  ];
}

Future<List<String>> _toolProficiencyKeys(
  OfflineCacheDatabase cache,
  CharacterData character,
  List<CharacterClassEntryData> entries,
) async {
  final values = <String>{
    ...?character.race?.toolProficiencyKeys,
    ...?character.subrace?.toolProficiencyKeys,
    ...?character.background?.toolProficiencyKeys,
    for (final entry in entries)
      ...((entry.isStartingClass ?? false)
          ? entry.classData?.toolTrainingKeys ?? const <String>[]
          : entry.classData?.multiclassToolTrainingKeys ?? const <String>[]),
  };

  final selectedOptions = await _selectedChoiceOptions(
    cache,
    character,
    entries,
  );
  for (final option in selectedOptions) {
    values.addAll(option.grantedToolKeys ?? const <String>[]);
  }

  return values.toList()..sort();
}

Future<List<ChoiceOptionData>> _selectedChoiceOptions(
  OfflineCacheDatabase cache,
  CharacterData character,
  List<CharacterClassEntryData> entries,
) async {
  final groups = await cache.getReferenceList(
        'choice_group',
        offlineAllKey,
        ChoiceGroupData.fromJson,
      ) ??
      const <ChoiceGroupData>[];
  final options = await cache.getReferenceList(
        'choice_option',
        offlineAllKey,
        ChoiceOptionData.fromJson,
      ) ??
      const <ChoiceOptionData>[];
  final classFeatures = await cache.getReferenceList(
        'class_feature',
        offlineAllKey,
        ClassFeatureData.fromJson,
      ) ??
      const <ClassFeatureData>[];
  final subclassFeatures = await cache.getReferenceList(
        'subclass_feature',
        offlineAllKey,
        SubclassFeatureData.fromJson,
      ) ??
      const <SubclassFeatureData>[];
  final totalLevel =
      entries.fold<int>(0, (sum, entry) => sum + (entry.level ?? 0));
  final raceFeatureIds = {
    for (final feature in [
      ...?character.race?.features,
      ...?character.subrace?.features,
    ])
      if ((feature.level ?? 1) <= max(totalLevel, 1)) feature.id,
  };
  final groupsByKey = {
    for (final group in groups)
      if (_isChoiceGroupAvailable(
        group,
        character,
        entries,
        classFeatures,
        subclassFeatures,
        raceFeatureIds,
      ))
        group.referenceKey: group,
  };
  final optionsByGroupId = <int, Map<String, ChoiceOptionData>>{};
  for (final option in options) {
    final groupId = option.choiceGroupId;
    final optionKey = option.optionKey.trim();
    if (optionKey.isEmpty) continue;
    optionsByGroupId.putIfAbsent(groupId, () => {})[optionKey] = option;
  }

  final selected = <ChoiceOptionData>[];
  for (final choice in character.choices ?? const <CharacterChoiceData>[]) {
    final groupKey = choice.groupKey?.trim();
    final optionKey = choice.optionKey?.trim();
    if (groupKey == null ||
        groupKey.isEmpty ||
        optionKey == null ||
        optionKey.isEmpty) {
      continue;
    }
    final group = groupsByKey[groupKey];
    final groupId = group?.id;
    if (groupId == null) continue;
    final option = optionsByGroupId[groupId]?[optionKey];
    if (option != null) selected.add(option);
  }
  return selected;
}

bool _isChoiceGroupAvailable(
  ChoiceGroupData group,
  CharacterData character,
  List<CharacterClassEntryData> entries,
  List<ClassFeatureData> classFeatures,
  List<SubclassFeatureData> subclassFeatures,
  Set<int?> raceFeatureIds,
) {
  final requiredLevel = group.level ?? 1;
  final sourceClassId = group.sourceClassId;
  if (sourceClassId != null) {
    return entries.any(
      (entry) =>
          entry.classData?.id == sourceClassId &&
          (entry.level ?? 0) >= requiredLevel,
    );
  }
  final sourceSubclassId = group.sourceSubclassId;
  if (sourceSubclassId != null) {
    return entries.any(
      (entry) =>
          entry.subclass?.id == sourceSubclassId &&
          (entry.level ?? 0) >= requiredLevel,
    );
  }
  final sourceFeatureId = group.sourceFeatureId;
  if (sourceFeatureId != null) {
    return classFeatures.any(
      (feature) =>
          feature.id == sourceFeatureId &&
          entries.any(
            (entry) =>
                entry.classData?.id == feature.parentClassId &&
                (entry.level ?? 0) >= max(feature.level, requiredLevel),
          ),
    );
  }
  final sourceSubclassFeatureId = group.sourceSubclassFeatureId;
  if (sourceSubclassFeatureId != null) {
    return subclassFeatures.any(
      (feature) =>
          feature.id == sourceSubclassFeatureId &&
          entries.any(
            (entry) =>
                entry.subclass?.id == feature.parentSubclassId &&
                (entry.level ?? 0) >= max(feature.level, requiredLevel),
          ),
    );
  }
  final sourceRaceId = group.sourceRaceId;
  if (sourceRaceId != null) return sourceRaceId == character.race?.id;
  final sourceSubraceId = group.sourceSubraceId;
  if (sourceSubraceId != null) return sourceSubraceId == character.subrace?.id;
  final sourceRaceFeatureId = group.sourceRaceFeatureId;
  if (sourceRaceFeatureId != null) {
    return raceFeatureIds.contains(sourceRaceFeatureId);
  }
  final sourceBackgroundId = group.sourceBackgroundId;
  return sourceBackgroundId != null &&
      sourceBackgroundId == character.background?.id;
}
