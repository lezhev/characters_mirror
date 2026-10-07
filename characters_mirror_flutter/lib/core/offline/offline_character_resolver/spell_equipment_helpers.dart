part of '../offline_character_resolver.dart';

Future<List<String>> _collectAlwaysPreparedSpellKeys(
    OfflineCacheDatabase cache,
    CharacterData character,
    List<CharacterClassEntryData> entries,
    int totalLevel,
    {required Set<int> selectedOptionIds,
    bool onlyAlwaysPrepared = true}) async {
  final grants = await cache.getReferenceList(
        'class_spell_grant',
        offlineAllKey,
        ClassSpellGrantData.fromJson,
      ) ??
      const <ClassSpellGrantData>[];
  final classLevels = <int, int>{};
  final subclassLevels = <int, int>{};
  for (final entry in entries) {
    final level = entry.level ?? 0;
    final classId = entry.classData?.id;
    final subclassId = entry.subclass?.id;
    if (classId != null) {
      classLevels[classId] = max(classLevels[classId] ?? 0, level);
    }
    if (subclassId != null) {
      subclassLevels[subclassId] = max(subclassLevels[subclassId] ?? 0, level);
    }
  }
  final classFeatures = await cache.getReferenceList(
        'class_feature',
        offlineAllKey,
        ClassFeatureData.fromJson,
      ) ??
      const <ClassFeatureData>[];
  final subclassFeatures = await cache.getReferenceList(
        'subclass_feature',
        offlineAllKey,
        SubclassFeatureData.fromJson,
      ) ??
      const <SubclassFeatureData>[];
  final currentClassFeatures = {
    for (final feature in classFeatures)
      if (feature.id != null &&
          (classLevels[feature.parentClassId] ?? 0) >= feature.level)
        feature.id!: classLevels[feature.parentClassId] ?? feature.level,
  };
  final currentSubclassFeatures = {
    for (final feature in subclassFeatures)
      if (feature.id != null &&
          (subclassLevels[feature.parentSubclassId] ?? 0) >= feature.level)
        feature.id!: subclassLevels[feature.parentSubclassId] ?? feature.level,
  };
  final values = <String>{};
  for (final grant in grants) {
    if ((onlyAlwaysPrepared && grant.alwaysPrepared != true) ||
        (grant.choiceOptionId != null &&
            !selectedOptionIds.contains(grant.choiceOptionId))) {
      continue;
    }
    final requiredLevel = grant.grantedAtLevel ?? 1;
    final sourceClassId = grant.sourceClassId ?? grant.sourceClass?.id;
    final sourceSubclassId = grant.sourceSubclassId ?? grant.sourceSubclass?.id;
    final sourceFeatureId = grant.sourceFeatureId ?? grant.sourceFeature?.id;
    final sourceSubclassFeatureId =
        grant.sourceSubclassFeatureId ?? grant.sourceSubclassFeature?.id;
    final isActive = (sourceClassId != null &&
            (classLevels[sourceClassId] ?? 0) >= requiredLevel) ||
        (sourceSubclassId != null &&
            (subclassLevels[sourceSubclassId] ?? 0) >= requiredLevel) ||
        (sourceFeatureId != null &&
            (currentClassFeatures[sourceFeatureId] ?? 0) >= requiredLevel) ||
        (sourceSubclassFeatureId != null &&
            (currentSubclassFeatures[sourceSubclassFeatureId] ?? 0) >=
                requiredLevel);
    final key = _normalizedTextOrNull(grant.spell?.referenceKey);
    if (isActive && key != null) values.add(key);
  }
  return values.toList()..sort();
}

Future<(Map<int, int>?, Map<int, int>?)> _spellSlots(
  OfflineCacheDatabase cache,
  List<CharacterClassEntryData> entries,
) async {
  final progressions = await cache.getReferenceList(
        'spell_slot_progression',
        offlineAllKey,
        SpellSlotProgressionData.fromJson,
      ) ??
      const <SpellSlotProgressionData>[];
  final standardEntries = [
    for (final entry in entries)
      if (_isStandardCasterProgression(
        entry.classData == null
            ? null
            : effectiveSpellcastingClass(
                    entry.classData!, entry.subclass, entry.level ?? 0)
                .spellcastingProgression,
      ))
        entry,
  ];
  final singleClassRounding = standardEntries.length == 1;
  var standardLevel = 0;
  var pactLevel = 0;
  for (final entry in entries) {
    final level = entry.level ?? 0;
    switch (entry.classData == null
        ? null
        : effectiveSpellcastingClass(entry.classData!, entry.subclass, level)
            .spellcastingProgression) {
      case SpellcastingProgression.full:
        standardLevel += level;
        break;
      case SpellcastingProgression.half:
        standardLevel += singleClassRounding ? (level + 1) ~/ 2 : level ~/ 2;
        break;
      case SpellcastingProgression.third:
        standardLevel += singleClassRounding ? (level + 2) ~/ 3 : level ~/ 3;
        break;
      case SpellcastingProgression.pactMagic:
        pactLevel = max(pactLevel, level);
        break;
      case SpellcastingProgression.none:
      case null:
        break;
    }
  }
  Map<int, int>? forLevel(String tableKey, int level) {
    if (level <= 0) return null;
    final row = progressions
        .where(
          (item) => item.tableKey == tableKey && item.level == min(level, 20),
        )
        .firstOrNull;
    final slots = row?.spellSlots;
    if (slots == null) return null;
    final result = {
      for (final entry in slots.entries)
        if (entry.key > 0 && entry.value > 0) entry.key: entry.value,
    };
    return result.isEmpty ? null : result;
  }

  return (
    forLevel('standard', standardLevel),
    forLevel('pact_magic', pactLevel),
  );
}

bool _isStandardCasterProgression(SpellcastingProgression? progression) =>
    progression == SpellcastingProgression.full ||
    progression == SpellcastingProgression.half ||
    progression == SpellcastingProgression.third;

List<String> _racialSpellKeys(CharacterData character, int totalLevel) {
  final characterLevel = max(totalLevel, 1);
  return _uniqueStrings([
    for (final feature in [
      ...?character.race?.features,
      ...?character.subrace?.features,
    ])
      if ((feature.level ?? 1) <= characterLevel)
        for (final grant
            in feature.spellGrants ?? const <RaceFeatureSpellGrantData>[])
          if ((grant.grantedAtLevel ?? 1) <= characterLevel &&
              _normalizedTextOrNull(grant.spell?.referenceKey) != null)
            grant.spell!.referenceKey,
  ]);
}

List<String> _collectGrantedSpellKeys(
  CharacterData character,
  List<String> alwaysPreparedSpellKeys,
  List<String> racialSpellKeys,
  List<ChoiceOptionData> selectedOptions,
) {
  return _uniqueStrings([
    ...alwaysPreparedSpellKeys,
    ...racialSpellKeys,
    for (final option in selectedOptions) ...?option.grantedSpellKeys,
    for (final selection
        in character.spellSelections ?? const <CharacterSpellSelectionData>[])
      if (_spellSelectionKey(selection) != null) _spellSelectionKey(selection)!,
  ]);
}

String? _spellSelectionKey(CharacterSpellSelectionData selection) {
  return _normalizedTextOrNull(selection.spellKey) ??
      _normalizedTextOrNull(selection.spell?.referenceKey);
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
  final tools = await cache.getReferenceList(
        'tool',
        offlineAllKey,
        ToolData.fromJson,
      ) ??
      const <ToolData>[];

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
        tools,
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
          tools,
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
      tools,
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
