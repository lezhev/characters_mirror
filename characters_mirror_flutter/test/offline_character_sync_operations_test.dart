import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_operation_replay.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_sync_operations.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_target_keys.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var nextId = 0;

  setUp(() {
    nextId = 0;
  });

  String changeId() => 'change-${nextId++}';

  test('generic choice update survives sync payload serialization and replay',
      () {
    final previous = CharacterData(
      id: 42,
      version: 7,
      choices: [
        CharacterChoiceData(
          id: 'choice-a',
          groupKey: 'race_language_choice',
          optionKey: 'common',
          selectionIndex: 0,
        ),
      ],
    );
    final next = previous.copyWith(
      choices: [
        CharacterChoiceData(
          id: 'choice-a',
          groupKey: 'race_language_choice',
          optionKey: 'elvish',
          selectionIndex: 0,
        ),
      ],
    );

    final operations = buildCharacterSyncOperations(
      previous: previous,
      next: next,
      localId: 42,
      serverId: 42,
      createdAt: DateTime.utc(2026, 9, 26),
      nextChangeId: changeId,
    );

    expect(operations, hasLength(1));
    final decoded = CharacterSyncOperationData.fromJson(
      operations.single.toJson(),
    );
    expect(decoded.type, CharacterSyncOperationType.upsertListItem);
    expect(decoded.targetId, 'choice-a');
    expect(decoded.itemPayload?.choiceValue?.groupKey, 'race_language_choice');
    expect(decoded.itemPayload?.choiceValue?.optionKey, 'elvish');

    final replayed = replayCharacterSyncOperation(previous, decoded);
    expect(replayed.choices, hasLength(1));
    expect(replayed.choices!.single.id, 'choice-a');
    expect(replayed.choices!.single.groupKey, 'race_language_choice');
    expect(replayed.choices!.single.optionKey, 'elvish');
  });

  test('equipped armor set, replace, and clear survive sync replay', () {
    final leather = CharacterEquipmentSelectionData(
      referenceKey: 'leather_armor',
      name: 'Кожаный доспех',
    );
    final chain = CharacterEquipmentSelectionData(
      referenceKey: 'chain_mail',
      name: 'Кольчуга',
    );
    final empty = CharacterData(id: 42, version: 7);
    final setOperations = buildCharacterSyncOperations(
      previous: empty,
      next: empty.copyWith(equippedArmor: leather),
      localId: 42,
      serverId: 42,
      createdAt: DateTime.utc(2026, 9, 26),
      nextChangeId: changeId,
    );
    expect(setOperations, hasLength(1));
    expect(setOperations.single.fieldPath, 'equippedArmor');
    final setReplay = replayCharacterSyncOperation(
      empty,
      CharacterSyncOperationData.fromJson(setOperations.single.toJson()),
    );
    expect(setReplay.equippedArmor?.referenceKey, 'leather_armor');

    final replaceOperations = buildCharacterSyncOperations(
      previous: empty.copyWith(equippedArmor: leather),
      next: empty.copyWith(equippedArmor: chain),
      localId: 42,
      serverId: 42,
      createdAt: DateTime.utc(2026, 9, 26),
      nextChangeId: changeId,
    );
    expect(replaceOperations, hasLength(1));
    final replaceReplay = replayCharacterSyncOperation(
      empty.copyWith(equippedArmor: leather),
      CharacterSyncOperationData.fromJson(replaceOperations.single.toJson()),
    );
    expect(replaceReplay.equippedArmor?.referenceKey, 'chain_mail');

    final clearOperations = buildCharacterSyncOperations(
      previous: empty.copyWith(equippedArmor: chain),
      next: empty,
      localId: 42,
      serverId: 42,
      createdAt: DateTime.utc(2026, 9, 26),
      nextChangeId: changeId,
    );
    expect(clearOperations, hasLength(1));
    final clearReplay = replayCharacterSyncOperation(
      empty.copyWith(equippedArmor: chain),
      CharacterSyncOperationData.fromJson(clearOperations.single.toJson()),
    );
    expect(clearReplay.equippedArmor, isNull);
  });

  test('equipped shield is an independent sync target', () {
    final previous = CharacterData(id: 42, version: 7);
    final operations = buildCharacterSyncOperations(
      previous: previous,
      next: previous.copyWith(
        equippedShield: CharacterEquipmentSelectionData(
          referenceKey: 'shield',
          name: 'Щит',
        ),
      ),
      localId: 42,
      serverId: 42,
      createdAt: DateTime.utc(2026, 9, 26),
      nextChangeId: changeId,
    );

    expect(operations, hasLength(1));
    expect(operations.single.fieldPath, 'equippedShield');
    final replayed = replayCharacterSyncOperation(
      previous,
      CharacterSyncOperationData.fromJson(operations.single.toJson()),
    );
    expect(replayed.equippedShield?.referenceKey, 'shield');
  });

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

  test('semantic actions preserve their original sequence', () {
    final first = CharacterSyncOperationData(
      id: 'damage-1',
      characterId: 42,
      localCharacterId: 42,
      type: CharacterSyncOperationType.applyDamage,
      targetType: CharacterSyncTargetType.field,
      fieldPath: 'currentHp',
      value: CharacterSyncValueData(
        semanticActionValue: CharacterSemanticActionData(amount: 5),
      ),
      createdAt: DateTime.utc(2026, 9, 14, 10),
    );
    final second = first.copyWith(
      id: 'damage-2',
      value: CharacterSyncValueData(
        semanticActionValue: CharacterSemanticActionData(amount: 3),
      ),
      createdAt: DateTime.utc(2026, 9, 14, 11),
    );

    final coalesced = coalesceCharacterSyncOperations([first, second]);

    expect(coalesced.map((operation) => operation.id), [
      'damage-1',
      'damage-2',
    ]);
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

  test('feature overrides use fine targets and legacy revision aliases', () {
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
    expect(operations.single.targetId, 'classFeature:7:name');
    expect(
      characterSyncOperationTargetKey(operations.single),
      'featureOverride:classFeature:7:name',
    );
    expect(operations.single.baseTargetRevision, 4);
  });

  test('feature override id churn does not create list operations', () {
    final previous = CharacterData(
      id: 42,
      version: 3,
      featureOverrides: [
        CharacterFeatureOverrideData(
          id: 'old-uuid',
          sourceType: CharacterFeatureSourceType.classFeature,
          sourceId: 7,
          name: 'Old',
          description: 'Description',
          tags: const [FeatureTag.combat],
        ),
      ],
    );
    final operations = buildCharacterSyncOperations(
      previous: previous,
      next: previous.copyWith(
        featureOverrides: [
          CharacterFeatureOverrideData(
            id: 'new-uuid',
            sourceType: CharacterFeatureSourceType.classFeature,
            sourceId: 7,
            name: 'New',
            description: 'Description',
            tags: const [FeatureTag.combat],
          ),
        ],
      ),
      localId: 42,
      serverId: 42,
      createdAt: DateTime.utc(2026, 4, 24),
      nextChangeId: changeId,
    );

    expect(operations, hasLength(1));
    expect(operations.single.type, CharacterSyncOperationType.setMemberValue);
    expect(operations.single.targetId, 'classFeature:7:name');
  });

  test('feature override subfields and tags use independent targets', () {
    final previous = CharacterData(
      id: 42,
      version: 3,
      featureOverrides: [
        CharacterFeatureOverrideData(
          sourceType: CharacterFeatureSourceType.classFeature,
          sourceId: 7,
          name: 'Old',
          description: 'Before',
          tags: const [FeatureTag.combat],
        ),
      ],
    );
    final operations = buildCharacterSyncOperations(
      previous: previous,
      next: previous.copyWith(
        featureOverrides: [
          CharacterFeatureOverrideData(
            sourceType: CharacterFeatureSourceType.classFeature,
            sourceId: 7,
            name: 'New',
            description: 'After',
            tags: const [FeatureTag.utility],
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
        'featureOverride:classFeature:7:name',
        'featureOverride:classFeature:7:description',
        'featureOverride:classFeature:7:tag:combat',
        'featureOverride:classFeature:7:tag:utility',
      ]),
    );
  });

  test('conditions and prepared spells produce per-member operations', () {
    final operations = buildCharacterSyncOperations(
      previous: CharacterData(
        id: 42,
        version: 2,
        activeConditions: const [ConditionType.poisoned],
        preparedSpellKeys: const ['fireball'],
      ),
      next: CharacterData(
        id: 42,
        version: 2,
        activeConditions: const [ConditionType.prone],
        preparedSpellKeys: const ['haste'],
      ),
      localId: 42,
      serverId: 42,
      createdAt: DateTime.utc(2026, 4, 24),
      nextChangeId: changeId,
    );

    expect(
      operations.map(characterSyncOperationTargetKey),
      containsAll([
        'member:activeConditions:poisoned',
        'member:activeConditions:prone',
        'member:preparedSpellKeys:fireball',
        'member:preparedSpellKeys:haste',
      ]),
    );
    expect(
      operations.every(
        (operation) => operation.targetType == CharacterSyncTargetType.member,
      ),
      isTrue,
    );
  });

  test('free-form member target components are collision safe', () {
    const spellKey = 'fire:ball%3A';
    final operations = buildCharacterSyncOperations(
      previous: CharacterData(id: 42, version: 2),
      next: CharacterData(
        id: 42,
        version: 2,
        preparedSpellKeys: const [spellKey],
      ),
      localId: 42,
      serverId: 42,
      createdAt: DateTime.utc(2026, 4, 24),
      nextChangeId: changeId,
    );

    expect(
      characterSyncOperationTargetKey(operations.single),
      'member:preparedSpellKeys:fire%3Aball%253A',
    );
    expect(
      decodeCharacterSyncCompositeId(
        encodeCharacterSyncCompositeId(const ['a:b', 'c%3A']),
      ),
      const ['a:b', 'c%3A'],
    );
  });

  test('manual proficiency changes produce keyed member operations', () {
    final operations = buildCharacterSyncOperations(
      previous: CharacterData(id: 42, version: 2),
      next: CharacterData(
        id: 42,
        version: 2,
        manualSkillProficiencyOverrides: [
          CharacterSkillProficiencyState(
            skill: Skill.arcana,
            level: CharacterSkillProficiencyLevel.expertise,
          ),
        ],
        manualSavingThrowProficiencyOverrides: [
          CharacterSavingThrowProficiencyOverrideData(
            ability: Ability.wisdom,
            state: CharacterSavingThrowProficiencyOverride.remove,
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
        'member:manualSkillProficiencyOverrides:arcana',
        'member:manualSavingThrowProficiencyOverrides:wisdom',
      ]),
    );
  });

  test('manual language overrides use a typed scalar sync target', () {
    final operations = buildCharacterSyncOperations(
      previous: CharacterData(
        id: 42,
        version: 2,
        syncTargetRevisions: const {
          'field:manualLanguageOverrides': 11,
        },
      ),
      next: CharacterData(
        id: 42,
        version: 2,
        manualLanguageOverrides: CharacterLanguageOverridesData(
          added: const [Language.elvish],
          custom: const ['River speech'],
        ),
      ),
      localId: 42,
      serverId: 42,
      createdAt: DateTime.utc(2026, 9, 26),
      nextChangeId: changeId,
    );

    final operation = operations.singleWhere(
      (value) => value.fieldPath == 'manualLanguageOverrides',
    );
    expect(characterSyncOperationTargetKey(operation),
        'field:manualLanguageOverrides');
    expect(operation.baseTargetRevision, 11);
    expect(operation.value?.languageOverridesValue?.added, [Language.elvish]);
    expect(
      operation.value?.languageOverridesValue?.custom,
      ['River speech'],
    );
  });

  test('starting equipment parent payload excludes nested resolutions', () {
    final selection = CharacterStartingEquipmentSelectionData(
      id: 'legacy-selection-id',
      sourceType: ChoiceSourceType.classData,
      sourceId: 5,
      sourceEntryId: 11,
      selectionIndex: 0,
      isSelected: true,
      resolutions: [
        CharacterStartingEquipmentResolutionData(
          id: 'legacy-resolution-id',
          sourceLineEntryId: 13,
          referenceKey: 'javelin',
          quantity: 1,
        ),
      ],
    );
    final operations = buildCharacterSyncOperations(
      previous: CharacterData(id: 42, version: 2),
      next: CharacterData(
        id: 42,
        version: 2,
        startingEquipmentSelections: [selection],
      ),
      localId: 42,
      serverId: 42,
      createdAt: DateTime.utc(2026, 4, 24),
      nextChangeId: changeId,
    );

    final parent = operations.singleWhere(
      (operation) => operation.targetType == CharacterSyncTargetType.listItem,
    );
    final resolution = operations.singleWhere(
      (operation) =>
          operation.targetType ==
          CharacterSyncTargetType.startingEquipmentResolution,
    );
    expect(
      parent.itemPayload?.startingEquipmentSelectionValue?.resolutions,
      isNull,
    );
    expect(parent.targetId, 'classData:5:11:0');
    expect(
      characterSyncOperationTargetKey(resolution),
      characterSyncStartingEquipmentResolutionTargetKey(
        'classData:5:11:0',
        '13',
      ),
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
