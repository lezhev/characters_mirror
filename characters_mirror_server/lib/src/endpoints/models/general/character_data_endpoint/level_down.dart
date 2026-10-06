part of '../character_data_endpoint.dart';

void _validateLevelDownRequest(LevelDownRequest request) {
  Rules.rangeInt('characterId', request.characterId, min: 1, max: 2147483647);
  Rules.rangeInt('expectedVersion', request.expectedVersion,
      min: 1, max: 2147483647);
  Rules.shortText('classEntryId', request.classEntryId);
  Rules.smallCollection('repairs', request.repairs);
  final slots = <String>{};
  for (final repair in request.repairs ?? const <LevelDownChoiceRepair>[]) {
    Rules.shortText('repairs.groupKey', repair.groupKey);
    Rules.rangeInt('repairs.selectionIndex', repair.selectionIndex,
        min: 0, max: 100);
    Rules.shortText('repairs.currentOptionKey', repair.currentOptionKey);
    Rules.shortText(
        'repairs.replacementOptionKey', repair.replacementOptionKey);
    if (!slots.add('${repair.groupKey}:${repair.selectionIndex}')) {
      throw InputValidationException('repairs', 'Duplicate choice repair.');
    }
  }
}

Future<LevelDownPreview> _previewLevelDown(
  Session session,
  CharacterData before,
  LevelDownRequest request, {
  Transaction? transaction,
  required _CharacterResolveContext resolveContext,
}) async {
  if (before.version != request.expectedVersion) {
    throw InputValidationException('expectedVersion',
        'Character changed. Refresh the character and try again.');
  }
  final entries = before.classEntries ?? const <CharacterClassEntryData>[];
  final entry = entries.where((e) => e.id == request.classEntryId).firstOrNull;
  if (entry == null || entry.classData?.id == null) {
    throw InputValidationException(
        'classEntryId', 'Unknown character class entry.');
  }
  final oldLevel = entry.level;
  if (oldLevel == null || oldLevel <= 1) {
    throw InputValidationException('level', 'Level 1 cannot be reduced to 0.');
  }
  final targetLevel = oldLevel - 1;
  final scores = {
    for (final e in before.derived?.abilityScores?.entries ??
        const <MapEntry<Ability, int>>[])
      e.key.name: e.value,
  };
  final endpoint = ClassDataEndpoint();
  final oldStep = await endpoint.getStepView(
    session,
    entry.classData!.id!,
    selectedLevel: oldLevel,
    isStartingClass: entry.isStartingClass == true,
    selectedSubclassId: entry.subclass?.id,
    abilityScores: scores,
  );
  final dropsSubclass = entry.subclass != null &&
      (entry.classData!.subclassChoiceLevel ?? 0) > targetLevel;
  final subclass = dropsSubclass ? null : entry.subclass;
  final targetStep = await endpoint.getStepView(
    session,
    entry.classData!.id!,
    selectedLevel: targetLevel,
    isStartingClass: entry.isStartingClass == true,
    selectedSubclassId: subclass?.id,
    abilityScores: scores,
  );
  final oldGroups = {
    for (final view in oldStep.choiceGroups ?? const <ChoiceGroupView>[])
      if (view.group?.referenceKey case final key?) key: view.group!,
  };
  final targetGroupViews = {
    for (final view in targetStep.choiceGroups ?? const <ChoiceGroupView>[])
      if (view.group?.referenceKey case final key?) key: view,
  };
  final removedGroupKeys = oldGroups.keys.toSet()
    ..removeAll(targetGroupViews.keys);
  final removedGroups = [for (final key in removedGroupKeys) oldGroups[key]!];
  final classChoices = (before.choices ?? const <CharacterChoiceData>[])
      .where((choice) => choice.classEntry?.id == entry.id)
      .toList();
  final removedChoices = classChoices
      .where((choice) => removedGroupKeys.contains(choice.groupKey))
      .toList();
  final previousFeatureIds = {
    for (final feature
        in oldStep.currentLevelFeatures ?? const <ClassFeatureData>[])
      if (feature.id != null) feature.id!,
    for (final feature
        in oldStep.currentSubclassFeatures ?? const <SubclassFeatureData>[])
      if (feature.id != null) feature.id!,
  };
  final choices = classChoices
      .where((choice) => !removedGroupKeys.contains(choice.groupKey))
      .toList();
  final repairsBySlot = {
    for (final repair in request.repairs ?? const <LevelDownChoiceRepair>[])
      '${repair.groupKey}:${repair.selectionIndex}': repair,
  };
  final invalidViews = <LevelDownInvalidChoiceView>[];
  final missing = <String>[];
  final repairedChoices = <CharacterChoiceData>[];
  for (final choice in choices) {
    final groupKey = choice.groupKey ?? '';
    final optionKey = choice.optionKey ?? '';
    final groupView = targetGroupViews[groupKey];
    final currentOption = groupView?.options
        ?.where((option) => option.optionKey == optionKey)
        .firstOrNull;
    if (groupView == null || currentOption == null) {
      throw InputValidationException(
          'choices.$groupKey', 'Choice is unavailable.');
    }
    final context = await _levelDownEligibilityContext(
      session,
      before,
      entry: entry,
      targetLevel: targetLevel,
      choices: [
        for (final item in before.choices ?? const <CharacterChoiceData>[])
          if (item.classEntry?.id != entry.id ||
              !removedGroupKeys.contains(item.groupKey))
            item,
      ],
      candidate: choice,
      targetStep: targetStep,
      replacedFeatureIds: previousFeatureIds,
      transaction: transaction,
    );
    final eligibility = _evaluateChoiceOptionData(currentOption, context);
    if (eligibility.isEligible) {
      repairedChoices.add(choice);
      continue;
    }
    final alternatives = <ChoiceOptionData>[];
    for (final option in groupView.options ?? const <ChoiceOptionData>[]) {
      if (option.optionKey == optionKey) continue;
      if (_evaluateChoiceOptionData(option, context).isEligible) {
        alternatives.add(option);
      }
    }
    final repair =
        repairsBySlot.remove('$groupKey:${choice.selectionIndex ?? 0}');
    if (repair != null) {
      if (repair.currentOptionKey != optionKey) {
        throw InputValidationException('repairs.$groupKey', 'Choice changed.');
      }
      final replacement = alternatives
          .where((option) => option.optionKey == repair.replacementOptionKey)
          .firstOrNull;
      if (replacement == null) {
        throw InputValidationException(
            'repairs.$groupKey', 'Replacement choice is unavailable.');
      }
      repairedChoices.add(choice.copyWith(optionKey: replacement.optionKey));
    } else {
      invalidViews.add(LevelDownInvalidChoiceView(
        groupKey: groupKey,
        selectionIndex: choice.selectionIndex ?? 0,
        optionKey: optionKey,
        reason: eligibility.failedRequirements
            .map((failure) => failure.reason)
            .join(', '),
        eligibleAlternativeOptionKeys:
            alternatives.map((option) => option.optionKey).toList(),
      ));
      missing.add('Replace unavailable choice "$groupKey" ($optionKey).');
    }
  }
  if (repairsBySlot.isNotEmpty) {
    throw InputValidationException(
        'repairs', 'Repair does not match an unavailable choice.');
  }

  final nextEntry = entry.copyWith(
    level: targetLevel,
    subclass: subclass,
    hpRolledValues: (entry.hpRolledValues?.isNotEmpty ?? false)
        ? entry.hpRolledValues!.take(entry.hpRolledValues!.length - 1).toList()
        : entry.hpRolledValues,
  );
  // Invalid choices are omitted from the transient projection so the ordinary
  // derived resolver can still calculate all independent consequences.
  final choicesForProjection = repairedChoices;
  var draft = before.copyWith(
    classEntries: [
      for (final item in entries) item.id == entry.id ? nextEntry : item
    ],
    choices: [
      for (final choice in before.choices ?? const <CharacterChoiceData>[])
        if (choice.classEntry?.id != entry.id) choice,
      ...choicesForProjection,
    ],
  );
  var derived = await _buildDerivedData(session, draft,
      transaction: transaction, resolveContext: resolveContext);
  draft = _preserveLevelChangeResources(
    before,
    draft.copyWith(derived: derived),
    fillNewResources: false,
  );
  derived = await _buildDerivedData(session, draft,
      transaction: transaction, resolveContext: resolveContext);
  draft = draft.copyWith(derived: derived);

  final removedClassFeatures =
      (oldStep.currentLevelFeatures ?? const <ClassFeatureData>[])
          .where((feature) => feature.level > targetLevel)
          .toList();
  final removedSubclassFeatures =
      (oldStep.currentSubclassFeatures ?? const <SubclassFeatureData>[])
          .where((feature) => dropsSubclass || feature.level > targetLevel)
          .toList();
  final oldResources = _levelDownResourceMaxima(before);
  final newResources = _levelDownResourceMaxima(draft);
  return LevelDownPreview(
    before: before,
    character: draft,
    classEntryId: entry.id!,
    oldLevel: oldLevel,
    targetLevel: targetLevel,
    removedClassFeatures: removedClassFeatures,
    removedSubclassFeatures: removedSubclassFeatures,
    removedChoiceGroups: removedGroups,
    removedChoices: removedChoices,
    invalidChoices: invalidViews,
    oldMaxHp: before.derived?.maxHp,
    newMaxHp: draft.derived?.maxHp,
    oldProficiencyBonus: before.derived?.proficiencyBonus,
    newProficiencyBonus: draft.derived?.proficiencyBonus,
    oldResourceMaxima: oldResources,
    newResourceMaxima: newResources,
    oldSpellSlots: before.derived?.spellSlots ?? const <int, int>{},
    newSpellSlots: draft.derived?.spellSlots ?? const <int, int>{},
    oldPactSlots: before.derived?.pactSlots ?? const <int, int>{},
    newPactSlots: draft.derived?.pactSlots ?? const <int, int>{},
    missingDecisions: missing,
  );
}

