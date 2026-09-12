import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_sync_operations.dart';
import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';
import 'package:flutter/foundation.dart';

OfflineCacheDatabase? offlineCacheDatabase;
OfflineSyncCoordinator? offlineSyncCoordinator;

bool get isAndroidOfflineCacheEnabled =>
    !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

Future<void> initializeOfflineServices() async {
  if (!isAndroidOfflineCacheEnabled) {
    return;
  }
  offlineCacheDatabase = await OfflineCacheDatabase.openDefault();
  offlineSyncCoordinator = OfflineSyncCoordinator(
    cache: offlineCacheDatabase!,
    client: client,
    currentUserId: currentOfflineUserId,
  );
}

int? currentOfflineUserId() {
  try {
    return sessionManager.signedInUser?.id;
  } catch (_) {
    return null;
  }
}

class OfflineSyncCoordinator {
  OfflineSyncCoordinator({
    required OfflineCacheDatabase cache,
    required Client client,
    required int? Function() currentUserId,
  })  : _cache = cache,
        _client = client,
        _currentUserId = currentUserId;

  final OfflineCacheDatabase _cache;
  final Client _client;
  final int? Function() _currentUserId;
  bool _isRunning = false;

  Future<void> syncNow() async {
    if (_isRunning) return;
    final userId = _currentUserId();
    if (userId == null) return;

    _isRunning = true;
    try {
      final pending = await _cache.getPendingChanges(userId);
      final coalesced = await _coalescePendingChanges(userId, pending);
      final pullSince = await _cache.getLastPulledAt(userId);
      if (coalesced.isEmpty && pullSince == null) {
        await _refreshAllCharacters(userId);
        return;
      }

      final legacyChanges = [
        for (final change in coalesced)
          if (change.operationData == null) change,
      ];
      final operationChanges = [
        for (final change in coalesced)
          if (change.operationData != null) change,
      ];

      CharacterSyncResponse? finalResponse;
      if (legacyChanges.isNotEmpty) {
        final response = await _sendLegacyChanges(
          legacyChanges,
          pullSince: operationChanges.isEmpty ? pullSince : null,
        );
        await _applyAcknowledgements(userId, legacyChanges, response);
        await _applyRejections(userId, legacyChanges, response.rejectedChanges);
        await _applyPulledCharacters(userId, response.characters);
        finalResponse = response;
      }
      if (operationChanges.isNotEmpty || legacyChanges.isEmpty) {
        final response = await _sendOperationChanges(
          operationChanges,
          pullSince: pullSince,
        );
        await _applyAcknowledgements(userId, operationChanges, response);
        await _applyRejections(
          userId,
          operationChanges,
          response.rejectedChanges,
        );
        await _applyPulledCharacters(userId, response.characters);
        finalResponse = response;
      }
      if (finalResponse?.serverTime != null) {
        await _cache.setLastPulledAt(userId, finalResponse!.serverTime!);
      }
    } catch (_) {
      for (final change in await _cache.getPendingChanges(userId)) {
        await _cache.markChangeFailed(userId, change.id, 'Sync request failed');
        final localId = int.tryParse(change.entityId);
        if (localId != null) {
          await _cache.markSyncError(userId, localId, 'Sync request failed');
        }
      }
    } finally {
      _isRunning = false;
    }
  }

  Future<CharacterSyncResponse> _sendLegacyChanges(
    List<OfflineCharacterChange> changes, {
    required DateTime? pullSince,
  }) {
    return _client.characterData.syncCharacters(
      CharacterSyncRequest(
        changes: [
          for (final change in changes)
            CharacterChangeData(
              id: change.id,
              changeType: change.changeType,
              entityType: change.entityType,
              entityId: change.entityId,
              payload: _serverPayloadForChange(change),
              createdAt: change.createdAt,
              baseUpdatedAt: change.baseUpdatedAt,
            ),
        ],
        pullSince: pullSince,
      ),
    );
  }

  Future<CharacterSyncResponse> _sendOperationChanges(
    List<OfflineCharacterChange> changes, {
    required DateTime? pullSince,
  }) {
    return _client.characterData.syncCharacters(
      CharacterSyncRequest(
        operations: [
          for (final change in changes)
            if (change.operationData != null) change.operationData!,
        ],
        pullSince: pullSince,
      ),
    );
  }

  Future<List<OfflineCharacterChange>> _coalescePendingChanges(
    int userId,
    List<OfflineCharacterChange> pending,
  ) async {
    final effectiveLegacy = <OfflineCharacterChange>[];
    final operationChanges = <OfflineCharacterChange>[];
    for (final change in pending) {
      final localId = int.tryParse(change.entityId);
      if (change.changeType == CharacterChangeType.delete && localId != null) {
        final record = await _cache.getCharacter(userId, localId);
        if (record?.serverId == null) {
          await _cache.markDeleteSynced(userId, localId);
          await _cache.deleteQueuedChangesForEntity(userId, change.entityId);
          continue;
        }
      }

      if (change.operationData != null) {
        operationChanges.add(change);
        continue;
      }

      if (effectiveLegacy.isNotEmpty) {
        final last = effectiveLegacy.last;
        if (last.entityId == change.entityId &&
            last.entityType == change.entityType) {
          if (last.changeType == CharacterChangeType.upsert &&
              change.changeType == CharacterChangeType.upsert) {
            effectiveLegacy[effectiveLegacy.length - 1] = change;
            continue;
          }
          if (change.changeType == CharacterChangeType.delete) {
            effectiveLegacy[effectiveLegacy.length - 1] = change;
            continue;
          }
        }
      }
      effectiveLegacy.add(change);
    }
    final changesById = {
      for (final change in operationChanges) change.id: change
    };
    final coalescedOperations = coalesceCharacterSyncOperations(
      operationChanges.map((change) => change.operationData!),
    );
    return [
      ...effectiveLegacy,
      for (final operation in coalescedOperations) changesById[operation.id]!,
    ];
  }

