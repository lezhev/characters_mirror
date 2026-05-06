import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/state/class_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/widgets/class_feature_cards.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/widgets/class_profile_card.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/widgets/class_progression_sections.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/widgets/class_spell_selection_section.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/skill_selection_section.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/starting_equipment_section.dart';
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
        currentStepView.choiceGroups ?? const <ClassChoiceGroupView>[];
    final currentLevelEntries = [
      for (final feature
          in currentStepView.currentLevelFeatures ?? const <ClassFeatureData>[])
        ClassFeatureEntry.classFeature(feature),
      for (final feature in currentStepView.currentSubclassFeatures ??
          const <SubclassFeatureData>[])
        ClassFeatureEntry.subclassFeature(feature),
    ]..sort(_compareFeatureEntries);
    final futureProgressionEntries = [
      for (final feature
          in currentStepView.futureLevelFeatures ?? const <ClassFeatureData>[])
        ClassFeatureEntry.classFeature(feature),
      for (final feature in currentStepView.futureSubclassFeatures ??
          const <SubclassFeatureData>[])
        ClassFeatureEntry.subclassFeature(feature),
    ]..sort(_compareFeatureEntries);
    final subclassChoice = currentStepView.subclassChoice;
    final className = currentStepView.classData!.name?.trim();
    final classTitle =
        className == null || className.isEmpty ? 'Профиль класса' : className;

    return ref.watch(classStateProvider).when(
          data: (stateData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSectionHeader(title: classTitle),
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
                if ((currentStepView.spellSelectionGroups?.isNotEmpty ??
                    false)) ...[
                  const Gap(12),
                  ClassSpellSelectionSection(
                    groups: currentStepView.spellSelectionGroups ??
                        const <ClassSpellSelectionGroupView>[],
                    selections: stateData.selectedSpellSelections,
                    onToggleSpell: ref
                        .read(classStateProvider.notifier)
                        .toggleSpellSelection,
                    onClearGroup: ref
                        .read(classStateProvider.notifier)
                        .clearSpellSelectionGroup,
                  ),
                ],
                if (choiceGroups.isNotEmpty) ...[
                  const Gap(12),
                  ClassChoiceGroupsSection(choiceGroups: choiceGroups),
                ],
                if (subclassChoice != null &&
                    (subclassChoice.requiredLevel ?? 99) <= selectedLevel &&
                    (subclassChoice.subclasses?.isNotEmpty ?? false)) ...[
                  const Gap(12),
                  const SubclassChoiceSection(),
                ],
                if (currentLevelEntries.isNotEmpty ||
                    futureProgressionEntries.isNotEmpty) ...[
                  const Gap(12),
                  ClassProgressionSection(
                    currentLevelEntries: currentLevelEntries,
                    futureProgressionEntries: futureProgressionEntries,
                    isFutureExpanded: isFutureExpanded.value,
                    onToggleFuture: () =>
                        isFutureExpanded.value = !isFutureExpanded.value,
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
