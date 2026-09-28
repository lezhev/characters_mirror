import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_choice_selector.dart';
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
    required this.onSelectFixedBlock,
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
  final void Function(StartingEquipmentBlockView blockView) onSelectFixedBlock;
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
    final catalogLabels = <EquipmentCatalogType, Map<String, String>>{
      EquipmentCatalogType.weapon: buildStartingEquipmentWeaponLabels(
        ref.watch(weaponCatalogProvider).valueOrNull ?? const <WeaponData>[],
      ),
      EquipmentCatalogType.armor: buildStartingEquipmentArmorLabels(
        ref.watch(armorCatalogProvider).valueOrNull ?? const <ArmorData>[],
      ),
      EquipmentCatalogType.item: buildStartingEquipmentItemLabels(
        ref.watch(itemCatalogProvider).valueOrNull ?? const <ItemData>[],
      ),
      EquipmentCatalogType.tool: buildStartingEquipmentToolLabels(
        ref.watch(toolCatalogProvider).valueOrNull ?? const <ToolData>[],
      ),
    };
    final orderedBlocks = _orderedStartingEquipmentBlocks(blocks);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CreationChoiceSelectorSurface(
          title: title,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var index = 0; index < orderedBlocks.length; index++) ...[
                  StartingEquipmentBlockCards(
                    blockView: orderedBlocks[index],
                    catalogLabels: catalogLabels,
                    selections: selections,
                    onClearBlock: onClearBlock,
                    onSelectFixedBlock: onSelectFixedBlock,
                    onShowChoiceDialog: (optionView) async {
                      final selection = selectionForStartingEquipmentBlock(
                        orderedBlocks[index],
                        selections: selections,
                      );
                      final isOptionSelected =
                          isStartingEquipmentOptionSelected(
                        optionView,
                        selection,
                      );
                      if (isOptionSelected) {
                        onClearBlock(orderedBlocks[index]);
                        return;
                      }

                      if (!context.mounted) {
                        return;
                      }

                      final resolutions = await _showRequiredResolutionDialogs(
                        context: context,
                        ref: ref,
                        lines: optionView.lines ??
                            const <StartingEquipmentLineData>[],
                        selectedReferenceKeysByLine: const {},
                      );
                      if (resolutions == null || !context.mounted) return;
                      onSelectOption(orderedBlocks[index], optionView);
                      for (final resolution in resolutions) {
                        onSetResolution(
                          blockView: orderedBlocks[index],
                          line: resolution.line,
                          catalogType: resolution.choice.catalogType,
                          referenceKey: resolution.choice.referenceKey,
                        );
                      }
                    },
                    onShowFixedLineDialog: (line) async {
                      if (!startingEquipmentLineRequiresResolution(line)) {
                        return;
                      }

                      final choice =
                          await showStartingEquipmentResolutionDialog(
                        context: context,
                        ref: ref,
                        line: line,
                        selectedReferenceKey:
                            selectedStartingEquipmentReferenceKeyForLine(
                          orderedBlocks[index],
                          selections: selections,
                          line: line,
                        ),
                      );
                      if (choice == null) {
                        return;
                      }

                      onSetResolution(
                        blockView: orderedBlocks[index],
                        line: line,
                        catalogType: choice.catalogType,
                        referenceKey: choice.referenceKey,
                      );
                    },
                  ),
                  if (index < orderedBlocks.length - 1) const Gap(8),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

List<StartingEquipmentBlockView> _orderedStartingEquipmentBlocks(
  List<StartingEquipmentBlockView> blocks,
) {
  final ordered = [...blocks];
  ordered.sort((left, right) {
    final leftIsChoice =
        left.block?.kind == StartingEquipmentBlockKind.choice ? 0 : 1;
    final rightIsChoice =
        right.block?.kind == StartingEquipmentBlockKind.choice ? 0 : 1;
    final kindCompare = leftIsChoice.compareTo(rightIsChoice);
    if (kindCompare != 0) {
      return kindCompare;
    }
    return (left.block?.orderIndex ?? 0).compareTo(
      right.block?.orderIndex ?? 0,
    );
  });
  return ordered;
}

Future<
    List<
        ({
          StartingEquipmentLineData line,
          StartingEquipmentCatalogDialogEntry choice
        })>?> _showRequiredResolutionDialogs({
  required BuildContext context,
  required WidgetRef ref,
  required List<StartingEquipmentLineData> lines,
  required Map<int, String> selectedReferenceKeysByLine,
}) async {
  final resolutions = <({
    StartingEquipmentLineData line,
    StartingEquipmentCatalogDialogEntry choice
  })>[];
  for (final line in lines) {
    if (!startingEquipmentLineRequiresResolution(line)) {
      continue;
    }
    final choice = await showStartingEquipmentResolutionDialog(
      context: context,
      ref: ref,
      line: line,
      selectedReferenceKey: selectedReferenceKeysByLine[line.entryId],
    );
    if (choice == null) {
      return null;
    }
    resolutions.add((line: line, choice: choice));
    if (!context.mounted) {
      return null;
    }
  }
  return resolutions;
}
