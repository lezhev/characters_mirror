part of '../character_data_endpoint.dart';

Future<List<CharacterEquipmentEntryView>> _collectGrantedEquipment(
  Session session,
  CharacterData character, {
  Transaction? transaction,
  _CharacterResolveContext? resolveContext,
}) async {
  final context = resolveContext ?? _CharacterResolveContext(session);
  final resolvedSources = await _resolveStartingEquipmentSources(
    session,
    character,
    transaction: transaction,
    resolveContext: context,
  );
  if (resolvedSources.blocks.isEmpty) {
    return const <CharacterEquipmentEntryView>[];
  }

  final selections = character.startingEquipmentSelections ??
      const <CharacterStartingEquipmentSelectionData>[];
  final accumulated = <String, _GrantedEquipmentAccumulator>{};

  for (final sourceBlock in resolvedSources.blocks) {
    final blockView = sourceBlock.blockView;
    final block = blockView.block;
    if (block == null) {
      continue;
    }
    final sourceSelections = _matchingStartingEquipmentSelections(
      selections,
      block: block,
    );
    final blockLines = _sortedStartingEquipmentLines(
      block.fixedLines ?? blockView.fixedLines,
    );

    if (block.kind == StartingEquipmentBlockKind.choice) {
      await _applyStartingEquipmentLines(
        session,
        blockLines,
        _collectBlockLevelResolutions(sourceSelections),
        accumulated,
        transaction: transaction,
        resolveContext: context,
      );

      for (final selection in sourceSelections) {
        if (selection.isSelected == false) {
          continue;
        }
        final optionView = _startingEquipmentOptionForEntryId(
          blockView.options,
          selection.choiceOptionEntryId,
        );
        if (optionView == null) {
          continue;
        }

        await _applyStartingEquipmentLines(
          session,
          _sortedStartingEquipmentLines(
            optionView.option?.lines ?? optionView.lines,
          ),
          selection.resolutions ??
              const <CharacterStartingEquipmentResolutionData>[],
          accumulated,
          transaction: transaction,
          resolveContext: context,
        );
      }
      continue;
    }
    if (sourceSelections.any((selection) => selection.isSelected == false)) {
      continue;
    }

    await _applyStartingEquipmentLines(
      session,
      blockLines,
      _collectBlockLevelResolutions(sourceSelections),
      accumulated,
      transaction: transaction,
      resolveContext: context,
    );
  }

  final result = [
    for (final item in accumulated.values)
      CharacterEquipmentEntryView(
        catalogType: item.catalogType,
        referenceKey: item.referenceKey,
        displayText: item.displayText,
        quantity: item.quantity,
      ),
  ]..sort(
      (a, b) {
        final textCompare =
            (a.displayText ?? '').compareTo(b.displayText ?? '');
        if (textCompare != 0) {
          return textCompare;
        }
        final typeCompare =
            (a.catalogType?.name ?? '').compareTo(b.catalogType?.name ?? '');
        if (typeCompare != 0) {
          return typeCompare;
        }
        return (a.referenceKey ?? '').compareTo(b.referenceKey ?? '');
      },
    );
  return result;
}

Future<_ResolvedStartingEquipmentSources> _resolveStartingEquipmentSources(
  Session session,
  CharacterData character, {
  Transaction? transaction,
  _CharacterResolveContext? resolveContext,
}) async {
  final context = resolveContext ?? _CharacterResolveContext(session);
  final sourceBlocks = <_StartingEquipmentSourceBlock>[];
  final startingEntry = _resolveStartingEntry(
    character.classEntries ?? const <CharacterClassEntryData>[],
  );
  final startingClass = startingEntry?.classData;
  final startingClassId = startingClass?.id;
  if (startingClassId != null) {
    sourceBlocks.addAll(
      _sourceBlocksFor(
        await context.startingEquipmentBlocks(
          sourceClassId: startingClassId,
          transaction: transaction,
        ),
      ),
    );
  }

  final background = character.background;
  final backgroundId = background?.id;
  if (backgroundId != null) {
    sourceBlocks.addAll(
      _sourceBlocksFor(
        await context.startingEquipmentBlocks(
          sourceBackgroundId: backgroundId,
          transaction: transaction,
        ),
      ),
    );
  }

  sourceBlocks.sort((a, b) {
    return (a.blockView.block?.orderIndex ?? 0)
        .compareTo(b.blockView.block?.orderIndex ?? 0);
  });

  return _ResolvedStartingEquipmentSources(blocks: sourceBlocks);
}

List<_StartingEquipmentSourceBlock> _sourceBlocksFor(
  List<StartingEquipmentBlockView> blockViews,
) {
  final result = <_StartingEquipmentSourceBlock>[];
  for (final blockView in blockViews) {
    if (blockView.block?.entryId == null) {
      continue;
    }
    result.add(
      _StartingEquipmentSourceBlock(
        blockView: blockView,
      ),
    );
  }
  result.sort(
    (a, b) => (a.blockView.block?.orderIndex ?? 0)
        .compareTo(b.blockView.block?.orderIndex ?? 0),
  );
  return result;
}

