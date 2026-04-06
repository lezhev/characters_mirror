import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/helpers/fight_page_formatters.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/widgets/attack_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AttackDialogController {
  const AttackDialogController._();

  static Future<void> createAttack({
    required BuildContext context,
    required WidgetRef ref,
    required int characterId,
    CharacterAttackData? initialAttack,
  }) async {
    final notifier =
        ref.read(characterSheetControllerProvider(characterId).notifier);
    var createdIndex = -1;
    CharacterAttackData? lastSaved;

    await showAttackDialog(
      context,
      attack: initialAttack ??
          CharacterAttackData(
            leadingAbility: Ability.strength,
            customAttackBonus: 0,
            tags: const [],
          ),
      isCreating: true,
      onDraftChanged: (draft) async {
        if (attackEquals(lastSaved, draft)) {
          return;
        }

        if (createdIndex < 0) {
          await notifier.addAttack(draft);
          final current = ref
              .read(characterSheetControllerProvider(characterId))
              .valueOrNull;
          createdIndex = (current?.attacks?.length ?? 1) - 1;
        } else {
          await notifier.updateAttack(createdIndex, draft);
        }

        lastSaved = draft;
      },
    );
  }

  static Future<void> editAttack({
    required BuildContext context,
    required WidgetRef ref,
    required int characterId,
    required int index,
    required CharacterAttackData attack,
  }) async {
    final notifier =
        ref.read(characterSheetControllerProvider(characterId).notifier);

    await showAttackDialog(
      context,
      attack: attack,
      isCreating: false,
      onDraftChanged: (draft) => notifier.updateAttack(index, draft),
      onDelete: () => notifier.deleteAttack(index),
    );
  }
}
