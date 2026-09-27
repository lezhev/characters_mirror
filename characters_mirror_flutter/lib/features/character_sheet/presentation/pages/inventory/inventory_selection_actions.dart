import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/inventory_selection_matcher.dart';
import 'package:flutter/material.dart';

class InventorySelectionActions extends StatefulWidget {
  const InventorySelectionActions({
    required this.selectedText,
    required this.character,
    required this.onAddWeapon,
    required this.onCreateManualAttack,
    required this.onEquipArmor,
    required this.onEquipShield,
    required this.onUnequipArmor,
    required this.onUnequipShield,
    this.weapons = const [],
    this.armors = const [],
    this.tools = const [],
    this.items = const [],
    this.magicItems = const [],
    super.key,
  });

  final String? selectedText;
  final CharacterData character;
  final List<WeaponData> weapons;
  final List<ArmorData> armors;
  final List<ToolData> tools;
  final List<ItemData> items;
  final List<MagicItemData> magicItems;
  final Future<void> Function(WeaponData weapon) onAddWeapon;
  final Future<void> Function(String name) onCreateManualAttack;
  final Future<void> Function(CharacterEquipmentSelectionData selection)
      onEquipArmor;
  final Future<void> Function(CharacterEquipmentSelectionData selection)
      onEquipShield;
  final Future<void> Function() onUnequipArmor;
  final Future<void> Function() onUnequipShield;

  @override
  State<InventorySelectionActions> createState() =>
      _InventorySelectionActionsState();
}

class _InventorySelectionActionsState extends State<InventorySelectionActions> {
  int? _selectedMatchIndex;

