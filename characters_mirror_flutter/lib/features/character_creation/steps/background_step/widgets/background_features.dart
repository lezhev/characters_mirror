import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/character_creation_choice_builder.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/background_step/state/background_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/application/expertise_owned_proficiencies.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/state/class_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_choice_group_card.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_choice_selector.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/skill_selection_section.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/starting_equipment_section.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/attributes/helpers/attributes_labels.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BackgroundFeatures extends ConsumerWidget {
  const BackgroundFeatures({
    required this.selectedBackground,
    required this.stepView,
    super.key,
  });

  final BackgroundData selectedBackground;
  final BackgroundStepView? stepView;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final sectionTitleStyle = textTheme.titleLarge?.copyWith(
      color: colorScheme.onSurface,
    );
    final backgroundName = selectedBackground.name?.trim();
    final backgroundTitle = backgroundName == null || backgroundName.isEmpty
        ? 'Особенности предыстории'
        : backgroundName;
    final creationState = ref.watch(characterCreationProvider);
    final character = creationState.character;
    final creationNotifier = ref.read(characterCreationProvider.notifier);
    final choiceGroups = stepView?.choiceGroups ?? const <ChoiceGroupView>[];
    final classState = ref.watch(classStateProvider).valueOrNull;
    final backgroundState = ref.watch(backgroundStateProvider).valueOrNull;
    final classChoiceGroups =
        classState?.stepView?.choiceGroups ?? const <ChoiceGroupView>[];
    final expertiseChoiceGroups = <ChoiceGroupView>[];
    if (classState != null) {
      final otherSelectedOptions = resolveSelectedChoiceOptions(
        choiceGroups: [
          ...creationState.raceChoiceGroups,
          ...choiceGroups,
        ],
        savedChoices: character.choices ?? const [],
        draftSelections: backgroundState?.selectedOptions ?? const {},
      );
      final eligibleKeys = resolveExpertiseEligibleOptionKeys(
        character: character,
        selectedBackground: backgroundState?.selectedBackground,
        selectedClass: classState.selectedClass,
        classSkillSelections: classState.selectedSkillSelections,
        backgroundSkillSelections:
            backgroundState?.selectedSkillSelections ?? const [],
        selectedOptions: classState.selectedOptions,
        otherSelectedOptions: otherSelectedOptions,
        choiceGroups: classChoiceGroups,
      );
      for (final groupView in classChoiceGroups) {
        final group = groupView.group;
        if (group?.type != ChoiceType.expertise) continue;
        final groupKey = classChoiceGroupKey(group!);
        final eligibleKeysForGroup = eligibleKeys[groupKey] ?? const <String>{};
        expertiseChoiceGroups.add(
          groupView.copyWith(
            options: [
              for (final option
                  in groupView.options ?? const <ChoiceOptionData>[])
                if (eligibleKeysForGroup.contains(option.optionKey.trim()))
                  option,
            ],
          ),
        );
      }
    }
    final languageChoiceGroups = choiceGroups
        .where((groupView) => groupView.group?.type == ChoiceType.language)
        .toList();
    final otherChoiceGroups = choiceGroups
        .where((groupView) => groupView.group?.type != ChoiceType.language)
        .toList();
    final hasLanguageChoiceGroup = choiceGroups.any(
      (groupView) => groupView.group?.type == ChoiceType.language,
    );
    final startingEquipmentBlocks = stepView?.startingEquipmentBlocks ??
        const <StartingEquipmentBlockView>[];
    final skillSelectionGroups =
        stepView?.skillSelectionGroups ?? const <SkillSelectionGroupView>[];
    final fixedSkillLabels = selectedBackground.skillProficiencies
        ?.map(skillLabel)
        .toList(growable: false);
    final toolsByKey = {
      for (final tool
          in ref.watch(toolCatalogProvider).valueOrNull ?? const <ToolData>[])
        tool.referenceKey: tool.name,
    };
    final toolProficiencyLabels = [
      for (final key in selectedBackground.toolProficiencyKeys ?? const [])
        if (toolsByKey[key] case final name?) name,
    ];
    final hasProficienciesOrLanguages = _hasAnyValues([
          fixedSkillLabels,
          toolProficiencyLabels,
        ]) ||
        skillSelectionGroups.isNotEmpty ||
        languageChoiceGroups.isNotEmpty ||
        (!hasLanguageChoiceGroup &&
            _hasPositiveCount(selectedBackground.languageCount));
    final cards = <Widget>[
      if (_hasText(selectedBackground.description))
        BackgroundFeatureCard(
          title: 'Описание',
          child: Text(
            selectedBackground.description!,
            style: textTheme.bodyMedium,
            textAlign: TextAlign.justify,
          ),
        ),
      if (_hasText(selectedBackground.feature))
        BackgroundFeatureCard(
          title: 'Особенность',
          child: Text(
            selectedBackground.feature!,
            style: textTheme.bodyMedium,
            textAlign: TextAlign.justify,
          ),
        ),
      if (selectedBackground.coins != null)
        BackgroundFeatureCard(
          title: 'Ресурсы',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (selectedBackground.coins != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Монеты: ${_formatCoins(selectedBackground.coins!)}',
                    style: textTheme.bodyMedium,
                  ),
                ),
            ],
          ),
        ),
    ];

    if (cards.isEmpty &&
        !hasProficienciesOrLanguages &&
        choiceGroups.isEmpty &&
        expertiseChoiceGroups.isEmpty &&
        startingEquipmentBlocks.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text('COMING SOON', style: textTheme.displayLarge),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(title: backgroundTitle),
        const Gap(2),
        ...cards,
        if (hasProficienciesOrLanguages) ...[
          const Gap(12),
          AppSectionHeader(
            title: 'Владения и языки',
            showDivider: false,
            titleStyle: sectionTitleStyle,
          ),
          const Gap(8),
          BackgroundValueGroup(
            label: 'Владение навыками',
            values: fixedSkillLabels,
          ),
          if (skillSelectionGroups.isNotEmpty) ...[
            const Gap(8),
            SkillSelectionSection(
              groups: skillSelectionGroups,
              selections: ref
                      .watch(backgroundStateProvider)
                      .valueOrNull
                      ?.selectedSkillSelections ??
                  const <CharacterSkillSelectionData>[],
              onToggleSkill: ref
                  .read(backgroundStateProvider.notifier)
                  .toggleSkillSelection,
              onClearGroup: ref
                  .read(backgroundStateProvider.notifier)
                  .clearSkillSelectionGroup,
            ),
          ],
          BackgroundChoiceGroupCards(choiceGroups: languageChoiceGroups),
          BackgroundValueGroup(
            label: 'Владение инструментами',
            values: toolProficiencyLabels,
          ),
          BackgroundCountGroup(
            label: 'Языков на выбор',
            count: hasLanguageChoiceGroup
                ? null
                : selectedBackground.languageCount,
          ),
        ],
        if (startingEquipmentBlocks.isNotEmpty) ...[
          const Gap(12),
          StartingEquipmentSection(
            blocks: startingEquipmentBlocks,
            selections: ref
                    .watch(backgroundStateProvider)
                    .valueOrNull
                    ?.startingEquipmentSelections ??
                const <CharacterStartingEquipmentSelectionData>[],
            onSelectOption: ref
                .read(backgroundStateProvider.notifier)
                .selectStartingEquipmentOption,
            onSelectFixedBlock: ref
                .read(backgroundStateProvider.notifier)
                .selectStartingEquipmentFixedBlock,
            onClearBlock: ref
                .read(backgroundStateProvider.notifier)
                .clearStartingEquipmentBlock,
            onSetResolution: ({
              required blockView,
              required line,
              required catalogType,
              required referenceKey,
            }) {
              ref
                  .read(backgroundStateProvider.notifier)
                  .setStartingEquipmentResolution(
                    blockView: blockView,
                    line: line,
                    catalogType: catalogType,
                    referenceKey: referenceKey,
                  );
            },
          ),
        ],
        if (expertiseChoiceGroups.isNotEmpty) ...[
          const Gap(12),
          ExpertiseChoiceGroupsSection(choiceGroups: expertiseChoiceGroups),
        ],
        if (otherChoiceGroups.isNotEmpty) ...[
          const Gap(12),
          BackgroundChoiceGroupsSection(choiceGroups: otherChoiceGroups),
        ],
        if (_hasAnyValues([
          selectedBackground.suggestedPersonality,
          selectedBackground.suggestedIdeal,
          selectedBackground.suggestedBond,
          selectedBackground.suggestedFlaw,
        ])) ...[
          const Gap(12),
          BackgroundFeatureCard(
            title: 'Ролевые зацепки',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackgroundPromptGroup(
                  label: 'Черты характера',
                  values: selectedBackground.suggestedPersonality,
                  selectedValue: character.personalityTraits,
                  onSelect: creationNotifier.setPersonalityTraits,
                ),
                BackgroundPromptGroup(
                  label: 'Идеалы',
                  values: selectedBackground.suggestedIdeal,
                  selectedValue: character.ideals,
                  onSelect: creationNotifier.setIdeals,
                ),
                BackgroundPromptGroup(
                  label: 'Привязанности',
                  values: selectedBackground.suggestedBond,
                  selectedValue: character.bonds,
                  onSelect: creationNotifier.setBonds,
                ),
                BackgroundPromptGroup(
                  label: 'Слабости',
                  values: selectedBackground.suggestedFlaw,
                  selectedValue: character.flaws,
                  onSelect: creationNotifier.setFlaws,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class ExpertiseChoiceGroupsSection extends ConsumerWidget {
  const ExpertiseChoiceGroupsSection({required this.choiceGroups, super.key});

  final List<ChoiceGroupView> choiceGroups;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(classStateProvider).when(
          data: (data) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppSectionHeader(
                title: 'Компетентность',
                showDivider: false,
                titleStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const Gap(8),
              for (final groupView in choiceGroups)
                if (groupView.group case final group?) ...[
                  Builder(builder: (context) {
                    final key = classChoiceGroupKey(group);
                    final eligibleOptionKeys = {
                      for (final option
                          in groupView.options ?? const <ChoiceOptionData>[])
                        option.optionKey.trim(),
                    };
                    final selected = [
                      for (final option in data.selectedOptions[key] ??
                          const <ChoiceOptionData>[])
                        if (eligibleOptionKeys
                            .contains(option.optionKey.trim()))
                          option,
                    ];
                    final selectionCount = group.selectionCount ?? 1;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Выбрано: ${selected.length} из $selectionCount. '
                          'Можно выбрать ещё ${selectionCount - selected.length}.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: CreationChoiceGroupCard(
                            groupView: groupView,
                            selectedOptions: selected,
                            onToggleOption: ref
                                .read(classStateProvider.notifier)
                                .toggleOption,
                            onIncrementOption: ref
                                .read(classStateProvider.notifier)
                                .incrementOption,
                            onDecrementOption: ref
                                .read(classStateProvider.notifier)
                                .decrementOption,
                            onClearGroup: ref
                                .read(classStateProvider.notifier)
                                .clearGroup,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
            ],
          ),
          error: (error, stackTrace) => Text('$error, $stackTrace'),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}

class BackgroundCountGroup extends StatelessWidget {
  const BackgroundCountGroup({
    required this.label,
    required this.count,
    super.key,
  });

  final String label;
  final int? count;

  @override
  Widget build(BuildContext context) {
    if (!_hasPositiveCount(count)) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        '$label: $count',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class BackgroundChoiceGroupsSection extends ConsumerWidget {
  const BackgroundChoiceGroupsSection({
    required this.choiceGroups,
    super.key,
  });

  final List<ChoiceGroupView> choiceGroups;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (choiceGroups.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(
          title: 'Владения предыстории',
          showDivider: false,
          titleStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const Gap(8),
        BackgroundChoiceGroupCards(choiceGroups: choiceGroups),
      ],
    );
  }
}

class BackgroundChoiceGroupCards extends ConsumerWidget {
  const BackgroundChoiceGroupCards({
    required this.choiceGroups,
    super.key,
  });

  final List<ChoiceGroupView> choiceGroups;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (choiceGroups.isEmpty) {
      return const SizedBox.shrink();
    }

    return ref.watch(backgroundStateProvider).when(
          data: (data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...choiceGroups
                    .where((groupView) => groupView.group != null)
                    .map(
                      (groupView) => Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: CreationChoiceGroupCard(
                          groupView: groupView,
                          selectedOptions: data.selectedOptions[
                                  classChoiceGroupKey(groupView.group!)] ??
                              const <ChoiceOptionData>[],
                          onToggleOption: ref
                              .read(backgroundStateProvider.notifier)
                              .toggleOption,
                          onIncrementOption: ref
                              .read(backgroundStateProvider.notifier)
                              .incrementOption,
                          onDecrementOption: ref
                              .read(backgroundStateProvider.notifier)
                              .decrementOption,
                          onClearGroup: ref
                              .read(backgroundStateProvider.notifier)
                              .clearGroup,
                        ),
                      ),
                    ),
              ],
            );
          },
          error: (e, s) => Text('$e, $s'),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}

class BackgroundFeatureCard extends StatelessWidget {
  const BackgroundFeatureCard({
    required this.title,
    required this.child,
    super.key,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelLarge),
          const Gap(8),
          child,
        ],
      ),
    );
  }
}

class BackgroundValueGroup extends StatelessWidget {
  const BackgroundValueGroup({
    required this.label,
    required this.values,
    super.key,
  });

  final String label;
  final List<dynamic>? values;

  @override
  Widget build(BuildContext context) {
    if (!_hasTextList(values)) {
      return const SizedBox.shrink();
    }

    final items = values!
        .map(_displayValue)
        .where((value) => value.trim().isNotEmpty)
        .toList();

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CreationChoiceSelector.fixed(
        title: label,
        switchKey: label,
        items: [
          for (final item in items)
            CreationChoiceSelectorItem(
              id: item,
              title: item,
              isSelected: true,
              isEnabled: false,
            ),
        ],
      ),
    );
  }
}

class BackgroundPromptGroup extends StatelessWidget {
  const BackgroundPromptGroup({
    required this.label,
    required this.values,
    required this.selectedValue,
    required this.onSelect,
    super.key,
  });

  final String label;
  final List<String>? values;
  final String? selectedValue;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    if (!_hasTextList(values)) {
      return const SizedBox.shrink();
    }

    final prompts = values!
        .map(_parsePromptCard)
        .where((prompt) => prompt.title.isNotEmpty)
        .toList();

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CreationChoiceSelector.fixed(
        title: label,
        switchKey: label,
        items: [
          for (final prompt in prompts)
            CreationChoiceSelectorItem(
              id: '${label}_${prompt.title}',
              title: prompt.title,
              isSelected: _isSelectedPrompt(selectedValue, prompt.raw),
              onTap: () => onSelect(prompt.raw),
              onInfoTap: prompt.description.isEmpty
                  ? null
                  : () => showChoiceOptionPlaceholderDialog(
                        context: context,
                        title: prompt.title,
                        description: prompt.description,
                      ),
            ),
        ],
      ),
    );
  }
}

