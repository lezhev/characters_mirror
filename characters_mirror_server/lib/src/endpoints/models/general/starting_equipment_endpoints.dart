import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class StartingEquipmentBlockDataEndpoint extends Endpoint {
  Future<List<StartingEquipmentBlockData>> getAll(Session session) async {
    return StartingEquipmentBlockData.db.find(
      session,
      orderBy: (t) => t.orderIndex,
    );
  }

  Future<StartingEquipmentBlockData> add(
    Session session,
    StartingEquipmentBlockData item,
  ) async {
    _stampStartingEquipmentRow(item);
    return StartingEquipmentBlockData.db.insertRow(session, item);
  }

  Future<StartingEquipmentBlockData> upsert(
    Session session,
    StartingEquipmentBlockData item,
  ) async {
    final normalizedBlockKey = item.blockKey?.trim();
    final existing = await StartingEquipmentBlockData.db.find(
      session,
      where: item.id != null
          ? (t) => t.id.equals(item.id)
          : normalizedBlockKey != null && normalizedBlockKey.isNotEmpty
              ? (t) => t.blockKey.equals(normalizedBlockKey)
              : (t) => t.id.equals(item.id),
      limit: 1,
    );

    if (existing.isNotEmpty) {
      item.id = existing.first.id;
      item.version = (existing.first.version ?? 0) + 1;
      item.createdAt ??= existing.first.createdAt;
      item.updatedAt = DateTime.now();
      await StartingEquipmentBlockData.db.updateRow(session, item);
      return item;
    }

    _stampStartingEquipmentRow(item);
    return StartingEquipmentBlockData.db.insertRow(session, item);
  }

  Future<void> delete(Session session, int id) async {
    await StartingEquipmentBlockData.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
  }
}

class StartingEquipmentOptionDataEndpoint extends Endpoint {
  Future<List<StartingEquipmentOptionData>> getAll(Session session) async {
    return StartingEquipmentOptionData.db.find(
      session,
      orderBy: (t) => t.orderIndex,
    );
  }

  Future<StartingEquipmentOptionData> add(
    Session session,
    StartingEquipmentOptionData item,
  ) async {
    _stampStartingEquipmentRow(item);
    return StartingEquipmentOptionData.db.insertRow(session, item);
  }

  Future<StartingEquipmentOptionData> upsert(
    Session session,
    StartingEquipmentOptionData item,
  ) async {
    final normalizedOptionKey = item.optionKey?.trim();
    final existing = await StartingEquipmentOptionData.db.find(
      session,
      where: item.id != null
          ? (t) => t.id.equals(item.id)
          : normalizedOptionKey != null && normalizedOptionKey.isNotEmpty
              ? (t) => t.optionKey.equals(normalizedOptionKey)
              : (t) => t.id.equals(item.id),
      limit: 1,
    );

    if (existing.isNotEmpty) {
      item.id = existing.first.id;
      item.version = (existing.first.version ?? 0) + 1;
      item.createdAt ??= existing.first.createdAt;
      item.updatedAt = DateTime.now();
      await StartingEquipmentOptionData.db.updateRow(session, item);
      return item;
    }

    _stampStartingEquipmentRow(item);
    return StartingEquipmentOptionData.db.insertRow(session, item);
  }

  Future<void> delete(Session session, int id) async {
    await StartingEquipmentOptionData.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
  }
}

class StartingEquipmentLineDataEndpoint extends Endpoint {
  Future<List<StartingEquipmentLineData>> getAll(Session session) async {
    return StartingEquipmentLineData.db.find(
      session,
      orderBy: (t) => t.orderIndex,
    );
  }

  Future<StartingEquipmentLineData> add(
    Session session,
    StartingEquipmentLineData item,
  ) async {
    _stampStartingEquipmentRow(item);
    return StartingEquipmentLineData.db.insertRow(session, item);
  }

  Future<StartingEquipmentLineData> upsert(
    Session session,
    StartingEquipmentLineData item,
  ) async {
    final normalizedLineKey = item.lineKey?.trim();
    final existing = await StartingEquipmentLineData.db.find(
      session,
      where: item.id != null
          ? (t) => t.id.equals(item.id)
          : normalizedLineKey != null && normalizedLineKey.isNotEmpty
              ? (t) => t.lineKey.equals(normalizedLineKey)
              : (t) => t.id.equals(item.id),
      limit: 1,
    );

    if (existing.isNotEmpty) {
      item.id = existing.first.id;
      item.version = (existing.first.version ?? 0) + 1;
      item.createdAt ??= existing.first.createdAt;
      item.updatedAt = DateTime.now();
      await StartingEquipmentLineData.db.updateRow(session, item);
      return item;
    }

    _stampStartingEquipmentRow(item);
    return StartingEquipmentLineData.db.insertRow(session, item);
  }

