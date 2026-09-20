import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_item_id.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_autosize_text_field.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/weapon_attack_builder.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/helpers/sheet_autosave.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/helpers/attack_dialog_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InventoryPage extends ConsumerWidget {
  const InventoryPage({
    required this.characterId,
    super.key,
  });

  final int characterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(characterSheetControllerProvider(characterId));
    final weapons = ref.watch(weaponCatalogProvider).valueOrNull;

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Text(humanReadableError(error)),
      ),
      data: (character) => Padding(
        padding: const EdgeInsets.all(12),
        child: PageSizeLimiter(
          child: _EquipmentEditor(
            character: character,
            weapons: weapons,
            onItemChanged: (id, value) {
              runCharacterSheetSave(
                context,
                ref
                    .read(
                      characterSheetControllerProvider(characterId).notifier,
                    )
                    .saveEquipmentItem(id, value),
              );
            },
            onItemDelete: (id) => ref
                .read(characterSheetControllerProvider(characterId).notifier)
                .deleteEquipmentItem(id),
            onAddAttack: (attack) => ref
                .read(characterSheetControllerProvider(characterId).notifier)
                .addAttack(attack),
            onCreateAttack: (initialAttack) =>
                AttackDialogController.createAttack(
              context: context,
              ref: ref,
              characterId: characterId,
              initialAttack: initialAttack,
            ),
          ),
        ),
      ),
    );
  }
}

class _EquipmentEditor extends StatefulWidget {
  const _EquipmentEditor({
    required this.character,
    required this.onItemChanged,
    required this.onItemDelete,
    required this.onAddAttack,
    required this.onCreateAttack,
    this.weapons,
  });

  final CharacterData character;
  final List<WeaponData>? weapons;
  final void Function(String id, String? value) onItemChanged;
  final Future<void> Function(String id) onItemDelete;
  final Future<void> Function(CharacterAttackData attack) onAddAttack;
  final Future<void> Function(CharacterAttackData initialAttack) onCreateAttack;

  @override
  State<_EquipmentEditor> createState() => _EquipmentEditorState();
}