Future<ChoiceEligibilityContext> _levelDownEligibilityContext(
  Session session,
  CharacterData before, {
  required CharacterClassEntryData entry,
  required int targetLevel,
  required List<CharacterChoiceData> choices,
  required CharacterChoiceData candidate,
  required ClassStepView targetStep,
  required Set<int> replacedFeatureIds,
  Transaction? transaction,
}) async {
  final levels = <String, int>{};
  for (final classEntry
      in before.classEntries ?? const <CharacterClassEntryData>[]) {
    final key = _normalizedTextOrNull(classEntry.classData?.referenceKey);
    if (key == null) continue;
    levels[key] = (levels[key] ?? 0) +
        (classEntry.id == entry.id ? targetLevel : classEntry.level ?? 0);
  }
  final groups =
      await ChoiceGroupData.db.find(session, transaction: transaction);
  final groupsByKey = {for (final group in groups) group.referenceKey: group};
  final options =
      await ChoiceOptionData.db.find(session, transaction: transaction);
  final selectedOptions = <ChoiceOptionData>[];
  for (final choice in choices) {
    if (identical(choice, candidate)) {
      continue;
    }
    final groupId = groupsByKey[choice.groupKey]?.id;
    final option = options
        .where((item) =>
            item.choiceGroupId == groupId && item.optionKey == choice.optionKey)
        .firstOrNull;
    if (option != null) selectedOptions.add(option);
  }
  // Include selected options from other class entries as well.
  final abilityScores = _buildAbilityScores(before, selectedOptions);
  final selectedKeys = <String>{
    for (final choice in choices)
      if (!identical(choice, candidate))
        encodeSelectedChoiceOptionKey(
            choice.groupKey ?? '', choice.optionKey ?? ''),
  };
  final skillKeys = <String>{
    ...?before.race?.skillProficiencies?.map((skill) => skill.name),
    ...?before.subrace?.skillProficiencies?.map((skill) => skill.name),
    ...?before.background?.skillProficiencies?.map((skill) => skill.name),
    for (final selection
        in before.skillSelections ?? const <CharacterSkillSelectionData>[])
      if (selection.skill != null) selection.skill!.name,
    for (final option in selectedOptions)
      ...?option.grantedSkills?.map((skill) => skill.name),
  };
  final manualSkills = before.manualSkillProficiencyOverrides;
  if (manualSkills != null) {
    for (final state in manualSkills) {
      if (state.level == CharacterSkillProficiencyLevel.none) {
        skillKeys.remove(state.skill.name);
      } else {
        skillKeys.add(state.skill.name);
      }
    }
  } else if (before.manualSkillProficiencies != null) {
    skillKeys
      ..clear()
      ..addAll([
        for (final state in before.manualSkillProficiencies!)
          if (state.level != CharacterSkillProficiencyLevel.none)
            state.skill.name,
      ]);
  }
  final toolKeys = <String>{
    ...?before.race?.toolProficiencyKeys,
    ...?before.subrace?.toolProficiencyKeys,
    ...?before.background?.toolProficiencyKeys,
    for (final classEntry
        in before.classEntries ?? const <CharacterClassEntryData>[])
      ...(classEntry.isStartingClass == true
          ? classEntry.classData?.toolTrainingKeys ?? const <String>[]
          : classEntry.classData?.multiclassToolTrainingKeys ??
              const <String>[]),
    for (final option in selectedOptions) ...?option.grantedToolKeys,
  }
    ..removeAll(
        before.manualToolProficiencyOverrides?.removedKeys ?? const <String>[])
    ..addAll(
        before.manualToolProficiencyOverrides?.addedKeys ?? const <String>[]);
  final spellFacts = collectChoiceSpellFacts([
    for (final selection
        in before.spellSelections ?? const <CharacterSpellSelectionData>[])
      if (_normalizedTextOrNull(selection.spellKey) case final key?)
        ChoiceSpellSelectionFact(key: key, kind: selection.kind?.name ?? ''),
  ]);
  final otherActiveFeatureIds =
      (before.derived?.activeFeatures ?? const <CharacterFeatureViewData>[])
          .where((feature) =>
              feature.sourceType == CharacterFeatureSourceType.classFeature ||
              feature.sourceType == CharacterFeatureSourceType.subclassFeature)
          .map((feature) => feature.sourceId)
          .where((id) => !replacedFeatureIds.contains(id))
          .toSet();
  final otherActiveFeatureKeys = <String>{};
  if (otherActiveFeatureIds.isNotEmpty) {
    final otherClasses = await ClassFeatureData.db.find(
      session,
      transaction: transaction,
      where: (t) => t.id.inSet(otherActiveFeatureIds),
    );
    final otherSubclasses = await SubclassFeatureData.db.find(
      session,
      transaction: transaction,
      where: (t) => t.id.inSet(otherActiveFeatureIds),
    );
    otherActiveFeatureKeys.addAll([
      for (final feature in otherClasses)
        if (_normalizedTextOrNull(feature.referenceKey) case final key?) key,
      for (final feature in otherSubclasses)
        if (_normalizedTextOrNull(feature.referenceKey) case final key?) key,
    ]);
  }
  final featureKeys = <String>{
    ...otherActiveFeatureKeys,
    for (final feature
        in targetStep.currentLevelFeatures ?? const <ClassFeatureData>[])
      if (_normalizedTextOrNull(feature.referenceKey) case final key?) key,
    for (final feature
        in targetStep.currentSubclassFeatures ?? const <SubclassFeatureData>[])
      if (_normalizedTextOrNull(feature.referenceKey) case final key?) key,
  };
  return ChoiceEligibilityContext(
    totalCharacterLevel: (before.derived?.totalLevel ?? targetLevel) -
        (entry.level ?? targetLevel) +
        targetLevel,
    classLevelsByReferenceKey: levels,
    abilityScores: abilityScores,
    knownSpellKeys: spellFacts.knownSpellKeys,
    knownCantripKeys: spellFacts.knownCantripKeys,
    featureKeys: featureKeys,
    selectedChoiceOptionKeys: selectedKeys,
    skillKeys: skillKeys,
    toolKeys: toolKeys,
  );
}

ChoiceOptionEligibility _evaluateChoiceOptionData(
  ChoiceOptionData option,
  ChoiceEligibilityContext context,
) {
  final requirements = <ChoiceRequirement>[
    for (final data in option.requirements ?? const <ChoiceRequirementData>[])
      _choiceRequirement(data),
    if (option.requiredExistingSkill case final skill?)
      ChoiceRequirement(
          kind: ChoiceRequirementKind.existingSkill, referenceKey: skill.name),
    if (_normalizedTextOrNull(option.requiredExistingToolKey) case final key?)
      ChoiceRequirement(
          kind: ChoiceRequirementKind.existingTool, referenceKey: key),
  ];
  return evaluateChoiceOptionEligibility(
      requirements: requirements, context: context);
}

Map<String, int> _levelDownResourceMaxima(CharacterData character) => {
      for (final feature in character.derived?.activeFeatures ??
          const <CharacterFeatureViewData>[])
        for (final resource
            in feature.resources ?? const <CharacterResourceViewData>[])
          if (resource.isUnlimited != true)
            _resourceStateKey(
                    feature.sourceType, feature.sourceId, resource.key):
                resource.max,
    };
