import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/spells/class_spell_progression.dart';
import 'package:test/test.dart';

void main() {
  test('Bard 1 to 2 adds one known spell and one replacement', () {
    final delta = buildClassSpellLevelDelta(
      ClassData(id: 1, spellSelectionMode: ClassSpellSelectionMode.known),
      ClassLevelData(classDataId: 1, level: 1, knownCantrips: 2, knownSpells: 4),
      ClassLevelData(classDataId: 1, level: 2, knownCantrips: 2, knownSpells: 5,
          knownSpellReplacements: 1),
    );
    expect(delta.cantripsToAdd, 0);
    expect(delta.knownSpellsToAdd, 1);
    expect(delta.knownSpellReplacements, 1);
    expect(delta.spellbookSpellsToAdd, 0);
  });

  test('Wizard free gains use progression totals and preparation increases', () {
    final wizard = ClassData(id: 2,
      spellSelectionMode: ClassSpellSelectionMode.spellbook,
      preparedSpellRule: PreparedSpellRuleData(ability: Ability.intelligence));
    final first = ClassLevelData(classDataId: 2, level: 1,
        knownCantrips: 3, spellbookSpells: 6, knownSpells: 99);
    final second = ClassLevelData(classDataId: 2, level: 2,
        knownCantrips: 3, spellbookSpells: 8, knownSpells: 100);
    final delta = buildClassSpellLevelDelta(wizard, first, second,
        abilityScores: {'intelligence': 16});
    expect(delta.spellbookSpellsToAdd, 2);
    expect(delta.knownSpellsToAdd, 0);
    expect(delta.cantripsToAdd, 0);
    expect(delta.preparedSpellLimitBefore, 4);
    expect(delta.preparedSpellLimitAfter, 5);
    final groups = buildClassSpellSelectionGroups(
      classData: wizard, classLevel: first, maxSpellLevel: 1,
      abilityScores: {'intelligence': 16},
      spells: [SpellData(referenceKey: 'shield', level: 1)],
    );
    expect(groups.map((g) => g.kind), [
      CharacterSpellSelectionKind.spellbookSpell,
      CharacterSpellSelectionKind.preparedSpell,
    ]);
    expect(groups.first.selectionCount, 6);
    expect(groups.last.optionSourceSelectionKind,
        CharacterSpellSelectionKind.spellbookSpell);
  });

  test('Paladin preparation floors half class level and honors minimum', () {
    final paladin = ClassData(preparedSpellRule: PreparedSpellRuleData(
      ability: Ability.charisma, classLevelDenominator: 2));
    for (final level in [2, 3]) {
      expect(preparedSpellLimit(paladin,
          ClassLevelData(classDataId: 1, level: level),
          abilityScores: {'charisma': 16}), 4);
    }
    expect(preparedSpellLimit(paladin,
        ClassLevelData(classDataId: 1, level: 2),
        abilityScores: {'charisma': 3}), 1);
  });

  test('legacy formula fallback remains supported and fails closed', () {
    expect(preparedSpellLimit(ClassData(), ClassLevelData(classDataId: 1,
        level: 2, preparedSpellFormula: 'wisdom modifier + cleric level'),
        abilityScores: {'wisdom': 16}), 5);
    expect(preparedSpellLimit(ClassData(), ClassLevelData(classDataId: 1,
        level: 3, preparedSpellFormula: 'charisma modifier + half paladin level'),
        abilityScores: {'charisma': 16}), 4);
    expect(preparedSpellLimit(ClassData(), ClassLevelData(classDataId: 1,
        level: 2, preparedSpellFormula: 'unknown level formula'),
        abilityScores: {'wisdom': 16}), isNull);
  });
}
