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

CharacterStartingEquipmentSelectionData? selectionForStartingEquipmentBlock(
  StartingEquipmentBlockView blockView, {
  required List<CharacterStartingEquipmentSelectionData> selections,
}) {
  final blockKey = normalizeStartingEquipmentText(blockView.block?.blockKey);
  if (blockKey == null) {
    return null;
  }
  for (final selection in selections) {
    if (normalizeStartingEquipmentText(selection.blockKey) == blockKey) {
      return selection;
    }
  }
  return null;
}

CharacterStartingEquipmentSelectionData? selectionForStartingEquipmentOption({
  required CharacterStartingEquipmentSelectionData? selection,
  required StartingEquipmentOptionView optionView,
}) {
  final optionKey =
      normalizeStartingEquipmentText(optionView.option?.optionKey);
  if (selection == null || optionKey == null) {
    return null;
  }
  return normalizeStartingEquipmentText(selection.optionKey) == optionKey
      ? selection
      : null;
}

bool isStartingEquipmentOptionSelected(
  StartingEquipmentOptionView optionView,
  CharacterStartingEquipmentSelectionData? selection,
) {
  final optionKey =
      normalizeStartingEquipmentText(optionView.option?.optionKey);
  return optionKey != null &&
      normalizeStartingEquipmentText(selection?.optionKey) == optionKey;
}

Map<String, String> startingEquipmentResolutionReferenceKeys(
  CharacterStartingEquipmentSelectionData? selection,
  List<StartingEquipmentLineData> lines,
) {
  if (selection == null) {
    return const {};
  }

  final lineKeys = {
    for (final line in lines)
      if (normalizeStartingEquipmentText(line.lineKey) != null)
        normalizeStartingEquipmentText(line.lineKey)!,
  };
  final values = <String, String>{};
  for (final resolution in selection.resolutions ??
      const <CharacterStartingEquipmentResolutionData>[]) {
    final lineKey = normalizeStartingEquipmentText(resolution.lineKey);
    final referenceKey =
        normalizeStartingEquipmentText(resolution.referenceKey);
    if (lineKey == null ||
        referenceKey == null ||
        !lineKeys.contains(lineKey)) {
      continue;
    }
    values[lineKey] = referenceKey;
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
  final lineKey = normalizeStartingEquipmentText(line.lineKey);
  if (selection == null || lineKey == null) {
    return null;
  }
  for (final resolution in selection.resolutions ??
      const <CharacterStartingEquipmentResolutionData>[]) {
    if (normalizeStartingEquipmentText(resolution.lineKey) == lineKey) {
      return normalizeStartingEquipmentText(resolution.referenceKey);
    }
  }
  return null;
}

String startingEquipmentOptionTitle({
  required StartingEquipmentOptionView optionView,
}) {
  return normalizeStartingEquipmentText(optionView.option?.name) ?? 'Вариант';
}

String startingEquipmentLineTitle(StartingEquipmentLineData line) {
  final displayText =
      normalizeStartingEquipmentText(line.displayText) ?? 'Предмет';
  final quantity = line.quantity ?? 1;
  return quantity > 1 ? '$quantity $displayText' : displayText;
}

String startingEquipmentLineDescription(StartingEquipmentLineData line) {
  if (startingEquipmentLineRequiresResolution(line)) {
    final selectedHint = line.kind == StartingEquipmentLineKind.weaponCategory
        ? 'Выберите конкретное оружие из списка.'
        : 'Выберите конкретный предмет из списка.';
    return '${startingEquipmentLineTitle(line)}\n\n$selectedHint';
  }
  return startingEquipmentLineTitle(line);
}

String startingEquipmentDialogLineLabel(
  StartingEquipmentLineData line, {
  required String? selectedReferenceKey,
  required bool enabled,
}) {
  if (!startingEquipmentLineRequiresResolution(line)) {
    return startingEquipmentLineTitle(line);
  }
  final selected = normalizeStartingEquipmentText(selectedReferenceKey);
  if (selected != null) {
    return '${startingEquipmentLineTitle(line)}\nВыбрано: $selected';
  }
  if (!enabled) {
    return '${startingEquipmentLineTitle(line)}\nСначала выберите этот вариант.';
  }
  return '${startingEquipmentLineTitle(line)}\nНажмите, чтобы выбрать предмет.';
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
