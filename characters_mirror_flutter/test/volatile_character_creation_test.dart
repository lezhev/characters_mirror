import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/memory_character_sync_store.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/repositories/reference_character_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('volatile creation becomes visible only after canonical server save',
      () async {
    final store = MemoryCharacterSyncStore();
    final remote = Completer<CharacterData>();
    final pending = persistConfirmedNewCharacter(
      CharacterData(name: 'Rogue fixture'),
      userId: 781,
      store: store,
      saveRemote: (_) => remote.future,
    );

    expect(await store.getCharacters(781), isEmpty);
    remote.complete(CharacterData(
      id: 42,
      name: 'Rogue fixture',
      derived: CharacterDerivedData(maxHp: 9),
    ));
    final saved = await pending;
    expect(saved.id, 42);
    expect(saved.derived?.maxHp, 9);
    expect((await store.getCharacters(781)).single.character.id, 42);
    expect((await store.getCharacters(781)).single.character.derived?.maxHp, 9);
  });

  test('failed volatile save leaves no disappearing local character', () async {
    final store = MemoryCharacterSyncStore();
    await expectLater(
      persistConfirmedNewCharacter(
        CharacterData(name: 'Rogue fixture'),
        userId: 781,
        store: store,
        saveRemote: (_) async => throw StateError('remote save failed'),
      ),
      throwsStateError,
    );
    expect(await store.getCharacters(781), isEmpty);
  });

  test('server response without id is not cached', () async {
    final store = MemoryCharacterSyncStore();
    await expectLater(
      persistConfirmedNewCharacter(
        CharacterData(name: 'Rogue fixture'),
        userId: 781,
        store: store,
        saveRemote: (_) async => CharacterData(name: 'Rogue fixture'),
      ),
      throwsStateError,
    );
    expect(await store.getCharacters(781), isEmpty);
  });
}
