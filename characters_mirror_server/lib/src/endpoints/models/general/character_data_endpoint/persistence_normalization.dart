part of '../character_data_endpoint.dart';

List<CharacterInventoryItemData>? _normalizedInventoryItems(
  List<CharacterInventoryItemData>? items,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final item in items ?? const <CharacterInventoryItemData>[])
      if (_normalizedTextOrNull(item.name) != null)
        CharacterInventoryItemData(
          id: item.id ?? _generateSyncId(),
          name: _normalizedTextOrNull(item.name),
          quantity: _normalizedPositiveQuantity(item.quantity),
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
      if (_normalizedTextOrNull(note.text) != null)
        CharacterNoteData(
          id: note.id ?? _generateSyncId(),
          text: _normalizedTextOrNull(note.text),
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
    name: _normalizedTextOrNull(attack.name),
    leadingAbility: attack.leadingAbility,
    damage: firstDamagePart?.formula ?? _normalizedTextOrNull(attack.damage),
    customAttackBonus: attack.customAttackBonus ?? 0,
    damageType: firstDamagePart?.damageType ?? attack.damageType,
    damageParts: damageParts,
    tags: _normalizedAttackTagsFromStrings(attack.tags),
    description: _normalizedTextOrNull(attack.description),
    updatedAt: attack.updatedAt?.toUtc() ?? updatedAt,
  );
}

List<DamagePartData>? _normalizedDamageParts(List<DamagePartData>? parts) {
  final normalized = [
    for (final part in parts ?? const <DamagePartData>[])
      if (_hasDamagePartData(part))
        DamagePartData(
          formula: _normalizedTextOrNull(part.formula),
          damageType: part.damageType,
          scaling: part.scaling,
          notes: _normalizedTextOrNull(part.notes),
        ),
  ];
  return normalized.isEmpty ? null : normalized;
}

bool _hasDamagePartData(DamagePartData part) {
  return _normalizedTextOrNull(part.formula) != null ||
      part.damageType != null ||
      part.scaling != null ||
      _normalizedTextOrNull(part.notes) != null;
}

List<CharacterFeatureOverrideData> _normalizedFeatureOverridesWithSync(
  List<CharacterFeatureOverrideData>? overrides,
  DateTime? updatedAt,
) {
  return [
    for (final override in _normalizedFeatureOverrides(overrides))
      override.copyWith(
        id: override.id ?? _generateSyncId(),
        updatedAt: override.updatedAt?.toUtc() ?? updatedAt,
      ),
  ];
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
          notes: _normalizedTextOrNull(entry.notes),
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
        selectedToolKey: _normalizedTextOrNull(choice.selectedToolKey),
        selectedText: _normalizedTextOrNull(choice.selectedText),
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
      if (selection.spellId != null ||
          selection.spell?.id != null ||
          _normalizedTextOrNull(selection.spellKey) != null ||
          _normalizedTextOrNull(selection.spell?.referenceKey) != null ||
          _normalizedTextOrNull(selection.spell?.name) != null)
        selection.copyWith(
          id: selection.id ?? _generateSyncId(),
          classDataId:
              selection.classDataId ?? selection.classEntry?.classData?.id,
          spellId: selection.spellId ?? selection.spell?.id,
          spellKey: _normalizedTextOrNull(selection.spellKey) ??
              _normalizedTextOrNull(selection.spell?.referenceKey) ??
              _normalizedTextOrNull(selection.spell?.name),
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

List<CharacterStartingEquipmentSelectionData>?
    _normalizedStartingEquipmentSelections(
  List<CharacterStartingEquipmentSelectionData>? selections,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final selection
        in selections ?? const <CharacterStartingEquipmentSelectionData>[])
      selection.copyWith(
        id: selection.id ?? _generateSyncId(),
        isSelected: selection.isSelected,
        resolutions: _normalizedStartingEquipmentResolutions(
          selection.resolutions,
          updatedAt,
        ),
        updatedAt: selection.updatedAt?.toUtc() ?? updatedAt,
      ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<CharacterStartingEquipmentResolutionData>?
    _normalizedStartingEquipmentResolutions(
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
        referenceKey: _normalizedTextOrNull(resolution.referenceKey),
        quantity: _normalizedPositiveQuantity(resolution.quantity),
        updatedAt: resolution.updatedAt?.toUtc() ?? updatedAt,
      ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<String>? _normalizedAttackTagsFromStrings(List<String>? tags) {
  final normalized = [
    for (final tag in tags ?? const <String>[])
      if (_normalizedTextOrNull(tag) != null) _normalizedTextOrNull(tag)!,
  ];
  return normalized.isEmpty ? null : normalized;
}
