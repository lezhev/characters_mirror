import 'package:characters_mirror_client/characters_mirror_client.dart';

Map<String, String> buildStartingEquipmentItemLabels(List<ItemData> items) {
  return {
    for (final item in items)
      if (normalizeStartingEquipmentText(item.referenceKey) != null)
        normalizeStartingEquipmentText(item.referenceKey)!:
            normalizeStartingEquipmentText(item.name) ??
                normalizeStartingEquipmentText(item.referenceKey)!,
  };
}

Map<String, String> buildStartingEquipmentWeaponLabels(
  List<WeaponData> weapons,
) {
  return {
    for (final weapon in weapons)
      if (normalizeStartingEquipmentText(weapon.referenceKey) != null)
        normalizeStartingEquipmentText(weapon.referenceKey)!:
            normalizeStartingEquipmentText(weapon.name) ??
                normalizeStartingEquipmentText(weapon.referenceKey)!,
  };
}

Map<String, String> buildStartingEquipmentArmorLabels(List<ArmorData> armor) {
  return {
    for (final item in armor)
      if (normalizeStartingEquipmentText(item.referenceKey) != null)
        normalizeStartingEquipmentText(item.referenceKey)!:
            normalizeStartingEquipmentText(item.name) ??
                normalizeStartingEquipmentText(item.referenceKey)!,
  };
}

typedef StartingEquipmentCatalogLabels
    = Map<EquipmentCatalogType, Map<String, String>>;

CharacterStartingEquipmentSelectionData? selectionForStartingEquipmentBlock(
  StartingEquipmentBlockView blockView, {
  required List<CharacterStartingEquipmentSelectionData> selections,
}) {
  final sourceEntryId = blockView.block?.entryId;
  if (sourceEntryId == null) {
    return null;
  }
  for (final selection in selections) {
    if (selection.sourceEntryId == sourceEntryId) {
      return selection;
    }
  }
  return null;
}

CharacterStartingEquipmentSelectionData? selectionForStartingEquipmentOption({
  required CharacterStartingEquipmentSelectionData? selection,
  required StartingEquipmentOptionView optionView,
}) {
  final optionEntryId = optionView.option?.entryId;
  if (selection == null || optionEntryId == null) {
    return null;
  }
  return selection.choiceOptionEntryId == optionEntryId ? selection : null;
}

bool isStartingEquipmentOptionSelected(
  StartingEquipmentOptionView optionView,
  CharacterStartingEquipmentSelectionData? selection,
) {
  final optionEntryId = optionView.option?.entryId;
  return optionEntryId != null &&
      selection?.choiceOptionEntryId == optionEntryId;
}

Map<int, String> startingEquipmentResolutionReferenceKeys(
  CharacterStartingEquipmentSelectionData? selection,
  List<StartingEquipmentLineData> lines,
) {
  if (selection == null) {
    return const {};
  }

  final lineIds = {
    for (final line in lines)
      if (line.entryId != null) line.entryId!,
  };
  final values = <int, String>{};
  for (final resolution in selection.resolutions ??
      const <CharacterStartingEquipmentResolutionData>[]) {
    final lineId = resolution.sourceLineEntryId;
    final referenceKey =
        normalizeStartingEquipmentText(resolution.referenceKey);
    if (lineId == null || referenceKey == null || !lineIds.contains(lineId)) {
      continue;
    }
    values[lineId] = referenceKey;
  }
  return values;
}

String? selectedStartingEquipmentReferenceKeyForLine(
  StartingEquipmentBlockView blockView, {
  required List<CharacterStartingEquipmentSelectionData> selections,
  required StartingEquipmentLineData line,
}) {
  final selection =
      selectionForStartingEquipmentBlock(blockView, selections: selections);
  final lineId = line.entryId;
  if (selection == null || lineId == null) {
    return null;
  }
  for (final resolution in selection.resolutions ??
      const <CharacterStartingEquipmentResolutionData>[]) {
    if (resolution.sourceLineEntryId == lineId) {
      return normalizeStartingEquipmentText(resolution.referenceKey);
    }
  }
  return null;
}

String startingEquipmentOptionTitle({
  required StartingEquipmentOptionView optionView,
  StartingEquipmentCatalogLabels catalogLabels = const {},
}) {
  final lines = optionView.lines ?? optionView.option?.lines ?? const [];
  if (lines.isEmpty) {
    return 'Вариант';
  }
  return lines
      .map((line) => startingEquipmentLineTitle(
            line,
            catalogLabels: catalogLabels,
          ))
      .join(' + ');
}

