part of '../offline_character_resolver.dart';

Future<List<CharacterFeatureViewData>> _activeFeatures(
  OfflineCacheDatabase cache,
  CharacterData character,
  int totalLevel,
  int proficiencyBonus,
  Map<String, int> abilityModifiers,
) async {
  final result = <CharacterFeatureViewData>[];
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
    required int sourceClassLevel,
  }) {
    if (sourceId == null || (level ?? 1) > totalLevel) return;
    final override =
        (character.featureOverrides ?? const <CharacterFeatureOverrideData>[])
            .where(
              (item) =>
                  item.sourceType == sourceType && item.sourceId == sourceId,
            )
            .firstOrNull;
    final resolvedName = override?.name ?? name;
    result.add(
      CharacterFeatureViewData(
        sourceType: sourceType,
        sourceId: sourceId,
        sourceName: sourceName,
        level: level,
        defaultName: name,
        defaultDescription: description,
        defaultTags: tags,
        name: resolvedName,
        description: override?.description ?? description,
        tags: override?.tags ?? tags,
        isCustomized: override != null,
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
    addFeature(
      sourceType: CharacterFeatureSourceType.raceFeature,
      sourceId: feature.id,
      sourceName: character.race?.name,
      level: feature.level,
      name: feature.name,
      description: feature.shortDescription ?? feature.description,
      tags: feature.tags,
      resources: feature.resources,
      sourceClassLevel: totalLevel,
    );
  }
  for (final feature
      in character.subrace?.features ?? const <RaceFeatureData>[]) {
    addFeature(
      sourceType: CharacterFeatureSourceType.subraceFeature,
      sourceId: feature.id,
      sourceName: character.subrace?.name,
      level: feature.level,
      name: feature.name,
      description: feature.shortDescription ?? feature.description,
      tags: feature.tags,
      resources: feature.resources,
      sourceClassLevel: totalLevel,
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
        selectedLevel: entry.level ?? 1,
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
        sourceClassLevel: entry.level ?? feature.level,
      );
    }
  }

  result.sort((a, b) {
    final levelCompare = (a.level ?? 1).compareTo(b.level ?? 1);
    if (levelCompare != 0) return levelCompare;
    return (a.name ?? a.defaultName ?? '')
        .compareTo(b.name ?? b.defaultName ?? '');
  });
  return result;
}

List<CharacterResourceViewData>? _resourceViews({
  required String? defaultName,
  required CharacterFeatureSourceType sourceType,
  required int sourceId,
  required List<FeatureResourceDefinitionData>? resources,
  required int sourceClassLevel,
  required int totalLevel,
  required int proficiencyBonus,
  required Map<String, int> abilityModifiers,
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
  required Map<String, int> abilityModifiers,
}) {
  final normalizedValue = max(value ?? 1, 1);
  final additiveValue = value ?? 0;
  switch (rule) {
    case FeatureResourceMaxRule.fixed:
      return normalizedValue;
    case FeatureResourceMaxRule.proficiencyBonus:
      return proficiencyBonus;
    case FeatureResourceMaxRule.abilityModifier:
      return (ability == null ? 0 : abilityModifiers[ability.name] ?? 0) +
          additiveValue;
    case FeatureResourceMaxRule.abilityModifierMinOne:
      return max(
        1,
        (ability == null ? 0 : abilityModifiers[ability.name] ?? 0) +
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
    if (hitDie == null) continue;
    final key = 'd$hitDie';
    result[key] = (result[key] ?? 0) + (entry.level ?? 1);
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

List<FeatureTag> _featureTags(List<CharacterFeatureViewData> features) {
  return {
    for (final feature in features) ...?feature.tags,
  }.toList()
    ..sort((a, b) => a.name.compareTo(b.name));
}

String _senseLabel(SenseType type, int? range) {
  final suffix = range == null ? '' : ' $range';
  return '${type.name}$suffix';
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
