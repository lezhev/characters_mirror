import 'dart:convert';

import 'package:characters_mirror_client/characters_mirror_client.dart';

List<CharacterSyncOperationData> buildCharacterSyncOperations({
  required CharacterData previous,
  required CharacterData next,
  required int localId,
  required int? serverId,
  required DateTime createdAt,
  required String Function() nextChangeId,
}) {
  if (serverId == null) {
    return [
      CharacterSyncOperationData(
        id: nextChangeId(),
        characterId: null,
        localCharacterId: localId,
        type: CharacterSyncOperationType.createCharacter,
        targetType: CharacterSyncTargetType.character,
        targetId: localId.toString(),
        itemPayload: CharacterSyncValueData(
          characterValue: next.copyWith(id: localId),
        ),
        createdAt: createdAt,
      ),
    ];
  }

  final builder = _OperationBuilder(
    previous: previous,
    next: next.copyWith(id: serverId),
    localId: localId,
    serverId: serverId,
    createdAt: createdAt,
    nextChangeId: nextChangeId,
  );
  return builder.build();
}

String characterSyncOperationTargetKey(CharacterSyncOperationData operation) {
  switch (operation.type) {
    case CharacterSyncOperationType.createCharacter:
    case CharacterSyncOperationType.deleteCharacter:
      return 'character:${operation.characterId ?? operation.localCharacterId ?? ''}';
    case CharacterSyncOperationType.setField:
      return 'field:${operation.fieldPath ?? ''}';
    case CharacterSyncOperationType.setMapEntry:
    case CharacterSyncOperationType.removeMapEntry:
      return 'map:${operation.fieldPath ?? ''}:${operation.targetId ?? ''}';
    case CharacterSyncOperationType.upsertListItem:
    case CharacterSyncOperationType.removeListItem:
      if (operation.targetType == CharacterSyncTargetType.resource) {
        final parts = (operation.targetId ?? '').split(':');
        if (parts.length == 3) {
          return 'resource:${parts[0]}:${parts[1]}:${parts[2]}';
        }
      }
      if (operation.targetType ==
          CharacterSyncTargetType.startingEquipmentResolution) {
        final parts = (operation.targetId ?? '').split(':');
        if (parts.length == 2) {
          return 'item:startingEquipmentSelections:${parts[0]}:resolution:${parts[1]}';
        }
      }
      return 'item:${operation.fieldPath ?? ''}:${operation.targetId ?? ''}';
  }
}

List<CharacterSyncOperationData> coalesceCharacterSyncOperations(
  Iterable<CharacterSyncOperationData> operations,
) {
  final orderedKeys = <String>[];
  final byKey = <String, CharacterSyncOperationData>{};
  for (final operation in operations) {
    final characterKey =
        '${operation.characterId ?? operation.localCharacterId ?? ''}';
    if (operation.type == CharacterSyncOperationType.deleteCharacter) {
      final keysToRemove = [
        for (final key in byKey.keys)
          if (key.startsWith('$characterKey|')) key,
      ];
      for (final key in keysToRemove) {
        byKey.remove(key);
        orderedKeys.remove(key);
      }
    }
    final key = '$characterKey|${characterSyncOperationTargetKey(operation)}';
    if (!byKey.containsKey(key)) {
      orderedKeys.add(key);
    }
    byKey[key] = operation;
  }
  return [
    for (final key in orderedKeys)
      if (byKey[key] != null) byKey[key]!,
  ];
}

class _OperationBuilder {
  _OperationBuilder({
    required this.previous,
    required this.next,
    required this.localId,
    required this.serverId,
    required this.createdAt,
    required this.nextChangeId,
  });

  final CharacterData previous;
  final CharacterData next;
  final int localId;
  final int serverId;
  final DateTime createdAt;
  final String Function() nextChangeId;

  final List<CharacterSyncOperationData> _operations = [];

