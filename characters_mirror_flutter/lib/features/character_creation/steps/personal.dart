import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/personal/application/personal_form_bindings.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/personal/widgets/personal_sections.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_step_scaffold.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PersonalStep extends ConsumerStatefulWidget {
  const PersonalStep({super.key});

  @override
  ConsumerState<PersonalStep> createState() => _PersonalStepState();
}

class _PersonalStepState extends ConsumerState<PersonalStep> {
  late final CharacterCreation _creationNotifier;
  late final PersonalFormBindings _bindings;

  @override
  void initState() {
    super.initState();
    _creationNotifier = ref.read(characterCreationProvider.notifier);
    _bindings = PersonalFormBindings(
      notifier: _creationNotifier,
      character: ref.read(characterCreationProvider).character,
    );
  }

  @override
  void dispose() {
    _bindings.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(characterCreationProvider);

    return CreationStepScaffold(
      route: 'summary',
      onBack: _syncAndExit,
      onStepTap: (target) async => _syncAndGoToStep(target),
      onPressedNext: () => _syncAndGoToStep(Step.summary),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PersonalShortFieldsSection(
            bindings: _bindings,
            alignment: state.character.alignmentValue,
            onAlignmentChanged: ref
                .read(characterCreationProvider.notifier)
                .setAlignment,
          ),
          const Gap(24),
          PersonalNarrativeSection(bindings: _bindings),
        ],
      ),
    );
  }

  Future<void> _syncAndGoToStep(Step target) async {
    FocusScope.of(context).unfocus();
    _bindings.flush();
    _creationNotifier.goToStep(context, target);
  }

  void _syncAndExit() {
    FocusScope.of(context).unfocus();
    _bindings.flush();
    _creationNotifier.reset();
    context.go('/characters');
  }
}
