import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character_spells/spell_cast_application.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('offline cast limit and pact payment match shared/server contract', () {
    final character = CharacterData(
      currentPactSlots: {1: 2},
      derived: CharacterDerivedData(
        pactSlots: {1: 2},
        resolvedSpells: [
          ResolvedCharacterSpellData(
            spellKey: 'bane',
            spell: SpellData(level: 1),
            sources: [
              SpellSourceContextData(
                sourceKey: 'classGrant:1',
                label: 'Invocation grant',
                known: true,
                prepared: true,
                alwaysPrepared: false,
                granted: true,
                canUseSlots: false,
                activation: SpellActivationData(
                  canUseStandardSlots: false,
                  canUsePactSlots: true,
                  slotless: false,
                  atWill: false,
                  maxCasts: 1,
                  castsResetOn: RestType.longRest,
                ),
              ),
            ],
          ),
        ],
      ),
    );
    final spent = applyCharacterSpellCast(
      character,
      CharacterSemanticActionData(
        spellKey: 'bane',
        spellSourceKey: 'classGrant:1',
        level: 1,
        slotSource: 'pact',
        spellPayment: 'slot',
      ),
    );
    expect(spent.currentPactSlots, {1: 1});
    expect(spent.spellActivationUses, {'castLimit:classGrant:1': 1});
    expect(
        () => applyCharacterSpellCast(
              character,
              CharacterSemanticActionData(
                spellKey: 'bane',
                spellSourceKey: 'classGrant:1',
                level: 1,
                slotSource: 'standard',
                spellPayment: 'slot',
              ),
            ),
        throwsA(isA<Exception>()));
    expect(
        () => applyCharacterSpellCast(
              spent,
              CharacterSemanticActionData(
                spellKey: 'bane',
                spellSourceKey: 'classGrant:1',
                level: 1,
                slotSource: 'pact',
                spellPayment: 'slot',
              ),
            ),
        throwsA(isA<Exception>()));
  });

  test('offline semantic cast spends the same upcast resource amount', () {
    final character = CharacterData(
      derived: CharacterDerivedData(
        spellSlots: {1: 2},
        pactSlots: {1: 1},
        activeFeatures: [
          CharacterFeatureViewData(
            sourceType: CharacterFeatureSourceType.classFeature,
            sourceId: 12,
            sourceClassLevel: 5,
            resources: [
              CharacterResourceViewData(
                  key: 'ki', kind: FeatureResourceKind.uses, current: 3, max: 3)
            ],
          ),
        ],
        resolvedSpells: [
          ResolvedCharacterSpellData(
            spellKey: 'burning_hands',
            spell: SpellData(level: 1, name: 'Burning Hands'),
            sources: [
              SpellSourceContextData(
                sourceKey: 'grant:1',
                label: 'Grant',
                known: true,
                prepared: true,
                alwaysPrepared: false,
                granted: true,
                canUseSlots: false,
                resourceSourceType: CharacterFeatureSourceType.classFeature,
                resourceSourceId: 12,
                activation: SpellActivationData(
                  canUseStandardSlots: false,
                  canUsePactSlots: false,
                  slotless: true,
                  atWill: false,
                  resourceKey: 'ki',
                  resourceCost: 2,
                  resourceUpcastPolicy: SpellResourceUpcastPolicyData(
                    resourcePerAdditionalSpellLevel: 1,
                    maxResourceCostBySourceLevel: {1: 2, 5: 3},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final cast = applyCharacterSpellCast(
      character,
      CharacterSemanticActionData(
        spellKey: 'burning_hands',
        spellSourceKey: 'grant:1',
        level: 2,
        slotSource: 'none',
        spellPayment: 'resource',
      ),
    );
    expect(cast.resourceStates?.single.current, 0);
    expect(cast.currentSpellSlots, isNull);
    expect(cast.currentPactSlots, isNull);
  });
}
