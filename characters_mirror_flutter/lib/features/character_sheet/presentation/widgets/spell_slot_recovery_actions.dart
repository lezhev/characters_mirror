import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import '../helpers/spell_slot_recovery_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpellSlotRecoveryActions extends ConsumerWidget {
  const SpellSlotRecoveryActions(
      {required this.characterId, required this.feature, super.key});
  final int characterId;
  final CharacterFeatureViewData feature;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final character =
        ref.watch(characterSheetControllerProvider(characterId)).value;
    if (character == null) return const SizedBox.shrink();
    final sources = characterSpellSlotRecoverySources(character.toJson()).where(
        (source) =>
            source.sourceType == feature.sourceType.name &&
            source.sourceId == feature.sourceId &&
            source.resourceKey == null &&
            source.trigger != 'spellCast');
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      for (final source in sources)
        TextButton.icon(
          key: ValueKey('spell-slot-recovery-${source.key}'),
          onPressed: spellSlotRecoveryOptions(character.toJson(), source)
                  .isEmpty
              ? null
              : () => runSpellSlotRecovery(context, ref, characterId, source),
          icon: const Icon(Icons.auto_awesome_outlined),
          label: Text(source.policy['activationSeconds'] == 60
              ? 'Восстановить ячейки (1 минута)'
              : 'Восстановить ячейки'),
        ),
    ]);
  }
}
