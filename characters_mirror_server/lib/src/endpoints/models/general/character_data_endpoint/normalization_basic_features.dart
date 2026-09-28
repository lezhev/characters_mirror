part of '../character_data_endpoint.dart';

String? _normalizedTextOrNull(String? value) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}

List<ConditionType>? _normalizedActiveConditions(List<ConditionType>? values) {
  final normalized = <ConditionType>[];
  for (final value in values ?? const <ConditionType>[]) {
    if (value == ConditionType.exhaustion || normalized.contains(value)) {
      continue;
    }
    normalized.add(value);
  }
  return normalized.isEmpty ? null : normalized;
}

int? _normalizedExhaustionLevel(int? value) {
  if (value == null || value <= 0) {
    return null;
  }
  return value.clamp(1, 6).toInt();
}

int? _normalizedDeathSaveCount(int? value) {
  final normalized = (value ?? 0).clamp(0, 3).toInt();
  return normalized == 0 ? null : normalized;
}

int? _zeroAsNull(int? value) {
  return value == null || value == 0 ? null : value;
}

int? _normalizedSpeed(int? value) {
  if (value == null) {
    return null;
  }
  return max(0, value);
}

Map<CharacterSpeedKind, int> _effectiveMovementSpeeds(
  CharacterData character,
) {
  final walking = _baseWalkingSpeed(character);
  return {
    CharacterSpeedKind.walking: character.walkingSpeed ?? walking,
    CharacterSpeedKind.swimming: character.swimmingSpeed ?? walking ~/ 2,
    CharacterSpeedKind.climbing: character.climbingSpeed ?? walking ~/ 2,
    CharacterSpeedKind.flying: character.flyingSpeed ?? 0,
  };
}

int _baseWalkingSpeed(CharacterData character) {
  return character.subrace?.speedOverride ?? character.race?.speed ?? 30;
}

int _displayedSpeed(
  CharacterSpeedKind? kind,
  Map<CharacterSpeedKind, int> movementSpeeds,
) {
  return movementSpeeds[kind ?? CharacterSpeedKind.walking] ??
      movementSpeeds[CharacterSpeedKind.walking] ??
      30;
}

Map<String, int>? _normalizedNonNegativeIntMap(Map<String, int>? values) {
  final result = <String, int>{};
  for (final entry
      in values?.entries ?? const Iterable<MapEntry<String, int>>.empty()) {
    final key = entry.key.trim();
    if (key.isEmpty) {
      continue;
    }
    result[key] = max(0, entry.value);
  }
  if (result.isEmpty) {
    return null;
  }
  final keys = result.keys.toList()..sort();
  return {
    for (final key in keys) key: result[key] ?? 0,
  };
}

Iterable<String> _normalizedTexts(Iterable<String>? values) sync* {
  for (final value in values ?? const <String>[]) {
    final normalized = _normalizedTextOrNull(value);
    if (normalized != null) {
      yield normalized;
    }
  }
}

List<String>? _normalizedPreparedSpellKeys(Iterable<String>? values) {
  if (values == null) {
    return null;
  }
  return _normalizedTexts(values).toSet().toList()..sort();
}

_CurrentRaceFeatures _currentRaceFeaturesBySource(
  CharacterData character,
  int totalLevel,
) {
  final characterLevel = max(totalLevel, 1);

  List<RaceFeatureData> filterCurrent(List<RaceFeatureData>? features) {
    return [
      for (final feature in features ?? const <RaceFeatureData>[])
        if ((feature.level ?? 1) <= characterLevel) feature,
    ];
  }

  return _CurrentRaceFeatures(
    raceFeatures: filterCurrent(character.race?.features),
    subraceFeatures: filterCurrent(character.subrace?.features),
  );
}

