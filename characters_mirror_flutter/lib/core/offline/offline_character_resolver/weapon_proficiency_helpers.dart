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
    final candidates = stepView?.currentLevelFeatures ??
        await cache.getReferenceList(
            'class_feature', offlineAllKey, ClassFeatureData.fromJson) ??
        const <ClassFeatureData>[];
    features.addAll(candidates.where((feature) =>
        feature.parentClassId == classId &&
        feature.level <= (entry.level ?? 0)));
  }
  return features;
}

Future<List<SubclassFeatureData>> _currentSubclassFeatures(
  OfflineCacheDatabase cache,
  List<CharacterClassEntryData> entries,
) async {
  final features = <SubclassFeatureData>[];
  for (final entry in entries) {
    final subclass = entry.subclass;
    final classId = entry.classData?.id;
    if (classId == null ||
        subclass?.id == null ||
        subclass!.parentClassId != classId ||
        (entry.level ?? 0) < (subclass.levelRequired ?? 1)) {
      continue;
    }
    final view = await cache.getReference<ClassStepView>(
      offlineClassStepKind,
      offlineClassStepKey(classId,
          selectedLevel: entry.level ?? 0, selectedSubclassId: subclass.id),
      ClassStepView.fromJson,
    );
    final candidates = view?.currentSubclassFeatures ??
        await cache.getReferenceList(
            'subclass_feature', offlineAllKey, SubclassFeatureData.fromJson) ??
        const <SubclassFeatureData>[];
    features.addAll(candidates.where((feature) =>
        feature.parentSubclassId == subclass.id &&
        feature.level <= (entry.level ?? 0)));
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
  List<CharacterClassEntryData> entries, {
  List<CharacterChoiceData>? automaticChoices,
}) async {
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
    final classSourced = group!.sourceClassId != null ||
        group.sourceSubclassId != null ||
        group.sourceFeatureId != null ||
        group.sourceSubclassFeatureId != null;
    if (!classSourced) {
      if (choice.classEntry != null) {
        throw StateError('Non-class choice $groupKey has a class entry.');
      }
    } else {
      final sourceClassId = group.sourceClassId ??
          classFeatures
              .where((feature) => feature.id == group.sourceFeatureId)
              .firstOrNull
              ?.parentClassId;
      final sourceSubclassId = group.sourceSubclassId ??
          subclassFeatures
              .where((feature) => feature.id == group.sourceSubclassFeatureId)
              .firstOrNull
              ?.parentSubclassId;
      final matchingEntries = entries
          .where((entry) =>
              (sourceClassId == null || entry.classData?.id == sourceClassId) &&
              (sourceSubclassId == null ||
                  entry.subclass?.id == sourceSubclassId))
          .toList();
      final boundId = choice.classEntry?.id;
      if (matchingEntries.isEmpty ||
          boundId == null && matchingEntries.length > 1 ||
          boundId != null &&
              matchingEntries.where((e) => e.id == boundId).length != 1) {
        throw StateError('Choice $groupKey is bound to the wrong class entry.');
      }
    }
    var option = optionsByGroupId[groupId]?[optionKey];
    if (option == null && choice.replacementHistory?.isNotEmpty == true) {
      final resolved = feature_modifiers.resolveProgressionChoiceOption(
          choice.toJson(),
          groupsByKey.values.map((g) => g.toJson()),
          options.map((o) => o.toJson()));
      if (resolved != null) option = ChoiceOptionData.fromJson(resolved);
    }
    if (option != null) selected.add(option);
  }
  final selectionsByGroup = <String, List<ChoiceOptionData>>{};
  final selectedKeysByGroup = <String, List<String>>{};
  for (final choice in character.choices ?? const <CharacterChoiceData>[]) {
    final groupKey = choice.groupKey;
    final optionKey = choice.optionKey;
    final group = groupsByKey[groupKey];
    final option =
        group == null ? null : optionsByGroupId[group.id]?[optionKey?.trim()];
    if (groupKey == null || option == null) continue;
    selectionsByGroup.putIfAbsent(groupKey, () => []).add(option);
    selectedKeysByGroup.putIfAbsent(groupKey, () => []).add(option.optionKey);
  }
  final activeClassFeatures = await _currentClassFeatures(cache, entries);
  final activeSubclassFeatures = await _currentSubclassFeatures(cache, entries);
  for (final group in groupsByKey.values) {
    final selected = selectionsByGroup[group.referenceKey] ?? const [];
    final keys = selectedKeysByGroup[group.referenceKey] ?? const [];
    final context = conditionalChoiceContext(
      character: character,
      group: group,
      options: optionsByGroupId[group.id]?.values ?? const [],
      otherOptions: [
        for (final entry in selectionsByGroup.entries)
          if (entry.key != group.referenceKey) ...entry.value,
      ],
      selectedOptionsByGroupKey: selectionsByGroup,
      classFeatures: activeClassFeatures,
      subclassFeatures: activeSubclassFeatures,
    );
    final groupEligible = feature_modifiers
        .choiceRequirementsEligibilityFromProtocol(
          (group.requirements ?? const <ChoiceRequirementData>[])
              .map((requirement) => requirement.toJson()),
          context,
        )
        .isEligible;
    if (!groupEligible && selected.isNotEmpty) {
      throw StateError('Choice group ${group.referenceKey} is unavailable.');
    }
    if (groupEligible && (group.requirements?.isNotEmpty ?? false)) {
      final minimum = group.minimumSelectionCount ?? group.selectionCount ?? 1;
      if (selected.length < minimum) {
        throw StateError(
            'Choice group ${group.referenceKey} requires $minimum selections.');
      }
    }
    final maximum = group.selectionCount ?? 1;
    final indices = (character.choices ?? const <CharacterChoiceData>[])
        .where((choice) => choice.groupKey == group.referenceKey)
        .map((choice) => choice.selectionIndex)
        .whereType<int>()
        .toList();
    if (selected.length > maximum ||
        group.allowDuplicates != true && keys.toSet().length != keys.length ||
        indices.toSet().length != indices.length) {
      throw StateError(
          'Choice group ${group.referenceKey} has invalid selections.');
    }
  }
  if (!groupsByKey.values.any((g) => g.autoSelectSingleEligible == true)) {
    return selected;
  }
  final spells = await cache.getReferenceList(
          'spell', offlineAllKey, SpellData.fromJson) ??
      [];
  final grants = await cache.getReferenceList(
          'class_spell_grant', offlineAllKey, ClassSpellGrantData.fromJson) ??
      [];
  for (final group in groupsByKey.values) {
    if (group.autoSelectSingleEligible != true ||
        (character.choices?.any((c) => c.groupKey == group.referenceKey) ??
            false)) {
      continue;
    }
    final groupOptions =
        optionsByGroupId[group.id]?.values ?? <ChoiceOptionData>[];
    final otherOptions =
        selected.where((o) => o.choiceGroupId != group.id).toList();
    final otherSpells = feature_modifiers.resolveCharacterSpellCollection(
      character: character.copyWith(derived: null).toJson(),
      spells: spells.map((s) => s.toJson()),
      classGrants: grants
          .where((g) =>
              (group.sourceFeatureId == null ||
                  g.sourceFeatureId != group.sourceFeatureId) &&
              (group.sourceSubclassFeatureId == null ||
                  g.sourceSubclassFeatureId != group.sourceSubclassFeatureId))
          .map((g) => g.toJson()),
      classFeatures: activeClassFeatures
          .where((f) => f.id != group.sourceFeatureId)
          .map((f) => f.toJson()),
      subclassFeatures: activeSubclassFeatures
          .where((f) => f.id != group.sourceSubclassFeatureId)
          .map((f) => f.toJson()),
      selectedOptions: otherOptions.map((o) => o.toJson()),
      choiceGroups: groups.map((g) => g.toJson()),
    );
    final context = conditionalChoiceContext(
      character: character,
      group: group,
      options: groupOptions,
      otherOptions: otherOptions,
      classFeatures: activeClassFeatures,
      subclassFeatures: activeSubclassFeatures,
      otherGrantedCantripKeys: otherSpells
          .where((s) => s.spell['level'] == 0)
          .map((s) => s.spellKey),
    );
    final key = feature_modifiers.automaticChoiceOptionKey(
        groupOptions.map((o) => o.toJson()), context);
    if (key == null) continue;
    selected.add(groupOptions.firstWhere((o) => o.optionKey == key));
    final parentClassId = activeClassFeatures
        .where((f) => f.id == group.sourceFeatureId)
        .firstOrNull
        ?.parentClassId;
    final parentSubclassId = activeSubclassFeatures
        .where((f) => f.id == group.sourceSubclassFeatureId)
        .firstOrNull
        ?.parentSubclassId;
    final entry = entries
        .where((e) =>
            (group.sourceClassId != null &&
                e.classData?.id == group.sourceClassId) ||
            (group.sourceSubclassId != null &&
                e.subclass?.id == group.sourceSubclassId) ||
            (parentClassId != null && e.classData?.id == parentClassId) ||
            (parentSubclassId != null && e.subclass?.id == parentSubclassId))
        .firstOrNull;
    automaticChoices?.add(CharacterChoiceData(
        id: const Uuid().v4(),
        groupKey: group.referenceKey,
        optionKey: key,
        selectionIndex: 0,
        classEntry: entry));
  }
  return selected;
}

