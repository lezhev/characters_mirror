import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_item_id.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_autosize_text_field.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/core/ui/input/app_input_limits.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/helpers/sheet_autosave.dart';
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
  final Future<void> Function(String id, String note) onUpdate;
  final Future<void> Function(String id) onDelete;

  @override
  State<_NotesEditor> createState() => _NotesEditorState();
}

class _NotesEditorState extends State<_NotesEditor> {
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];
  final List<String> _noteIds = [];
  List<String> _lastNotes = const [];
  bool _isResettingFields = false;
  int? _confirmDeleteIndex;

  @override
  void initState() {
    super.initState();
    _syncNotes(widget.character.notes);
  }

  @override
  void didUpdateWidget(_NotesEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    final incomingNotes = widget.character.notes;
    if (!_sameNotes(incomingNotes)) {
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
          trailing: IconButton(
            tooltip: 'Добавить заметку',
            onPressed: _handleAdd,
            icon: const Icon(Icons.add),
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
                    maxRunes: AppInputLimits.longText,
                    onChanged: (_) => _handleNoteChanged(index),
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
      _setLocalNotes(
        [..._noteIds, createCharacterSyncItemId()],
        [..._currentTexts(), ''],
      );
      _lastNotes = _currentTexts();
    });
    _focusNodes.last.requestFocus();
    runCharacterSheetSave(context, widget.onAdd());
  }

  Future<void> _handleDelete(int index) async {
    if (_confirmDeleteIndex != index) {
      setState(() {
        _confirmDeleteIndex = index;
      });
      return;
    }

    final id = _noteIds[index];
    final remainingIds = [
      for (var i = 0; i < _noteIds.length; i++)
        if (i != index) _noteIds[i],
    ];
    final remainingTexts = [
      for (var i = 0; i < _controllers.length; i++)
        if (i != index) _controllers[i].text,
    ];
    setState(() {
      _confirmDeleteIndex = null;
      _setLocalNotes(remainingIds, remainingTexts);
    });
    _runSave(() => widget.onDelete(id));
  }

  Future<void> _saveNote(int index) async {
    if (index < 0 || index >= _controllers.length) {
      return;
    }
    final text = _controllers[index].text;
    if (index < _lastNotes.length && text == _lastNotes[index]) {
      return;
    }

    _runSave(() => widget.onUpdate(_noteIds[index], text));
  }

  void _handleNoteChanged(int index) {
    _resetDeleteConfirmation(index);
    _saveNote(index);
  }

  void _runSave(Future<void> Function() save) {
    _lastNotes = _currentTexts();
    runCharacterSheetSave(context, save());
  }

  void _syncNotes(List<CharacterNoteData>? notes) {
    final values = notes ?? const <CharacterNoteData>[];
    final incomingIds = [
      for (final note in values) note.id ?? createCharacterSyncItemId(),
    ];
    final incomingTexts = [for (final note in values) note.text ?? ''];
    if (_noteIds.length == incomingIds.length &&
        _sameIds(_noteIds, incomingIds)) {
      _isResettingFields = true;
      for (var index = 0; index < incomingTexts.length; index++) {
        final text = incomingTexts[index];
        if (_controllers[index].text == text) continue;
        _controllers[index].value = TextEditingValue(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        );
      }
      _isResettingFields = false;
    } else {
      final incomingIdSet = incomingIds.toSet();
      final blankDraftIds = <String>[];
      for (var index = 0; index < _noteIds.length; index++) {
        if (_controllers[index].text.trim().isEmpty &&
            !incomingIdSet.contains(_noteIds[index])) {
          blankDraftIds.add(_noteIds[index]);
        }
      }
      _setLocalNotes(
        [...incomingIds, ...blankDraftIds],
        [...incomingTexts, for (final _ in blankDraftIds) ''],
      );
    }
    _lastNotes = _currentTexts();
    _confirmDeleteIndex = null;
  }

  void _setLocalNotes(List<String> ids, List<String> notes) {
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
    _noteIds
      ..clear()
      ..addAll(ids);
    _isResettingFields = false;
  }

  List<String> _currentTexts() => [
        for (final controller in _controllers) controller.text,
      ];

  bool _sameNotes(List<CharacterNoteData>? notes) {
    final values = notes ?? const <CharacterNoteData>[];
    final persistedLocalIndexes = [
      for (var index = 0; index < _controllers.length; index++)
        if (_controllers[index].text.trim().isNotEmpty) index,
    ];
    if (values.length != persistedLocalIndexes.length) {
      return false;
    }
    for (var index = 0; index < values.length; index++) {
      final localIndex = persistedLocalIndexes[index];
      if (values[index].id != _noteIds[localIndex] ||
          (values[index].text ?? '').trim() !=
              _controllers[localIndex].text.trim()) {
        return false;
      }
    }
    return true;
  }

  bool _sameIds(List<String> left, List<String> right) {
    if (left.length != right.length) return false;
    for (var index = 0; index < left.length; index++) {
      if (left[index] != right[index]) return false;
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
