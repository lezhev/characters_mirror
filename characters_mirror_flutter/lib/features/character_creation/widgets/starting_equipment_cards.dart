import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_choice_selector.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/starting_equipment_helpers.dart';
import 'package:flutter/material.dart';

class StartingEquipmentBlockCards extends StatelessWidget {
  const StartingEquipmentBlockCards({
    required this.blockView,
    required this.selections,
    required this.onClearBlock,
    required this.onShowChoiceDialog,
    required this.onShowFixedLineDialog,
    super.key,
  });

  final StartingEquipmentBlockView blockView;
  final List<CharacterStartingEquipmentSelectionData> selections;
  final void Function(StartingEquipmentBlockView blockView) onClearBlock;
  final Future<void> Function(StartingEquipmentOptionView optionView)
      onShowChoiceDialog;
  final Future<void> Function(StartingEquipmentLineData line)
      onShowFixedLineDialog;

  @override
  Widget build(BuildContext context) {
    final block = blockView.block;
    if (block == null) {
      return const SizedBox.shrink();
    }

    final selection =
        selectionForStartingEquipmentBlock(blockView, selections: selections);
    if (block.kind == StartingEquipmentBlockKind.choice) {
      final options = _equipmentOptionViews(blockView);
      if (options.isEmpty) {
        return const SizedBox.shrink();
      }

      final selectionCount = block.selectionCount ?? 1;
      final items = options.map((optionView) {
        final title = startingEquipmentOptionTitle(optionView: optionView);
        final optionKey = normalizeStartingEquipmentText(
          optionView.option?.optionKey,
        );
        return CreationChoiceSelectorItem(
          id: optionKey ?? title,
          title: title,
          subtitle: optionView.option?.description,
          isSelected: isStartingEquipmentOptionSelected(optionView, selection),
          onTap: () => onShowChoiceDialog(optionView),
        );
      }).toList();

      if (selectionCount <= 1) {
        return CreationChoiceSelector.single(
          title:
              normalizeStartingEquipmentText(block.name) ?? 'Выбор снаряжения',
          description: block.description,
          switchKey: block.blockKey ?? 'equipment_choice',
          onClear: normalizeStartingEquipmentText(selection?.optionKey) != null
              ? () => onClearBlock(blockView)
              : null,
          autoScrollOnExpand: false,
          surface: false,
          adaptivePairLayout: options.length == 2,
          items: items,
        );
      }

      return CreationChoiceSelector.multi(
        title: normalizeStartingEquipmentText(block.name) ?? 'Выбор снаряжения',
        description: block.description,
        switchKey: block.blockKey ?? 'equipment_choice',
        selectionLimit: selectionCount,
        onClear: normalizeStartingEquipmentText(selection?.optionKey) != null
            ? () => onClearBlock(blockView)
            : null,
        autoScrollOnExpand: false,
        surface: false,
        items: items,
      );
    }

    final fixedLines = _equipmentFixedLines(blockView);
    if (fixedLines.isEmpty) {
      return const SizedBox.shrink();
    }

    final resolvedByLine =
        startingEquipmentResolutionReferenceKeys(selection, fixedLines);

    return CreationChoiceSelector.fixed(
      title: normalizeStartingEquipmentText(block.name),
      description: block.description,
      switchKey: block.blockKey ?? 'equipment_fixed',
      surface: false,
      items: [
        for (final line in fixedLines)
          CreationChoiceSelectorItem(
            id: normalizeStartingEquipmentText(line.lineKey) ??
                startingEquipmentLineTitle(line),
            title: startingEquipmentLineTitle(line),
            subtitle: startingEquipmentLineRequiresResolution(line)
                ? startingEquipmentLineDescription(line)
                : null,
            isSelected: !startingEquipmentLineRequiresResolution(line) ||
                resolvedByLine.containsKey(
                  normalizeStartingEquipmentText(line.lineKey),
                ),
            isEnabled: startingEquipmentLineRequiresResolution(line),
            onTap: startingEquipmentLineRequiresResolution(line)
                ? () => onShowFixedLineDialog(line)
                : null,
          ),
      ],
    );
  }
}

List<StartingEquipmentLineData> _equipmentFixedLines(
  StartingEquipmentBlockView blockView,
) {
  final lines = blockView.block?.fixedLines;
  if (lines != null && lines.isNotEmpty) {
    return lines;
  }
  return blockView.fixedLines ?? const <StartingEquipmentLineData>[];
}

List<StartingEquipmentOptionView> _equipmentOptionViews(
  StartingEquipmentBlockView blockView,
) {
  final options = blockView.block?.options;
  if (options != null && options.isNotEmpty) {
    return [
      for (final option in options)
        StartingEquipmentOptionView(
          option: option,
          lines: option.lines ?? const <StartingEquipmentLineData>[],
        ),
    ];
  }
  return blockView.options ?? const <StartingEquipmentOptionView>[];
}
