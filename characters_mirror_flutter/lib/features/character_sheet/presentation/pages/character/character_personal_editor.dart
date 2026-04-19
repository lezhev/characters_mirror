import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/character_alignment_labels.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_autosize_text_field.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:flutter/material.dart';

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
  String? notes,
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
  late final TextEditingController _notesController;

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
  late final FocusNode _notesFocusNode;

  late _PersonalInfoSnapshot _lastSavedSnapshot;
  _PersonalInfoSnapshot? _pendingSnapshot;
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
    _notesController = TextEditingController(text: snapshot.notes);

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
    _notesFocusNode = FocusNode();
  }

  @override
  void didUpdateWidget(CharacterPersonalEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    final incomingSnapshot =
        _PersonalInfoSnapshot.fromCharacter(widget.character);
    if (!_hasAnyFocus && incomingSnapshot != _lastSavedSnapshot) {
      _lastSavedSnapshot = incomingSnapshot;
      _applySnapshot(incomingSnapshot);
    }
  }

  @override
  void dispose() {
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
    _notesController.dispose();

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
    _notesFocusNode.dispose();
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
                  _queueSave();
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
                ],
              );
            },
          ),
        ),
        const AppSectionHeader(
          showDivider: false,
        ),
        AppSurfaceCard(
          padding: const EdgeInsets.all(16),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Column(
            children: [
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
      _AlignmentFieldSpec() => DropdownButtonFormField<CharacterAlignment>(
          key: ValueKey(field.alignment),
          focusNode: field.focusNode,
          initialValue: field.alignment,
          decoration: const InputDecoration(
            labelText: 'Мировоззрение',
            border: OutlineInputBorder(),
          ),
          items: CharacterAlignment.values
              .map(
                (value) => DropdownMenuItem(
                  value: value,
                  child: Text(characterAlignmentLabel(value)),
                ),
              )
              .toList(),
          onChanged: field.onChanged,
        ),
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
    _notesController.text = snapshot.notes;
    _alignment = snapshot.alignmentValue;
  }

  bool get _hasAnyFocus {
    return [
      _nameFocusNode,
      _ageFocusNode,
      _heightFocusNode,
      _weightFocusNode,
      _eyesFocusNode,
      _skinFocusNode,
      _hairFocusNode,
      _alignmentFocusNode,
      _appearanceFocusNode,
      _backstoryFocusNode,
      _goalsFocusNode,
      _alliesOrganizationsFocusNode,
      _personalityTraitsFocusNode,
      _idealsFocusNode,
      _bondsFocusNode,
      _flawsFocusNode,
      _notesFocusNode,
    ].any((node) => node.hasFocus);
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
      notes: _notesController.text,
    );
  }

  void _queueSave([String? _]) {
    _pendingSnapshot = _snapshot();
    if (_isSaving) {
      return;
    }
    _flushPendingSaves();
  }

  Future<void> _flushPendingSaves() async {
    while (_pendingSnapshot != null) {
      final draft = _pendingSnapshot;
      _pendingSnapshot = null;
      if (draft == null || draft == _lastSavedSnapshot) {
        continue;
      }

      if (mounted) {
        setState(() {
          _isSaving = true;
        });
      }

      try {
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
          notes: draft.notes,
        );
        _lastSavedSnapshot = draft;
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

sealed class _PersonalFieldSpec {
  const _PersonalFieldSpec();
}

class _ShortFieldSpec extends _PersonalFieldSpec {
  const _ShortFieldSpec({
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.textInputAction,
    required this.onSubmitted,
  });

  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final VoidCallback onSubmitted;
}

class _AlignmentFieldSpec extends _PersonalFieldSpec {
  const _AlignmentFieldSpec({
    required this.focusNode,
    required this.alignment,
    required this.onChanged,
  });

  final FocusNode focusNode;
  final CharacterAlignment? alignment;
  final ValueChanged<CharacterAlignment?> onChanged;
}

class _ShortTextField extends StatelessWidget {
  const _ShortTextField({
    required this.spec,
    required this.onChanged,
  });

  final _ShortFieldSpec spec;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: spec.controller,
      focusNode: spec.focusNode,
      minLines: 1,
      maxLines: 1,
      textInputAction: spec.textInputAction,
      onChanged: onChanged,
      onSubmitted: (_) => spec.onSubmitted(),
      decoration: InputDecoration(
        labelText: spec.label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class _NarrativeTextField extends StatelessWidget {
  const _NarrativeTextField({
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.isLast = false,
  });

  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: AppAutosizeTextField(
        label: label,
        controller: controller,
        focusNode: focusNode,
        minLines: 3,
        onChanged: onChanged,
      ),
    );
  }
}

class _PersonalInfoSnapshot {
  const _PersonalInfoSnapshot({
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
    required this.eyes,
    required this.skin,
    required this.hair,
    required this.alignmentValue,
    required this.appearance,
    required this.backstory,
    required this.goals,
    required this.alliesOrganizations,
    required this.personalityTraits,
    required this.ideals,
    required this.bonds,
    required this.flaws,
    required this.notes,
  });

  factory _PersonalInfoSnapshot.fromCharacter(CharacterData character) {
    return _PersonalInfoSnapshot(
      name: character.name ?? '',
      age: character.age ?? '',
      height: character.height ?? '',
      weight: character.weight ?? '',
      eyes: character.eyes ?? '',
      skin: character.skin ?? '',
      hair: character.hair ?? '',
      alignmentValue: character.alignmentValue,
      appearance: character.appearance ?? '',
      backstory: character.backstory ?? '',
      goals: character.goals ?? '',
      alliesOrganizations: character.alliesOrganizations ?? '',
      personalityTraits: character.personalityTraits ?? '',
      ideals: character.ideals ?? '',
      bonds: character.bonds ?? '',
      flaws: character.flaws ?? '',
      notes: character.notes ?? '',
    );
  }

  final String name;
  final String age;
  final String height;
  final String weight;
  final String eyes;
  final String skin;
  final String hair;
  final CharacterAlignment? alignmentValue;
  final String appearance;
  final String backstory;
  final String goals;
  final String alliesOrganizations;
  final String personalityTraits;
  final String ideals;
  final String bonds;
  final String flaws;
  final String notes;

  @override
  bool operator ==(Object other) {
    return other is _PersonalInfoSnapshot &&
        other.name == name &&
        other.age == age &&
        other.height == height &&
        other.weight == weight &&
        other.eyes == eyes &&
        other.skin == skin &&
        other.hair == hair &&
        other.alignmentValue == alignmentValue &&
        other.appearance == appearance &&
        other.backstory == backstory &&
        other.goals == goals &&
        other.alliesOrganizations == alliesOrganizations &&
        other.personalityTraits == personalityTraits &&
        other.ideals == ideals &&
        other.bonds == bonds &&
        other.flaws == flaws &&
        other.notes == notes;
  }

  @override
  int get hashCode => Object.hash(
        name,
        age,
        height,
        weight,
        eyes,
        skin,
        hair,
        alignmentValue,
        appearance,
        backstory,
        goals,
        alliesOrganizations,
        personalityTraits,
        ideals,
        bonds,
        flaws,
        notes,
      );
}
