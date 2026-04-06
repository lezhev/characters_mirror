import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/helpers/fight_page_formatters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fight page formatters', () {
    test('formats attack bonus from proficiency, ability, and custom bonus', () {
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
  });
}
