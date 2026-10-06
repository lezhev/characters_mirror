import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_services.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/repositories/reference_character_repository.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _CanonicalRepository extends CharacterRepository {
  final getIds = <int>[];
  final levelUpIds = <int>[];
  final levelDownIds = <int>[];
  final saveIds = <int>[];
  final semanticSaveIds = <int>[];

  final local = CharacterData(id: -13, name: 'Draft');
  final canonical = CharacterData(id: 87, name: 'Draft', version: 1);

  @override
  Future<CharacterData> getCharacter(int characterId) async {
    getIds.add(characterId);
    return characterId < 0 ? local : canonical;
  }

  @override
  Future<CharacterData> prepareLevelUp(int characterId) async {
    levelUpIds.add(characterId);
    return canonical;
  }

  @override
  Future<CharacterData> prepareLevelDown(int characterId) async {
    levelDownIds.add(characterId);
    return canonical;
  }

  @override
  Future<CharacterData> saveCharacter(CharacterData character) async {
    saveIds.add(character.id!);
    return character.copyWith(id: 87, version: 2);
  }

  @override
  Future<CharacterData> saveSemanticAction({
    required CharacterData character,
    required CharacterSyncOperationType type,
    required CharacterSemanticActionData action,
  }) async {
    semanticSaveIds.add(character.id!);
    return character.copyWith(id: 87, version: 2);
  }
}

void main() {
  test('repository never sends an unresolved temporary id to the server',
      () async {
    final previousStore = characterSyncStore;
    final previousCache = offlineCacheDatabase;
    final previousCoordinator = offlineSyncCoordinator;
    characterSyncStore = null;
    offlineCacheDatabase = null;
    offlineSyncCoordinator = null;
    addTearDown(() {
      characterSyncStore = previousStore;
      offlineCacheDatabase = previousCache;
      offlineSyncCoordinator = previousCoordinator;
    });
    final repository = CharacterRepository();

    await expectLater(
      repository.getCharacter(-13),
      throwsA(isA<StateError>()),
    );
    await expectLater(
      repository.prepareLevelUp(-13),
      throwsA(isA<StateError>()),
    );
    await expectLater(
      repository.prepareLevelDown(-13),
      throwsA(isA<StateError>()),
    );
    await expectLater(
      repository.applyLevelUp(LevelUpRequest(
        characterId: -13,
        expectedVersion: 1,
        classEntryId: 'entry',
      )),
      throwsA(isA<StateError>()),
    );
    await expectLater(
      repository.applyLevelDown(LevelDownRequest(
        characterId: -13,
        expectedVersion: 1,
        classEntryId: 'entry',
      )),
      throwsA(isA<StateError>()),
    );
    await expectLater(
      repository.saveCharacter(CharacterData(id: -13, name: 'Draft')),
      throwsA(isA<StateError>()),
    );
    await expectLater(repository.delete(-13), throwsA(isA<StateError>()));
  });

  test('repeated Level Up after temp-id remap uses the canonical id', () async {
    final repository = _CanonicalRepository();
    final container = ProviderContainer(overrides: [
      characterRepositoryProvider.overrideWithValue(repository),
    ]);
    addTearDown(container.dispose);
    final provider = characterSheetControllerProvider(-13);
    await container.read(provider.future);
    final controller = container.read(provider.notifier);

    final first = await controller.prepareLevelUp();
    final second = await controller.prepareLevelUp();

    expect(first.id, 87);
    expect(second.id, 87);
    expect(repository.levelUpIds, [-13, 87]);
    expect(identical(controller, container.read(provider.notifier)), isTrue);
  });

  test('Level Down, reload, and edit keep using the canonical id', () async {
    final repository = _CanonicalRepository();
    final container = ProviderContainer(overrides: [
      characterRepositoryProvider.overrideWithValue(repository),
    ]);
    addTearDown(container.dispose);
    final provider = characterSheetControllerProvider(-13);
    await container.read(provider.future);
    final controller = container.read(provider.notifier);

    await controller.prepareLevelDown();
    await controller.prepareLevelDown();
    await controller.reload();
    await controller.saveProficiencyOverrides(
      controller.state.requireValue.copyWith(name: 'Edited'),
    );
    await controller.adjustExperience(1);

    expect(repository.levelDownIds, [-13, 87]);
    expect(repository.getIds.last, 87);
    final firstCanonicalRead = repository.getIds.indexOf(87);
    expect(repository.getIds.skip(firstCanonicalRead), everyElement(87));
    expect(repository.saveIds, [87]);
    expect(repository.semanticSaveIds, [87]);
    expect(controller.state.requireValue.id, 87);
  });

  test('an already canonical route id remains unchanged', () async {
    final repository = _CanonicalRepository();
    final container = ProviderContainer(overrides: [
      characterRepositoryProvider.overrideWithValue(repository),
    ]);
    addTearDown(container.dispose);
    final provider = characterSheetControllerProvider(87);
    await container.read(provider.future);
    final controller = container.read(provider.notifier);

    await controller.prepareLevelUp();

    expect(repository.levelUpIds, [87]);
  });
}
