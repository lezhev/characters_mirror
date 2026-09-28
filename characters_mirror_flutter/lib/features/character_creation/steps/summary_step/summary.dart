import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/state/race_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_step_scaffold.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/summary_step/application/summary_overview_data.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/summary_step/widgets/summary_overview.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SummaryStep extends HookConsumerWidget {
  const SummaryStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaving = useState(false);
    final state = ref.watch(characterCreationProvider);
    final characterRaceId = state.character.race?.id;
    final raceState = ref.watch(raceStateProvider).valueOrNull;
    final hasSubraceOptions = characterRaceId != null &&
        raceState?.selectedRace?.id == characterRaceId &&
        raceState!.subraces.any(
          (subrace) => subrace.parentRaceId == characterRaceId,
        );
    final data = SummaryOverviewData.fromState(
      state: state,
      hasSubraceOptions: hasSubraceOptions,
    );

    return CreationStepScaffold(
      route: 'character',
      onBack: () =>
          ref.read(characterCreationProvider.notifier).prevStep(context),
      onStepTap: (target) async {
        ref
            .read(characterCreationProvider.notifier)
            .editStepFromSummary(context, target);
      },
      onPressedNext: () {
        _finishCreation(
          context: context,
          ref: ref,
          character: state.character,
          isSaving: isSaving,
        );
      },
      body: SummaryOverview(
        data: data,
        onEdit: (target) => ref
            .read(characterCreationProvider.notifier)
            .editStepFromSummary(context, target),
        onPortraitTap: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Выбор портрета скоро появится.')),
        ),
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
