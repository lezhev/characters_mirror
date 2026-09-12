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

      await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(operations: [noteA]),
      );
      await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(operations: [noteB]),
      );

      final current = await endpoints.characterData.getCharacter(
        ownerSession,
        saved.id!,
      );
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
      expect(current.equipment?.single.quantity, 2);
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
  });
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
