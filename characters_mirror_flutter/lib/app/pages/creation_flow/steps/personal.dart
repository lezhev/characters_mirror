import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_app_bar.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_nav_bar.dart';
import 'package:characters_mirror_flutter/app/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PersonalStep extends ConsumerStatefulWidget {
  const PersonalStep({super.key});

  @override
  ConsumerState<PersonalStep> createState() => _PersonalStepState();
}

class _PersonalStepState extends ConsumerState<PersonalStep> {
  late final CharacterCreation _creationNotifier;
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

  @override
  void initState() {
    super.initState();
    _creationNotifier = ref.read(characterCreationProvider.notifier);
    final character = ref.read(characterCreationProvider).character;

    _nameController = TextEditingController(text: character.name ?? '');
    _ageController = TextEditingController(text: character.age ?? '');
    _heightController = TextEditingController(text: character.height ?? '');
    _weightController = TextEditingController(text: character.weight ?? '');
    _eyesController = TextEditingController(text: character.eyes ?? '');
    _skinController = TextEditingController(text: character.skin ?? '');
    _hairController = TextEditingController(text: character.hair ?? '');
    _appearanceController =
        TextEditingController(text: character.appearance ?? '');
    _backstoryController = TextEditingController(text: character.backstory ?? '');
    _goalsController = TextEditingController(text: character.goals ?? '');
    _alliesOrganizationsController =
        TextEditingController(text: character.alliesOrganizations ?? '');
    _personalityTraitsController =
        TextEditingController(text: character.personalityTraits ?? '');
    _idealsController = TextEditingController(text: character.ideals ?? '');
    _bondsController = TextEditingController(text: character.bonds ?? '');
    _flawsController = TextEditingController(text: character.flaws ?? '');
    _notesController = TextEditingController(text: character.notes ?? '');

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

    _attachAutosave(_nameFocusNode, _saveName);
    _attachAutosave(_ageFocusNode, _saveAge);
    _attachAutosave(_heightFocusNode, _saveHeight);
    _attachAutosave(_weightFocusNode, _saveWeight);
    _attachAutosave(_eyesFocusNode, _saveEyes);
    _attachAutosave(_skinFocusNode, _saveSkin);
    _attachAutosave(_hairFocusNode, _saveHair);
    _attachAutosave(_appearanceFocusNode, _saveAppearance);
    _attachAutosave(_backstoryFocusNode, _saveBackstory);
    _attachAutosave(_goalsFocusNode, _saveGoals);
    _attachAutosave(
      _alliesOrganizationsFocusNode,
      _saveAlliesOrganizations,
    );
    _attachAutosave(
      _personalityTraitsFocusNode,
      _savePersonalityTraits,
    );
    _attachAutosave(_idealsFocusNode, _saveIdeals);
    _attachAutosave(_bondsFocusNode, _saveBonds);
    _attachAutosave(_flawsFocusNode, _saveFlaws);
    _attachAutosave(_notesFocusNode, _saveNotes);
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
    final state = ref.watch(characterCreationProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: CreationAppBar(
          title: "Создание персонажа",
          onBack: _syncAndExit,
          onStepTap: _syncAndGoToStep,
        ),
      ),
      body: PageSizeLimiter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Короткие поля',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Gap(12),
                _SectionCard(
                  child: Column(
                    children: [
                      _ShortField(
                        label: 'Имя',
                        controller: _nameController,
                        focusNode: _nameFocusNode,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) => _submitShortField(
                          save: _saveName,
                          nextFocus: _ageFocusNode,
                        ),
                      ),
                      _ShortField(
                        label: 'Возраст',
                        controller: _ageController,
                        focusNode: _ageFocusNode,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) => _submitShortField(
                          save: _saveAge,
                          nextFocus: _heightFocusNode,
                        ),
                      ),
                      _ShortField(
                        label: 'Рост',
                        controller: _heightController,
                        focusNode: _heightFocusNode,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) => _submitShortField(
                          save: _saveHeight,
                          nextFocus: _weightFocusNode,
                        ),
                      ),
                      _ShortField(
                        label: 'Вес',
                        controller: _weightController,
                        focusNode: _weightFocusNode,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) => _submitShortField(
                          save: _saveWeight,
                          nextFocus: _eyesFocusNode,
                        ),
                      ),
                      _ShortField(
                        label: 'Глаза',
                        controller: _eyesController,
                        focusNode: _eyesFocusNode,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) => _submitShortField(
                          save: _saveEyes,
                          nextFocus: _skinFocusNode,
                        ),
                      ),
                      _ShortField(
                        label: 'Кожа',
                        controller: _skinController,
                        focusNode: _skinFocusNode,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) => _submitShortField(
                          save: _saveSkin,
                          nextFocus: _hairFocusNode,
                        ),
                      ),
                      _ShortField(
                        label: 'Волосы',
                        controller: _hairController,
                        focusNode: _hairFocusNode,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _submitShortField(
                          save: _saveHair,
                          nextFocus: _alignmentFocusNode,
                        ),
                      ),
                      const Gap(8),
                      DropdownButtonFormField<CharacterAlignment>(
                        focusNode: _alignmentFocusNode,
                        initialValue: state.character.alignmentValue,
                        decoration: const InputDecoration(
                          labelText: 'Мировоззрение',
                          border: OutlineInputBorder(),
                        ),
                        items: CharacterAlignment.values
                            .map(
                              (alignment) => DropdownMenuItem(
                                value: alignment,
                                child: Text(_alignmentLabel(alignment)),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          ref
                              .read(characterCreationProvider.notifier)
                              .setAlignment(value);
                          _appearanceFocusNode.requestFocus();
                        },
                      ),
                    ],
                  ),
                ),
                const Gap(24),
                Text(
                  'История и характер',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Gap(12),
                _SectionCard(
                  child: Column(
                    children: [
                      _NarrativeField(
                        label: 'Внешность',
                        controller: _appearanceController,
                        focusNode: _appearanceFocusNode,
                      ),
                      _NarrativeField(
                        label: 'История персонажа',
                        controller: _backstoryController,
                        focusNode: _backstoryFocusNode,
                        maxLines: 5,
                      ),
                      _NarrativeField(
                        label: 'Цели',
                        controller: _goalsController,
                        focusNode: _goalsFocusNode,
                      ),
                      _NarrativeField(
                        label: 'Союзники и организации',
                        controller: _alliesOrganizationsController,
                        focusNode: _alliesOrganizationsFocusNode,
                      ),
                      _NarrativeField(
                        label: 'Черты характера',
                        controller: _personalityTraitsController,
                        focusNode: _personalityTraitsFocusNode,
                      ),
                      _NarrativeField(
                        label: 'Идеалы',
                        controller: _idealsController,
                        focusNode: _idealsFocusNode,
                      ),
                      _NarrativeField(
                        label: 'Привязанности',
                        controller: _bondsController,
                        focusNode: _bondsFocusNode,
                      ),
                      _NarrativeField(
                        label: 'Слабости',
                        controller: _flawsController,
                        focusNode: _flawsFocusNode,
                      ),
                      _NarrativeField(
                        label: 'Доп. заметки',
                        controller: _notesController,
                        focusNode: _notesFocusNode,
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: CreationNavBar(
            onPressedNext: () {
              _syncAndGoToStep(Step.summary);
            },
            route: 'summary',
          ),
        ),
      ),
    );
  }

  void _attachAutosave(FocusNode node, VoidCallback save) {
    node.addListener(() {
      if (!node.hasFocus) {
        save();
      }
    });
  }

  void _submitShortField({
    required VoidCallback save,
    FocusNode? nextFocus,
  }) {
    save();
    if (nextFocus != null) {
      nextFocus.requestFocus();
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  void _flushPersonalFields() {
    _saveName();
    _saveAge();
    _saveHeight();
    _saveWeight();
    _saveEyes();
    _saveSkin();
    _saveHair();
    _saveAppearance();
    _saveBackstory();
    _saveGoals();
    _saveAlliesOrganizations();
    _savePersonalityTraits();
    _saveIdeals();
    _saveBonds();
    _saveFlaws();
    _saveNotes();
  }

  void _saveName() =>
      _creationNotifier.setName(_nameController.text);

  void _saveAge() => _creationNotifier.setAge(_ageController.text);

  void _saveHeight() => _creationNotifier.setHeight(_heightController.text);

  void _saveWeight() => _creationNotifier.setWeight(_weightController.text);

  void _saveEyes() => _creationNotifier.setEyes(_eyesController.text);

  void _saveSkin() => _creationNotifier.setSkin(_skinController.text);

  void _saveHair() => _creationNotifier.setHair(_hairController.text);

  void _saveAppearance() =>
      _creationNotifier.setAppearance(_appearanceController.text);

  void _saveBackstory() =>
      _creationNotifier.setBackstory(_backstoryController.text);

  void _saveGoals() => _creationNotifier.setGoals(_goalsController.text);

  void _saveAlliesOrganizations() =>
      _creationNotifier.setAlliesOrganizations(
        _alliesOrganizationsController.text,
      );

  void _savePersonalityTraits() =>
      _creationNotifier.setPersonalityTraits(
        _personalityTraitsController.text,
      );

  void _saveIdeals() => _creationNotifier.setIdeals(_idealsController.text);

  void _saveBonds() => _creationNotifier.setBonds(_bondsController.text);

  void _saveFlaws() => _creationNotifier.setFlaws(_flawsController.text);

  void _saveNotes() => _creationNotifier.setNotes(_notesController.text);

  void _syncAndGoToStep(Step target) {
    FocusScope.of(context).unfocus();
    _flushPersonalFields();
    _creationNotifier.goToStep(context, target);
  }

  void _syncAndExit() {
    FocusScope.of(context).unfocus();
    _flushPersonalFields();
    context.go('/characters');
  }

  String _alignmentLabel(CharacterAlignment value) {
    switch (value) {
      case CharacterAlignment.lawfulGood:
        return 'Законопослушный добрый';
      case CharacterAlignment.neutralGood:
        return 'Нейтральный добрый';
      case CharacterAlignment.chaoticGood:
        return 'Хаотичный добрый';
      case CharacterAlignment.lawfulNeutral:
        return 'Законопослушный нейтральный';
      case CharacterAlignment.trueNeutral:
        return 'Истинно нейтральный';
      case CharacterAlignment.chaoticNeutral:
        return 'Хаотичный нейтральный';
      case CharacterAlignment.lawfulEvil:
        return 'Законопослушный злой';
      case CharacterAlignment.neutralEvil:
        return 'Нейтральный злой';
      case CharacterAlignment.chaoticEvil:
        return 'Хаотичный злой';
      case CharacterAlignment.unaligned:
        return 'Без мировоззрения';
    }
  }
}

class _SectionCard extends StatelessWidget {
  final Widget child;

  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}

class _ShortField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String> onSubmitted;

  const _ShortField({
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.textInputAction,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class _NarrativeField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final int maxLines;

  const _NarrativeField({
    required this.label,
    required this.controller,
    required this.focusNode,
    this.maxLines = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        minLines: 3,
        maxLines: maxLines,
        textInputAction: TextInputAction.newline,
        decoration: InputDecoration(
          labelText: label,
          alignLabelWithHint: true,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
