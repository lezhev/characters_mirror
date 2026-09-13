part of '../character_data_endpoint.dart';

const _characterScalarSyncFields = <String>[
  'name',
  'age',
  'height',
  'weight',
  'eyes',
  'skin',
  'hair',
  'appearance',
  'backstory',
  'goals',
  'alliesOrganizations',
  'personalityTraits',
  'ideals',
  'bonds',
  'flaws',
  'experience',
  'alignmentValue',
  'race',
  'subrace',
  'background',
  'useFlexibleAbilityBonuses',
  'temporaryHp',
  'currentHp',
  'deathSaveSuccesses',
  'deathSaveFailures',
  'hpPerLevelBonus',
  'hpFlatBonus',
  'activeConcentrationSpellName',
  'customInitiativeBonus',
  'customArmorClassBonus',
  'walkingSpeed',
  'swimmingSpeed',
  'climbingSpeed',
  'flyingSpeed',
  'displayedSpeedKind',
  'customSpellSaveDcBonus',
  'customSpellAttackBonus',
  'preparedSpellKeys',
  'activeConditions',
  'exhaustionLevel',
  'inspiration',
  'manualSkillProficiencies',
  'manualSavingThrowProficiencies',
];

Map<String, int> _materializedSyncTargetRevisions(
  CharacterData character,
  int baselineRevision,
) {
  final revisions = <String, int>{
    ...?character.syncTargetRevisions,
  };
  for (final field in _characterScalarSyncFields) {
    revisions.putIfAbsent(_fieldTargetKey(field), () => baselineRevision);
  }
  _addMapTargetRevisions(
    revisions,
    'baseAbilityScores',
    character.baseAbilityScores,
    baselineRevision,
  );
  _addMapTargetRevisions(
    revisions,
    'customAbilityBonuses',
    character.customAbilityBonuses,
    baselineRevision,
  );
  _addMapTargetRevisions(
    revisions,
    'currentHitDice',
    character.currentHitDice,
    baselineRevision,
  );
  _addMapTargetRevisions(
    revisions,
    'hitDiceMaxOverrides',
    character.hitDiceMaxOverrides,
    baselineRevision,
  );
  _addMapTargetRevisions(
    revisions,
    'currentSpellSlots',
    character.currentSpellSlots,
    baselineRevision,
  );
  _addItemTargetRevisions(
    revisions,
    'notes',
    character.notes?.map((item) => item.id),
    baselineRevision,
  );
  _addItemTargetRevisions(
    revisions,
    'equipment',
    character.equipment?.map((item) => item.id),
    baselineRevision,
  );
  _addItemTargetRevisions(
    revisions,
    'attacks',
    character.attacks?.map((item) => item.id),
    baselineRevision,
  );
  _addItemTargetRevisions(
    revisions,
    'featureOverrides',
    character.featureOverrides?.map(_featureOverrideTargetId),
    baselineRevision,
  );
  _addItemTargetRevisions(
    revisions,
    'classEntries',
    character.classEntries?.map((item) => item.id),
    baselineRevision,
  );
  _addItemTargetRevisions(
    revisions,
    'choices',
    character.choices?.map((item) => item.id),
    baselineRevision,
  );
  _addItemTargetRevisions(
    revisions,
    'skillSelections',
    character.skillSelections?.map((item) => item.id),
    baselineRevision,
  );
  _addItemTargetRevisions(
    revisions,
    'spellSelections',
    character.spellSelections?.map((item) => item.id),
    baselineRevision,
  );
  _addItemTargetRevisions(
    revisions,
    'startingEquipmentSelections',
    character.startingEquipmentSelections?.map((item) => item.id),
    baselineRevision,
  );
  for (final state
      in character.resourceStates ?? const <CharacterResourceStateData>[]) {
    revisions.putIfAbsent(
      _resourceTargetKey(
        state.sourceType.name,
        state.sourceId,
        state.resourceKey,
      ),
      () => baselineRevision,
    );
  }
  for (final selection in character.startingEquipmentSelections ??
      const <CharacterStartingEquipmentSelectionData>[]) {
    final selectionId = selection.id;
    if (selectionId == null) continue;
    for (final resolution in selection.resolutions ??
        const <CharacterStartingEquipmentResolutionData>[]) {
      final resolutionId = resolution.id;
      if (resolutionId == null) continue;
      revisions.putIfAbsent(
        _startingEquipmentResolutionTargetKey(selectionId, resolutionId),
        () => baselineRevision,
      );
    }
  }
  return revisions;
}

