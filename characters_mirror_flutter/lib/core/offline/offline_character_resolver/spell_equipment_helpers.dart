part of '../offline_character_resolver.dart';

List<String> _collectAlwaysPreparedSpellKeys(CharacterData character) {
  return _uniqueStrings(character.derived?.alwaysPreparedSpellKeys ?? const []);
}

List<String> _collectGrantedSpellKeys(
  CharacterData character,
  List<String> alwaysPreparedSpellKeys,
  List<ChoiceOptionData> selectedOptions,
) {
  return _uniqueStrings([
    ...alwaysPreparedSpellKeys,
    for (final option in selectedOptions)
      ...?option.grantedSpellKeys,
    for (final selection
        in character.spellSelections ?? const <CharacterSpellSelectionData>[])
      if (_spellSelectionKey(selection) != null) _spellSelectionKey(selection)!,
  ]);
}

String? _spellSelectionKey(CharacterSpellSelectionData selection) {
  return _normalizedTextOrNull(selection.spellKey) ??
      _normalizedTextOrNull(selection.spell?.referenceKey) ??
      _normalizedTextOrNull(selection.spell?.name);
}

Future<List<CharacterEquipmentEntryView>> _collectGrantedEquipment(
  OfflineCacheDatabase cache,
  CharacterData character,
) async {
  final weapons = await cache.getReferenceList(
        'weapon',
        offlineAllKey,
        WeaponData.fromJson,
      ) ??
      const <WeaponData>[];
  final items = await cache.getReferenceList(
        'item',
        offlineAllKey,
        ItemData.fromJson,
      ) ??
      const <ItemData>[];
  final armor = await cache.getReferenceList(
        'armor',
        offlineAllKey,
        ArmorData.fromJson,
      ) ??
      const <ArmorData>[];

  final startingEntry = _startingClassEntry(
    character.classEntries ?? const <CharacterClassEntryData>[],
  );
  final startingClass = startingEntry?.classData;
  final startingClassId = startingClass?.id;
  final backgroundId = character.background?.id;
  final classStepView = startingClassId == null
      ? null
      : await cache.getReference<ClassStepView>(
          offlineClassStepKind,
          offlineClassStepKey(
            startingClassId,
            selectedLevel: startingEntry?.level ?? 1,
            selectedSubclassId: startingEntry?.subclass?.id,
          ),
          ClassStepView.fromJson,
        );
  final backgroundStepView = backgroundId == null
      ? null
      : await cache.getReference<BackgroundStepView>(
          offlineBackgroundStepKind,
          offlineBackgroundStepKey(backgroundId),
          BackgroundStepView.fromJson,
        );
  final relevantBlocks = <_StartingEquipmentSourceBlock>[
    if (startingClassId != null)
      ..._sourceBlocksFor(
        sourceType: ChoiceSourceType.classData,
        sourceId: startingClassId,
        blocks: classStepView?.startingEquipmentBlocks,
      ),
    if (backgroundId != null)
      ..._sourceBlocksFor(
        sourceType: ChoiceSourceType.background,
        sourceId: backgroundId,
        blocks: backgroundStepView?.startingEquipmentBlocks,
      ),
  ]..sort((a, b) {
      final sourceCompare = a.sourceType.name.compareTo(b.sourceType.name);
      if (sourceCompare != 0) return sourceCompare;
      final idCompare = a.sourceId.compareTo(b.sourceId);
      if (idCompare != 0) return idCompare;
      return (a.blockView.block?.orderIndex ?? 0)
          .compareTo(b.blockView.block?.orderIndex ?? 0);
    });
  if (relevantBlocks.isEmpty) {
    return const <CharacterEquipmentEntryView>[];
  }

  final selections = character.startingEquipmentSelections ??
      const <CharacterStartingEquipmentSelectionData>[];
  final accumulated = <String, _GrantedEquipmentAccumulator>{};
  for (final sourceBlock in relevantBlocks) {
    final blockView = sourceBlock.blockView;
    final block = blockView.block;
    if (block == null) continue;
    final sourceSelections = _matchingStartingEquipmentSelections(
      selections,
      sourceType: sourceBlock.sourceType,
      sourceId: sourceBlock.sourceId,
      block: block,
    );
    final blockLines = _sortedStartingEquipmentLines(
      block.fixedLines ?? blockView.fixedLines,
    );
    if (block.kind == StartingEquipmentBlockKind.choice) {
      _applyStartingEquipmentLines(
        blockLines,
        _collectBlockLevelResolutions(sourceSelections),
        weapons,
        items,
        armor,
        accumulated,
      );
      for (final selection in sourceSelections) {
        if (selection.isSelected == false) continue;
        final option = _startingEquipmentOptionForEntryId(
          blockView.options,
          selection.choiceOptionEntryId,
        );
        if (option == null) continue;
        _applyStartingEquipmentLines(
          _sortedStartingEquipmentLines(option.option?.lines ?? option.lines),
          selection.resolutions ??
              const <CharacterStartingEquipmentResolutionData>[],
          weapons,
          items,
          armor,
          accumulated,
        );
      }
      continue;
    }
    if (sourceSelections.any((selection) => selection.isSelected == false)) {
      continue;
    }

    _applyStartingEquipmentLines(
      blockLines,
      _collectBlockLevelResolutions(sourceSelections),
      weapons,
      items,
      armor,
      accumulated,
    );
  }

  final result = [
    for (final item in accumulated.values)
      CharacterEquipmentEntryView(
        catalogType: item.catalogType,
        referenceKey: item.referenceKey,
        displayText: item.displayText,
        quantity: item.quantity,
      ),
  ]..sort((a, b) {
      final textCompare = (a.displayText ?? '').compareTo(b.displayText ?? '');
      if (textCompare != 0) return textCompare;
      final typeCompare =
          (a.catalogType?.name ?? '').compareTo(b.catalogType?.name ?? '');
      if (typeCompare != 0) return typeCompare;
      return (a.referenceKey ?? '').compareTo(b.referenceKey ?? '');
    });
  return result;
}
