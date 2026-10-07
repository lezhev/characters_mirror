part of '../character_data_endpoint.dart';

const _semanticProtocolVersion = 4;

bool _isSemanticOperation(CharacterSyncOperationData operation) {
  return switch (operation.type) {
    CharacterSyncOperationType.applyDamage ||
    CharacterSyncOperationType.heal ||
    CharacterSyncOperationType.grantTemporaryHp ||
    CharacterSyncOperationType.adjustSpellSlots ||
    CharacterSyncOperationType.castSpell ||
    CharacterSyncOperationType.adjustHitDice ||
    CharacterSyncOperationType.adjustResource ||
    CharacterSyncOperationType.adjustExperience ||
    CharacterSyncOperationType.applyRest =>
      true,
    _ => false,
  };
}

int _minimumProtocolVersionForOperation(CharacterSyncOperationData operation) {
  if (_isSemanticOperation(operation)) return _semanticProtocolVersion;
  if (_isMemberOperation(operation)) return 3;
  return 0;
}

List<String> _semanticActionTargetKeys(
  CharacterData character,
  CharacterSyncOperationData operation,
) {
  final action = operation.value?.semanticActionValue;
  switch (operation.type) {
    case CharacterSyncOperationType.applyDamage:
      return [
        _fieldTargetKey('currentHp'),
        _fieldTargetKey('temporaryHp'),
      ];
    case CharacterSyncOperationType.heal:
      return [
        _fieldTargetKey('currentHp'),
        _fieldTargetKey('deathSaveSuccesses'),
        _fieldTargetKey('deathSaveFailures'),
      ];
    case CharacterSyncOperationType.grantTemporaryHp:
      return [_fieldTargetKey('temporaryHp')];
    case CharacterSyncOperationType.adjustSpellSlots:
      return spellSlotActionTargetKeys(
          character.toJson(), action?.toJson() ?? {});
    case CharacterSyncOperationType.castSpell:
      return [
        ...spellSlotActionTargetKeys(
            character.toJson(), action?.toJson() ?? {}),
        if (spellCastStartsConcentration(
            character.toJson(), action?.toJson() ?? {}))
          _fieldTargetKey('activeConcentrationSpellName'),
      ];
    case CharacterSyncOperationType.adjustHitDice:
      return [_mapTargetKey('currentHitDice', action?.dieKind ?? '')];
    case CharacterSyncOperationType.adjustResource:
      return [
        _resourceTargetKey(
          action?.sourceType?.name ?? '',
          action?.sourceId ?? 0,
          action?.resourceKey ?? '',
        ),
      ];
    case CharacterSyncOperationType.adjustExperience:
      return [_fieldTargetKey('experience')];
    case CharacterSyncOperationType.applyRest:
      return _restTargetKeys(character, action?.restType);
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

List<String> _restTargetKeys(CharacterData character, RestType? restType) {
  if (restType != RestType.shortRest && restType != RestType.longRest) {
    return const [];
  }
  final result = <String>{};
  for (final feature in character.derived?.activeFeatures ??
      const <CharacterFeatureViewData>[]) {
    for (final resource
        in feature.resources ?? const <CharacterResourceViewData>[]) {
      if (_serverResourceShouldRestore(resource, restType!)) {
        result.add(_resourceTargetKey(
          feature.sourceType.name,
          feature.sourceId,
          resource.key,
        ));
      }
    }
  }
  final pactLevels = {
    ...?character.derived?.pactSlots?.keys,
    ...?character.currentPactSlots?.keys
  };
  result.addAll(
      pactLevels.map((level) => _mapTargetKey('currentPactSlots', '$level')));
  if (character.currentPactSlots == null && pactLevels.isNotEmpty) {
    result.addAll({
      ...?character.derived?.spellSlots?.keys,
      ...?character.currentSpellSlots?.keys
    }.map((level) => _mapTargetKey('currentSpellSlots', '$level')));
  }
  if (restType == RestType.longRest) {
    result.addAll([
      _fieldTargetKey('currentHp'),
      _fieldTargetKey('temporaryHp'),
      _fieldTargetKey('deathSaveSuccesses'),
      _fieldTargetKey('deathSaveFailures'),
    ]);
    final slotLevels = <int>{
      ...?character.derived?.spellSlots?.keys,
      ...?character.currentSpellSlots?.keys,
    };
    result.addAll(slotLevels.map(
      (level) => _mapTargetKey('currentSpellSlots', '$level'),
    ));
    final dieKinds = <String>{
      ...?character.derived?.hitDiceSummary?.keys,
      ...?character.currentHitDice?.keys,
    };
    result.addAll(dieKinds.map(
      (kind) => _mapTargetKey('currentHitDice', kind),
    ));
  }
  final sorted = result.toList()..sort();
  return sorted;
}

String _materializedBarrierToken(
  CharacterData character,
  String targetKey,
) {
  final direct = character.syncBarrierTokens?[targetKey];
  if (direct != null) return direct;
  final revision = character.syncTargetRevisions?[targetKey] ?? 0;
  return 'revision:$revision';
}

_SemanticActionFailure? _semanticBarrierFailure(
  CharacterData character,
  CharacterSyncOperationData operation,
) {
  final action = operation.value?.semanticActionValue;
  if (action == null) {
    return const _SemanticActionFailure(
      'invalid_action',
      'Semantic operation requires a typed action payload.',
    );
  }
  final expected = action.baseBarrierTokens ?? const <String, String>{};
  for (final target in _semanticActionTargetKeys(character, operation)) {
    if (expected[target] != _materializedBarrierToken(character, target)) {
      return const _SemanticActionFailure(
        'crossed_barrier',
        'A manual correction or reset changed the action baseline.',
      );
    }
  }
  return null;
}

Map<String, String> _barrierTokensAfterOperation({
  required CharacterData current,
  required CharacterSyncOperationData operation,
  required Set<String> changedTargets,
}) {
  final result = <String, String>{...?current.syncBarrierTokens};
  if (_isSemanticOperation(operation)) {
    final targets = _semanticActionTargetKeys(current, operation);
    for (final target in targets) {
      result.putIfAbsent(
        target,
        () => _materializedBarrierToken(current, target),
      );
    }
    if (operation.type == CharacterSyncOperationType.applyRest) {
      for (final target in targets) {
        result[target] = operation.id;
      }
    }
  } else {
    for (final target in changedTargets.where(_isSemanticBarrierTarget)) {
      result[target] = operation.id;
    }
  }
  return result;
}

bool _isSemanticBarrierTarget(String target) {
  return target == _fieldTargetKey('currentHp') ||
      target == _fieldTargetKey('temporaryHp') ||
      target == _fieldTargetKey('deathSaveSuccesses') ||
      target == _fieldTargetKey('deathSaveFailures') ||
      target == _fieldTargetKey('activeConcentrationSpellName') ||
      target == _fieldTargetKey('experience') ||
      target.startsWith('map:currentSpellSlots:') ||
      target.startsWith('map:currentPactSlots:') ||
      target.startsWith('map:currentHitDice:') ||
      target.startsWith('resource:');
}

CharacterData _applySemanticActionToCharacter(
  CharacterData character,
  CharacterSyncOperationData operation,
) {
  final action = operation.value?.semanticActionValue;
  if (action == null) {
    throw const _SemanticActionFailure(
      'invalid_action',
      'Semantic operation requires a typed action payload.',
    );
  }
  return switch (operation.type) {
    CharacterSyncOperationType.applyDamage =>
      _applyServerDamage(character, _requiredPositiveAmount(action)),
    CharacterSyncOperationType.heal =>
      _applyServerHealing(character, _requiredPositiveAmount(action)),
    CharacterSyncOperationType.grantTemporaryHp =>
      _grantServerTemporaryHp(character, _requiredPositiveAmount(action)),
    CharacterSyncOperationType.adjustSpellSlots =>
      _adjustServerSpellSlots(character, action),
    CharacterSyncOperationType.castSpell => _castServerSpell(character, action),
    CharacterSyncOperationType.adjustHitDice =>
      _adjustServerHitDice(character, action),
    CharacterSyncOperationType.adjustResource =>
      _adjustServerResource(character, action),
    CharacterSyncOperationType.adjustExperience =>
      _adjustServerExperience(character, action),
    CharacterSyncOperationType.applyRest => _applyServerRest(character, action),
    _ => throw const _SemanticActionFailure(
        'invalid_action',
        'Operation is not a semantic action.',
      ),
  };
}

int _requiredPositiveAmount(CharacterSemanticActionData action) {
  final amount = action.amount;
  if (amount == null || amount <= 0) {
    throw const _SemanticActionFailure(
      'invalid_action',
      'Action amount must be positive.',
    );
  }
  Rules.nonNegativeInt('semanticAction.amount', amount);
  return amount;
}

CharacterData _applyServerDamage(CharacterData character, int amount) {
  final maxHp = max(0, character.derived?.maxHp ?? 0);
  final currentHp = (character.currentHp ?? maxHp).clamp(0, maxHp);
  final temporaryHp = max(0, character.temporaryHp ?? 0);
  final absorbed = min(temporaryHp, amount);
  final nextHp = max(0, currentHp - (amount - absorbed));
  return character.copyWith(
    currentHp: nextHp == maxHp ? null : nextHp,
    temporaryHp: temporaryHp - absorbed == 0 ? null : temporaryHp - absorbed,
  );
}

CharacterData _applyServerHealing(CharacterData character, int amount) {
  final maxHp = max(0, character.derived?.maxHp ?? 0);
  final currentHp = (character.currentHp ?? maxHp).clamp(0, maxHp);
  final nextHp = min(maxHp, currentHp + amount);
  return character.copyWith(
    currentHp: nextHp == maxHp ? null : nextHp,
    deathSaveSuccesses: nextHp > 0 ? null : character.deathSaveSuccesses,
    deathSaveFailures: nextHp > 0 ? null : character.deathSaveFailures,
  );
}

CharacterData _grantServerTemporaryHp(CharacterData character, int amount) {
  final next = (character.temporaryHp ?? 0) + amount;
  Rules.nonNegativeInt('temporaryHp', next);
  return character.copyWith(temporaryHp: next);
}

CharacterData _adjustServerSpellSlots(
    CharacterData character, CharacterSemanticActionData action) {
  try {
    return adjustCharacterSpellSlots(character, action);
  } on SpellCastFailure catch (error) {
    throw _SemanticActionFailure(error.code, error.message);
  }
}

CharacterData _castServerSpell(
  CharacterData character,
  CharacterSemanticActionData action,
) {
  if (action.spellKey != null ||
      action.spellSourceKey != null ||
      action.slotSource != null) {
    try {
      return applyCharacterSpellCast(character, action);
    } on SpellCastFailure catch (error) {
      throw _SemanticActionFailure(error.code, error.message);
    }
  }
  final level = action.level;
  if (level == null || level < 0 || level > 9) {
    throw const _SemanticActionFailure(
      'invalid_action',
      'Cast action requires spell level 0..9.',
    );
  }
  var next = character;
  if (level > 0) {
    next = _adjustServerSpellSlots(
      next,
      CharacterSemanticActionData(level: level, delta: -1),
    );
  }
  if (action.startsConcentration == true) {
    final name = action.spellName?.trim();
    if (name == null || name.isEmpty) {
      throw const _SemanticActionFailure(
        'invalid_action',
        'A concentration spell requires a name.',
      );
    }
    Rules.shortText('activeConcentrationSpellName', name);
    next = next.copyWith(activeConcentrationSpellName: name);
  }
  return next;
}

CharacterData _adjustServerHitDice(
  CharacterData character,
  CharacterSemanticActionData action,
) {
  final kind = action.dieKind?.trim();
  final delta = action.delta;
  if (kind == null || kind.isEmpty || delta == null || delta == 0) {
    throw const _SemanticActionFailure(
      'invalid_action',
      'Hit dice adjustment requires die kind and non-zero delta.',
    );
  }
  final maximum = character.derived?.hitDiceSummary?[kind];
  if (maximum == null || maximum <= 0) {
    throw const _SemanticActionFailure(
      'target_not_found',
      'The requested hit die does not exist.',
    );
  }
  final current =
      (character.currentHitDice?[kind] ?? maximum).clamp(0, maximum).toInt();
  final next = current + delta;
  if (next < 0) {
    throw const _SemanticActionFailure(
      'insufficient_resource',
      'Not enough hit dice are available.',
    );
  }
  if (next > maximum) {
    throw const _SemanticActionFailure(
      'resource_bounds',
      'Hit dice adjustment exceeds the canonical maximum.',
    );
  }
  return character.copyWith(
    currentHitDice: _updatedStringIntMap(
      character.currentHitDice,
      kind,
      next,
      removeWhen: maximum,
    ),
  );
}

CharacterData _adjustServerResource(
  CharacterData character,
  CharacterSemanticActionData action,
) {
  final sourceType = action.sourceType;
  final sourceId = action.sourceId;
  final resourceKey = action.resourceKey?.trim();
  final delta = action.delta;
  if (sourceType == null ||
      sourceId == null ||
      resourceKey == null ||
      resourceKey.isEmpty ||
      delta == null ||
      delta == 0) {
    throw const _SemanticActionFailure(
      'invalid_action',
      'Resource adjustment requires identity and non-zero delta.',
    );
  }
  CharacterResourceViewData? resource;
  for (final feature in character.derived?.activeFeatures ??
      const <CharacterFeatureViewData>[]) {
    if (feature.sourceType != sourceType || feature.sourceId != sourceId) {
      continue;
    }
    resource = feature.resources
        ?.where((value) => value.key == resourceKey)
        .firstOrNull;
    if (resource != null) break;
  }
  if (resource == null || resource.isUnlimited == true) {
    throw const _SemanticActionFailure(
      'target_not_found',
      'The requested finite feature resource does not exist.',
    );
  }
  final next = resource.current + delta;
  if (next < 0) {
    throw const _SemanticActionFailure(
      'insufficient_resource',
      'Not enough feature resource is available.',
    );
  }
  if (next > resource.max) {
    throw const _SemanticActionFailure(
      'resource_bounds',
      'Resource adjustment exceeds the canonical maximum.',
    );
  }
  return character.copyWith(
    resourceStates: _updatedServerResourceStates(
      character.resourceStates,
      sourceType,
      sourceId,
      resourceKey,
      next,
      resource.max,
    ),
  );
}

CharacterData _adjustServerExperience(
  CharacterData character,
  CharacterSemanticActionData action,
) {
  final delta = action.delta;
  if (delta == null || delta == 0) {
    throw const _SemanticActionFailure(
      'invalid_action',
      'Experience adjustment requires a non-zero delta.',
    );
  }
  final next = (character.experience ?? 0) + delta;
  if (next < 0) {
    throw const _SemanticActionFailure(
      'insufficient_resource',
      'Experience cannot become negative.',
    );
  }
  Rules.nonNegativeInt('experience', next);
  return character.copyWith(experience: next);
}

CharacterData _applyServerRest(
  CharacterData character,
  CharacterSemanticActionData action,
) {
  final restType = action.restType;
  if (restType != RestType.shortRest && restType != RestType.longRest) {
    throw const _SemanticActionFailure(
      'invalid_action',
      'Only short and long rest actions are supported.',
    );
  }
  final restoredResources = <String>{};
  for (final feature in character.derived?.activeFeatures ??
      const <CharacterFeatureViewData>[]) {
    for (final resource
        in feature.resources ?? const <CharacterResourceViewData>[]) {
      if (_serverResourceShouldRestore(resource, restType!)) {
        restoredResources.add(_resourceTargetKey(
          feature.sourceType.name,
          feature.sourceId,
          resource.key,
        ));
      }
    }
  }
  final resourceStates = [
    for (final state
        in character.resourceStates ?? const <CharacterResourceStateData>[])
      if (!restoredResources.contains(_resourceTargetKey(
        state.sourceType.name,
        state.sourceId,
        state.resourceKey,
      )))
        state,
  ];
  final pools = SpellSlotPools.fromCharacter(character.toJson());
  final materialized = pools.materialized;
  var next = character.copyWith(
    resourceStates: resourceStates.isEmpty ? null : resourceStates,
    currentSpellSlots:
        character.currentPactSlots == null && pools.pactMax.isNotEmpty
            ? (materialized['currentSpellSlots'] == null
                ? null
                : spellProtocolIntMap<int>(materialized['currentSpellSlots']))
            : character.currentSpellSlots,
    currentPactSlots: pools.pactMax.isEmpty ? null : pools.pactMax,
  );
  if (restType == RestType.longRest) {
    next = next.copyWith(
      currentHp: null,
      temporaryHp: null,
      deathSaveSuccesses: null,
      deathSaveFailures: null,
      currentSpellSlots: null,
      currentHitDice: _serverLongRestHitDice(character),
    );
  }
  return next;
}

bool _serverResourceShouldRestore(
  CharacterResourceViewData resource,
  RestType restType,
) {
  return switch (restType) {
    RestType.shortRest => resource.resetOn == RestType.shortRest,
    RestType.longRest => resource.resetOn == RestType.shortRest ||
        resource.resetOn == RestType.longRest,
    RestType.dawn || RestType.special => false,
  };
}

Map<String, int>? _serverLongRestHitDice(CharacterData character) {
  final maximum = character.derived?.hitDiceSummary ?? const <String, int>{};
  if (maximum.isEmpty) return null;
  final restored = <String, int>{
    for (final entry in maximum.entries)
      entry.key: (character.currentHitDice?[entry.key] ?? entry.value)
          .clamp(0, entry.value)
          .toInt(),
  };
  var remaining = maximum.values.fold<int>(0, (sum, value) => sum + value) ~/ 2;
  if (remaining <= 0) remaining = 1;
  final keys = maximum.keys.toList()
    ..sort((left, right) {
      final size = _serverHitDieSize(right).compareTo(_serverHitDieSize(left));
      return size != 0 ? size : left.compareTo(right);
    });
  for (final key in keys) {
    if (remaining <= 0) break;
    final missing = (maximum[key] ?? 0) - (restored[key] ?? 0);
    if (missing <= 0) continue;
    final amount = min(missing, remaining);
    restored[key] = (restored[key] ?? 0) + amount;
    remaining -= amount;
  }
  final sparse = <String, int>{};
  for (final entry in restored.entries) {
    if (entry.value != maximum[entry.key]) sparse[entry.key] = entry.value;
  }
  return sparse.isEmpty ? null : sparse;
}

int _serverHitDieSize(String value) {
  return value.startsWith('d') ? int.tryParse(value.substring(1)) ?? 0 : 0;
}

Map<K, int>? _updatedIntMap<K>(
  Map<K, int>? source,
  K key,
  int value, {
  required int removeWhen,
}) {
  final result = <K, int>{...?source};
  if (value == removeWhen) {
    result.remove(key);
  } else {
    result[key] = value;
  }
  return result.isEmpty ? null : result;
}

Map<String, int>? _updatedStringIntMap(
  Map<String, int>? source,
  String key,
  int value, {
  required int removeWhen,
}) {
  final result = _updatedIntMap(source, key, value, removeWhen: removeWhen);
  if (result == null) return null;
  final keys = result.keys.toList()..sort();
  return {for (final item in keys) item: result[item]!};
}

List<CharacterResourceStateData>? _updatedServerResourceStates(
  List<CharacterResourceStateData>? source,
  CharacterFeatureSourceType sourceType,
  int sourceId,
  String resourceKey,
  int current,
  int maximum,
) {
  final result = [
    for (final state in source ?? const <CharacterResourceStateData>[])
      if (state.sourceType != sourceType ||
          state.sourceId != sourceId ||
          state.resourceKey != resourceKey)
        state,
    if (current != maximum)
      CharacterResourceStateData(
        sourceType: sourceType,
        sourceId: sourceId,
        resourceKey: resourceKey,
        current: current,
      ),
  ]..sort((left, right) {
      final type = left.sourceType.name.compareTo(right.sourceType.name);
      if (type != 0) return type;
      final id = left.sourceId.compareTo(right.sourceId);
      return id != 0 ? id : left.resourceKey.compareTo(right.resourceKey);
    });
  return result.isEmpty ? null : result;
}

class _SemanticActionFailure implements Exception {
  const _SemanticActionFailure(this.reason, this.message);

  final String reason;
  final String message;

  @override
  String toString() => message;
}
