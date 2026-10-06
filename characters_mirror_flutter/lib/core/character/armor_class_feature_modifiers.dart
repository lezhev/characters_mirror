import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart' as ac;

// Keep active source metadata in derived data for recalculation without a cache.
List<FeatureModifierData> armorClassFeatureModifiers(
  Iterable<FeatureModifierData> modifiers,
  Iterable<ClassFeatureData> classFeatures,
  Iterable<SubclassFeatureData> subclassFeatures,
) {
  final classes = {for (final feature in classFeatures) feature.id: feature};
  final subclasses = {
    for (final feature in subclassFeatures) feature.id: feature
  };
  final result = <FeatureModifierData>[];
  for (final modifier in modifiers) {
    if (modifier.target != FeatureModifierTarget.armorClass) continue;
    if ((modifier.classFeatureId == null) ==
        (modifier.subclassFeatureId == null)) {
      continue;
    }
    final feature = modifier.classFeatureId == null
        ? null
        : classes[modifier.classFeatureId];
    final subfeature = modifier.subclassFeatureId == null
        ? null
        : subclasses[modifier.subclassFeatureId];
    if (feature == null && subfeature == null) continue;
    result.add(modifier.copyWith(
      classFeature: feature == null
          ? null
          : ClassFeatureData(
              id: feature.id,
              parentClassId: feature.parentClassId,
              referenceKey: feature.referenceKey,
              name: feature.name,
              level: feature.level,
            ),
      subclassFeature: subfeature == null
          ? null
          : SubclassFeatureData(
              id: subfeature.id,
              parentSubclassId: subfeature.parentSubclassId,
              referenceKey: subfeature.referenceKey,
              name: subfeature.name,
              level: subfeature.level,
            ),
    ));
  }
  // Compatibility for older catalogs: express the existing rule as the same
  // candidate operation. An explicit formula row takes precedence over it.
  for (final feature in classFeatures) {
    final rule = feature.unarmoredDefenseRule;
    if (rule == null ||
        feature.id == null ||
        result.any((modifier) =>
            modifier.classFeatureId == feature.id &&
            modifier.operation == FeatureModifierOperation.baseArmorClass)) {
      continue;
    }
    result.add(FeatureModifierData(
      referenceKey: 'legacy_unarmored_defense_${feature.id}',
      classFeatureId: feature.id,
      classFeature: ClassFeatureData(
          id: feature.id,
          parentClassId: feature.parentClassId,
          level: feature.level,
          name: 'Защита без доспехов'),
      target: FeatureModifierTarget.armorClass,
      operation: FeatureModifierOperation.baseArmorClass,
      value: FeatureModifierValueData(
          kind: FeatureModifierValueKind.staticValue,
          staticValue: 10,
          abilityModifiers: [
            Ability.dexterity,
            rule == UnarmoredDefenseRule.dexterityConstitution
                ? Ability.constitution
                : Ability.wisdom
          ]),
      conditions: [
        FeatureModifierConditionData(
            type: FeatureModifierConditionType.unarmored),
        if (rule == UnarmoredDefenseRule.dexterityWisdom)
          FeatureModifierConditionData(
              type: FeatureModifierConditionType.noShield)
      ],
    ));
  }
  return result;
}

({List<ac.FeatureModifierSpec> modifiers, ac.FeatureModifierContext context})
    armorClassModifierInput(
        CharacterData character,
        Iterable<FeatureModifierData> modifiers,
        Map<Ability, int> abilityModifiers,
        int proficiencyBonus) {
  final levels = <String, int>{};
  final entries = character.classEntries ?? const <CharacterClassEntryData>[];
  for (final entry in entries) {
    final key = entry.classData?.referenceKey ?? 'class:${entry.classData?.id}';
    levels[key] = (levels[key] ?? 0) + (entry.level ?? 0);
  }
  final specs = <ac.FeatureModifierSpec>[];
  for (final modifier in modifiers) {
    if (modifier.target != FeatureModifierTarget.armorClass) continue;
    final sourceEntry = entries
        .where((entry) =>
            (modifier.classFeature?.parentClassId != null &&
                entry.classData?.id == modifier.classFeature?.parentClassId) ||
            (modifier.subclassFeature?.parentSubclassId != null &&
                entry.subclass?.id ==
                    modifier.subclassFeature?.parentSubclassId))
        .firstOrNull;
    if (sourceEntry == null) continue;
    final conditions = <ac.FeatureModifierCondition>{};
    final choices = <String>{};
    for (final condition
        in modifier.conditions ?? const <FeatureModifierConditionData>[]) {
      if (condition.type == FeatureModifierConditionType.selectedChoiceOption) {
        choices.add(
            '${condition.choiceGroupKey?.trim()}::${condition.optionKey?.trim()}');
      } else {
        conditions.add(
            ac.FeatureModifierCondition.values.byName(condition.type.name));
      }
    }
    specs.add(ac.FeatureModifierSpec(
      referenceKey: modifier.referenceKey,
      sourceFeatureKey: modifier.referenceKey,
      sourceClassKey: sourceEntry.classData?.referenceKey ??
          'class:${sourceEntry.classData?.id}',
      sourceName: modifier.classFeature?.name ?? modifier.subclassFeature?.name,
      target: ac.FeatureModifierTarget.armorClass,
      operation:
          ac.FeatureModifierOperation.values.byName(modifier.operation.name),
      valueKind:
          ac.FeatureModifierValueKind.values.byName(modifier.value.kind.name),
      staticValue: modifier.value.staticValue,
      progression: modifier.value.progression ?? const {},
      numerator: modifier.value.numerator,
      denominator: modifier.value.denominator,
      rounding: modifier.value.rounding == null
          ? null
          : ac.FeatureModifierRounding.floor,
      abilityModifierKeys: modifier.value.abilityModifiers
              ?.map((ability) => ability.name)
              .toList() ??
          const [],
      conditions: conditions,
      requiredChoiceOptions: choices,
    ));
  }
  return (
    modifiers: specs,
    context: ac.FeatureModifierContext(
      proficiencyBonus: proficiencyBonus,
      classLevelsByKey: levels,
      activeFeatureKeys: {for (final spec in specs) spec.sourceFeatureKey},
      abilityModifiers: {
        for (final entry in abilityModifiers.entries)
          entry.key.name: entry.value
      },
      isArmored: character.equippedArmor != null,
      hasShield: character.equippedShield != null,
      selectedChoiceOptionKeys: {
        for (final choice in character.choices ?? const <CharacterChoiceData>[])
          if ((choice.groupKey?.trim().isNotEmpty ?? false) &&
              (choice.optionKey?.trim().isNotEmpty ?? false))
            '${choice.groupKey!.trim()}::${choice.optionKey!.trim()}'
      },
    )
  );
}

ac.ArmorClassEquipment? armorClassEquipment(ArmorData? armor) => armor == null
    ? null
    : ac.ArmorClassEquipment(
        name: armor.name,
        baseAC: armor.baseAC,
        dexBonus: armor.dexBonus == true,
        dexBonusMax: armor.dexBonusMax,
        bonusAC: armor.bonusAC ?? 0,
      );
