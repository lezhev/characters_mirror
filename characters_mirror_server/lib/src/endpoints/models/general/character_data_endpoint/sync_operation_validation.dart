part of '../character_data_endpoint.dart';

void _validateSyncSnapshotChanges({
  required CharacterData current,
  required CharacterData next,
}) {
  final changedFields = <String>{};
  for (final targetKey in _changedSyncTargetKeys(current, next)) {
    final separator = targetKey.indexOf(':');
    if (separator < 0) continue;
    final kind = targetKey.substring(0, separator);
    if (kind == 'resource') {
      changedFields.add('resourceStates');
      continue;
    }
    final parts = _decodeCompositeTargetId(targetKey.substring(separator + 1));
    if (parts.isNotEmpty) {
      changedFields.add(parts.first);
    }
  }

  final json = next.toJson();
  CharacterValidator.validate(
    CharacterData.fromJson({
      for (final field in changedFields)
        if (json.containsKey(field)) field: json[field],
    }),
  );
}

void _validateSyncOperationResult({
  required CharacterSyncOperationData operation,
  required CharacterData current,
  required CharacterData next,
}) {
  switch (operation.type) {
    case CharacterSyncOperationType.createCharacter:
      CharacterValidator.validate(next);
      return;
    case CharacterSyncOperationType.deleteCharacter:
    case CharacterSyncOperationType.removeMapEntry:
    case CharacterSyncOperationType.removeListItem:
      return;
    case CharacterSyncOperationType.setField:
      _validateSyncField(next, operation.fieldPath);
      return;
    case CharacterSyncOperationType.setMapEntry:
      _validateSyncMapEntry(operation);
      _validateTopLevelCollectionGrowth(
        current: current,
        next: next,
        field: operation.fieldPath,
        sizeRule: Rules.smallCollection,
      );
      return;
    case CharacterSyncOperationType.upsertListItem:
      _validateSyncListItem(operation);
      if (operation.targetType ==
          CharacterSyncTargetType.startingEquipmentResolution) {
        _validateStartingEquipmentResolutionGrowth(current, next, operation);
      } else {
        _validateTopLevelCollectionGrowth(
          current: current,
          next: next,
          field: operation.fieldPath,
          sizeRule: Rules.mediumCollection,
        );
      }
      CharacterValidator.validateLogicalIdentities(
        next,
        field: operation.fieldPath,
      );
      return;
    case CharacterSyncOperationType.addSetMember:
    case CharacterSyncOperationType.removeSetMember:
    case CharacterSyncOperationType.setMemberValue:
      _validateSyncMember(next, operation.fieldPath);
      CharacterValidator.validateLogicalIdentities(
        next,
        field: operation.fieldPath,
      );
      return;
    case CharacterSyncOperationType.applyDamage:
    case CharacterSyncOperationType.heal:
    case CharacterSyncOperationType.grantTemporaryHp:
    case CharacterSyncOperationType.adjustSpellSlots:
    case CharacterSyncOperationType.castSpell:
    case CharacterSyncOperationType.adjustHitDice:
    case CharacterSyncOperationType.adjustResource:
    case CharacterSyncOperationType.adjustExperience:
    case CharacterSyncOperationType.applyRest:
      _validateSyncSnapshotChanges(current: current, next: next);
      return;
  }
}

void _validateSyncMember(CharacterData character, String? field) {
  if (field == null || field.isEmpty) {
    throw Exception('Member operation requires fieldPath.');
  }
  final json = character.toJson();
  CharacterValidator.validate(
    CharacterData.fromJson({
      if (json.containsKey(field)) field: json[field],
    }),
  );
}

void _validateSyncField(CharacterData character, String? field) {
  if (field == null || field.isEmpty) {
    throw Exception('Field operation requires fieldPath.');
  }
  final json = character.toJson();
  CharacterValidator.validate(
    CharacterData.fromJson({
      if (json.containsKey(field)) field: json[field],
    }),
  );
}

