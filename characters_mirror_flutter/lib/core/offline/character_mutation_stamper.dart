import 'dart:convert';
import 'dart:math';

import 'package:characters_mirror_client/characters_mirror_client.dart';

CharacterData stampCharacterMutation({
  required CharacterData previous,
  required CharacterData next,
  DateTime? now,
}) {
  // TODO(op-sync): keep the root snapshot stamp for v1, then move inventory,
  // notes, and attacks to per-entity operation timestamps.
  final timestamp = now?.toUtc() ?? DateTime.now().toUtc();
  final normalizedNext = normalizeCharacterForPersistence(
    next,
    fallbackUpdatedAt: next.updatedAt ?? timestamp,
  );
  final normalizedPrevious = normalizeCharacterForPersistence(
    previous,
    fallbackUpdatedAt: previous.updatedAt,
  );

  final stampedEquipment = _stampCollection<CharacterInventoryItemData>(
    previous: normalizedPrevious.equipment,
    next: normalizedNext.equipment,
    previousId: (item) => item.id,
    withUpdatedAt: (item, updatedAt) => item.copyWith(updatedAt: updatedAt),
  );
  final stampedNotes = _stampCollection<CharacterNoteData>(
    previous: normalizedPrevious.notes,
    next: normalizedNext.notes,
    previousId: (item) => item.id,
    withUpdatedAt: (item, updatedAt) => item.copyWith(updatedAt: updatedAt),
  );
  final stampedAttacks = _stampCollection<CharacterAttackData>(
    previous: normalizedPrevious.attacks,
    next: normalizedNext.attacks,
    previousId: (item) => item.id,
    withUpdatedAt: (item, updatedAt) => item.copyWith(updatedAt: updatedAt),
  );
  final stampedOverrides = _stampCollection<CharacterFeatureOverrideData>(
    previous: normalizedPrevious.featureOverrides,
    next: normalizedNext.featureOverrides,
    previousId: (item) => item.id,
    withUpdatedAt: (item, updatedAt) => item.copyWith(updatedAt: updatedAt),
  );
  final stampedEntries = _stampCollection<CharacterClassEntryData>(
    previous: normalizedPrevious.classEntries,
    next: normalizedNext.classEntries,
    previousId: (item) => item.id,
    withUpdatedAt: (item, updatedAt) => item.copyWith(updatedAt: updatedAt),
  );
  final stampedChoices = _stampCollection<CharacterChoiceData>(
    previous: normalizedPrevious.choices,
    next: normalizedNext.choices,
    previousId: (item) => item.id,
    withUpdatedAt: (item, updatedAt) => item.copyWith(updatedAt: updatedAt),
  );
  final stampedSkillSelections = _stampCollection<CharacterSkillSelectionData>(
    previous: normalizedPrevious.skillSelections,
    next: normalizedNext.skillSelections,
    previousId: (item) => item.id,
    withUpdatedAt: (item, updatedAt) => item.copyWith(updatedAt: updatedAt),
  );
  final stampedSpellSelections = _stampCollection<CharacterSpellSelectionData>(
    previous: normalizedPrevious.spellSelections,
    next: normalizedNext.spellSelections,
    previousId: (item) => item.id,
    withUpdatedAt: (item, updatedAt) => item.copyWith(updatedAt: updatedAt),
  );
  final stampedSelections =
      _stampCollection<CharacterStartingEquipmentSelectionData>(
    previous: normalizedPrevious.startingEquipmentSelections,
    next: normalizedNext.startingEquipmentSelections,
    previousId: (item) => item.id,
    withUpdatedAt: (item, updatedAt) => item.copyWith(
      updatedAt: updatedAt,
      resolutions: _stampCollection<CharacterStartingEquipmentResolutionData>(
        previous: normalizedPrevious.startingEquipmentSelections
            ?.firstWhere(
              (previousSelection) => previousSelection.id == item.id,
              orElse: () => CharacterStartingEquipmentSelectionData(
                id: item.id,
                resolutions: const [],
              ),
            )
            .resolutions,
        next: item.resolutions,
        previousId: (resolution) => resolution.id,
        withUpdatedAt: (resolution, resolutionUpdatedAt) => resolution.copyWith(
          updatedAt: resolutionUpdatedAt,
        ),
      ),
    ),
  );

  final stamped = normalizedNext.copyWith(
    createdAt: normalizedPrevious.createdAt ?? normalizedNext.createdAt,
    equipment: stampedEquipment,
    notes: stampedNotes,
    attacks: stampedAttacks,
    featureOverrides: stampedOverrides,
    classEntries: stampedEntries,
    choices: stampedChoices,
    skillSelections: stampedSkillSelections,
    spellSelections: stampedSpellSelections,
    startingEquipmentSelections: stampedSelections,
  );

  final nextUpdatedAt = _characterChanged(normalizedPrevious, stamped)
      ? timestamp
      : normalizedPrevious.updatedAt ?? stamped.updatedAt ?? timestamp;

  return stamped.copyWith(
    updatedAt: nextUpdatedAt,
    equipment: _applyFallbackUpdatedAt(
      stamped.equipment,
      nextUpdatedAt,
      (item, updatedAt) =>
          item.copyWith(updatedAt: item.updatedAt ?? updatedAt),
    ),
    notes: _applyFallbackUpdatedAt(
      stamped.notes,
      nextUpdatedAt,
      (item, updatedAt) =>
          item.copyWith(updatedAt: item.updatedAt ?? updatedAt),
    ),
    attacks: _applyFallbackUpdatedAt(
      stamped.attacks,
      nextUpdatedAt,
      (item, updatedAt) =>
          item.copyWith(updatedAt: item.updatedAt ?? updatedAt),
    ),
    featureOverrides: _applyFallbackUpdatedAt(
      stamped.featureOverrides,
      nextUpdatedAt,
      (item, updatedAt) =>
          item.copyWith(updatedAt: item.updatedAt ?? updatedAt),
    ),
    classEntries: _applyFallbackUpdatedAt(
      stamped.classEntries,
      nextUpdatedAt,
      (item, updatedAt) =>
          item.copyWith(updatedAt: item.updatedAt ?? updatedAt),
    ),
    choices: _applyFallbackUpdatedAt(
      stamped.choices,
      nextUpdatedAt,
      (item, updatedAt) =>
          item.copyWith(updatedAt: item.updatedAt ?? updatedAt),
    ),
    skillSelections: _applyFallbackUpdatedAt(
      stamped.skillSelections,
      nextUpdatedAt,
      (item, updatedAt) =>
          item.copyWith(updatedAt: item.updatedAt ?? updatedAt),
    ),
    spellSelections: _applyFallbackUpdatedAt(
      stamped.spellSelections,
      nextUpdatedAt,
      (item, updatedAt) =>
          item.copyWith(updatedAt: item.updatedAt ?? updatedAt),
    ),
    startingEquipmentSelections: _applyFallbackUpdatedAt(
      stamped.startingEquipmentSelections,
      nextUpdatedAt,
      (item, updatedAt) => item.copyWith(
        updatedAt: item.updatedAt ?? updatedAt,
        resolutions: _applyFallbackUpdatedAt(
          item.resolutions,
          updatedAt,
          (resolution, resolutionUpdatedAt) => resolution.copyWith(
            updatedAt: resolution.updatedAt ?? resolutionUpdatedAt,
          ),
        ),
      ),
    ),
  );
}