String startingEquipmentLineTitle(
  StartingEquipmentLineData line, {
  StartingEquipmentCatalogLabels catalogLabels = const {},
  String? selectedReferenceKey,
}) {
  final selected = normalizeStartingEquipmentText(selectedReferenceKey);
  final base = switch (line.kind) {
    StartingEquipmentLineKind.catalogRef =>
      _catalogReferenceLabel(line, catalogLabels) ?? 'Предмет',
    StartingEquipmentLineKind.weaponCategory =>
      _resolutionReferenceLabel(line, selected, catalogLabels) ??
          _weaponCategoryTitle(line.allowedWeaponCategories),
    StartingEquipmentLineKind.itemCategory =>
      _resolutionReferenceLabel(line, selected, catalogLabels) ??
          _itemCategoryTitle(line),
    null => 'Предмет',
  };
  final quantity = line.quantity ?? 1;
  return quantity > 1 ? '$base x$quantity' : base;
}

String? _catalogReferenceLabel(
  StartingEquipmentLineData line,
  StartingEquipmentCatalogLabels catalogLabels,
) {
  final catalogType = line.catalogType;
  final referenceKey = normalizeStartingEquipmentText(line.referenceKey);
  if (catalogType == null || referenceKey == null) {
    return referenceKey;
  }
  return catalogLabels[catalogType]?[referenceKey] ?? referenceKey;
}

String _weaponCategoryTitle(List<WeaponCategory>? categories) {
  final values = categories ?? const <WeaponCategory>[];
  if (values.isEmpty) {
    return 'Любое оружие';
  }
  if (values.length == 1) {
    return switch (values.single) {
      WeaponCategory.simpleMelee => 'Любое простое рукопашное оружие',
      WeaponCategory.simpleRanged => 'Любое простое дальнобойное оружие',
      WeaponCategory.martialMelee => 'Любое воинское рукопашное оружие',
      WeaponCategory.martialRanged => 'Любое воинское дальнобойное оружие',
    };
  }
  if (values.every(
    (value) =>
        value == WeaponCategory.simpleMelee ||
        value == WeaponCategory.simpleRanged,
  )) {
    return 'Любое простое оружие';
  }
  if (values.every(
    (value) =>
        value == WeaponCategory.martialMelee ||
        value == WeaponCategory.martialRanged,
  )) {
    return 'Любое воинское оружие';
  }
  return 'Любое оружие';
}

String _itemCategoryTitle(StartingEquipmentLineData line) {
  if (line.catalogType == EquipmentCatalogType.armor) {
    final categories = line.allowedItemCategories ?? const <String>[];
    if (categories.length == 1) {
      return 'Любой доспех: ${categories.single}';
    }
    return 'Любой доспех';
  }
  final categories = line.allowedItemCategories ?? const <String>[];
  if (categories.length == 1) {
    return 'Любой предмет: ${categories.single}';
  }
  return 'Любой предмет';
}

String startingEquipmentDialogLineLabel(
  StartingEquipmentLineData line, {
  required String? selectedReferenceKey,
  required bool enabled,
  StartingEquipmentCatalogLabels catalogLabels = const {},
}) {
  if (!startingEquipmentLineRequiresResolution(line)) {
    return startingEquipmentLineTitle(line, catalogLabels: catalogLabels);
  }
  final selected = normalizeStartingEquipmentText(selectedReferenceKey);
  final title = startingEquipmentLineTitle(line, catalogLabels: catalogLabels);
  final selectedLabel = _resolutionReferenceLabel(
    line,
    selected,
    catalogLabels,
  );
  if (selected != null) {
    return '$title\nВыбрано: ${selectedLabel ?? selected}';
  }
  if (!enabled) {
    return '$title\nСначала выберите этот вариант.';
  }
  return '$title\nНажмите, чтобы выбрать предмет.';
}

String? _resolutionReferenceLabel(
  StartingEquipmentLineData line,
  String? referenceKey,
  StartingEquipmentCatalogLabels catalogLabels,
) {
  if (referenceKey == null) {
    return null;
  }
  final catalogType = line.kind == StartingEquipmentLineKind.weaponCategory
      ? EquipmentCatalogType.weapon
      : line.catalogType ?? EquipmentCatalogType.item;
  return catalogLabels[catalogType]?[referenceKey] ?? referenceKey;
}

bool startingEquipmentLineRequiresResolution(StartingEquipmentLineData line) {
  return line.kind == StartingEquipmentLineKind.weaponCategory ||
      line.kind == StartingEquipmentLineKind.itemCategory;
}

String? normalizeStartingEquipmentText(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return null;
  }
  return trimmed;
}
