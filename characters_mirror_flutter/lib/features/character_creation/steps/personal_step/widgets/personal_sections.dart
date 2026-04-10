import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_autosize_text_field.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/personal_step/application/personal_form_bindings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PersonalShortFieldsSection extends StatelessWidget {
  const PersonalShortFieldsSection({
    required this.bindings,
    required this.alignment,
    required this.onAlignmentChanged,
    super.key,
  });

  final PersonalFormBindings bindings;
  final CharacterAlignment? alignment;
  final ValueChanged<CharacterAlignment?> onAlignmentChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionHeader(title: 'Короткие поля', showDivider: false),
        const Gap(12),
        AppSurfaceCard(
          padding: const EdgeInsets.all(16),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Column(
            children: [
              PersonalTextField.short(
                label: 'Имя',
                controller: bindings.nameController,
                focusNode: bindings.nameFocusNode,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => bindings.submitShortField(
                  context: context,
                  save: bindings.saveName,
                  nextFocus: bindings.ageFocusNode,
                ),
              ),
              PersonalTextField.short(
                label: 'Возраст',
                controller: bindings.ageController,
                focusNode: bindings.ageFocusNode,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => bindings.submitShortField(
                  context: context,
                  save: bindings.saveAge,
                  nextFocus: bindings.heightFocusNode,
                ),
              ),
              PersonalTextField.short(
                label: 'Рост',
                controller: bindings.heightController,
                focusNode: bindings.heightFocusNode,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => bindings.submitShortField(
                  context: context,
                  save: bindings.saveHeight,
                  nextFocus: bindings.weightFocusNode,
                ),
              ),
              PersonalTextField.short(
                label: 'Вес',
                controller: bindings.weightController,
                focusNode: bindings.weightFocusNode,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => bindings.submitShortField(
                  context: context,
                  save: bindings.saveWeight,
                  nextFocus: bindings.eyesFocusNode,
                ),
              ),
              PersonalTextField.short(
                label: 'Глаза',
                controller: bindings.eyesController,
                focusNode: bindings.eyesFocusNode,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => bindings.submitShortField(
                  context: context,
                  save: bindings.saveEyes,
                  nextFocus: bindings.skinFocusNode,
                ),
              ),
              PersonalTextField.short(
                label: 'Кожа',
                controller: bindings.skinController,
                focusNode: bindings.skinFocusNode,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => bindings.submitShortField(
                  context: context,
                  save: bindings.saveSkin,
                  nextFocus: bindings.hairFocusNode,
                ),
              ),
              PersonalTextField.short(
                label: 'Волосы',
                controller: bindings.hairController,
                focusNode: bindings.hairFocusNode,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => bindings.submitShortField(
                  context: context,
                  save: bindings.saveHair,
                  nextFocus: bindings.alignmentFocusNode,
                ),
              ),
              const Gap(8),
              DropdownButtonFormField<CharacterAlignment>(
                focusNode: bindings.alignmentFocusNode,
                initialValue: alignment,
                decoration: const InputDecoration(
                  labelText: 'Мировоззрение',
                  border: OutlineInputBorder(),
                ),
                items: CharacterAlignment.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(bindings.alignmentLabel(value)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  onAlignmentChanged(value);
                  bindings.appearanceFocusNode.requestFocus();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PersonalNarrativeSection extends StatelessWidget {
  const PersonalNarrativeSection({
    required this.bindings,
    super.key,
  });

  final PersonalFormBindings bindings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionHeader(title: 'История и характер', showDivider: false),
        const Gap(12),
        AppSurfaceCard(
          padding: const EdgeInsets.all(16),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Column(
            children: [
              PersonalTextField.narrative(
                label: 'Внешность',
                controller: bindings.appearanceController,
                focusNode: bindings.appearanceFocusNode,
              ),
              PersonalTextField.narrative(
                label: 'История персонажа',
                controller: bindings.backstoryController,
                focusNode: bindings.backstoryFocusNode,
              ),
              PersonalTextField.narrative(
                label: 'Цели',
                controller: bindings.goalsController,
                focusNode: bindings.goalsFocusNode,
              ),
              PersonalTextField.narrative(
                label: 'Союзники и организации',
                controller: bindings.alliesOrganizationsController,
                focusNode: bindings.alliesOrganizationsFocusNode,
              ),
              PersonalTextField.narrative(
                label: 'Черты характера',
                controller: bindings.personalityTraitsController,
                focusNode: bindings.personalityTraitsFocusNode,
              ),
              PersonalTextField.narrative(
                label: 'Идеалы',
                controller: bindings.idealsController,
                focusNode: bindings.idealsFocusNode,
              ),
              PersonalTextField.narrative(
                label: 'Привязанности',
                controller: bindings.bondsController,
                focusNode: bindings.bondsFocusNode,
              ),
              PersonalTextField.narrative(
                label: 'Слабости',
                controller: bindings.flawsController,
                focusNode: bindings.flawsFocusNode,
              ),
              PersonalTextField.narrative(
                label: 'Доп. заметки',
                controller: bindings.notesController,
                focusNode: bindings.notesFocusNode,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PersonalTextField extends StatelessWidget {
  const PersonalTextField.short({
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.onSubmitted,
    super.key,
    this.textInputAction = TextInputAction.next,
  })  : maxLines = 1,
        minLines = 1,
        isNarrative = false;

  const PersonalTextField.narrative({
    required this.label,
    required this.controller,
    required this.focusNode,
    super.key,
  })  : minLines = 3,
        maxLines = null,
        onSubmitted = null,
        textInputAction = TextInputAction.newline,
        isNarrative = true;

  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction textInputAction;
  final int minLines;
  final int? maxLines;
  final bool isNarrative;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isNarrative ? 16.0 : 12.0),
      child: isNarrative
          ? AppAutosizeTextField(
              label: label,
              controller: controller,
              focusNode: focusNode,
              minLines: minLines,
            )
          : TextField(
              controller: controller,
              focusNode: focusNode,
              minLines: minLines,
              maxLines: maxLines,
              textInputAction: textInputAction,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                labelText: label,
                alignLabelWithHint: isNarrative,
                border: const OutlineInputBorder(),
              ),
            ),
    );
  }
}
