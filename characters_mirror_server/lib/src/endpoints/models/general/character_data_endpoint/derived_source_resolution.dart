part of '../character_data_endpoint.dart';

class _ResolvedDerivedSources {
  final List<ChoiceOptionData> selectedOptions;
  final Map<int, List<SelectedFeatureChoiceView>>
      selectedChoicesByClassFeatureId;
  final Map<int, List<SelectedFeatureChoiceView>>
      selectedChoicesBySubclassFeatureId;
  final List<ClassFeatureData> currentClassFeatures;
  final List<SubclassFeatureData> currentSubclassFeatures;
  final List<FeatureDisplayPropertyData> featureDisplayProperties;
  final List<FeatureModifierData> featureModifiers;
  final List<String> alwaysPreparedSpellKeys;
  final List<String> grantedClassSpellKeys;

  const _ResolvedDerivedSources({
    required this.selectedOptions,
    required this.selectedChoicesByClassFeatureId,
    required this.selectedChoicesBySubclassFeatureId,
    required this.currentClassFeatures,
    required this.currentSubclassFeatures,
    required this.featureDisplayProperties,
    required this.featureModifiers,
    required this.alwaysPreparedSpellKeys,
    required this.grantedClassSpellKeys,
  });
}

class _CurrentRaceFeatures {
  final List<RaceFeatureData> raceFeatures;
  final List<RaceFeatureData> subraceFeatures;

  const _CurrentRaceFeatures({
    required this.raceFeatures,
    required this.subraceFeatures,
  });
}

class _ResolvedStartingEquipmentSources {
  final List<_StartingEquipmentSourceBlock> blocks;

  const _ResolvedStartingEquipmentSources({
    required this.blocks,
  });
}

class _StartingEquipmentSourceBlock {
  const _StartingEquipmentSourceBlock({
    required this.blockView,
  });

  final StartingEquipmentBlockView blockView;
}

class _GrantedEquipmentAccumulator {
  _GrantedEquipmentAccumulator({
    required this.catalogType,
    required this.referenceKey,
    required this.displayText,
    required this.quantity,
  });

  final EquipmentCatalogType catalogType;
  final String referenceKey;
  String displayText;
  int quantity;
}

class _ActiveFeatureResourceEffect {
  const _ActiveFeatureResourceEffect({
    required this.sourceType,
    required this.sourceId,
    required this.sourceClassLevel,
    required this.effect,
  });

  final CharacterFeatureSourceType sourceType;
  final int sourceId;
  final int sourceClassLevel;
  final FeatureResourceEffectData effect;
}

