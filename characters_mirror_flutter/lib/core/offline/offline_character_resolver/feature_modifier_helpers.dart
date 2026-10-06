part of '../offline_character_resolver.dart';

Future<int> _offlineFeatureModifierTotal(
  OfflineCacheDatabase cache,
  List<CharacterClassEntryData> entries,
  CharacterData character, {
  required int proficiencyBonus,
  required FeatureModifierTarget target,
  bool abilityCheckIncludesProficiency = false,
}) async {
  final modifiers = <FeatureModifierData>[];
  final activeFeatureKeys = <String>{};
  final classLevels = <String, int>{};
  final featureClassKeys = <int, String>{};
  final classFeatureKeys = <int, String>{};
  final subclassFeatureKeys = <int, String>{};
  for (final entry in entries) {
    final classId = entry.classData?.id;
    final classKey = entry.classData?.referenceKey;
    if (classId == null || classKey == null) continue;
    classLevels[classKey] = (classLevels[classKey] ?? 0) + (entry.level ?? 0);
    final view = await cache.getReference<ClassStepView>(
      offlineClassStepKind,
      offlineClassStepKey(
        classId,
        selectedLevel: entry.level ?? 0,
        selectedSubclassId: entry.subclass?.id,
      ),
      ClassStepView.fromJson,
    );
    modifiers.addAll(view?.featureModifiers ?? const <FeatureModifierData>[]);
    for (final feature
        in view?.currentLevelFeatures ?? const <ClassFeatureData>[]) {
      final id = feature.id;
      final key = feature.referenceKey;
      if (id != null && key != null) {
        classFeatureKeys[id] = key;
        featureClassKeys[id] = classKey;
        activeFeatureKeys.add(key);
      }
    }
    for (final feature
        in view?.currentSubclassFeatures ?? const <SubclassFeatureData>[]) {
      final id = feature.id;
      final key = feature.referenceKey;
      if (id != null && key != null) {
        subclassFeatureKeys[id] = key;
        featureClassKeys[id] = classKey;
        activeFeatureKeys.add(key);
      }
    }
  }

  final specs = <feature_modifiers.FeatureModifierSpec>[];
  final selectedChoiceOptionKeys = <String>{
    for (final choice in character.choices ?? const <CharacterChoiceData>[])
      if ((choice.groupKey?.trim().isNotEmpty ?? false) &&
          (choice.optionKey?.trim().isNotEmpty ?? false))
        '${choice.groupKey!.trim()}::${choice.optionKey!.trim()}',
  };
  for (final modifier in modifiers) {
    if (modifier.operation != FeatureModifierOperation.add) continue;
    final classFeatureId = modifier.classFeatureId;
    final subclassFeatureId = modifier.subclassFeatureId;
    if ((classFeatureId == null) == (subclassFeatureId == null)) continue;
    final sourceFeatureKey = classFeatureId == null
        ? subclassFeatureKeys[subclassFeatureId]
        : classFeatureKeys[classFeatureId];
    final sourceId = classFeatureId ?? subclassFeatureId;
    final sourceClassKey = sourceId == null ? null : featureClassKeys[sourceId];
    if (sourceFeatureKey == null || sourceClassKey == null) continue;
    final simpleConditions = <feature_modifiers.FeatureModifierCondition>{};
    final requiredChoiceOptions = <String>{};
    for (final condition
        in modifier.conditions ?? const <FeatureModifierConditionData>[]) {
      switch (condition.type) {
        case FeatureModifierConditionType.unarmored:
          simpleConditions
              .add(feature_modifiers.FeatureModifierCondition.unarmored);
        case FeatureModifierConditionType.noShield:
          simpleConditions
              .add(feature_modifiers.FeatureModifierCondition.noShield);
        case FeatureModifierConditionType.abilityCheckIsNotProficient:
          simpleConditions.add(
            feature_modifiers
                .FeatureModifierCondition.abilityCheckIsNotProficient,
          );
        case FeatureModifierConditionType.armored:
          simpleConditions
              .add(feature_modifiers.FeatureModifierCondition.armored);
        case FeatureModifierConditionType.rangedWeaponAttack:
          simpleConditions.add(
            feature_modifiers.FeatureModifierCondition.rangedWeaponAttack,
          );
        case FeatureModifierConditionType.selectedChoiceOption:
          final groupKey = condition.choiceGroupKey?.trim();
          final optionKey = condition.optionKey?.trim();
          if (groupKey != null &&
              groupKey.isNotEmpty &&
              optionKey != null &&
              optionKey.isNotEmpty) {
            requiredChoiceOptions.add('$groupKey::$optionKey');
          }
      }
    }
    specs.add(feature_modifiers.FeatureModifierSpec(
      referenceKey: modifier.referenceKey,
      sourceFeatureKey: sourceFeatureKey,
      sourceClassKey: sourceClassKey,
      target: switch (modifier.target) {
        FeatureModifierTarget.speed =>
          feature_modifiers.FeatureModifierTarget.speed,
        FeatureModifierTarget.abilityCheck =>
          feature_modifiers.FeatureModifierTarget.abilityCheck,
        FeatureModifierTarget.armorClass =>
          feature_modifiers.FeatureModifierTarget.armorClass,
        FeatureModifierTarget.attackRoll =>
          feature_modifiers.FeatureModifierTarget.attackRoll,
        FeatureModifierTarget.damageRoll =>
          feature_modifiers.FeatureModifierTarget.damageRoll,
      },
      operation: feature_modifiers.FeatureModifierOperation.add,
      valueKind: switch (modifier.value.kind) {
        FeatureModifierValueKind.staticValue =>
          feature_modifiers.FeatureModifierValueKind.staticValue,
        FeatureModifierValueKind.classLevelProgression =>
          feature_modifiers.FeatureModifierValueKind.classLevelProgression,
        FeatureModifierValueKind.proficiencyBonusFraction =>
          feature_modifiers.FeatureModifierValueKind.proficiencyBonusFraction,
      },
      staticValue: modifier.value.staticValue,
      progression: modifier.value.progression ?? const {},
      numerator: modifier.value.numerator,
      denominator: modifier.value.denominator,
      rounding: modifier.value.rounding == FeatureModifierRounding.floor
          ? feature_modifiers.FeatureModifierRounding.floor
          : null,
      conditions: simpleConditions,
      requiredChoiceOptions: requiredChoiceOptions,
    ));
  }
  final resolved = feature_modifiers.evaluateFeatureModifiers(
    modifiers: specs,
    context: feature_modifiers.FeatureModifierContext(
      proficiencyBonus: proficiencyBonus,
      classLevelsByKey: classLevels,
      activeFeatureKeys: activeFeatureKeys,
      isArmored: character.equippedArmor != null,
      hasShield: character.equippedShield != null,
      abilityCheckIncludesProficiency: abilityCheckIncludesProficiency,
      selectedChoiceOptionKeys: selectedChoiceOptionKeys,
    ),
  );
  return feature_modifiers.sumFeatureModifierValues(resolved)[switch (target) {
        FeatureModifierTarget.speed =>
          feature_modifiers.FeatureModifierTarget.speed,
        FeatureModifierTarget.abilityCheck =>
          feature_modifiers.FeatureModifierTarget.abilityCheck,
        FeatureModifierTarget.armorClass =>
          feature_modifiers.FeatureModifierTarget.armorClass,
        FeatureModifierTarget.attackRoll =>
          feature_modifiers.FeatureModifierTarget.attackRoll,
        FeatureModifierTarget.damageRoll =>
          feature_modifiers.FeatureModifierTarget.damageRoll,
      }] ??
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
