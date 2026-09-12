import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_sync_operations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var nextId = 0;

  setUp(() {
    nextId = 0;
  });

  String changeId() => 'change-${nextId++}';

  test('independent scalar changes produce separate targets', () {
    final operations = buildCharacterSyncOperations(
      previous: CharacterData(
        id: 42,
        name: 'Old',
        currentHp: 5,
        version: 7,
        syncTargetRevisions: {
          'field:name': 2,
          'field:currentHp': 3,
        },
      ),
      next: CharacterData(id: 42, name: 'New', currentHp: 4, version: 7),
      localId: 42,
      serverId: 42,
      createdAt: DateTime.utc(2026, 4, 24),
      nextChangeId: changeId,
    );

    expect(operations, hasLength(2));
    expect(
      operations.map(characterSyncOperationTargetKey),
      containsAll(['field:name', 'field:currentHp']),
    );
    expect(
      operations
          .singleWhere((operation) => operation.fieldPath == 'name')
          .baseTargetRevision,
      2,
    );
    expect(
      operations
          .singleWhere((operation) => operation.fieldPath == 'currentHp')
          .baseTargetRevision,
      3,
    );
  });

  test('same field keeps the last set operation during coalescing', () {
    final first = CharacterSyncOperationData(
      id: 'first',
      characterId: 42,
      localCharacterId: 42,
      type: CharacterSyncOperationType.setField,
      targetType: CharacterSyncTargetType.field,
      targetId: 'name',
      fieldPath: 'name',
      value: CharacterSyncValueData(stringValue: 'First'),
      createdAt: DateTime.utc(2026, 4, 24),
    );
    final second = first.copyWith(
      id: 'second',
      value: CharacterSyncValueData(stringValue: 'Second'),
    );

    final coalesced = coalesceCharacterSyncOperations([first, second]);

    expect(coalesced, hasLength(1));
    expect(coalesced.single.id, 'second');
    expect(coalesced.single.value?.stringValue, 'Second');
  });

  test('different note equipment and attack ids do not collide', () {
    final operations = buildCharacterSyncOperations(
      previous: CharacterData(id: 42, version: 1),
      next: CharacterData(
        id: 42,
        version: 1,
        notes: [CharacterNoteData(id: 'note-1', text: 'Note')],
        equipment: [
          CharacterInventoryItemData(
            id: 'item-1',
            name: 'Rope',
            quantity: 1,
            type: CharacterInventoryItemType.custom,
          ),
        ],
        attacks: [CharacterAttackData(id: 'attack-1', name: 'Slash')],
      ),
      localId: 42,
      serverId: 42,
      createdAt: DateTime.utc(2026, 4, 24),
      nextChangeId: changeId,
    );

    expect(
      operations.map(characterSyncOperationTargetKey),
      containsAll([
        'item:notes:note-1',
        'item:equipment:item-1',
        'item:attacks:attack-1',
      ]),
    );
  });

  test('offline-created character builds one create snapshot operation', () {
    final operations = buildCharacterSyncOperations(
      previous: CharacterData(id: -1, name: 'Draft'),
      next: CharacterData(id: -1, name: 'Final'),
      localId: -1,
      serverId: null,
      createdAt: DateTime.utc(2026, 4, 24),
      nextChangeId: changeId,
    );

    expect(operations, hasLength(1));
    expect(operations.single.type, CharacterSyncOperationType.createCharacter);
    expect(operations.single.itemPayload?.characterValue?.name, 'Final');
  });

  test('delete operation drops earlier pending operations for character', () {
    final setName = CharacterSyncOperationData(
      id: 'set-name',
      characterId: 42,
      localCharacterId: 42,
      type: CharacterSyncOperationType.setField,
      targetType: CharacterSyncTargetType.field,
      targetId: 'name',
      fieldPath: 'name',
      value: CharacterSyncValueData(stringValue: 'Name'),
      createdAt: DateTime.utc(2026, 4, 24),
    );
    final delete = CharacterSyncOperationData(
      id: 'delete',
      characterId: 42,
      localCharacterId: 42,
      type: CharacterSyncOperationType.deleteCharacter,
      targetType: CharacterSyncTargetType.character,
      targetId: '42',
      createdAt: DateTime.utc(2026, 4, 24),
    );

    final coalesced = coalesceCharacterSyncOperations([setName, delete]);

    expect(coalesced, hasLength(1));
    expect(coalesced.single.type, CharacterSyncOperationType.deleteCharacter);
  });
}
