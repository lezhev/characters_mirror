part of '../offline_character_resolver.dart';

Future<List<CharacterFeatureViewData>> _activeFeatures(
  OfflineCacheDatabase cache,
  CharacterData character,
  int totalLevel,
  int proficiencyBonus,
  Map<Ability, int> abilityModifiers,
) async {
  final result = <CharacterFeatureViewData>[];
  final activeEffects = <({
    int sourceClassLevel,
    FeatureResourceEffectData effect,
  })>[];
  final resourceStatesByKey = {
    for (final state
        in character.resourceStates ?? const <CharacterResourceStateData>[])
      _featureResourceKey(state.sourceType, state.sourceId, state.resourceKey):
          state,
  };
  void addFeature({
    required CharacterFeatureSourceType sourceType,
    required int? sourceId,
    required String? sourceName,
    required int? level,
    required String? name,
    required String? description,
    required List<FeatureTag>? tags,
    required List<FeatureResourceDefinitionData>? resources,
    required List<FeatureResourceEffectData>? resourceEffects,
    required int sourceClassLevel,
  }) {
    if (sourceId == null) return;
    final override =
        (character.featureOverrides ?? const <CharacterFeatureOverrideData>[])
            .where(
              (item) =>
                  item.sourceType == sourceType && item.sourceId == sourceId,
            )
            .firstOrNull;
    final resolvedName = override?.name ?? name;
    final resolvedDescription = override?.description ?? description;
    final normalizedDefaultTags = _normalizedFeatureTags(tags);
    final resolvedTags = override?.tags == null
        ? normalizedDefaultTags
        : _normalizedFeatureTags(override!.tags);
    final isCustomized = override != null &&
        (_normalizedTextOrNull(resolvedName) != _normalizedTextOrNull(name) ||
            _normalizedTextOrNull(resolvedDescription) !=
                _normalizedTextOrNull(description) ||
            !_featureTagsMatch(resolvedTags, normalizedDefaultTags));
    activeEffects.addAll([
      for (final effect
          in resourceEffects ?? const <FeatureResourceEffectData>[])
        (sourceClassLevel: sourceClassLevel, effect: effect),
    ]);
    result.add(
      CharacterFeatureViewData(
        sourceType: sourceType,
        sourceId: sourceId,
        sourceName: sourceName,
        level: level,
        defaultName: name,
        defaultDescription: description,
        defaultTags: normalizedDefaultTags,
        name: resolvedName,
        description: resolvedDescription,
        tags: resolvedTags,
        isCustomized: isCustomized,
        resources: _resourceViews(
          defaultName: resolvedName,
          sourceType: sourceType,
          sourceId: sourceId,
          resources: resources,
          sourceClassLevel: sourceClassLevel,
          totalLevel: totalLevel,
          proficiencyBonus: proficiencyBonus,
          abilityModifiers: abilityModifiers,
          resourceStatesByKey: resourceStatesByKey,
        ),
      ),
    );
  }

  for (final feature in character.race?.features ?? const <RaceFeatureData>[]) {
    if ((feature.level ?? 1) > max(totalLevel, 1)) continue;
    addFeature(
      sourceType: CharacterFeatureSourceType.raceFeature,
      sourceId: feature.id,
      sourceName: character.race?.name,
      level: feature.level,
      name: feature.name,
      description: feature.shortDescription ?? feature.description,
      tags: feature.tags,
      resources: feature.resources,
      resourceEffects: feature.resourceEffects,
      sourceClassLevel: max(totalLevel, 1),
    );
  }
  for (final feature
      in character.subrace?.features ?? const <RaceFeatureData>[]) {
    if ((feature.level ?? 1) > max(totalLevel, 1)) continue;
    addFeature(
      sourceType: CharacterFeatureSourceType.subraceFeature,
      sourceId: feature.id,
      sourceName: character.subrace?.name,
      level: feature.level,
      name: feature.name,
      description: feature.shortDescription ?? feature.description,
      tags: feature.tags,
      resources: feature.resources,
      resourceEffects: feature.resourceEffects,
      sourceClassLevel: max(totalLevel, 1),
    );
  }
  for (final entry
      in character.classEntries ?? const <CharacterClassEntryData>[]) {
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
    for (final feature
        in stepView?.currentLevelFeatures ?? const <ClassFeatureData>[]) {
      addFeature(
        sourceType: CharacterFeatureSourceType.classFeature,
        sourceId: feature.id,
        sourceName: entry.classData?.name,
        level: feature.level,
        name: feature.name,
        description: feature.shortDescription ?? feature.description,
        tags: feature.tags,
        resources: feature.resources,
        resourceEffects: feature.resourceEffects,
        sourceClassLevel: entry.level ?? feature.level,
      );
    }
    for (final feature
        in stepView?.currentSubclassFeatures ?? const <SubclassFeatureData>[]) {
      addFeature(
        sourceType: CharacterFeatureSourceType.subclassFeature,
        sourceId: feature.id,
        sourceName: _subclassSourceName(entry.subclass),
        level: feature.level,
        name: feature.name,
        description: feature.shortDescription ?? feature.description,
        tags: feature.tags,
        resources: feature.resources,
        resourceEffects: feature.resourceEffects,
        sourceClassLevel: entry.level ?? feature.level,
      );
    }
  }

  final effective = _applyFeatureResourceEffects(
    result,
    activeEffects,
    totalLevel: totalLevel,
    proficiencyBonus: proficiencyBonus,
    abilityModifiers: abilityModifiers,
  );
  effective.sort((a, b) {
    final sourceCompare = _featureSourceOrder(a.sourceType)
        .compareTo(_featureSourceOrder(b.sourceType));
    if (sourceCompare != 0) return sourceCompare;
    final levelCompare = (a.level ?? 0).compareTo(b.level ?? 0);
    if (levelCompare != 0) return levelCompare;
    final nameCompare = (a.name ?? a.defaultName ?? '')
        .compareTo(b.name ?? b.defaultName ?? '');
    if (nameCompare != 0) return nameCompare;
    return a.sourceId.compareTo(b.sourceId);
  });
  return effective;
}

