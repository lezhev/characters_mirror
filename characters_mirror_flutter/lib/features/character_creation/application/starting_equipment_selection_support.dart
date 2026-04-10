import 'package:characters_mirror_client/characters_mirror_client.dart';

bool startingEquipmentLineRequiresResolution(StartingEquipmentLineData line) {
  return line.kind == StartingEquipmentLineKind.weaponCategory ||
      line.kind == StartingEquipmentLineKind.itemCategory;
}

List<CharacterStartingEquipmentSelectionData> selectionsForEquipmentSource({
  required List<CharacterStartingEquipmentSelectionData> selections,
  required ChoiceSourceType sourceType,
  required int sourceId,
}) {
  return selections
      .where(
        (selection) =>
            selection.sourceType == sourceType &&
            selection.sourceId == sourceId,
      )
      .toList()
    ..sort(
      (left, right) =>
          (left.selectionIndex ?? 0).compareTo(right.selectionIndex ?? 0),
    );
}

List<CharacterStartingEquipmentSelectionData>
    normalizeStartingEquipmentSelections({
  required List<StartingEquipmentBlockView> blocks,
  required List<CharacterStartingEquipmentSelectionData> selections,
  required ChoiceSourceType sourceType,
  required int sourceId,
}) {
  final sourceSelections = selectionsForEquipmentSource(
    selections: selections,
    sourceType: sourceType,
    sourceId: sourceId,
  );
  final normalized = <CharacterStartingEquipmentSelectionData>[];

  for (final blockView in blocks) {
    final block = blockView.block;
    final blockKey = normalizedEquipmentKey(block?.blockKey);
    if (block == null || blockKey == null) {
      continue;
    }

    final blockSelections = sourceSelections
        .where((selection) =>
            normalizedEquipmentKey(selection.blockKey) == blockKey)
        .toList();
    switch (block.kind) {
      case StartingEquipmentBlockKind.fixedGrant:
        final normalizedSelection = _normalizeFixedBlockSelection(
          block: block,
          lines: blockView.fixedLines ?? const <StartingEquipmentLineData>[],
          selections: blockSelections,
          sourceType: sourceType,
          sourceId: sourceId,
        );
        if (normalizedSelection != null) {
          normalized.add(normalizedSelection);
        }
      case StartingEquipmentBlockKind.choice:
        normalized.addAll(
          _normalizeChoiceBlockSelections(
            block: block,
            options: blockView.options ?? const <StartingEquipmentOptionView>[],
            selections: blockSelections,
            sourceType: sourceType,
            sourceId: sourceId,
          ),
        );
      case null:
        continue;
    }
  }

  return normalized;
}

List<CharacterStartingEquipmentSelectionData>
    replaceEquipmentSelectionsForSource({
  required List<CharacterStartingEquipmentSelectionData> existingSelections,
  required ChoiceSourceType sourceType,
  required List<CharacterStartingEquipmentSelectionData> replacementSelections,
}) {
  final preserved = existingSelections
      .where((selection) => selection.sourceType != sourceType)
      .toList();
  return [...preserved, ...replacementSelections];
}

String? normalizedEquipmentKey(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return null;
  }
  return trimmed;
}

CharacterStartingEquipmentSelectionData? _normalizeFixedBlockSelection({
  required StartingEquipmentBlockData block,
  required List<StartingEquipmentLineData> lines,
  required List<CharacterStartingEquipmentSelectionData> selections,
  required ChoiceSourceType sourceType,
  required int sourceId,
}) {
  final resolvableLines = {
    for (final line in lines)
      if (startingEquipmentLineRequiresResolution(line) &&
          normalizedEquipmentKey(line.lineKey) != null)
        normalizedEquipmentKey(line.lineKey)!: line,
  };
  if (resolvableLines.isEmpty) {
    return null;
  }

  final resolutions = _normalizeResolutions(
    linesByKey: resolvableLines,
    resolutions: [
      for (final selection in selections) ...?selection.resolutions,
    ],
  );
  if (resolutions.isEmpty) {
    return null;
  }

  return CharacterStartingEquipmentSelectionData(
    sourceType: sourceType,
    sourceId: sourceId,
    blockKey: block.blockKey,
    selectionIndex: 0,
    resolutions: resolutions,
  );
}