Future<_ResolvedDerivedSources> _resolveDerivedSources(
  Session session,
  CharacterData character,
  List<CharacterChoiceData> choices, {
  Transaction? transaction,
  _CharacterResolveContext? resolveContext,
}) async {
  final context = resolveContext ?? _CharacterResolveContext(session);
  final entries = character.classEntries ?? const <CharacterClassEntryData>[];
  final currentClassFeatures = <ClassFeatureData>[];
  final currentSubclassFeatures = <SubclassFeatureData>[];
  final classLevels = <int, int>{};
  final subclassLevels = <int, int>{};

  for (final entry in entries) {
    final level = entry.level ?? 0;
    final classId = entry.classData?.id;
    if (classId != null) {
      classLevels[classId] = max(classLevels[classId] ?? 0, level);
      currentClassFeatures.addAll(
        await context.classFeatures(
          classId,
          level,
          transaction: transaction,
        ),
      );
    }

    final subclassId = entry.subclass?.id;
    if (subclassId != null) {
      subclassLevels[subclassId] = max(subclassLevels[subclassId] ?? 0, level);
      currentSubclassFeatures.addAll(
        await context.subclassFeatures(
          subclassId,
          level,
          transaction: transaction,
        ),
      );
    }
  }

  final currentClassFeatureIds = {
    for (final feature in currentClassFeatures)
      if (feature.id != null) feature.id!,
  };
  final currentClassFeatureLevels = {
    for (final feature in currentClassFeatures)
      if (feature.id != null)
        feature.id!: classLevels[feature.parentClassId] ?? feature.level,
  };
  final currentSubclassFeatureIds = {
    for (final feature in currentSubclassFeatures)
      if (feature.id != null) feature.id!,
  };
  final currentSubclassFeatureLevels = {
    for (final feature in currentSubclassFeatures)
      if (feature.id != null)
        feature.id!: subclassLevels[feature.parentSubclassId] ?? feature.level,
  };
  final classSpellGrants = await context.classSpellGrants(
    transaction: transaction,
  );
  final featureDisplayProperties = await context.featureDisplayProperties(
    transaction: transaction,
  );
  final classModifierIds = currentClassFeatureIds;
  final subclassModifierIds = currentSubclassFeatureIds;
  final featureModifiers = <FeatureModifierData>[
    if (classModifierIds.isNotEmpty)
      ...await FeatureModifierData.db.find(
        session,
        where: (t) => t.classFeatureId.inSet(classModifierIds),
        orderBy: (t) => t.referenceKey,
        transaction: transaction,
      ),
    if (subclassModifierIds.isNotEmpty)
      ...await FeatureModifierData.db.find(
        session,
        where: (t) => t.subclassFeatureId.inSet(subclassModifierIds),
        orderBy: (t) => t.referenceKey,
        transaction: transaction,
      ),
  ];

  final currentRaceFeatures = _currentRaceFeaturesBySource(character,
      entries.fold<int>(0, (sum, entry) => sum + (entry.level ?? 0)));
  final raceFeatureIds = {
    for (final feature in [
      ...currentRaceFeatures.raceFeatures,
      ...currentRaceFeatures.subraceFeatures,
    ])
      if (feature.id != null) feature.id!,
  };
  final allGroups = await context.choiceGroups(
    transaction: transaction,
  );
  final relevantGroups = allGroups.where((group) {
    final groupLevel = group.level ?? 1;
    final byClass = group.sourceClassId != null &&
        (classLevels[group.sourceClassId!] ?? 0) >= groupLevel;
    final bySubclass = group.sourceSubclassId != null &&
        (subclassLevels[group.sourceSubclassId!] ?? 0) >= groupLevel;
    final byFeature = group.sourceFeatureId != null &&
        (currentClassFeatureLevels[group.sourceFeatureId!] ?? 0) >= groupLevel;
    final bySubclassFeature = group.sourceSubclassFeatureId != null &&
        (currentSubclassFeatureLevels[group.sourceSubclassFeatureId!] ?? 0) >=
            groupLevel;
    final byBackground = group.sourceBackgroundId != null &&
        group.sourceBackgroundId == character.background?.id;
    final byRace =
        group.sourceRaceId != null && group.sourceRaceId == character.race?.id;
    final bySubrace = group.sourceSubraceId != null &&
        group.sourceSubraceId == character.subrace?.id;
    final byRaceFeature = group.sourceRaceFeatureId != null &&
        raceFeatureIds.contains(group.sourceRaceFeatureId);

    return byClass ||
        bySubclass ||
        byFeature ||
        bySubclassFeature ||
        byBackground ||
        byRace ||
        bySubrace ||
        byRaceFeature;
  }).toList();

  for (final group in relevantGroups) {
    _validateChoiceGroupSourceInvariant(group);
  }

  final relevantGroupIds = {
    for (final group in relevantGroups)
      if (group.id != null) group.id!,
  };
  final options = await context.choiceOptions(
    relevantGroupIds,
    transaction: transaction,
  );
  final optionsByGroupId = <int, List<ChoiceOptionData>>{};
  for (final option in options) {
    optionsByGroupId.putIfAbsent(option.choiceGroupId, () => []).add(option);
  }
  final optionsByGroupKey = <String, Map<String, ChoiceOptionData>>{};
  for (final group in relevantGroups) {
    final groupId = group.id;
    if (groupId == null) continue;
    optionsByGroupKey[group.referenceKey] = {
      for (final option
          in optionsByGroupId[groupId] ?? const <ChoiceOptionData>[])
        if (option.optionKey.trim().isNotEmpty) option.optionKey.trim(): option,
    };
  }

  final selectedOptions = <ChoiceOptionData>[];
  final selectedByGroupKey = <String, List<_SelectedGenericChoice>>{};
  for (final choice in choices) {
    final groupKey = choice.groupKey;
    final optionKey = _normalizedTextOrNull(choice.optionKey);
    if (groupKey == null || optionKey == null) {
      throw InputValidationException(
        'choices',
        'A generic choice requires groupKey and optionKey.',
      );
    }

    final group = relevantGroups.where((item) => item.referenceKey == groupKey);
    if (group.length != 1) {
      throw InputValidationException(
        'choices',
        'Choice group "$groupKey" is unavailable for this character.',
      );
    }
    final selectedGroup = group.single;
    final option = optionsByGroupKey[groupKey]?[optionKey];
    if (option == null || option.choiceGroupId != selectedGroup.id) {
      throw InputValidationException(
        'choices',
        'Choice option "$optionKey" is not part of group "$groupKey".',
      );
    }

    _validateChoiceClassEntryBinding(choice, selectedGroup, character);
    selectedByGroupKey.putIfAbsent(groupKey, () => []).add(
          _SelectedGenericChoice(choice, option),
        );

    selectedOptions.add(option);
  }

  _validateGenericChoiceSelectionRules(selectedByGroupKey, relevantGroups);
  _validateGenericChoiceEligibility(
    character,
    selectedByGroupKey,
    relevantGroups,
    currentClassFeatures,
    currentSubclassFeatures,
  );
  await _validateGenericChoiceReferenceKeys(
    session,
    [
      for (final selected in selectedByGroupKey.values)
        ...selected.map((e) => e.option)
    ],
    transaction: transaction,
  );

  final selectedChoicesByClassFeatureId =
      <int, List<SelectedFeatureChoiceView>>{};
  final selectedChoicesBySubclassFeatureId =
      <int, List<SelectedFeatureChoiceView>>{};
  final orderedGroups = [...relevantGroups]..sort(
      (left, right) => (left.sortOrder ?? 0).compareTo(right.sortOrder ?? 0));
  for (final group in orderedGroups) {
    final selections = [...?selectedByGroupKey[group.referenceKey]]..sort(
        (left, right) => (left.choice.selectionIndex ?? 0)
            .compareTo(right.choice.selectionIndex ?? 0));
    if (selections.isEmpty) continue;
    final target = group.sourceFeatureId != null
        ? selectedChoicesByClassFeatureId.putIfAbsent(
            group.sourceFeatureId!,
            () => <SelectedFeatureChoiceView>[],
          )
        : group.sourceSubclassFeatureId != null
            ? selectedChoicesBySubclassFeatureId.putIfAbsent(
                group.sourceSubclassFeatureId!,
                () => <SelectedFeatureChoiceView>[],
              )
            : null;
    if (target == null) continue;
    for (final selection in selections) {
      final optionName = _normalizedTextOrNull(selection.option.name) ??
          selection.option.optionKey;
      final groupName = _normalizedTextOrNull(group.name);
      target.add(SelectedFeatureChoiceView(
        groupKey: group.referenceKey,
        groupTitle: groupName,
        optionKey: selection.option.optionKey,
        name: optionName,
        shortDescription: selection.option.shortDescription,
      ));
    }
  }

  List<String> spellGrantKeys({required bool onlyAlwaysPrepared}) =>
      _collectAlwaysPreparedSpellKeys(
        classSpellGrants,
        classLevels: classLevels,
        subclassLevels: subclassLevels,
        currentClassFeatureIds: currentClassFeatureIds,
        currentSubclassFeatureIds: currentSubclassFeatureIds,
        currentClassFeatureLevels: currentClassFeatureLevels,
        currentSubclassFeatureLevels: currentSubclassFeatureLevels,
        selectedOptionIds: {
          for (final option in selectedOptions)
            if (option.id != null) option.id!
        },
        onlyAlwaysPrepared: onlyAlwaysPrepared,
      );
  return _ResolvedDerivedSources(
    selectedOptions: selectedOptions,
    selectedChoicesByClassFeatureId: selectedChoicesByClassFeatureId,
    selectedChoicesBySubclassFeatureId: selectedChoicesBySubclassFeatureId,
    currentClassFeatures: currentClassFeatures,
    currentSubclassFeatures: currentSubclassFeatures,
    featureDisplayProperties: featureDisplayProperties,
    featureModifiers: featureModifiers,
    alwaysPreparedSpellKeys: spellGrantKeys(onlyAlwaysPrepared: true),
    grantedClassSpellKeys: spellGrantKeys(onlyAlwaysPrepared: false),
  );
}