  List<CharacterSyncOperationData> build() {
    _addStringField('name', previous.name, next.name);
    _addStringField('age', previous.age, next.age);
    _addStringField('height', previous.height, next.height);
    _addStringField('weight', previous.weight, next.weight);
    _addStringField('eyes', previous.eyes, next.eyes);
    _addStringField('skin', previous.skin, next.skin);
    _addStringField('hair', previous.hair, next.hair);
    _addStringField('appearance', previous.appearance, next.appearance);
    _addStringField('backstory', previous.backstory, next.backstory);
    _addStringField('goals', previous.goals, next.goals);
    _addStringField(
      'alliesOrganizations',
      previous.alliesOrganizations,
      next.alliesOrganizations,
    );
    _addStringField(
      'personalityTraits',
      previous.personalityTraits,
      next.personalityTraits,
    );
    _addStringField('ideals', previous.ideals, next.ideals);
    _addStringField('bonds', previous.bonds, next.bonds);
    _addStringField('flaws', previous.flaws, next.flaws);
    _addIntField('experience', previous.experience, next.experience);
    _addField(
      'alignmentValue',
      previous.alignmentValue,
      next.alignmentValue,
      (value) => CharacterSyncValueData(alignmentValue: value),
    );
    _addIntField('race', previous.race?.id, next.race?.id);
    _addIntField('subrace', previous.subrace?.id, next.subrace?.id);
    _addIntField('background', previous.background?.id, next.background?.id);
    _addBoolField(
      'useFlexibleAbilityBonuses',
      previous.useFlexibleAbilityBonuses,
      next.useFlexibleAbilityBonuses,
    );
    _addIntField('temporaryHp', previous.temporaryHp, next.temporaryHp);
    _addIntField('currentHp', previous.currentHp, next.currentHp);
    _addIntField(
      'deathSaveSuccesses',
      previous.deathSaveSuccesses,
      next.deathSaveSuccesses,
    );
    _addIntField(
      'deathSaveFailures',
      previous.deathSaveFailures,
      next.deathSaveFailures,
    );
    _addIntField(
        'hpPerLevelBonus', previous.hpPerLevelBonus, next.hpPerLevelBonus);
    _addIntField('hpFlatBonus', previous.hpFlatBonus, next.hpFlatBonus);
    _addStringIntMap('baseAbilityScores', previous.baseAbilityScores,
        next.baseAbilityScores);
    _addStringIntMap(
      'customAbilityBonuses',
      previous.customAbilityBonuses,
      next.customAbilityBonuses,
    );
    _addStringIntMap(
        'currentHitDice', previous.currentHitDice, next.currentHitDice);
    _addStringIntMap(
      'hitDiceMaxOverrides',
      previous.hitDiceMaxOverrides,
      next.hitDiceMaxOverrides,
    );
    _addIntIntMap('currentSpellSlots', previous.currentSpellSlots,
        next.currentSpellSlots);
    _addStringField(
      'activeConcentrationSpellName',
      previous.activeConcentrationSpellName,
      next.activeConcentrationSpellName,
    );
    _addIntField(
      'customInitiativeBonus',
      previous.customInitiativeBonus,
      next.customInitiativeBonus,
    );
    _addIntField(
      'customArmorClassBonus',
      previous.customArmorClassBonus,
      next.customArmorClassBonus,
    );
    _addIntField('walkingSpeed', previous.walkingSpeed, next.walkingSpeed);
    _addIntField('swimmingSpeed', previous.swimmingSpeed, next.swimmingSpeed);
    _addIntField('climbingSpeed', previous.climbingSpeed, next.climbingSpeed);
    _addIntField('flyingSpeed', previous.flyingSpeed, next.flyingSpeed);
    _addField(
      'displayedSpeedKind',
      previous.displayedSpeedKind,
      next.displayedSpeedKind,
      (value) => CharacterSyncValueData(speedKindValue: value),
    );
    _addIntField(
      'customSpellSaveDcBonus',
      previous.customSpellSaveDcBonus,
      next.customSpellSaveDcBonus,
    );
    _addIntField(
      'customSpellAttackBonus',
      previous.customSpellAttackBonus,
      next.customSpellAttackBonus,
    );
    _addField(
      'preparedSpellKeys',
      previous.preparedSpellKeys,
      next.preparedSpellKeys,
      (value) => CharacterSyncValueData(stringListValue: value),
    );
    _addField(
      'activeConditions',
      previous.activeConditions,
      next.activeConditions,
      (value) => CharacterSyncValueData(conditionListValue: value),
    );
    _addIntField(
        'exhaustionLevel', previous.exhaustionLevel, next.exhaustionLevel);
    _addBoolField('inspiration', previous.inspiration, next.inspiration);
    _addField(
      'manualSkillProficiencies',
      previous.manualSkillProficiencies,
      next.manualSkillProficiencies,
      (value) => CharacterSyncValueData(skillProficiencyListValue: value),
    );
    _addField(
      'manualSavingThrowProficiencies',
      previous.manualSavingThrowProficiencies,
      next.manualSavingThrowProficiencies,
      (value) => CharacterSyncValueData(abilityListValue: value),
    );

    _addListItems(
      'notes',
      previous.notes,
      next.notes,
      (item) => item.id,
      (item) => CharacterSyncValueData(noteValue: item),
    );
    _addListItems(
      'equipment',
      previous.equipment,
      next.equipment,
      (item) => item.id,
      (item) => CharacterSyncValueData(equipmentValue: item),
    );
    _addListItems(
      'attacks',
      previous.attacks,
      next.attacks,
      (item) => item.id,
      (item) => CharacterSyncValueData(attackValue: item),
    );
    _addListItems(
      'featureOverrides',
      previous.featureOverrides,
      next.featureOverrides,
      (item) => item.id,
      (item) => CharacterSyncValueData(featureOverrideValue: item),
    );
    _addResourceStates();
    _addListItems(
      'classEntries',
      previous.classEntries,
      next.classEntries,
      (item) => item.id,
      (item) => CharacterSyncValueData(classEntryValue: item),
    );
    _addListItems(
      'choices',
      previous.choices,
      next.choices,
      (item) => item.id,
      (item) => CharacterSyncValueData(choiceValue: item),
    );
    _addListItems(
      'skillSelections',
      previous.skillSelections,
      next.skillSelections,
      (item) => item.id,
      (item) => CharacterSyncValueData(skillSelectionValue: item),
    );
    _addListItems(
      'spellSelections',
      previous.spellSelections,
      next.spellSelections,
      (item) => item.id,
      (item) => CharacterSyncValueData(spellSelectionValue: item),
    );
    _addStartingEquipmentSelections();
    return _operations;
  }