void _addMapTargetRevisions<K>(
  Map<String, int> revisions,
  String field,
  Map<K, int>? values,
  int baselineRevision,
) {
  for (final key in values?.keys ?? const <Never>[]) {
    revisions.putIfAbsent(
      _mapTargetKey(field, key.toString()),
      () => baselineRevision,
    );
  }
}

void _addItemTargetRevisions(
  Map<String, int> revisions,
  String collection,
  Iterable<String?>? ids,
  int baselineRevision,
) {
  for (final id in ids ?? const <String?>[]) {
    if (id == null) continue;
    revisions.putIfAbsent(
        _itemTargetKey(collection, id), () => baselineRevision);
  }
}

String _targetKeyForOperation(CharacterSyncOperationData operation) {
  switch (operation.type) {
    case CharacterSyncOperationType.createCharacter:
    case CharacterSyncOperationType.deleteCharacter:
      return 'character:${operation.characterId ?? operation.localCharacterId ?? ''}';
    case CharacterSyncOperationType.setField:
      return _fieldTargetKey(operation.fieldPath ?? '');
    case CharacterSyncOperationType.setMapEntry:
    case CharacterSyncOperationType.removeMapEntry:
      return _mapTargetKey(operation.fieldPath ?? '', operation.targetId ?? '');
    case CharacterSyncOperationType.upsertListItem:
    case CharacterSyncOperationType.removeListItem:
      if (operation.targetType == CharacterSyncTargetType.resource) {
        final parts = _decodeCompositeTargetId(operation.targetId);
        if (parts.length == 3) {
          return _resourceTargetKey(
              parts[0], int.tryParse(parts[1]) ?? 0, parts[2]);
        }
      }
      if (operation.targetType ==
          CharacterSyncTargetType.startingEquipmentResolution) {
        final parts = _decodeCompositeTargetId(operation.targetId);
        if (parts.length == 2) {
          return _startingEquipmentResolutionTargetKey(parts[0], parts[1]);
        }
      }
      return _itemTargetKey(
          operation.fieldPath ?? '', operation.targetId ?? '');
  }
}

