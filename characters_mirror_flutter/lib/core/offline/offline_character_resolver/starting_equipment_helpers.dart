part of '../offline_character_resolver.dart';

List<_StartingEquipmentSourceBlock> _sourceBlocksFor({
  required ChoiceSourceType sourceType,
  required int sourceId,
  required List<StartingEquipmentBlockView>? blocks,
}) {
  final result = <_StartingEquipmentSourceBlock>[];
  for (final blockView in blocks ?? const <StartingEquipmentBlockView>[]) {
    if (blockView.block?.entryId == null) continue;
    result.add(
      _StartingEquipmentSourceBlock(
        sourceType: sourceType,
        sourceId: sourceId,
        blockView: blockView,
      ),
    );
  }
  return result
    ..sort((a, b) => (a.blockView.block?.orderIndex ?? 0)
        .compareTo(b.blockView.block?.orderIndex ?? 0));
}

List<CharacterStartingEquipmentSelectionData>
    _matchingStartingEquipmentSelections(
  List<CharacterStartingEquipmentSelectionData> selections, {
  required ChoiceSourceType sourceType,
  required int sourceId,
  required StartingEquipmentBlockData block,
}) {
  final sourceEntryId = block.entryId;
  if (sourceEntryId == null) {
    return const <CharacterStartingEquipmentSelectionData>[];
  }

  return [
    for (final selection in selections)
      if (selection.sourceType == sourceType &&
          selection.sourceId == sourceId &&
          selection.sourceEntryId == sourceEntryId)
        selection,
  ]..sort((a, b) => (a.selectionIndex ?? 0).compareTo(b.selectionIndex ?? 0));
}

StartingEquipmentOptionView? _startingEquipmentOptionForEntryId(
  List<StartingEquipmentOptionView>? options,
  int? entryId,
) {
  if (entryId == null) return null;
  for (final option in options ?? const <StartingEquipmentOptionView>[]) {
    if (option.option?.entryId == entryId) {
      return option;
    }
  }
  return null;
}

List<StartingEquipmentLineData> _sortedStartingEquipmentLines(
  List<StartingEquipmentLineData>? lines,
) {
  return [...?lines]
    ..sort((a, b) => (a.orderIndex ?? 0).compareTo(b.orderIndex ?? 0));
}

List<CharacterStartingEquipmentResolutionData> _collectBlockLevelResolutions(
  List<CharacterStartingEquipmentSelectionData> selections,
) {
  final resolutions = <CharacterStartingEquipmentResolutionData>[];
  for (final selection in selections) {
    if (selection.choiceOptionEntryId != null) continue;
    resolutions.addAll(
      selection.resolutions ??
          const <CharacterStartingEquipmentResolutionData>[],
    );
  }
  return resolutions
    ..sort((a, b) =>
        (a.sourceLineEntryId ?? 0).compareTo(b.sourceLineEntryId ?? 0));
}

