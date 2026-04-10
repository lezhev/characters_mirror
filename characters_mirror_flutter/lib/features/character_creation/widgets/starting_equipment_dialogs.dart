import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/starting_equipment_helpers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StartingEquipmentCatalogDialogEntry {
  const StartingEquipmentCatalogDialogEntry({
    required this.referenceKey,
    required this.label,
    required this.catalogType,
  });

  final String referenceKey;
  final String label;
  final EquipmentCatalogType catalogType;
}

Future<void> showStartingEquipmentOptionDialog({
  required BuildContext context,
  required WidgetRef ref,
  required StartingEquipmentOptionView optionView,
  required bool isSelected,
  required Map<String, String> selectedReferenceKeysByLine,
  required void Function({
    required StartingEquipmentLineData line,
    required EquipmentCatalogType catalogType,
    required String referenceKey,
  }) onSaveResolution,
}) {
  final lines = optionView.lines ?? const <StartingEquipmentLineData>[];
  final title = startingEquipmentOptionTitle(optionView: optionView);

  return showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var index = 0; index < lines.length; index++) ...[
              StartingEquipmentDialogLineTile(
                line: lines[index],
                enabled: isSelected,
                selectedReferenceKey: selectedReferenceKeysByLine[
                    normalizeStartingEquipmentText(lines[index].lineKey)],
                onTap: !startingEquipmentLineRequiresResolution(lines[index])
                    ? null
                    : () async {
                        final choice =
                            await showStartingEquipmentResolutionDialog(
                          context: dialogContext,
                          ref: ref,
                          line: lines[index],
                          selectedReferenceKey: selectedReferenceKeysByLine[
                              normalizeStartingEquipmentText(
                            lines[index].lineKey,
                          )],
                        );
                        if (choice == null) {
                          return;
                        }
                        onSaveResolution(
                          line: lines[index],
                          catalogType: choice.catalogType,
                          referenceKey: choice.referenceKey,
                        );
                        if (dialogContext.mounted) {
                          Navigator.of(dialogContext).pop();
                        }
                      },
              ),
              if (index < lines.length - 1) const Gap(8),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Закрыть'),
        ),
      ],
    ),
  );
}

Future<void> showStartingEquipmentLineDialog({
  required BuildContext context,
  required WidgetRef ref,
  required StartingEquipmentLineData line,
  required bool enabled,
  required String? selectedReferenceKey,
  required void Function({
    required EquipmentCatalogType catalogType,
    required String referenceKey,
  }) onSaveResolution,
}) async {
  if (!startingEquipmentLineRequiresResolution(line)) {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(startingEquipmentLineTitle(line)),
        content: Text(startingEquipmentLineDescription(line)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
    return;
  }

  await showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(startingEquipmentLineTitle(line)),
      content: StartingEquipmentDialogLineTile(
        line: line,
        enabled: enabled,
        selectedReferenceKey: selectedReferenceKey,
        onTap: !enabled
            ? null
            : () async {
                final choice = await showStartingEquipmentResolutionDialog(
                  context: dialogContext,
                  ref: ref,
                  line: line,
                  selectedReferenceKey: selectedReferenceKey,
                );
                if (choice == null) {
                  return;
                }
                onSaveResolution(
                  catalogType: choice.catalogType,
                  referenceKey: choice.referenceKey,
                );
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }
              },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Закрыть'),
        ),
      ],
    ),
  );
}

class StartingEquipmentDialogLineTile extends StatelessWidget {
  const StartingEquipmentDialogLineTile({
    required this.line,
    required this.enabled,
    this.selectedReferenceKey,
    this.onTap,
    super.key,
  });

