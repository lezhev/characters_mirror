import 'package:characters_mirror_flutter/core/character/choice_group_presentation.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/subclass_decision.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/background_step/state/background_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/application/expertise_owned_proficiencies.dart';
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
    final data = ref.watch(classStateProvider).valueOrNull;
    final subclasses =
        data?.stepView?.subclassChoice?.subclasses ?? const <SubclassData>[];
    if (subclasses.isEmpty) return const SizedBox.shrink();
    return SubclassDecision(
        subclasses: subclasses,
        selectedId: data?.selectedSubclass?.id,
        context: ChoicePresentationContext.creation,
        onChanged: (id) {
          if (id == null) {
            ref.read(classStateProvider.notifier).unselectSubclass();
          } else {
            ref
                .read(classStateProvider.notifier)
                .selectSubclass(subclasses.firstWhere((s) => s.id == id));
          }
        });
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
  const ClassChoiceGroupCard(
      {required this.groupView, this.showTitle = true, super.key});

  final ChoiceGroupView groupView;
  final bool showTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = groupView.group;
    if (group == null) {
      return const SizedBox.shrink();
    }
    return ref.watch(classStateProvider).when(
          data: (data) {
            var eligibleView = groupView;
            if (group.type == ChoiceType.expertise) {
              final creation = ref.watch(characterCreationProvider);
              final background = ref.watch(backgroundStateProvider).valueOrNull;
              final otherOptions = resolveSelectedChoiceOptions(
                  choiceGroups: [
                    ...creation.raceChoiceGroups,
                    ...?background?.stepView?.choiceGroups
                  ],
                  savedChoices: creation.character.choices ?? [],
                  draftSelections: background?.selectedOptions ?? {});
              final keys = resolveExpertiseEligibleOptionKeys(
                      character: creation.character,
                      selectedBackground: background?.selectedBackground,
                      selectedClass: data.selectedClass,
                      classSkillSelections: data.selectedSkillSelections,
                      backgroundSkillSelections:
                          background?.selectedSkillSelections ?? [],
                      selectedOptions: data.selectedOptions,
                      otherSelectedOptions: otherOptions,
                      choiceGroups: [groupView],
                      classStep: data.stepView)[classChoiceGroupKey(group)] ??
                  {};
              eligibleView = groupView.copyWith(options: [
                for (final o in groupView.options ?? const <ChoiceOptionData>[])
                  if (keys.contains(o.optionKey.trim())) o
              ]);
            }
            return CreationChoiceGroupCard(
              groupView: eligibleView,
              showTitle: showTitle,
              selectedOptions:
                  data.selectedOptions[classChoiceGroupKey(group)] ??
                      const <ChoiceOptionData>[],
              onToggleOption:
                  ref.read(classStateProvider.notifier).toggleOption,
              onIncrementOption:
                  ref.read(classStateProvider.notifier).incrementOption,
              onDecrementOption:
                  ref.read(classStateProvider.notifier).decrementOption,
              onClearGroup: ref.read(classStateProvider.notifier).clearGroup,
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

class ClassProgressionSection extends StatelessWidget {
  const ClassProgressionSection({
    required this.currentLevelEntries,
    required this.futureProgressionEntries,
    required this.groupsByClassFeatureId,
    required this.groupsBySubclassFeatureId,
    required this.isFutureExpanded,
    required this.onToggleFuture,
    this.subclassChoiceFeatureId,
    this.sourceLevel = 1,
    this.selectedOptionIds = const {},
    this.abilityModifiers = const {},
    super.key,
  });

  final List<ClassFeatureEntry> currentLevelEntries;
  final List<ClassFeatureEntry> futureProgressionEntries;
  final Map<int, List<ChoiceGroupView>> groupsByClassFeatureId;
  final Map<int, List<ChoiceGroupView>> groupsBySubclassFeatureId;
  final bool isFutureExpanded;
  final VoidCallback onToggleFuture;
  final int? subclassChoiceFeatureId;
  final int sourceLevel;
  final Set<int> selectedOptionIds;
  final Map<Ability, int> abilityModifiers;

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
          ..._buildFeatureCards(
            currentLevelEntries,
            groupsByClassFeatureId: groupsByClassFeatureId,
            groupsBySubclassFeatureId: groupsBySubclassFeatureId,
            subclassChoiceFeatureId: subclassChoiceFeatureId,
            sourceLevel: sourceLevel,
            selectedOptionIds: selectedOptionIds,
            abilityModifiers: abilityModifiers,
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
              children: _buildFeatureCards(
                futureProgressionEntries,
                groupsByClassFeatureId: groupsByClassFeatureId,
                groupsBySubclassFeatureId: groupsBySubclassFeatureId,
                sourceLevel: sourceLevel,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

List<Widget> _buildFeatureCards(
  List<ClassFeatureEntry> entries, {
  required Map<int, List<ChoiceGroupView>> groupsByClassFeatureId,
  required Map<int, List<ChoiceGroupView>> groupsBySubclassFeatureId,
  int? subclassChoiceFeatureId,
  int sourceLevel = 1,
  Set<int> selectedOptionIds = const {},
  Map<Ability, int> abilityModifiers = const {},
}) {
  final widgets = <Widget>[];
  for (final entry in entries) {
    final featureId = entry.featureId;
    final featureChoiceGroups = featureId == null
        ? const <ChoiceGroupView>[]
        : (entry.isSubclass
                ? groupsBySubclassFeatureId[featureId]
                : groupsByClassFeatureId[featureId]) ??
            const <ChoiceGroupView>[];
    final title = entry.classFeature?.name ?? entry.subclassFeature?.name;
    widgets.add(entry.buildCard(
        sourceLevel: sourceLevel,
        selectedOptionIds: selectedOptionIds,
        abilityModifiers: abilityModifiers,
        decisions: [
          for (final groupView in featureChoiceGroups)
            Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ClassChoiceGroupCard(
                    groupView: groupView,
                    showTitle: showChoiceGroupTitle(
                        title, groupView.group?.name,
                        type: groupView.group?.type,
                        linkedGroupCount: featureChoiceGroups.length))),
          if (!entry.isSubclass &&
              featureId != null &&
              featureId == subclassChoiceFeatureId)
            const Padding(
                padding: EdgeInsets.only(top: 8),
                child: SubclassChoiceSection()),
        ]));
  }

  return widgets;
}