CharacterData normalizeCharacterForPersistence(
  CharacterData character, {
  DateTime? fallbackUpdatedAt,
}) {
  final updatedAt = character.updatedAt?.toUtc() ?? fallbackUpdatedAt?.toUtc();
  return character.copyWith(
    createdAt: character.createdAt?.toUtc() ?? updatedAt,
    updatedAt: updatedAt,
    equipment: _normalizedInventory(character.equipment, updatedAt),
    notes: _normalizedNotes(character.notes, updatedAt),
    attacks: _normalizedAttacks(character.attacks, updatedAt),
    featureOverrides: _normalizedFeatureOverrides(
      character.featureOverrides,
      updatedAt,
    ),
    resourceStates: _normalizedResourceStates(character.resourceStates),
    classEntries: _normalizedClassEntries(character.classEntries, updatedAt),
    choices: _normalizedChoices(character.choices, updatedAt),
    skillSelections: _normalizedSkillSelections(
      character.skillSelections,
      updatedAt,
    ),
    spellSelections: _normalizedSpellSelections(
      character.spellSelections,
      updatedAt,
    ),
    startingEquipmentSelections: _normalizedSelections(
      character.startingEquipmentSelections,
      updatedAt,
    ),
  );
}

List<T>? _stampCollection<T>({
  required List<T>? previous,
  required List<T>? next,
  required String? Function(T item) previousId,
  required T Function(T item, DateTime updatedAt) withUpdatedAt,
}) {
  final previousById = {
    for (final item in previous ?? <T>[])
      if (previousId(item) != null) previousId(item)!: item,
  };
  final stamped = <T>[];
  for (final item in next ?? <T>[]) {
    final id = previousId(item);
    final previousItem = id == null ? null : previousById[id];
    final previousUpdatedAt =
        _tryReadUpdatedAt(previousItem)?.toUtc() ?? _tryReadUpdatedAt(item);
    final changed = previousItem == null ||
        !_jsonEqualsIgnoringUpdatedAt(previousItem, item);
    final updatedAt = changed
        ? DateTime.now().toUtc()
        : previousUpdatedAt?.toUtc() ?? DateTime.now().toUtc();
    stamped.add(withUpdatedAt(item, updatedAt));
  }
  return stamped.isEmpty ? null : stamped;
}

