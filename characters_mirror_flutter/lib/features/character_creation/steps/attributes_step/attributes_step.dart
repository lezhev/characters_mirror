import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_step_scaffold.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/state/attribute_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/widgets/attribute_selection.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/selection_type.dart';
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
        final notifier = ref.read(characterCreationProvider.notifier);
        notifier.syncAttributesDraft(_baseAttributes(ref));
        notifier.syncRacialAttributeChoicesDraft(_racialAttributeChoices(ref));
        notifier.nextStep(context);
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

Map<String, int> _baseAttributes(WidgetRef ref) {
  return ref
      .read(attributeStateProvider)
      .assignedAttributes
      .map((key, value) => MapEntry(key.name, value));
}

List<CharacterChoiceData> _racialAttributeChoices(WidgetRef ref) {
  return ref
      .read(attributeStateProvider.notifier)
      .buildRacialAttributeChoices();
}

void _syncAndGo({
  required BuildContext context,
  required WidgetRef ref,
  required Step target,
}) {
  final notifier = ref.read(characterCreationProvider.notifier);
  notifier.syncAttributesDraft(_baseAttributes(ref));
  notifier.syncRacialAttributeChoicesDraft(_racialAttributeChoices(ref));
  notifier.goToStep(context, target);
}