int _featureSourceOrder(CharacterFeatureSourceType sourceType) {
  switch (sourceType) {
    case CharacterFeatureSourceType.classFeature:
      return 0;
    case CharacterFeatureSourceType.subclassFeature:
      return 1;
    case CharacterFeatureSourceType.raceFeature:
      return 2;
    case CharacterFeatureSourceType.subraceFeature:
      return 3;
  }
}

List<FeatureTag>? _normalizedFeatureTags(List<FeatureTag>? values) {
  if (values == null) return null;
  final result = values.toSet().toList()
    ..sort((a, b) => a.name.compareTo(b.name));
  return result.isEmpty ? null : result;
}

bool _featureTagsMatch(List<FeatureTag>? left, List<FeatureTag>? right) {
  final a = left ?? const <FeatureTag>[];
  final b = right ?? const <FeatureTag>[];
  return a.length == b.length && a.toSet().containsAll(b);
}

List<CharacterFeatureViewData> _applyFeatureResourceEffects(
  List<CharacterFeatureViewData> features,
  List<({int sourceClassLevel, FeatureResourceEffectData effect})> effects, {
  required int totalLevel,
  required int proficiencyBonus,
  required Map<Ability, int> abilityModifiers,
}) {
  var result = features;
  for (final activeEffect in effects) {
    final effect = activeEffect.effect;
    if (effect.type != FeatureResourceEffectType.modify) continue;
    result = [
      for (final feature in result)
        feature.copyWith(
          resources: _modifiedFeatureResources(
            feature.resources,
            feature,
            effect,
            activeEffect.sourceClassLevel,
            totalLevel: totalLevel,
            proficiencyBonus: proficiencyBonus,
            abilityModifiers: abilityModifiers,
          ),
        ),
    ];
  }
  return result;
}

List<CharacterResourceViewData>? _modifiedFeatureResources(
  List<CharacterResourceViewData>? resources,
  CharacterFeatureViewData target,
  FeatureResourceEffectData effect,
  int sourceClassLevel, {
  required int totalLevel,
  required int proficiencyBonus,
  required Map<Ability, int> abilityModifiers,
}) {
  if (resources == null || resources.isEmpty) return resources;
  if (effect.targetType != null &&
      effect.targetType != FeatureResourceTargetType.featureResource) {
    return resources;
  }
  if (effect.targetSourceType != null &&
      effect.targetSourceType != target.sourceType) {
    return resources;
  }
  if (effect.targetSourceId != null &&
      effect.targetSourceId != target.sourceId) {
    return resources;
  }
  return [
    for (final resource in resources)
      if (effect.targetResourceKey == null ||
          effect.targetResourceKey == resource.key)
        _modifiedResource(
          resource,
          effect,
          sourceClassLevel,
          totalLevel: totalLevel,
          proficiencyBonus: proficiencyBonus,
          abilityModifiers: abilityModifiers,
        )
      else
        resource,
  ];
}

