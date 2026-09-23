part of '../character_data_endpoint.dart';

const _characterSyncEventCreated = 'created';
const _characterSyncEventUpdated = 'updated';
const _characterSyncEventDeleted = 'deleted';

Future<_CharacterSyncPullDelta> _loadAuthoritativeCharacterFullResync(
  Session session, {
  required int userId,
  required _CharacterResolveContext resolveContext,
}) {
  return _runCharacterMutationTransaction(
    session,
    (transaction) async {
      final records = await CharacterRecord.db.find(
        session,
        where: (t) => t.userId.equals(userId),
        orderBy: (t) => t.id,
        include: _characterRecordInclude(),
        transaction: transaction,
      );
      final characters = await Future.wait(
        records.map(
          (record) => _buildCharacterAggregate(
            session,
            record,
            transaction: transaction,
            resolveContext: resolveContext,
          ),
        ),
      );
      return _CharacterSyncPullDelta(
        characters: characters,
        cursor: await _latestCharacterSyncEventId(
              session,
              userId: userId,
              transaction: transaction,
            ) ??
            0,
      );
    },
    userId: userId,
  );
}

Future<void> _recordCharacterSyncEvent(
  Session session, {
  required int userId,
  required int characterId,
  required String eventType,
  required Transaction transaction,
  int? characterVersion,
  String? changeId,
}) async {
  await CharacterSyncEventRecord.db.insertRow(
    session,
    CharacterSyncEventRecord(
      userId: userId,
      characterId: characterId,
      characterVersion: characterVersion,
      eventType: eventType,
      changeId: changeId,
      createdAt: DateTime.now().toUtc(),
    ),
    transaction: transaction,
  );
}

Future<_CharacterSyncPullDelta> _loadCharacterSyncDelta(
  Session session, {
  required int userId,
  required int? pullAfterEventId,
  required DateTime? pullSince,
  _CharacterResolveContext? resolveContext,
}) async {
  final context = resolveContext ?? _CharacterResolveContext(session);
  if (pullAfterEventId != null) {
    return _loadCharacterSyncDeltaAfterEventId(
      session,
      userId: userId,
      pullAfterEventId: pullAfterEventId,
      resolveContext: context,
    );
  }

  final characters = await _loadCharactersUpdatedAfter(
    session,
    userId: userId,
    updatedAfter: pullSince,
    resolveContext: context,
  );
  return _CharacterSyncPullDelta(
    characters: characters,
    cursor: await _latestCharacterSyncEventId(session, userId: userId),
  );
}

Future<_CharacterSyncPullDelta> _loadCharacterSyncDeltaAfterEventId(
  Session session, {
  required int userId,
  required int pullAfterEventId,
  required _CharacterResolveContext resolveContext,
}) async {
  final events = await CharacterSyncEventRecord.db.find(
    session,
    where: (t) => t.userId.equals(userId) & (t.id > pullAfterEventId),
    orderBy: (t) => t.id,
    orderDescending: false,
  );
  if (events.isEmpty) {
    return _CharacterSyncPullDelta(
      cursor: pullAfterEventId,
    );
  }

  final latestByCharacterId = <int, CharacterSyncEventRecord>{};
  for (final event in events) {
    latestByCharacterId[event.characterId] = event;
  }

  final deletedCharacterIds = <int>[];
  final changedCharacterIds = <int>{};
  for (final event in latestByCharacterId.values) {
    if (event.eventType == _characterSyncEventDeleted) {
      deletedCharacterIds.add(event.characterId);
    } else {
      changedCharacterIds.add(event.characterId);
    }
  }
  deletedCharacterIds.sort();

  final records = changedCharacterIds.isEmpty
      ? const <CharacterRecord>[]
      : await CharacterRecord.db.find(
          session,
          where: (t) =>
              t.userId.equals(userId) & t.id.inSet(changedCharacterIds),
          include: _characterRecordInclude(),
        );
  final characters = await Future.wait(
    records.map(
      (record) => _buildCharacterAggregate(
        session,
        record,
        resolveContext: resolveContext,
      ),
    ),
  );
  characters.sort((left, right) => (left.id ?? 0).compareTo(right.id ?? 0));

  return _CharacterSyncPullDelta(
    characters: characters,
    deletedCharacterIds: deletedCharacterIds,
    cursor: events.last.id ?? pullAfterEventId,
  );
}

Future<int?> _latestCharacterSyncEventId(
  Session session, {
  required int userId,
  Transaction? transaction,
}) async {
  final latest = await CharacterSyncEventRecord.db.findFirstRow(
    session,
    where: (t) => t.userId.equals(userId),
    orderBy: (t) => t.id,
    orderDescending: true,
    transaction: transaction,
  );
  return latest?.id;
}

class _CharacterSyncPullDelta {
  const _CharacterSyncPullDelta({
    this.characters = const <CharacterData>[],
    this.deletedCharacterIds = const <int>[],
    this.cursor,
  });

  final List<CharacterData> characters;
  final List<int> deletedCharacterIds;
  final int? cursor;
}