class _EquipmentEditorState extends State<_EquipmentEditor> {
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];
  final List<String> _itemIds = [];
  String? _selectedText;

  @override
  void initState() {
    super.initState();
    _syncItems(widget.character.equipment);
  }

  @override
  void didUpdateWidget(_EquipmentEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_hasAnyFocus && !_matchesIncoming(widget.character.equipment)) {
      _syncItems(widget.character.equipment);
    }
  }

  @override
  void dispose() {
    _disposeEditors();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AppSectionHeader(
          title: 'Инвентарь',
          showDivider: false,
          trailing: IconButton(
            tooltip: 'Добавить предмет',
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ),
        const SizedBox(height: 12),
        if (_controllers.isEmpty)
          const AppSurfaceCard(
            padding: EdgeInsets.all(16),
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Text('Инвентарь пока пуст'),
          )
        else
          for (var index = 0; index < _controllers.length; index++) ...[
            AppSurfaceCard(
              padding: const EdgeInsets.all(16),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppAutosizeTextField(
                    label: index == 0 ? 'Снаряжение' : 'Предмет ${index + 1}',
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    minLines: 2,
                    onChanged: (value) => _queueSave(index, value),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      tooltip: 'Удалить предмет',
                      onPressed: () => _deleteItem(index),
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ),
                ],
              ),
            ),
            if (index + 1 < _controllers.length) const SizedBox(height: 12),
          ],
        if (_selectedText != null) ...[
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: FilledButton(
              onPressed: () => _addSelectedTextToAttacks(_selectedText!),
              child: const Text('Добавить в атаки'),
            ),
          ),
        ],
      ],
    );
  }

  void _handleControllerChanged(int index) {
    final selectedText = _selectedEquipmentText(_controllers[index]);
    if (selectedText == _selectedText) {
      return;
    }

    setState(() {
      _selectedText = selectedText;
    });
  }

  String? _selectedEquipmentText(TextEditingController controller) {
    final selection = controller.selection;
    if (!selection.isValid || selection.isCollapsed) {
      return null;
    }

    final text = controller.text;
    final start = selection.start.clamp(0, text.length).toInt();
    final end = selection.end.clamp(0, text.length).toInt();
    if (start == end) {
      return null;
    }

    return normalizedEquipmentSelectionText(
      text.substring(start < end ? start : end, start < end ? end : start),
    );
  }

  Future<void> _addSelectedTextToAttacks(String selectedText) async {
    final weapon = findWeaponByExactName(widget.weapons, selectedText);
    final attackName = weapon?.name ?? selectedText;
    if (_hasAttackNamed(attackName)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Атака уже есть: $attackName'),
        ),
      );
      return;
    }

    if (weapon == null) {
      await widget.onCreateAttack(buildAttackDraftFromSelection(selectedText));
      return;
    }

    try {
      await widget.onAddAttack(
        buildAttackFromWeapon(
          weapon: weapon,
          character: widget.character,
        ),
      );
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Атака добавлена: ${weapon.name ?? selectedText}'),
        ),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(humanReadableError(error)),
        ),
      );
    }
  }

  bool _hasAttackNamed(String? name) {
    final normalizedName =
        normalizedEquipmentSelectionText(name)?.toLowerCase();
    if (normalizedName == null) {
      return false;
    }

    return (widget.character.attacks ?? const <CharacterAttackData>[]).any(
      (attack) =>
          normalizedEquipmentSelectionText(attack.name)?.toLowerCase() ==
          normalizedName,
    );
  }

  void _queueSave(int index, String value) {
    widget.onItemChanged(_itemIds[index], value);
  }

  void _addItem() {
    final ids = [..._itemIds, createCharacterSyncItemId()];
    final names = [..._controllers.map((controller) => controller.text), ''];
    setState(() => _setEditors(ids, names));
    _focusNodes.last.requestFocus();
  }

  void _deleteItem(int index) {
    final id = _itemIds[index];
    final ids = [
      for (var i = 0; i < _itemIds.length; i++)
        if (i != index) _itemIds[i],
    ];
    final names = [
      for (var i = 0; i < _controllers.length; i++)
        if (i != index) _controllers[i].text,
    ];
    setState(() {
      _selectedText = null;
      _setEditors(ids, names);
    });
    runCharacterSheetSave(context, widget.onItemDelete(id));
  }

  void _syncItems(List<CharacterInventoryItemData>? items) {
    final values = items ?? const <CharacterInventoryItemData>[];
    if (values.isEmpty) {
      _setEditors([createCharacterSyncItemId()], ['']);
      return;
    }
    _setEditors(
      [for (final item in values) item.id ?? createCharacterSyncItemId()],
      [for (final item in values) item.name ?? ''],
    );
  }

  void _setEditors(List<String> ids, List<String> names) {
    _disposeEditors();
    _itemIds
      ..clear()
      ..addAll(ids);
    for (var index = 0; index < names.length; index++) {
      final controller = TextEditingController(text: names[index]);
      controller.addListener(() => _handleControllerChanged(index));
      _controllers.add(controller);
      _focusNodes.add(FocusNode());
    }
  }

  void _disposeEditors() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _controllers.clear();
    _focusNodes.clear();
  }

  bool _matchesIncoming(List<CharacterInventoryItemData>? items) {
    final values = items ?? const <CharacterInventoryItemData>[];
    if (values.isEmpty &&
        _controllers.length == 1 &&
        _controllers.single.text.isEmpty) {
      return true;
    }
    if (values.length != _controllers.length) return false;
    for (var index = 0; index < values.length; index++) {
      if (values[index].id != _itemIds[index] ||
          (values[index].name ?? '') != _controllers[index].text) {
        return false;
      }
    }
    return true;
  }

  bool get _hasAnyFocus => _focusNodes.any((node) => node.hasFocus);
}