List<T>? _applyFallbackUpdatedAt<T>(
  List<T>? items,
  DateTime updatedAt,
  T Function(T item, DateTime updatedAt) withUpdatedAt,
) {
  if (items == null || items.isEmpty) {
    return null;
  }
  return [
    for (final item in items) withUpdatedAt(item, updatedAt),
  ];
}

DateTime? _tryReadUpdatedAt(Object? value) {
  if (value is CharacterInventoryItemData) return value.updatedAt;
  if (value is CharacterNoteData) return value.updatedAt;
  if (value is CharacterAttackData) return value.updatedAt;
  if (value is CharacterFeatureOverrideData) return value.updatedAt;
  if (value is CharacterClassEntryData) return value.updatedAt;
  if (value is CharacterChoiceData) return value.updatedAt;
  if (value is CharacterSkillSelectionData) return value.updatedAt;
  if (value is CharacterSpellSelectionData) return value.updatedAt;
  if (value is CharacterStartingEquipmentSelectionData) return value.updatedAt;
  if (value is CharacterStartingEquipmentResolutionData) return value.updatedAt;
  return null;
}

bool _characterChanged(CharacterData previous, CharacterData next) {
  return !_jsonEqualsIgnoringTransientCharacterFields(previous, next);
}

bool _jsonEqualsIgnoringTransientCharacterFields(Object? left, Object? right) {
  final normalizedLeft = _normalizeJson(left);
  final normalizedRight = _normalizeJson(right);
  if (normalizedLeft is Map<String, dynamic>) {
    normalizedLeft.remove('updatedAt');
    normalizedLeft.remove('derived');
    normalizedLeft.remove('version');
  }
  if (normalizedRight is Map<String, dynamic>) {
    normalizedRight.remove('updatedAt');
    normalizedRight.remove('derived');
    normalizedRight.remove('version');
  }
  return jsonEncode(normalizedLeft) == jsonEncode(normalizedRight);
}

bool _jsonEqualsIgnoringUpdatedAt(Object? left, Object? right) {
  final normalizedLeft = _normalizeJson(left);
  final normalizedRight = _normalizeJson(right);
  if (normalizedLeft is Map<String, dynamic>) {
    normalizedLeft.remove('updatedAt');
  }
  if (normalizedRight is Map<String, dynamic>) {
    normalizedRight.remove('updatedAt');
  }
  return jsonEncode(normalizedLeft) == jsonEncode(normalizedRight);
}

