import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_autosize_text_field.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
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
            onChanged: (value) => ref
                .read(characterSheetControllerProvider(characterId).notifier)
                .saveEquipment(value),
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
  });

  final CharacterData character;
  final Future<void> Function(String? value) onChanged;

  @override
  State<_EquipmentEditor> createState() => _EquipmentEditorState();
}

class _EquipmentEditorState extends State<_EquipmentEditor> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  String? _lastSavedText;
  String? _pendingText;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _lastSavedText = widget.character.equipment;
    _controller = TextEditingController(text: _lastSavedText ?? '');
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
          child: AppAutosizeTextField(
            label: 'Снаряжение',
            controller: _controller,
            focusNode: _focusNode,
            minLines: 8,
            onChanged: _queueSave,
          ),
        ),
      ],
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
