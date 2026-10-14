part of '../offline_character_resolver.dart';

Future<int> _offlineFeatureModifierTotal(
  OfflineCacheDatabase cache,
  List<CharacterClassEntryData> entries,
  CharacterData character, {
  required int proficiencyBonus,
  required FeatureModifierTarget target,
  bool abilityCheckIncludesProficiency = false,
}) async {
  final allClassFeatures = await _currentClassFeatures(cache, entries);
  final allSubclassFeatures = await _currentSubclassFeatures(cache, entries);
  final suppressedKeys = await _offlineSuppressedFeatureKeys(
    cache,
    character,
    allClassFeatures,
    allSubclassFeatures,
  );
  final classFeatures = allClassFeatures
      .where((feature) =>
          !suppressedKeys.contains('classFeature:${feature.referenceKey}'))
      .toList();
  final subclassFeatures = allSubclassFeatures
      .where((feature) =>
          !suppressedKeys.contains('subclassFeature:${feature.referenceKey}'))
      .toList();
  final modifiers = await _offlineCurrentFeatureModifiers(
    cache,
    entries,
    classFeatures: classFeatures,
    subclassFeatures: subclassFeatures,
  );
  final input = feature_modifiers.characterFeatureModifierInput(
    character.toJson(),
    modifiers: modifiers.map((modifier) => modifier.toJson()),
    classFeatures: classFeatures.map((feature) => feature.toJson()),
    subclassFeatures: subclassFeatures.map((feature) => feature.toJson()),
    proficiencyBonus: proficiencyBonus,
    abilityCheckIncludesProficiency: abilityCheckIncludesProficiency,
  );
  final resolved = feature_modifiers.evaluateFeatureModifiers(
      modifiers: input.modifiers, context: input.context);
  return feature_modifiers.sumFeatureModifierValues(resolved)[
          feature_modifiers.FeatureModifierTarget.values.byName(target.name)] ??
      0;
}

Future<List<FeatureModifierData>> _offlineCurrentFeatureModifiers(
  OfflineCacheDatabase cache,
  List<CharacterClassEntryData> entries, {
  List<ClassFeatureData>? classFeatures,
  List<SubclassFeatureData>? subclassFeatures,
}) async {
  final filterFeatureModifiers =
      classFeatures != null || subclassFeatures != null;
  final activeIds = <int>{
    for (final feature in classFeatures ?? const <ClassFeatureData>[])
      if (feature.id != null) feature.id!,
    for (final feature in subclassFeatures ?? const <SubclassFeatureData>[])
      if (feature.id != null) feature.id!,
  };
  final byKey = <String, FeatureModifierData>{};
  for (final entry in entries) {
    final classId = entry.classData?.id;
    if (classId == null) continue;
    final view = await cache.getReference<ClassStepView>(
      offlineClassStepKind,
      offlineClassStepKey(
        classId,
        selectedLevel: entry.level ?? 0,
        selectedSubclassId: entry.subclass?.id,
      ),
      ClassStepView.fromJson,
    );
    for (final modifier
        in view?.featureModifiers ?? const <FeatureModifierData>[]) {
      if (filterFeatureModifiers &&
          modifier.classFeatureId != null &&
          !activeIds.contains(modifier.classFeatureId)) {
        continue;
      }
      if (filterFeatureModifiers &&
          modifier.subclassFeatureId != null &&
          !activeIds.contains(modifier.subclassFeatureId)) {
        continue;
      }
      byKey.putIfAbsent(modifier.referenceKey, () => modifier);
    }
  }
  final result = byKey.values.toList()
    ..sort((a, b) => a.referenceKey.compareTo(b.referenceKey));
  return result;
}

Future<Set<String>> _offlineSuppressedFeatureKeys(
  OfflineCacheDatabase cache,
  CharacterData character,
  List<ClassFeatureData> classFeatures,
  List<SubclassFeatureData> subclassFeatures,
) async {
  final acquired = <String>{
    for (final feature in classFeatures)
      if (feature.referenceKey != null) 'classFeature:${feature.referenceKey}',
    for (final feature in subclassFeatures)
      if (feature.referenceKey != null)
        'subclassFeature:${feature.referenceKey}',
    for (final feature in character.race?.features ?? const <RaceFeatureData>[])
      if (feature.referenceKey != null &&
          (feature.level ?? 1) <= _characterTotalLevel(character))
        'raceFeature:${feature.referenceKey}',
    for (final feature
        in character.subrace?.features ?? const <RaceFeatureData>[])
      if (feature.referenceKey != null &&
          (feature.level ?? 1) <= _characterTotalLevel(character))
        'subraceFeature:${feature.referenceKey}',
  };
  final relations = await cache.getReferenceList(
          'feature_relation', offlineAllKey, FeatureRelationData.fromJson) ??
      const <FeatureRelationData>[];
  return _offlineResolveSuppressedFeatureKeys(relations, acquired);
}

Set<String> _offlineResolveSuppressedFeatureKeys(
  List<FeatureRelationData> relations,
  Set<String> acquired,
) {
  final replacementsByTarget = <String, List<FeatureRelationData>>{};
  for (final relation in relations) {
    if (relation.relationType != FeatureRelationType.replaces) continue;
    final target = '${relation.targetType.name}:${relation.targetReferenceKey}';
    replacementsByTarget.putIfAbsent(target, () => []).add(relation);
  }
  final activeMemo = <String, bool>{};
  final visiting = <String>{};
  bool isActive(String feature) {
    final cached = activeMemo[feature];
    if (cached != null) return cached;
    if (!visiting.add(feature)) {
      throw StateError('Feature relations contain a cycle.');
    }
    final activeSources = (replacementsByTarget[feature] ?? const [])
        .where((relation) => isActive(
              '${relation.sourceType.name}:${relation.sourceReferenceKey}',
            ))
        .length;
    visiting.remove(feature);
    if (activeSources > 1 && acquired.contains(feature)) {
      throw StateError('Multiple active features replace $feature.');
    }
    final active = acquired.contains(feature) && activeSources == 0;
    activeMemo[feature] = active;
    return active;
  }

  final replaced = <String>{};
  for (final feature in acquired) {
    if (!isActive(feature)) replaced.add(feature);
  }
  return replaced;
}

int _characterTotalLevel(CharacterData character) => max(
      1,
      (character.classEntries ?? const <CharacterClassEntryData>[])
          .fold<int>(0, (sum, entry) => sum + (entry.level ?? 0)),
    );
