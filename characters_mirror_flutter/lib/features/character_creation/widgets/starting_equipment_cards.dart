import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/starting_equipment_helpers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
      final options =
          blockView.options ?? const <StartingEquipmentOptionView>[];
      if (options.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (normalizeStartingEquipmentText(selection?.optionKey) != null)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => onClearBlock(blockView),
                child: const Text('Сбросить выбор'),
              ),
            ),
          LayoutBuilder(
            builder: (context, constraints) {
              final useRow = constraints.maxWidth >= 560 && options.length > 1;
              final children = [
                for (var index = 0; index < options.length; index++) ...[
                  if (useRow)
                    Expanded(
                      child: StartingEquipmentChoiceCard(
                        title: startingEquipmentOptionTitle(
                            optionView: options[index]),
                        isSelected: isStartingEquipmentOptionSelected(
                            options[index], selection),
                        onTap: () => onShowChoiceDialog(options[index]),
                      ),
                    )
                  else
                    StartingEquipmentChoiceCard(
                      title: startingEquipmentOptionTitle(
                          optionView: options[index]),
                      isSelected: isStartingEquipmentOptionSelected(
                          options[index], selection),
                      onTap: () => onShowChoiceDialog(options[index]),
                    ),
                  if (index < options.length - 1) const Gap(8),
                ],
              ];

              if (useRow) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              );
            },
          ),
        ],
      );
    }

    final fixedLines =
        blockView.fixedLines ?? const <StartingEquipmentLineData>[];
    if (fixedLines.isEmpty) {
      return const SizedBox.shrink();
    }

    final resolvedByLine =
        startingEquipmentResolutionReferenceKeys(selection, fixedLines);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final line in fixedLines)
          StartingEquipmentChoiceCard(
            title: startingEquipmentLineTitle(line),
            isSelected: !startingEquipmentLineRequiresResolution(line) ||
                resolvedByLine.containsKey(
                  normalizeStartingEquipmentText(line.lineKey),
                ),
            onTap: () => onShowFixedLineDialog(line),
          ),
      ],
    );
  }
}

class StartingEquipmentChoiceCard extends StatelessWidget {
  const StartingEquipmentChoiceCard({
    required this.title,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: AppSurfaceCard(
          backgroundColor: colorScheme.surface,
          border: Border.all(
            color:
                isSelected ? colorScheme.primary : colorScheme.outlineVariant,
            width: isSelected ? 1.5 : 1,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
