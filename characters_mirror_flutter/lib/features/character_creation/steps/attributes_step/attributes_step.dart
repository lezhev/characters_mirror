import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/character_creation_ability_scores.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_step_scaffold.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/state/attribute_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/widgets/attribute_selection.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/selection_type.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/state/class_state.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AttributesStep extends ConsumerWidget {
  const AttributesStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CreationStepScaffold(
      route: 'personal',
      scrollableBody: false,
      onBack: () {
        ref.read(characterCreationProvider.notifier).reset();
        context.go('/characters');
      },
      onStepTap: (target) async => _syncAndGo(
        context: context,
        ref: ref,
        target: target,
      ),
      onPressedNext: () {
        unawaited(_syncAndGo(
          context: context,
          ref: ref,
          target: null,
        ));
      },
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SelectionType(type: SelectType.defaultType),
              SelectionType(type: SelectType.random),
              SelectionType(type: SelectType.purchace),
              SelectionType(type: SelectType.manual),
            ],
          ),
          const Gap(8),
          Divider(
            color: Theme.of(context).colorScheme.outline,
          ),
          const Gap(8),
          AttributeSelection()
        ],
      ),
    );
  }
}

Future<void> _syncAndGo({
  required BuildContext context,
  required WidgetRef ref,
  required Step? target,
}) async {
  final notifier = ref.read(characterCreationProvider.notifier);
  ref.read(attributeStateProvider.notifier).syncActiveDraftToCharacter();
  final character = ref.read(characterCreationProvider).character;
  final choices = character.choices ?? const <CharacterChoiceData>[];
  final abilityScores = buildCharacterCreationAbilityScores(
    character,
    choices,
    choiceGroups: ref.read(characterCreationProvider).raceChoiceGroups,
  );
  await ref
      .read(classStateProvider.notifier)
      .refreshSpellSelectionGroupsForAbilityScores(abilityScores);
  if (!context.mounted) {
    return;
  }
  final classState = ref.read(classStateProvider).valueOrNull;
  final hasSpellGroups = classState?.stepView?.spellSelectionGroups?.any(
        (group) => group.kind != null && (group.options?.isNotEmpty ?? false),
      ) ??
      false;

  if (classState != null) {
    ref.read(characterCreationProvider.notifier).syncPrimaryClassDraft(
          classData: classState.selectedClass,
          subclass: classState.selectedSubclass,
          choiceGroups: classState.stepView?.choiceGroups ?? const [],
          selectedOptions: classState.selectedOptions,
          skillSelections: classState.selectedSkillSelections,
          spellSelections: classState.selectedSpellSelections,
          startingEquipmentSelections: classState.startingEquipmentSelections,
          hasSpellCreationStep: hasSpellGroups,
          level: classState.selectedLevel,
        );
  }

  notifier.goToStep(context, target ?? Step.personal);
}
