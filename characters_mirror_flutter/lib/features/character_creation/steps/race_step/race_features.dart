import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/state/race_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/expand_section.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/smooth_switcher.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RaceFeatures extends HookConsumerWidget {
  final RaceData selectedRace;

  const RaceFeatures({super.key, required this.selectedRace});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final isFutureFeaturesExpanded = useState(false);
    final colorScheme = Theme.of(context).colorScheme;

    List<Widget> buildFeatureSection(List<RaceFeatureData> list) {
      final widgets = <Widget>[];
      int? currentLevel;

      for (final feature in list) {
        if (feature.level != currentLevel) {
          currentLevel = feature.level;
          widgets.add(
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4),
              child: Text(
                'Уровень $currentLevel',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),
          );
        }
        widgets.add(RaceFeatureCard(feature: feature));
      }

      return widgets;
    }

    return ref.watch(raceStateProvider).when(
          data: (data) {
            final hasFeatures =
                data.features.isNotEmpty || data.futureFeatures.isNotEmpty;
            final hasSubraces = data.subraces.isNotEmpty;

            if (!hasFeatures && !hasSubraces) {
              return Center(
                child: Text('COMING SOON', style: textTheme.displayLarge),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if ((selectedRace.description ?? '').trim().isNotEmpty) ...[
                  const Gap(4),
                  Text('Описание', style: textTheme.headlineSmall),
                  const Gap(4),
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: colorScheme.primary,
                  ),
                  const Gap(8),
                  Text(
                    selectedRace.description!,
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.justify,
                  ),
                ],
                if (hasSubraces) ...[
                  const Gap(16),
                  Text('Подрасы', style: textTheme.headlineSmall),
                  const Gap(4),
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: colorScheme.primary,
                  ),
                  const Gap(8),
                  const SubraceChoice(),
                ],
                if (hasFeatures) ...[
                  const Gap(16),
                  Text('Особенности расы', style: textTheme.headlineSmall),
                  const Gap(4),
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: colorScheme.primary,
                  ),
                  const Gap(2),
                ],
                if (data.features.isNotEmpty)
                  ...buildFeatureSection(data.features),
                if (data.futureFeatures.isNotEmpty) ...[
                  const Gap(8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Будущие умения',
                          style: textTheme.titleMedium,
                        ),
                        IconButton(
                          onPressed: () => isFutureFeaturesExpanded.value =
                              !isFutureFeaturesExpanded.value,
                          icon: AnimatedRotation(
                            turns: isFutureFeaturesExpanded.value ? 0.5 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: const Icon(Icons.expand_more),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(6),
                  Container(
                    height: 2,
                    width: double.infinity,
                    color: colorScheme.outlineVariant,
                  ),
                  ExpandableSection(
                    extraOffset: 64,
                    expand: isFutureFeaturesExpanded.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: buildFeatureSection(data.futureFeatures),
                    ),
                  ),
                ],
              ],
            );
          },
          error: (e, s) => errorWidget(
            e: e,
            s: s,
            refresh: () => ref.refresh(raceStateProvider),
            context: context,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}

class RaceFeatureCard extends HookConsumerWidget {
  final RaceFeatureData feature;

  const RaceFeatureCard({super.key, required this.feature});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isExpanded = useState(false);

