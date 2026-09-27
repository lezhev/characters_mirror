import 'dart:io';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_services.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/attributes_step.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/attribute_enum.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/selection_type.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/state/attribute_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/state/class_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets(
      'offline attributes save keeps the creation draft when ability view is unavailable',
      (tester) async {
    final classData = ClassData(id: 1, name: 'Wizard');
    final repository = _OfflineClassRepository(classData);
    final container = ProviderContainer(
      overrides: [
        classRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    container
        .read(characterCreationProvider.notifier)
        .applyPrimaryClassSelection(classData: classData);
    await container.read(classStateProvider.future);
    final attributes = container.read(attributeStateProvider.notifier);
    attributes.changeType(SelectType.manual);
    attributes.updateManualAttribute(Attribute.strength, 16);

    final router = GoRouter(
      initialLocation: '/create/attributes',
      routes: [
        GoRoute(
          path: '/create/attributes',
          builder: (_, __) => const AttributesStep(),
        ),
        GoRoute(
          path: '/create/personal',
          builder: (_, __) => const Scaffold(body: Text('personal route')),
        ),
      ],
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          theme: darkTheme,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Далее'));
    await tester.pumpAndSettle();

    expect(repository.abilitySpecificRequests, 1);
    expect(find.text('personal route'), findsOneWidget);
    expect(
      container.read(characterCreationProvider).character.baseAbilityScores,
      containsPair('strength', 16),
    );
    expect(
      container
          .read(characterCreationProvider)
          .character
          .classEntries
          ?.single
          .classData
          ?.id,
      1,
    );
    expect(container.read(classStateProvider).hasError, isFalse);
  });

  test('offline-created attributes persist through restart and one create sync',
      () async {
    final directory = await Directory.systemTemp.createTemp('offline-attrs-');
    addTearDown(() => directory.delete(recursive: true));
    final path = '${directory.path}/cache.sqlite';
    final initialCache = await OfflineCacheDatabase.openAt(path);
    final local = await initialCache.saveLocal(
      7,
      CharacterData(
        name: 'Offline hero',
        baseAbilityScores: const {'strength': 10},
      ),
    );
    await initialCache.saveLocal(
      7,
      local.character.copyWith(baseAbilityScores: const {'strength': 25}),
    );
    initialCache.close();

    final cache = await OfflineCacheDatabase.openAt(path);
    addTearDown(cache.close);
    final reloaded = await cache.getCharacter(7, local.localId);
    expect(reloaded?.character.baseAbilityScores, const {'strength': 25});

    var createRequests = 0;
    final coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      retryDelays: const [],
      syncCharacters: (request) async {
        final operation = request.operations!.single;
        expect(operation.type, CharacterSyncOperationType.createCharacter);
        expect(
          operation.itemPayload?.characterValue?.baseAbilityScores,
          const {'strength': 25},
        );
        createRequests += 1;
        final canonical = CharacterData(
          id: 42,
          name: 'Offline hero',
          baseAbilityScores: const {'strength': 25},
          version: 1,
        );
        return CharacterSyncResponse(
          acknowledgedChangeIds: [operation.id],
          changedCharacters: {operation.id: canonical},
          characters: [canonical],
          pullCursor: 1,
        );
      },
    );
    addTearDown(coordinator.dispose);

    await coordinator.syncNow();

    expect(createRequests, 1);
    final byLocalId = await cache.getCharacter(7, local.localId);
    expect(byLocalId?.serverId, 42);
    final synced = await cache.getCharacter(7, 42);
    expect(synced?.status, OfflineCharacterSyncStatus.clean);
    expect(synced?.character.baseAbilityScores, const {'strength': 25});
    expect(await cache.getPendingChanges(7), isEmpty);
  });
}

class _OfflineClassRepository extends ClassRepository {
  _OfflineClassRepository(this.classData);

  final ClassData classData;
  int abilitySpecificRequests = 0;

  @override
  Future<List<ClassData>> getAll() async => [classData];

  @override
  Future<ClassStepView> getStepView(
    int classId, {
    int selectedLevel = 1,
    bool isStartingClass = true,
    int? selectedSubclassId,
    Map<String, int>? abilityScores,
  }) async {
    if (abilityScores != null) {
      abilitySpecificRequests += 1;
      throw StateError('No cached ability-specific class view.');
    }
    return ClassStepView(
      classData: classData,
      selectedLevel: selectedLevel,
    );
  }
}