  @override
  void didUpdateWidget(InventorySelectionActions oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedText != widget.selectedText) {
      _selectedMatchIndex = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = widget.selectedText;
    if (selected == null ||
        selected.trim().isEmpty ||
        selected.contains('\n') ||
        selected.contains('\r')) {
      return const SizedBox.shrink();
    }
    final matches = findExactInventoryMatches(
      selectedText: selected,
      weapons: widget.weapons,
      armors: widget.armors,
      tools: widget.tools,
      items: widget.items,
      magicItems: widget.magicItems,
    );
    if (matches.length > 1) {
      final index = _selectedMatchIndex;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButton<int>(
            value: index != null && index < matches.length ? index : null,
            hint: const Text('Выберите справочную запись'),
            items: [
              for (var i = 0; i < matches.length; i++)
                DropdownMenuItem(value: i, child: Text(_label(matches[i]))),
            ],
            onChanged: (value) => setState(() => _selectedMatchIndex = value),
          ),
          if (index != null && index < matches.length)
            _actionsFor(context, matches[index]),
        ],
      );
    }
    if (matches.length == 1) {
      return _actionsFor(context, matches.single);
    }
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        OutlinedButton.icon(
          onPressed: () => widget.onCreateManualAttack(selected.trim()),
          icon: const Icon(Icons.sports_martial_arts),
          label: const Text('Добавить ручную атаку'),
        ),
        OutlinedButton.icon(
          onPressed: () => widget.onEquipArmor(
            CharacterEquipmentSelectionData(name: selected.trim()),
          ),
          icon: const Icon(Icons.shield_outlined),
          label: const Text('Экипировать как доспех'),
        ),
        OutlinedButton.icon(
          onPressed: () => widget.onEquipShield(
            CharacterEquipmentSelectionData(name: selected.trim()),
          ),
          icon: const Icon(Icons.security),
          label: const Text('Экипировать как щит'),
        ),
      ],
    );
  }

  Widget _actionsFor(
    BuildContext context,
    InventoryReferenceMatch match,
  ) {
    switch (match.kind) {
      case InventoryReferenceKind.weapon:
        final weapon = match.entity as WeaponData;
        return Wrap(
          spacing: 8,
          children: [
            OutlinedButton.icon(
              onPressed: () => widget.onAddWeapon(weapon),
              icon: const Icon(Icons.sports_martial_arts),
              label: const Text('Добавить в атаки'),
            ),
            _detailsButton(context, weapon.name, weapon.description),
          ],
        );
      case InventoryReferenceKind.armor:
        final armor = match.entity as ArmorData;
        if (armor.categoryValue == null) {
          return _detailsButton(context, armor.name, armor.description);
        }
        if (armor.categoryValue == ArmorCategory.shield) {
          final equipped = _sameEquipment(
            widget.character.equippedShield,
            armor.referenceKey,
            armor.name,
          );
          return Wrap(
            spacing: 8,
            children: [
              OutlinedButton(
                onPressed: equipped
                    ? widget.onUnequipShield
                    : () => widget.onEquipShield(_selection(armor)),
                child: Text(equipped ? 'Снять щит' : 'Экипировать щит'),
              ),
              _detailsButton(context, armor.name, armor.description),
            ],
          );
        }
        final equipped = _sameEquipment(
          widget.character.equippedArmor,
          armor.referenceKey,
          armor.name,
        );
        return Wrap(
          spacing: 8,
          children: [
            OutlinedButton(
              onPressed: equipped
                  ? widget.onUnequipArmor
                  : () => widget.onEquipArmor(_selection(armor)),
              child: Text(equipped ? 'Снять доспех' : 'Экипировать доспех'),
            ),
            _detailsButton(context, armor.name, armor.description),
          ],
        );
      case InventoryReferenceKind.tool:
        final tool = match.entity as ToolData;
        return _detailsButton(
          context,
          tool.name,
          tool.category == null
              ? 'Описание отсутствует.'
              : 'Описание отсутствует.\nКатегория: ${tool.category!.name}',
        );
      case InventoryReferenceKind.item:
        final item = match.entity as ItemData;
        return _detailsButton(context, item.name, item.description);
      case InventoryReferenceKind.magicItem:
        final item = match.entity as MagicItemData;
        return _detailsButton(context, item.name, item.description);
    }
  }

  Widget _detailsButton(
      BuildContext context, String? name, String? description) {
    return OutlinedButton.icon(
      onPressed: () => showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(name ?? 'Описание'),
          content: Text(
            description?.trim().isNotEmpty == true
                ? description!.trim()
                : 'Описание отсутствует.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Закрыть'),
            ),
          ],
        ),
      ),
      icon: const Icon(Icons.info_outline),
      label: const Text('Описание'),
    );
  }

  bool _sameEquipment(
    CharacterEquipmentSelectionData? current,
    String? referenceKey,
    String? name,
  ) {
    if (current == null) return false;
    if (referenceKey != null) return current.referenceKey == referenceKey;
    return _normalized(current.name) == _normalized(name);
  }

  CharacterEquipmentSelectionData _selection(ArmorData armor) =>
      CharacterEquipmentSelectionData(
        referenceKey: armor.referenceKey,
        name: armor.name ?? '',
      );

  String _label(InventoryReferenceMatch match) {
    final name = switch (match.kind) {
      InventoryReferenceKind.weapon => (match.entity as WeaponData).name,
      InventoryReferenceKind.armor => (match.entity as ArmorData).name,
      InventoryReferenceKind.tool => (match.entity as ToolData).name,
      InventoryReferenceKind.item => (match.entity as ItemData).name,
      InventoryReferenceKind.magicItem => (match.entity as MagicItemData).name,
    };
    final kind = switch (match.kind) {
      InventoryReferenceKind.weapon => 'Оружие',
      InventoryReferenceKind.armor => 'Броня',
      InventoryReferenceKind.tool => 'Инструмент',
      InventoryReferenceKind.item => 'Предмет',
      InventoryReferenceKind.magicItem => 'Магический предмет',
    };
    return '$name · $kind';
  }

  String? _normalized(String? value) =>
      value?.trim().replaceAll(RegExp(r'\s+'), ' ').toLowerCase();
}