  void _addStringField(String field, String? left, String? right) {
    _addField(field, left, right,
        (value) => CharacterSyncValueData(stringValue: value));
  }

  void _addIntField(String field, int? left, int? right) {
    _addField(
        field, left, right, (value) => CharacterSyncValueData(intValue: value));
  }

  void _addBoolField(String field, bool? left, bool? right) {
    _addField(field, left, right,
        (value) => CharacterSyncValueData(boolValue: value));
  }

  void _addField<T>(
    String field,
    T? left,
    T? right,
    CharacterSyncValueData Function(T? value) valueBuilder,
  ) {
    if (_jsonEquals(left, right)) return;
    _operations.add(
      _operation(
        type: CharacterSyncOperationType.setField,
        targetType: CharacterSyncTargetType.field,
        fieldPath: field,
        targetId: field,
        value: valueBuilder(right),
        baseTargetRevision: _baseRevision('field:$field'),
      ),
    );
  }

  void _addStringIntMap(
    String field,
    Map<String, int>? left,
    Map<String, int>? right,
  ) {
    final keys = {...?left?.keys, ...?right?.keys}.toList()..sort();
    for (final key in keys) {
      _addMapEntry(field, key, left?[key], right?[key]);
    }
  }

  void _addIntIntMap(String field, Map<int, int>? left, Map<int, int>? right) {
    final keys = {...?left?.keys, ...?right?.keys}.toList()..sort();
    for (final key in keys) {
      _addMapEntry(field, key.toString(), left?[key], right?[key]);
    }
  }

  void _addMapEntry(String field, String key, int? left, int? right) {
    if (left == right) return;
    final targetKey = 'map:$field:$key';
    _operations.add(
      _operation(
        type: right == null
            ? CharacterSyncOperationType.removeMapEntry
            : CharacterSyncOperationType.setMapEntry,
        targetType: CharacterSyncTargetType.mapEntry,
        fieldPath: field,
        targetId: key,
        value: right == null ? null : CharacterSyncValueData(intValue: right),
        baseTargetRevision: _baseRevision(targetKey),
      ),
    );
  }

  void _addListItems<T>(
    String field,
    List<T>? left,
    List<T>? right,
    String? Function(T item) idOf,
    CharacterSyncValueData Function(T item) payloadOf,
  ) {
    final leftById = _itemsById(left, idOf);
    final rightById = _itemsById(right, idOf);
    final ids = {...leftById.keys, ...rightById.keys}.toList()..sort();
    for (final id in ids) {
      final leftItem = leftById[id];
      final rightItem = rightById[id];
      if (_jsonEquals(leftItem, rightItem)) continue;
      final targetKey = 'item:$field:$id';
      _operations.add(
        _operation(
          type: rightItem == null
              ? CharacterSyncOperationType.removeListItem
              : CharacterSyncOperationType.upsertListItem,
          targetType: CharacterSyncTargetType.listItem,
          fieldPath: field,
          targetId: id,
          itemPayload: rightItem == null ? null : payloadOf(rightItem),
          baseTargetRevision: _baseRevision(targetKey),
        ),
      );
    }
  }

