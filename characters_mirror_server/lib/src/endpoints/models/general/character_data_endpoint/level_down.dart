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
  final subclassRequiredLevel =
      entry.subclass?.levelRequired ?? entry.classData!.subclassChoiceLevel;
  final dropsSubclass = entry.subclass != null &&
      subclassRequiredLevel != null &&
      subclassRequiredLevel > targetLevel;
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
  final nextEntry = entry.copyWith(
    level: targetLevel,
    subclass: subclass,
    hpRolledValues: (entry.hpRolledValues?.isNotEmpty ?? false)
        ? entry.hpRolledValues!
            .take(min(entry.hpRolledValues!.length, targetLevel))
            .toList()
        : entry.hpRolledValues,
  );
  final targetCharacter = before.copyWith(
    classEntries: [
      for (final item in entries) item.id == entry.id ? nextEntry : item,
    ],
  );
  final removedChoices = classChoices
      .where((choice) => removedGroupKeys.contains(choice.groupKey))
      .toList();
  final choices = classChoices
      .where((choice) => !removedGroupKeys.contains(choice.groupKey))
      .toList();
  final choicesForEligibility = [
    for (final choice in before.choices ?? const <CharacterChoiceData>[])
      if (choice.classEntry?.id != entry.id ||
          !removedGroupKeys.contains(choice.groupKey))
        choice,
  ];
  final allGroups = await ChoiceGroupData.db.find(
    session,
    transaction: transaction,
  );
  final groupsByKey = {
    for (final group in allGroups) group.referenceKey: group
  };
  final allOptions = await ChoiceOptionData.db.find(
    session,
    transaction: transaction,
  );
  final selectedOptionsByGroupKey = <String, List<ChoiceOptionData>>{};
  for (final choice in choicesForEligibility) {
    final group = groupsByKey[choice.groupKey];
    final option = allOptions
        .where((item) =>
            item.choiceGroupId == group?.id &&
            item.optionKey == choice.optionKey)
        .firstOrNull;
    if (option != null) {
      selectedOptionsByGroupKey
          .putIfAbsent(choice.groupKey!, () => <ChoiceOptionData>[])
          .add(option);
    }
  }
  final targetOldClassFeatureIds = {
    for (final feature
        in oldStep.currentLevelFeatures ?? const <ClassFeatureData>[])
      if (feature.id != null) feature.id!,
  };
  final targetOldSubclassFeatureIds = {
    for (final feature
        in oldStep.currentSubclassFeatures ?? const <SubclassFeatureData>[])
      if (feature.id != null) feature.id!,
  };
  final otherClassFeatureIds =
      (before.derived?.activeFeatures ?? const <CharacterFeatureViewData>[])
          .where((feature) =>
              feature.sourceType == CharacterFeatureSourceType.classFeature &&
              !targetOldClassFeatureIds.contains(feature.sourceId))
          .map((feature) => feature.sourceId)
          .toSet();
  final otherSubclassFeatureIds = (before.derived?.activeFeatures ??
          const <CharacterFeatureViewData>[])
      .where((feature) =>
          feature.sourceType == CharacterFeatureSourceType.subclassFeature &&
          !targetOldSubclassFeatureIds.contains(feature.sourceId))
      .map((feature) => feature.sourceId)
      .toSet();
  final otherClassFeatures = otherClassFeatureIds.isEmpty
      ? const <ClassFeatureData>[]
      : await ClassFeatureData.db.find(
          session,
          transaction: transaction,
          where: (t) => t.id.inSet(otherClassFeatureIds),
        );
  final otherSubclassFeatures = otherSubclassFeatureIds.isEmpty
      ? const <SubclassFeatureData>[]
      : await SubclassFeatureData.db.find(
          session,
          transaction: transaction,
          where: (t) => t.id.inSet(otherSubclassFeatureIds),
        );
  final targetClassFeatures = [
    ...?targetStep.currentLevelFeatures,
    ...otherClassFeatures,
  ];
  final targetSubclassFeatures = [
    ...?targetStep.currentSubclassFeatures,
    ...otherSubclassFeatures,
  ];
  final targetSelectedOptions = [
    for (final selected in selectedOptionsByGroupKey.values) ...selected,
  ];
  final targetAbilityScores = _buildAbilityScores(
    targetCharacter,
    targetSelectedOptions,
  );
  final eligibilityContexts = {
    for (final groupKey
        in choices.map((choice) => choice.groupKey).whereType<String>())
      groupKey: buildChoiceEligibilityContext(
        character: targetCharacter,
        evaluatingGroupKey: groupKey,
        selectedOptionsByGroupKey: selectedOptionsByGroupKey,
        groups: allGroups,
        abilityScores: targetAbilityScores,
        currentClassFeatures: targetClassFeatures,
        currentSubclassFeatures: targetSubclassFeatures,
      ),
  };
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
    final context = eligibilityContexts[groupKey];
    if (context == null) {
      throw InputValidationException(
          'choices.$groupKey', 'Choice group is unavailable.');
    }
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
