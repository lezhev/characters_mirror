import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/character_alignment_labels.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_autosize_text_field.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/core/ui/input/app_input_limits.dart';
import 'package:characters_mirror_flutter/core/ui/input/app_input_formatters.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/helpers/sheet_autosave.dart';
import 'package:flutter/material.dart';

part 'character_personal_editor/personal_field_widgets.dart';
part 'character_personal_editor/alignment_picker.dart';
part 'character_personal_editor/narrative_fields_snapshot.dart';

typedef SavePersonalInfo = Future<void> Function({
  String? name,
  String? age,
  String? height,
  String? weight,
  String? eyes,
  String? skin,
  String? hair,
  CharacterAlignment? alignmentValue,
  String? appearance,
  String? backstory,
  String? goals,
  String? alliesOrganizations,
  String? personalityTraits,
  String? ideals,
  String? bonds,
  String? flaws,
});

class CharacterPersonalEditor extends StatefulWidget {
  const CharacterPersonalEditor({
    required this.character,
    required this.onChanged,
    super.key,
  });

  final CharacterData character;
  final SavePersonalInfo onChanged;

  @override
  State<CharacterPersonalEditor> createState() =>
      _CharacterPersonalEditorState();
}

class _CharacterPersonalEditorState extends State<CharacterPersonalEditor> {
  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  late final TextEditingController _eyesController;
  late final TextEditingController _skinController;
  late final TextEditingController _hairController;
  late final TextEditingController _appearanceController;
  late final TextEditingController _backstoryController;
  late final TextEditingController _goalsController;
  late final TextEditingController _alliesOrganizationsController;
  late final TextEditingController _personalityTraitsController;
  late final TextEditingController _idealsController;
  late final TextEditingController _bondsController;
  late final TextEditingController _flawsController;

  late final FocusNode _nameFocusNode;
  late final FocusNode _ageFocusNode;
  late final FocusNode _heightFocusNode;
  late final FocusNode _weightFocusNode;
  late final FocusNode _eyesFocusNode;
  late final FocusNode _skinFocusNode;
  late final FocusNode _hairFocusNode;
  late final FocusNode _alignmentFocusNode;
  late final FocusNode _appearanceFocusNode;
  late final FocusNode _backstoryFocusNode;
  late final FocusNode _goalsFocusNode;
  late final FocusNode _alliesOrganizationsFocusNode;
  late final FocusNode _personalityTraitsFocusNode;
  late final FocusNode _idealsFocusNode;
  late final FocusNode _bondsFocusNode;
  late final FocusNode _flawsFocusNode;

  late _PersonalInfoSnapshot _lastSavedSnapshot;
  late final DebouncedAutosave<_PersonalInfoSnapshot> _autosave;
  CharacterAlignment? _alignment;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final snapshot = _PersonalInfoSnapshot.fromCharacter(widget.character);
    _lastSavedSnapshot = snapshot;
    _alignment = snapshot.alignmentValue;

    _nameController = TextEditingController(text: snapshot.name);
    _ageController = TextEditingController(text: snapshot.age);
    _heightController = TextEditingController(text: snapshot.height);
    _weightController = TextEditingController(text: snapshot.weight);
    _eyesController = TextEditingController(text: snapshot.eyes);
    _skinController = TextEditingController(text: snapshot.skin);
    _hairController = TextEditingController(text: snapshot.hair);
    _appearanceController = TextEditingController(text: snapshot.appearance);
    _backstoryController = TextEditingController(text: snapshot.backstory);
    _goalsController = TextEditingController(text: snapshot.goals);
    _alliesOrganizationsController = TextEditingController(
      text: snapshot.alliesOrganizations,
    );
    _personalityTraitsController = TextEditingController(
      text: snapshot.personalityTraits,
    );
    _idealsController = TextEditingController(text: snapshot.ideals);
    _bondsController = TextEditingController(text: snapshot.bonds);
    _flawsController = TextEditingController(text: snapshot.flaws);

    _nameFocusNode = FocusNode();
    _ageFocusNode = FocusNode();
    _heightFocusNode = FocusNode();
    _weightFocusNode = FocusNode();
    _eyesFocusNode = FocusNode();
    _skinFocusNode = FocusNode();
    _hairFocusNode = FocusNode();
    _alignmentFocusNode = FocusNode();
    _appearanceFocusNode = FocusNode();
    _backstoryFocusNode = FocusNode();
    _goalsFocusNode = FocusNode();
    _alliesOrganizationsFocusNode = FocusNode();
    _personalityTraitsFocusNode = FocusNode();
    _idealsFocusNode = FocusNode();
    _bondsFocusNode = FocusNode();
    _flawsFocusNode = FocusNode();

