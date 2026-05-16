import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_roll_variables.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/abilities_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/helpers/attack_dialog_controller.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/helpers/fight_page_formatters.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/widgets/attack_list_section.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/widgets/combat_stats_row.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/widgets/feature_list_section.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/widgets/fight_error_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/widgets/hit_points_calculator_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FightPage extends ConsumerWidget {
  const FightPage({
    required this.characterId,
    super.key,
  });

  final int characterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(characterSheetControllerProvider(characterId));
    final selectedFeatureTags =
        ref.watch(selectedFightFeatureTagsProvider(characterId));

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => FightErrorState(
        message: humanReadableError(error),
        onRetry: () => ref
            .read(characterSheetControllerProvider(characterId).notifier)
            .reload(),
      ),
      data: (character) {
        final attacks = character.attacks ?? const <CharacterAttackData>[];
        final displayedAttacks = attacks.isEmpty
            ? [
                CharacterAttackData(
                  leadingAbility: Ability.strength,
                  customAttackBonus: 0,
                  tags: const [],
                ),
              ]
            : attacks;
        final activeFeatures = character.derived?.activeFeatures ??
            const <CharacterFeatureViewData>[];
        final visibleFeatures = activeFeatures
            .where(
              (feature) =>
                  matchesSelectedFeatureTags(feature, selectedFeatureTags),
            )
            .toList();

        return Padding(
          padding: const EdgeInsets.all(12),
          child: PageSizeLimiter(
            child: ListView(
              children: [
                CombatStatsRow(
                  character: character,
                  onHpPressed: () => showHitPointsCalculatorSheet(
                    context: context,
                    character: character,
                    onSave: ({
                      required currentHp,
                      required temporaryHp,
                    }) {
                      return ref
                          .read(
                            characterSheetControllerProvider(characterId)
                                .notifier,
                          )
                          .saveHitPoints(
                            currentHp: currentHp,
                            temporaryHp: temporaryHp,
                          );
                    },
                    onSaveDeathSavingThrows: ({
                      required successes,
                      required failures,
                    }) {
                      return ref
                          .read(
                            characterSheetControllerProvider(characterId)
                                .notifier,
                          )
                          .saveDeathSavingThrows(
                            successes: successes,
                            failures: failures,
                          );
                    },
                    onSaveSettings: ({
                      required classEntries,
                      required hpPerLevelBonus,
                      required hpFlatBonus,
                      required currentHitDice,
                      required hitDiceMaxOverrides,
                    }) {
                      return ref
                          .read(
                            characterSheetControllerProvider(characterId)
                                .notifier,
                          )
                          .saveHitPointSettings(
                            classEntries: classEntries,
                            hpPerLevelBonus: hpPerLevelBonus,
                            hpFlatBonus: hpFlatBonus,
                            currentHitDice: currentHitDice,
                            hitDiceMaxOverrides: hitDiceMaxOverrides,
                          );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                AttackListSection(
                  attacks: displayedAttacks,
                  onAddAttack: () => AttackDialogController.createAttack(
                    context: context,
                    ref: ref,
                    characterId: characterId,
                  ),
                  attackBonusLabelBuilder: (attack) =>
                      formatAttackBonus(character, attack),
                  damageLabelBuilder: formatDamageLabel,
                  damageRollValueBuilder: formatDamageRollValue,
                  rollVariables: characterRollVariables(character),
                  onAttackPressed: (index, attack) {
                    final isPlaceholder = attacks.isEmpty;
                    if (isPlaceholder) {
                      AttackDialogController.createAttack(
                        context: context,
                        ref: ref,
                        characterId: characterId,
                        initialAttack: attack,
                      );
                      return;
                    }

                    AttackDialogController.editAttack(
                      context: context,
                      ref: ref,
                      characterId: characterId,
                      index: index,
                      attack: attack,
                    );
                  },
                ),
                const SizedBox(height: 24),
                FeatureListSection(
                  activeFeatures: activeFeatures,
                  visibleFeatures: visibleFeatures,
                  onOpenAllAbilities: () => _openAllAbilities(context),
                  onSaveFeature: (
                    feature, {
                    String? name,
                    String? description,
                    List<FeatureTag>? tags,
                  }) {
                    return ref
                        .read(characterSheetControllerProvider(characterId)
                            .notifier)
                        .saveFeatureOverride(
                          feature,
                          name: name,
                          description: description,
                          tags: tags,
                        );
                  },
                  onResetFeature: (feature) {
                    return ref
                        .read(characterSheetControllerProvider(characterId)
                            .notifier)
                        .resetFeatureOverride(feature);
                  },
                  onSetFeatureResource: (feature, resourceKey, current) {
                    return ref
                        .read(characterSheetControllerProvider(characterId)
                            .notifier)
                        .setFeatureResource(feature, resourceKey, current);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openAllAbilities(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Все способности'),
          ),
          body: AbilitiesPage(characterId: characterId),
        ),
      ),
    );
  }
}
