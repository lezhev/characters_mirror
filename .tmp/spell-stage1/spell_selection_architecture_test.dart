import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character/spell_selection_support.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dependent prepared pool only includes this class draft spellbook', () {
    final shield = SpellData(referenceKey: 'shield', level: 1);
    final sleep = SpellData(referenceKey: 'sleep', level: 1);
    final group = ClassSpellSelectionGroupView(classDataId: 1,
        kind: CharacterSpellSelectionKind.preparedSpell,
        optionSourceSelectionKind: CharacterSpellSelectionKind.spellbookSpell,
        options: [shield, sleep]);
    final selections = [
      CharacterSpellSelectionData(classDataId: 1, spell: shield,
          kind: CharacterSpellSelectionKind.spellbookSpell),
      CharacterSpellSelectionData(classDataId: 2, spell: sleep,
          kind: CharacterSpellSelectionKind.spellbookSpell),
      CharacterSpellSelectionData(classDataId: 1, spell: sleep,
          kind: CharacterSpellSelectionKind.knownSpell),
    ];
    expect(spellGroupOptions(group, selections).map((s) => s.referenceKey), ['shield']);
    expect(spellGroupOptions(group, []), isEmpty);
  });

  test('identity preserves class entry and selection kind', () {
    final first = CharacterSpellSelectionData(
      classEntry: CharacterClassEntryData(id: 'entry-1'), classDataId: 1,
      kind: CharacterSpellSelectionKind.spellbookSpell, spellKey: 'shield');
    expect(spellSelectionIdentity(first),
        isNot(spellSelectionIdentity(first.copyWith(
          kind: CharacterSpellSelectionKind.preparedSpell))));
    expect(spellSelectionIdentity(first),
        isNot(spellSelectionIdentity(first.copyWith(
          classEntry: CharacterClassEntryData(id: 'entry-2')))));
    expect(spellSelectionIdentity(first.copyWith(classEntry: null)),
        isNot(spellSelectionIdentity(first.copyWith(classEntry: null, classDataId: 2))));
  });

  test('preparation uses explicit mode and spellbook origin, not class name', () {
    final entry = CharacterClassEntryData(id: 'wizard', classData: ClassData(
      id: 1, name: 'Unrelated display name',
      spellSelectionMode: ClassSpellSelectionMode.spellbook));
    final shield = SpellData(referenceKey: 'shield', level: 1, availableForClassIds: [1]);
    final sleep = SpellData(referenceKey: 'sleep', level: 1, availableForClassIds: [1]);
    final character = CharacterData(classEntries: [entry], spellSelections: [
      CharacterSpellSelectionData(classEntry: entry, spell: shield,
          kind: CharacterSpellSelectionKind.spellbookSpell),
      CharacterSpellSelectionData(classEntry: entry, spell: sleep,
          kind: CharacterSpellSelectionKind.knownSpell),
      CharacterSpellSelectionData(classEntry: entry.copyWith(id: 'other'), spell: sleep,
          kind: CharacterSpellSelectionKind.spellbookSpell),
    ]);
    expect(preparationPoolForEntry(character, entry, [shield, sleep])
        .map((s) => s.referenceKey), ['shield']);
    final prepared = entry.copyWith(classData: entry.classData!.copyWith(
        name: 'Wizard', spellSelectionMode: ClassSpellSelectionMode.prepared));
    expect(preparationPoolForEntry(character, prepared, [shield, sleep]), hasLength(2));
  });
}
