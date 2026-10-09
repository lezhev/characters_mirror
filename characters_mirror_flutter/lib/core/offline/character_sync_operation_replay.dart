import 'dart:math';
import 'package:characters_mirror_flutter/core/character_spells/spell_cast_application.dart';
import 'package:characters_mirror_flutter/core/character_spells/spell_slot_recovery_application.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';

import 'package:characters_mirror_client/characters_mirror_client.dart';

CharacterData replayCharacterSyncOperation(
  CharacterData character,
  CharacterSyncOperationData operation,
) {
  if (_isSemantic(operation.type)) {
    return _replaySemantic(character, operation);
  }
  if (operation.type == CharacterSyncOperationType.createCharacter) {
    return (operation.itemPayload?.characterValue ??
            operation.value?.characterValue ??
            character)
        .copyWith(id: character.id);
  }
  if (operation.type == CharacterSyncOperationType.deleteCharacter) {
    return character;
  }

  final json = Map<String, dynamic>.from(character.toJson())..remove('derived');
  switch (operation.type) {
    case CharacterSyncOperationType.setField:
      _setField(json, operation.fieldPath, operation.value);
      break;
    case CharacterSyncOperationType.setMapEntry:
      _setMapEntry(json, operation);
      break;
    case CharacterSyncOperationType.removeMapEntry:
      _removeMapEntry(json, operation);
      break;
    case CharacterSyncOperationType.upsertListItem:
      _upsertListItem(json, operation);
      break;
    case CharacterSyncOperationType.removeListItem:
      _removeListItem(json, operation);
      break;
    case CharacterSyncOperationType.addSetMember:
    case CharacterSyncOperationType.removeSetMember:
    case CharacterSyncOperationType.setMemberValue:
      _applyMember(json, operation);
      break;
    case CharacterSyncOperationType.createCharacter:
    case CharacterSyncOperationType.deleteCharacter:
    case CharacterSyncOperationType.applyDamage:
    case CharacterSyncOperationType.heal:
    case CharacterSyncOperationType.grantTemporaryHp:
    case CharacterSyncOperationType.adjustSpellSlots:
    case CharacterSyncOperationType.castSpell:
    case CharacterSyncOperationType.adjustHitDice:
    case CharacterSyncOperationType.adjustResource:
    case CharacterSyncOperationType.adjustExperience:
    case CharacterSyncOperationType.recoverSpellSlots:
    case CharacterSyncOperationType.applyRest:
      break;
  }
  return CharacterData.fromJson(json).copyWith(
    id: character.id,
    version: character.version,
    derived: character.derived,
    syncTargetRevisions: character.syncTargetRevisions,
    syncBarrierTokens: character.syncBarrierTokens,
  );
}

