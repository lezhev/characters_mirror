/// Retained selections are inactive while their class source cannot select spells.
/// Resolve against current entries rather than an embedded, older snapshot.
bool isSpellSelectionActive(Map<String, dynamic> selection,
    Iterable<Map<String, dynamic>> classEntries) {
  final embedded = (selection['classEntry'] as Map?) ?? const {};
  final entryId = embedded['id'];
  final classId =
      selection['classDataId'] ?? (embedded['classData'] as Map?)?['id'];
  final entries = classEntries.toList();
  if (entries.isEmpty && classId != null) return false;
  final entry = (entryId == null
          ? null
          : entries.where((e) => e['id'] == entryId).firstOrNull) ??
      (classId == null
          ? null
          : entries
              .where((e) =>
                  ((e['classData'] as Map?)?['id'] ?? e['classDataId']) ==
                  classId)
              .firstOrNull) ??
      (entries.isEmpty ? embedded : null);
  final level = entry?['level'] as int?;
  if (entry == null) return entryId == null && classId == null;
  final data = (entry['classData'] as Map?) ?? const {};
  final subclass = (entry['subclass'] as Map?) ?? const {};
  final activeSubclass = subclass.isNotEmpty &&
      subclass['parentClassId'] == data['id'] &&
      (level ?? 0) >= (subclass['levelRequired'] as int? ?? 1) &&
      (level ?? 0) >=
          (subclass['spellcastingStartLevel'] as int? ??
              subclass['levelRequired'] as int? ??
              1);
  final mode = (activeSubclass ? subclass['spellSelectionMode'] : null) ??
      data['spellSelectionMode'];
  return mode != 'none';
}
