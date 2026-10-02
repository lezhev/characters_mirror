import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/character_model_extensions.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_autosize_text_field.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/core/ui/input/app_input_limits.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/weapon_attack_builder.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/inventory/inventory_selection_actions.dart';
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
    final armors = ref.watch(armorCatalogProvider).valueOrNull;
    final tools = ref.watch(toolCatalogProvider).valueOrNull;
    final items = ref.watch(itemCatalogProvider).valueOrNull;
    final magicItems = ref.watch(magicItemCatalogProvider).valueOrNull;

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
            armors: armors,
            tools: tools,
            items: items,
            magicItems: magicItems,
            catalogsReady: weapons != null &&
                armors != null &&
                tools != null &&
                items != null &&
                magicItems != null,
            onInventoryChanged: (value) {
              runCharacterSheetSave(
                context,
                ref
                    .read(
                      characterSheetControllerProvider(characterId).notifier,
                    )
                    .saveEquipmentText(value),
              );
            },
            onCreateAttack: (initialAttack) =>
                AttackDialogController.createAttack(
              context: context,
              ref: ref,
              characterId: characterId,
              initialAttack: initialAttack,
            ),
            onEquipArmor: (selection) {
              final save = ref
                  .read(characterSheetControllerProvider(characterId).notifier)
                  .saveEquippedArmor(selection);
              runCharacterSheetSave(context, save);
              return save;
            },
            onEquipShield: (selection) {
              final save = ref
                  .read(characterSheetControllerProvider(characterId).notifier)
                  .saveEquippedShield(selection);
              runCharacterSheetSave(context, save);
              return save;
            },
          ),
        ),
      ),
    );
  }
}

class _EquipmentEditor extends StatefulWidget {
  const _EquipmentEditor({
    required this.character,
    required this.onInventoryChanged,
    required this.onCreateAttack,
    required this.onEquipArmor,
    required this.onEquipShield,
    this.weapons,
    this.armors,
    this.tools,
    this.items,
    this.magicItems,
    this.catalogsReady = false,
  });

  final CharacterData character;
  final List<WeaponData>? weapons;
  final List<ArmorData>? armors;
  final List<ToolData>? tools;
  final List<ItemData>? items;
  final List<MagicItemData>? magicItems;
  final bool catalogsReady;
  final ValueChanged<String> onInventoryChanged;
  final Future<void> Function(CharacterAttackData initialAttack) onCreateAttack;
  final Future<void> Function(CharacterEquipmentSelectionData? selection)
      onEquipArmor;
  final Future<void> Function(CharacterEquipmentSelectionData? selection)
      onEquipShield;

  @override
  State<_EquipmentEditor> createState() => _EquipmentEditorState();
}

class _EquipmentEditorState extends State<_EquipmentEditor> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  String? _selectedText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.character.equipmentText ?? '',
    )..addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(_EquipmentEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_focusNode.hasFocus &&
        widget.character.equipmentText != _controller.text) {
      _controller.text = widget.character.equipmentText ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AppSectionHeader(
          title: 'Инвентарь',
          showDivider: false,
        ),
        const SizedBox(height: 12),
        AppSurfaceCard(
          padding: const EdgeInsets.all(16),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: AppAutosizeTextField(
            label: 'Снаряжение',
            controller: _controller,
            focusNode: _focusNode,
            minLines: 6,
            maxRunes: AppInputLimits.mediumText,
            onChanged: widget.onInventoryChanged,
          ),
        ),
        if (_selectedText != null && widget.catalogsReady) ...[
          const SizedBox(height: 12),
          InventorySelectionActions(
            selectedText: _selectedText,
            character: widget.character,
            weapons: widget.weapons ?? const [],
            armors: widget.armors ?? const [],
            tools: widget.tools ?? const [],
            items: widget.items ?? const [],
            magicItems: widget.magicItems ?? const [],
            onAddWeapon: (weapon) => _addWeaponToAttacks(weapon),
            onCreateManualAttack: (name) => widget.onCreateAttack(
              buildAttackDraftFromSelection(name),
            ),
            onEquipArmor: widget.onEquipArmor,
            onEquipShield: widget.onEquipShield,
            onUnequipArmor: () => widget.onEquipArmor(null),
            onUnequipShield: () => widget.onEquipShield(null),
          ),
        ],
      ],
    );
  }

  void _handleControllerChanged() {
    final selectedText = _selectedEquipmentText(_controller);
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

  Future<void> _addWeaponToAttacks(WeaponData weapon) async {
    final attackName = weapon.name;
    if (_hasAttackNamed(attackName)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Атака уже есть: $attackName'),
        ),
      );
      return;
    }

    try {
      await widget.onCreateAttack(
        buildAttackFromWeapon(
          weapon: weapon,
          character: widget.character,
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
}