void _validateGenericChoiceEligibility(
  CharacterData character,
  Map<String, List<_SelectedGenericChoice>> selectedByGroupKey,
  List<ChoiceGroupData> groups,
  List<ClassFeatureData> currentClassFeatures,
  List<SubclassFeatureData> currentSubclassFeatures,
) {
  final selectedOptionsByGroupKey = {
    for (final entry in selectedByGroupKey.entries)
      entry.key: [for (final selected in entry.value) selected.option],
  };
  final scores = _buildAbilityScores(
    character,
    [
      for (final selected in selectedByGroupKey.values)
        for (final item in selected) item.option
    ],
  );
  final contextsByGroupKey = {
    for (final groupKey in selectedByGroupKey.keys)
      groupKey: buildChoiceEligibilityContext(
        character: character,
        evaluatingGroupKey: groupKey,
        selectedOptionsByGroupKey: selectedOptionsByGroupKey,
        groups: groups,
        abilityScores: scores,
        currentClassFeatures: currentClassFeatures,
        currentSubclassFeatures: currentSubclassFeatures,
      ),
  };
  for (final entry in selectedByGroupKey.entries) {
    for (final selected in entry.value) {
      final requirements = <ChoiceRequirement>[
        for (final data
            in selected.option.requirements ?? const <ChoiceRequirementData>[])
          _choiceRequirement(data),
        if (selected.option.requiredExistingSkill case final skill?)
          ChoiceRequirement(
            kind: ChoiceRequirementKind.existingSkill,
            referenceKey: skill.name,
          ),
      ];
      final requiredToolKey = selected.option.requiredExistingToolKey?.trim();
      if (requiredToolKey != null && requiredToolKey.isNotEmpty) {
        requirements.add(ChoiceRequirement(
          kind: ChoiceRequirementKind.existingTool,
          referenceKey: requiredToolKey,
        ));
      }
      final result = evaluateChoiceOptionEligibility(
        requirements: requirements,
        context: contextsByGroupKey[entry.key]!,
      );
      if (!result.isEligible) {
        throw InputValidationException(
          'choices.${entry.key}',
          'choice option "${selected.option.optionKey}" is unavailable: '
              '${result.failedRequirements.map((failure) => failure.reason).join(', ')}.',
        );
      }
    }
  }
}