CharacterResourceViewData _modifiedResource(
  CharacterResourceViewData resource,
  FeatureResourceEffectData effect,
  int sourceClassLevel, {
  required int totalLevel,
  required int proficiencyBonus,
  required Map<Ability, int> abilityModifiers,
}) {
  final unlimitedAtLevel = effect.becomesUnlimitedAtLevel;
  final isUnlimited = effect.setUnlimited == true ||
      resource.isUnlimited == true ||
      (unlimitedAtLevel != null && sourceClassLevel >= unlimitedAtLevel);
  var maxValue = resource.max;
  if (!isUnlimited && effect.setMaxRule != null) {
    maxValue = _resourceMax(
      rule: effect.setMaxRule!,
      value: effect.setMaxValue,
      ability: effect.setMaxAbility,
      progressionValues: null,
      sourceClassLevel: sourceClassLevel,
      totalLevel: totalLevel,
      proficiencyBonus: proficiencyBonus,
      abilityModifiers: abilityModifiers,
    );
  }
  if (!isUnlimited && effect.addMaxValue != null) {
    maxValue += effect.addMaxValue!;
  }
  maxValue = max(maxValue, 0);
  return resource.copyWith(
    current: isUnlimited ? 0 : resource.current.clamp(0, maxValue).toInt(),
    max: isUnlimited ? 0 : maxValue,
    isUnlimited: isUnlimited ? true : null,
    resetOn: effect.setResetOn ?? resource.resetOn,
  );
}

List<CharacterResourceViewData>? _resourceViews({
  required String? defaultName,
  required CharacterFeatureSourceType sourceType,
  required int sourceId,
  required List<FeatureResourceDefinitionData>? resources,
  required int sourceClassLevel,
  required int totalLevel,
  required int proficiencyBonus,
  required Map<Ability, int> abilityModifiers,
  required Map<String, CharacterResourceStateData> resourceStatesByKey,
}) {
  if (resources == null || resources.isEmpty) return null;
  final result = <CharacterResourceViewData>[];
  final sortedResources = [...resources]
    ..sort((a, b) => a.key.compareTo(b.key));
  for (final resource in sortedResources) {
    final isUnlimited = _isResourceUnlimited(resource, sourceClassLevel);
    final maxValue = isUnlimited
        ? 0
        : _resourceMax(
            rule: resource.maxRule,
            value: resource.maxValue,
            ability: resource.maxAbility,
            progressionValues: resource.progressionValues,
            sourceClassLevel: sourceClassLevel,
            totalLevel: totalLevel,
            proficiencyBonus: proficiencyBonus,
            abilityModifiers: abilityModifiers,
          );
    if (!isUnlimited && maxValue <= 0) continue;
    final state = resourceStatesByKey[
        _featureResourceKey(sourceType, sourceId, resource.key)];
    result.add(
      CharacterResourceViewData(
        key: resource.key,
        name: resource.name ?? defaultName,
        kind: resource.kind,
        current: isUnlimited
            ? 0
            : (state?.current ?? maxValue).clamp(0, maxValue).toInt(),
        max: isUnlimited ? 0 : maxValue,
        isUnlimited: isUnlimited ? true : null,
        resetOn: resource.resetOn,
        usageResetOn: resource.usageResetOn,
        activationTrigger: resource.activationTrigger,
      ),
    );
  }
  return result.isEmpty ? null : result;
}

String? _subclassSourceName(SubclassData? subclass) {
  final parts = [
    _normalizedTextOrNull(subclass?.subclassName),
    _normalizedTextOrNull(subclass?.name),
  ].whereType<String>().toList();
  if (parts.isEmpty) {
    return null;
  }
  if (parts.length == 2 && parts[0] == parts[1]) {
    return parts[0];
  }
  return parts.join(' ');
}

