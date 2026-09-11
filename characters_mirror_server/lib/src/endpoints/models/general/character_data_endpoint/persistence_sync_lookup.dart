part of '../character_data_endpoint.dart';

bool _serverSnapshotIsNewer(
  CharacterRecord? currentRecord,
  CharacterData incoming,
) {
  final storedUpdatedAt = currentRecord?.updatedAt?.toUtc();
  final incomingUpdatedAt = incoming.updatedAt?.toUtc();
  if (storedUpdatedAt == null || incomingUpdatedAt == null) {
    return false;
  }
  return storedUpdatedAt.isAfter(incomingUpdatedAt);
}

bool _serverDeleteShouldWin(
    CharacterRecord currentRecord, DateTime? baseUpdatedAt) {
  final storedUpdatedAt = currentRecord.updatedAt?.toUtc();
  final base = baseUpdatedAt?.toUtc();
  if (storedUpdatedAt == null || base == null) {
    return false;
  }
  return storedUpdatedAt.isAfter(base);
}

Future<CharacterRecord?> _findOwnedCharacterRecordByEntityId(
  Session session,
  int userId,
  String entityId,
) async {
  final numericId = int.tryParse(entityId);
  if (numericId != null) {
    return _findOwnedCharacterRecord(session, numericId, userId);
  }
  return null;
}

Future<List<CharacterData>> _loadCharactersUpdatedAfter(
  Session session, {
  required int userId,
  required DateTime? updatedAfter,
}) async {
  final records = await CharacterRecord.db.find(
    session,
    where: (t) {
      var expression = t.userId.equals(userId);
      if (updatedAfter != null) {
        expression &= t.updatedAt > updatedAfter.toUtc();
      }
      return expression;
    },
    orderBy: (t) => t.updatedAt,
    orderDescending: false,
    include: _characterRecordInclude(),
  );

  return Future.wait(
    records.map((record) => _buildCharacterAggregate(session, record)),
  );
}

CharacterInventoryItemType _inventoryItemTypeForCatalog(
  EquipmentCatalogType? catalogType,
) {
  switch (catalogType) {
    case EquipmentCatalogType.weapon:
      return CharacterInventoryItemType.weapon;
    case EquipmentCatalogType.armor:
      return CharacterInventoryItemType.armor;
    case EquipmentCatalogType.magicItem:
      return CharacterInventoryItemType.magicItem;
    case EquipmentCatalogType.item:
    case null:
      return CharacterInventoryItemType.item;
  }
}

String _generateSyncId() {
  final random = Random.secure();
  final chunks = [
    for (final length in const [8, 4, 4, 4, 12]) _randomHex(random, length),
  ];
  return chunks.join('-');
}

String _randomHex(Random random, int length) {
  final buffer = StringBuffer();
  for (var index = 0; index < length; index++) {
    buffer.write(random.nextInt(16).toRadixString(16));
  }
  return buffer.toString();
}

Future<int> _requireCurrentUserId(Session session) async {
  final userId = (await session.authenticated)?.userId;
  if (userId == null) {
    throw Exception('Authentication required.');
  }
  return userId;
}

Future<CharacterRecord?> _findOwnedCharacterRecord(
  Session session,
  int characterId,
  int userId,
) async {
  final rows = await CharacterRecord.db.find(
    session,
    where: (t) => t.id.equals(characterId) & t.userId.equals(userId),
    limit: 1,
    include: _characterRecordInclude(),
  );
  if (rows.isEmpty) {
    return null;
  }
  return rows.first;
}

Future<CharacterRecord> _requireOwnedCharacterRecord(
  Session session,
  int characterId, {
  int? userId,
}) async {
  final resolvedUserId = userId ?? await _requireCurrentUserId(session);
  final record = await _findOwnedCharacterRecord(
    session,
    characterId,
    resolvedUserId,
  );
  if (record != null) {
    return record;
  }

  final existing = await CharacterRecord.db.find(
    session,
    where: (t) => t.id.equals(characterId),
    limit: 1,
  );
  if (existing.isNotEmpty) {
    throw Exception('Access denied to character id=$characterId.');
  }

  throw Exception('CharacterData with id=$characterId was not found.');
}