List<CharacterStartingEquipmentSelectionData> _normalizeChoiceBlockSelections({
  required StartingEquipmentBlockData block,
  required List<StartingEquipmentOptionView> options,
  required List<CharacterStartingEquipmentSelectionData> selections,
  required ChoiceSourceType sourceType,
  required int sourceId,
}) {
  final optionsByKey = {
    for (final optionView in options)
      if (normalizedEquipmentKey(optionView.option?.optionKey) != null)
        normalizedEquipmentKey(optionView.option!.optionKey)!: optionView,
  };
  if (optionsByKey.isEmpty) {
    return const <CharacterStartingEquipmentSelectionData>[];
  }

  final normalized = <CharacterStartingEquipmentSelectionData>[];
  final selectionLimit = block.selectionCount ?? 1;
  final candidateSelections = [
    for (final selection in selections)
      if (normalizedEquipmentKey(selection.optionKey) != null &&
          optionsByKey.containsKey(normalizedEquipmentKey(selection.optionKey)))
        selection,
  ]..sort(
      (left, right) =>
          (left.selectionIndex ?? 0).compareTo(right.selectionIndex ?? 0),
    );

  for (var index = 0;
      index < candidateSelections.length && normalized.length < selectionLimit;
      index++) {
    final selection = candidateSelections[index];
    final optionKey = normalizedEquipmentKey(selection.optionKey);
    if (optionKey == null) {
      continue;
    }
    final optionView = optionsByKey[optionKey];
    if (optionView == null) {
      continue;
    }

    final resolvableLines = {
      for (final line
          in optionView.lines ?? const <StartingEquipmentLineData>[])
        if (startingEquipmentLineRequiresResolution(line) &&
            normalizedEquipmentKey(line.lineKey) != null)
          normalizedEquipmentKey(line.lineKey)!: line,
    };
    final normalizedResolutions = _normalizeResolutions(
      linesByKey: resolvableLines,
      resolutions: selection.resolutions ?? const [],
    );

    normalized.add(
      CharacterStartingEquipmentSelectionData(
        sourceType: sourceType,
        sourceId: sourceId,
        blockKey: block.blockKey,
        optionKey: optionView.option?.optionKey,
        selectionIndex: normalized.length,
        resolutions: normalizedResolutions,
      ),
    );
  }

  return normalized;
}

List<CharacterStartingEquipmentResolutionData> _normalizeResolutions({
  required Map<String, StartingEquipmentLineData> linesByKey,
  required List<CharacterStartingEquipmentResolutionData> resolutions,
}) {
  if (linesByKey.isEmpty || resolutions.isEmpty) {
    return const <CharacterStartingEquipmentResolutionData>[];
  }

  final normalized = <CharacterStartingEquipmentResolutionData>[];
  final seenLineKeys = <String>{};
  for (final resolution in resolutions) {
    final lineKey = normalizedEquipmentKey(resolution.lineKey);
    if (lineKey == null || seenLineKeys.contains(lineKey)) {
      continue;
    }
    final line = linesByKey[lineKey];
    final referenceKey = normalizedEquipmentKey(resolution.referenceKey);
    if (line == null || referenceKey == null) {
      continue;
    }

    final expectedType = switch (line.kind) {
      StartingEquipmentLineKind.weaponCategory => EquipmentCatalogType.weapon,
      StartingEquipmentLineKind.itemCategory => EquipmentCatalogType.item,
      StartingEquipmentLineKind.catalogRef || null => line.catalogType,
    };
    if (expectedType == null || resolution.catalogType != expectedType) {
      continue;
    }

    normalized.add(
      CharacterStartingEquipmentResolutionData(
        lineKey: line.lineKey,
        catalogType: expectedType,
        referenceKey: referenceKey,
        quantity: resolution.quantity ?? line.quantity,
      ),
    );
    seenLineKeys.add(lineKey);
  }

  return normalized;
}
