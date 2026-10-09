import 'package:characters_mirror_client/characters_mirror_client.dart';

bool hasActiveSubclassSpellcasting(
        ClassData data, SubclassData? subclass, int level) =>
    subclass != null &&
    subclass.parentClassId == data.id &&
    level >= (subclass.levelRequired ?? 1) &&
    level >= (subclass.spellcastingStartLevel ?? subclass.levelRequired ?? 1);

ClassData effectiveSpellcastingClass(
    ClassData data, SubclassData? subclass, int level) {
  if (!hasActiveSubclassSpellcasting(data, subclass, level)) return data;
  return data.copyWith(
    spellcastingProgression:
        subclass!.spellcastingProgression ?? data.spellcastingProgression,
    spellSelectionMode: subclass.spellSelectionMode ?? data.spellSelectionMode,
    spellSelectionFilter:
        subclass.spellSelectionFilter ?? data.spellSelectionFilter,
    spellcastingAbilityValue:
        subclass.spellcastingAbilityValue ?? data.spellcastingAbilityValue,
  );
}

/// Subclass rows override spell progression only, retaining the owning class ID.
/// A row is a complete spell progression snapshot, not a sparse field overlay.
List<ClassLevelData> effectiveSpellProgression(
    ClassData data, SubclassData? subclass, Iterable<ClassLevelData> rows) {
  final classRows = {
    for (final row in rows)
      if (row.classDataId == data.id && row.subclassDataId == null)
        row.level: row,
  };
  if (subclass != null) {
    for (final row in rows) {
      if (row.subclassDataId == subclass.id &&
          row.classDataId == data.id &&
          hasActiveSubclassSpellcasting(data, subclass, row.level)) {
        classRows[row.level] = row.copyWith(classDataId: data.id);
      }
    }
  }
  return classRows.values.toList()..sort((a, b) => a.level.compareTo(b.level));
}
