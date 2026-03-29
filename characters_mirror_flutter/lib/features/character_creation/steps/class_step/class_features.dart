import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/state/class_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/expand_section.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClassFeatures extends HookConsumerWidget {
  final ClassStepView? stepView;
  final int selectedLevel;

  const ClassFeatures({
    super.key,
    required this.stepView,
    required this.selectedLevel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final isFutureExpanded = useState(false);
    final currentStepView = stepView;

    if (currentStepView == null || currentStepView.classData == null) {
      return const SizedBox.shrink();
    }

    final classData = currentStepView.classData!;
    final choiceGroups = currentStepView.choiceGroups ?? const <ClassChoiceGroupView>[];
    final currentFeatures =
        currentStepView.currentLevelFeatures ?? const <ClassFeatureData>[];
    final futureFeatures =
        currentStepView.futureLevelFeatures ?? const <ClassFeatureData>[];
    final subclassChoice = currentStepView.subclassChoice;

    return ref.watch(classStateProvider).when(
          data: (data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Профиль класса', style: textTheme.headlineSmall),
                const Gap(4),
                Container(width: double.infinity, height: 2, color: colorScheme.primary),
                const Gap(8),
                _MetaCard(classData: classData),
                if (subclassChoice != null &&
                    (subclassChoice.requiredLevel ?? 99) <= selectedLevel &&
                    (subclassChoice.subclasses?.isNotEmpty ?? false)) ...[
                  const Gap(12),
                  Text('Подкласс', style: textTheme.titleLarge),
                  const Gap(8),
                  const SubclassChoice(),
                ],
                if (choiceGroups.isNotEmpty) ...[
                  const Gap(12),
                  Text('Выборы класса', style: textTheme.titleLarge),
                  const Gap(8),
                  ...choiceGroups
                      .where((groupView) => groupView.group != null)
                      .map((groupView) => ClassChoiceGroupCard(groupView: groupView))
                ],
                if (currentFeatures.isNotEmpty) ...[
                  const Gap(12),
                  Text('Умения текущего уровня', style: textTheme.titleLarge),
                  const Gap(8),
                  ...currentFeatures.map((feature) => ClassFeatureCard(feature: feature)),
                ],
                if (futureFeatures.isNotEmpty) ...[
                  const Gap(12),
                  InkWell(
                    onTap: () => isFutureExpanded.value = !isFutureExpanded.value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Будущая прогрессия', style: textTheme.titleLarge),
                        Icon(
                          isFutureExpanded.value
                              ? Icons.expand_less
                              : Icons.expand_more,
                        ),
                      ],
                    ),
                  ),
                  const Gap(8),
                  ExpandableSection(
                    extraOffset: 64,
                    expand: isFutureExpanded.value,
                    child: Column(
                      children: futureFeatures
                          .map((feature) => ClassFeatureCard(feature: feature))
                          .toList(),
                    ),
                  ),
                ],
                if ((currentStepView.multiclassWarnings?.isNotEmpty ?? false)) ...[
                  const Gap(12),
                  ...currentStepView.multiclassWarnings!.map(
                    (warning) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        warning,
                        style: textTheme.bodySmall?.copyWith(color: colorScheme.error),
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
          error: (e, s) => errorWidget(
            e: e,
            s: s,
            refresh: () => ref.refresh(classStateProvider),
            context: context,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}

class _MetaCard extends StatelessWidget {
  final ClassData classData;

  const _MetaCard({required this.classData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labels = <String>[
      if (_hitDieLabel(classData) != null) 'Кость хитов: ${_hitDieLabel(classData)}',
      if (classData.primaryAbilities?.isNotEmpty ?? false)
        'Ключевые характеристики: ${_joinNames(classData.primaryAbilities!)}',
      if (classData.savingThrowProficiencies?.isNotEmpty ?? false)
        'Спасброски: ${_joinNames(classData.savingThrowProficiencies!)}',
      if (classData.availableSkills?.isNotEmpty ?? false)
        'Навыки на выбор (${classData.skillCount ?? 0}): ${_joinNames(classData.availableSkills!)}',
      if (_spellcastingAbilityLabel(classData) != null)
        'Базовая характеристика заклинаний: ${_spellcastingAbilityLabel(classData)}',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.surfaceDim,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if ((classData.description ?? '').isNotEmpty) ...[
            Text(
              classData.description!,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            const Gap(8),
          ],
          ...labels.map(
            (label) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(label, style: theme.textTheme.bodyMedium),
            ),
          ),
        ],
      ),
    );
  }
}

class ClassFeatureCard extends StatelessWidget {
  final ClassFeatureData feature;

  const ClassFeatureCard({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tags = feature.tags ?? const <FeatureTag>[];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.surfaceDim,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Уровень ${feature.level}: ${feature.name ?? 'Без названия'}',
              style: theme.textTheme.titleMedium,
            ),
            const Gap(6),
            if ((feature.description ?? '').isNotEmpty)
              Text(
                feature.description!,
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
            if (tags.isNotEmpty) ...[
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags
                    .map(
                      (tag) => Chip(
                        label: Text(_formatName(_enumToken(tag))),
                        visualDensity: VisualDensity.compact,
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class SubclassChoice extends ConsumerWidget {
  const SubclassChoice({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ref.watch(classStateProvider).when(
          data: (data) {
            final subclasses = data.stepView?.subclassChoice?.subclasses ?? const <SubclassData>[];
            final selected = data.selectedSubclass;
            if (subclasses.isEmpty) return const SizedBox.shrink();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: subclasses.map((subclass) {
                    final isSelected = selected?.id == subclass.id;
                    return InkWell(
                      onTap: () {
                        isSelected
                            ? ref.read(classStateProvider.notifier).unselectSubclass()
                            : ref.read(classStateProvider.notifier).selectSubclass(subclass);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? colorScheme.primary
                                : colorScheme.outline,
                          ),
                        ),
                        child: Text(subclass.name ?? '', style: textTheme.bodyMedium),
                      ),
                    );
                  }).toList(),
                ),
                if (selected != null && (selected.description ?? '').isNotEmpty) ...[
                  const Gap(10),
                  Text(
                    selected.description!,
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ],
            );
          },
          error: (e, s) => errorWidget(
            e: e,
            s: s,
            refresh: () => ref.refresh(classStateProvider),
            context: context,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}

class ClassChoiceGroupCard extends ConsumerWidget {
  final ClassChoiceGroupView groupView;

  const ClassChoiceGroupCard({super.key, required this.groupView});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = groupView.group!;
    final options = groupView.options ?? const <ClassChoiceOptionData>[];
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return ref.watch(classStateProvider).when(
          data: (data) {
            final key = group.exclusiveKey?.trim().isNotEmpty == true
                ? group.exclusiveKey!
                : 'group_${group.id ?? group.name ?? _enumToken(group.type)}';
            final selected = data.selectedOptions[key];

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(group.name ?? 'Выбор', style: textTheme.titleMedium),
                    if ((group.description ?? '').isNotEmpty) ...[
                      const Gap(6),
                      Text(group.description!, style: textTheme.bodyMedium),
                    ],
                    const Gap(10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: options.map((option) {
                        final isSelected = selected?.id == option.id;
                        return InkWell(
                          onTap: () {
                            if (isSelected) {
                              ref.read(classStateProvider.notifier).unselectOption(group);
                              return;
                            }
                            ref.read(classStateProvider.notifier).selectOption(group, option);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? colorScheme.primary
                                    : colorScheme.outline,
                              ),
                            ),
                            child: Text(option.name ?? '', style: textTheme.bodySmall),
                          ),
                        );
                      }).toList(),
                    ),
                    if (selected != null && (selected.description ?? '').isNotEmpty) ...[
                      const Gap(10),
                      Text(selected.description!, style: textTheme.bodyMedium),
                    ],
                  ],
                ),
              ),
            );
          },
          error: (e, s) => errorWidget(
            e: e,
            s: s,
            refresh: () => ref.refresh(classStateProvider),
            context: context,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}

String _joinNames(List<dynamic> values) =>
    values.map((value) => _formatName(_enumToken(value))).join(', ');

String? _hitDieLabel(ClassData classData) {
  if (classData.hitDieValue != null) {
    return 'd${classData.hitDieValue}';
  }
  return null;
}

String? _spellcastingAbilityLabel(ClassData classData) {
  if (classData.spellcastingAbilityValue != null) {
    return _formatName(_enumToken(classData.spellcastingAbilityValue));
  }
  return null;
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
  return normalized.isEmpty
      ? normalized
      : normalized[0].toUpperCase() + normalized.substring(1);
}