Object? _normalizeJson(Object? value) {
  if (value == null || value is num || value is bool || value is String) {
    return value;
  }
  if (value is DateTime) {
    return value.toUtc().toIso8601String();
  }
  if (value is SerializableModel) {
    return _normalizeJson(value.toJson());
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

List<CharacterInventoryItemData>? _normalizedInventory(
  List<CharacterInventoryItemData>? items,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final item in items ?? const <CharacterInventoryItemData>[])
      if (_normalizedText(item.name) != null)
        CharacterInventoryItemData(
          id: item.id ?? _generateSyncId(),
          name: _normalizedText(item.name),
          quantity: _normalizeQuantity(item.quantity),
          type: item.type ?? CharacterInventoryItemType.custom,
          updatedAt: item.updatedAt?.toUtc() ?? updatedAt,
        ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<CharacterNoteData>? _normalizedNotes(
  List<CharacterNoteData>? notes,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final note in notes ?? const <CharacterNoteData>[])
      if (_normalizedText(note.text) != null)
        CharacterNoteData(
          id: note.id ?? _generateSyncId(),
          text: _normalizedText(note.text),
          updatedAt: note.updatedAt?.toUtc() ?? updatedAt,
        ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<CharacterAttackData>? _normalizedAttacks(
  List<CharacterAttackData>? attacks,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final attack in attacks ?? const <CharacterAttackData>[])
      _normalizedAttack(attack, updatedAt),
  ];
  return normalized.isEmpty ? null : normalized;
}

CharacterAttackData _normalizedAttack(
  CharacterAttackData attack,
  DateTime? updatedAt,
) {
  final damageParts = _normalizedDamageParts(attack.damageParts);
  final firstDamagePart = damageParts?.first;
  return CharacterAttackData(
    id: attack.id ?? _generateSyncId(),
    name: _normalizedText(attack.name),
    leadingAbility: attack.leadingAbility,
    damage: firstDamagePart?.formula ?? _normalizedText(attack.damage),
    customAttackBonus: attack.customAttackBonus ?? 0,
    damageType: firstDamagePart?.damageType ?? attack.damageType,
    damageParts: damageParts,
    tags: _normalizedStringList(attack.tags),
    description: _normalizedText(attack.description),
    updatedAt: attack.updatedAt?.toUtc() ?? updatedAt,
  );
}

List<DamagePartData>? _normalizedDamageParts(List<DamagePartData>? parts) {
  final normalized = [
    for (final part in parts ?? const <DamagePartData>[])
      if (_hasDamagePartData(part))
        DamagePartData(
          formula: _normalizedText(part.formula),
          damageType: part.damageType,
          scaling: part.scaling,
          notes: _normalizedText(part.notes),
        ),
  ];
  return normalized.isEmpty ? null : normalized;
}

bool _hasDamagePartData(DamagePartData part) {
  return _normalizedText(part.formula) != null ||
      part.damageType != null ||
      part.scaling != null ||
      _normalizedText(part.notes) != null;
}

List<CharacterFeatureOverrideData>? _normalizedFeatureOverrides(
  List<CharacterFeatureOverrideData>? overrides,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final item in overrides ?? const <CharacterFeatureOverrideData>[])
      item.copyWith(
        id: item.id ?? _generateSyncId(),
        name: _normalizedText(item.name),
        description: _normalizedText(item.description),
        updatedAt: item.updatedAt?.toUtc() ?? updatedAt,
      ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<CharacterResourceStateData>? _normalizedResourceStates(
  List<CharacterResourceStateData>? states,
) {
  final normalized = <CharacterResourceStateData>[];
  for (final state in states ?? const <CharacterResourceStateData>[]) {
    if (state.current < 0) {
      continue;
    }
    final candidate = CharacterResourceStateData(
      sourceType: state.sourceType,
      sourceId: state.sourceId,
      resourceKey: _normalizedText(state.resourceKey) ?? 'main',
      current: state.current,
    );
    final existingIndex = normalized.indexWhere(
      (item) =>
          item.sourceType == candidate.sourceType &&
          item.sourceId == candidate.sourceId &&
          item.resourceKey == candidate.resourceKey,
    );
    if (existingIndex >= 0) {
      normalized[existingIndex] = candidate;
    } else {
      normalized.add(candidate);
    }
  }
  normalized.sort((left, right) {
    final sourceCompare = left.sourceType.name.compareTo(right.sourceType.name);
    if (sourceCompare != 0) {
      return sourceCompare;
    }
    final idCompare = left.sourceId.compareTo(right.sourceId);
    if (idCompare != 0) {
      return idCompare;
    }
    return left.resourceKey.compareTo(right.resourceKey);
  });
  return normalized.isEmpty ? null : normalized;
}

List<CharacterClassEntryData>? _normalizedClassEntries(
  List<CharacterClassEntryData>? entries,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final entry in entries ?? const <CharacterClassEntryData>[])
      if (entry.classData?.id != null)
        entry.copyWith(
          id: entry.id ?? _generateSyncId(),
          notes: _normalizedText(entry.notes),
          updatedAt: entry.updatedAt?.toUtc() ?? updatedAt,
        ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<CharacterChoiceData>? _normalizedChoices(
  List<CharacterChoiceData>? choices,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final choice in choices ?? const <CharacterChoiceData>[])
      choice.copyWith(
        id: choice.id ?? _generateSyncId(),
        selectedToolKey: _normalizedText(choice.selectedToolKey),
        selectedText: _normalizedText(choice.selectedText),
        updatedAt: choice.updatedAt?.toUtc() ?? updatedAt,
      ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<CharacterSpellSelectionData>? _normalizedSpellSelections(
  List<CharacterSpellSelectionData>? selections,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final selection in selections ?? const <CharacterSpellSelectionData>[])
      if (_normalizedText(selection.spellKey) != null ||
          selection.spellId != null ||
          selection.spell?.id != null)
        selection.copyWith(
          id: selection.id ?? _generateSyncId(),
          classDataId:
              selection.classDataId ?? selection.classEntry?.classData?.id,
          spellId: selection.spellId ?? selection.spell?.id,
          spellKey: _normalizedText(selection.spellKey) ??
              _normalizedText(selection.spell?.referenceKey) ??
              _normalizedText(selection.spell?.name),
          updatedAt: selection.updatedAt?.toUtc() ?? updatedAt,
        ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<CharacterSkillSelectionData>? _normalizedSkillSelections(
  List<CharacterSkillSelectionData>? selections,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final selection in selections ?? const <CharacterSkillSelectionData>[])
      if (selection.skill != null)
        selection.copyWith(
          id: selection.id ?? _generateSyncId(),
          classDataId:
              selection.classDataId ?? selection.classEntry?.classData?.id,
          updatedAt: selection.updatedAt?.toUtc() ?? updatedAt,
        ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<CharacterStartingEquipmentSelectionData>? _normalizedSelections(
  List<CharacterStartingEquipmentSelectionData>? selections,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final selection
        in selections ?? const <CharacterStartingEquipmentSelectionData>[])
      selection.copyWith(
        id: selection.id ?? _generateSyncId(),
        resolutions: _normalizedResolutions(selection.resolutions, updatedAt),
        updatedAt: selection.updatedAt?.toUtc() ?? updatedAt,
      ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<CharacterStartingEquipmentResolutionData>? _normalizedResolutions(
  List<CharacterStartingEquipmentResolutionData>? resolutions,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final resolution
        in resolutions ?? const <CharacterStartingEquipmentResolutionData>[])
      CharacterStartingEquipmentResolutionData(
        id: resolution.id ?? _generateSyncId(),
        sourceLineEntryId: resolution.sourceLineEntryId,
        catalogType: resolution.catalogType,
        referenceKey: _normalizedText(resolution.referenceKey),
        quantity: _normalizeQuantity(resolution.quantity),
        updatedAt: resolution.updatedAt?.toUtc() ?? updatedAt,
      ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<String>? _normalizedStringList(List<String>? values) {
  final normalized = [
    for (final value in values ?? const <String>[])
      if (_normalizedText(value) != null) _normalizedText(value)!,
  ];
  return normalized.isEmpty ? null : normalized;
}

int _normalizeQuantity(int? quantity) {
  final value = quantity ?? 1;
  return value < 1 ? 1 : value;
}

String? _normalizedText(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return null;
  }
  return trimmed;
}

String _generateSyncId() {
  final random = Random.secure();
  final parts = [
    for (final length in const [8, 4, 4, 4, 12]) _randomHex(random, length),
  ];
  return parts.join('-');
}

String _randomHex(Random random, int length) {
  final buffer = StringBuffer();
  for (var index = 0; index < length; index++) {
    buffer.write(random.nextInt(16).toRadixString(16));
  }
  return buffer.toString();
}
