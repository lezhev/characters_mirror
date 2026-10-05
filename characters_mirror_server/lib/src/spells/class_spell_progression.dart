import 'dart:math' as math;
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import '../generated/protocol.dart';

ClassSpellSelectionMode classSpellSelectionMode(
    ClassData data, ClassLevelData? row) {
  return ClassSpellSelectionMode.values.byName(resolveSpellSelectionMode(
      explicitMode: data.spellSelectionMode?.name,
      legacyFormula: row?.preparedSpellFormula,
      spellcastingAbility: data.spellcastingAbilityValue?.name,
      hasPreparedRule: row?.preparedSpellRule != null,
      knownSpells: row?.knownSpells,
      knownCantrips: row?.knownCantrips,
      spellbookSpells: row?.spellbookSpells));
}

int? preparedSpellLimit(ClassLevelData row,
    {required Map<String, int> abilityScores}) {
  final data = row.preparedSpellRule;
  final rule = data == null
      ? legacyPreparedSpellRule(row.preparedSpellFormula)
      : PreparedSpellRule(
          ability: data.ability.name,
          numerator: data.classLevelNumerator,
          denominator: data.classLevelDenominator,
          rounding: data.rounding.name,
          flatBonus: data.flatBonus,
          minimum: data.minimum);
  return rule?.evaluate(row.level, abilityScores);
}

int classSpellbookTotal(ClassData data, ClassLevelData row) =>
    spellbookProgressionTotal(
        level: row.level,
        total: row.spellbookSpells,
        explicitMode: data.spellSelectionMode?.name,
        legacyFormula: row.preparedSpellFormula);

ClassSpellDeltaView buildClassSpellDelta(
    ClassData data, ClassLevelData before, ClassLevelData after,
    {required Map<String, int> abilityScores}) {
  if (before.classDataId != after.classDataId ||
      (data.id != null && data.id != after.classDataId) ||
      before.level < 0 ||
      after.level <= before.level ||
      after.level > 20) {
    throw ArgumentError(
        'Expected increasing levels of the same class, up to 20.');
  }
  final mode = classSpellSelectionMode(data, after);
  int gain(int? oldTotal, int? newTotal) =>
      math.max(0, (newTotal ?? 0) - (oldTotal ?? 0));
  final prepares = mode == ClassSpellSelectionMode.prepared ||
      mode == ClassSpellSelectionMode.spellbook;
  return ClassSpellDeltaView(
      cantripsToAdd: mode == ClassSpellSelectionMode.none
          ? 0
          : gain(before.knownCantrips, after.knownCantrips),
      knownSpellsToAdd: mode == ClassSpellSelectionMode.known
          ? gain(before.knownSpells, after.knownSpells)
          : 0,
      knownSpellReplacements: mode == ClassSpellSelectionMode.known
          ? math.max(0, after.knownSpellReplacements ?? 0)
          : 0,
      spellbookSpellsToAdd: mode == ClassSpellSelectionMode.spellbook
          ? gain(classSpellbookTotal(data, before),
              classSpellbookTotal(data, after))
          : 0,
      preparedSpellLimitBefore: prepares
          ? preparedSpellLimit(before, abilityScores: abilityScores)
          : null,
      preparedSpellLimitAfter: prepares
          ? preparedSpellLimit(after, abilityScores: abilityScores)
          : null);
}

List<ClassSpellSelectionGroupView> buildClassSpellSelectionGroups({
  required ClassData classData,
  required ClassLevelData classLevel,
  required int selectedLevel,
  required int maxSpellLevel,
  required List<SpellData> spells,
  required Map<String, int> abilityScores,
}) {
  final mode = classSpellSelectionMode(classData, classLevel);
  if (mode == ClassSpellSelectionMode.none) return [];
  final groups = <ClassSpellSelectionGroupView>[];
  void add(
      CharacterSpellSelectionKind kind, int? count, List<SpellData> options,
      {CharacterSpellSelectionKind? source}) {
    if (count == null || count <= 0 || options.isEmpty) return;
    groups.add(ClassSpellSelectionGroupView(
        kind: kind,
        selectionCount: count,
        classDataId: classData.id,
        classLevel: selectedLevel,
        options: options,
        optionSourceSelectionKind: source));
  }

  add(CharacterSpellSelectionKind.knownCantrip, classLevel.knownCantrips,
      spells.where((spell) => spell.level == 0).toList());
  final leveled = spells
      .where((spell) => (spell.level ?? 0) > 0 && spell.level! <= maxSpellLevel)
      .toList();
  if (mode == ClassSpellSelectionMode.known) {
    add(CharacterSpellSelectionKind.knownSpell, classLevel.knownSpells,
        leveled);
  }
  if (mode == ClassSpellSelectionMode.spellbook) {
    add(CharacterSpellSelectionKind.spellbookSpell,
        classSpellbookTotal(classData, classLevel), leveled);
  }
  if (mode == ClassSpellSelectionMode.prepared ||
      mode == ClassSpellSelectionMode.spellbook) {
    add(
        CharacterSpellSelectionKind.preparedSpell,
        preparedSpellLimit(classLevel.copyWith(level: selectedLevel),
            abilityScores: abilityScores),
        leveled,
        source: mode == ClassSpellSelectionMode.spellbook
            ? CharacterSpellSelectionKind.spellbookSpell
            : null);
  }
  return groups;
}