    _autosave = DebouncedAutosave<_PersonalInfoSnapshot>(
      delay: characterSheetAutosaveDelay,
      lastSaved: _lastSavedSnapshot,
      equals: (left, right) => left == right,
      onSavingChanged: (value) {
        if (!mounted) {
          return;
        }
        setState(() {
          _isSaving = value;
        });
      },
      onError: (error, _) {
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(humanReadableError(error)),
          ),
        );
      },
      save: (draft) async {
        await widget.onChanged(
          name: draft.name,
          age: draft.age,
          height: draft.height,
          weight: draft.weight,
          eyes: draft.eyes,
          skin: draft.skin,
          hair: draft.hair,
          alignmentValue: draft.alignmentValue,
          appearance: draft.appearance,
          backstory: draft.backstory,
          goals: draft.goals,
          alliesOrganizations: draft.alliesOrganizations,
          personalityTraits: draft.personalityTraits,
          ideals: draft.ideals,
          bonds: draft.bonds,
          flaws: draft.flaws,
        );
        _lastSavedSnapshot = draft;
      },
    );
  }

  @override
  void didUpdateWidget(CharacterPersonalEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    final incomingSnapshot =
        _PersonalInfoSnapshot.fromCharacter(widget.character);
    final currentSnapshot = _snapshot();
    if (incomingSnapshot != _lastSavedSnapshot &&
        currentSnapshot == _lastSavedSnapshot) {
      _lastSavedSnapshot = incomingSnapshot;
      _autosave.updateLastSaved(incomingSnapshot);
      _applySnapshot(incomingSnapshot);
    }
  }

  @override
  void dispose() {
    _autosave.dispose(flushPending: true);
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _eyesController.dispose();
    _skinController.dispose();
    _hairController.dispose();
    _appearanceController.dispose();
    _backstoryController.dispose();
    _goalsController.dispose();
    _alliesOrganizationsController.dispose();
    _personalityTraitsController.dispose();
    _idealsController.dispose();
    _bondsController.dispose();
    _flawsController.dispose();

    _nameFocusNode.dispose();
    _ageFocusNode.dispose();
    _heightFocusNode.dispose();
    _weightFocusNode.dispose();
    _eyesFocusNode.dispose();
    _skinFocusNode.dispose();
    _hairFocusNode.dispose();
    _alignmentFocusNode.dispose();
    _appearanceFocusNode.dispose();
    _backstoryFocusNode.dispose();
    _goalsFocusNode.dispose();
    _alliesOrganizationsFocusNode.dispose();
    _personalityTraitsFocusNode.dispose();
    _idealsFocusNode.dispose();
    _bondsFocusNode.dispose();
    _flawsFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(
          title: 'Описание персонажа',
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              final usePairs = constraints.maxWidth >= 360;
              final nameField = _ShortFieldSpec(
                label: 'Имя',
                controller: _nameController,
                focusNode: _nameFocusNode,
                textInputAction: TextInputAction.next,
                onSubmitted: () => _ageFocusNode.requestFocus(),
              );
              final pairedFields = [
                _ShortFieldSpec(
                  label: 'Возраст',
                  controller: _ageController,
                  focusNode: _ageFocusNode,
                  textInputAction: TextInputAction.next,
                  onSubmitted: () => _heightFocusNode.requestFocus(),
                ),
                _ShortFieldSpec(
                  label: 'Рост',
                  controller: _heightController,
                  focusNode: _heightFocusNode,
                  textInputAction: TextInputAction.next,
                  onSubmitted: () => _weightFocusNode.requestFocus(),
                ),
                _ShortFieldSpec(
                  label: 'Вес',
                  controller: _weightController,
                  focusNode: _weightFocusNode,
                  textInputAction: TextInputAction.next,
                  onSubmitted: () => _eyesFocusNode.requestFocus(),
                ),
                _ShortFieldSpec(
                  label: 'Глаза',
                  controller: _eyesController,
                  focusNode: _eyesFocusNode,
                  textInputAction: TextInputAction.next,
                  onSubmitted: () => _skinFocusNode.requestFocus(),
                ),
                _ShortFieldSpec(
                  label: 'Кожа',
                  controller: _skinController,
                  focusNode: _skinFocusNode,
                  textInputAction: TextInputAction.next,
                  onSubmitted: () => _hairFocusNode.requestFocus(),
                ),
                _ShortFieldSpec(
                  label: 'Волосы',
                  controller: _hairController,
                  focusNode: _hairFocusNode,
                  textInputAction: TextInputAction.done,
                  onSubmitted: () => _alignmentFocusNode.requestFocus(),
                ),
              ];
              final alignmentField = _AlignmentFieldSpec(
                focusNode: _alignmentFocusNode,
                alignment: _alignment,
                onChanged: (value) {
                  setState(() {
                    _alignment = value;
                  });
                  _queueSaveImmediately();
                },
              );

              return Column(
                children: [
                  _buildField(nameField),
                  if (usePairs)
                    ..._pairedFieldRows(pairedFields)
                  else
                    for (final field in pairedFields) _buildField(field),
                  const SizedBox(height: 12),
                  _buildField(alignmentField, hasBottomGap: false),
                  const SizedBox(height: 16),
                  _NarrativeTextField(
                    label: 'Внешность',
                    controller: _appearanceController,
                    focusNode: _appearanceFocusNode,
                    onChanged: _queueSave,
                  ),
                  _NarrativeTextField(
                    label: 'История персонажа',
                    controller: _backstoryController,
                    focusNode: _backstoryFocusNode,
                    onChanged: _queueSave,
                  ),
                  _NarrativeTextField(
                    label: 'Цели',
                    controller: _goalsController,
                    focusNode: _goalsFocusNode,
                    onChanged: _queueSave,
                  ),
                  _NarrativeTextField(
                    label: 'Союзники и организации',
                    controller: _alliesOrganizationsController,
                    focusNode: _alliesOrganizationsFocusNode,
                    onChanged: _queueSave,
                  ),
                  _NarrativeTextField(
                    label: 'Черты характера',
                    controller: _personalityTraitsController,
                    focusNode: _personalityTraitsFocusNode,
                    onChanged: _queueSave,
                  ),
                  _NarrativeTextField(
                    label: 'Идеалы',
                    controller: _idealsController,
                    focusNode: _idealsFocusNode,
                    onChanged: _queueSave,
                  ),
                  _NarrativeTextField(
                    label: 'Привязанности',
                    controller: _bondsController,
                    focusNode: _bondsFocusNode,
                    onChanged: _queueSave,
                  ),
                  _NarrativeTextField(
                    label: 'Слабости',
                    controller: _flawsController,
                    focusNode: _flawsFocusNode,
                    onChanged: _queueSave,
                    isLast: true,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _pairedFieldRows(List<_PersonalFieldSpec> fields) {
    return [
      for (var index = 0; index < fields.length; index += 2)
        Padding(
          padding: EdgeInsets.only(
            bottom: index + 2 >= fields.length ? 0 : 12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildField(fields[index], hasBottomGap: false)),
              if (index + 1 < fields.length) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: _buildField(fields[index + 1], hasBottomGap: false),
                ),
              ],
            ],
          ),
        ),
    ];
  }

  Widget _buildField(
    _PersonalFieldSpec field, {
    bool hasBottomGap = true,
  }) {
    final child = switch (field) {
      _ShortFieldSpec() => _ShortTextField(
          spec: field,
          onChanged: _queueSave,
        ),
      _AlignmentFieldSpec() => _AlignmentPickerField(spec: field),
    };

    return Padding(
      padding: EdgeInsets.only(bottom: hasBottomGap ? 12 : 0),
      child: child,
    );
  }

  void _applySnapshot(_PersonalInfoSnapshot snapshot) {
    _nameController.text = snapshot.name;
    _ageController.text = snapshot.age;
    _heightController.text = snapshot.height;
    _weightController.text = snapshot.weight;
    _eyesController.text = snapshot.eyes;
    _skinController.text = snapshot.skin;
    _hairController.text = snapshot.hair;
    _appearanceController.text = snapshot.appearance;
    _backstoryController.text = snapshot.backstory;
    _goalsController.text = snapshot.goals;
    _alliesOrganizationsController.text = snapshot.alliesOrganizations;
    _personalityTraitsController.text = snapshot.personalityTraits;
    _idealsController.text = snapshot.ideals;
    _bondsController.text = snapshot.bonds;
    _flawsController.text = snapshot.flaws;
    _alignment = snapshot.alignmentValue;
  }

  _PersonalInfoSnapshot _snapshot() {
    return _PersonalInfoSnapshot(
      name: _nameController.text,
      age: _ageController.text,
      height: _heightController.text,
      weight: _weightController.text,
      eyes: _eyesController.text,
      skin: _skinController.text,
      hair: _hairController.text,
      alignmentValue: _alignment,
      appearance: _appearanceController.text,
      backstory: _backstoryController.text,
      goals: _goalsController.text,
      alliesOrganizations: _alliesOrganizationsController.text,
      personalityTraits: _personalityTraitsController.text,
      ideals: _idealsController.text,
      bonds: _bondsController.text,
      flaws: _flawsController.text,
    );
  }

  void _queueSave([String? _]) {
    _autosave.schedule(_snapshot());
  }

  void _queueSaveImmediately() {
    _autosave.schedule(_snapshot());
    unawaited(_autosave.flush());
  }
}

sealed class _PersonalFieldSpec {
  const _PersonalFieldSpec();
}
