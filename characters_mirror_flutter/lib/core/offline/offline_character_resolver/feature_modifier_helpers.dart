part of '../offline_character_resolver.dart';

Future<int> _offlineFeatureModifierTotal(
  OfflineCacheDatabase cache,
  List<CharacterClassEntryData> entries,
  CharacterData character, {
  required int proficiencyBonus,
  required FeatureModifierTarget target,
  bool abilityCheckIncludesProficiency = false,
}) async {
  final modifiers = await _offlineCurrentFeatureModifiers(cache, entries);
  final classFeatures = await _currentClassFeatures(cache, entries);
  final subclassFeatures = await _currentSubclassFeatures(cache, entries);
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
  List<CharacterClassEntryData> entries,
) async {
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
      byKey.putIfAbsent(modifier.referenceKey, () => modifier);
    }
  }
  final result = byKey.values.toList()
    ..sort((a, b) => a.referenceKey.compareTo(b.referenceKey));
  return result;
}