void _applyStartingEquipmentLines(
  List<StartingEquipmentLineData> lines,
  List<CharacterStartingEquipmentResolutionData> resolutions,
  List<WeaponData> weapons,
  List<ItemData> items,
  List<ArmorData> armor,
  List<ToolData> tools,
  Map<String, _GrantedEquipmentAccumulator> accumulated,
) {
  final resolutionsByLineEntryId = {
    for (final resolution in resolutions)
      if (resolution.sourceLineEntryId != null)
        resolution.sourceLineEntryId!: resolution,
  };

  for (final line in lines) {
    switch (line.kind) {
      case StartingEquipmentLineKind.catalogRef:
        final catalogType = line.catalogType;
        final referenceKey = _normalizedTextOrNull(line.referenceKey);
        if (catalogType == null || referenceKey == null) continue;
        _accumulateGrantedEquipment(
          accumulated,
          catalogType: catalogType,
          referenceKey: referenceKey,
          displayText: _catalogRefDisplayText(
            catalogType,
            referenceKey,
            weapons,
            items,
            armor,
            tools,
          ),
          quantity: _positiveQuantity(line.quantity),
        );
        break;
      case StartingEquipmentLineKind.weaponCategory:
        final lineEntryId = line.entryId;
        if (lineEntryId == null) continue;
        final resolution = resolutionsByLineEntryId[lineEntryId];
        final referenceKey = _normalizedTextOrNull(resolution?.referenceKey);
        if (resolution?.catalogType != EquipmentCatalogType.weapon ||
            referenceKey == null) {
          continue;
        }
        final weapon = weapons
            .where((item) =>
                _normalizedTextOrNull(item.referenceKey) == referenceKey)
            .firstOrNull;
        if (weapon == null) continue;
        final allowed =
            line.allowedWeaponCategories ?? const <WeaponCategory>[];
        if (allowed.isNotEmpty && !allowed.contains(weapon.category)) {
          continue;
        }
        _accumulateGrantedEquipment(
          accumulated,
          catalogType: EquipmentCatalogType.weapon,
          referenceKey: referenceKey,
          displayText: _normalizedTextOrNull(weapon.name) ?? referenceKey,
          quantity: _positiveQuantity(
            resolution?.quantity,
            fallback: line.quantity,
          ),
        );
        break;
      case StartingEquipmentLineKind.itemCategory:
        final lineEntryId = line.entryId;
        if (lineEntryId == null) continue;
        final resolution = resolutionsByLineEntryId[lineEntryId];
        final referenceKey = _normalizedTextOrNull(resolution?.referenceKey);
        if (referenceKey == null) {
          continue;
        }
        final expectedType = line.catalogType ?? EquipmentCatalogType.item;
        if (resolution?.catalogType != expectedType) {
          continue;
        }

        if (expectedType == EquipmentCatalogType.armor) {
          final armorItem = armor
              .where((item) =>
                  _normalizedTextOrNull(item.referenceKey) == referenceKey)
              .firstOrNull;
          if (armorItem == null) continue;
          final allowed = {
            for (final value in line.allowedItemCategories ?? const <String>[])
              if (_normalizedTextOrNull(value) != null)
                _normalizedTextOrNull(value)!,
          };
          if (allowed.isNotEmpty &&
              !allowed.contains(armorItem.categoryValue?.name)) {
            continue;
          }
          _accumulateGrantedEquipment(
            accumulated,
            catalogType: EquipmentCatalogType.armor,
            referenceKey: referenceKey,
            displayText: _normalizedTextOrNull(armorItem.name) ?? referenceKey,
            quantity: _positiveQuantity(
              resolution?.quantity,
              fallback: line.quantity,
            ),
          );
          continue;
        }

        if (expectedType == EquipmentCatalogType.tool) {
          final tool = tools
              .where((item) =>
                  _normalizedTextOrNull(item.referenceKey) == referenceKey)
              .firstOrNull;
          if (tool == null) continue;
          final allowed = {
            for (final value in line.allowedItemCategories ?? const <String>[])
              if (_normalizedTextOrNull(value) != null)
                _normalizedTextOrNull(value)!,
          };
          if (allowed.isNotEmpty &&
              (tool.category == null ||
                  !allowed.contains(tool.category!.name))) {
            continue;
          }
          _accumulateGrantedEquipment(
            accumulated,
            catalogType: EquipmentCatalogType.tool,
            referenceKey: referenceKey,
            displayText: _normalizedTextOrNull(tool.name) ?? referenceKey,
            quantity: _positiveQuantity(
              resolution?.quantity,
              fallback: line.quantity,
            ),
          );
          continue;
        }

        if (expectedType != EquipmentCatalogType.item) {
          continue;
        }
        final item = items
            .where((item) =>
                _normalizedTextOrNull(item.referenceKey) == referenceKey)
            .firstOrNull;
        if (item == null) continue;
        final category = _normalizedTextOrNull(item.category);
        final allowed = {
          for (final value in line.allowedItemCategories ?? const <String>[])
            if (_normalizedTextOrNull(value) != null)
              _normalizedTextOrNull(value)!,
        };
        if (allowed.isNotEmpty &&
            (category == null || !allowed.contains(category))) {
          continue;
        }
        _accumulateGrantedEquipment(
          accumulated,
          catalogType: EquipmentCatalogType.item,
          referenceKey: referenceKey,
          displayText: _normalizedTextOrNull(item.name) ?? referenceKey,
          quantity: _positiveQuantity(
            resolution?.quantity,
            fallback: line.quantity,
          ),
        );
        break;
      case null:
        break;
    }
  }
}

void _accumulateGrantedEquipment(
  Map<String, _GrantedEquipmentAccumulator> accumulated, {
  required EquipmentCatalogType catalogType,
  required String referenceKey,
  required String displayText,
  required int quantity,
}) {
  final key = '${catalogType.name}:$referenceKey';
  final existing = accumulated[key];
  if (existing == null) {
    accumulated[key] = _GrantedEquipmentAccumulator(
      catalogType: catalogType,
      referenceKey: referenceKey,
      displayText: displayText,
      quantity: quantity,
    );
    return;
  }

  existing.quantity += quantity;
  if (existing.displayText.trim().isEmpty) {
    existing.displayText = displayText;
  }
}

String _catalogRefDisplayText(
  EquipmentCatalogType catalogType,
  String referenceKey,
  List<WeaponData> weapons,
  List<ItemData> items,
  List<ArmorData> armor,
  List<ToolData> tools,
) {
  switch (catalogType) {
    case EquipmentCatalogType.weapon:
      final weapon = weapons
          .where(
            (item) => _normalizedTextOrNull(item.referenceKey) == referenceKey,
          )
          .firstOrNull;
      return _normalizedTextOrNull(weapon?.name) ?? referenceKey;
    case EquipmentCatalogType.armor:
      final armorItem = armor
          .where(
            (item) => _normalizedTextOrNull(item.referenceKey) == referenceKey,
          )
          .firstOrNull;
      return _normalizedTextOrNull(armorItem?.name) ?? referenceKey;
    case EquipmentCatalogType.tool:
      final tool = tools
          .where((item) =>
              _normalizedTextOrNull(item.referenceKey) == referenceKey)
          .firstOrNull;
      return _normalizedTextOrNull(tool?.name) ?? referenceKey;
    case EquipmentCatalogType.item:
    case EquipmentCatalogType.magicItem:
      final item = items
          .where(
            (item) => _normalizedTextOrNull(item.referenceKey) == referenceKey,
          )
          .firstOrNull;
      return _normalizedTextOrNull(item?.name) ?? referenceKey;
  }
}

int _positiveQuantity(int? value, {int? fallback}) {
  final candidate = value ?? fallback ?? 1;
  return candidate > 0 ? candidate : 1;
}

String? _normalizedTextOrNull(String? value) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}
