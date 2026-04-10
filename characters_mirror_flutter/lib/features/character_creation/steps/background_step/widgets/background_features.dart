import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/character_creation_choice_builder.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/background_step/state/background_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_choice_group_card.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/starting_equipment_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BackgroundFeatures extends ConsumerWidget {
  const BackgroundFeatures({
    required this.selectedBackground,
    required this.stepView,
    required this.selectedOptions,
    super.key,
  });

  final BackgroundData selectedBackground;
  final BackgroundStepView? stepView;
  final Map<String, List<ClassChoiceOptionData>> selectedOptions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
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
      if (_hasAnyValues([
        selectedBackground.skillProficiencies,
        selectedBackground.toolProficiencies,
        selectedBackground.languages,
      ]))
        BackgroundFeatureCard(
          title: 'Владения и языки',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackgroundValueGroup(
                label: 'Владение навыками',
                values: selectedBackground.skillProficiencies,
              ),
              BackgroundValueGroup(
                label: 'Владение инструментами',
                values: selectedBackground.toolProficiencies,
              ),
              BackgroundValueGroup(
                label: 'Языки',
                values: selectedBackground.languages,
              ),
            ],
          ),
        ),
      if (_hasTextList(selectedBackground.items) ||
          selectedBackground.coins != null)
        BackgroundFeatureCard(
          title: 'Снаряжение и ресурсы',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackgroundValueGroup(
                label: 'Предметы',
                values: selectedBackground.items,
              ),
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
      if (_hasAnyValues([
        selectedBackground.suggestedPersonality,
        selectedBackground.suggestedIdeal,
        selectedBackground.suggestedBond,
        selectedBackground.suggestedFlaw,
      ]))
        BackgroundFeatureCard(
          title: 'Ролевые зацепки',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackgroundPromptGroup(
                label: 'Черты характера',
                values: selectedBackground.suggestedPersonality,
              ),
              BackgroundPromptGroup(
                label: 'Идеалы',
                values: selectedBackground.suggestedIdeal,
              ),
              BackgroundPromptGroup(
                label: 'Привязанности',
                values: selectedBackground.suggestedBond,
              ),
              BackgroundPromptGroup(
                label: 'Слабости',
                values: selectedBackground.suggestedFlaw,
              ),
            ],
          ),
        ),
    ];
    final choiceCards =
        (stepView?.choiceGroups ?? const <ClassChoiceGroupView>[])
            .where((groupView) => groupView.group != null)
            .map(
              (groupView) => Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CreationChoiceGroupCard(
                  groupView: groupView,
                  selectedOptions:
                      selectedOptions[classChoiceGroupKey(groupView.group!)] ??
                          const <ClassChoiceOptionData>[],
                  onToggleOption:
                      ref.read(backgroundStateProvider.notifier).toggleOption,
                  onIncrementOption: ref
                      .read(backgroundStateProvider.notifier)
                      .incrementOption,
                  onDecrementOption: ref
                      .read(backgroundStateProvider.notifier)
                      .decrementOption,
                  onClearGroup:
                      ref.read(backgroundStateProvider.notifier).clearGroup,
                ),
              ),
            )
            .toList();

    if (cards.isEmpty && choiceCards.isEmpty) {
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
        const AppSectionHeader(title: 'Особенности предыстории'),
        const Gap(2),
        ...cards,
        if ((stepView?.startingEquipmentBlocks?.isNotEmpty ?? false)) ...[
          const Gap(12),
          StartingEquipmentSection(
            blocks: stepView?.startingEquipmentBlocks ??
                const <StartingEquipmentBlockView>[],
            selections: ref
                    .watch(backgroundStateProvider)
                    .valueOrNull
                    ?.startingEquipmentSelections ??
                const <CharacterStartingEquipmentSelectionData>[],
            onSelectOption: ref
                .read(backgroundStateProvider.notifier)
                .selectStartingEquipmentOption,
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
        if (choiceCards.isNotEmpty) ...[
          const Gap(12),
          const AppSectionHeader(title: 'Выборы предыстории'),
          const Gap(2),
          ...choiceCards,
        ],
      ],
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

    final textTheme = Theme.of(context).textTheme;
    final chips = values!
        .map(_displayValue)
        .where((value) => value.trim().isNotEmpty)
        .map(
          (value) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(value, style: textTheme.bodySmall),
          ),
        )
        .toList();

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: textTheme.titleSmall),
          const Gap(6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: chips,
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
    super.key,
  });

  final String label;
  final List<String>? values;

  @override
  Widget build(BuildContext context) {
    if (!_hasTextList(values)) {
      return const SizedBox.shrink();
    }

    final textTheme = Theme.of(context).textTheme;
    final prompts = values!.where((value) => value.trim().isNotEmpty).toList();

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: textTheme.titleSmall),
          const Gap(6),
          ...prompts.map(
            (value) => Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                '• $value',
                style: textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
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
