part of '../character_data_endpoint.dart';

Future<_GrantedEquipmentAccumulator> _resolveWeaponCategorySelection(
  Session session,
  StartingEquipmentLineData line,
  CharacterStartingEquipmentResolutionData resolution,
) async {
  if (resolution.catalogType != EquipmentCatalogType.weapon) {
    throw Exception(
      'Starting equipment line "${line.entryId}" requires a weapon resolution.',
    );
  }

  final referenceKey = _normalizedTextOrNull(resolution.referenceKey);
  if (referenceKey == null) {
    throw Exception(
      'Starting equipment line "${line.entryId}" requires weapon referenceKey.',
    );
  }

  final rows = await WeaponData.db.find(
    session,
    where: (t) => t.referenceKey.equals(referenceKey),
    limit: 1,
  );
  if (rows.isEmpty) {
    throw Exception(
      'Weapon referenceKey="$referenceKey" was not found for starting equipment.',
    );
  }

  final weapon = rows.first;
  final allowed = line.allowedWeaponCategories ?? const <WeaponCategory>[];
  if (allowed.isNotEmpty && !allowed.contains(weapon.category)) {
    throw Exception(
      'Weapon "$referenceKey" is not allowed for starting equipment line "${line.entryId}".',
    );
  }

  return _GrantedEquipmentAccumulator(
    catalogType: EquipmentCatalogType.weapon,
    referenceKey: referenceKey,
    displayText: _normalizedTextOrNull(weapon.name) ?? referenceKey,
    quantity: _normalizedPositiveQuantity(resolution.quantity,
        fallback: line.quantity),
  );
}

Future<_GrantedEquipmentAccumulator> _resolveItemCategorySelection(
  Session session,
  StartingEquipmentLineData line,
  CharacterStartingEquipmentResolutionData resolution,
) async {
  final expectedType = line.catalogType ?? EquipmentCatalogType.item;
  if (resolution.catalogType != expectedType) {
    throw Exception(
      'Starting equipment line "${line.entryId}" requires a ${expectedType.name} resolution.',
    );
  }

  switch (resolution.catalogType) {
    case EquipmentCatalogType.armor:
      return _resolveArmorCategorySelection(session, line, resolution);
    case EquipmentCatalogType.item:
      break;
    case EquipmentCatalogType.weapon:
    case EquipmentCatalogType.magicItem:
    case null:
      throw Exception(
        'Starting equipment line "${line.entryId}" requires a ${expectedType.name} resolution.',
      );
  }

  final referenceKey = _normalizedTextOrNull(resolution.referenceKey);
  if (referenceKey == null) {
    throw Exception(
      'Starting equipment line "${line.entryId}" requires item referenceKey.',
    );
  }

  final rows = await ItemData.db.find(
    session,
    where: (t) => t.referenceKey.equals(referenceKey),
    limit: 1,
  );
  if (rows.isEmpty) {
    throw Exception(
      'Item referenceKey="$referenceKey" was not found for starting equipment.',
    );
  }

  final item = rows.first;
  final itemCategory = _normalizedTextOrNull(item.category);
  final allowedCategories = {
    for (final category in line.allowedItemCategories ?? const <String>[])
      if (_normalizedTextOrNull(category) != null)
        _normalizedTextOrNull(category)!,
  };
  if (allowedCategories.isNotEmpty &&
      (itemCategory == null || !allowedCategories.contains(itemCategory))) {
    throw Exception(
      'Item "$referenceKey" is not allowed for starting equipment line "${line.entryId}".',
    );
  }

  return _GrantedEquipmentAccumulator(
    catalogType: EquipmentCatalogType.item,
    referenceKey: referenceKey,
    displayText: _normalizedTextOrNull(item.name) ?? referenceKey,
    quantity: _normalizedPositiveQuantity(resolution.quantity,
        fallback: line.quantity),
  );
}

Future<_GrantedEquipmentAccumulator> _resolveArmorCategorySelection(
  Session session,
  StartingEquipmentLineData line,
  CharacterStartingEquipmentResolutionData resolution,
) async {
  final referenceKey = _normalizedTextOrNull(resolution.referenceKey);
  if (referenceKey == null) {
    throw Exception(
      'Starting equipment line "${line.entryId}" requires armor referenceKey.',
    );
  }

  final rows = await ArmorData.db.find(
    session,
    where: (t) => t.referenceKey.equals(referenceKey),
    limit: 1,
  );
  if (rows.isEmpty) {
    throw Exception(
      'Armor referenceKey="$referenceKey" was not found for starting equipment.',
    );
  }

  final armor = rows.first;
  final allowedCategories = {
    for (final category in line.allowedItemCategories ?? const <String>[])
      if (_normalizedTextOrNull(category) != null)
        _normalizedTextOrNull(category)!,
  };
  if (allowedCategories.isNotEmpty &&
      !allowedCategories.contains(armor.categoryValue?.name)) {
    throw Exception(
      'Armor "$referenceKey" is not allowed for starting equipment line "${line.entryId}".',
    );
  }

  return _GrantedEquipmentAccumulator(
    catalogType: EquipmentCatalogType.armor,
    referenceKey: referenceKey,
    displayText: _normalizedTextOrNull(armor.name) ?? referenceKey,
    quantity: _normalizedPositiveQuantity(resolution.quantity,
        fallback: line.quantity),
  );
}

List<DamageType> _collectDamageTypes(
  CharacterData character,
  List<CharacterChoiceData> choices,
) {
  final values = <DamageType>{};
  values.addAll([
    ...?character.race?.resistances,
    ...?character.subrace?.resistances,
  ]);
  for (final option in _selectedRaceChoiceOptions(character, choices)) {
    if (option.damageType != null) {
      values.add(option.damageType!);
    }
  }
  return values.toList()..sort((a, b) => a.name.compareTo(b.name));
}

bool _isClassOrBackgroundChoice(CharacterChoiceData choice) {
  switch (choice.sourceType) {
    case ChoiceSourceType.background:
    case ChoiceSourceType.classData:
    case ChoiceSourceType.subclass:
    case ChoiceSourceType.classFeature:
    case ChoiceSourceType.subclassFeature:
      return true;
    case ChoiceSourceType.race:
    case ChoiceSourceType.subrace:
    case null:
      return false;
  }
}

int _normalizedPositiveQuantity(
  int? value, {
  int? fallback,
}) {
  final candidate = value ?? fallback ?? 1;
  return candidate > 0 ? candidate : 1;
}

String _classChoiceGroupKey(ClassChoiceGroupData group) {
  final explicitKey = _normalizedTextOrNull(group.exclusiveKey);
  if (explicitKey != null) {
    return explicitKey;
  }
  return 'group_${group.id ?? group.name ?? _safeEnumToken(group.type) ?? 'unknown'}';
}
