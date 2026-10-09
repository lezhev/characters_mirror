part of '../offline_character_resolver.dart';

Future<List<FeatureModifierData>> _offlineArmorClassModifiers(
  OfflineCacheDatabase cache,
  CharacterData character,
  List<FeatureModifierData> cachedModifiers,
  List<ClassFeatureData> classFeatures,
  List<SubclassFeatureData> subclassFeatures,
) async {
  final modifiers = [...cachedModifiers];
  final classes = {for (final feature in classFeatures) feature.id: feature};
  final subclasses = {
    for (final feature in subclassFeatures) feature.id: feature
  };
  for (final entry in character.classEntries ?? <CharacterClassEntryData>[]) {
    final classId = entry.classData?.id;
    if (classId == null) continue;
    final level = entry.level ?? 0;
    final view = await cache.getReference<ClassStepView>(
      offlineClassStepKind,
      offlineClassStepKey(classId,
          selectedLevel: level, selectedSubclassId: entry.subclass?.id),
      ClassStepView.fromJson,
    );
    // A current catalog is authoritative, including an explicitly empty list.
    // Missing/older steps must not erase formulas supplied in a server snapshot.
    if (view?.featureModifiers != null) continue;
    for (final modifier in character.derived?.featureModifiers ??
        const <FeatureModifierData>[]) {
      if (modifier.target != FeatureModifierTarget.armorClass) continue;
      final feature = modifier.classFeature;
      final subfeature = modifier.subclassFeature;
      if (feature != null &&
          feature.id == modifier.classFeatureId &&
          feature.parentClassId == classId &&
          feature.level <= level) {
        classes.putIfAbsent(feature.id, () => feature);
        modifiers.add(modifier);
      } else if (subfeature != null &&
          subfeature.id == modifier.subclassFeatureId &&
          entry.subclass?.parentClassId == classId &&
          subfeature.parentSubclassId == entry.subclass?.id &&
          level >= (entry.subclass?.levelRequired ?? 1) &&
          subfeature.level <= level) {
        subclasses.putIfAbsent(subfeature.id, () => subfeature);
        modifiers.add(modifier);
      }
    }
  }
  return armorClassFeatureModifiers(
      modifiers, classes.values, subclasses.values);
}

Future<({int value, String source, String formula})> _calculateArmorClass(
  OfflineCacheDatabase cache,
  CharacterData character,
  Map<Ability, int> abilityModifiers,
  List<FeatureModifierData> armorClassModifiers,
  int proficiencyBonus,
) async {
  final bodyArmorReferenceKey = character.equippedArmor?.referenceKey?.trim();
  final shieldReferenceKey = character.equippedShield?.referenceKey?.trim();
  final armorRows = await cache.getReferenceList(
        'armor',
        offlineAllKey,
        ArmorData.fromJson,
      ) ??
      const <ArmorData>[];
  final bodyArmor = armorRows
      .where((armor) =>
          armor.referenceKey == bodyArmorReferenceKey &&
          (armor.categoryValue == ArmorCategory.light ||
              armor.categoryValue == ArmorCategory.medium ||
              armor.categoryValue == ArmorCategory.heavy))
      .firstOrNull;
  final shield = armorRows
      .where((armor) =>
          armor.referenceKey == shieldReferenceKey &&
          armor.categoryValue == ArmorCategory.shield)
      .firstOrNull;
  final input = armorClassModifierInput(
      character, armorClassModifiers, abilityModifiers, proficiencyBonus);
  return feature_modifiers.resolveArmorClass(
    context: input.context,
    modifiers: input.modifiers,
    bodyArmor: armorClassEquipment(bodyArmor),
    shield: armorClassEquipment(shield),
    customBonus: character.customArmorClassBonus ?? 0,
  );
}