Future<CharacterData> _pruneInactiveConditionalChoices(
  OfflineCacheDatabase cache,
  CharacterData character,
) async {
  final groups = await cache.getReferenceList(
        'choice_group',
        offlineAllKey,
        ChoiceGroupData.fromJson,
      ) ??
      const <ChoiceGroupData>[];
  final conditionalGroups =
      groups.where((group) => group.requirements?.isNotEmpty == true).toList();
  if (conditionalGroups.isEmpty) return character;
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
  final entries = character.classEntries ?? const <CharacterClassEntryData>[];
  final totalLevel =
      entries.fold<int>(0, (sum, entry) => sum + (entry.level ?? 0));
  final raceFeatureIds = {
    for (final feature in [
      ...?character.race?.features,
      ...?character.subrace?.features,
    ])
      if ((feature.level ?? 1) <= max(totalLevel, 1)) feature.id,
  };
  final optionsByGroupId = <int, Map<String, ChoiceOptionData>>{};
  for (final option in options) {
    optionsByGroupId.putIfAbsent(
        option.choiceGroupId, () => {})[option.optionKey] = option;
  }
  final availableGroups = {
    for (final group in groups)
      if (_isChoiceGroupAvailable(group, character, entries, classFeatures,
          subclassFeatures, raceFeatureIds))
        group.referenceKey: group,
  };
  final selectedByGroup = <String, List<ChoiceOptionData>>{};
  for (final choice in character.choices ?? const <CharacterChoiceData>[]) {
    final group = availableGroups[choice.groupKey];
    final option = group == null
        ? null
        : optionsByGroupId[group.id]?[choice.optionKey?.trim()];
    if (choice.groupKey != null && option != null) {
      selectedByGroup.putIfAbsent(choice.groupKey!, () => []).add(option);
    }
  }
  final activeClassFeatures = await _currentClassFeatures(cache, entries);
  final activeSubclassFeatures = await _currentSubclassFeatures(cache, entries);
  final inactive = <String>{};
  for (final group in conditionalGroups) {
    if (!availableGroups.containsKey(group.referenceKey)) continue;
    for (final data in group.requirements!) {
      if (!feature_modifiers.choiceRequirementIsWellFormed(
          feature_modifiers.choiceRequirementFromProtocol(data.toJson()))) {
        throw StateError(
            'Choice group ${group.referenceKey} has invalid requirements.');
      }
    }
    final context = conditionalChoiceContext(
      character: character,
      group: group,
      options: optionsByGroupId[group.id]?.values ?? const [],
      otherOptions: [
        for (final entry in selectedByGroup.entries)
          if (entry.key != group.referenceKey) ...entry.value,
      ],
      selectedOptionsByGroupKey: selectedByGroup,
      classFeatures: activeClassFeatures,
      subclassFeatures: activeSubclassFeatures,
    );
    if (!feature_modifiers
        .choiceRequirementsEligibilityFromProtocol(
          group.requirements!.map((requirement) => requirement.toJson()),
          context,
        )
        .isEligible) {
      inactive.add(group.referenceKey);
    }
  }
  if (inactive.isEmpty) return character;
  return character.copyWith(choices: [
    for (final choice in character.choices ?? const <CharacterChoiceData>[])
      if (!inactive.contains(choice.groupKey)) choice,
  ]);
}

Future<CharacterData> _materializeOfflineAutomaticChoices(
    OfflineCacheDatabase cache, CharacterData character) async {
  final automatic = <CharacterChoiceData>[];
  await _selectedChoiceOptions(cache, character, character.classEntries ?? [],
      automaticChoices: automatic);
  return automatic.isEmpty
      ? character
      : character.copyWith(choices: [...?character.choices, ...automatic]);
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
