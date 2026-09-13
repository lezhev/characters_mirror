import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart'
    as protocol;
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/features/characters/application/characters_list_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CharactersListController', () {
    test('removes deleted character optimistically', () async {
      final repository = _ControlledDeleteCharacterRepository(
        initialCharacters: {
          1: protocol.CharacterData(id: 1, name: 'Первый герой'),
          2: protocol.CharacterData(id: 2, name: 'Второй герой'),
        },
      );
      final controller = CharactersListController(repository);
      addTearDown(controller.dispose);
      await controller.reload();

      final deleteFuture = controller.deleteCharacter(1);

      expect(repository.pendingDeleteId, 1);
      expect(_characterIds(controller), [2]);
      expect(
          controller.state.offlineRecordsByCharacterId.containsKey(1), isFalse);

      repository.completeDelete(1);
      final result = await deleteFuture;

      expect(result.success, isTrue);
      expect(_characterIds(controller), [2]);
      expect(controller.state.deletingCharacterId, isNull);
    });

    test('restores previous list when optimistic delete fails', () async {
      final repository = _ControlledDeleteCharacterRepository(
        initialCharacters: {
          1: protocol.CharacterData(id: 1, name: 'Первый герой'),
          2: protocol.CharacterData(id: 2, name: 'Второй герой'),
        },
      );
      final controller = CharactersListController(repository);
      addTearDown(controller.dispose);
      await controller.reload();

      final deleteFuture = controller.deleteCharacter(1);
      expect(_characterIds(controller), [2]);

      repository.failDelete(1);
      final result = await deleteFuture;

      expect(result.success, isFalse);
      expect(_characterIds(controller), [1, 2]);
      expect(
          controller.state.offlineRecordsByCharacterId.containsKey(1), isTrue);
      expect(controller.state.deletingCharacterId, isNull);
    });
  });
}

List<int?> _characterIds(CharactersListController controller) {
  return controller.state.characters.value!
      .map((character) => character.id)
      .toList();
}

class _ControlledDeleteCharacterRepository extends CharacterRepository {
  _ControlledDeleteCharacterRepository({
    required Map<int, protocol.CharacterData> initialCharacters,
  }) : _charactersById = Map<int, protocol.CharacterData>.from(
          initialCharacters,
        );

  final Map<int, protocol.CharacterData> _charactersById;
  final _deleteCompleters = <int, Completer<void>>{};

  int? get pendingDeleteId {
    for (final entry in _deleteCompleters.entries) {
      if (!entry.value.isCompleted) {
        return entry.key;
      }
    }
    return null;
  }

  @override
  Future<List<protocol.CharacterData>> getAll() async {
    return _charactersById.values.toList();
  }

  @override
  Future<List<OfflineCharacterRecord>> getOfflineRecords() async {
    return [
      for (final entry in _charactersById.entries)
        OfflineCharacterRecord(
          userId: 1,
          localId: entry.key,
          serverId: entry.key,
          character: entry.value,
          status: OfflineCharacterSyncStatus.clean,
        ),
    ];
  }

  @override
  Future<void> delete(int id) async {
    final completer = Completer<void>();
    _deleteCompleters[id] = completer;
    await completer.future;
    _charactersById.remove(id);
  }

  void completeDelete(int id) {
    _deleteCompleters[id]?.complete();
  }

  void failDelete(int id) {
    _deleteCompleters[id]?.completeError(Exception('Delete failed'));
  }
}
