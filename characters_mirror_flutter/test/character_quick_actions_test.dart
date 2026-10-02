import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/quick_actions_sheet.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('hasActiveCharacterStatus', () {
    test('is false when no tracked status is active', () {
      expect(hasActiveCharacterStatus(CharacterData(id: 1)), isFalse);
    });

    test('is true for inspiration', () {
      expect(
        hasActiveCharacterStatus(CharacterData(id: 1, inspiration: true)),
        isTrue,
      );
    });

    test('is true for active conditions', () {
      expect(
        hasActiveCharacterStatus(
          CharacterData(id: 1, activeConditions: [ConditionType.poisoned]),
        ),
        isTrue,
      );
    });

    test('is true for positive exhaustion', () {
      expect(
        hasActiveCharacterStatus(CharacterData(id: 1, exhaustionLevel: 1)),
        isTrue,
      );
    });

    test('is true for a non-empty concentration name', () {
      expect(
        hasActiveCharacterStatus(
          CharacterData(id: 1, activeConcentrationSpellName: ' Bless '),
        ),
        isTrue,
      );
    });

    test('ignores whitespace-only concentration names', () {
      expect(
        hasActiveCharacterStatus(
          CharacterData(id: 1, activeConcentrationSpellName: '  '),
        ),
        isFalse,
      );
    });
  });
}