void _validateSyncMapEntry(CharacterSyncOperationData operation) {
  final field = operation.fieldPath;
  final targetId = operation.targetId;
  final value = operation.value?.intValue;
  if (field == null || targetId == null || value == null) {
    throw Exception('Map operation requires fieldPath, targetId, and value.');
  }

  final projection = switch (field) {
    'baseAbilityScores' ||
    'customAbilityBonuses' ||
    'currentHitDice' ||
    'hitDiceMaxOverrides' =>
      <String, dynamic>{
        field: <String, int>{targetId: value},
      },
    'currentSpellSlots' => <String, dynamic>{
        field: [
          {'k': int.parse(targetId), 'v': value},
        ],
      },
    _ => throw Exception('Unsupported map field "$field".'),
  };
  CharacterValidator.validate(CharacterData.fromJson(projection));
}

void _validateSyncListItem(CharacterSyncOperationData operation) {
  final field = operation.fieldPath;
  if (field == null || field.isEmpty) {
    throw Exception('List operation requires fieldPath.');
  }
  if (operation.targetType ==
      CharacterSyncTargetType.startingEquipmentResolution) {
    final resolution = operation.itemPayload?.startingEquipmentResolutionValue;
    if (resolution == null) {
      throw Exception(
        'Starting equipment resolution operation requires payload.',
      );
    }
    CharacterValidator.validate(
      CharacterData(
        startingEquipmentSelections: [
          CharacterStartingEquipmentSelectionData(
            resolutions: [resolution],
          ),
        ],
      ),
    );
    return;
  }

  final payload = operation.itemPayload;
  final itemJson = switch (field) {
    'notes' => payload?.noteValue?.toJson(),
    'equipment' => payload?.equipmentValue?.toJson(),
    'attacks' => payload?.attackValue?.toJson(),
    'featureOverrides' => payload?.featureOverrideValue?.toJson(),
    'resourceStates' => payload?.resourceStateValue?.toJson(),
    'classEntries' => payload?.classEntryValue?.toJson(),
    'choices' => payload?.choiceValue?.toJson(),
    'skillSelections' => payload?.skillSelectionValue?.toJson(),
    'spellSelections' => payload?.spellSelectionValue?.toJson(),
    'startingEquipmentSelections' =>
      payload?.startingEquipmentSelectionValue?.toJson(),
    _ => throw Exception('Unsupported list field "$field".'),
  };
  if (itemJson == null) {
    throw Exception('List operation requires item payload.');
  }
  CharacterValidator.validate(
    CharacterData.fromJson({
      field: [itemJson],
    }),
  );
}

void _validateTopLevelCollectionGrowth({
  required CharacterData current,
  required CharacterData next,
  required String? field,
  required void Function(String field, Object? value) sizeRule,
}) {
  if (field == null || field.isEmpty) {
    throw Exception('Collection operation requires fieldPath.');
  }
  final currentValue = current.toJson()[field];
  final nextValue = next.toJson()[field];
  if (_syncCollectionLength(nextValue) > _syncCollectionLength(currentValue)) {
    sizeRule(field, nextValue);
  }
}

void _validateStartingEquipmentResolutionGrowth(
  CharacterData current,
  CharacterData next,
  CharacterSyncOperationData operation,
) {
  final parts = _decodeCompositeTargetId(operation.targetId);
  if (parts.length != 2) {
    throw Exception(
      'Starting equipment resolution operation requires targetId.',
    );
  }
  final currentResolutions = _startingEquipmentResolutions(current, parts[0]);
  final nextResolutions = _startingEquipmentResolutions(next, parts[0]);
  if (nextResolutions.length > currentResolutions.length) {
    Rules.smallCollection(
      'startingEquipmentSelections.resolutions',
      nextResolutions,
    );
  }
}

List<CharacterStartingEquipmentResolutionData> _startingEquipmentResolutions(
  CharacterData character,
  String selectionId,
) {
  return _findStartingEquipmentSelection(character, selectionId)?.resolutions ??
      const <CharacterStartingEquipmentResolutionData>[];
}

int _syncCollectionLength(Object? value) {
  return switch (value) {
    Iterable<Object?> iterable => iterable.length,
    Map<Object?, Object?> map => map.length,
    _ => 0,
  };
}
