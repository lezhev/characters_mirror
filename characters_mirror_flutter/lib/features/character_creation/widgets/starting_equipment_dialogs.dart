import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/starting_equipment_helpers.dart';
import 'package:flutter/material.dart';
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
      if (line.catalogType == EquipmentCatalogType.armor) {
        final armor = await ref.read(armorCatalogProvider.future);
        if (!context.mounted) {
          return null;
        }
        final allowedCategories = {
          for (final category in line.allowedItemCategories ?? const <String>[])
            if (normalizeStartingEquipmentText(category) != null)
              normalizeStartingEquipmentText(category)!,
        };
        final entries = [
          for (final armorItem in armor)
            if (normalizeStartingEquipmentText(armorItem.referenceKey) !=
                    null &&
                normalizeStartingEquipmentText(armorItem.name) != null &&
                (allowedCategories.isEmpty ||
                    allowedCategories.contains(armorItem.categoryValue?.name)))
              StartingEquipmentCatalogDialogEntry(
                referenceKey:
                    normalizeStartingEquipmentText(armorItem.referenceKey)!,
                label: normalizeStartingEquipmentText(armorItem.name)!,
                catalogType: EquipmentCatalogType.armor,
              ),
        ]..sort((left, right) => left.label.compareTo(right.label));
        return _showStartingEquipmentCatalogDialog(
          context: context,
          title: startingEquipmentLineTitle(line),
          selectedReferenceKey: selectedReferenceKey,
          entries: entries,
        );
      }

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
