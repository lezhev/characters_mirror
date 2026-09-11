part of '../character_data_endpoint.dart';

Future<List<CharacterFeatureOverrideData>> _pruneFeatureOverrides(
  Session session,
  CharacterData character,
) async {
  final normalizedOverrides = _normalizedFeatureOverrides(
    character.featureOverrides,
  );
  if (normalizedOverrides.isEmpty) {
    return const <CharacterFeatureOverrideData>[];
  }

  final entries = character.classEntries ?? const <CharacterClassEntryData>[];
  final choices = character.choices ?? const <CharacterChoiceData>[];
  final totalLevel =
      entries.fold<int>(0, (sum, entry) => sum + (entry.level ?? 0));
  final scores = _buildAbilityScores(character, choices);
  final abilityModifiers = {
    for (final ability in Ability.values)
      ability.name: _abilityModifier(scores[ability.name] ?? 10),
  };
  final proficiencyBonus = totalLevel <= 0 ? 2 : 2 + ((totalLevel - 1) ~/ 4);
  final resolvedSources =
      await _resolveDerivedSources(session, character, choices);
  final currentRaceFeatures =
      _currentRaceFeaturesBySource(character, totalLevel);
  final defaultFeatures = _buildActiveFeatures(
    character: character.copyWith(
      featureOverrides: const <CharacterFeatureOverrideData>[],
    ),
    resolvedSources: resolvedSources,
    currentRaceFeatures: currentRaceFeatures,
    totalLevel: totalLevel,
    proficiencyBonus: proficiencyBonus,
    abilityModifiers: abilityModifiers,
  );
  final defaultByKey = {
    for (final feature in defaultFeatures)
      _featureOverrideKey(feature.sourceType, feature.sourceId): feature,
  };

  return [
    for (final override in normalizedOverrides)
      if (_isMeaningfulFeatureOverride(
        override,
        defaultByKey[
            _featureOverrideKey(override.sourceType, override.sourceId)],
      ))
        override,
  ];
}

Future<List<CharacterResourceStateData>> _pruneResourceStates(
  Session session,
  CharacterData character,
) async {
  final normalizedStates = _normalizedResourceStates(character.resourceStates);
  if (normalizedStates.isEmpty) {
    return const <CharacterResourceStateData>[];
  }

  final derived = await _buildDerivedData(
    session,
    character.copyWith(resourceStates: normalizedStates),
  );
  final activeResourcesByKey = {
    for (final feature
        in derived.activeFeatures ?? const <CharacterFeatureViewData>[])
      for (final resource
          in feature.resources ?? const <CharacterResourceViewData>[])
        _resourceStateKey(feature.sourceType, feature.sourceId, resource.key):
            resource,
  };
  final pruned = <CharacterResourceStateData>[];
  for (final state in normalizedStates) {
    final resource = activeResourcesByKey[
        _resourceStateKey(state.sourceType, state.sourceId, state.resourceKey)];
    if (resource == null) {
      continue;
    }
    if (resource.isUnlimited == true) {
      continue;
    }
    final current = state.current.clamp(0, resource.max).toInt();
    if (current == resource.max) {
      continue;
    }
    pruned.add(
      CharacterResourceStateData(
        sourceType: state.sourceType,
        sourceId: state.sourceId,
        resourceKey: state.resourceKey,
        current: current,
      ),
    );
  }
  return pruned;
}

Future<CharacterData> _applyInitialEquipmentSnapshot(
  Session session,
  CharacterData character,
) async {
  final grantedEquipment = await _collectGrantedEquipment(session, character);
  if (grantedEquipment.isEmpty) {
    return character;
  }

  final equipment =
      (character.equipment == null || character.equipment!.isEmpty)
          ? _buildEquipmentSnapshot(
              grantedEquipment,
              fallbackUpdatedAt: character.updatedAt,
            )
          : character.equipment;
  final weaponAttacks = await _buildStartingWeaponAttacks(
    session,
    character,
    grantedEquipment,
  );
  final attacks = [...?character.attacks];
  for (final attack in weaponAttacks) {
    if (!_containsAttackWithName(attacks, attack.name)) {
      attacks.add(attack);
    }
  }

  return character.copyWith(
    equipment: equipment,
    attacks: attacks.isEmpty ? character.attacks : attacks,
  );
}

