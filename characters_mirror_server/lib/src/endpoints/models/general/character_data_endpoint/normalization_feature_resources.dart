part of '../character_data_endpoint.dart';

List<CharacterResourceViewData>? _buildFeatureResources({
  required String? defaultName,
  required CharacterFeatureSourceType sourceType,
  required int sourceId,
  required List<FeatureResourceDefinitionData>? resourceDefinitions,
  required int sourceClassLevel,
  required int totalLevel,
  required int proficiencyBonus,
  required Map<Ability, int> abilityModifiers,
  required Map<String, CharacterResourceStateData> resourceStatesByKey,
}) {
  if (resourceDefinitions == null || resourceDefinitions.isEmpty) {
    return null;
  }

  final resources = <CharacterResourceViewData>[];
  final sortedDefinitions = [...resourceDefinitions]
    ..sort((a, b) => a.key.compareTo(b.key));
  for (final definition in sortedDefinitions) {
    final resource = _buildFeatureResource(
      defaultName: defaultName,
      sourceType: sourceType,
      sourceId: sourceId,
      definition: definition,
      sourceClassLevel: sourceClassLevel,
      totalLevel: totalLevel,
      proficiencyBonus: proficiencyBonus,
      abilityModifiers: abilityModifiers,
      resourceStatesByKey: resourceStatesByKey,
    );
    if (resource != null) {
      resources.add(resource);
    }
  }
  return resources.isEmpty ? null : resources;
}

CharacterResourceViewData? _buildFeatureResource({
  required String? defaultName,
  required CharacterFeatureSourceType sourceType,
  required int sourceId,
  required FeatureResourceDefinitionData definition,
  required int sourceClassLevel,
  required int totalLevel,
  required int proficiencyBonus,
  required Map<Ability, int> abilityModifiers,
  required Map<String, CharacterResourceStateData> resourceStatesByKey,
}) {
  if (definition.maxRule == FeatureResourceMaxRule.special) {
    return null;
  }
  final isUnlimited = _isResourceUnlimited(definition, sourceClassLevel);
  final maxValue = isUnlimited
      ? 0
      : _featureResourceMax(
          rule: definition.maxRule,
          value: definition.maxValue,
          ability: definition.maxAbility,
          progressionValues: definition.progressionValues,
          sourceClassLevel: sourceClassLevel,
          totalLevel: totalLevel,
          proficiencyBonus: proficiencyBonus,
          abilityModifiers: abilityModifiers,
        );
  if (maxValue == null) {
    return null;
  }
  if (!isUnlimited && maxValue <= 0) {
    return null;
  }

  final state = resourceStatesByKey[
      _resourceStateKey(sourceType, sourceId, definition.key)];
  final current =
      isUnlimited ? 0 : (state?.current ?? maxValue).clamp(0, maxValue).toInt();
  return CharacterResourceViewData(
    key: definition.key,
    name: definition.name ?? defaultName,
    kind: definition.kind,
    current: current,
    max: maxValue,
    isUnlimited: isUnlimited ? true : null,
    resetOn: definition.resetOn,
    usageResetOn: definition.usageResetOn,
    activationTrigger: definition.activationTrigger,
  );
}

int? _featureResourceMax({
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
      return _featureResourceTableMax(progressionValues, sourceClassLevel);
    case FeatureResourceMaxRule.special:
      return null;
  }
}

int _featureResourceTableMax(
  List<FeatureResourceProgressionValueData>? values,
  int sourceClassLevel,
) {
  final sortedValues = [...?values]..sort((a, b) => a.level.compareTo(b.level));
  var resolved = 0;
  for (final value in sortedValues) {
    if (value.level <= sourceClassLevel) {
      resolved = value.value;
    }
  }
  return max(resolved, 0);
}

bool _isResourceUnlimited(
  FeatureResourceDefinitionData definition,
  int sourceClassLevel,
) {
  final unlimitedAtLevel = definition.becomesUnlimitedAtLevel;
  return unlimitedAtLevel != null && sourceClassLevel >= unlimitedAtLevel;
}

List<CharacterFeatureViewData> _applyFeatureResourceModifiers(
  List<CharacterFeatureViewData> features,
  List<_ActiveFeatureResourceEffect> effects, {
  required int totalLevel,
  required int proficiencyBonus,
  required Map<Ability, int> abilityModifiers,
}) {
  var result = features;
  for (final activeEffect in effects) {
    final effect = activeEffect.effect;
    if (effect.type != FeatureResourceEffectType.modify) {
      continue;
    }
    result = [
      for (final feature in result)
        feature.copyWith(
          resources: _modifiedFeatureResources(
            feature.resources,
            feature,
            activeEffect,
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
  CharacterFeatureViewData targetFeature,
  _ActiveFeatureResourceEffect activeEffect, {
  required int totalLevel,
  required int proficiencyBonus,
  required Map<Ability, int> abilityModifiers,
}) {
  if (resources == null || resources.isEmpty) {
    return resources;
  }
  final effect = activeEffect.effect;
  if (effect.targetType != null &&
      effect.targetType != FeatureResourceTargetType.featureResource) {
    return resources;
  }
  if (effect.targetSourceType != null &&
      effect.targetSourceType != targetFeature.sourceType) {
    return resources;
  }
  if (effect.targetSourceId != null &&
      effect.targetSourceId != targetFeature.sourceId) {
    return resources;
  }

  return [
    for (final resource in resources)
      if (effect.targetResourceKey == null ||
          effect.targetResourceKey == resource.key)
        _modifiedResource(
          resource,
          activeEffect,
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
  _ActiveFeatureResourceEffect activeEffect, {
  required int totalLevel,
  required int proficiencyBonus,
  required Map<Ability, int> abilityModifiers,
}) {
  final effect = activeEffect.effect;
  final becomesUnlimitedAtLevel = effect.becomesUnlimitedAtLevel;
  final isUnlimited = effect.setUnlimited == true ||
      resource.isUnlimited == true ||
      (becomesUnlimitedAtLevel != null &&
          activeEffect.sourceClassLevel >= becomesUnlimitedAtLevel);
  var maxValue = resource.max;
  if (!isUnlimited && effect.setMaxRule != null) {
    final resolvedMax = _featureResourceMax(
      rule: effect.setMaxRule!,
      value: effect.setMaxValue,
      ability: effect.setMaxAbility,
      progressionValues: null,
      sourceClassLevel: activeEffect.sourceClassLevel,
      totalLevel: totalLevel,
      proficiencyBonus: proficiencyBonus,
      abilityModifiers: abilityModifiers,
    );
    if (resolvedMax == null) {
      return resource;
    }
    maxValue = resolvedMax;
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