    return ref.watch(raceStateProvider).when(
          data: (data) {
            final choiceSets =
                feature.choiceSets ?? const <RaceChoiceSetData>[];
            final spellGrants =
                feature.spellGrants ?? const <RaceFeatureSpellGrantData>[];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.surfaceDim,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              feature.name ?? '',
                              style: textTheme.titleMedium,
                            ),
                          ),
                          IconButton(
                            onPressed: () =>
                                isExpanded.value = !isExpanded.value,
                            icon: AnimatedRotation(
                              turns: isExpanded.value ? 0.5 : 0,
                              duration: const Duration(milliseconds: 200),
                              child: const Icon(Icons.expand_more),
                            ),
                          ),
                        ],
                      ),
                      ExpandableSection(
                        extraOffset: 64,
                        expand: isExpanded.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if ((feature.description ?? '').trim().isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  feature.description!,
                                  style: textTheme.bodyMedium,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            if (spellGrants.isNotEmpty) ...[
                              const Gap(12),
                              Text('Заклинания', style: textTheme.titleSmall),
                              const Gap(8),
                              ...spellGrants.map(
                                (grant) => Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: Text(
                                    _spellGrantLabel(grant),
                                    style: textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ],
                            if (choiceSets.isNotEmpty) ...[
                              const Gap(12),
                              Text('Выборы', style: textTheme.titleSmall),
                              const Gap(8),
                              ...choiceSets.map(
                                (choiceSet) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: _RaceChoiceSetCard(
                                    choiceSet: choiceSet,
                                    selectedOptions: data
                                                .selectedChoiceOptionsByGroup[
                                            _choiceSetGroupKey(choiceSet.id) ??
                                                ''] ??
                                        const <RaceChoiceOptionData>[],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          error: (e, s) => errorWidget(
            e: e,
            s: s,
            refresh: () => ref.refresh(raceStateProvider),
            context: context,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}

class _RaceChoiceSetCard extends ConsumerWidget {
  final RaceChoiceSetData choiceSet;
  final List<RaceChoiceOptionData> selectedOptions;

  const _RaceChoiceSetCard({
    required this.choiceSet,
    required this.selectedOptions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final options = [...?choiceSet.choiceOptions]..sort(_compareChoiceOptions);
    if (options.isEmpty) return const SizedBox.shrink();

    final isAbilityChoice = choiceSet.kind == RaceChoiceKind.abilityBonusChoice;
    final selectedKeys = {
      for (final option in selectedOptions)
        if (option.optionKey?.trim().isNotEmpty == true)
          option.optionKey!.trim(),
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _raceChoiceKindLabel(choiceSet.kind),
            style: textTheme.titleSmall,
          ),
          if ((choiceSet.description ?? '').trim().isNotEmpty) ...[
            const Gap(6),
            Text(
              choiceSet.description!,
              style: textTheme.bodyMedium,
            ),
          ],
          const Gap(8),
          Text(
            isAbilityChoice
                ? 'Этот выбор применяется на шаге характеристик.'
                : 'Выберите ${choiceSet.pickCount ?? 1}.',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const Gap(8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((option) {
              final optionKey = option.optionKey?.trim();
              final isSelected =
                  optionKey != null && selectedKeys.contains(optionKey);

              return InkWell(
                onTap: isAbilityChoice
                    ? null
                    : () => ref
                        .read(raceStateProvider.notifier)
                        .toggleChoiceOption(choiceSet, option),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.outline,
                    ),
                    color: isSelected
                        ? colorScheme.primaryContainer.withValues(alpha: 0.5)
                        : Colors.transparent,
                  ),
                  child: Text(
                    _choiceOptionLabel(option),
                    style: textTheme.bodySmall,
                  ),
                ),
              );
            }).toList(),
          ),
          if (selectedOptions.any(
            (option) => (option.description ?? '').trim().isNotEmpty,
          )) ...[
            const Gap(10),
            ...selectedOptions
                .where((option) => (option.description ?? '').trim().isNotEmpty)
                .map(
                  (option) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      option.description!,
                      style: textTheme.bodyMedium,
                    ),
                  ),
                ),
          ],
        ],
      ),
    );
  }
}

class SubraceChoice extends ConsumerWidget {
  const SubraceChoice({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return ref.watch(raceStateProvider).when(
          data: (data) {
            final subclasses = data.subraces;
            final selected = data.selectedSubrace;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: subclasses.length,
                    itemBuilder: (context, index) {
                      final subrace = subclasses[index];
                      final isSelected = data.selectedSubrace == subrace;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Material(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              isSelected
                                  ? ref
                                      .read(raceStateProvider.notifier)
                                      .unselectSubrace()
                                  : ref
                                      .read(raceStateProvider.notifier)
                                      .selectSubrace(subrace);
                            },
                            splashColor: colorScheme.surfaceContainerLowest
                                .withValues(alpha: 0.7),
                            highlightColor: Colors.transparent,
                            child: Ink(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected
                                      ? colorScheme.outlineVariant
                                      : colorScheme.outline,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Center(
                                  child: Text(
                                    subrace.name ?? '',
                                    style: textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Gap(12),
                SmoothSwitcher(
                  extraOffset: 64,
                  child: selected != null
                      ? Column(
                          key: ValueKey(selected.id ?? 'empty'),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if ((selected.description ?? '').trim().isNotEmpty)
                              Text(
                                selected.description!,
                                style: textTheme.bodyMedium,
                                textAlign: TextAlign.justify,
                              ),
                          ],
                        )
                      : const SizedBox.shrink(key: ValueKey('empty')),
                ),
              ],
            );
          },
          error: (e, s) => errorWidget(
            e: e,
            s: s,
            refresh: () => ref.refresh(raceStateProvider),
            context: context,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}

int _compareChoiceOptions(RaceChoiceOptionData a, RaceChoiceOptionData b) {
  final sortCompare = (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0);
  if (sortCompare != 0) return sortCompare;
  return _choiceOptionLabel(a).compareTo(_choiceOptionLabel(b));
}

String _raceChoiceKindLabel(RaceChoiceKind? kind) {
  switch (kind) {
    case RaceChoiceKind.abilityBonusChoice:
      return 'Бонусы к характеристикам';
    case RaceChoiceKind.skillProficiencyChoice:
      return 'Навыки';
    case RaceChoiceKind.languageChoice:
      return 'Языки';
    case RaceChoiceKind.toolProficiencyChoice:
      return 'Инструменты';
    case RaceChoiceKind.cantripChoice:
      return 'Заговоры';
    case RaceChoiceKind.dragonbornAncestryChoice:
      return 'Драконье наследие';
    case null:
      return 'Выбор';
  }
}

String? _choiceSetGroupKey(int? choiceSetId) {
  if (choiceSetId == null) return null;
  return 'race_choice_$choiceSetId';
}

String _choiceOptionLabel(RaceChoiceOptionData option) {
  final explicitName = option.name?.trim();
  if (explicitName != null && explicitName.isNotEmpty) {
    return explicitName;
  }

  if (option.spell?.name?.trim().isNotEmpty == true) {
    return option.spell!.name!.trim();
  }
  if (option.skill != null) {
    return _formatName(_enumToken(option.skill));
  }
  if (option.language != null) {
    return _formatName(_enumToken(option.language));
  }
  if (option.ability != null && option.bonusValue != null) {
    return '${_formatName(_enumToken(option.ability))} +${option.bonusValue}';
  }
  if (option.ability != null) {
    return _formatName(_enumToken(option.ability));
  }
  if (option.damageType != null) {
    return _formatName(_enumToken(option.damageType));
  }
  if ((option.toolKey ?? '').trim().isNotEmpty) {
    return option.toolKey!.trim();
  }
  if ((option.optionKey ?? '').trim().isNotEmpty) {
    return option.optionKey!.trim();
  }
  return 'Выбор';
}

String _spellGrantLabel(RaceFeatureSpellGrantData grant) {
  final parts = <String>[
    grant.spell?.name ?? 'Заклинание',
    if (grant.castAtSpellLevel != null) 'ур. ${grant.castAtSpellLevel}',
    if (grant.freeCastsFormula?.trim().isNotEmpty == true)
      'бесплатно: ${grant.freeCastsFormula}',
    if (grant.freeCastsPerRest != null)
      'за ${_formatName(_enumToken(grant.freeCastsPerRest))}',
    if (grant.canAlsoCastWithSpellSlots == true) 'можно через ячейки',
  ];
  return parts.join(' • ');
}

String _enumToken(Object? value) {
  if (value == null) return 'unknown';
  final raw = value.toString();
  if (raw.trim().isEmpty) return 'unknown';
  final parts = raw.split('.');
  return parts.isEmpty ? raw : parts.last;
}

String _formatName(String value) {
  final normalized = value.replaceAllMapped(
    RegExp(r'([a-z])([A-Z])'),
    (match) => '${match.group(1)} ${match.group(2)}',
  );
  if (normalized.isEmpty) return normalized;
  return normalized[0].toUpperCase() + normalized.substring(1);
}
