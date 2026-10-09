import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_target_keys.dart';

import 'package:characters_mirror_shared/characters_mirror_shared.dart';

const characterSemanticSyncProtocolVersion = 6;

bool isCharacterSemanticOperation(CharacterSyncOperationType type) {
  return switch (type) {
    CharacterSyncOperationType.applyDamage ||
    CharacterSyncOperationType.heal ||
    CharacterSyncOperationType.grantTemporaryHp ||
    CharacterSyncOperationType.adjustSpellSlots ||
    CharacterSyncOperationType.castSpell ||
    CharacterSyncOperationType.adjustHitDice ||
    CharacterSyncOperationType.adjustResource ||
    CharacterSyncOperationType.adjustExperience ||
    CharacterSyncOperationType.recoverSpellSlots ||
    CharacterSyncOperationType.applyRest =>
      true,
    _ => false,
  };
}

List<String> characterSemanticActionTargetKeys(
  CharacterData character,
  CharacterSyncOperationType type,
  CharacterSemanticActionData action,
) {
  switch (type) {
    case CharacterSyncOperationType.applyDamage:
      return [
        characterSyncFieldTargetKey('currentHp'),
        characterSyncFieldTargetKey('temporaryHp'),
      ];
    case CharacterSyncOperationType.heal:
      return [
        characterSyncFieldTargetKey('currentHp'),
        characterSyncFieldTargetKey('deathSaveSuccesses'),
        characterSyncFieldTargetKey('deathSaveFailures'),
      ];
    case CharacterSyncOperationType.grantTemporaryHp:
      return [characterSyncFieldTargetKey('temporaryHp')];
    case CharacterSyncOperationType.adjustSpellSlots:
      return spellSlotActionTargetKeys(character.toJson(), action.toJson());
    case CharacterSyncOperationType.castSpell:
      return [
        ...spellSlotRecoveryEventTargetKeys(character.toJson()),
        ...spellActivationActionTargets(character.toJson(), action.toJson()),
        if (spellCastStartsConcentration(character.toJson(), action.toJson()))
          characterSyncFieldTargetKey('activeConcentrationSpellName'),
      ];
    case CharacterSyncOperationType.adjustHitDice:
      return [
        characterSyncMapTargetKey('currentHitDice', action.dieKind ?? ''),
      ];
    case CharacterSyncOperationType.adjustResource:
      return [
        characterSyncResourceTargetKey(
          action.sourceType ?? CharacterFeatureSourceType.classFeature,
          action.sourceId ?? 0,
          action.resourceKey ?? '',
        ),
      ];
    case CharacterSyncOperationType.adjustExperience:
      return [characterSyncFieldTargetKey('experience')];
    case CharacterSyncOperationType.applyRest:
      return _characterRestTargetKeys(character, action.restType);
    case CharacterSyncOperationType.recoverSpellSlots:
      return spellSlotRecoveryActionTargetKeys(
          character.toJson(), action.toJson());
    case CharacterSyncOperationType.createCharacter:
    case CharacterSyncOperationType.deleteCharacter:
    case CharacterSyncOperationType.setField:
    case CharacterSyncOperationType.setMapEntry:
    case CharacterSyncOperationType.removeMapEntry:
    case CharacterSyncOperationType.upsertListItem:
    case CharacterSyncOperationType.removeListItem:
    case CharacterSyncOperationType.addSetMember:
    case CharacterSyncOperationType.removeSetMember:
    case CharacterSyncOperationType.setMemberValue:
      return const [];
  }
}

CharacterSyncOperationData createCharacterSemanticOperation({
  required CharacterData character,
  required int localId,
  required int serverId,
  required CharacterSyncOperationType type,
  required CharacterSemanticActionData action,
  required String changeId,
  required DateTime createdAt,
}) {
  final targets = characterSemanticActionTargetKeys(character, type, action);
  final baseBarrierTokens = {
    for (final target in targets)
      target: materializedCharacterBarrierToken(character, target),
  };
  final primaryTarget = targets.firstOrNull;
  return CharacterSyncOperationData(
    id: changeId,
    characterId: serverId,
    localCharacterId: localId,
    type: type,
    targetType: _targetTypeForSemanticAction(type),
    targetId: _targetIdForSemanticAction(type, action),
    fieldPath: _fieldPathForSemanticAction(type, action),
    value: CharacterSyncValueData(
      semanticActionValue: action.copyWith(
        baseBarrierTokens: baseBarrierTokens,
      ),
    ),
    baseCharacterRevision: character.version,
    baseTargetRevision: primaryTarget == null
        ? character.version
        : character.syncTargetRevisions?[primaryTarget] ?? character.version,
    createdAt: createdAt,
  );
}

