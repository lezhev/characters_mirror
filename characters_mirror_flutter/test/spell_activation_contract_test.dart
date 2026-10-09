import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:characters_mirror_flutter/core/character_spells/spell_cast_application.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/widgets/race_choice_set_card.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('race grant label uses only explicit activation when present', () {
    final grant = RaceFeatureSpellGrantData(
        featureId: 1,
        spellId: 2,
        spell: SpellData(name: 'Spell'),
        freeCastsFormula: '9',
        freeCastsPerRest: RestType.shortRest,
        castAtSpellLevel: 4,
        canAlsoCastWithSpellSlots: true,
        activation: SpellActivationData(
            canUseStandardSlots: false,
            canUsePactSlots: false,
            slotless: true,
            atWill: false,
            freeCasts: 1,
            resetOn: RestType.longRest,
            castAtSpellLevel: 2));
    final expected = spellGrantLabel(grant.copyWith(
        activation: null,
        freeCastsFormula: '1',
        freeCastsPerRest: RestType.longRest,
        castAtSpellLevel: 2,
        canAlsoCastWithSpellSlots: false));
    expect(spellGrantLabel(grant), expected);
  });

  test('offline typed cast rejects contradictory activation before spending',
      () {
    final c = CharacterData(
        derived: CharacterDerivedData(resolvedSpells: [
      ResolvedCharacterSpellData(
          spellKey: 'spell',
          spell: SpellData(level: 1),
          sources: [
            SpellSourceContextData(
                sourceKey: 'grant',
                label: 'Grant',
                known: true,
                prepared: true,
                alwaysPrepared: false,
                granted: true,
                canUseSlots: false,
                activation: SpellActivationData(
                    canUseStandardSlots: false,
                    canUsePactSlots: false,
                    slotless: true,
                    atWill: true,
                    resourceKey: 'ki',
                    resourceCost: 2))
          ])
    ]));
    expect(
        () => applyCharacterSpellCast(
            c,
            CharacterSemanticActionData(
                spellKey: 'spell',
                spellSourceKey: 'grant',
                level: 1,
                slotSource: 'none',
                spellPayment: 'atWill')),
        throwsA(isA<SpellCastFailure>()
            .having((e) => e.code, 'code', 'invalid_activation')));
    expect(c.resourceStates, isNull);
    expect(c.spellActivationUses, isNull);
  });
}
