part of '../offline_character_resolver.dart';

Future<List<WeaponCategory>> _weaponTraining(
  OfflineCacheDatabase cache,
  CharacterData character,
  List<CharacterClassEntryData> entries,
) async {
  final values = <WeaponCategory>{
    for (final entry in entries)
      ...((entry.isStartingClass ?? false)
          ? entry.classData?.weaponTraining ?? const <WeaponCategory>[]
          : entry.classData?.multiclassWeaponTraining ??
              const <WeaponCategory>[]),
  };

  final selectedOptions = await _selectedClassBackgroundChoiceOptions(
    cache,
    character,
    entries,
  );
  for (final option in selectedOptions) {
    values.addAll(option.grantedWeaponTraining ?? const <WeaponCategory>[]);
  }

  return values.toList()..sort((a, b) => a.name.compareTo(b.name));
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
    for (final choice in character.choices ?? const <CharacterChoiceData>[])
      if (choice.selectedToolKey?.trim().isNotEmpty == true)
        choice.selectedToolKey!.trim(),
  };

  final selectedOptions = await _selectedClassBackgroundChoiceOptions(
    cache,
    character,
    entries,
  );
  for (final option in selectedOptions) {
    values.addAll(option.grantedToolKeys ?? const <String>[]);
  }

  return values.toList()..sort();
}

Future<List<ClassChoiceOptionData>> _selectedClassBackgroundChoiceOptions(
  OfflineCacheDatabase cache,
  CharacterData character,
  List<CharacterClassEntryData> entries,
) async {
  final groups = await cache.getReferenceList(
        'class_choice_group',
        offlineAllKey,
        ClassChoiceGroupData.fromJson,
      ) ??
      const <ClassChoiceGroupData>[];
  final options = await cache.getReferenceList(
        'class_choice_option',
        offlineAllKey,
        ClassChoiceOptionData.fromJson,
      ) ??
      const <ClassChoiceOptionData>[];
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
  final groupsByKey = {
    for (final group in groups)
      if (_isSupportedClassBackgroundChoiceGroup(
        group,
        character,
        entries,
        classFeatures,
        subclassFeatures,
      ))
        _classChoiceGroupKey(group): group,
  };
  final optionsByGroupId = <int, Map<String, ClassChoiceOptionData>>{};
  for (final option in options) {
    final groupId = option.choiceGroupId;
    final optionKey = option.optionKey?.trim();
    if (optionKey == null || optionKey.isEmpty) continue;
    optionsByGroupId.putIfAbsent(groupId, () => {})[optionKey] = option;
  }

  final selected = <ClassChoiceOptionData>[];
  for (final choice in character.choices ?? const <CharacterChoiceData>[]) {
    if (!_isClassOrBackgroundChoice(choice.sourceType)) continue;
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

bool _isSupportedClassBackgroundChoiceGroup(
  ClassChoiceGroupData group,
  CharacterData character,
  List<CharacterClassEntryData> entries,
  List<ClassFeatureData> classFeatures,
  List<SubclassFeatureData> subclassFeatures,
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
                (entry.level ?? 0) >= feature.level,
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
                (entry.level ?? 0) >= feature.level,
          ),
    );
  }
  return group.sourceBackgroundId != null &&
      group.sourceBackgroundId == character.background?.id;
}

bool _isClassOrBackgroundChoice(ChoiceSourceType? sourceType) {
  switch (sourceType) {
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
  final exclusiveKey = group.exclusiveKey?.trim();
  if (exclusiveKey != null && exclusiveKey.isNotEmpty) return exclusiveKey;
  return 'group_${group.id ?? group.name ?? group.type?.name ?? 'unknown'}';
}
