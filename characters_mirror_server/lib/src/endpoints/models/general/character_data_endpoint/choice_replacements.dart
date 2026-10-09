part of '../character_data_endpoint.dart';

Future<CharacterData> _replaceLevelUpChoices(
    Session session,
    CharacterData draft,
    CharacterData before,
    CharacterClassEntryData entry,
    ClassStepView step,
    LevelUpRequest request,
    {Transaction? transaction,
    required _CharacterResolveContext resolveContext}) async {
  if (request.choiceReplacements?.isNotEmpty != true) return draft;
  final views = step.choiceGroups ?? <ChoiceGroupView>[];
  try {
    final originalIds = {
      for (final choice in before.choices ?? <CharacterChoiceData>[]) choice.id
    };
    if ((request.choiceReplacements ?? <LevelUpChoiceReplacementData>[])
        .any((r) => !originalIds.contains(r.selectionId))) {
      throw ArgumentError('Only prior choices can be replaced.');
    }
    final rows = replaceProgressionChoices(
        (draft.choices ?? <CharacterChoiceData>[]).map((c) => c.toJson()),
        (request.choiceReplacements ?? <LevelUpChoiceReplacementData>[])
            .map((r) => r.toJson()),
        views.map((v) => {
              ...v.group!.toJson(),
              'options': v.options?.map((o) => o.toJson()).toList()
            }),
        classEntryId: entry.id!,
        classLevel: entry.level!);
    final projected = draft.copyWith(
        choices: rows.map(CharacterChoiceData.fromJson).toList());
    final allGroups =
        await resolveContext.choiceGroups(transaction: transaction);
    final allOptions = await resolveContext.choiceOptions(
      {
        for (final group in allGroups)
          if (group.id != null) group.id!
      },
      transaction: transaction,
    );
    final groupsByKey = {
      for (final group in allGroups) group.referenceKey: group
    };
    final selectedByGroup = <String, List<ChoiceOptionData>>{};
    for (final choice in projected.choices ?? <CharacterChoiceData>[]) {
      final groupKey = choice.groupKey;
      final group = groupsByKey[groupKey];
      if (groupKey == null || group == null || group.id == null) continue;
      final option = allOptions
          .where((item) =>
              item.choiceGroupId == group.id &&
              item.optionKey == choice.optionKey)
          .firstOrNull;
      if (option == null) continue;
      selectedByGroup.putIfAbsent(groupKey, () => []).add(option);
    }
    final activeClassFeatures = <ClassFeatureData>[];
    final activeSubclassFeatures = <SubclassFeatureData>[];
    for (final classEntry
        in projected.classEntries ?? const <CharacterClassEntryData>[]) {
      if (classEntry.classData?.id case final classId?) {
        activeClassFeatures.addAll(await resolveContext.classFeatures(
          classId,
          classEntry.level ?? 0,
          transaction: transaction,
        ));
      }
      if (classEntry.subclass?.id case final subclassId?) {
        activeSubclassFeatures.addAll(await resolveContext.subclassFeatures(
          subclassId,
          classEntry.level ?? 0,
          transaction: transaction,
        ));
      }
    }
    final scores = _buildAbilityScores(
      projected,
      [for (final options in selectedByGroup.values) ...options],
    );
    final inactiveGroups = <String>{};
    for (final group
        in allGroups.where((g) => g.requirements?.isNotEmpty == true)) {
      final context = buildChoiceEligibilityContext(
        character: projected,
        evaluatingGroupKey: group.referenceKey,
        selectedOptionsByGroupKey: selectedByGroup,
        groups: allGroups,
        abilityScores: scores,
        currentClassFeatures: activeClassFeatures,
        currentSubclassFeatures: activeSubclassFeatures,
      );
      if (!evaluateChoiceOptionEligibility(
        requirements: group.requirements!.map(_choiceRequirement),
        context: context,
      ).isEligible) {
        inactiveGroups.add(group.referenceKey);
      }
    }
    final cleaned = inactiveGroups.isEmpty
        ? projected
        : projected.copyWith(choices: [
            for (final choice in projected.choices ?? <CharacterChoiceData>[])
              if (!inactiveGroups.contains(choice.groupKey)) choice,
          ]);
    final sources = await _resolveDerivedSources(
        session, cleaned, cleaned.choices!,
        transaction: transaction,
        resolveContext: resolveContext,
        allowIncompleteConditionalGroups: true);
    final groups = await resolveContext.choiceGroups(transaction: transaction);
    final options = <String, List<ChoiceOptionData>>{};
    for (final option in sources.selectedOptions) {
      final group = groups.firstWhere((g) => g.id == option.choiceGroupId);
      options.putIfAbsent(group.referenceKey, () => []).add(option);
    }
    final cantripKeys = choiceCantripCandidateKeys([
      ...sources.selectedOptions.map((o) => o.toJson()),
      ...views
          .expand((v) => v.options ?? <ChoiceOptionData>[])
          .map((o) => o.toJson()),
    ]);
    for (final replacement in request.choiceReplacements!) {
      final view = views
          .firstWhere((v) => v.group!.referenceKey == replacement.groupKey);
      final option =
          view.options!.firstWhere((o) => o.optionKey == replacement.optionKey);
      final context = buildChoiceEligibilityContext(
          character: cleaned,
          evaluatingGroupKey: replacement.groupKey,
          selectedOptionsByGroupKey: options,
          groups: groups,
          abilityScores:
              _buildAbilityScores(projected, sources.selectedOptions),
          currentClassFeatures: sources.currentClassFeatures,
          currentSubclassFeatures: sources.currentSubclassFeatures,
          cantripReferenceKeys: cantripKeys,
          grantedCantripKeys: knownChoiceCantripKeys(
              character: cleaned.toJson(),
              cantripReferenceKeys: cantripKeys,
              otherOptions: options.entries
                  .where((e) => e.key != replacement.groupKey)
                  .expand((e) => e.value)
                  .map((o) => o.toJson()),
              otherFeatures: [
                ...sources.currentClassFeatures.map((f) => f.toJson()),
                ...sources.currentSubclassFeatures.map((f) => f.toJson())
              ]));
      if (!choiceOptionEligibilityFromProtocol(option.toJson(), context)
          .isEligible) {
        throw ArgumentError('Unavailable replacement option.');
      }
    }
    return cleaned;
  } on ArgumentError catch (error) {
    throw InputValidationException(
        'choiceReplacements', error.message.toString());
  }
}

