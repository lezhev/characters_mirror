import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
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

      final response = await _client.characterData.syncCharacters(
        CharacterSyncRequest(
          changes: [
            for (final change in coalesced)
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

      await _applyAcknowledgements(userId, coalesced, response);
      await _applyRejections(userId, response.rejectedChanges);
      await _applyPulledCharacters(userId, response.characters);
      if (response.serverTime != null) {
        await _cache.setLastPulledAt(userId, response.serverTime!);
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

  Future<List<OfflineCharacterChange>> _coalescePendingChanges(
    int userId,
    List<OfflineCharacterChange> pending,
  ) async {
    // TODO(op-sync): replace snapshot coalescing with per-entity operation
    // collapsing once the server accepts add/update/remove operations.
    final effective = <OfflineCharacterChange>[];
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

      if (effective.isNotEmpty) {
        final last = effective.last;
        if (last.entityId == change.entityId &&
            last.entityType == change.entityType) {
          if (last.changeType == CharacterChangeType.upsert &&
              change.changeType == CharacterChangeType.upsert) {
            effective[effective.length - 1] = change;
            continue;
          }
          if (change.changeType == CharacterChangeType.delete) {
            effective[effective.length - 1] = change;
            continue;
          }
        }
      }
      effective.add(change);
    }
    return effective;
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
    final acknowledged = (response.acknowledgedChangeIds ?? const <String>[])
        .toSet();
    if (acknowledged.isEmpty) {
      return;
    }

    final characterById = {
      for (final character in response.characters ?? const <CharacterData>[])
        if (character.id != null) character.id!.toString(): character,
    };

    for (final change in sentChanges) {
      if (!acknowledged.contains(change.id)) {
        continue;
      }
      switch (change.changeType) {
        case CharacterChangeType.upsert:
          final localId = change.payload?.id;
          final serverCharacter = characterById[change.entityId];
          if (localId != null && serverCharacter != null) {
            await _cache.markSynced(userId, localId, serverCharacter);
            await _cache.clearSyncError(userId, serverCharacter.id!);
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
  }

  Future<void> _applyRejections(
    int userId,
    List<CharacterRejectedChangeData>? rejectedChanges,
  ) async {
    for (final rejection in rejectedChanges ?? const <CharacterRejectedChangeData>[]) {
      final serverCharacter = rejection.character;
      if (serverCharacter != null && serverCharacter.id != null) {
        await _cache.upsertCleanFromServer(
          userId,
          serverCharacter,
          overwritePending: true,
        );
        await _cache.markSyncError(
          userId,
          serverCharacter.id!,
          rejection.message ?? rejection.reason ?? 'Rejected by server',
        );
      }
      await _cache.removeChanges(userId, [rejection.changeId]);
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
