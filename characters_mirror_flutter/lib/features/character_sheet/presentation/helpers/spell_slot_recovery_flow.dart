import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import '../widgets/spell_slot_recovery_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> runSpellSlotRecovery(BuildContext context, WidgetRef ref,
    int characterId, SpellSlotRecoverySource source) async {
  final character =
      ref.read(characterSheetControllerProvider(characterId)).value;
  if (character == null) return;
  final options = spellSlotRecoveryOptions(character.toJson(), source);
  if (options.isEmpty) return;
  final selected = source.mode == 'all'
      ? <int, int>{}
      : await showDialog<Map<int, int>>(
          context: context,
          builder: (_) => SpellSlotRecoveryDialog(
                title: source.name,
                options: options,
                budget: source.budget,
                single: source.mode == 'singleLowerLevel',
              ));
  if (selected == null || !context.mounted) return;
  try {
    await ref
        .read(characterSheetControllerProvider(characterId).notifier)
        .recoverSpellSlots(source, selected);
  } catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(humanReadableError(error))));
    }
  }
}

Future<void> offerTriggeredSpellSlotRecovery(BuildContext context,
    WidgetRef ref, int characterId, String trigger) async {
  final character =
      ref.read(characterSheetControllerProvider(characterId)).value;
  if (character == null) return;
  for (final source in characterSpellSlotRecoverySources(character.toJson())
      .where((source) => source.trigger == trigger)) {
    if (!context.mounted) return;
    await runSpellSlotRecovery(context, ref, characterId, source);
  }
}

SpellSlotRecoverySource? featureResourceRecoverySource(
  Map<String, dynamic> character,
  CharacterFeatureViewData feature,
  CharacterResourceViewData resource,
) {
  final effects =
      feature.spellSlotRecoveryEffects ?? const <FeatureResourceEffectData>[];
  for (final effect in effects) {
    if (effect.type != FeatureResourceEffectType.restore ||
        (effect.targetType != FeatureResourceTargetType.spellSlots &&
            effect.targetType != FeatureResourceTargetType.pactSlots) ||
        effect.id == null ||
        effect.recoveryPolicy?.resourceKey != resource.key) {
      continue;
    }
    for (final source in characterSpellSlotRecoverySources(character)) {
      if (source.sourceType == feature.sourceType.name &&
          source.sourceId == feature.sourceId &&
          source.effectId == effect.id &&
          source.resourceKey == resource.key) {
        return source;
      }
    }
  }
  return null;
}

bool canRecoverFeatureResource(
  Map<String, dynamic> character,
  CharacterFeatureViewData feature,
  CharacterResourceViewData resource,
) {
  final source = featureResourceRecoverySource(character, feature, resource);
  return source != null &&
      spellSlotRecoveryOptions(character, source).isNotEmpty;
}

Future<void> runFeatureResourceRecovery(
  BuildContext context,
  WidgetRef ref,
  int characterId,
  CharacterFeatureViewData feature,
  CharacterResourceViewData resource,
) async {
  final character =
      ref.read(characterSheetControllerProvider(characterId)).value;
  if (character == null) return;
  final source =
      featureResourceRecoverySource(character.toJson(), feature, resource);
  if (source == null) return;
  await runSpellSlotRecovery(context, ref, characterId, source);
}
