import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/rate_limiting/character_save_rate_limiter.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Character sync', (sessionBuilder, endpoints) {
    setUp(CharacterSaveRateLimiter.resetForTests);

    TestSessionBuilder authenticatedSession(int userId) {
      return sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId,
          <Scope>{},
        ),
      );
    }

    test('syncCharacters acknowledges newer snapshot changes', () async {
      final ownerSession = authenticatedSession(101);
      final createdAt = DateTime.utc(2026, 4, 24, 0, 0, 0);

      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(
          name: 'Старое имя',
          updatedAt: createdAt,
          createdAt: createdAt,
        ),
      );

      final response = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          changes: [
            CharacterChangeData(
              id: 'change-1',
              changeType: CharacterChangeType.upsert,
              entityType: CharacterEntityType.character,
              entityId: saved.id!.toString(),
              createdAt: DateTime.utc(2026, 4, 24, 0, 5, 0),
              baseUpdatedAt: saved.updatedAt,
              payload: saved.copyWith(
                name: 'Новое имя',
                updatedAt: DateTime.utc(2026, 4, 24, 0, 10, 0),
              ),
            ),
          ],
          pullSince: DateTime.utc(2026, 4, 24, 0, 1, 0),
        ),
      );

      expect(response.acknowledgedChangeIds, contains('change-1'));
      expect(response.rejectedChanges, isEmpty);
      expect(
        response.characters
            ?.where((character) => character.id == saved.id)
            .length,
        1,
      );
      expect(
        response.characters
            ?.firstWhere((character) => character.id == saved.id)
            .name,
        'Новое имя',
      );
    });

    test('syncCharacters rejects stale snapshot changes', () async {
      final ownerSession = authenticatedSession(101);
      final createdAt = DateTime.utc(2026, 4, 24, 1, 0, 0);

      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(
          name: 'Актуальный герой',
          updatedAt: createdAt,
          createdAt: createdAt,
        ),
      );

      final fresherServerVersion = await endpoints.characterData.saveCharacter(
        ownerSession,
        saved.copyWith(
          name: 'Сервер новее',
          updatedAt: DateTime.utc(2026, 4, 24, 1, 20, 0),
        ),
      );

      final response = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          changes: [
            CharacterChangeData(
              id: 'change-2',
              changeType: CharacterChangeType.upsert,
              entityType: CharacterEntityType.character,
              entityId: saved.id!.toString(),
              createdAt: DateTime.utc(2026, 4, 24, 1, 25, 0),
              baseUpdatedAt: saved.updatedAt,
              payload: saved.copyWith(
                name: 'Локально устарело',
                updatedAt: DateTime.utc(2026, 4, 24, 1, 10, 0),
              ),
            ),
          ],
          pullSince: DateTime.utc(2026, 4, 24, 1, 5, 0),
        ),
      );

      expect(response.acknowledgedChangeIds, isNot(contains('change-2')));
      expect(response.rejectedChanges, hasLength(1));
      expect(response.rejectedChanges?.single.reason, 'stale_update');
      expect(
        response.rejectedChanges?.single.character?.name,
        fresherServerVersion.name,
      );
    });

    test('operation sync applies independent biography and hp edits', () async {
      final ownerSession = authenticatedSession(201);
      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'Hero', backstory: 'Before', currentHp: 10),
      );

      final biography = _setFieldOperation(
        id: 'bio',
        character: saved,
        fieldPath: 'backstory',
        targetId: 'backstory',
        value: CharacterSyncValueData(stringValue: 'After'),
      );
      final hp = _setFieldOperation(
        id: 'hp',
        character: saved,
        fieldPath: 'currentHp',
        targetId: 'currentHp',
        value: CharacterSyncValueData(intValue: 7),
      );

      await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(operations: [biography]),
      );
      final response = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(operations: [hp]),
      );

      expect(response.acknowledgedChangeIds, contains('hp'));
      final current = await endpoints.characterData.getCharacter(
        ownerSession,
        saved.id!,
      );
      expect(current.backstory, 'After');
      expect(current.currentHp, 7);
    });

    test('operation sync persists proficiency override fields', () async {
      final ownerSession = authenticatedSession(205);
      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'Proficiency sync'),
      );
      final operation = _setFieldOperation(
        id: 'language-overrides',
        character: saved,
        fieldPath: 'manualLanguageOverrides',
        targetId: 'manualLanguageOverrides',
        value: CharacterSyncValueData(
          languageOverridesValue: CharacterLanguageOverridesData(
            added: const [Language.elvish],
            custom: const ['River speech'],
          ),
        ),
      );

      final response = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(operations: [operation]),
      );
      final current = await endpoints.characterData.getCharacter(
        ownerSession,
        saved.id!,
      );

      expect(response.acknowledgedChangeIds, contains('language-overrides'));
      expect(response.rejectedChanges, isEmpty);
      expect(current.manualLanguageOverrides?.added, [Language.elvish]);
      expect(current.derived?.languages, [Language.elvish]);
      expect(current.derived?.customLanguages, ['River speech']);
    });

    test('operation sync merges different note ids', () async {
      final ownerSession = authenticatedSession(202);
      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(
          name: 'Notes',
          notes: [
            CharacterNoteData(id: 'note-a', text: 'A'),
            CharacterNoteData(id: 'note-b', text: 'B'),
          ],
        ),
      );

      final noteA = _upsertItemOperation(
        id: 'note-a-change',
        character: saved,
        fieldPath: 'notes',
        targetId: 'note-a',
        payload: CharacterSyncValueData(
          noteValue: CharacterNoteData(id: 'note-a', text: 'A+'),
        ),
      );
      final noteB = _upsertItemOperation(
        id: 'note-b-change',
        character: saved,
        fieldPath: 'notes',
        targetId: 'note-b',
        payload: CharacterSyncValueData(
          noteValue: CharacterNoteData(id: 'note-b', text: 'B+'),
        ),
      );

      final firstResponse = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(operations: [noteA]),
      );
      final secondResponse = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(operations: [noteB]),
      );

      expect(firstResponse.acknowledgedChangeIds, contains('note-a-change'));
      expect(secondResponse.acknowledgedChangeIds, contains('note-b-change'));
      expect(firstResponse.rejectedChanges, isEmpty);
      expect(secondResponse.rejectedChanges, isEmpty);
      expect(
        firstResponse.changedCharacters?['note-a-change']?.notes
            ?.singleWhere((note) => note.id == 'note-a')
            .text,
        'A+',
      );
      final current = await endpoints.characterData.getCharacter(
        ownerSession,
        saved.id!,
      );
      expect(current.notes?.map((note) => note.id),
          containsAll(['note-a', 'note-b']));
      expect(
          current.notes?.map((note) => note.text), containsAll(['A+', 'B+']));
    });

    test('operation sync merges inventory and attacks changes', () async {
      final ownerSession = authenticatedSession(203);
      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(
          name: 'Combat',
          equipment: [
            CharacterInventoryItemData(
              id: 'rope',
              name: 'Rope',
              quantity: 1,
              type: CharacterInventoryItemType.custom,
            ),
          ],
          attacks: [CharacterAttackData(id: 'slash', name: 'Slash')],
        ),
      );

      await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            _upsertItemOperation(
              id: 'equip',
              character: saved,
              fieldPath: 'equipment',
              targetId: 'rope',
              payload: CharacterSyncValueData(
                equipmentValue: CharacterInventoryItemData(
                  id: 'rope',
                  name: 'Rope',
                  quantity: 2,
                  type: CharacterInventoryItemType.custom,
                ),
              ),
            ),
          ],
        ),
      );
      await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            _upsertItemOperation(
              id: 'attack',
              character: saved,
              fieldPath: 'attacks',
              targetId: 'slash',
              payload: CharacterSyncValueData(
                attackValue: CharacterAttackData(
                  id: 'slash',
                  name: 'Slash',
                  damage: '1d8',
                ),
              ),
            ),
          ],
        ),
      );

      final current = await endpoints.characterData.getCharacter(
        ownerSession,
        saved.id!,
      );
      expect(current.equipment, hasLength(1));
      expect(current.equipment?.single.name, 'Rope x2');
      expect(current.equipment?.single.quantity, 1);
      expect(current.attacks?.single.damage, '1d8');
    });

    test('operation sync rejects same field conflict', () async {
      final ownerSession = authenticatedSession(204);
      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'Base'),
      );
      final first = _setFieldOperation(
        id: 'first-name',
        character: saved,
        fieldPath: 'name',
        targetId: 'name',
        value: CharacterSyncValueData(stringValue: 'First'),
      );
      final second = _setFieldOperation(
        id: 'second-name',
        character: saved,
        fieldPath: 'name',
        targetId: 'name',
        value: CharacterSyncValueData(stringValue: 'Second'),
      );

      await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(operations: [first]),
      );
      final response = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(operations: [second]),
      );

      expect(response.acknowledgedChangeIds, isNot(contains('second-name')));
      expect(response.rejectedChanges, hasLength(1));
      expect(response.rejectedChanges?.single.reason, 'target_conflict');
      expect(response.rejectedChanges?.single.character?.name, 'First');
    });

    test(
        'operation sync accepts stale character revision for independent target',
        () async {
      final ownerSession = authenticatedSession(205);
      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'Base', currentHp: 10),
      );

      await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            _setFieldOperation(
              id: 'name-change',
              character: saved,
              fieldPath: 'name',
              targetId: 'name',
              value: CharacterSyncValueData(stringValue: 'Changed'),
            ),
          ],
        ),
      );
      final response = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            _setFieldOperation(
              id: 'hp-change',
              character: saved,
              fieldPath: 'currentHp',
              targetId: 'currentHp',
              value: CharacterSyncValueData(intValue: 9),
            ),
          ],
        ),
      );

      expect(response.acknowledgedChangeIds, contains('hp-change'));
      final current = await endpoints.characterData.getCharacter(
        ownerSession,
        saved.id!,
      );
      expect(current.name, 'Changed');
      expect(current.currentHp, 9);
    });

    test('operation sync ignores invalid untouched legacy fields', () async {
      final ownerSession = authenticatedSession(2060);
      final session = ownerSession.build();
      final now = DateTime.now().toUtc();
      final legacyName = List.filled(491, 'x').join();
      late CharacterRecord record;
      try {
        record = await CharacterRecord.db.insertRow(
          session,
          CharacterRecord(
            name: legacyName,
            currentHp: 10,
            version: 1,
            createdAt: now,
            updatedAt: now,
            userId: 2060,
          ),
        );
      } finally {
        await session.close();
      }
      final current = await endpoints.characterData.getCharacter(
        ownerSession,
        record.id!,
      );

      final response = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            _setFieldOperation(
              id: 'legacy-name-independent-hp',
              character: current,
              fieldPath: 'currentHp',
              targetId: 'currentHp',
              value: CharacterSyncValueData(intValue: 9),
            ),
          ],
        ),
      );

      expect(
        response.acknowledgedChangeIds,
        contains('legacy-name-independent-hp'),
      );
      expect(response.rejectedChanges, isEmpty);
      final saved = await endpoints.characterData.getCharacter(
        ownerSession,
        record.id!,
      );
      expect(saved.name, legacyName);
      expect(saved.currentHp, 9);
    });

    test('legacy snapshot ignores invalid untouched stored fields', () async {
      final ownerSession = authenticatedSession(2062);
      final session = ownerSession.build();
      final now = DateTime.now().toUtc();
      final legacyName = List.filled(491, 'x').join();
      late CharacterRecord record;
      try {
        record = await CharacterRecord.db.insertRow(
          session,
          CharacterRecord(
            name: legacyName,
            currentHp: 10,
            version: 1,
            createdAt: now,
            updatedAt: now,
            userId: 2062,
          ),
        );
      } finally {
        await session.close();
      }
      final current = await endpoints.characterData.getCharacter(
        ownerSession,
        record.id!,
      );

      final response = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          changes: [
            CharacterChangeData(
              id: 'legacy-snapshot-independent-hp',
              changeType: CharacterChangeType.upsert,
              entityType: CharacterEntityType.character,
              entityId: record.id!.toString(),
              payload: current.copyWith(currentHp: 9),
              createdAt: now,
              baseUpdatedAt: current.updatedAt,
            ),
          ],
        ),
      );

      expect(
        response.acknowledgedChangeIds,
        contains('legacy-snapshot-independent-hp'),
      );
      expect(response.rejectedChanges, isEmpty);
      final saved = await endpoints.characterData.getCharacter(
        ownerSession,
        record.id!,
      );
      expect(saved.name, legacyName);
      expect(saved.currentHp, 9);
    });

    test('legacy snapshot still validates changed fields', () async {
      final ownerSession = authenticatedSession(2063);
      final invalidName = List.filled(491, 'x').join();
      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'Valid'),
      );

      final response = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          changes: [
            CharacterChangeData(
              id: 'legacy-snapshot-invalid-name',
              changeType: CharacterChangeType.upsert,
              entityType: CharacterEntityType.character,
              entityId: saved.id!.toString(),
              payload: saved.copyWith(name: invalidName),
              createdAt: DateTime.now().toUtc(),
              baseUpdatedAt: saved.updatedAt,
            ),
          ],
        ),
      );

      expect(response.acknowledgedChangeIds, isEmpty);
      expect(response.rejectedChanges, hasLength(1));
      expect(response.rejectedChanges?.single.reason, 'invalid_change');
      expect(
          response.rejectedChanges?.single.message, contains('characterName'));
      final current = await endpoints.characterData.getCharacter(
        ownerSession,
        saved.id!,
      );
      expect(current.name, 'Valid');
    });

    test('operation sync still validates the changed target', () async {
      final ownerSession = authenticatedSession(2061);
      final invalidName = List.filled(491, 'x').join();
      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'Valid'),
      );

      final response = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            _setFieldOperation(
              id: 'invalid-name-target',
              character: saved,
              fieldPath: 'name',
              targetId: 'name',
              value: CharacterSyncValueData(stringValue: invalidName),
            ),
          ],
        ),
      );

      expect(response.acknowledgedChangeIds, isEmpty);
      expect(response.rejectedChanges, hasLength(1));
      expect(response.rejectedChanges?.single.reason, 'invalid_operation');
      expect(
          response.rejectedChanges?.single.message, contains('characterName'));
    });

    test('operation sync acknowledges duplicate change id once applied',
        () async {
      final ownerSession = authenticatedSession(206);
      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'Base'),
      );
      final operation = _setFieldOperation(
        id: 'same-change',
        character: saved,
        fieldPath: 'name',
        targetId: 'name',
        value: CharacterSyncValueData(stringValue: 'Once'),
      );

      await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(operations: [operation]),
      );
      final response = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(operations: [operation]),
      );

      expect(response.acknowledgedChangeIds, contains('same-change'));
      expect(response.changedCharacters?['same-change']?.name, 'Once');
      final current = await endpoints.characterData.getCharacter(
        ownerSession,
        saved.id!,
      );
      expect(current.name, 'Once');
      expect(current.version, 2);
    });

    test('operation sync creates offline character and returns change mapping',
        () async {
      final ownerSession = authenticatedSession(207);

      final response = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            CharacterSyncOperationData(
              id: 'create-local',
              localCharacterId: -1,
              type: CharacterSyncOperationType.createCharacter,
              targetType: CharacterSyncTargetType.character,
              targetId: '-1',
              itemPayload: CharacterSyncValueData(
                characterValue: CharacterData(id: -1, name: 'Offline'),
              ),
              createdAt: DateTime.utc(2026, 4, 24),
            ),
          ],
        ),
      );

      final created = response.changedCharacters?['create-local'];
      expect(response.acknowledgedChangeIds, contains('create-local'));
      expect(created?.id, isPositive);
      expect(created?.name, 'Offline');
      expect(created?.syncTargetRevisions, isNotEmpty);
    });

    test('operation sync duplicate create id does not clone character',
        () async {
      final ownerSession = authenticatedSession(307);
      final operation = CharacterSyncOperationData(
        id: 'create-local-once',
        localCharacterId: -1,
        type: CharacterSyncOperationType.createCharacter,
        targetType: CharacterSyncTargetType.character,
        targetId: '-1',
        itemPayload: CharacterSyncValueData(
          characterValue: CharacterData(id: -1, name: 'Offline once'),
        ),
        createdAt: DateTime.utc(2026, 4, 24),
      );

      final first = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(operations: [operation]),
      );
      final second = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(operations: [operation]),
      );

      expect(first.acknowledgedChangeIds, contains(operation.id));
      expect(second.acknowledgedChangeIds, contains(operation.id));
      expect(second.changedCharacters?[operation.id]?.id,
          first.changedCharacters?[operation.id]?.id);
      final all = await endpoints.characterData.getAll(ownerSession);
      expect(all.where((character) => character.name == 'Offline once'),
          hasLength(1));
    });

    test('cursor pull returns changes after cursor even on timestamp boundary',
        () async {
      final ownerSession = authenticatedSession(308);
      final sameTimestamp = DateTime.utc(2026, 4, 24, 3);

      final first = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(
          name: 'First boundary',
          createdAt: sameTimestamp,
          updatedAt: sameTimestamp,
        ),
      );
      final initialPull = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(pullAfterEventId: 0),
      );

      final second = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(
          name: 'Second boundary',
          createdAt: sameTimestamp,
          updatedAt: sameTimestamp,
        ),
      );
      final nextPull = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(pullAfterEventId: initialPull.pullCursor),
      );

      expect(initialPull.characters?.map((character) => character.id),
          contains(first.id));
      expect(nextPull.characters?.map((character) => character.id),
          contains(second.id));
      expect(nextPull.characters?.map((character) => character.id),
          isNot(contains(first.id)));
      expect(nextPull.pullCursor, greaterThan(initialPull.pullCursor ?? 0));
    });

    test('cursor pull returns remote create update and delete', () async {
      final ownerSession = authenticatedSession(309);

      final emptyPull = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(pullAfterEventId: 0),
      );
      final created = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'Remote create'),
      );
      final createPull = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(pullAfterEventId: emptyPull.pullCursor ?? 0),
      );

      final updated = await endpoints.characterData.saveCharacter(
        ownerSession,
        created.copyWith(name: 'Remote update'),
      );
      final updatePull = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(pullAfterEventId: createPull.pullCursor),
      );

      await endpoints.characterData.delete(ownerSession, updated.id!);
      final deletePull = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(pullAfterEventId: updatePull.pullCursor),
      );

      expect(createPull.characters?.single.id, created.id);
      expect(createPull.characters?.single.name, 'Remote create');
      expect(updatePull.characters?.single.id, created.id);
      expect(updatePull.characters?.single.name, 'Remote update');
      expect(deletePull.characters, isEmpty);
      expect(deletePull.deletedCharacterIds, contains(created.id));
    });

    test('authoritative full resync returns current state and cursor',
        () async {
      final ownerSession = authenticatedSession(311);
      final retained = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'Retained'),
      );
      final removed = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'Removed'),
      );
      await endpoints.characterData.delete(ownerSession, removed.id!);

      final full = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          fullResync: true,
          pullAfterEventId: 999999999,
        ),
      );

      expect(full.capabilities, contains('authoritative_full_resync'));
      expect(full.characters?.map((character) => character.id), [retained.id]);
      expect(full.deletedCharacterIds, isEmpty);
      expect(full.pullCursor, isNotNull);

      final createdAfter = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'After full resync'),
      );
      final delta = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(pullAfterEventId: full.pullCursor),
      );
      expect(
        delta.characters?.map((character) => character.id),
        contains(createdAfter.id),
      );
      expect(delta.pullCursor, greaterThan(full.pullCursor ?? 0));
    });

    test('stale operation does not resurrect deleted character', () async {
      final ownerSession = authenticatedSession(310);
      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'Delete before stale update'),
      );
      await endpoints.characterData.delete(ownerSession, saved.id!);

      final response = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            _setFieldOperation(
              id: 'stale-update-deleted',
              character: saved,
              fieldPath: 'name',
              targetId: 'name',
              value: CharacterSyncValueData(stringValue: 'Resurrected'),
            ),
          ],
        ),
      );

      expect(response.rejectedChanges, hasLength(1));
      expect(response.rejectedChanges?.single.reason, 'not_found');
      final all = await endpoints.characterData.getAll(ownerSession);
      expect(all, isEmpty);
    });

    test('operation sync keeps stale delete protection', () async {
      final ownerSession = authenticatedSession(208);
      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'Delete me'),
      );
      await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            _setFieldOperation(
              id: 'touch',
              character: saved,
              fieldPath: 'name',
              targetId: 'name',
              value: CharacterSyncValueData(stringValue: 'Touched'),
            ),
          ],
        ),
      );

      final response = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            CharacterSyncOperationData(
              id: 'delete-stale',
              characterId: saved.id,
              localCharacterId: saved.id,
              type: CharacterSyncOperationType.deleteCharacter,
              targetType: CharacterSyncTargetType.character,
              targetId: saved.id.toString(),
              baseCharacterRevision: saved.version,
              baseTargetRevision: saved.version,
              createdAt: DateTime.utc(2026, 4, 24),
            ),
          ],
        ),
      );

      expect(response.rejectedChanges, hasLength(1));
      expect(response.rejectedChanges?.single.reason, 'stale_delete');
      expect(response.rejectedChanges?.single.character?.name, 'Touched');
    });

    test('legacy snapshot change updates target revision for v2 conflicts',
        () async {
      final ownerSession = authenticatedSession(209);
      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'Before', currentHp: 10),
      );
      final baseNameRevision = saved.syncTargetRevisions?['field:name'];

      await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          changes: [
            CharacterChangeData(
              id: 'legacy-name',
              changeType: CharacterChangeType.upsert,
              entityType: CharacterEntityType.character,
              entityId: saved.id!.toString(),
              payload: saved.copyWith(
                name: 'Legacy',
                updatedAt: _afterSaved(saved),
              ),
              createdAt: DateTime.utc(2026, 4, 24, 2),
            ),
          ],
        ),
      );

      final current = await endpoints.characterData.getCharacter(
        ownerSession,
        saved.id!,
      );
      expect(current.name, 'Legacy');
      expect(
          current.syncTargetRevisions?['field:name'], isNot(baseNameRevision));

      final response = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            _setFieldOperation(
              id: 'stale-v2-name',
              character: saved,
              fieldPath: 'name',
              targetId: 'name',
              value: CharacterSyncValueData(stringValue: 'V2'),
            ),
          ],
        ),
      );

      expect(response.rejectedChanges, hasLength(1));
      expect(response.rejectedChanges?.single.reason, 'target_conflict');
    });

    test('legacy snapshot change preserves independent v2 target apply',
        () async {
      final ownerSession = authenticatedSession(210);
      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'Before', currentHp: 10),
      );

      await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          changes: [
            CharacterChangeData(
              id: 'legacy-name-independent',
              changeType: CharacterChangeType.upsert,
              entityType: CharacterEntityType.character,
              entityId: saved.id!.toString(),
              payload: saved.copyWith(
                name: 'Legacy',
                updatedAt: _afterSaved(saved),
              ),
              createdAt: DateTime.utc(2026, 4, 24, 2),
            ),
          ],
        ),
      );

      final response = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            _setFieldOperation(
              id: 'v2-hp-after-legacy',
              character: saved,
              fieldPath: 'currentHp',
              targetId: 'currentHp',
              value: CharacterSyncValueData(intValue: 8),
            ),
          ],
        ),
      );

      expect(response.acknowledgedChangeIds, contains('v2-hp-after-legacy'));
      final current = await endpoints.characterData.getCharacter(
        ownerSession,
        saved.id!,
      );
      expect(current.name, 'Legacy');
      expect(current.currentHp, 8);
    });

    test(
        'removed list item leaves tombstone revision that rejects stale upsert',
        () async {
      final ownerSession = authenticatedSession(211);
      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(
          name: 'Tombstone',
          notes: [CharacterNoteData(id: 'note-a', text: 'A')],
        ),
      );
      final baseRevision = saved.syncTargetRevisions?['item:notes:note-a'];

      await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            _removeItemOperation(
              id: 'delete-note-a',
              character: saved,
              fieldPath: 'notes',
              targetId: 'note-a',
            ),
          ],
        ),
      );

      final deleted = await endpoints.characterData.getCharacter(
        ownerSession,
        saved.id!,
      );
      expect(deleted.notes, isNull);
      expect(deleted.syncTargetRevisions?['item:notes:note-a'],
          isNot(baseRevision));

      final stale = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            _upsertItemOperation(
              id: 'stale-note-a',
              character: saved,
              fieldPath: 'notes',
              targetId: 'note-a',
              payload: CharacterSyncValueData(
                noteValue: CharacterNoteData(id: 'note-a', text: 'Stale'),
              ),
            ),
          ],
        ),
      );

      expect(stale.rejectedChanges, hasLength(1));
      expect(stale.rejectedChanges?.single.reason, 'target_conflict');

      final fresh = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            _upsertItemOperation(
              id: 'fresh-note-a',
              character: deleted,
              fieldPath: 'notes',
              targetId: 'note-a',
              payload: CharacterSyncValueData(
                noteValue: CharacterNoteData(id: 'note-a', text: 'Fresh'),
              ),
            ),
          ],
        ),
      );

      expect(fresh.acknowledgedChangeIds, contains('fresh-note-a'));
      final restored = await endpoints.characterData.getCharacter(
        ownerSession,
        saved.id!,
      );
      expect(restored.notes?.single.text, 'Fresh');
    });

    test('removed map entry leaves tombstone revision for stale setMapEntry',
        () async {
      final ownerSession = authenticatedSession(212);
      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(
          name: 'Map Tombstone',
          customAbilityBonuses: const {'strength': 1},
        ),
      );
      final baseRevision =
          saved.syncTargetRevisions?['map:customAbilityBonuses:strength'];

      await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            _removeMapEntryOperation(
              id: 'remove-strength',
              character: saved,
              fieldPath: 'customAbilityBonuses',
              targetId: 'strength',
            ),
          ],
        ),
      );

      final removed = await endpoints.characterData.getCharacter(
        ownerSession,
        saved.id!,
      );
      expect(removed.customAbilityBonuses, isNull);
      expect(removed.syncTargetRevisions?['map:customAbilityBonuses:strength'],
          isNot(baseRevision));

      final stale = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            _setMapEntryOperation(
              id: 'stale-strength',
              character: saved,
              fieldPath: 'customAbilityBonuses',
              targetId: 'strength',
              value: 2,
            ),
          ],
        ),
      );

      expect(stale.rejectedChanges, hasLength(1));
      expect(stale.rejectedChanges?.single.reason, 'target_conflict');

      final fresh = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            _setMapEntryOperation(
              id: 'fresh-strength',
              character: removed,
              fieldPath: 'customAbilityBonuses',
              targetId: 'strength',
              value: 3,
            ),
          ],
        ),
      );

      expect(fresh.acknowledgedChangeIds, contains('fresh-strength'));
      final restored = await endpoints.characterData.getCharacter(
        ownerSession,
        saved.id!,
      );
      expect(restored.customAbilityBonuses?['strength'], 3);
    });

    test(
        'removed starting equipment resolution leaves tombstone revision '
        'for stale upsert', () async {
      final ownerSession = authenticatedSession(213);
      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(
          name: 'Nested Tombstone',
          startingEquipmentSelections: [
            CharacterStartingEquipmentSelectionData(
              id: 'selection-a',
              sourceType: ChoiceSourceType.classData,
              sourceId: 1,
              isSelected: true,
              selectionIndex: 0,
              resolutions: [
                CharacterStartingEquipmentResolutionData(
                  id: 'resolution-a',
                  catalogType: EquipmentCatalogType.item,
                  referenceKey: 'rope',
                  quantity: 1,
                ),
              ],
            ),
          ],
        ),
      );
      const targetKey =
          'item:startingEquipmentSelections:selection-a:resolution:resolution-a';
      final baseRevision = saved.syncTargetRevisions?[targetKey];

      await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            _removeStartingEquipmentResolutionOperation(
              id: 'delete-resolution-a',
              character: saved,
              selectionId: 'selection-a',
              resolutionId: 'resolution-a',
            ),
          ],
        ),
      );

      final deleted = await endpoints.characterData.getCharacter(
        ownerSession,
        saved.id!,
      );
      expect(
        deleted.startingEquipmentSelections?.single.resolutions,
        isEmpty,
      );
      expect(deleted.syncTargetRevisions?[targetKey], isNot(baseRevision));

      final stale = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            _upsertStartingEquipmentResolutionOperation(
              id: 'stale-resolution-a',
              character: saved,
              selectionId: 'selection-a',
              resolutionId: 'resolution-a',
              payload: CharacterStartingEquipmentResolutionData(
                id: 'resolution-a',
                catalogType: EquipmentCatalogType.item,
                referenceKey: 'stale-rope',
                quantity: 2,
              ),
            ),
          ],
        ),
      );

      expect(stale.rejectedChanges, hasLength(1));
      expect(stale.rejectedChanges?.single.reason, 'target_conflict');

      final fresh = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          operations: [
            _upsertStartingEquipmentResolutionOperation(
              id: 'fresh-resolution-a',
              character: deleted,
              selectionId: 'selection-a',
              resolutionId: 'resolution-a',
              payload: CharacterStartingEquipmentResolutionData(
                id: 'resolution-a',
                catalogType: EquipmentCatalogType.item,
                referenceKey: 'fresh-rope',
                quantity: 3,
              ),
            ),
          ],
        ),
      );

      expect(fresh.acknowledgedChangeIds, contains('fresh-resolution-a'));
      final restored = await endpoints.characterData.getCharacter(
        ownerSession,
        saved.id!,
      );
      expect(
        restored.startingEquipmentSelections?.single.resolutions?.single
            .referenceKey,
        'fresh-rope',
      );
    });
  });

  withServerpod(
    'Character sync concurrency',
    (sessionBuilder, endpoints) {
      setUp(CharacterSaveRateLimiter.resetForTests);

      TestSessionBuilder authenticatedSession(int userId) {
        return sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            userId,
            <Scope>{},
          ),
        );
      }

      test('parallel independent operations keep both target changes',
          () async {
        final userId = 900000 + DateTime.now().microsecondsSinceEpoch % 100000;
        final ownerSession = authenticatedSession(userId);

        for (var attempt = 0; attempt < 5; attempt++) {
          CharacterSaveRateLimiter.resetForTests();
          final saved = await endpoints.characterData.saveCharacter(
            ownerSession,
            CharacterData(
              name: 'Concurrent $attempt',
              currentHp: 10,
              notes: [CharacterNoteData(id: 'note-a', text: 'A')],
            ),
          );
          final hp = _setFieldOperation(
            id: 'concurrent-hp-$attempt',
            character: saved,
            fieldPath: 'currentHp',
            targetId: 'currentHp',
            value: CharacterSyncValueData(intValue: 7),
          );
          final note = _upsertItemOperation(
            id: 'concurrent-note-$attempt',
            character: saved,
            fieldPath: 'notes',
            targetId: 'note-a',
            payload: CharacterSyncValueData(
              noteValue: CharacterNoteData(id: 'note-a', text: 'A+'),
            ),
          );

          CharacterSaveRateLimiter.resetForTests();
          final responses = await Future.wait([
            endpoints.characterData.syncCharacters(
              ownerSession,
              CharacterSyncRequest(operations: [hp]),
            ),
            endpoints.characterData.syncCharacters(
              ownerSession,
              CharacterSyncRequest(operations: [note]),
            ),
          ]);

          expect(responses.expand((r) => r.acknowledgedChangeIds ?? const []),
              containsAll([hp.id, note.id]));
          expect(
              responses.expand((r) => r.rejectedChanges ?? const []), isEmpty);

          final current = await endpoints.characterData.getCharacter(
            ownerSession,
            saved.id!,
          );
          expect(current.currentHp, 7);
          expect(current.notes?.single.text, 'A+');
          expect(current.version, (saved.version ?? 0) + 2);
          expect(current.syncTargetRevisions?['field:currentHp'],
              greaterThan(saved.version ?? 0));
          expect(current.syncTargetRevisions?['item:notes:note-a'],
              greaterThan(saved.version ?? 0));
        }
      });

      test('parallel same-target operations acknowledge one and reject one',
          () async {
        final userId = 910000 + DateTime.now().microsecondsSinceEpoch % 100000;
        final ownerSession = authenticatedSession(userId);
        final saved = await endpoints.characterData.saveCharacter(
          ownerSession,
          CharacterData(name: 'Base'),
        );
        final first = _setFieldOperation(
          id: 'same-target-a',
          character: saved,
          fieldPath: 'name',
          targetId: 'name',
          value: CharacterSyncValueData(stringValue: 'A'),
        );
        final second = _setFieldOperation(
          id: 'same-target-b',
          character: saved,
          fieldPath: 'name',
          targetId: 'name',
          value: CharacterSyncValueData(stringValue: 'B'),
        );

        final responses = await Future.wait([
          endpoints.characterData.syncCharacters(
            ownerSession,
            CharacterSyncRequest(operations: [first]),
          ),
          endpoints.characterData.syncCharacters(
            ownerSession,
            CharacterSyncRequest(operations: [second]),
          ),
        ]);

        expect(
          responses
              .expand((response) => response.acknowledgedChangeIds ?? const [])
              .length,
          1,
        );
        expect(
          responses
              .expand((response) => response.rejectedChanges ?? const [])
              .single
              .reason,
          'target_conflict',
        );
      });

      test('full resync cursor cannot hide a concurrent mutation', () async {
        final userId = 920000 + DateTime.now().microsecondsSinceEpoch % 100000;
        final ownerSession = authenticatedSession(userId);
        await endpoints.characterData.saveCharacter(
          ownerSession,
          CharacterData(name: 'Baseline'),
        );

        for (var attempt = 0; attempt < 5; attempt++) {
          CharacterSaveRateLimiter.resetForTests();
          final results = await Future.wait<Object>([
            endpoints.characterData.syncCharacters(
              ownerSession,
              CharacterSyncRequest(fullResync: true),
            ),
            endpoints.characterData.saveCharacter(
              ownerSession,
              CharacterData(name: 'Concurrent full $attempt'),
            ),
          ]);
          final full = results[0] as CharacterSyncResponse;
          final saved = results[1] as CharacterData;
          final included = full.characters?.any(
                (character) => character.id == saved.id,
              ) ??
              false;
          if (included) continue;

          final delta = await endpoints.characterData.syncCharacters(
            ownerSession,
            CharacterSyncRequest(pullAfterEventId: full.pullCursor),
          );
          expect(
            delta.characters?.map((character) => character.id),
            contains(saved.id),
          );
          expect(delta.pullCursor, greaterThan(full.pullCursor ?? 0));
        }
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}

DateTime _afterSaved(CharacterData character) {
  return (character.updatedAt ?? DateTime.utc(2026, 4, 24))
      .toUtc()
      .add(const Duration(seconds: 1));
}

CharacterSyncOperationData _setFieldOperation({
  required String id,
  required CharacterData character,
  required String fieldPath,
  required String targetId,
  required CharacterSyncValueData value,
}) {
  final targetKey = 'field:$targetId';
  return CharacterSyncOperationData(
    id: id,
    characterId: character.id,
    localCharacterId: character.id,
    type: CharacterSyncOperationType.setField,
    targetType: CharacterSyncTargetType.field,
    targetId: targetId,
    fieldPath: fieldPath,
    value: value,
    baseCharacterRevision: character.version,
    baseTargetRevision:
        character.syncTargetRevisions?[targetKey] ?? character.version,
    createdAt: DateTime.utc(2026, 4, 24),
  );
}

CharacterSyncOperationData _upsertItemOperation({
  required String id,
  required CharacterData character,
  required String fieldPath,
  required String targetId,
  required CharacterSyncValueData payload,
}) {
  final targetKey = 'item:$fieldPath:$targetId';
  return CharacterSyncOperationData(
    id: id,
    characterId: character.id,
    localCharacterId: character.id,
    type: CharacterSyncOperationType.upsertListItem,
    targetType: CharacterSyncTargetType.listItem,
    targetId: targetId,
    fieldPath: fieldPath,
    itemPayload: payload,
    baseCharacterRevision: character.version,
    baseTargetRevision:
        character.syncTargetRevisions?[targetKey] ?? character.version,
    createdAt: DateTime.utc(2026, 4, 24),
  );
}

CharacterSyncOperationData _removeItemOperation({
  required String id,
  required CharacterData character,
  required String fieldPath,
  required String targetId,
}) {
  final targetKey = 'item:$fieldPath:$targetId';
  return CharacterSyncOperationData(
    id: id,
    characterId: character.id,
    localCharacterId: character.id,
    type: CharacterSyncOperationType.removeListItem,
    targetType: CharacterSyncTargetType.listItem,
    targetId: targetId,
    fieldPath: fieldPath,
    baseCharacterRevision: character.version,
    baseTargetRevision:
        character.syncTargetRevisions?[targetKey] ?? character.version,
    createdAt: DateTime.utc(2026, 4, 24),
  );
}

CharacterSyncOperationData _setMapEntryOperation({
  required String id,
  required CharacterData character,
  required String fieldPath,
  required String targetId,
  required int value,
}) {
  final targetKey = 'map:$fieldPath:$targetId';
  return CharacterSyncOperationData(
    id: id,
    characterId: character.id,
    localCharacterId: character.id,
    type: CharacterSyncOperationType.setMapEntry,
    targetType: CharacterSyncTargetType.mapEntry,
    targetId: targetId,
    fieldPath: fieldPath,
    value: CharacterSyncValueData(intValue: value),
    baseCharacterRevision: character.version,
    baseTargetRevision:
        character.syncTargetRevisions?[targetKey] ?? character.version,
    createdAt: DateTime.utc(2026, 4, 24),
  );
}

CharacterSyncOperationData _removeMapEntryOperation({
  required String id,
  required CharacterData character,
  required String fieldPath,
  required String targetId,
}) {
  final targetKey = 'map:$fieldPath:$targetId';
  return CharacterSyncOperationData(
    id: id,
    characterId: character.id,
    localCharacterId: character.id,
    type: CharacterSyncOperationType.removeMapEntry,
    targetType: CharacterSyncTargetType.mapEntry,
    targetId: targetId,
    fieldPath: fieldPath,
    baseCharacterRevision: character.version,
    baseTargetRevision:
        character.syncTargetRevisions?[targetKey] ?? character.version,
    createdAt: DateTime.utc(2026, 4, 24),
  );
}

CharacterSyncOperationData _upsertStartingEquipmentResolutionOperation({
  required String id,
  required CharacterData character,
  required String selectionId,
  required String resolutionId,
  required CharacterStartingEquipmentResolutionData payload,
}) {
  final targetKey =
      'item:startingEquipmentSelections:$selectionId:resolution:$resolutionId';
  return CharacterSyncOperationData(
    id: id,
    characterId: character.id,
    localCharacterId: character.id,
    type: CharacterSyncOperationType.upsertListItem,
    targetType: CharacterSyncTargetType.startingEquipmentResolution,
    targetId: '$selectionId:$resolutionId',
    fieldPath: 'startingEquipmentSelections',
    itemPayload: CharacterSyncValueData(
      startingEquipmentResolutionValue: payload,
    ),
    baseCharacterRevision: character.version,
    baseTargetRevision:
        character.syncTargetRevisions?[targetKey] ?? character.version,
    createdAt: DateTime.utc(2026, 4, 24),
  );
}

CharacterSyncOperationData _removeStartingEquipmentResolutionOperation({
  required String id,
  required CharacterData character,
  required String selectionId,
  required String resolutionId,
}) {
  final targetKey =
      'item:startingEquipmentSelections:$selectionId:resolution:$resolutionId';
  return CharacterSyncOperationData(
    id: id,
    characterId: character.id,
    localCharacterId: character.id,
    type: CharacterSyncOperationType.removeListItem,
    targetType: CharacterSyncTargetType.startingEquipmentResolution,
    targetId: '$selectionId:$resolutionId',
    fieldPath: 'startingEquipmentSelections',
    baseCharacterRevision: character.version,
    baseTargetRevision:
        character.syncTargetRevisions?[targetKey] ?? character.version,
    createdAt: DateTime.utc(2026, 4, 24),
  );
}
