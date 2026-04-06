import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_step_scaffold.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/summary/widgets/summary_sections.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SummaryStep extends HookConsumerWidget {
  const SummaryStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaving = useState(false);
    final state = ref.watch(characterCreationProvider);
    final classEntries =
        state.character.classEntries ?? const <CharacterClassEntryData>[];
    final choices = state.character.choices ?? const <CharacterChoiceData>[];
    final classEntry = classEntries.isNotEmpty ? classEntries.first : null;
    final classChoiceSummary =
        formatChoiceSummary(choices.where(isClassChoice).toList());
    final backgroundChoiceSummary = formatChoiceSummary(
      choices
          .where((choice) => choice.sourceType == ChoiceSourceType.background)
          .toList(),
    );
    final raceChoiceSummary = formatChoiceSummary(
      choices
          .where(
            (choice) =>
                choice.sourceType == ChoiceSourceType.race ||
                choice.sourceType == ChoiceSourceType.subrace,
          )
          .toList(),
    );

    return CreationStepScaffold(
      route: 'character',
      onBack: () {
        ref.read(characterCreationProvider.notifier).reset();
        context.go('/characters');
      },
      onStepTap: (target) async {
        ref.read(characterCreationProvider.notifier).goToStep(context, target);
      },
      onPressedNext: () {
        _finishCreation(
          context: context,
          ref: ref,
          character: state.character,
          isSaving: isSaving,
        );
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SummaryIdentitySection(
            character: state.character,
            classEntry: classEntry,
          ),
          const Gap(24),
          SummaryChoicesSection(
            raceChoiceSummary: raceChoiceSummary,
            classChoiceSummary: classChoiceSummary,
            backgroundChoiceSummary: backgroundChoiceSummary,
          ),
          const Gap(24),
          SummaryAbilitiesSection(
            baseAbilityScores:
                state.character.baseAbilityScores ?? const <String, int>{},
          ),
        ],
      ),
    );
  }
}

Future<void> _finishCreation({
  required BuildContext context,
  required WidgetRef ref,
  required CharacterData character,
  required ValueNotifier<bool> isSaving,
}) async {
  if (isSaving.value) {
    return;
  }

  final messenger = ScaffoldMessenger.of(context);
  isSaving.value = true;

  try {
    final saved = await ref.read(characterRepositoryProvider).saveCharacter(
          character,
        );
    final characterId = saved.id;
    if (characterId == null) {
      throw StateError(
        'Сервер сохранил персонажа без идентификатора.',
      );
    }

    ref.read(characterCreationProvider.notifier).reset();

    if (!context.mounted) {
      return;
    }
    context.go('/characters/sheet/$characterId');
  } catch (error) {
    if (!context.mounted) {
      return;
    }
    messenger.showSnackBar(
      SnackBar(
        content: Text(humanReadableError(error)),
      ),
    );
  } finally {
    if (context.mounted) {
      isSaving.value = false;
    }
  }
}
