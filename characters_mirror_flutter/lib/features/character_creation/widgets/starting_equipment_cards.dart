import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_choice_selector.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/starting_equipment_helpers.dart';
import 'package:flutter/material.dart';

class StartingEquipmentBlockCards extends StatelessWidget {
  const StartingEquipmentBlockCards({
    required this.blockView,
    required this.catalogLabels,
    required this.selections,
    required this.onClearBlock,
    required this.onSelectFixedBlock,
    required this.onShowChoiceDialog,
    required this.onShowFixedLineDialog,
    super.key,
  });

  final StartingEquipmentBlockView blockView;
  final StartingEquipmentCatalogLabels catalogLabels;
  final List<CharacterStartingEquipmentSelectionData> selections;
  final void Function(StartingEquipmentBlockView blockView) onClearBlock;
  final void Function(StartingEquipmentBlockView blockView) onSelectFixedBlock;
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
        final title = startingEquipmentOptionTitle(
          optionView: optionView,
          catalogLabels: catalogLabels,
        );
        return CreationChoiceSelectorItem(
          id: '${optionView.option?.entryId ?? title}',
          title: title,
          isSelected: isStartingEquipmentOptionSelected(optionView, selection),
          onTap: () => onShowChoiceDialog(optionView),
        );
      }).toList();

      if (selectionCount <= 1) {
        return CreationChoiceSelector.single(
          title: null,
          switchKey: '${block.entryId ?? 'equipment_choice'}',
          autoScrollOnExpand: false,
          surface: false,
          adaptivePairLayout: options.length == 2,
          items: items,
        );
      }

      return CreationChoiceSelector.multi(
        title: null,
        switchKey: '${block.entryId ?? 'equipment_choice'}',
        selectionLimit: selectionCount,
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
    final isSelected = selection?.isSelected != false;

    return CreationChoiceSelector.fixed(
      title: null,
      switchKey: '${block.entryId ?? 'equipment_fixed'}',
      surface: false,
      items: [
        for (final line in fixedLines)
          _fixedLineItem(
            line,
            isBlockSelected: isSelected,
            selectedReferenceKey: resolvedByLine[line.entryId],
          ),
      ],
    );
  }

  CreationChoiceSelectorItem _fixedLineItem(
    StartingEquipmentLineData line, {
    required bool isBlockSelected,
    required String? selectedReferenceKey,
  }) {
    final requiresResolution = startingEquipmentLineRequiresResolution(line);
    final isLineResolved = selectedReferenceKey != null;
    final lineTitle = startingEquipmentLineTitle(
      line,
      catalogLabels: catalogLabels,
      selectedReferenceKey: selectedReferenceKey,
    );
    final isLineSelected =
        isBlockSelected && (!requiresResolution || isLineResolved);
    return CreationChoiceSelectorItem(
      id: '${line.entryId ?? lineTitle}',
      title: lineTitle,
      isSelected: isLineSelected,
      onTap: requiresResolution
          ? () => onShowFixedLineDialog(line)
          : isLineSelected
              ? () => onClearBlock(blockView)
              : () => onSelectFixedBlock(blockView),
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