CharacterSyncOperationData rebaseCharacterSemanticOperation(
  CharacterData character,
  CharacterSyncOperationData operation,
) {
  final action = operation.value?.semanticActionValue;
  if (action == null || !isCharacterSemanticOperation(operation.type)) {
    return operation;
  }
  final targets = characterSemanticActionTargetKeys(
    character,
    operation.type,
    action,
  );
  final tokens = {
    for (final target in targets)
      target: materializedCharacterBarrierToken(character, target),
  };
  return operation.copyWith(
    characterId: character.id,
    baseCharacterRevision: character.version,
    baseTargetRevision: targets.isEmpty
        ? character.version
        : character.syncTargetRevisions?[targets.first] ?? character.version,
    value: CharacterSyncValueData(
      semanticActionValue: action.copyWith(baseBarrierTokens: tokens),
    ),
  );
}

CharacterData materializeLocalBarrierTokens(
  CharacterData character,
  CharacterSyncOperationData operation,
) {
  final action = operation.value?.semanticActionValue;
  if (action == null || !isCharacterSemanticOperation(operation.type)) {
    return character;
  }
  final result = <String, String>{...?character.syncBarrierTokens};
  final targets = characterSemanticActionTargetKeys(
    character,
    operation.type,
    action,
  );
  for (final target in targets) {
    result.putIfAbsent(
      target,
      () => materializedCharacterBarrierToken(character, target),
    );
  }
  if (operation.type == CharacterSyncOperationType.applyRest) {
    for (final target in targets) {
      result[target] = operation.id;
    }
  }
  if (targets.contains(characterSyncFieldTargetKey('spellRecoveryTriggers')) &&
      (operation.type == CharacterSyncOperationType.castSpell ||
          operation.type == CharacterSyncOperationType.applyRest ||
          operation.type == CharacterSyncOperationType.recoverSpellSlots)) {
    result[characterSyncFieldTargetKey('spellRecoveryTriggers')] = operation.id;
  }
  return character.copyWith(syncBarrierTokens: result.isEmpty ? null : result);
}

String materializedCharacterBarrierToken(
  CharacterData character,
  String target,
) {
  return character.syncBarrierTokens?[target] ??
      'revision:${character.syncTargetRevisions?[target] ?? 0}';
}

bool isCharacterSemanticBarrierTarget(String target) {
  return target == characterSyncFieldTargetKey('currentHp') ||
      target == characterSyncFieldTargetKey('spellRecoveryTriggers') ||
      target == characterSyncFieldTargetKey('temporaryHp') ||
      target == characterSyncFieldTargetKey('deathSaveSuccesses') ||
      target == characterSyncFieldTargetKey('deathSaveFailures') ||
      target == characterSyncFieldTargetKey('activeConcentrationSpellName') ||
      target == characterSyncFieldTargetKey('experience') ||
      target.startsWith('map:currentSpellSlots:') ||
      target.startsWith('map:spellActivationUses:') ||
      target.startsWith('map:currentPactSlots:') ||
      target.startsWith('map:currentHitDice:') ||
      target.startsWith('resource:');
}

CharacterData applyLocalAbsoluteBarrierTokens(
  CharacterData character,
  Iterable<CharacterSyncOperationData> operations,
  String Function(CharacterSyncOperationData operation) targetKeyOf,
) {
  final result = <String, String>{...?character.syncBarrierTokens};
  for (final operation in operations) {
    if (isCharacterSemanticOperation(operation.type)) continue;
    final target = targetKeyOf(operation);
    if (isCharacterSemanticBarrierTarget(target)) {
      result[target] = operation.id;
    }
  }
  return character.copyWith(syncBarrierTokens: result.isEmpty ? null : result);
}

