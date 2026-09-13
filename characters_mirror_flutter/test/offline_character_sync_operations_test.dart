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

  test('equipment diff handles generated enum values on the character', () {
    final previous = CharacterData(
      id: 42,
      version: 1,
      alignmentValue: CharacterAlignment.lawfulGood,
      displayedSpeedKind: CharacterSpeedKind.walking,
      equipment: [
        CharacterInventoryItemData(
          id: 'item-1',
          name: 'Rope',
          quantity: 1,
          type: CharacterInventoryItemType.custom,
        ),
      ],
    );

    final operations = buildCharacterSyncOperations(
      previous: previous,
      next: previous.copyWith(
        equipment: [
          CharacterInventoryItemData(
            id: 'item-1',
            name: 'Rope and torch',
            quantity: 1,
            type: CharacterInventoryItemType.custom,
          ),
        ],
      ),
      localId: 42,
      serverId: 42,
      createdAt: DateTime.utc(2026, 9, 13),
      nextChangeId: changeId,
    );

    expect(operations, hasLength(1));
    expect(operations.single.fieldPath, 'equipment');
    expect(
        operations.single.itemPayload?.equipmentValue?.name, 'Rope and torch');
  });

  test('reordering list items does not enqueue delete and recreate operations',
      () {
    final operations = buildCharacterSyncOperations(
      previous: CharacterData(
        id: 42,
        version: 1,
        notes: [
          CharacterNoteData(id: 'note-a', text: 'A'),
          CharacterNoteData(id: 'note-b', text: 'B'),
        ],
      ),
      next: CharacterData(
        id: 42,
        version: 1,
        notes: [
          CharacterNoteData(id: 'note-b', text: 'B'),
          CharacterNoteData(id: 'note-a', text: 'A'),
        ],
      ),
      localId: 42,
      serverId: 42,
      createdAt: DateTime.utc(2026, 4, 24),
      nextChangeId: changeId,
    );

    expect(operations, isEmpty);
  });

  test('updated item keeps the same target key after serialization', () {
    final operations = buildCharacterSyncOperations(
      previous: CharacterData(
        id: 42,
        version: 1,
        notes: [CharacterNoteData(id: 'note-a', text: 'A')],
      ),
      next: CharacterData(
        id: 42,
        version: 1,
        notes: [CharacterNoteData(id: 'note-a', text: 'A+')],
      ),
      localId: 42,
      serverId: 42,
      createdAt: DateTime.utc(2026, 4, 24),
      nextChangeId: changeId,
    );
    final decoded = CharacterSyncOperationData.fromJson(
      operations.single.toJson(),
    );

    expect(characterSyncOperationTargetKey(decoded), 'item:notes:note-a');
  });

  test('target keys escape separator characters in ids and map keys', () {
    final operations = buildCharacterSyncOperations(
      previous: CharacterData(
        id: 42,
        version: 1,
        customAbilityBonuses: const {'str:bonus': 1},
        resourceStates: [
          CharacterResourceStateData(
            sourceType: CharacterFeatureSourceType.classFeature,
            sourceId: 7,
            resourceKey: 'ki:pool',
            current: 1,
          ),
        ],
      ),
      next: CharacterData(
        id: 42,
        version: 1,
        customAbilityBonuses: const {'str:bonus': 2},
        resourceStates: [
          CharacterResourceStateData(
            sourceType: CharacterFeatureSourceType.classFeature,
            sourceId: 7,
            resourceKey: 'ki:pool',
            current: 0,
          ),
        ],
      ),
      localId: 42,
      serverId: 42,
      createdAt: DateTime.utc(2026, 4, 24),
      nextChangeId: changeId,
    );

    expect(
      operations.map(characterSyncOperationTargetKey),
      containsAll([
        'map:customAbilityBonuses:str%3Abonus',
        'resource:classFeature:7:ki%3Apool',
      ]),
    );
  });

  test('feature overrides without ids use stable source target ids', () {
    final operations = buildCharacterSyncOperations(
      previous: CharacterData(
        id: 42,
        version: 7,
        syncTargetRevisions: const {
          'item:featureOverrides:classFeature%3A7': 4,
        },
        featureOverrides: [
          CharacterFeatureOverrideData(
            sourceType: CharacterFeatureSourceType.classFeature,
            sourceId: 7,
            name: 'Custom',
          ),
        ],
      ),
      next: CharacterData(id: 42, version: 7),
      localId: 42,
      serverId: 42,
      createdAt: DateTime.utc(2026, 4, 24),
      nextChangeId: changeId,
    );

    expect(operations, hasLength(1));
    expect(operations.single.targetId, 'classFeature:7');
    expect(
      characterSyncOperationTargetKey(operations.single),
      'item:featureOverrides:classFeature%3A7',
    );
    expect(operations.single.baseTargetRevision, 4);
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
