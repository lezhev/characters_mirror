import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/spells/class_spell_progression.dart';
import 'package:test/test.dart';

void main() {
  test('structured Paladin rule uses floor and minimum', () {
    final rule = PreparedSpellRuleData(
        ability: Ability.charisma,
        classLevelDenominator: 2,
        rounding: PreparedSpellRounding.floor);
    for (final level in [2, 3]) {
      final row =
          ClassLevelData(classDataId: 1, level: level, preparedSpellRule: rule);
      expect(preparedSpellLimit(row, abilityScores: {'charisma': 16}), 4);
      expect(preparedSpellLimit(row, abilityScores: {'charisma': 1}), 1);
    }
  });
  test('Wizard creation uses spellbook kind and dependent prepared options',
      () {
    final groups = buildClassSpellSelectionGroups(
        classData: ClassData(
            id: 1, spellSelectionMode: ClassSpellSelectionMode.spellbook),
        classLevel: ClassLevelData(
            classDataId: 1,
            level: 1,
            knownSpells: 99,
            spellbookSpells: 6,
            preparedSpellRule: PreparedSpellRuleData(
                ability: Ability.intelligence,
                rounding: PreparedSpellRounding.floor)),
        selectedLevel: 1,
        maxSpellLevel: 1,
        abilityScores: {'intelligence': 16},
        spells: [SpellData(referenceKey: 'shield', level: 1)]);
    expect(groups.map((g) => g.kind), [
      CharacterSpellSelectionKind.spellbookSpell,
      CharacterSpellSelectionKind.preparedSpell
    ]);
    expect(groups.first.selectionCount, 6);
    expect(groups.last.selectionCount, 4);
    expect(groups.last.optionSourceSelectionKind,
        CharacterSpellSelectionKind.spellbookSpell);
  });
  test('legacy Wizard creation does not reuse knownSpells as book size', () {
    final groups = buildClassSpellSelectionGroups(
        classData:
            ClassData(id: 1, spellcastingAbilityValue: Ability.intelligence),
        classLevel: ClassLevelData(
            classDataId: 1,
            level: 1,
            knownSpells: 99,
            preparedSpellFormula: 'intelligence modifier + wizard level'),
        selectedLevel: 1,
        maxSpellLevel: 1,
        abilityScores: {'intelligence': 16},
        spells: [SpellData(referenceKey: 'shield', level: 1)]);
    expect(groups.first.kind, CharacterSpellSelectionKind.spellbookSpell);
    expect(groups.first.selectionCount, 6);
  });
  test('prepared class options come from supplied full class list', () {
    final groups = buildClassSpellSelectionGroups(
        classData: ClassData(
            id: 1, spellSelectionMode: ClassSpellSelectionMode.prepared),
        classLevel: ClassLevelData(
            classDataId: 1,
            level: 2,
            preparedSpellRule: PreparedSpellRuleData(
                ability: Ability.charisma,
                classLevelDenominator: 2,
                rounding: PreparedSpellRounding.floor)),
        selectedLevel: 2,
        maxSpellLevel: 1,
        abilityScores: {
          'charisma': 16
        },
        spells: [
          SpellData(referenceKey: 'bless', level: 1),
          SpellData(referenceKey: 'aid', level: 2)
        ]);
    expect(groups.single.selectionCount, 4);
    expect(groups.single.options!.single.referenceKey, 'bless');
    expect(groups.single.optionSourceSelectionKind, isNull);
  });
  test('structured preparation overrides legacy formula', () {
    final row = ClassLevelData(
        classDataId: 1,
        level: 3,
        preparedSpellFormula: 'charisma modifier + paladin level',
        preparedSpellRule: PreparedSpellRuleData(
            ability: Ability.wisdom,
            classLevelNumerator: 1,
            classLevelDenominator: 1,
            rounding: PreparedSpellRounding.floor,
            flatBonus: 0,
            minimum: 1));
    expect(preparedSpellLimit(row, abilityScores: {'wisdom': 16}), 6);
    expect(preparedSpellLimit(row, abilityScores: {'wisdom': 1}), 1);
  });
  test('Paladin legacy half-level rounds down', () {
    for (final level in [2, 3]) {
      expect(
          preparedSpellLimit(
              ClassLevelData(
                  classDataId: 1,
                  level: level,
                  preparedSpellFormula: 'charisma modifier + paladin level'),
              abilityScores: {'charisma': 16}),
          4);
    }
  });
  test('legacy formula and missing abilities are safe', () {
    final row = ClassLevelData(
        classDataId: 1,
        level: 2,
        preparedSpellFormula: 'wisdom modifier + cleric level');
    expect(preparedSpellLimit(row, abilityScores: {'wisdom': 14}), 4);
    expect(preparedSpellLimit(row, abilityScores: {}), isNull);
    expect(
        preparedSpellLimit(
            ClassLevelData(
                classDataId: 1,
                level: 2,
                preparedSpellFormula: 'unknown expression'),
            abilityScores: {}),
        isNull);
  });
  test('Bard 1 to 2 uses totals and target replacements', () {
    final delta = buildClassSpellDelta(
        ClassData(spellSelectionMode: ClassSpellSelectionMode.known),
        ClassLevelData(
            classDataId: 1, level: 1, knownCantrips: 2, knownSpells: 4),
        ClassLevelData(
            classDataId: 1,
            level: 2,
            knownCantrips: 2,
            knownSpells: 5,
            knownSpellReplacements: 1),
        abilityScores: {'charisma': 16});
    expect(delta.cantripsToAdd, 0);
    expect(delta.knownSpellsToAdd, 1);
    expect(delta.knownSpellReplacements, 1);
    expect(delta.spellbookSpellsToAdd, 0);
  });
  test('Wizard 1 to 2 gains from progression, not actual book size', () {
    final rule = PreparedSpellRuleData(
        ability: Ability.intelligence,
        classLevelNumerator: 1,
        classLevelDenominator: 1,
        rounding: PreparedSpellRounding.floor,
        flatBonus: 0,
        minimum: 1);
    final delta = buildClassSpellDelta(
        ClassData(spellSelectionMode: ClassSpellSelectionMode.spellbook),
        ClassLevelData(
            classDataId: 1,
            level: 1,
            knownCantrips: 3,
            spellbookSpells: 6,
            preparedSpellRule: rule),
        ClassLevelData(
            classDataId: 1,
            level: 2,
            knownCantrips: 3,
            spellbookSpells: 8,
            preparedSpellRule: rule),
        abilityScores: {'intelligence': 16});
    expect(delta.cantripsToAdd, 0);
    expect(delta.knownSpellsToAdd, 0);
    expect(delta.spellbookSpellsToAdd, 2);
    expect(delta.preparedSpellLimitBefore, 4);
    expect(delta.preparedSpellLimitAfter, 5);
  });
}