bool _hasText(String? value) => value != null && value.trim().isNotEmpty;

bool _hasTextList(List<dynamic>? values) =>
    values != null &&
    values.any((value) => _displayValue(value).trim().isNotEmpty);

bool _hasAnyValues(List<List<dynamic>?> groups) =>
    groups.any((group) => _hasTextList(group));

bool _hasPositiveCount(int? value) => value != null && value > 0;

_PromptCardData _parsePromptCard(String raw) {
  final normalized = raw.trim();
  if (normalized.isEmpty) {
    return const _PromptCardData(title: '', description: '', raw: '');
  }

  final dotIndex = normalized.indexOf('.');
  if (dotIndex == -1) {
    return _PromptCardData(title: normalized, description: '', raw: normalized);
  }

  final title = normalized.substring(0, dotIndex).trim();
  final description = normalized.substring(dotIndex + 1).trim();
  return _PromptCardData(
    title: title,
    description: description,
    raw: normalized,
  );
}

bool _isSelectedPrompt(String? selectedValue, String raw) {
  final normalizedSelected = selectedValue?.trim();
  return normalizedSelected != null &&
      normalizedSelected.isNotEmpty &&
      normalizedSelected == raw;
}

String _formatCoins(double value) {
  return value.truncateToDouble() == value
      ? value.toInt().toString()
      : value.toString();
}

String _displayValue(dynamic value) {
  if (value == null) {
    return '';
  }
  if (value is String) {
    return value;
  }

  final raw = value.name?.toString() ?? value.toString();
  final normalized = raw.replaceAllMapped(
    RegExp(r'([a-z])([A-Z])'),
    (match) => '${match.group(1)} ${match.group(2)}',
  );

  return normalized.isEmpty
      ? normalized
      : normalized[0].toUpperCase() + normalized.substring(1);
}

class _PromptCardData {
  const _PromptCardData({
    required this.title,
    required this.description,
    required this.raw,
  });

  final String title;
  final String description;
  final String raw;
}