ChoiceRequirement _choiceRequirement(ChoiceRequirementData data) {
  final kind = switch (data.type) {
    ChoiceRequirementType.minimumClassLevel =>
      ChoiceRequirementKind.minimumClassLevel,
    ChoiceRequirementType.minimumCharacterLevel =>
      ChoiceRequirementKind.minimumCharacterLevel,
    ChoiceRequirementType.abilityScore => ChoiceRequirementKind.abilityScore,
    ChoiceRequirementType.knownSpell => ChoiceRequirementKind.knownSpell,
    ChoiceRequirementType.knownCantrip => ChoiceRequirementKind.knownCantrip,
    ChoiceRequirementType.feature => ChoiceRequirementKind.feature,
    ChoiceRequirementType.selectedChoiceOption =>
      ChoiceRequirementKind.selectedChoiceOption,
  };
  return ChoiceRequirement(
    kind: kind,
    classKey: data.classKey,
    ability: data.ability?.name,
    value: data.value,
    referenceKey: data.referenceKey,
    choiceGroupKey: data.choiceGroupKey,
    optionKey: data.optionKey,
  );
}

class _SelectedGenericChoice {
  const _SelectedGenericChoice(this.choice, this.option);

  final CharacterChoiceData choice;
  final ChoiceOptionData option;
}

void _validateGenericChoiceSelectionRules(
  Map<String, List<_SelectedGenericChoice>> selectedByGroupKey,
  List<ChoiceGroupData> groups,
) {
  final exclusiveGroups = <String, String>{};
  for (final group in groups) {
    final selections = selectedByGroupKey[group.referenceKey] ??
        const <_SelectedGenericChoice>[];
    final selectionCount = group.selectionCount ?? 1;
    if (selections.length > selectionCount) {
      throw InputValidationException(
        'choices.${group.referenceKey}',
        'selects ${selections.length} options; maximum is $selectionCount.',
      );
    }
    final optionKeys = <String>{};
    final selectionIndices = <int>{};
    for (final selection in selections) {
      if (group.allowDuplicates != true &&
          !optionKeys.add(selection.option.optionKey)) {
        throw InputValidationException(
          'choices.${group.referenceKey}',
          'does not allow duplicate option keys.',
        );
      }
      final index = selection.choice.selectionIndex;
      if (index != null && !selectionIndices.add(index)) {
        throw InputValidationException(
          'choices.${group.referenceKey}',
          'duplicates selection index $index.',
        );
      }
    }
    if (selections.isEmpty) continue;
    final exclusiveKey = group.exclusiveKey?.trim();
    if (exclusiveKey == null || exclusiveKey.isEmpty) continue;
    final previous = exclusiveGroups[exclusiveKey];
    if (previous != null && previous != group.referenceKey) {
      throw InputValidationException(
        'choices.${group.referenceKey}',
        'conflicts with choice group "$previous".',
      );
    }
    if (selections.isNotEmpty) {
      exclusiveGroups[exclusiveKey] = group.referenceKey;
    }
  }
}