List<CharacterInventoryItemData> _buildEquipmentSnapshot(
  List<CharacterEquipmentEntryView> grantedEquipment, {
  required DateTime? fallbackUpdatedAt,
}) {
  final items = <CharacterInventoryItemData>[];
  for (final entry in grantedEquipment) {
    final name = _normalizedTextOrNull(entry.displayText) ??
        _normalizedTextOrNull(entry.referenceKey);
    if (name == null) {
      continue;
    }
    items.add(
      CharacterInventoryItemData(
        id: _generateSyncId(),
        name: name,
        quantity: _normalizedPositiveQuantity(entry.quantity),
        type: _inventoryItemTypeForCatalog(entry.catalogType),
        updatedAt: fallbackUpdatedAt,
      ),
    );
  }
  return items;
}

Future<List<CharacterAttackData>> _buildStartingWeaponAttacks(
  Session session,
  CharacterData character,
  List<CharacterEquipmentEntryView> grantedEquipment,
) async {
  final weaponReferenceKeys = <String>[
    for (final entry in grantedEquipment)
      if (entry.catalogType == EquipmentCatalogType.weapon &&
          _normalizedTextOrNull(entry.referenceKey) != null)
        _normalizedTextOrNull(entry.referenceKey)!,
  ];
  if (weaponReferenceKeys.isEmpty) {
    return const <CharacterAttackData>[];
  }

  final uniqueReferenceKeys = <String>{};
  final attacks = <CharacterAttackData>[];
  CharacterDerivedData? derived;

  for (final referenceKey in weaponReferenceKeys) {
    if (!uniqueReferenceKeys.add(referenceKey)) {
      continue;
    }

    final rows = await WeaponData.db.find(
      session,
      where: (t) => t.referenceKey.equals(referenceKey),
      limit: 1,
    );
    if (rows.isEmpty) {
      continue;
    }

    final weapon = rows.first;
    if (_hasWeaponProperty(weapon, WeaponProperty.finesse)) {
      derived ??= await _buildDerivedData(session, character);
    }

    attacks.add(
      CharacterAttackData(
        id: _generateSyncId(),
        name: _normalizedTextOrNull(weapon.name) ?? referenceKey,
        leadingAbility: _startingWeaponAbility(weapon, derived),
        damage: _normalizedTextOrNull(weapon.damage),
        customAttackBonus: 0,
        damageType: weapon.damageType,
        tags: _normalizedAttackTags(weapon.properties),
        description: _normalizedTextOrNull(weapon.description),
        updatedAt: character.updatedAt,
      ),
    );
  }

  return attacks;
}

Ability _startingWeaponAbility(
  WeaponData weapon,
  CharacterDerivedData? derived,
) {
  if (_hasWeaponProperty(weapon, WeaponProperty.finesse)) {
    final modifiers = derived?.abilityModifiers ?? const <String, int>{};
    final strength = modifiers[Ability.strength.name] ?? 0;
    final dexterity = modifiers[Ability.dexterity.name] ?? 0;
    return dexterity > strength ? Ability.dexterity : Ability.strength;
  }

  switch (weapon.category) {
    case WeaponCategory.simpleRanged:
    case WeaponCategory.martialRanged:
      return Ability.dexterity;
    case WeaponCategory.simpleMelee:
    case WeaponCategory.martialMelee:
    case null:
      return Ability.strength;
  }
}

List<String>? _normalizedAttackTags(List<WeaponProperty>? tags) {
  final normalized = [
    for (final tag in tags ?? const <WeaponProperty>[]) tag.name,
  ];
  return normalized.isEmpty ? null : normalized;
}

bool _hasWeaponProperty(WeaponData weapon, WeaponProperty property) {
  return (weapon.properties ?? const <WeaponProperty>[]).contains(property);
}

bool _containsAttackWithName(
  List<CharacterAttackData> attacks,
  String? name,
) {
  final normalizedName = _normalizedTextOrNull(name)?.toLowerCase();
  if (normalizedName == null) {
    return false;
  }

  return attacks.any(
    (attack) =>
        _normalizedTextOrNull(attack.name)?.toLowerCase() == normalizedName,
  );
}
