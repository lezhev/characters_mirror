import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

Future<List<StartingEquipmentBlockView>> startingEquipmentBlockViews(
  Session session, {
  int? sourceClassId,
  int? sourceBackgroundId,
}) async {
  final entries = await StartingEquipmentEntryData.db.find(
    session,
    where: (t) {
      final byClass = sourceClassId == null
          ? t.sourceClassId.equals(null)
          : t.sourceClassId.equals(sourceClassId);
      final byBackground = sourceBackgroundId == null
          ? t.sourceBackgroundId.equals(null)
          : t.sourceBackgroundId.equals(sourceBackgroundId);
      return byClass & byBackground;
    },
    orderBy: (t) => t.orderIndex,
  );
  return startingEquipmentBlockViewsFromEntries(entries);
}

List<StartingEquipmentBlockView> startingEquipmentBlockViewsFromEntries(
  List<StartingEquipmentEntryData> entries,
) {
  final entriesByParent = <int?, List<StartingEquipmentEntryData>>{};
  for (final entry in entries) {
    entriesByParent.putIfAbsent(entry.parentEntryId, () => []).add(entry);
  }
  for (final list in entriesByParent.values) {
    list.sort(_compareEntries);
  }

  return [
    for (final root in entriesByParent[null] ?? const <StartingEquipmentEntryData>[])
      if (_blockViewForRoot(root, entriesByParent) case final view?) view,
  ];
}

StartingEquipmentBlockView? _blockViewForRoot(
  StartingEquipmentEntryData root,
  Map<int?, List<StartingEquipmentEntryData>> entriesByParent,
) {
  switch (root.kind) {
    case StartingEquipmentEntryKind.fixedLine:
      final line = _lineDataForEntry(root);
      return StartingEquipmentBlockView(
        block: StartingEquipmentBlockData(
          entryId: root.id,
          orderIndex: root.orderIndex,
          kind: StartingEquipmentBlockKind.fixedGrant,
          fixedLines: [line],
        ),
        fixedLines: [line],
        options: const <StartingEquipmentOptionView>[],
      );
    case StartingEquipmentEntryKind.choiceGroup:
      final options = [
        for (final option in entriesByParent[root.id] ??
            const <StartingEquipmentEntryData>[])
          if (option.kind == StartingEquipmentEntryKind.choiceOption)
            _optionViewForEntry(option, entriesByParent),
      ];
      return StartingEquipmentBlockView(
        block: StartingEquipmentBlockData(
          entryId: root.id,
          orderIndex: root.orderIndex,
          kind: StartingEquipmentBlockKind.choice,
          selectionCount: root.selectionCount,
          options: [for (final option in options) if (option.option != null) option.option!],
        ),
        fixedLines: const <StartingEquipmentLineData>[],
        options: options,
      );
    case StartingEquipmentEntryKind.choiceOption:
    case StartingEquipmentEntryKind.optionLine:
    case null:
      return null;
  }
}

StartingEquipmentOptionView _optionViewForEntry(
  StartingEquipmentEntryData option,
  Map<int?, List<StartingEquipmentEntryData>> entriesByParent,
) {
  final lines = [
    for (final line in entriesByParent[option.id] ??
        const <StartingEquipmentEntryData>[])
      if (line.kind == StartingEquipmentEntryKind.optionLine)
        _lineDataForEntry(line),
  ];
  return StartingEquipmentOptionView(
    option: StartingEquipmentOptionData(
      entryId: option.id,
      parentEntryId: option.parentEntryId,
      orderIndex: option.orderIndex,
      lines: lines,
    ),
    lines: lines,
  );
}

StartingEquipmentLineData _lineDataForEntry(StartingEquipmentEntryData entry) {
  return StartingEquipmentLineData(
    entryId: entry.id,
    parentEntryId: entry.parentEntryId,
    orderIndex: entry.orderIndex,
    kind: entry.lineKind,
    quantity: entry.quantity,
    catalogType: entry.catalogType,
    referenceKey: entry.referenceKey,
    allowedWeaponCategories: entry.allowedWeaponCategories,
    allowedItemCategories: entry.allowedItemCategories,
  );
}

int _compareEntries(
  StartingEquipmentEntryData left,
  StartingEquipmentEntryData right,
) {
  final orderCompare = (left.orderIndex ?? 0).compareTo(right.orderIndex ?? 0);
  if (orderCompare != 0) return orderCompare;
  return (left.id ?? 0).compareTo(right.id ?? 0);
}