  CharacterData? _serverPayloadForChange(OfflineCharacterChange change) {
    final payload = change.payload;
    if (payload == null) return null;
    final parsedId = int.tryParse(change.entityId);
    if (parsedId == null || parsedId < 0) {
      return payload.copyWith(id: null);
    }
    return payload.copyWith(id: parsedId);
  }

  Future<void> _applyAcknowledgements(
    int userId,
    List<OfflineCharacterChange> sentChanges,
    CharacterSyncResponse response,
  ) async {
    final acknowledged =
        (response.acknowledgedChangeIds ?? const <String>[]).toSet();
    if (acknowledged.isEmpty) {
      return;
    }

    final characterById = {
      for (final character in response.characters ?? const <CharacterData>[])
        if (character.id != null) character.id!.toString(): character,
    };
    final changedByChangeId = response.changedCharacters ?? const {};
    final syncedUpdates =
        <({int localId, String entityId, CharacterData character})>[];

    for (final change in sentChanges) {
      if (!acknowledged.contains(change.id)) {
        continue;
      }
      final operation = change.operationData;
      if (operation != null) {
        switch (operation.type) {
          case CharacterSyncOperationType.createCharacter:
          case CharacterSyncOperationType.setField:
          case CharacterSyncOperationType.setMapEntry:
          case CharacterSyncOperationType.removeMapEntry:
          case CharacterSyncOperationType.upsertListItem:
          case CharacterSyncOperationType.removeListItem:
            final serverCharacter = changedByChangeId[change.id] ??
                (operation.characterId == null
                    ? null
                    : characterById[operation.characterId.toString()]);
            final localId = operation.localCharacterId ??
                operation.characterId ??
                int.tryParse(change.entityId);
            if (localId != null && serverCharacter != null) {
              syncedUpdates.add((
                localId: localId,
                entityId: change.entityId,
                character: serverCharacter,
              ));
            }
            break;
          case CharacterSyncOperationType.deleteCharacter:
            final localId = operation.localCharacterId ??
                operation.characterId ??
                int.tryParse(change.entityId);
            if (localId != null) {
              await _cache.markDeleteSynced(userId, localId);
            }
            break;
        }
        continue;
      }

      switch (change.changeType) {
        case CharacterChangeType.upsert:
          final localId = change.payload?.id;
          final serverCharacter = characterById[change.entityId];
          if (localId != null && serverCharacter != null) {
            syncedUpdates.add((
              localId: localId,
              entityId: change.entityId,
              character: serverCharacter,
            ));
          }
          break;
        case CharacterChangeType.delete:
          final localId = int.tryParse(change.entityId);
          if (localId != null) {
            await _cache.markDeleteSynced(userId, localId);
          }
          break;
      }
    }

    await _cache.removeChanges(userId, acknowledged);
    for (final update in syncedUpdates) {
      final serverId = update.character.id;
      final hasMoreChanges = await _cache.hasQueuedChangesForEntity(
        userId,
        serverId?.toString() ?? update.entityId,
      );
      if (!hasMoreChanges) {
        await _cache.markSynced(userId, update.localId, update.character);
        if (serverId != null) {
          await _cache.clearSyncError(userId, serverId);
        }
      }
    }
  }

  Future<void> _applyRejections(
    int userId,
    List<OfflineCharacterChange> sentChanges,
    List<CharacterRejectedChangeData>? rejectedChanges,
  ) async {
    final sentById = {for (final change in sentChanges) change.id: change};
    for (final rejection
        in rejectedChanges ?? const <CharacterRejectedChangeData>[]) {
      final serverCharacter = rejection.character;
      if (serverCharacter != null && serverCharacter.id != null) {
        final change = sentById[rejection.changeId];
        final localId = change?.operationData?.localCharacterId ??
            int.tryParse(change?.entityId ?? '') ??
            serverCharacter.id!;
        await _cache.markConflict(
          userId,
          localId,
          serverCharacter,
          rejection.message ?? rejection.reason,
        );
        await _cache.markChangeConflict(
          userId,
          rejection.changeId,
          serverCharacter,
          rejection.message ?? rejection.reason,
        );
      } else {
        await _cache.markChangeRejected(
          userId,
          rejection.changeId,
          rejection.message ?? rejection.reason ?? 'Rejected by server',
        );
      }
    }
  }

  Future<void> _applyPulledCharacters(
    int userId,
    List<CharacterData>? characters,
  ) async {
    for (final character in characters ?? const <CharacterData>[]) {
      await _cache.upsertCleanFromServer(userId, character);
    }
  }

  Future<void> _refreshAllCharacters(int userId) async {
    final characters = await _client.characterData.getAll();
    for (final character in characters) {
      await _cache.upsertCleanFromServer(userId, character);
    }
    await _cache.setLastPulledAt(userId, DateTime.now().toUtc());
  }
}
