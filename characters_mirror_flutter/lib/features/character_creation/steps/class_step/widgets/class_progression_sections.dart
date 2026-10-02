import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/expandable_section.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/character_creation_choice_builder.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/state/class_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/widgets/class_feature_cards.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_choice_group_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubclassChoiceSection extends ConsumerWidget {
  const SubclassChoiceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final sectionTitleStyle = textTheme.titleLarge?.copyWith(
      color: colorScheme.onSurface,
    );

    return ref.watch(classStateProvider).when(
          data: (data) {
            final subclasses = data.stepView?.subclassChoice?.subclasses ??
                const <SubclassData>[];
            final selected = data.selectedSubclass;
            if (subclasses.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSectionHeader(
                  title: 'Подкласс',
                  showDivider: false,
                  titleStyle: sectionTitleStyle,
                ),
                const Gap(8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: subclasses.map((subclass) {
                    final isSelected = selected?.id == subclass.id;
                    return InkWell(
                      onTap: () {
                        isSelected
                            ? ref
                                .read(classStateProvider.notifier)
                                .unselectSubclass()
                            : ref
                                .read(classStateProvider.notifier)
                                .selectSubclass(subclass);
                      },
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
                        ),
                        child: Text(
                          subclass.name ?? '',
                          style: textTheme.bodyMedium,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (selected != null &&
                    (selected.description ?? '').isNotEmpty) ...[
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

class ClassChoiceGroupsSection extends ConsumerWidget {
  const ClassChoiceGroupsSection({
    required this.choiceGroups,
    super.key,
  });

  final List<ChoiceGroupView> choiceGroups;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (choiceGroups.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final sectionTitleStyle = theme.textTheme.titleLarge?.copyWith(
      color: theme.colorScheme.onSurface,
    );

    return ref.watch(classStateProvider).when(
          data: (data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSectionHeader(
                  title: 'Владения класса',
                  showDivider: false,
                  titleStyle: sectionTitleStyle,
                ),
                const Gap(8),
                ...choiceGroups
                    .where((groupView) => groupView.group != null)
                    .map(
                      (groupView) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ClassChoiceGroupCard(groupView: groupView),
                      ),
                    ),
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
  const ClassChoiceGroupCard({required this.groupView, super.key});

  final ChoiceGroupView groupView;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = groupView.group;
    if (group == null || group.type == ChoiceType.expertise) {
      return const SizedBox.shrink();
    }
    return ref.watch(classStateProvider).when(
          data: (data) => CreationChoiceGroupCard(
            groupView: groupView,
            selectedOptions: data.selectedOptions[classChoiceGroupKey(group)] ??
                const <ChoiceOptionData>[],
            onToggleOption: ref.read(classStateProvider.notifier).toggleOption,
            onIncrementOption:
                ref.read(classStateProvider.notifier).incrementOption,
            onDecrementOption:
                ref.read(classStateProvider.notifier).decrementOption,
            onClearGroup: ref.read(classStateProvider.notifier).clearGroup,
          ),
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

class ClassProgressionSection extends StatelessWidget {
  const ClassProgressionSection({
    required this.currentLevelEntries,
    required this.futureProgressionEntries,
    required this.groupsByClassFeatureId,
    required this.groupsBySubclassFeatureId,
    required this.isFutureExpanded,
    required this.onToggleFuture,
    super.key,
  });

  final List<ClassFeatureEntry> currentLevelEntries;
  final List<ClassFeatureEntry> futureProgressionEntries;
  final Map<int, List<ChoiceGroupView>> groupsByClassFeatureId;
  final Map<int, List<ChoiceGroupView>> groupsBySubclassFeatureId;
  final bool isFutureExpanded;
  final VoidCallback onToggleFuture;

  @override
  Widget build(BuildContext context) {
    if (currentLevelEntries.isEmpty && futureProgressionEntries.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (currentLevelEntries.isNotEmpty) ...[
          AppSectionHeader(
            title: 'Умения текущего уровня',
            showDivider: false,
            titleStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const Gap(8),
          ..._buildFeatureLevelGroups(
            context,
            currentLevelEntries,
            groupsByClassFeatureId: groupsByClassFeatureId,
            groupsBySubclassFeatureId: groupsBySubclassFeatureId,
          ),
        ],
        if (futureProgressionEntries.isNotEmpty) ...[
          if (currentLevelEntries.isNotEmpty) const Gap(12),
          InkWell(
            onTap: onToggleFuture,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Будущая прогрессия',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                Icon(
                  isFutureExpanded ? Icons.expand_less : Icons.expand_more,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
          const Gap(8),
          ExpandableSection(
            extraOffset: 64,
            expand: isFutureExpanded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildFeatureLevelGroups(
                context,
                futureProgressionEntries,
                groupsByClassFeatureId: groupsByClassFeatureId,
                groupsBySubclassFeatureId: groupsBySubclassFeatureId,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

List<Widget> _buildFeatureLevelGroups(
  BuildContext context,
  List<ClassFeatureEntry> entries, {
  required Map<int, List<ChoiceGroupView>> groupsByClassFeatureId,
  required Map<int, List<ChoiceGroupView>> groupsBySubclassFeatureId,
}) {
  final textTheme = Theme.of(context).textTheme;
  final colorScheme = Theme.of(context).colorScheme;
  final widgets = <Widget>[];
  int? currentLevel;

  for (final entry in entries) {
    if (entry.level != currentLevel) {
      currentLevel = entry.level;
      if (widgets.isNotEmpty) {
        widgets.add(const Gap(10));
      }
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: Text(
            'Уровень $currentLevel',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
            ),
          ),
        ),
      );
    }
    widgets.add(entry.buildCard());
    final featureId = entry.featureId;
    final featureChoiceGroups = featureId == null
        ? const <ChoiceGroupView>[]
        : (entry.isSubclass
                ? groupsBySubclassFeatureId[featureId]
                : groupsByClassFeatureId[featureId]) ??
            const <ChoiceGroupView>[];
    for (final groupView in featureChoiceGroups) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 8),
          child: ClassChoiceGroupCard(groupView: groupView),
        ),
      );
    }
  }

  return widgets;
}
