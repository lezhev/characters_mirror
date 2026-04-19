import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_autosize_text_field.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/weapon_attack_builder.dart';
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
            onChanged: (value) => ref
                .read(characterSheetControllerProvider(characterId).notifier)
                .saveEquipment(value),
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
    required this.onChanged,
    required this.onAddAttack,
    required this.onCreateAttack,
    this.weapons,
  });

  final CharacterData character;
  final List<WeaponData>? weapons;
  final Future<void> Function(String? value) onChanged;
  final Future<void> Function(CharacterAttackData attack) onAddAttack;
  final Future<void> Function(CharacterAttackData initialAttack) onCreateAttack;

  @override
  State<_EquipmentEditor> createState() => _EquipmentEditorState();
}

class _EquipmentEditorState extends State<_EquipmentEditor> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  String? _lastSavedText;
  String? _pendingText;
  String? _selectedText;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _lastSavedText = widget.character.equipment;
    _controller = TextEditingController(text: _lastSavedText ?? '');
    _controller.addListener(_handleControllerChanged);
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(_EquipmentEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    final incomingText = widget.character.equipment;
    if (!_focusNode.hasFocus && incomingText != _lastSavedText) {
      _lastSavedText = incomingText;
      _controller.text = incomingText ?? '';
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerChanged);
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
          trailing: _isSaving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : null,
        ),
        const SizedBox(height: 12),
        AppSurfaceCard(
          padding: const EdgeInsets.all(16),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAutosizeTextField(
                label: 'Снаряжение',
                controller: _controller,
                focusNode: _focusNode,
                minLines: 8,
                onChanged: _queueSave,
              ),
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
          ),
        ),
      ],
    );
  }

  void _handleControllerChanged() {
    final selectedText = _selectedEquipmentText();
    if (selectedText == _selectedText) {
      return;
    }

    setState(() {
      _selectedText = selectedText;
    });
  }

  String? _selectedEquipmentText() {
    final selection = _controller.selection;
    if (!selection.isValid || selection.isCollapsed) {
      return null;
    }

    final text = _controller.text;
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

  void _queueSave(String value) {
    _pendingText = value;
    if (_isSaving) {
      return;
    }
    _flushPendingSaves();
  }

  Future<void> _flushPendingSaves() async {
    while (_pendingText != null) {
      final draft = _pendingText;
      _pendingText = null;
      if (draft == _lastSavedText) {
        continue;
      }

      if (mounted) {
        setState(() {
          _isSaving = true;
        });
      }

      try {
        await widget.onChanged(draft);
        _lastSavedText = draft;
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

    if (mounted) {
      setState(() {
        _isSaving = false;
      });
    }
  }
}