  Future<void> delete(Session session, int id) async {
    await StartingEquipmentLineData.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
  }
}

Future<List<StartingEquipmentBlockView>> loadStartingEquipmentBlockViews(
  Session session, {
  int? sourceClassId,
  int? sourceBackgroundId,
}) async {
  final blocks = await _loadStartingEquipmentBlocks(
    session,
    sourceClassId: sourceClassId,
    sourceBackgroundId: sourceBackgroundId,
  );
  if (blocks.isEmpty) {
    return const <StartingEquipmentBlockView>[];
  }

  final blockIds = {
    for (final block in blocks)
      if (block.id != null) block.id!,
  };
  final options = blockIds.isEmpty
      ? const <StartingEquipmentOptionData>[]
      : await StartingEquipmentOptionData.db.find(
          session,
          where: (t) => t.blockId.inSet(blockIds),
          orderBy: (t) => t.orderIndex,
        );
  final optionIds = {
    for (final option in options)
      if (option.id != null) option.id!,
  };
  final lines = (blockIds.isEmpty && optionIds.isEmpty)
      ? const <StartingEquipmentLineData>[]
      : await StartingEquipmentLineData.db.find(
          session,
          where: (t) => t.blockId.inSet(blockIds) | t.optionId.inSet(optionIds),
          orderBy: (t) => t.orderIndex,
        );

  final optionsByBlockId = <int, List<StartingEquipmentOptionData>>{};
  for (final option in options) {
    optionsByBlockId.putIfAbsent(
        option.blockId, () => <StartingEquipmentOptionData>[]);
    optionsByBlockId[option.blockId]!.add(option);
  }
  final fixedLinesByBlockId = <int, List<StartingEquipmentLineData>>{};
  final linesByOptionId = <int, List<StartingEquipmentLineData>>{};
  for (final line in lines) {
    final blockId = line.blockId;
    if (blockId != null) {
      fixedLinesByBlockId.putIfAbsent(
          blockId, () => <StartingEquipmentLineData>[]);
      fixedLinesByBlockId[blockId]!.add(line);
    }
    final optionId = line.optionId;
    if (optionId != null) {
      linesByOptionId.putIfAbsent(
          optionId, () => <StartingEquipmentLineData>[]);
      linesByOptionId[optionId]!.add(line);
    }
  }

  return [
    for (final block in blocks)
      StartingEquipmentBlockView(
        block: block,
        fixedLines: block.id == null
            ? const <StartingEquipmentLineData>[]
            : fixedLinesByBlockId[block.id!] ??
                const <StartingEquipmentLineData>[],
        options: block.id == null
            ? const <StartingEquipmentOptionView>[]
            : [
                for (final option in optionsByBlockId[block.id!] ??
                    const <StartingEquipmentOptionData>[])
                  StartingEquipmentOptionView(
                    option: option,
                    lines: option.id == null
                        ? const <StartingEquipmentLineData>[]
                        : linesByOptionId[option.id!] ??
                            const <StartingEquipmentLineData>[],
                  ),
              ],
      ),
  ];
}

Future<List<StartingEquipmentBlockData>> _loadStartingEquipmentBlocks(
  Session session, {
  int? sourceClassId,
  int? sourceBackgroundId,
}) async {
  if (sourceClassId == null && sourceBackgroundId == null) {
    return const <StartingEquipmentBlockData>[];
  }

  if (sourceClassId != null && sourceBackgroundId != null) {
    return StartingEquipmentBlockData.db.find(
      session,
      where: (t) =>
          t.sourceClassId.equals(sourceClassId) |
          t.sourceBackgroundId.equals(sourceBackgroundId),
      orderBy: (t) => t.orderIndex,
    );
  }

  if (sourceClassId != null) {
    return StartingEquipmentBlockData.db.find(
      session,
      where: (t) => t.sourceClassId.equals(sourceClassId),
      orderBy: (t) => t.orderIndex,
    );
  }

  return StartingEquipmentBlockData.db.find(
    session,
    where: (t) => t.sourceBackgroundId.equals(sourceBackgroundId),
    orderBy: (t) => t.orderIndex,
  );
}

void _stampStartingEquipmentRow(dynamic row) {
  final now = DateTime.now();
  row.version ??= 1;
  row.createdAt ??= now;
  row.updatedAt ??= now;
}
