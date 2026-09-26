import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_proficiency_editor_operations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('removing an automatic canonical value adds a removal delta', () {
    final removed = CharacterProficiencyEditorOperations.removeLanguage(
      CharacterData(),
      Language.common,
    );

    expect(
      removed.manualLanguageOverrides?.removed,
      [Language.common],
    );
  });

  test('adding a removed canonical value clears the removal delta', () {
    final added = CharacterProficiencyEditorOperations.addLanguage(
      CharacterData(
        manualLanguageOverrides: CharacterLanguageOverridesData(
          removed: const [Language.common],
        ),
      ),
      Language.common,
    );

    expect(added.manualLanguageOverrides?.removed, isEmpty);
    expect(added.manualLanguageOverrides?.added, isEmpty);
  });

  test('removing a manual canonical addition removes it from additions', () {
    final removed = CharacterProficiencyEditorOperations.removeToolKey(
      CharacterData(
        manualToolProficiencyOverrides: CharacterToolProficiencyOverridesData(
          addedKeys: const ['lute'],
        ),
      ),
      'lute',
    );

    expect(removed.manualToolProficiencyOverrides?.addedKeys, isEmpty);
    expect(removed.manualToolProficiencyOverrides?.removedKeys, isEmpty);
  });

  test('custom labels are trimmed and deduplicated case-insensitively', () {
    final character = CharacterProficiencyEditorOperations.addCustomLanguage(
      CharacterData(),
      '  River speech  ',
    );
    final duplicate = CharacterProficiencyEditorOperations.addCustomLanguage(
      character,
      'river SPEECH',
    );

    expect(duplicate.manualLanguageOverrides?.custom, ['River speech']);
  });

  test('weapon categories and specific keys stay in separate fields', () {
    final category = CharacterProficiencyEditorOperations.addWeaponCategory(
      CharacterData(),
      WeaponCategory.simpleMelee,
    );
    final weapon = CharacterProficiencyEditorOperations.addWeaponKey(
      category,
      'longsword',
    );

    expect(
      weapon.manualWeaponProficiencyOverrides?.addedCategories,
      [WeaponCategory.simpleMelee],
    );
    expect(
      weapon.manualWeaponProficiencyOverrides?.addedKeys,
      ['longsword'],
    );
  });

  test('reset clears only the selected section overrides', () {
    final reset = CharacterProficiencyEditorOperations.resetLanguages(
      CharacterData(
        manualLanguageOverrides: CharacterLanguageOverridesData(
          added: const [Language.elvish],
          custom: const ['Homebrew'],
        ),
        manualToolProficiencyOverrides: CharacterToolProficiencyOverridesData(
          custom: const ['Custom tool'],
        ),
      ),
    );

    expect(reset.manualLanguageOverrides, isNull);
    expect(
      reset.manualToolProficiencyOverrides?.custom,
      ['Custom tool'],
    );
  });
}