List<CharacterStartingEquipmentSelectionData>
    _matchingStartingEquipmentSelections(
  List<CharacterStartingEquipmentSelectionData> selections, {
  required StartingEquipmentBlockData block,
}) {
  final sourceEntryId = block.entryId;
  if (sourceEntryId == null) {
    return const <CharacterStartingEquipmentSelectionData>[];
  }

  return [
    for (final selection in selections)
      if (selection.sourceEntryId == sourceEntryId) selection,
  ]..sort(_compareStartingEquipmentSelections);
}

StartingEquipmentOptionView? _startingEquipmentOptionForEntryId(
  List<StartingEquipmentOptionView>? options,
  int? entryId,
) {
  if (entryId == null) {
    return null;
  }
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
    if (selection.choiceOptionEntryId != null) {
      continue;
    }
    resolutions.addAll(
      selection.resolutions ??
          const <CharacterStartingEquipmentResolutionData>[],
    );
  }
  resolutions.sort(_compareStartingEquipmentResolutions);
  return resolutions;
}

Future<void> _applyStartingEquipmentLines(
  Session session,
  List<StartingEquipmentLineData> lines,
  List<CharacterStartingEquipmentResolutionData> resolutions,
  Map<String, _GrantedEquipmentAccumulator> accumulated, {
  Transaction? transaction,
  _CharacterResolveContext? resolveContext,
}) async {
  final context = resolveContext ?? _CharacterResolveContext(session);
  final resolutionsByLineKey =
      <int, CharacterStartingEquipmentResolutionData>{};
  for (final resolution in resolutions) {
    final lineEntryId = resolution.sourceLineEntryId;
    if (lineEntryId == null) {
      continue;
    }
    resolutionsByLineKey[lineEntryId] = resolution;
  }

  for (final line in lines) {
    switch (line.kind) {
      case StartingEquipmentLineKind.catalogRef:
        final catalogType = line.catalogType;
        final referenceKey = _normalizedTextOrNull(line.referenceKey);
        if (catalogType == null || referenceKey == null) {
          continue;
        }
        _accumulateGrantedEquipment(
          accumulated,
          catalogType: catalogType,
          referenceKey: referenceKey,
          displayText: await _catalogRefDisplayText(
            session,
            catalogType,
            referenceKey,
            transaction: transaction,
            resolveContext: context,
          ),
          quantity: _normalizedPositiveQuantity(line.quantity),
        );
        break;
      case StartingEquipmentLineKind.weaponCategory:
        final lineEntryId = line.entryId;
        if (lineEntryId == null) {
          continue;
        }
        final resolution = resolutionsByLineKey[lineEntryId];
        if (resolution == null) {
          continue;
        }
        final resolved = await _resolveWeaponCategorySelection(
          session,
          line,
          resolution,
          transaction: transaction,
          resolveContext: context,
        );
        _accumulateGrantedEquipment(
          accumulated,
          catalogType: resolved.catalogType,
          referenceKey: resolved.referenceKey,
          displayText: resolved.displayText,
          quantity: resolved.quantity,
        );
        break;
      case StartingEquipmentLineKind.itemCategory:
        final lineEntryId = line.entryId;
        if (lineEntryId == null) {
          continue;
        }
        final resolution = resolutionsByLineKey[lineEntryId];
        if (resolution == null) {
          continue;
        }
        final resolved = await _resolveItemCategorySelection(
          session,
          line,
          resolution,
          transaction: transaction,
          resolveContext: context,
        );
        _accumulateGrantedEquipment(
          accumulated,
          catalogType: resolved.catalogType,
          referenceKey: resolved.referenceKey,
          displayText: resolved.displayText,
          quantity: resolved.quantity,
        );
        break;
      case null:
        continue;
    }
  }
}

Future<String> _catalogRefDisplayText(
  Session session,
  EquipmentCatalogType catalogType,
  String referenceKey, {
  Transaction? transaction,
  _CharacterResolveContext? resolveContext,
}) async {
  final context = resolveContext ?? _CharacterResolveContext(session);
  switch (catalogType) {
    case EquipmentCatalogType.weapon:
      final weapon = await context.weapon(
        referenceKey,
        transaction: transaction,
      );
      return _normalizedTextOrNull(weapon?.name) ?? referenceKey;
    case EquipmentCatalogType.armor:
      final armor = await context.armor(
        referenceKey,
        transaction: transaction,
      );
      return _normalizedTextOrNull(armor?.name) ?? referenceKey;
    case EquipmentCatalogType.tool:
      final tool = await context.tool(referenceKey, transaction: transaction);
      return _normalizedTextOrNull(tool?.name) ?? referenceKey;
    case EquipmentCatalogType.item:
    case EquipmentCatalogType.magicItem:
      final item = await context.item(
        referenceKey,
        transaction: transaction,
      );
      return _normalizedTextOrNull(item?.name) ?? referenceKey;
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
