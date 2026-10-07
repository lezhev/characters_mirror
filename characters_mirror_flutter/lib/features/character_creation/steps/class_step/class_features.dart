import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character/feature_presentation.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/state/class_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/widgets/class_feature_cards.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/widgets/class_profile_card.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/widgets/class_progression_sections.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/skill_selection_section.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/starting_equipment_section.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_spell_selection_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClassFeatures extends HookConsumerWidget {
  const ClassFeatures({
    required this.stepView,
    required this.selectedLevel,
    super.key,
  });

  final ClassStepView? stepView;
  final int selectedLevel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFutureExpanded = useState(false);
    final currentStepView = stepView;

    if (currentStepView == null || currentStepView.classData == null) {
      return const SizedBox.shrink();
    }

    final choiceGroups =
        currentStepView.choiceGroups ?? const <ChoiceGroupView>[];
    final groupsByClassFeatureId = <int, List<ChoiceGroupView>>{};
    final groupsBySubclassFeatureId = <int, List<ChoiceGroupView>>{};
    final standaloneChoiceGroups = <ChoiceGroupView>[];
    for (final groupView in choiceGroups) {
      final group = groupView.group;
      if (group == null) continue;
      final featureId = group.sourceFeatureId;
      final subclassFeatureId = group.sourceSubclassFeatureId;
      if (featureId != null &&
          (currentStepView.currentLevelFeatures
                      ?.any((f) => f.id == featureId) ==
                  true ||
              currentStepView.currentLevelFeatureViews
                      ?.any((v) => v.classFeature?.id == featureId) ==
                  true)) {
        groupsByClassFeatureId.putIfAbsent(featureId, () => []).add(groupView);
      } else if (subclassFeatureId != null &&
          (currentStepView.currentSubclassFeatures
                      ?.any((f) => f.id == subclassFeatureId) ==
                  true ||
              currentStepView.currentSubclassFeatureViews?.any(
                      (v) => v.subclassFeature?.id == subclassFeatureId) ==
                  true)) {
        groupsBySubclassFeatureId
            .putIfAbsent(subclassFeatureId, () => [])
            .add(groupView);
      } else {
        standaloneChoiceGroups.add(groupView);
      }
    }
    for (final groups in [
      ...groupsByClassFeatureId.values,
      ...groupsBySubclassFeatureId.values,
    ]) {
      groups.sort((left, right) =>
          (left.group?.sortOrder ?? 0).compareTo(right.group?.sortOrder ?? 0));
    }
    standaloneChoiceGroups.sort((left, right) =>
        (left.group?.sortOrder ?? 0).compareTo(right.group?.sortOrder ?? 0));
    final currentLevelEntries = [
      for (final feature in _classFeaturePresentationViews(
        currentStepView.currentLevelFeatures,
        currentStepView.currentLevelFeatureViews,
      ))
        ClassFeatureEntry.classFeature(feature),
      for (final feature in _subclassFeaturePresentationViews(
        currentStepView.currentSubclassFeatures,
        currentStepView.currentSubclassFeatureViews,
      ))
        ClassFeatureEntry.subclassFeature(feature),
    ]..sort(_compareFeatureEntries);
    final futureProgressionEntries = [
      for (final feature in _classFeaturePresentationViews(
        currentStepView.futureLevelFeatures,
        currentStepView.futureLevelFeatureViews,
      ))
        ClassFeatureEntry.classFeature(feature),
      for (final feature in _subclassFeaturePresentationViews(
        currentStepView.futureSubclassFeatures,
        currentStepView.futureSubclassFeatureViews,
      ))
        ClassFeatureEntry.subclassFeature(feature),
    ]..sort(_compareFeatureEntries);
    final subclassChoice = currentStepView.subclassChoice;
    final hasSubclassDecision = subclassChoice != null &&
        (subclassChoice.requiredLevel ?? 99) <= selectedLevel &&
        (subclassChoice.subclasses?.isNotEmpty ?? false);
    final subclassChoiceFeatureId = hasSubclassDecision &&
            currentLevelEntries.any((e) =>
                !e.isSubclass &&
                e.featureId != null &&
                e.featureId == subclassChoice.sourceFeatureId)
        ? subclassChoice.sourceFeatureId
        : null;
    final className = currentStepView.classData!.name?.trim();
    final classTitle =
        className == null || className.isEmpty ? 'Профиль класса' : className;

    return ref.watch(classStateProvider).when(
          data: (stateData) {
            final scores = ref.watch(characterCreationProvider
                .select((state) => state.character.baseAbilityScores));
            final abilityModifiers = {
              for (final a in Ability.values)
                a: (((scores?[a.name] ?? 10) - 10) / 2).floor()
            };
            final selectedOptionIds = {
              for (final options in stateData.selectedOptions.values)
                for (final option in options)
                  if (option.id != null) option.id!
            };
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSectionHeader(title: classTitle, showDivider: false),
                const Gap(8),
                ClassProfileCard(classData: currentStepView.classData!),
                if ((currentStepView.startingEquipmentBlocks?.isNotEmpty ??
                    false)) ...[
                  const Gap(12),
                  StartingEquipmentSection(
                    blocks: currentStepView.startingEquipmentBlocks ??
                        const <StartingEquipmentBlockView>[],
                    selections: stateData.startingEquipmentSelections,
                    onSelectOption: ref
                        .read(classStateProvider.notifier)
                        .selectStartingEquipmentOption,
                    onSelectFixedBlock: ref
                        .read(classStateProvider.notifier)
                        .selectStartingEquipmentFixedBlock,
                    onClearBlock: ref
                        .read(classStateProvider.notifier)
                        .clearStartingEquipmentBlock,
                    onSetResolution: ({
                      required blockView,
                      required line,
                      required catalogType,
                      required referenceKey,
                    }) {
                      ref
                          .read(classStateProvider.notifier)
                          .setStartingEquipmentResolution(
                            blockView: blockView,
                            line: line,
                            catalogType: catalogType,
                            referenceKey: referenceKey,
                          );
                    },
                  ),
                ],
                if ((currentStepView.skillSelectionGroups?.isNotEmpty ??
                    false)) ...[
                  const Gap(12),
                  SkillSelectionSection(
                    groups: currentStepView.skillSelectionGroups ??
                        const <SkillSelectionGroupView>[],
                    selections: stateData.selectedSkillSelections,
                    onToggleSkill: ref
                        .read(classStateProvider.notifier)
                        .toggleSkillSelection,
                    onClearGroup: ref
                        .read(classStateProvider.notifier)
                        .clearSkillSelectionGroup,
                  ),
                ],
                if (standaloneChoiceGroups.isNotEmpty) ...[
                  const Gap(12),
                  ClassChoiceGroupsSection(
                      choiceGroups: standaloneChoiceGroups),
                ],
                if (hasSubclassDecision && subclassChoiceFeatureId == null) ...[
                  const Gap(12),
                  const SubclassChoiceSection(),
                ],
                if (currentLevelEntries.isNotEmpty ||
                    futureProgressionEntries.isNotEmpty) ...[
                  const Gap(12),
                  ClassProgressionSection(
                    currentLevelEntries: currentLevelEntries,
                    subclassChoiceFeatureId: subclassChoiceFeatureId,
                    sourceLevel: selectedLevel,
                    selectedOptionIds: selectedOptionIds,
                    abilityModifiers: abilityModifiers,
                    futureProgressionEntries: futureProgressionEntries,
                    groupsByClassFeatureId: groupsByClassFeatureId,
                    groupsBySubclassFeatureId: groupsBySubclassFeatureId,
                    isFutureExpanded: isFutureExpanded.value,
                    onToggleFuture: () =>
                        isFutureExpanded.value = !isFutureExpanded.value,
                  ),
                ],
                if (currentStepView.spellSelectionGroups?.any((group) =>
                        group.kind != null &&
                        (group.options?.isNotEmpty ?? false)) ??
                    false) ...[
                  const Gap(12),
                  ClassSpellSelectionSection(
                    groups: currentStepView.spellSelectionGroups!,
                    selections: stateData.selectedSpellSelections,
                    onToggleSpell: ref
                        .read(classStateProvider.notifier)
                        .toggleSpellSelection,
                    onClearGroup: ref
                        .read(classStateProvider.notifier)
                        .clearSpellSelectionGroup,
                  ),
                ],
                if ((currentStepView.multiclassWarnings?.isNotEmpty ??
                    false)) ...[
                  const Gap(12),
                  for (final warning in currentStepView.multiclassWarnings!)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        warning,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.error,
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

List<ClassStepFeatureView> _classFeaturePresentationViews(
  List<ClassFeatureData>? features,
  List<ClassStepFeatureView>? views,
) {
  return stepFeatureViews(features, null, views, null);
}

List<ClassStepFeatureView> _subclassFeaturePresentationViews(
  List<SubclassFeatureData>? features,
  List<ClassStepFeatureView>? views,
) {
  return stepFeatureViews(null, features, null, views);
}

int _compareFeatureEntries(ClassFeatureEntry left, ClassFeatureEntry right) {
  final levelCompare = left.level.compareTo(right.level);
  if (levelCompare != 0) {
    return levelCompare;
  }
  if (left.isSubclass == right.isSubclass) {
    return 0;
  }
  return left.isSubclass ? 1 : -1;
}