bool _isSemantic(CharacterSyncOperationType type) => switch (type) {
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

CharacterData _replaySemantic(
  CharacterData character,
  CharacterSyncOperationData operation,
) {
  final action = operation.value?.semanticActionValue;
  if (action == null) throw StateError('Missing semantic action payload.');
  switch (operation.type) {
    case CharacterSyncOperationType.applyDamage:
      final amount = _positive(action.amount);
      final maximum = max(0, character.derived?.maxHp ?? 0);
      final current = (character.currentHp ?? maximum).clamp(0, maximum);
      final temporary = max(0, character.temporaryHp ?? 0);
      final absorbed = min(temporary, amount);
      final nextHp = max(0, current - (amount - absorbed));
      return character.copyWith(
        currentHp: nextHp == maximum ? null : nextHp,
        temporaryHp: temporary - absorbed == 0 ? null : temporary - absorbed,
      );
    case CharacterSyncOperationType.heal:
      final amount = _positive(action.amount);
      final maximum = max(0, character.derived?.maxHp ?? 0);
      final current = (character.currentHp ?? maximum).clamp(0, maximum);
      final next = min(maximum, current + amount);
      return character.copyWith(
        currentHp: next == maximum ? null : next,
        deathSaveSuccesses: next > 0 ? null : character.deathSaveSuccesses,
        deathSaveFailures: next > 0 ? null : character.deathSaveFailures,
      );
    case CharacterSyncOperationType.grantTemporaryHp:
      return character.copyWith(
        temporaryHp: (character.temporaryHp ?? 0) + _positive(action.amount),
      );
    case CharacterSyncOperationType.adjustSpellSlots:
      return _adjustSpellSlots(character, action);
    case CharacterSyncOperationType.castSpell:
      if (action.spellKey != null ||
          action.spellSourceKey != null ||
          action.slotSource != null) {
        return applyCharacterSpellRecoveryEvent(
            applyCharacterSpellCast(character, action),
            event: 'spellCast',
            sourceActionId: operation.id,
            action: action);
      }
      var next = character;
      final level = action.level;
      if (level == null || level < 0 || level > 9) {
        throw StateError('Invalid cast level.');
      }
      if (level > 0) {
        next = _adjustSpellSlots(
          next,
          CharacterSemanticActionData(level: level, delta: -1),
        );
      }
      if (action.startsConcentration == true) {
        next = next.copyWith(activeConcentrationSpellName: action.spellName);
      }
      return next;
    case CharacterSyncOperationType.adjustHitDice:
      final kind = action.dieKind;
      final delta = action.delta;
      final maximum = character.derived?.hitDiceSummary?[kind];
      if (kind == null || delta == null || maximum == null) {
        throw StateError('Invalid hit dice action.');
      }
      final current = character.currentHitDice?[kind] ?? maximum;
      final next = current + delta;
      if (next < 0 || next > maximum) throw StateError('Hit dice bounds.');
      return character.copyWith(
        currentHitDice: _updatedMap(
          character.currentHitDice,
          kind,
          next,
          removeWhen: maximum,
        ),
      );
    case CharacterSyncOperationType.adjustResource:
      return _adjustResource(character, action);
    case CharacterSyncOperationType.adjustExperience:
      final delta = action.delta;
      if (delta == null) throw StateError('Invalid experience action.');
      final next = (character.experience ?? 0) + delta;
      if (next < 0) throw StateError('Experience bounds.');
      return character.copyWith(experience: next);
    case CharacterSyncOperationType.applyRest:
      return applyCharacterSpellRecoveryEvent(
          _applyRest(character, action.restType),
          event: action.restType!.name,
          sourceActionId: operation.id);
    case CharacterSyncOperationType.recoverSpellSlots:
      return applyCharacterSpellSlotRecovery(character, action);
    default:
      return character;
  }
}

int _positive(int? value) {
  if (value == null || value <= 0) {
    throw StateError('Positive amount required.');
  }
  return value;
}

CharacterData _adjustSpellSlots(
        CharacterData character, CharacterSemanticActionData action) =>
    adjustCharacterSpellSlots(character, action);

CharacterData _adjustResource(
  CharacterData character,
  CharacterSemanticActionData action,
) {
  final sourceType = action.sourceType;
  final sourceId = action.sourceId;
  final key = action.resourceKey;
  final delta = action.delta;
  if (sourceType == null || sourceId == null || key == null || delta == null) {
    throw StateError('Invalid resource action.');
  }
  CharacterResourceViewData? resource;
  for (final feature in character.derived?.activeFeatures ??
      const <CharacterFeatureViewData>[]) {
    if (feature.sourceType == sourceType && feature.sourceId == sourceId) {
      for (final candidate
          in feature.resources ?? const <CharacterResourceViewData>[]) {
        if (candidate.key == key) resource = candidate;
      }
    }
  }
  if (resource == null || resource.isUnlimited == true) {
    throw StateError('Resource not found.');
  }
  final next = resource.current + delta;
  if (next < 0 || next > resource.max) throw StateError('Resource bounds.');
  final states = [
    for (final state
        in character.resourceStates ?? const <CharacterResourceStateData>[])
      if (state.sourceType != sourceType ||
          state.sourceId != sourceId ||
          state.resourceKey != key)
        state,
    if (next != resource.max)
      CharacterResourceStateData(
        sourceType: sourceType,
        sourceId: sourceId,
        resourceKey: key,
        current: next,
      ),
  ];
  return character.copyWith(resourceStates: states.isEmpty ? null : states);
}

CharacterData _applyRest(CharacterData character, RestType? restType) {
  if (restType == null || restType == RestType.special) {
    throw StateError('Unsupported rest type.');
  }
  final restored = <String>{};
  for (final feature in character.derived?.activeFeatures ??
      const <CharacterFeatureViewData>[]) {
    for (final resource
        in feature.resources ?? const <CharacterResourceViewData>[]) {
      final shouldRestore = restType == RestType.shortRest
          ? resource.resetOn == RestType.shortRest
          : restType == RestType.longRest
              ? resource.resetOn == RestType.shortRest ||
                  resource.resetOn == RestType.longRest
              : resource.resetOn == restType;
      if (shouldRestore) {
        restored.add(
            '${feature.sourceType.name}:${feature.sourceId}:${resource.key}');
      }
    }
  }
  final states = [
    for (final state
        in character.resourceStates ?? const <CharacterResourceStateData>[])
      if (!restored.contains(
          '${state.sourceType.name}:${state.sourceId}:${state.resourceKey}'))
        state,
  ];
  final pools = SpellSlotPools.fromCharacter(character.toJson());
  final materialized = pools.materialized;
  var next = character.copyWith(
    resourceStates: states.isEmpty ? null : states,
    currentSpellSlots:
        (restType == RestType.shortRest || restType == RestType.longRest) &&
                character.currentPactSlots == null &&
                pools.pactMax.isNotEmpty
            ? (materialized['currentSpellSlots'] == null
                ? null
                : spellProtocolIntMap<int>(materialized['currentSpellSlots']))
            : character.currentSpellSlots,
    currentPactSlots:
        restType == RestType.shortRest || restType == RestType.longRest
            ? pools.pactMax.isEmpty
                ? null
                : pools.pactMax
            : character.currentPactSlots,
  );
  if (restType == RestType.longRest) {
    next = next.copyWith(
      currentHp: null,
      temporaryHp: null,
      deathSaveSuccesses: null,
      deathSaveFailures: null,
      currentSpellSlots: null,
      currentHitDice: _longRestHitDice(character),
    );
  }
  return next;
}

Map<String, int>? _longRestHitDice(CharacterData character) {
  final maximum = character.derived?.hitDiceSummary ?? const <String, int>{};
  if (maximum.isEmpty) return null;
  final restored = <String, int>{
    for (final entry in maximum.entries)
      entry.key: character.currentHitDice?[entry.key] ?? entry.value,
  };
  var remaining = maximum.values.fold<int>(0, (sum, value) => sum + value) ~/ 2;
  if (remaining <= 0) remaining = 1;
  final keys = maximum.keys.toList()
    ..sort((a, b) => _dieSize(b).compareTo(_dieSize(a)));
  for (final key in keys) {
    final missing = maximum[key]! - restored[key]!;
    final amount = min(missing, remaining);
    restored[key] = restored[key]! + amount;
    remaining -= amount;
    if (remaining <= 0) break;
  }
  restored.removeWhere((key, value) => value == maximum[key]);
  return restored.isEmpty ? null : restored;
}

int _dieSize(String value) =>
    value.startsWith('d') ? int.tryParse(value.substring(1)) ?? 0 : 0;

Map<K, int>? _updatedMap<K>(
  Map<K, int>? source,
  K key,
  int value, {
  required int removeWhen,
}) {
  final result = <K, int>{...?source};
  value == removeWhen ? result.remove(key) : result[key] = value;
  return result.isEmpty ? null : result;
}

void _setField(
  Map<String, dynamic> json,
  String? field,
  CharacterSyncValueData? value,
) {
  if (field == null) throw StateError('Missing field path.');
  final encoded = _encodedFieldValue(field, value);
  encoded == null ? json.remove(field) : json[field] = encoded;
}

void _setMapEntry(
  Map<String, dynamic> json,
  CharacterSyncOperationData operation,
) {
  final field = operation.fieldPath;
  final key = operation.targetId;
  if (field == null || key == null) throw StateError('Missing map target.');
  if (field == 'currentSpellSlots' || field == 'currentPactSlots') {
    final values = _decodeIntMap(json[field]);
    values[int.parse(key)] = operation.value?.intValue;
    json[field] = _encodeIntMap(values);
    return;
  }
  final values = Map<String, dynamic>.from(json[field] as Map? ?? const {});
  values[key] = operation.value?.intValue;
  json[field] = values;
}

void _removeMapEntry(
  Map<String, dynamic> json,
  CharacterSyncOperationData operation,
) {
  final field = operation.fieldPath;
  final key = operation.targetId;
  if (field == null || key == null) throw StateError('Missing map target.');
  if (field == 'currentSpellSlots' || field == 'currentPactSlots') {
    final values = _decodeIntMap(json[field])..remove(int.parse(key));
    json[field] = values.isEmpty ? null : _encodeIntMap(values);
    return;
  }
  final values = Map<String, dynamic>.from(json[field] as Map? ?? const {})
    ..remove(key);
  json[field] = values.isEmpty ? null : values;
}

Map<int, int?> _decodeIntMap(Object? value) => {
      for (final item in value as List? ?? const [])
        if (item is Map<String, dynamic>) item['k'] as int: item['v'] as int?,
    };

List<Map<String, int>> _encodeIntMap(Map<int, int?> value) => [
      for (final key in (value.keys.toList()..sort()))
        if (value[key] != null) {'k': key, 'v': value[key]!},
    ];

void _upsertListItem(
  Map<String, dynamic> json,
  CharacterSyncOperationData operation,
) {
  final field = operation.fieldPath;
  if (field == null) throw StateError('Missing list field.');
  if (operation.targetType == CharacterSyncTargetType.resource) {
    final item = operation.itemPayload?.resourceStateValue;
    if (item == null) throw StateError('Missing resource payload.');
    final values =
        List<dynamic>.from(json['resourceStates'] as List? ?? const []);
    final index = values.indexWhere((raw) =>
        raw is Map &&
        raw['sourceType'] == item.sourceType.toJson() &&
        raw['sourceId'] == item.sourceId &&
        raw['resourceKey'] == item.resourceKey);
    index == -1 ? values.add(item.toJson()) : values[index] = item.toJson();
    json['resourceStates'] = values;
    return;
  }
  final item = _encodedItem(field, operation.itemPayload);
  final target = operation.targetId;
  if (item == null || target == null) throw StateError('Missing list payload.');
  final values = List<dynamic>.from(json[field] as List? ?? const []);
  final index = values.indexWhere(
    (raw) => raw is Map && raw['id']?.toString() == target,
  );
  index == -1 ? values.add(item) : values[index] = item;
  json[field] = values;
}

void _removeListItem(
  Map<String, dynamic> json,
  CharacterSyncOperationData operation,
) {
  final field = operation.fieldPath;
  final target = operation.targetId;
  if (field == null || target == null) throw StateError('Missing list target.');
  final values = List<dynamic>.from(json[field] as List? ?? const [])
    ..removeWhere((raw) => raw is Map && raw['id']?.toString() == target);
  json[field] = values.isEmpty ? null : values;
}

void _applyMember(
  Map<String, dynamic> json,
  CharacterSyncOperationData operation,
) {
  final target = operation.targetId;
  if (target == null) throw StateError('Missing member target.');
  if (operation.fieldPath == 'activeConditions') {
    final values = <String>{
      for (final raw in json['activeConditions'] as List? ?? const [])
        raw.toString(),
    };
    operation.type == CharacterSyncOperationType.addSetMember
        ? values.add(target)
        : values.remove(target);
    json['activeConditions'] =
        values.isEmpty ? null : (values.toList()..sort());
    return;
  }
  if (operation.fieldPath == 'preparedSpellKeys') {
    final values = <String>{
      for (final raw in json['preparedSpellKeys'] as List? ?? const [])
        raw.toString().trim().toLowerCase(),
    };
    operation.type == CharacterSyncOperationType.addSetMember
        ? values.add(target.trim().toLowerCase())
        : values.remove(target.trim().toLowerCase());
    json['preparedSpellKeys'] =
        values.isEmpty ? null : (values.toList()..sort());
    return;
  }
  final field = operation.fieldPath;
  if (field == 'manualSkillProficiencyOverrides' ||
      field == 'manualSavingThrowProficiencyOverrides') {
    final values = List<dynamic>.from(json[field] as List? ?? const [])
      ..removeWhere((raw) =>
          raw is Map &&
          (raw['skill']?.toString() == target ||
              raw['ability']?.toString() == target));
    final encoded = field == 'manualSkillProficiencyOverrides'
        ? operation.value?.skillProficiencyValue?.toJson()
        : operation.value?.savingThrowProficiencyOverrideValue?.toJson();
    if (encoded != null) values.add(encoded);
    json[field!] = values;
    return;
  }
  throw StateError('Unsupported member field ${operation.fieldPath}.');
}

Object? _encodedFieldValue(String field, CharacterSyncValueData? value) {
  if (value == null) return null;
  if (_stringFields.contains(field)) return value.stringValue;
  if (_intFields.contains(field)) return value.intValue;
  if (_boolFields.contains(field)) return value.boolValue;
  return switch (field) {
    'alignmentValue' => value.alignmentValue?.toJson(),
    'displayedSpeedKind' => value.speedKindValue?.toJson(),
    'preparedSpellKeys' => value.stringListValue,
    'activeConditions' =>
      value.conditionListValue?.map((item) => item.toJson()).toList(),
    'manualSkillProficiencies' =>
      value.skillProficiencyListValue?.map((item) => item.toJson()).toList(),
    'manualSavingThrowProficiencies' =>
      value.abilityListValue?.map((item) => item.toJson()).toList(),
    'manualLanguageOverrides' => value.languageOverridesValue?.toJson(),
    'manualToolProficiencyOverrides' =>
      value.toolProficiencyOverridesValue?.toJson(),
    'manualWeaponProficiencyOverrides' =>
      value.weaponProficiencyOverridesValue?.toJson(),
    'manualArmorTrainingOverrides' =>
      value.armorTrainingOverridesValue?.toJson(),
    'equippedArmor' ||
    'equippedShield' =>
      value.equipmentSelectionValue?.toJson(),
    'race' ||
    'subrace' ||
    'background' =>
      value.intValue == null ? null : {'id': value.intValue},
    _ => throw StateError('Unsupported field $field.'),
  };
}

const _stringFields = {
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
  'activeConcentrationSpellName',
};
const _intFields = {
  'experience',
  'temporaryHp',
  'currentHp',
  'deathSaveSuccesses',
  'deathSaveFailures',
  'hpPerLevelBonus',
  'hpFlatBonus',
  'customInitiativeBonus',
  'customArmorClassBonus',
  'walkingSpeed',
  'swimmingSpeed',
  'climbingSpeed',
  'flyingSpeed',
  'customSpellSaveDcBonus',
  'customSpellAttackBonus',
  'exhaustionLevel',
};
const _boolFields = {'useFlexibleAbilityBonuses', 'inspiration'};

Map<String, dynamic>? _encodedItem(
  String field,
  CharacterSyncValueData? value,
) =>
    switch (field) {
      'notes' => value?.noteValue?.toJson(),
      'equipment' => value?.equipmentValue?.toJson(),
      'attacks' => value?.attackValue?.toJson(),
      'featureOverrides' => value?.featureOverrideValue?.toJson(),
      'classEntries' => value?.classEntryValue?.toJson(),
      'choices' => value?.choiceValue?.toJson(),
      'skillSelections' => value?.skillSelectionValue?.toJson(),
      'spellSelections' => value?.spellSelectionValue?.toJson(),
      'startingEquipmentSelections' =>
        value?.startingEquipmentSelectionValue?.toJson(),
      _ => null,
    };