  void _addResourceStates() {
    final leftById = {
      for (final state
          in previous.resourceStates ?? const <CharacterResourceStateData>[])
        _resourceTargetId(state): state,
    };
    final rightById = {
      for (final state
          in next.resourceStates ?? const <CharacterResourceStateData>[])
        _resourceTargetId(state): state,
    };
    final ids = {...leftById.keys, ...rightById.keys}.toList()..sort();
    for (final id in ids) {
      final leftItem = leftById[id];
      final rightItem = rightById[id];
      if (_jsonEquals(leftItem, rightItem)) continue;
      final targetKey = 'resource:$id';
      _operations.add(
        _operation(
          type: rightItem == null
              ? CharacterSyncOperationType.removeListItem
              : CharacterSyncOperationType.upsertListItem,
          targetType: CharacterSyncTargetType.resource,
          fieldPath: 'resourceStates',
          targetId: id,
          itemPayload: rightItem == null
              ? null
              : CharacterSyncValueData(resourceStateValue: rightItem),
          baseTargetRevision: _baseRevision(targetKey),
        ),
      );
    }
  }

  void _addStartingEquipmentSelections() {
    _addListItems(
      'startingEquipmentSelections',
      previous.startingEquipmentSelections,
      next.startingEquipmentSelections,
      (item) => item.id,
      (item) => CharacterSyncValueData(startingEquipmentSelectionValue: item),
    );
    final previousById = _itemsById(
      previous.startingEquipmentSelections,
      (item) => item.id,
    );
    final nextById = _itemsById(
      next.startingEquipmentSelections,
      (item) => item.id,
    );
    for (final selectionId in {...previousById.keys, ...nextById.keys}) {
      final leftResolutions = _itemsById(
        previousById[selectionId]?.resolutions,
        (item) => item.id,
      );
      final rightResolutions = _itemsById(
        nextById[selectionId]?.resolutions,
        (item) => item.id,
      );
      final resolutionIds = {
        ...leftResolutions.keys,
        ...rightResolutions.keys,
      }.toList()
        ..sort();
      for (final resolutionId in resolutionIds) {
        final leftItem = leftResolutions[resolutionId];
        final rightItem = rightResolutions[resolutionId];
        if (_jsonEquals(leftItem, rightItem)) continue;
        final targetId = '$selectionId:$resolutionId';
        final targetKey =
            'item:startingEquipmentSelections:$selectionId:resolution:$resolutionId';
        _operations.add(
          _operation(
            type: rightItem == null
                ? CharacterSyncOperationType.removeListItem
                : CharacterSyncOperationType.upsertListItem,
            targetType: CharacterSyncTargetType.startingEquipmentResolution,
            fieldPath: 'startingEquipmentSelections',
            targetId: targetId,
            itemPayload: rightItem == null
                ? null
                : CharacterSyncValueData(
                    startingEquipmentResolutionValue: rightItem,
                  ),
            baseTargetRevision: _baseRevision(targetKey),
          ),
        );
      }
    }
  }

  CharacterSyncOperationData _operation({
    required CharacterSyncOperationType type,
    required CharacterSyncTargetType targetType,
    required String fieldPath,
    required String targetId,
    CharacterSyncValueData? value,
    CharacterSyncValueData? itemPayload,
    required int baseTargetRevision,
  }) {
    return CharacterSyncOperationData(
      id: nextChangeId(),
      characterId: serverId,
      localCharacterId: localId,
      type: type,
      targetType: targetType,
      targetId: targetId,
      fieldPath: fieldPath,
      value: value,
      itemPayload: itemPayload,
      baseCharacterRevision: previous.version ?? 0,
      baseTargetRevision: baseTargetRevision,
      createdAt: createdAt,
    );
  }

  int _baseRevision(String targetKey) {
    return previous.syncTargetRevisions?[targetKey] ?? previous.version ?? 0;
  }
}

Map<String, T> _itemsById<T>(List<T>? items, String? Function(T item) idOf) {
  return {
    for (final item in items ?? <T>[])
      if (idOf(item) != null) idOf(item)!: item,
  };
}

String _resourceTargetId(CharacterResourceStateData state) {
  return '${state.sourceType.name}:${state.sourceId}:${state.resourceKey}';
}

bool _jsonEquals(Object? left, Object? right) {
  return jsonEncode(_normalizeJson(left)) == jsonEncode(_normalizeJson(right));
}

Object? _normalizeJson(Object? value) {
  if (value == null || value is num || value is bool || value is String) {
    return value;
  }
  if (value is DateTime) {
    return value.toUtc().toIso8601String();
  }
  if (value is SerializableModel) {
    final json = Map<String, dynamic>.from(value.toJson());
    json.remove('updatedAt');
    json.remove('derived');
    json.remove('version');
    json.remove('syncTargetRevisions');
    return _normalizeJson(json);
  }
  if (value is Iterable) {
    return [for (final item in value) _normalizeJson(item)];
  }
  if (value is Map) {
    final normalized = <String, Object?>{};
    final keys = value.keys.map((key) => key.toString()).toList()..sort();
    for (final key in keys) {
      normalized[key] = _normalizeJson(value[key]);
    }
    return normalized;
  }
  return value.toString();
}
