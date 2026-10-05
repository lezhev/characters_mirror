import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/validation/character_validator.dart';
import 'package:characters_mirror_server/src/validation/validation_exception.dart';
import 'package:test/test.dart';

void main() {
  CharacterSpellSelectionData selection(String? entry, int classId,
          CharacterSpellSelectionKind kind, int index) =>
      CharacterSpellSelectionData(
          classEntry: entry == null ? null : CharacterClassEntryData(id: entry),
          classDataId: classId,
          kind: kind,
          spellKey: 'shield',
          selectionIndex: index);

  test('same spell preserves multiclass sources and kinds', () {
    expect(
        () => CharacterValidator.validate(CharacterData(spellSelections: [
              selection(
                  'wizard', 1, CharacterSpellSelectionKind.spellbookSpell, 0),
              selection(
                  'wizard', 1, CharacterSpellSelectionKind.preparedSpell, 0),
              selection('bard', 2, CharacterSpellSelectionKind.knownSpell, 0),
              selection('second-wizard', 1,
                  CharacterSpellSelectionKind.spellbookSpell, 0),
            ])),
        returnsNormally);
  });
  test('class id fallback distinguishes sources', () {
    expect(
        () => CharacterValidator.validate(CharacterData(spellSelections: [
              selection(null, 1, CharacterSpellSelectionKind.knownSpell, 0),
              selection(null, 2, CharacterSpellSelectionKind.knownSpell, 0),
            ])),
        returnsNormally);
  });
  test('entry identity wins over inconsistent catalog class id', () {
    expect(
        () => CharacterValidator.validate(CharacterData(spellSelections: [
              selection(
                  'wizard', 1, CharacterSpellSelectionKind.spellbookSpell, 0),
              selection(
                  'wizard', 2, CharacterSpellSelectionKind.spellbookSpell, 1),
            ])),
        throwsA(isA<InputValidationException>()));
  });
  test('duplicate source and kind is rejected even with different slots', () {
    expect(
        () => CharacterValidator.validate(CharacterData(spellSelections: [
              selection(
                  'wizard', 1, CharacterSpellSelectionKind.spellbookSpell, 0),
              selection(
                  'wizard', 1, CharacterSpellSelectionKind.spellbookSpell, 1),
            ])),
        throwsA(isA<InputValidationException>()));
  });
}
