import 'package:characters_mirror_client/characters_mirror_client.dart';

bool startingEquipmentLineRequiresResolution(StartingEquipmentLineData line) {
  return line.kind == StartingEquipmentLineKind.weaponCategory ||
      line.kind == StartingEquipmentLineKind.itemCategory;
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
    final sourceEntryId = block?.entryId;
    if (block == null || sourceEntryId == null) {
      continue;
    }

    final blockSelections = sourceSelections
        .where((selection) => selection.sourceEntryId == sourceEntryId)
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

List<CharacterStartingEquipmentSelectionData> selectionsForEquipmentSource({
  required List<CharacterStartingEquipmentSelectionData> selections,
  required ChoiceSourceType sourceType,
  required int sourceId,
}) {
  return selections
      .where(
        (selection) =>
            selection.sourceType == sourceType && selection.sourceId == sourceId,
      )
      .toList()
    ..sort(
      (left, right) =>
          (left.selectionIndex ?? 0).compareTo(right.selectionIndex ?? 0),
    );
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

CharacterStartingEquipmentSelectionData? _normalizeFixedBlockSelection({
  required StartingEquipmentBlockData block,
  required List<StartingEquipmentLineData> lines,
  required List<CharacterStartingEquipmentSelectionData> selections,
  required ChoiceSourceType sourceType,
  required int sourceId,
}) {
  final resolvableLineIds = {
    for (final line in lines)
      if (startingEquipmentLineRequiresResolution(line) && line.entryId != null)
        line.entryId!: line,
  };
  CharacterStartingEquipmentSelectionData? existingSelection;
  for (final selection in selections) {
    existingSelection = selection;
    break;
  }
  final currentSelection = existingSelection;
  if (currentSelection?.isSelected == false) {
    return currentSelection!.copyWith(
      sourceType: sourceType,
      sourceId: sourceId,
      sourceEntryId: block.entryId,
      choiceOptionEntryId: null,
      isSelected: false,
      selectionIndex: 0,
      resolutions: const [],
    );
  }

  final resolutions = _normalizeResolutions(
    linesById: resolvableLineIds,
    resolutions: [
      for (final selection in selections) ...?selection.resolutions,
    ],
  );

  return CharacterStartingEquipmentSelectionData(
    sourceType: sourceType,
    sourceId: sourceId,
    sourceEntryId: block.entryId,
    isSelected: true,
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
  final optionsById = {
    for (final optionView in options)
      if (optionView.option?.entryId != null)
        optionView.option!.entryId!: optionView,
  };
  if (optionsById.isEmpty) {
    return const <CharacterStartingEquipmentSelectionData>[];
  }

  final normalized = <CharacterStartingEquipmentSelectionData>[];
  final selectionLimit = block.selectionCount ?? 1;
  final candidateSelections = [
    for (final selection in selections)
      if (selection.choiceOptionEntryId != null &&
          optionsById.containsKey(selection.choiceOptionEntryId))
        selection,
  ]..sort(
      (left, right) =>
          (left.selectionIndex ?? 0).compareTo(right.selectionIndex ?? 0),
    );

  for (var index = 0;
      index < candidateSelections.length && normalized.length < selectionLimit;
      index++) {
    final selection = candidateSelections[index];
    final optionView = optionsById[selection.choiceOptionEntryId];
    if (optionView == null) {
      continue;
    }

    final resolvableLines = {
      for (final line
          in optionView.lines ?? const <StartingEquipmentLineData>[])
        if (startingEquipmentLineRequiresResolution(line) &&
            line.entryId != null)
          line.entryId!: line,
    };
    final normalizedResolutions = _normalizeResolutions(
      linesById: resolvableLines,
      resolutions: selection.resolutions ?? const [],
    );

    normalized.add(
      CharacterStartingEquipmentSelectionData(
        sourceType: sourceType,
        sourceId: sourceId,
        sourceEntryId: block.entryId,
        choiceOptionEntryId: optionView.option?.entryId,
        isSelected: selection.isSelected ?? true,
        selectionIndex: normalized.length,
        resolutions: normalizedResolutions,
      ),
    );
  }

  return normalized;
}

List<CharacterStartingEquipmentResolutionData> _normalizeResolutions({
  required Map<int, StartingEquipmentLineData> linesById,
  required List<CharacterStartingEquipmentResolutionData> resolutions,
}) {
  if (linesById.isEmpty || resolutions.isEmpty) {
    return const <CharacterStartingEquipmentResolutionData>[];
  }

  final normalized = <CharacterStartingEquipmentResolutionData>[];
  final seenLineIds = <int>{};
  for (final resolution in resolutions) {
    final lineId = resolution.sourceLineEntryId;
    if (lineId == null || seenLineIds.contains(lineId)) {
      continue;
    }
    final line = linesById[lineId];
    final referenceKey = normalizedEquipmentText(resolution.referenceKey);
    if (line == null || referenceKey == null) {
      continue;
    }

    final expectedType = switch (line.kind) {
      StartingEquipmentLineKind.weaponCategory => EquipmentCatalogType.weapon,
      StartingEquipmentLineKind.itemCategory =>
        line.catalogType ?? EquipmentCatalogType.item,
      StartingEquipmentLineKind.catalogRef || null => line.catalogType,
    };
    if (expectedType == null || resolution.catalogType != expectedType) {
      continue;
    }

    normalized.add(
      CharacterStartingEquipmentResolutionData(
        sourceLineEntryId: line.entryId,
        catalogType: expectedType,
        referenceKey: referenceKey,
        quantity: resolution.quantity ?? line.quantity,
      ),
    );
    seenLineIds.add(lineId);
  }

  return normalized;
}

String? normalizedEquipmentText(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return null;
  }
  return trimmed;
}
