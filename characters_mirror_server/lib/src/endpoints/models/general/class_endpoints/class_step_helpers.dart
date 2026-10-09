part of '../class_endpoints.dart';

const _standardSpellSlotTableKey = 'standard';
const _pactMagicSpellSlotTableKey = 'pact_magic';

List<SkillSelectionGroupView> _buildClassSkillSelectionGroups(
  ClassData classData,
) {
  final classId = classData.id;
  final skillCount = classData.skillCount ?? 0;
  final options = _uniqueSkills(classData.availableSkills);
  if (classId == null || skillCount <= 0 || options.isEmpty) {
    return const <SkillSelectionGroupView>[];
  }

  return [
    SkillSelectionGroupView(
      kind: CharacterSkillSelectionKind.classSkill,
      selectionCount: skillCount,
      classDataId: classId,
      options: options,
    ),
  ];
}

List<Skill> _uniqueSkills(List<Skill>? skills) {
  final result = <Skill>[];
  final seen = <Skill>{};
  for (final skill in skills ?? const <Skill>[]) {
    if (seen.add(skill)) {
      result.add(skill);
    }
  }
  return result;
}

ClassLevelData? _classLevelForSelection(
  List<ClassLevelData> progression,
  int selectedLevel,
) {
  ClassLevelData? best;
  for (final row in progression) {
    if (row.level == selectedLevel) {
      return row;
    }
    if (row.level <= selectedLevel &&
        (best == null || row.level > best.level)) {
      best = row;
    }
  }
  return best;
}

Future<List<ClassSpellSelectionGroupView>> _buildSpellSelectionGroups(
  Session session, {
  required int classId,
  required int? selectedSubclassId,
  required ClassData classData,
  required int selectedLevel,
  required ClassLevelData classLevel,
  required Map<String, int>? abilityScores,
}) async {
  final listKey = classData.spellSelectionFilter?.spellListClassKey;
  final listClass = listKey == null
      ? null
      : (await ClassData.db.find(session,
              where: (t) => t.referenceKey.equals(listKey), limit: 1))
          .firstOrNull;
  if (listKey != null && listClass == null) {
    throw InputValidationException(
        'spellSelectionFilter', 'Unknown spell list.');
  }
  final spells = [
    for (final spell in await SpellData.db.find(session))
      if (_isSpellAvailableForClassStep(
        spell,
        classId: listClass?.id ?? classId,
        selectedSubclassId: listClass == null ? selectedSubclassId : null,
      ))
        spell,
  ]..sort(_compareSpells);

  final slots = await _spellSlotsForClassStep(
      session, classData.spellcastingProgression, selectedLevel);
  return buildClassSpellSelectionGroups(
      classData: classData,
      classLevel: classLevel,
      selectedLevel: selectedLevel,
      maxSpellLevel: _maxKnownSpellLevel(slots),
      spells: spells,
      abilityScores: abilityScores ?? const {});
}

bool _isSpellAvailableForClassStep(
  SpellData spell, {
  required int classId,
  required int? selectedSubclassId,
}) {
  if (spell.availableForClassIds?.contains(classId) == true) {
    return true;
  }
  if (selectedSubclassId != null &&
      spell.availableForSubclassIds?.contains(selectedSubclassId) == true) {
    return true;
  }
  return false;
}

Future<Map<int, int>?> _spellSlotsForClassStep(
  Session session,
  SpellcastingProgression? progression,
  int classLevel,
) async {
  if (classLevel <= 0 || progression == null) {
    return null;
  }

  final tableKey = progression == SpellcastingProgression.pactMagic
      ? _pactMagicSpellSlotTableKey
      : _standardSpellSlotTableKey;
  final progressionLevel = _classStepProgressionLevel(
    progression,
    classLevel,
  );
  if (progressionLevel <= 0) {
    return null;
  }

  return _spellSlotsForProgressionLevel(
    session,
    tableKey,
    progressionLevel,
  );
}

int _classStepProgressionLevel(
  SpellcastingProgression progression,
  int classLevel,
) {
  switch (progression) {
    case SpellcastingProgression.full:
    case SpellcastingProgression.pactMagic:
      return classLevel;
    case SpellcastingProgression.half:
      return (classLevel + 1) ~/ 2;
    case SpellcastingProgression.third:
      return (classLevel + 2) ~/ 3;
    case SpellcastingProgression.none:
      return 0;
  }
}

Future<Map<int, int>?> _spellSlotsForProgressionLevel(
  Session session,
  String tableKey,
  int level,
) async {
  if (level <= 0) {
    return null;
  }
  final rows = await SpellSlotProgressionData.db.find(
    session,
    where: (t) => t.tableKey.equals(tableKey) & t.level.equals(level),
    limit: 1,
  );
  if (rows.isEmpty) {
    return null;
  }
  return _nonZeroSpellSlots(rows.first.spellSlots);
}

Map<int, int>? _nonZeroSpellSlots(Map<int, int>? slots) {
  final result = <int, int>{};
  for (final entry in slots?.entries ?? const Iterable.empty()) {
    if (entry.key > 0 && entry.value > 0) {
      result[entry.key] = entry.value;
    }
  }
  return result.isEmpty ? null : result;
}

int _maxKnownSpellLevel(Map<int, int>? spellSlots) {
  var maxLevel = 0;
  for (final entry in spellSlots?.entries ?? const Iterable.empty()) {
    if (entry.value > 0 && entry.key > maxLevel) {
      maxLevel = entry.key;
    }
  }
  return maxLevel;
}

int _compareSpells(SpellData left, SpellData right) {
  final levelCompare = (left.level ?? 0).compareTo(right.level ?? 0);
  if (levelCompare != 0) {
    return levelCompare;
  }
  return (left.name ?? '').compareTo(right.name ?? '');
}