List<String> _characterRestTargetKeys(
  CharacterData character,
  RestType? restType,
) {
  if (restType == null || restType == RestType.special) {
    return const [];
  }
  final targets = <String>{
    ...spellActivationRestTargets(character.toJson(), restType.name),
    ...spellSlotRecoveryEventTargetKeys(character.toJson())
  };
  for (final feature in character.derived?.activeFeatures ??
      const <CharacterFeatureViewData>[]) {
    for (final resource
        in feature.resources ?? const <CharacterResourceViewData>[]) {
      if (_resourceRestoresOn(resource, restType)) {
        targets.add(characterSyncResourceTargetKey(
          feature.sourceType,
          feature.sourceId,
          resource.key,
        ));
      }
    }
  }
  final pactLevels =
      restType == RestType.shortRest || restType == RestType.longRest
          ? <int>{
              ...?character.derived?.pactSlots?.keys,
              ...?character.currentPactSlots?.keys
            }
          : <int>{};
  targets.addAll(pactLevels
      .map((level) => characterSyncMapTargetKey('currentPactSlots', '$level')));
  if (character.currentPactSlots == null && pactLevels.isNotEmpty) {
    targets.addAll({
      ...?character.derived?.spellSlots?.keys,
      ...?character.currentSpellSlots?.keys
    }.map((level) => characterSyncMapTargetKey('currentSpellSlots', '$level')));
  }
  if (restType == RestType.longRest) {
    targets.addAll([
      characterSyncFieldTargetKey('currentHp'),
      characterSyncFieldTargetKey('temporaryHp'),
      characterSyncFieldTargetKey('deathSaveSuccesses'),
      characterSyncFieldTargetKey('deathSaveFailures'),
    ]);
    final levels = <int>{
      ...?character.derived?.spellSlots?.keys,
      ...?character.currentSpellSlots?.keys,
    };
    targets.addAll(levels.map(
      (level) => characterSyncMapTargetKey('currentSpellSlots', '$level'),
    ));
    final kinds = <String>{
      ...?character.derived?.hitDiceSummary?.keys,
      ...?character.currentHitDice?.keys,
    };
    targets.addAll(kinds.map(
      (kind) => characterSyncMapTargetKey('currentHitDice', kind),
    ));
  }
  final sorted = targets.toList()..sort();
  return sorted;
}

bool _resourceRestoresOn(
    CharacterResourceViewData resource, RestType restType) {
  return switch (restType) {
    RestType.shortRest => resource.resetOn == RestType.shortRest,
    RestType.longRest => resource.resetOn == RestType.shortRest ||
        resource.resetOn == RestType.longRest,
    RestType.dawn || RestType.special => resource.resetOn == restType,
  };
}

CharacterSyncTargetType _targetTypeForSemanticAction(
  CharacterSyncOperationType type,
) {
  return switch (type) {
    CharacterSyncOperationType.adjustSpellSlots ||
    CharacterSyncOperationType.adjustHitDice =>
      CharacterSyncTargetType.mapEntry,
    CharacterSyncOperationType.adjustResource =>
      CharacterSyncTargetType.resource,
    CharacterSyncOperationType.applyRest => CharacterSyncTargetType.character,
    CharacterSyncOperationType.recoverSpellSlots =>
      CharacterSyncTargetType.character,
    _ => CharacterSyncTargetType.field,
  };
}

String? _fieldPathForSemanticAction(
    CharacterSyncOperationType type, CharacterSemanticActionData action) {
  return switch (type) {
    CharacterSyncOperationType.applyDamage ||
    CharacterSyncOperationType.heal =>
      'currentHp',
    CharacterSyncOperationType.grantTemporaryHp => 'temporaryHp',
    CharacterSyncOperationType.adjustSpellSlots ||
    CharacterSyncOperationType.castSpell =>
      action.slotSource == 'pact' ? 'currentPactSlots' : 'currentSpellSlots',
    CharacterSyncOperationType.adjustHitDice => 'currentHitDice',
    CharacterSyncOperationType.adjustResource => 'resourceStates',
    CharacterSyncOperationType.adjustExperience => 'experience',
    _ => null,
  };
}

String? _targetIdForSemanticAction(
  CharacterSyncOperationType type,
  CharacterSemanticActionData action,
) {
  return switch (type) {
    CharacterSyncOperationType.adjustSpellSlots ||
    CharacterSyncOperationType.castSpell =>
      '${action.level ?? ''}',
    CharacterSyncOperationType.adjustHitDice => action.dieKind,
    CharacterSyncOperationType.adjustResource =>
      encodeCharacterSyncCompositeId([
        action.sourceType?.name ?? '',
        '${action.sourceId ?? ''}',
        action.resourceKey ?? '',
      ]),
    _ => null,
  };
}