Set<String> _changedSyncTargetKeys(
  CharacterData previous,
  CharacterData next,
) {
  final changed = <String>{};
  final previousJson = previous.toJson()..remove('derived');
  final nextJson = next.toJson()..remove('derived');

  for (final field in _characterScalarSyncFields) {
    if (!_syncJsonEquals(
      _syncScalarFieldValue(previousJson, field),
      _syncScalarFieldValue(nextJson, field),
    )) {
      changed.add(_fieldTargetKey(field));
    }
  }

  _addChangedMapTargets(
    changed,
    'baseAbilityScores',
    previous.baseAbilityScores,
    next.baseAbilityScores,
  );
  _addChangedMapTargets(
    changed,
    'customAbilityBonuses',
    previous.customAbilityBonuses,
    next.customAbilityBonuses,
  );
  _addChangedMapTargets(
    changed,
    'currentHitDice',
    previous.currentHitDice,
    next.currentHitDice,
  );
  _addChangedMapTargets(
    changed,
    'hitDiceMaxOverrides',
    previous.hitDiceMaxOverrides,
    next.hitDiceMaxOverrides,
  );
  _addChangedMapTargets(
    changed,
    'currentSpellSlots',
    previous.currentSpellSlots,
    next.currentSpellSlots,
  );

  _addChangedItemTargets(
    changed,
    'notes',
    previous.notes,
    next.notes,
    (item) => item.id,
  );
  _addChangedItemTargets(
    changed,
    'equipment',
    previous.equipment,
    next.equipment,
    (item) => item.id,
  );
  _addChangedItemTargets(
    changed,
    'attacks',
    previous.attacks,
    next.attacks,
    (item) => item.id,
  );
  _addChangedItemTargets(
    changed,
    'featureOverrides',
    previous.featureOverrides,
    next.featureOverrides,
    _featureOverrideTargetId,
  );
  _addChangedResourceTargets(
      changed, previous.resourceStates, next.resourceStates);
  _addChangedItemTargets(
    changed,
    'classEntries',
    previous.classEntries,
    next.classEntries,
    (item) => item.id,
  );
  _addChangedItemTargets(
    changed,
    'choices',
    previous.choices,
    next.choices,
    (item) => item.id,
  );
  _addChangedItemTargets(
    changed,
    'skillSelections',
    previous.skillSelections,
    next.skillSelections,
    (item) => item.id,
  );
  _addChangedItemTargets(
    changed,
    'spellSelections',
    previous.spellSelections,
    next.spellSelections,
    (item) => item.id,
  );
  _addChangedItemTargets(
    changed,
    'startingEquipmentSelections',
    previous.startingEquipmentSelections,
    next.startingEquipmentSelections,
    (item) => item.id,
  );
  _addChangedStartingEquipmentResolutionTargets(
    changed,
    previous.startingEquipmentSelections,
    next.startingEquipmentSelections,
  );

  return changed;
}

Object? _syncScalarFieldValue(Map<String, dynamic> json, String field) {
  final value = json[field];
  if (field == 'race' || field == 'subrace' || field == 'background') {
    if (value is Map<String, dynamic>) {
      return value['id'];
    }
  }
  return value;
}

void _addChangedMapTargets<K>(
  Set<String> changed,
  String field,
  Map<K, int>? previous,
  Map<K, int>? next,
) {
  final keys = {...?previous?.keys, ...?next?.keys};
  for (final key in keys) {
    if (previous?[key] != next?[key]) {
      changed.add(_mapTargetKey(field, key.toString()));
    }
  }
}

void _addChangedItemTargets<T>(
  Set<String> changed,
  String collection,
  List<T>? previous,
  List<T>? next,
  String? Function(T item) idOf,
) {
  final previousById = _syncItemsById(previous, idOf);
  final nextById = _syncItemsById(next, idOf);
  final ids = {...previousById.keys, ...nextById.keys};
  for (final id in ids) {
    if (!_syncJsonEquals(previousById[id], nextById[id])) {
      changed.add(_itemTargetKey(collection, id));
    }
  }
}

void _addChangedResourceTargets(
  Set<String> changed,
  List<CharacterResourceStateData>? previous,
  List<CharacterResourceStateData>? next,
) {
  final previousById = {
    for (final state in previous ?? const <CharacterResourceStateData>[])
      _resourceTargetId(state): state,
  };
  final nextById = {
    for (final state in next ?? const <CharacterResourceStateData>[])
      _resourceTargetId(state): state,
  };
  for (final id in {...previousById.keys, ...nextById.keys}) {
    if (!_syncJsonEquals(previousById[id], nextById[id])) {
      final parts = _decodeCompositeTargetId(id);
      if (parts.length == 3) {
        changed.add(_resourceTargetKey(
          parts[0],
          int.tryParse(parts[1]) ?? 0,
          parts[2],
        ));
      }
    }
  }
}