Future<CharacterData> _preserveChoiceReplacementHistory(
    Session session, CharacterData? current, CharacterData next,
    {bool trusted = false, Transaction? transaction}) async {
  if (trusted) return next;
  final groups =
      await ChoiceGroupData.db.find(session, transaction: transaction);
  final controlled = {
    for (final group in groups)
      if (group.progressionKey != null) group.referenceKey
  };
  final previous = {
    for (final choice in current?.choices ?? <CharacterChoiceData>[])
      if (choice.id != null) choice.id!: choice
  };
  final nextById = {
    for (final choice in next.choices ?? <CharacterChoiceData>[])
      if (choice.id != null) choice.id!: choice
  };
  for (final old in previous.values) {
    if (!controlled.contains(old.groupKey)) continue;
    final value = nextById[old.id];
    if (value == null ||
        value.groupKey != old.groupKey ||
        value.optionKey != old.optionKey ||
        value.classEntry?.id != old.classEntry?.id) {
      throw InputValidationException('choices',
          'Progression choices can only be replaced through level-up.');
    }
  }
  return next.copyWith(choices: [
    for (final choice in next.choices ?? <CharacterChoiceData>[])
      choice.copyWith(
          replacementHistory: previous[choice.id]?.replacementHistory)
  ]);
}
