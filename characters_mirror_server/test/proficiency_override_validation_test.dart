import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/validation/character_validator.dart';
import 'package:characters_mirror_server/src/validation/validation_exception.dart';
import 'package:test/test.dart';

void main() {
  CharacterData characterWithCustomLanguage(String? value) => CharacterData(
        manualLanguageOverrides: CharacterLanguageOverridesData(
          custom: value == null ? null : [value],
        ),
      );

  test('custom proficiency labels accept 119 and 120 characters', () {
    expect(
      () => CharacterValidator.validate(
        characterWithCustomLanguage('a' * 119),
      ),
      returnsNormally,
    );
    expect(
      () => CharacterValidator.validate(
        characterWithCustomLanguage('a' * 120),
      ),
      returnsNormally,
    );
  });

  test('custom proficiency labels reject 121, empty, and whitespace-only', () {
    for (final value in ['a' * 121, '', ' \t\n ']) {
      expect(
        () => CharacterValidator.validate(characterWithCustomLanguage(value)),
        throwsA(isA<InputValidationException>()),
        reason: 'invalid label should be rejected: ${value.length} chars',
      );
    }
  });

  test('custom proficiency list accepts 64 and rejects 65 values', () {
    CharacterData characterWithCount(int count) => CharacterData(
          manualToolProficiencyOverrides: CharacterToolProficiencyOverridesData(
            custom: List.generate(count, (index) => 'Custom tool $index'),
          ),
        );

    expect(
      () => CharacterValidator.validate(characterWithCount(64)),
      returnsNormally,
    );
    expect(
      () => CharacterValidator.validate(characterWithCount(65)),
      throwsA(isA<InputValidationException>()),
    );
  });

  test('duplicates do not bypass the raw 64-entry collection limit', () {
    final character = CharacterData(
      manualLanguageOverrides: CharacterLanguageOverridesData(
        custom: List.filled(65, 'Same language'),
      ),
    );

    expect(
      () => CharacterValidator.validate(character),
      throwsA(isA<InputValidationException>()),
    );
  });
}
