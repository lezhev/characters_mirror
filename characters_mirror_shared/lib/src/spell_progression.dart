import 'dart:math' as math;
import 'dart:convert';

/// A deliberately limited preparation rule, shared by server and client.
class PreparedSpellRule {
  const PreparedSpellRule(
      {required this.ability,
      this.numerator = 1,
      this.denominator = 1,
      this.rounding = 'floor',
      this.flatBonus = 0,
      this.minimum = 1});

  final String ability;
  final int numerator;
  final int denominator;
  final String rounding;
  final int flatBonus;
  final int minimum;

  int? evaluate(int classLevel, Map<String, int> abilityScores) {
    final score = abilityScores[ability];
    if (score == null || denominator <= 0 || numerator < 0 || classLevel < 0) {
      return null;
    }
    final fraction = classLevel * numerator / denominator;
    final levelBonus = switch (rounding) {
      'floor' => fraction.floor(),
      'ceil' => fraction.ceil(),
      'nearest' => fraction.round(),
      _ => null,
    };
    if (levelBonus == null) return null;
    return math.max(
        minimum, ((score - 10) / 2).floor() + levelBonus + flatBonus);
  }
}

/// Transition support for the existing catalog formulas, not an expression engine.
PreparedSpellRule? legacyPreparedSpellRule(String? formula) {
  final text = formula?.trim().toLowerCase();
  if (text == null) return null;
  final match = RegExp(
          r'^(strength|dexterity|constitution|intelligence|wisdom|charisma) modifier \+ (cleric|druid|wizard|paladin) level$')
      .firstMatch(text);
  if (match != null) {
    return PreparedSpellRule(
        ability: match[1]!, denominator: match[2] == 'paladin' ? 2 : 1);
  }
  final half = RegExp(r'^charisma modifier \+ floor\(paladin level / 2\)$')
      .hasMatch(text);
  return half
      ? const PreparedSpellRule(ability: 'charisma', denominator: 2)
      : null;
}

String resolveSpellSelectionMode(
    {String? explicitMode,
    String? legacyFormula,
    String? spellcastingAbility,
    bool hasPreparedRule = false,
    int? knownSpells,
    int? knownCantrips,
    int? spellbookSpells}) {
  if (explicitMode != null) return explicitMode;
  if ((spellbookSpells ?? 0) > 0) return 'spellbook';
  final legacy = legacyPreparedSpellRule(legacyFormula);
  if (legacy != null || hasPreparedRule) {
    return (legacy?.ability ?? spellcastingAbility) == 'intelligence'
        ? 'spellbook'
        : 'prepared';
  }
  if ((knownSpells ?? 0) > 0 || (knownCantrips ?? 0) > 0) return 'known';
  return spellcastingAbility != null ? 'known' : 'none';
}

/// Legacy Wizard totals come from class progression, never from book contents.
int spellbookProgressionTotal(
    {required int level,
    int? total,
    String? explicitMode,
    String? legacyFormula}) {
  if (total != null) return math.max(0, total);
  if (explicitMode == null &&
      legacyPreparedSpellRule(legacyFormula)?.ability == 'intelligence') {
    return level <= 0 ? 0 : 6 + 2 * (level - 1);
  }
  return 0;
}

/// Entry identity takes precedence over catalog class identity.
String spellSelectionIdentity(
    {String? classEntryId,
    int? classDataId,
    String? kind,
    required String spellKey}) {
  final source =
      classEntryId != null ? 'entry:$classEntryId' : 'class:$classDataId';
  return jsonEncode([source, kind, spellKey.trim()]);
}
