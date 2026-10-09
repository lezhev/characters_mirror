import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';

Map<String, dynamic> filter(List<String> schools, int level) => {
      'schools': schools,
      'minimumSpellLevel': 1,
      'maximumSpellLevel': level,
      'unrestrictedChoicesByLevel': {3: 1, 8: 2, 14: 3, 20: 4},
    };

Map<String, dynamic> spell(int id, String school, {int level = 1}) => {
      'id': id,
      'referenceKey': 'spell_$id',
      'level': level,
      'schoolValue': school,
    };

void main() {
  for (final (name, schools) in [
    ('Eldritch Knight', ['abjuration', 'evocation']),
    ('Arcane Trickster', ['enchantment', 'illusion']),
  ]) {
    test('$name restricted slot cannot be replaced outside its schools', () {
      final policy = filter(schools, 3);
      expect(
          spellSelectionsMatchFilter([
            {...spell(1, schools.first), 'selectionUnrestricted': false},
            {...spell(2, 'necromancy'), 'selectionUnrestricted': false},
          ], policy, kind: 'knownSpell', level: 3),
          isFalse);
    });

    for (final level in [8, 14, 20]) {
      test('$name unrestricted origin survives replacement at level $level', () {
        final policy = filter(schools, level);
        final replacementSchool = level == 8 ? 'necromancy' : schools.first;
        expect(
            spellSelectionsMatchFilter([
              {...spell(1, replacementSchool), 'selectionUnrestricted': true},
              for (var i = 0; i < level ~/ 8; i++)
                {...spell(i + 2, schools.first), 'selectionUnrestricted': false},
            ], policy, kind: 'knownSpell', level: level),
            isTrue);
      });
    }
  }

  test('a higher cumulative quota never promotes a restricted slot', () {
    final policy = filter(['abjuration', 'evocation'], 20);
    expect(
        spellSelectionsMatchFilter([
          {...spell(1, 'necromancy'), 'selectionUnrestricted': true},
          {...spell(2, 'necromancy'), 'selectionUnrestricted': true},
          {...spell(3, 'necromancy'), 'selectionUnrestricted': true},
          {...spell(4, 'necromancy'), 'selectionUnrestricted': false},
        ], policy, kind: 'knownSpell', level: 20),
        isFalse);
  });

  test('unrestricted slots still obey the shared spell-level bounds', () {
    expect(
        spellSelectionsMatchFilter([
          {...spell(1, 'necromancy', level: 4), 'selectionUnrestricted': true},
        ], filter(['abjuration', 'evocation'], 3),
            kind: 'knownSpell', level: 20),
        isFalse);
  });

  test('legacy provenance is conservatively inferred from school eligibility', () {
    final policy = filter(['abjuration', 'evocation'], 3);
    expect(spellSelectionsMatchFilter([spell(1, 'necromancy')], policy,
        kind: 'knownSpell', level: 3), isTrue);
    expect(spellSelectionsMatchFilter([spell(2, 'abjuration')], policy,
        kind: 'knownSpell', level: 3), isTrue);
  });

  test('multiclass selection groups keep their quotas independent', () {
    final ek = filter(['abjuration', 'evocation'], 3);
    final at = filter(['enchantment', 'illusion'], 3);
    expect(spellSelectionsMatchFilter([
      {...spell(1, 'necromancy'), 'selectionUnrestricted': true},
    ], ek, kind: 'knownSpell', level: 3), isTrue);
    expect(spellSelectionsMatchFilter([
      {...spell(2, 'necromancy'), 'selectionUnrestricted': false},
    ], at, kind: 'knownSpell', level: 3), isFalse);
  });

  test('replacement retains its origin and level-down restores both', () {
    final policy = filter(['abjuration', 'evocation'], 20);
    final original = {
      'id': 'entry-spell',
      'classEntry': {'id': 'ek-entry'},
      'classDataId': 7,
      'kind': 'knownSpell',
      'selectionIndex': 2,
      'spellId': 11,
      'spellKey': 'spell_11',
      'spell': spell(11, 'necromancy'),
      'selectionFilter': filter(['abjuration', 'evocation'], 3),
      'selectionRuleLevel': 3,
      'selectionUnrestricted': true,
    };
    final atEight = replaceSpellSelection(
      selection: original,
      replacementSpell: spell(12, 'abjuration'),
      currentFilter: policy,
      kind: 'knownSpell',
      currentLevel: 8,
    )!;
    expect(atEight['id'], original['id']);
    expect(atEight['selectionUnrestricted'], isTrue);
    expect(atEight['selectionRuleLevel'], 3);
    expect(atEight['spellReplacementHistory'], hasLength(1));
    final atFourteen = replaceSpellSelection(
      selection: atEight,
      replacementSpell: spell(13, 'illusion'),
      currentFilter: policy,
      kind: 'knownSpell',
      currentLevel: 14,
    )!;
    expect(atFourteen['selectionUnrestricted'], isTrue);
    final restoredAtEight = rollbackSpellSelectionReplacements([atFourteen],
        classEntryId: 'ek-entry', targetLevel: 8).single;
    expect(restoredAtEight['spellId'], 12);
    expect(restoredAtEight['selectionUnrestricted'], isTrue);
    expect(restoredAtEight['spellReplacementHistory'], hasLength(1));
    final restoredAtThree = rollbackSpellSelectionReplacements(
        [restoredAtEight], classEntryId: 'ek-entry', targetLevel: 3).single;
    expect(restoredAtThree['spellId'], 11);
    expect(restoredAtThree['selectionFilter'], original['selectionFilter']);
    expect(restoredAtThree['selectionRuleLevel'], 3);
    expect(restoredAtThree['selectionUnrestricted'], isTrue);
    expect(restoredAtThree['spellReplacementHistory'], isNull);
  });

  test('ambiguous legacy slots stay restricted across repeated replacement', () {
    final original = {
      'id': 'legacy',
      'classEntry': {'id': 'at-entry'},
      'spellId': 20,
      'spellKey': 'spell_20',
      'spell': spell(20, 'enchantment'),
      'selectionUnrestricted': null,
    };
    final rule = filter(['enchantment', 'illusion'], 8);
    final first = replaceSpellSelection(
      selection: original,
      replacementSpell: spell(21, 'illusion'),
      currentFilter: rule,
      kind: 'knownSpell',
      currentLevel: 8,
    )!;
    expect(first['selectionUnrestricted'], isNull);
    expect(replaceSpellSelection(
        selection: first,
        replacementSpell: spell(22, 'necromancy'),
        currentFilter: rule,
        kind: 'knownSpell',
        currentLevel: 14), isNull);
  });
}