List<CharacterFeatureViewData> _buildActiveFeatures({
  required CharacterData character,
  required _ResolvedDerivedSources resolvedSources,
  required _CurrentRaceFeatures currentRaceFeatures,
  required int totalLevel,
  required int proficiencyBonus,
  required Map<Ability, int> abilityModifiers,
}) {
  final normalizedOverrides = _normalizedFeatureOverrides(
    character.featureOverrides,
  );
  final resourceStatesByKey = {
    for (final state in _normalizedResourceStates(character.resourceStates))
      _resourceStateKey(state.sourceType, state.sourceId, state.resourceKey):
          state,
  };
  final overridesByKey = {
    for (final override in normalizedOverrides)
      _featureOverrideKey(override.sourceType, override.sourceId): override,
  };
  final activeFeatures = <CharacterFeatureViewData>[];
  final activeEffects = <_ActiveFeatureResourceEffect>[];

  void addFeature({
    required CharacterFeatureSourceType sourceType,
    required int? sourceId,
    required String? sourceName,
    required int? level,
    required String? defaultName,
    required String? defaultDescription,
    required List<FeatureTag>? defaultTags,
    required List<FeatureResourceDefinitionData>? resources,
    required List<FeatureResourceEffectData>? resourceEffects,
    required int sourceClassLevel,
    List<FeatureDisplayPropertyData> displayPropertyDefinitions =
        const <FeatureDisplayPropertyData>[],
    List<String> selectedChoices = const <String>[],
  }) {
    if (sourceId == null) {
      return;
    }

    final override = overridesByKey[_featureOverrideKey(sourceType, sourceId)];
    final resolvedName = override?.name ?? defaultName;
    final resolvedDescription = override?.description ?? defaultDescription;
    final normalizedDefaultTags = _normalizedFeatureTags(
      defaultTags,
      preserveEmpty: false,
    );
    final resolvedTags = override?.tags != null
        ? _normalizedFeatureTags(override!.tags, preserveEmpty: true)
        : normalizedDefaultTags;
    final isCustomized = override != null &&
        (_normalizedTextOrNull(resolvedName) !=
                _normalizedTextOrNull(defaultName) ||
            _normalizedTextOrNull(resolvedDescription) !=
                _normalizedTextOrNull(defaultDescription) ||
            !_featureTagsEqual(
              resolvedTags,
              normalizedDefaultTags,
              preserveEmpty: false,
            ));
    final featureResources = _buildFeatureResources(
      defaultName: resolvedName,
      sourceType: sourceType,
      sourceId: sourceId,
      resourceDefinitions: resources,
      sourceClassLevel: sourceClassLevel,
      totalLevel: totalLevel,
      proficiencyBonus: proficiencyBonus,
      abilityModifiers: abilityModifiers,
      resourceStatesByKey: resourceStatesByKey,
    );
    activeEffects.addAll([
      for (final effect
          in resourceEffects ?? const <FeatureResourceEffectData>[])
        _ActiveFeatureResourceEffect(
          sourceType: sourceType,
          sourceId: sourceId,
          sourceClassLevel: sourceClassLevel,
          effect: effect,
        ),
    ]);

    activeFeatures.add(
      CharacterFeatureViewData(
        sourceType: sourceType,
        sourceId: sourceId,
        sourceName: sourceName,
        level: level,
        defaultName: defaultName,
        defaultDescription: defaultDescription,
        defaultTags: normalizedDefaultTags,
        name: resolvedName,
        description: resolvedDescription,
        tags: resolvedTags,
        isCustomized: isCustomized,
        resources: featureResources,
        selectedChoices: selectedChoices,
        displayProperties: resolveDisplayPropertyViews(
          definitions: displayPropertyDefinitions,
          sourceLevel: sourceClassLevel,
          characterLevel: totalLevel,
          subclassLevel: sourceClassLevel,
          abilityModifiers: {
            for (final entry in abilityModifiers.entries)
              entry.key.name: entry.value,
          },
        ),
      ),
    );
  }

  for (final feature in resolvedSources.currentClassFeatures) {
    final sourceClassLevel = character.classEntries
            ?.firstWhere(
              (entry) => entry.classData?.id == feature.parentClassId,
              orElse: CharacterClassEntryData.new,
            )
            .level ??
        feature.level;
    addFeature(
      sourceType: CharacterFeatureSourceType.classFeature,
      sourceId: feature.id,
      sourceName: character.classEntries
          ?.firstWhere(
            (entry) => entry.classData?.id == feature.parentClassId,
            orElse: CharacterClassEntryData.new,
          )
          .classData
          ?.name,
      level: feature.level,
      defaultName: feature.name,
      defaultDescription: feature.shortDescription ?? feature.description,
      defaultTags: feature.tags,
      resources: feature.resources,
      resourceEffects: feature.resourceEffects,
      sourceClassLevel: sourceClassLevel,
      displayPropertyDefinitions: resolvedSources.featureDisplayProperties
          .where((property) => property.sourceClassFeatureId == feature.id)
          .toList(),
      selectedChoices:
          resolvedSources.selectedChoicesByClassFeatureId[feature.id] ??
              const <String>[],
    );
  }
  for (final feature in resolvedSources.currentSubclassFeatures) {
    final classEntry = character.classEntries?.firstWhere(
      (entry) => entry.subclass?.id == feature.parentSubclassId,
      orElse: CharacterClassEntryData.new,
    );
    final sourceClassLevel = character.classEntries
            ?.firstWhere(
              (entry) => entry.subclass?.id == feature.parentSubclassId,
              orElse: CharacterClassEntryData.new,
            )
            .level ??
        feature.level;
    addFeature(
      sourceType: CharacterFeatureSourceType.subclassFeature,
      sourceId: feature.id,
      sourceName: _subclassSourceName(classEntry?.subclass),
      level: feature.level,
      defaultName: feature.name,
      defaultDescription: feature.shortDescription ?? feature.description,
      defaultTags: feature.tags,
      resources: feature.resources,
      resourceEffects: feature.resourceEffects,
      sourceClassLevel: sourceClassLevel,
      displayPropertyDefinitions: resolvedSources.featureDisplayProperties
          .where((property) => property.sourceSubclassFeatureId == feature.id)
          .toList(),
      selectedChoices:
          resolvedSources.selectedChoicesBySubclassFeatureId[feature.id] ??
              const <String>[],
    );
  }
  for (final feature in currentRaceFeatures.raceFeatures) {
    addFeature(
      sourceType: CharacterFeatureSourceType.raceFeature,
      sourceId: feature.id,
      sourceName: character.race?.name,
      level: feature.level,
      defaultName: feature.name,
      defaultDescription: feature.shortDescription ?? feature.description,
      defaultTags: feature.tags,
      resources: feature.resources,
      resourceEffects: feature.resourceEffects,
      sourceClassLevel: max(totalLevel, 1),
    );
  }
  for (final feature in currentRaceFeatures.subraceFeatures) {
    addFeature(
      sourceType: CharacterFeatureSourceType.subraceFeature,
      sourceId: feature.id,
      sourceName: character.subrace?.name,
      level: feature.level,
      defaultName: feature.name,
      defaultDescription: feature.shortDescription ?? feature.description,
      defaultTags: feature.tags,
      resources: feature.resources,
      resourceEffects: feature.resourceEffects,
      sourceClassLevel: max(totalLevel, 1),
    );
  }

  final modifiedFeatures = _applyFeatureResourceModifiers(
    activeFeatures,
    activeEffects,
    totalLevel: totalLevel,
    proficiencyBonus: proficiencyBonus,
    abilityModifiers: abilityModifiers,
  )..sort(_compareActiveFeatures);
  return modifiedFeatures;
}