int _resourceMax({
  required FeatureResourceMaxRule rule,
  required int? value,
  required Ability? ability,
  required List<FeatureResourceProgressionValueData>? progressionValues,
  required int sourceClassLevel,
  required int totalLevel,
  required int proficiencyBonus,
  required Map<Ability, int> abilityModifiers,
}) {
  final normalizedValue = max(value ?? 1, 1);
  final additiveValue = value ?? 0;
  switch (rule) {
    case FeatureResourceMaxRule.fixed:
      return normalizedValue;
    case FeatureResourceMaxRule.proficiencyBonus:
      return proficiencyBonus;
    case FeatureResourceMaxRule.abilityModifier:
      return (ability == null ? 0 : abilityModifiers[ability] ?? 0) +
          additiveValue;
    case FeatureResourceMaxRule.abilityModifierMinOne:
      return max(
        1,
        (ability == null ? 0 : abilityModifiers[ability] ?? 0) +
            additiveValue,
      );
    case FeatureResourceMaxRule.sourceClassLevel:
      return max(sourceClassLevel, 0);
    case FeatureResourceMaxRule.sourceClassLevelTimesValue:
      return max(sourceClassLevel, 0) * normalizedValue;
    case FeatureResourceMaxRule.totalLevel:
      return max(totalLevel, 0);
    case FeatureResourceMaxRule.totalLevelTimesValue:
      return max(totalLevel, 0) * normalizedValue;
    case FeatureResourceMaxRule.sourceClassLevelTable:
      final sortedValues = [...?progressionValues]
        ..sort((a, b) => a.level.compareTo(b.level));
      var resolved = 0;
      for (final item in sortedValues) {
        if (item.level <= sourceClassLevel) {
          resolved = item.value;
        }
      }
      return max(resolved, 0);
  }
}

bool _isResourceUnlimited(
  FeatureResourceDefinitionData resource,
  int sourceClassLevel,
) {
  final unlimitedAtLevel = resource.becomesUnlimitedAtLevel;
  return unlimitedAtLevel != null && sourceClassLevel >= unlimitedAtLevel;
}

String _featureResourceKey(
  CharacterFeatureSourceType sourceType,
  int sourceId,
  String resourceKey,
) {
  return '${sourceType.name}:$sourceId:$resourceKey';
}

Map<String, int> _hitDiceSummary(
  CharacterData character,
  List<CharacterClassEntryData> entries,
) {
  final result = <String, int>{};
  for (final entry in entries) {
    final hitDie = entry.classData?.hitDieValue;
    final level = entry.level ?? 0;
    if (hitDie == null || level <= 0) continue;
    final key = 'd$hitDie';
    result[key] = (result[key] ?? 0) + level;
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

int _maxHp(
  CharacterData character,
  List<CharacterClassEntryData> entries,
  int constitutionModifier,
) {
  var total = 0;
  var totalLevel = 0;
  final sortedEntries = [...entries]
    ..sort((a, b) => (a.classOrder ?? 0).compareTo(b.classOrder ?? 0));
  for (final entry in sortedEntries) {
    final level = max(0, entry.level ?? 0);
    final hitDie = max(1, entry.classData?.hitDieValue ?? 8);
    final fixedGain = max(1, (hitDie ~/ 2) + 1);
    final rolledValues = entry.hpRolledValues ?? const <int>[];
    for (var levelIndex = 0; levelIndex < level; levelIndex++) {
      totalLevel++;
      final defaultGain = totalLevel == 1 ? hitDie : fixedGain;
      final rawGain = levelIndex < rolledValues.length
          ? rolledValues[levelIndex]
          : defaultGain;
      total += rawGain.clamp(1, hitDie).toInt() + constitutionModifier;
    }
  }
  total += totalLevel * (character.hpPerLevelBonus ?? 0);
  total += character.hpFlatBonus ?? 0;
  return max(total, 1);
}

List<String> _uniqueStrings(Iterable<String> values) {
  return {
    for (final value in values)
      if (value.trim().isNotEmpty) value.trim(),
  }.toList()
    ..sort();
}

List<DamageType> _uniqueDamageTypes(Iterable<DamageType> values) {
  return {...values}.toList()..sort((a, b) => a.name.compareTo(b.name));
}

CharacterClassEntryData? _startingClassEntry(
  List<CharacterClassEntryData> entries,
) {
  for (final entry in entries) {
    if (entry.isStartingClass == true) return entry;
  }
  if (entries.isEmpty) return null;
  final sortedEntries = [...entries]
    ..sort((a, b) => (a.classOrder ?? 0).compareTo(b.classOrder ?? 0));
  return sortedEntries.first;
}
