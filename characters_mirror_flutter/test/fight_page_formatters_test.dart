import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/helpers/fight_page_formatters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fight page formatters', () {
    test('formats attack bonus from proficiency, ability, and custom bonus',
        () {
      final character = CharacterData(
        derived: CharacterDerivedData(
          proficiencyBonus: 2,
          abilityModifiers: const {'strength': 3},
        ),
      );
      final attack = CharacterAttackData(
        leadingAbility: Ability.strength,
        customAttackBonus: 1,
      );

      expect(formatAttackBonus(character, attack), '+6');
    });

    test('keeps legacy damage label unchanged', () {
      final attack = CharacterAttackData(
        damage: '1d8',
        damageType: DamageType.slashing,
      );

      expect(formatDamageLabel(attack), '1d8');
      expect(formatDamageRollValue(attack), '1d8');
    });

    test('formats multiple damage parts', () {
      final attack = CharacterAttackData(
        damageParts: [
          DamagePartData(
            formula: '4d6',
            damageType: DamageType.fire,
          ),
          DamagePartData(
            formula: '4d6',
            damageType: DamageType.radiant,
          ),
        ],
      );

      expect(formatDamageLabel(attack), '4d6 огонь + 4d6 излучение');
      expect(formatDamageRollValue(attack), '4d6 + 4d6');
    });

    test('builds effective spell damage parts from legacy fields', () {
      final spell = SpellData(
        damageDice: '8d6',
        damageType: DamageType.fire,
        damageScaling: SpellScalingData(
          mode: SpellScalingMode.slotLevel,
          scalingBySlotLevel: const {4: '9d6'},
        ),
      );

      final parts = effectiveSpellDamageParts(spell);

      expect(parts, hasLength(1));
      expect(parts.single.formula, '8d6');
      expect(parts.single.damageType, DamageType.fire);
      expect(parts.single.scaling?.scalingBySlotLevel, const {4: '9d6'});
    });

    test('filters abilities by selected tags', () {
      final feature = CharacterFeatureViewData(
        sourceType: CharacterFeatureSourceType.classFeature,
        sourceId: 1,
        tags: const [FeatureTag.combat],
        defaultTags: const [FeatureTag.utility],
      );

      expect(
        matchesSelectedFeatureTags(feature, {FeatureTag.combat}),
        isTrue,
      );
      expect(
        matchesSelectedFeatureTags(feature, {FeatureTag.defense}),
        isFalse,
      );
    });

    test('suggests only unselected matching weapon properties', () {
      final result = matchingWeaponPropertySuggestions(
        query: 'fi',
        selectedTags: const ['heavy'],
      );

      expect(result, ['finesse']);
    });

    test('localizes known weapon property tags', () {
      expect(attackTagLabel('finesse'), 'Фехтовальное');
      expect(attackTagLabel('two-handed'), 'Двуручное');
      expect(attackTagLabel('martial'), 'martial');
    });
  });
}
