import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/character_mutation_stamper.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/core/offline/offline_services.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/repositories/repository_base.dart';
import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';

class CharacterRepository implements Repository<CharacterData> {
  @override
  Future<List<CharacterData>> getAll() async {
    final cache = offlineCacheDatabase;
    final userId = currentOfflineUserId();
    if (cache != null && userId != null) {
      final cached = await cache.getCharacters(userId);
      unawaited(_refreshCharacters(cache, userId));
      if (cached.isNotEmpty) {
        return cached.map((record) => record.character).toList();
      }
    }

    final characters = await client.characterData.getAll();
    if (cache != null && userId != null) {
      for (final character in characters) {
        await cache.upsertCleanFromServer(userId, character);
      }
    }
    return characters;
  }

  @override
  Future<CharacterData?> getById(int id) => getCharacter(id);

  Future<CharacterData> saveCharacter(CharacterData character) =>
      _saveCharacter(character);

  Future<CharacterData> getCharacter(int characterId) async {
    final cache = offlineCacheDatabase;
    final userId = currentOfflineUserId();
    if (cache != null && userId != null) {
      final cached = await cache.getCharacter(userId, characterId);
      if (cached != null &&
          cached.status != OfflineCharacterSyncStatus.deleting) {
        unawaited(_refreshCharacter(cache, userId, characterId));
        return cached.character;
      }
    }

    final character = await client.characterData.getCharacter(characterId);
    if (cache != null && userId != null) {
      await cache.upsertCleanFromServer(userId, character);
    }
    return character;
  }

  @override
  Future<CharacterData> upsert(CharacterData entity) => saveCharacter(entity);

  @override
  Future<void> delete(int id) async {
    final cache = offlineCacheDatabase;
    final userId = currentOfflineUserId();
    if (cache != null && userId != null) {
      await cache.markDeleting(userId, id, null);
      unawaited(offlineSyncCoordinator?.syncNow());
      return;
    }
    return client.characterData.delete(id);
  }

  Future<OfflineCharacterRecord?> getOfflineRecord(int id) async {
    final cache = offlineCacheDatabase;
    final userId = currentOfflineUserId();
    if (cache == null || userId == null) return null;
    return cache.getCharacter(userId, id);
  }

  Future<List<OfflineCharacterRecord>> getOfflineRecords() async {
    final cache = offlineCacheDatabase;
    final userId = currentOfflineUserId();
    if (cache == null || userId == null) return const [];
    return cache.getCharacters(userId);
  }

  Future<bool> hasUnsyncedChanges() async {
    final cache = offlineCacheDatabase;
    final userId = currentOfflineUserId();
    if (cache == null || userId == null) return false;
    return cache.hasUnsyncedChanges(userId);
  }

  Future<void> clearLocalUserCache() async {
    final cache = offlineCacheDatabase;
    final userId = currentOfflineUserId();
    if (cache == null || userId == null) return;
    await cache.clearUser(userId);
  }

  Future<void> clearLocalUserCacheForUser(int userId) async {
    final cache = offlineCacheDatabase;
    if (cache == null) return;
    await cache.clearUser(userId);
  }

  Future<CharacterData> _saveCharacter(CharacterData character) async {
    final normalized = normalizeCharacterForPersistence(
      character,
      fallbackUpdatedAt: character.updatedAt ?? DateTime.now().toUtc(),
    );
    final cache = offlineCacheDatabase;
    final userId = currentOfflineUserId();
    if (cache != null && userId != null) {
      final resolved = await resolveOfflineCharacter(cache, normalized);
      final record = await cache.saveLocal(userId, resolved);
      unawaited(offlineSyncCoordinator?.syncNow());
      return record.character;
    }

    return client.characterData.saveCharacter(normalized);
  }

  Future<void> _refreshCharacters(
      OfflineCacheDatabase cache, int userId) async {
    try {
      final characters = await client.characterData.getAll();
      for (final character in characters) {
        await cache.upsertCleanFromServer(userId, character);
      }
      unawaited(offlineSyncCoordinator?.syncNow());
    } catch (_) {
      // Cached data is still valid for offline use.
    }
  }

  Future<void> _refreshCharacter(
    OfflineCacheDatabase cache,
    int userId,
    int characterId,
  ) async {
    if (characterId < 0) return;
    try {
      final character = await client.characterData.getCharacter(characterId);
      await cache.upsertCleanFromServer(userId, character);
    } catch (_) {
      // Cached data is still valid for offline use.
    }
  }
}
