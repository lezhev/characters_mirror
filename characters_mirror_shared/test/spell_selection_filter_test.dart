import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';

void main() {
  final filter = {
    'spellListClassKey': 'wizard',
    'schools': ['abjuration', 'evocation'],
    'kinds': ['knownSpell'],
    'maximumSpellLevel': 4,
    'unrestrictedChoicesByLevel': {'3': 1, '8': 2}
  };
  test('school filter applies only to declared kinds', () {
    expect(
        spellMatchesSelectionFilter(
            {'level': 1, 'schoolValue': 'evocation'}, filter,
            kind: 'knownSpell'),
        true);
    expect(
        spellMatchesSelectionFilter(
            {'level': 1, 'schoolValue': 'illusion'}, filter,
            kind: 'knownSpell'),
        false);
    expect(
        spellMatchesSelectionFilter(
            {'level': 0, 'schoolValue': 'illusion'}, filter,
            kind: 'knownCantrip'),
        true);
  });
  test('unrestricted quota never bypasses list or maximum level', () {
    expect(spellSelectionUnrestrictedCount(filter, 7), 1);
    expect(spellSelectionUnrestrictedCount(filter, 8), 2);
    expect(
        spellMatchesSelectionFilter(
            {'level': 5, 'schoolValue': 'illusion'}, filter,
            kind: 'knownSpell', unrestricted: true),
        false);
    expect(
        spellMatchesSelectionFilter(
            {'level': 1, 'schoolValue': 'illusion'}, filter,
            kind: 'knownSpell', unrestricted: true),
        true);
  });
  test('quota validation counts off-school choices as a separate budget', () {
    final selected = [
      {'referenceKey': 'a', 'level': 1, 'schoolValue': 'illusion'},
      {'referenceKey': 'b', 'level': 1, 'schoolValue': 'enchantment'}
    ];
    expect(
        spellSelectionsMatchFilter(selected, filter,
            kind: 'knownSpell', level: 3),
        false);
    expect(
        spellSelectionsMatchFilter(selected, filter,
            kind: 'knownSpell', level: 8),
        true);
  });
}
