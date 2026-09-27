import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character/armor_class_calculator.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/character_semantic_sync.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_item_id.dart';
import 'package:characters_mirror_flutter/core/offline/character_mutation_stamper.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/core/offline/offline_services.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/repositories/repository_base.dart';
import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';

class CharacterRepository implements Repository<CharacterData> {
  List<ArmorData>? _armorCatalogWithoutOfflineCache;

  @override
  Future<List<CharacterData>> getAll() async {
    final store = characterSyncStore;
    final userId = currentOfflineUserId();
    if (store != null && userId != null) {
      final cached = await store.getCharacters(userId);
      if (cached.isNotEmpty) {
        unawaited(offlineSyncCoordinator?.syncNow());
        return cached.map((record) => record.character).toList();
      }
      await offlineSyncCoordinator?.syncNow();
      final synchronized = await store.getCharacters(userId);
      if (synchronized.isNotEmpty ||
          await store.getSyncEventCursor(userId) != null) {
        return synchronized.map((record) => record.character).toList();
      }
    }

    final characters = await client.characterData.getAll();
    if (store != null && userId != null) {
      for (final character in characters) {
        await store.upsertCleanFromServer(userId, character);
      }
    }
    return characters;
  }

  @override
  Future<CharacterData?> getById(int id) => getCharacter(id);

  Future<CharacterData> saveCharacter(CharacterData character) =>
      _saveCharacter(character);

  Future<CharacterData> saveSemanticAction({
    required CharacterData character,
    required CharacterSyncOperationType type,
    required CharacterSemanticActionData action,
  }) async {
    final normalized = normalizeCharacterForPersistence(
      character,
      fallbackUpdatedAt: character.updatedAt ?? DateTime.now().toUtc(),
    );
    final store = characterSyncStore;
    final userId = currentOfflineUserId();
    if (store == null || userId == null) {
      return saveCharacter(normalized);
    }
    final existing = normalized.id == null
        ? null
        : await store.getCharacter(userId, normalized.id!);
    if (existing?.serverId == null) {
      final resolved = await _resolveForLocalStore(normalized);
      final record = await store.saveLocal(userId, resolved);
      unawaited(offlineSyncCoordinator?.syncNow());
      return record.character;
    }
    final now = DateTime.now().toUtc();
    final operation = createCharacterSemanticOperation(
      character: existing!.character,
      localId: existing.localId,
      serverId: existing.serverId!,
      type: type,
      action: action,
      changeId: createCharacterSyncItemId(),
      createdAt: now,
    );
    final resolved = await _resolveForLocalStore(normalized);
    final record = await store.saveSemanticLocal(
      userId,
      resolved,
      operation,
    );
    unawaited(offlineSyncCoordinator?.syncNow());
    return record.character;
  }

  Future<CharacterData> getCharacter(int characterId) async {
    final store = characterSyncStore;
    final userId = currentOfflineUserId();
    if (store != null && userId != null) {
      final cached = await store.getCharacter(userId, characterId);
      if (cached != null &&
          cached.status != OfflineCharacterSyncStatus.deleting) {
        unawaited(offlineSyncCoordinator?.syncNow());
        return cached.character;
      }
      await offlineSyncCoordinator?.syncNow();
      final synchronized = await store.getCharacter(userId, characterId);
      if (synchronized != null &&
          synchronized.status != OfflineCharacterSyncStatus.deleting) {
        return synchronized.character;
      }
    }

    final character = await client.characterData.getCharacter(characterId);
    if (store != null && userId != null) {
      await store.upsertCleanFromServer(userId, character);
    }
    return character;
  }

  @override
  Future<CharacterData> upsert(CharacterData entity) => saveCharacter(entity);

  @override
  Future<void> delete(int id) async {
    final store = characterSyncStore;
    final userId = currentOfflineUserId();
    if (store != null && userId != null) {
      await store.markDeleting(userId, id, null);
      unawaited(offlineSyncCoordinator?.syncNow());
      return;
    }
    return client.characterData.delete(id);
  }

  Future<OfflineCharacterRecord?> getOfflineRecord(int id) async {
    final store = characterSyncStore;
    final userId = currentOfflineUserId();
    if (store == null || userId == null) return null;
    return store.getCharacter(userId, id);
  }

  Future<List<OfflineCharacterRecord>> getOfflineRecords() async {
    final store = characterSyncStore;
    final userId = currentOfflineUserId();
    if (store == null || userId == null) return const [];
    return store.getCharacters(userId);
  }

  Future<bool> hasUnsyncedChanges() async {
    final store = characterSyncStore;
    final userId = currentOfflineUserId();
    if (store == null || userId == null) return false;
    return store.hasUnsyncedChanges(userId);
  }

  Future<void> clearLocalUserCache() async {
    final store = characterSyncStore;
    final userId = currentOfflineUserId();
    if (store == null || userId == null) return;
    await store.clearUser(userId);
  }

  Future<void> clearLocalUserCacheForUser(int userId) async {
    final store = characterSyncStore;
    if (store == null) return;
    await store.clearUser(userId);
  }

  Future<CharacterData> _saveCharacter(CharacterData character) async {
    final normalized = normalizeCharacterForPersistence(
      character,
      fallbackUpdatedAt: character.updatedAt ?? DateTime.now().toUtc(),
    );
    final store = characterSyncStore;
    final userId = currentOfflineUserId();
    if (store != null && userId != null) {
      final resolved = await _resolveForLocalStore(normalized);
      final record = await store.saveLocal(userId, resolved);
      unawaited(offlineSyncCoordinator?.syncNow());
      return record.character;
    }

    return client.characterData.saveCharacter(normalized);
  }

  Future<CharacterData> _resolveForLocalStore(CharacterData character) async {
    final cache = offlineCacheDatabase;
    if (cache == null) {
      final hasCatalogArmorSelection = [
        character.equippedArmor?.referenceKey,
        character.equippedShield?.referenceKey,
      ].any((key) => key?.trim().isNotEmpty == true);
      if (!hasCatalogArmorSelection) {
        return recalculateArmorClassFromCatalog(character, const []);
      }

      try {
        _armorCatalogWithoutOfflineCache ??= await client.armorData.getAll();
        return recalculateArmorClassFromCatalog(
          character,
          _armorCatalogWithoutOfflineCache!,
        );
      } catch (_) {
        // Keep the local edit available if reference data cannot be loaded.
        return character;
      }
    }
    return resolveOfflineCharacter(cache, character);
  }
}
