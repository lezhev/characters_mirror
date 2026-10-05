from pathlib import Path
root = Path('D:/SUAI/characters_mirror')
def write(path, content):
    p=root/path
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(content, encoding='utf-8')
def replace(path, old, new):
    p=root/path
    data=p.read_bytes(); text=data.decode('utf-8'); nl='\r\n' if '\r\n' in text else '\n'
    text=text.replace('\r\n','\n')
    assert old in text, (path, old[:70])
    p.write_bytes(text.replace(old,new).replace('\n',nl).encode('utf-8'))
s='characters_mirror_server/lib/src/models/'
write(s+'enums/class_spell_selection_mode.spy.yaml', '''enum: ClassSpellSelectionMode
serialized: byName
values:
  - none
  - known
  - prepared
  - spellbook
''')
write(s+'enums/prepared_spell_rounding.spy.yaml', '''enum: PreparedSpellRounding
serialized: byName
values:
  - floor
''')
write(s+'data/general/class/prepared_spell_rule_data.spy.yaml', '''class: PreparedSpellRuleData
fields:
  ability: Ability
  classLevelNumerator: int, default=1
  classLevelDenominator: int, default=1
  rounding: PreparedSpellRounding, default=floor
  flatBonus: int, default=0
  minimum: int, default=1
''')
replace(s+'data/general/class/class_data.spy.yaml','  spellcastingAbilityValue: Ability?','  spellcastingAbilityValue: Ability?\n  spellSelectionMode: ClassSpellSelectionMode?\n  preparedSpellRule: PreparedSpellRuleData?')
replace(s+'data/general/class/class_level_data.spy.yaml','  knownCantrips: int?\n  knownSpells: int?', '''  # Totals at this class level, not gains on reaching it.
  knownCantrips: int?
  # Only for known-spell casters; never a spellbook size.
  knownSpells: int?
  # Total free progression entries; excludes copied/manual spells.
  spellbookSpells: int?
  # Replacements allowed when reaching this level.
  knownSpellReplacements: int?''')
replace(s+'enums/character_spell_selection_kind.spy.yaml','  - preparedSpell','  - preparedSpell\n  - spellbookSpell')
replace(s+'views/class_spell_selection_group_view.spy.yaml','  options: List<SpellData>?','  options: List<SpellData>?\n  optionSourceSelectionKind: CharacterSpellSelectionKind?')
write(s+'views/class_spell_level_delta_view.spy.yaml','''class: ClassSpellLevelDeltaView
fields:
  classDataId: int
  fromLevel: int
  toLevel: int
  cantripsToAdd: int
  knownSpellsToAdd: int
  knownSpellReplacements: int
  spellbookSpellsToAdd: int
  preparedSpellLimitBefore: int?
  preparedSpellLimitAfter: int?
''')
write('characters_mirror_shared/lib/src/prepared_spell_rules.dart', '''import 'dart:math' as math;

/// Small value rule shared by server and client protocol adapters.
class PreparedSpellRule {
  const PreparedSpellRule({
    required this.ability,
    this.classLevelNumerator = 1,
    this.classLevelDenominator = 1,
    this.rounding = 'floor',
    this.flatBonus = 0,
    this.minimum = 1,
  });

  final String ability;
  final int classLevelNumerator;
  final int classLevelDenominator;
  final String rounding;
  final int flatBonus;
  final int minimum;

  int? evaluate(int classLevel, Map<String, int>? abilityScores) {
    final score = abilityScores?[ability];
    if (score == null || classLevel < 1 || classLevelNumerator < 0 ||
        classLevelDenominator <= 0 || rounding != 'floor' || minimum < 0) {
      return null;
    }
    return math.max(minimum, ((score - 10) / 2).floor() +
        (classLevel * classLevelNumerator / classLevelDenominator).floor() +
        flatBonus);
  }
}

/// Transitional whitelist, not an expression engine. Unknown text fails closed.
PreparedSpellRule? legacyPreparedSpellRule(String? formula) {
  final text = formula?.trim().toLowerCase().replaceAll(RegExp(r'\\s+'), ' ');
  if (text == null) return null;
  final match = RegExp(
    r'^(strength|dexterity|constitution|intelligence|wisdom|charisma) modifier \\+ (.+?)(?: \\(minimum (?:of )?1\\))?$',
  ).firstMatch(text);
  if (match == null) return null;
  final term = match.group(2)!;
  final fullLevel = RegExp(r'^(?:(?:class|cleric|druid|wizard|paladin) )?level$');
  final halfLevel = RegExp(
    r'^(?:half (?:your )?(?:paladin |class )?level(?: \\(rounded down\\))?|floor\\((?:paladin |class )?level / 2\\)|(?:paladin |class )?level / 2(?: \\(rounded down\\))?)$',
  );
  if (!fullLevel.hasMatch(term) && !halfLevel.hasMatch(term)) return null;
  return PreparedSpellRule(ability: match.group(1)!,
      classLevelDenominator: halfLevel.hasMatch(term) ? 2 : 1);
}

int? evaluatePreparedSpellLimit({
  PreparedSpellRule? rule,
  String? legacyFormula,
  required int classLevel,
  Map<String, int>? abilityScores,
}) => (rule ?? legacyPreparedSpellRule(legacyFormula))
    ?.evaluate(classLevel, abilityScores);

/// Explicit metadata wins. Legacy inference never examines display names.
String resolveSpellSelectionMode({
  String? explicitMode,
  bool hasStructuredRule = false,
  String? legacyFormula,
  int? spellbookSpells,
  int? knownSpells,
  bool hasSpellcasting = false,
}) {
  if (explicitMode != null) return explicitMode;
  if (spellbookSpells != null) return 'spellbook';
  final legacyRule = legacyPreparedSpellRule(legacyFormula);
  if (legacyRule != null &&
      RegExp(r'\\bwizard level\\b').hasMatch(legacyFormula!.toLowerCase())) {
    return 'spellbook';
  }
  if (hasStructuredRule || legacyRule != null) return 'prepared';
  if ((knownSpells ?? 0) > 0 || hasSpellcasting) return 'known';
  return 'none';
}
''')
replace('characters_mirror_shared/lib/characters_mirror_shared.dart',"export 'src/feature_display_property_resolver.dart';", "export 'src/feature_display_property_resolver.dart';\nexport 'src/prepared_spell_rules.dart';")