void _validateChoiceClassEntryBinding(
  CharacterChoiceData choice,
  ChoiceGroupData group,
  CharacterData character,
) {
  final classSource = group.sourceClassId != null ||
      group.sourceSubclassId != null ||
      group.sourceFeatureId != null ||
      group.sourceSubclassFeatureId != null;
  if (!classSource) {
    if (choice.classEntry != null) {
      throw InputValidationException(
        'choices.${group.referenceKey}.classEntry',
        'is only valid for a class-sourced choice group.',
      );
    }
    return;
  }

  final entries = character.classEntries ?? const <CharacterClassEntryData>[];
  final matchingEntries = entries.where((entry) {
    final classId = entry.classData?.id;
    final subclassId = entry.subclass?.id;
    if (group.sourceClassId != null && classId != group.sourceClassId) {
      return false;
    }
    if (group.sourceSubclassId != null &&
        subclassId != group.sourceSubclassId) {
      return false;
    }
    if (group.sourceFeatureId != null && classId == null) return false;
    if (group.sourceSubclassFeatureId != null && subclassId == null) {
      return false;
    }
    return true;
  }).toList();
  if (matchingEntries.isEmpty) {
    throw InputValidationException(
      'choices.${group.referenceKey}.classEntry',
      'must match an active class or subclass source.',
    );
  }

  final classEntryId = choice.classEntry?.id;
  if (classEntryId == null) {
    if (matchingEntries.length > 1) {
      throw InputValidationException(
        'choices.${group.referenceKey}.classEntry',
        'is required when multiple matching class entries exist.',
      );
    }
    return;
  }
  if (matchingEntries.where((entry) => entry.id == classEntryId).length != 1) {
    throw InputValidationException(
      'choices.${group.referenceKey}.classEntry',
      'does not match the choice group source.',
    );
  }
}

Future<void> _validateGenericChoiceReferenceKeys(
  Session session,
  List<ChoiceOptionData> selectedOptions, {
  Transaction? transaction,
}) async {
  final toolKeys = <String>{};
  final spellKeys = <String>{};
  for (final option in selectedOptions) {
    toolKeys.addAll(option.grantedToolKeys ?? const <String>[]);
    spellKeys.addAll(option.grantedSpellKeys ?? const <String>[]);
  }
  if (toolKeys.any((key) => key.trim().isEmpty || key != key.trim())) {
    throw InputValidationException(
      'choices.grantedToolKeys',
      'must contain canonical, non-empty ToolData.referenceKey values.',
    );
  }
  if (spellKeys.any((key) => key.trim().isEmpty || key != key.trim())) {
    throw InputValidationException(
      'choices.grantedSpellKeys',
      'must contain canonical, non-empty SpellData.referenceKey values.',
    );
  }
  final tools = toolKeys.isEmpty
      ? const <ToolData>[]
      : await ToolData.db.find(
          session,
          where: (t) => t.referenceKey.inSet(toolKeys),
          transaction: transaction,
        );
  final spells = spellKeys.isEmpty
      ? const <SpellData>[]
      : await SpellData.db.find(
          session,
          where: (t) => t.referenceKey.inSet(spellKeys),
          transaction: transaction,
        );
  final knownTools = tools.map((tool) => tool.referenceKey).toSet();
  final knownSpells = spells.map((spell) => spell.referenceKey).toSet();
  for (final key in toolKeys.difference(knownTools)) {
    throw InputValidationException(
      'choices.grantedToolKeys',
      'unknown ToolData.referenceKey "$key".',
    );
  }
  for (final key in spellKeys.difference(knownSpells)) {
    throw InputValidationException(
      'choices.grantedSpellKeys',
      'unknown SpellData.referenceKey "$key".',
    );
  }
}

void _validateChoiceGroupSourceInvariant(ChoiceGroupData group) {
  final sourceCount = [
    group.sourceClassId,
    group.sourceSubclassId,
    group.sourceFeatureId,
    group.sourceSubclassFeatureId,
    group.sourceRaceId,
    group.sourceSubraceId,
    group.sourceRaceFeatureId,
    group.sourceBackgroundId,
  ].where((id) => id != null).length;
  if (sourceCount != 1) {
    throw InputValidationException(
      'choiceGroups.${group.referenceKey}',
      'A choice group must have exactly one source relation.',
    );
  }
}
