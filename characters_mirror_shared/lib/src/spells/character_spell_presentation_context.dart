import '../feature_modifier_protocol.dart';
import 'spell_presentation.dart';
import 'spell_protocol_values.dart';

/// Builds the same presentation-only context from server or offline snapshots.
SpellPresentationContext spellPresentationContextForCharacter(
    Map<String, dynamic> character, String? castingAbility,
    {int? castLevel}) {
  final derived = character['derived'] as Map? ?? const {};
  final abilities = spellProtocolStringMap<int>(derived['abilityModifiers']);
  final scores = spellProtocolStringMap<int>(derived['abilityScores']);
  final baseScores =
      spellProtocolStringMap<int>(character['baseAbilityScores']);
  final modifier = castingAbility == null
      ? null
      : abilities[castingAbility] ??
          (((scores[castingAbility] ?? baseScores[castingAbility] ?? 10) - 10) /
                  2)
              .floor();
  final input = characterFeatureModifierInput(character);
  final proficiency = derived['proficiencyBonus'] as int? ?? 0;
  return SpellPresentationContext(
    castLevel: castLevel,
    casterLevel: derived['totalLevel'] as int? ??
        (character['classEntries'] == null
            ? 1
            : input.context.classLevelsByKey.values
                .fold<int>(0, (sum, level) => sum + level)),
    castingAbility: castingAbility,
    abilityModifier: modifier,
    attackBonus: modifier == null
        ? null
        : proficiency +
            modifier +
            (character['customSpellAttackBonus'] as int? ?? 0),
    saveDc: modifier == null
        ? null
        : 8 +
            proficiency +
            modifier +
            (character['customSpellSaveDcBonus'] as int? ?? 0),
    featureModifiers: input.modifiers,
    modifierContext: input.context,
  );
}
