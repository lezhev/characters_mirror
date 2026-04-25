import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/character_model_extensions.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_autosize_text_field.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({
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
      data: (character) {
        final controller = ref.read(
          characterSheetControllerProvider(characterId).notifier,
        );
        return Padding(
          padding: const EdgeInsets.all(12),
          child: PageSizeLimiter(
            child: _NotesEditor(
              character: character,
              onAdd: controller.addNote,
              onUpdate: controller.updateNote,
              onDelete: controller.deleteNote,
            ),
          ),
        );
      },
    );
  }
}

class _NotesEditor extends StatefulWidget {
  const _NotesEditor({
    required this.character,
    required this.onAdd,
    required this.onUpdate,
    required this.onDelete,
  });

  final CharacterData character;
  final Future<void> Function() onAdd;
  final Future<void> Function(int index, String note) onUpdate;
  final Future<void> Function(int index) onDelete;

  @override
  State<_NotesEditor> createState() => _NotesEditorState();
}

class _NotesEditorState extends State<_NotesEditor> {
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];
  List<String> _lastNotes = const [];
  bool _isSaving = false;
  bool _isResettingFields = false;
  int? _confirmDeleteIndex;

  @override
  void initState() {
    super.initState();
    _syncNotes(widget.character.noteTexts);
  }

  @override
  void didUpdateWidget(_NotesEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    final incomingNotes = widget.character.noteTexts;
    if (!_hasAnyFocus && !_sameNotes(incomingNotes, _lastNotes)) {
      _syncNotes(incomingNotes);
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AppSectionHeader(
          title: 'Заметки',
          showDivider: false,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isSaving) ...[
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 8),
              ],
              IconButton(
                tooltip: 'Добавить заметку',
                onPressed: _handleAdd,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (_controllers.isEmpty)
          const AppSurfaceCard(
            padding: EdgeInsets.all(16),
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Text('Заметок пока нет'),
          )
        else
          for (var index = 0; index < _controllers.length; index++) ...[
            AppSurfaceCard(
              padding: const EdgeInsets.all(16),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppAutosizeTextField(
                    label: 'Заметка ${index + 1}',
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    minLines: 4,
                    onChanged: (_) => _resetDeleteConfirmation(index),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => _handleDelete(index),
                    child: Text(
                      _confirmDeleteIndex == index ? 'Точно?' : 'Удалить',
                    ),
                  ),
                ],
              ),
            ),
            if (index + 1 < _controllers.length) const SizedBox(height: 12),
          ],
      ],
    );
  }

  Future<void> _handleAdd() async {
    setState(() {
      _confirmDeleteIndex = null;
      _setLocalNotes([..._currentTexts(), '']);
    });
    _focusNodes.last.requestFocus();
    await widget.onAdd();
  }

  Future<void> _handleDelete(int index) async {
    if (_confirmDeleteIndex != index) {
      setState(() {
        _confirmDeleteIndex = index;
      });
      return;
    }

    setState(() {
      _confirmDeleteIndex = null;
      _setLocalNotes([
        for (var i = 0; i < _controllers.length; i++)
          if (i != index) _controllers[i].text,
      ]);
    });
    await _runSave(() => widget.onDelete(index));
  }

  Future<void> _saveNote(int index) async {
    if (index < 0 || index >= _controllers.length) {
      return;
    }
    final text = _controllers[index].text;
    if (index < _lastNotes.length && text == _lastNotes[index]) {
      return;
    }

    await _runSave(() => widget.onUpdate(index, text));
  }

  Future<void> _runSave(Future<void> Function() save) async {
    if (mounted) {
      setState(() {
        _isSaving = true;
      });
    }

    try {
      await save();
      _lastNotes = _currentTexts();
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(humanReadableError(error)),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  void _syncNotes(List<String> notes) {
    _setLocalNotes(notes);
    _lastNotes = List<String>.from(notes);
    _confirmDeleteIndex = null;
  }

  void _setLocalNotes(List<String> notes) {
    _isResettingFields = true;
    for (final node in _focusNodes) {
      node.dispose();
    }
    for (final controller in _controllers) {
      controller.dispose();
    }
    _focusNodes
      ..clear()
      ..addAll([
        for (var index = 0; index < notes.length; index++)
          _buildFocusNode(index),
      ]);
    _controllers
      ..clear()
      ..addAll([
        for (final note in notes) TextEditingController(text: note),
      ]);
    _isResettingFields = false;
  }

  List<String> _currentTexts() => [
        for (final controller in _controllers) controller.text,
      ];

  bool get _hasAnyFocus => _focusNodes.any((node) => node.hasFocus);

  bool _sameNotes(List<String> left, List<String> right) {
    if (left.length != right.length) {
      return false;
    }
    for (var index = 0; index < left.length; index++) {
      if (left[index] != right[index]) {
        return false;
      }
    }
    return true;
  }

  FocusNode _buildFocusNode(int index) {
    final node = FocusNode();
    node.addListener(() {
      if (!node.hasFocus && !_isResettingFields) {
        _saveNote(index);
      }
    });
    return node;
  }

  void _resetDeleteConfirmation(int index) {
    if (_confirmDeleteIndex != index) {
      return;
    }
    setState(() {
      _confirmDeleteIndex = null;
    });
  }
}