  final StartingEquipmentLineData line;
  final bool enabled;
  final String? selectedReferenceKey;
  final Future<void> Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final canResolve = startingEquipmentLineRequiresResolution(line);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: canResolve && enabled
            ? () async {
                await onTap?.call();
              }
            : null,
        borderRadius: BorderRadius.circular(8),
        child: AppSurfaceCard(
          backgroundColor: colorScheme.surface,
          border: Border.all(
            color: _borderColor(
              context,
              enabled: enabled,
              hasSelection: (selectedReferenceKey ?? '').trim().isNotEmpty,
            ),
            width:
                ((selectedReferenceKey ?? '').trim().isNotEmpty || !canResolve)
                    ? 1.5
                    : 1,
          ),
          child: Text(
            startingEquipmentDialogLineLabel(
              line,
              selectedReferenceKey: selectedReferenceKey,
              enabled: enabled,
            ),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: enabled
                      ? null
                      : colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                ),
          ),
        ),
      ),
    );
  }

  Color _borderColor(
    BuildContext context, {
    required bool enabled,
    required bool hasSelection,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    if (!enabled) {
      return colorScheme.outlineVariant.withValues(alpha: 0.6);
    }
    if (hasSelection || !startingEquipmentLineRequiresResolution(line)) {
      return colorScheme.primary;
    }
    return colorScheme.outlineVariant;
  }
}

Future<StartingEquipmentCatalogDialogEntry?>
    showStartingEquipmentResolutionDialog({
  required BuildContext context,
  required WidgetRef ref,
  required StartingEquipmentLineData line,
  required String? selectedReferenceKey,
}) async {
  switch (line.kind) {
    case StartingEquipmentLineKind.weaponCategory:
      final weapons = await ref.read(weaponCatalogProvider.future);
      if (!context.mounted) {
        return null;
      }
      final allowedCategories = {
        for (final category
            in line.allowedWeaponCategories ?? const <WeaponCategory>[])
          category,
      };
      final entries = [
        for (final weapon in weapons)
          if (normalizeStartingEquipmentText(weapon.referenceKey) != null &&
              normalizeStartingEquipmentText(weapon.name) != null &&
              (allowedCategories.isEmpty ||
                  allowedCategories.contains(weapon.category)))
            StartingEquipmentCatalogDialogEntry(
              referenceKey:
                  normalizeStartingEquipmentText(weapon.referenceKey)!,
              label: normalizeStartingEquipmentText(weapon.name)!,
              catalogType: EquipmentCatalogType.weapon,
            ),
      ]..sort((left, right) => left.label.compareTo(right.label));
      return _showStartingEquipmentCatalogDialog(
        context: context,
        title: startingEquipmentLineTitle(line),
        selectedReferenceKey: selectedReferenceKey,
        entries: entries,
      );
    case StartingEquipmentLineKind.itemCategory:
      final items = await ref.read(itemCatalogProvider.future);
      if (!context.mounted) {
        return null;
      }
      final allowedCategories = {
        for (final category in line.allowedItemCategories ?? const <String>[])
          if (normalizeStartingEquipmentText(category) != null)
            normalizeStartingEquipmentText(category)!,
      };
      final entries = [
        for (final item in items)
          if (normalizeStartingEquipmentText(item.referenceKey) != null &&
              normalizeStartingEquipmentText(item.name) != null &&
              (allowedCategories.isEmpty ||
                  allowedCategories.contains(
                    normalizeStartingEquipmentText(item.category),
                  )))
            StartingEquipmentCatalogDialogEntry(
              referenceKey: normalizeStartingEquipmentText(item.referenceKey)!,
              label: normalizeStartingEquipmentText(item.name)!,
              catalogType: EquipmentCatalogType.item,
            ),
      ]..sort((left, right) => left.label.compareTo(right.label));
      return _showStartingEquipmentCatalogDialog(
        context: context,
        title: startingEquipmentLineTitle(line),
        selectedReferenceKey: selectedReferenceKey,
        entries: entries,
      );
    case StartingEquipmentLineKind.catalogRef:
    case null:
      return null;
  }
}

Future<StartingEquipmentCatalogDialogEntry?>
    _showStartingEquipmentCatalogDialog({
  required BuildContext context,
  required String title,
  required String? selectedReferenceKey,
  required List<StartingEquipmentCatalogDialogEntry> entries,
}) {
  return showDialog<StartingEquipmentCatalogDialogEntry>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: 420,
        child: entries.isEmpty
            ? const Text('Подходящие предметы пока не загружены.')
            : ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 420),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: entries.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    return ListTile(
                      onTap: () => Navigator.of(dialogContext).pop(entry),
                      title: Text(entry.label),
                      trailing: normalizeStartingEquipmentText(
                                  selectedReferenceKey) ==
                              entry.referenceKey
                          ? const Icon(Icons.check_circle_outline)
                          : null,
                    );
                  },
                ),
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Отмена'),
        ),
      ],
    ),
  );
}