void _addChangedStartingEquipmentResolutionTargets(
  Set<String> changed,
  List<CharacterStartingEquipmentSelectionData>? previous,
  List<CharacterStartingEquipmentSelectionData>? next,
) {
  final previousById = _syncItemsById(previous, (item) => item.id);
  final nextById = _syncItemsById(next, (item) => item.id);
  for (final selectionId in {...previousById.keys, ...nextById.keys}) {
    final previousResolutions = _syncItemsById(
      previousById[selectionId]?.resolutions,
      (item) => item.id,
    );
    final nextResolutions = _syncItemsById(
      nextById[selectionId]?.resolutions,
      (item) => item.id,
    );
    for (final resolutionId in {
      ...previousResolutions.keys,
      ...nextResolutions.keys
    }) {
      if (!_syncJsonEquals(
        previousResolutions[resolutionId],
        nextResolutions[resolutionId],
      )) {
        changed.add(_startingEquipmentResolutionTargetKey(
          selectionId,
          resolutionId,
        ));
      }
    }
  }
}

Map<String, T> _syncItemsById<T>(
  List<T>? items,
  String? Function(T item) idOf,
) {
  return {
    for (final item in items ?? <T>[])
      if (idOf(item) != null) idOf(item)!: item,
  };
}

String _featureOverrideTargetId(CharacterFeatureOverrideData item) {
  return item.id ??
      _encodeCompositeTargetId([
        item.sourceType.name,
        item.sourceId.toString(),
      ]);
}

bool _syncJsonEquals(Object? left, Object? right) {
  return jsonEncode(_normalizeSyncJson(left)) ==
      jsonEncode(_normalizeSyncJson(right));
}

Object? _normalizeSyncJson(Object? value) {
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
    return _normalizeSyncJson(json);
  }
  if (value is Iterable) {
    return [for (final item in value) _normalizeSyncJson(item)];
  }
  if (value is Map) {
    final normalized = <String, Object?>{};
    final keys = value.keys.map((key) => key.toString()).toList()..sort();
    for (final key in keys) {
      if (key == 'updatedAt' ||
          key == 'derived' ||
          key == 'version' ||
          key == 'syncTargetRevisions') {
        continue;
      }
      normalized[key] = _normalizeSyncJson(value[key]);
    }
    return normalized;
  }
  return value.toString();
}

String _fieldTargetKey(String field) => _syncTargetKey('field', [field]);

String _mapTargetKey(String field, String key) =>
    _syncTargetKey('map', [field, key]);

String _itemTargetKey(String collection, String id) =>
    _syncTargetKey('item', [collection, id]);

String _resourceTargetKey(String sourceType, int sourceId, String resourceKey) {
  return _syncTargetKey(
    'resource',
    [sourceType, sourceId.toString(), resourceKey],
  );
}

String _startingEquipmentResolutionTargetKey(
  String selectionId,
  String resolutionId,
) {
  return _syncTargetKey(
    'item',
    ['startingEquipmentSelections', selectionId, 'resolution', resolutionId],
  );
}

String _resourceTargetId(CharacterResourceStateData state) {
  return _encodeCompositeTargetId([
    state.sourceType.name,
    state.sourceId.toString(),
    state.resourceKey,
  ]);
}

String _syncTargetKey(String kind, Iterable<String> parts) {
  return '$kind:${parts.map(_encodeTargetKeyPart).join(':')}';
}

String _encodeCompositeTargetId(Iterable<String> parts) {
  return parts.map(_encodeTargetKeyPart).join(':');
}

List<String> _decodeCompositeTargetId(String? value) {
  if (value == null || value.isEmpty) {
    return const <String>[];
  }
  final parts = <String>[];
  final buffer = StringBuffer();
  for (var index = 0; index < value.length; index++) {
    final char = value[index];
    if (char == ':') {
      parts.add(_decodeTargetKeyPart(buffer.toString()));
      buffer.clear();
      continue;
    }
    buffer.write(char);
  }
  parts.add(_decodeTargetKeyPart(buffer.toString()));
  return parts;
}

String _encodeTargetKeyPart(String value) {
  return value.replaceAll('%', '%25').replaceAll(':', '%3A');
}

String _decodeTargetKeyPart(String value) {
  return value.replaceAll('%3A', ':').replaceAll('%25', '%');
}
