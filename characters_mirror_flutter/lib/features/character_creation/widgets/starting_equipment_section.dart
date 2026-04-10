import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/starting_equipment_cards.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/starting_equipment_dialogs.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/starting_equipment_helpers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StartingEquipmentSection extends ConsumerWidget {
  const StartingEquipmentSection({
    required this.blocks,
    required this.selections,
    required this.onSelectOption,
    required this.onClearBlock,
    required this.onSetResolution,
    super.key,
    this.title = 'Стартовое снаряжение',
  });

  final String title;
  final List<StartingEquipmentBlockView> blocks;
  final List<CharacterStartingEquipmentSelectionData> selections;
  final void Function(
    StartingEquipmentBlockView blockView,
    StartingEquipmentOptionView optionView,
  ) onSelectOption;
  final void Function(StartingEquipmentBlockView blockView) onClearBlock;
  final void Function({
    required StartingEquipmentBlockView blockView,
    required StartingEquipmentLineData line,
    required EquipmentCatalogType catalogType,
    required String referenceKey,
  }) onSetResolution;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (blocks.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(title: title),
        const Gap(8),
        for (var index = 0; index < blocks.length; index++) ...[
          StartingEquipmentBlockCards(
            blockView: blocks[index],
            selections: selections,
            onClearBlock: onClearBlock,
            onShowChoiceDialog: (optionView) async {
              final selection = selectionForStartingEquipmentBlock(
                blocks[index],
                selections: selections,
              );
              final isOptionSelected =
                  isStartingEquipmentOptionSelected(optionView, selection);
              if (!isOptionSelected) {
                onSelectOption(blocks[index], optionView);
              }

              if (!context.mounted) {
                return;
              }

              await showStartingEquipmentOptionDialog(
                context: context,
                ref: ref,
                optionView: optionView,
                isSelected: true,
                selectedReferenceKeysByLine:
                    startingEquipmentResolutionReferenceKeys(
                  selectionForStartingEquipmentOption(
                    selection: isOptionSelected ? selection : null,
                    optionView: optionView,
                  ),
                  optionView.lines ?? const <StartingEquipmentLineData>[],
                ),
                onSaveResolution: ({
                  required line,
                  required catalogType,
                  required referenceKey,
                }) {
                  onSetResolution(
                    blockView: blocks[index],
                    line: line,
                    catalogType: catalogType,
                    referenceKey: referenceKey,
                  );
                },
              );
            },
            onShowFixedLineDialog: (line) async {
              await showStartingEquipmentLineDialog(
                context: context,
                ref: ref,
                line: line,
                enabled: true,
                selectedReferenceKey:
                    selectedStartingEquipmentReferenceKeyForLine(
                  blocks[index],
                  selections: selections,
                  line: line,
                ),
                onSaveResolution: ({
                  required catalogType,
                  required referenceKey,
                }) {
                  onSetResolution(
                    blockView: blocks[index],
                    line: line,
                    catalogType: catalogType,
                    referenceKey: referenceKey,
                  );
                },
              );
            },
          ),
          if (index < blocks.length - 1) const Gap(10),
        ],
      ],
    );
  }
}
