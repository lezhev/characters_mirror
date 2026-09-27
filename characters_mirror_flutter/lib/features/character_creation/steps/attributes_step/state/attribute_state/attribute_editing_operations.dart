// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of '../attribute_state.dart';

extension AttributeStateEditingOperations on AttributeState {
  List<int?> get defaultAttributes => [15, 14, 13, 12, 10, 8];

  Map<Attribute, int> get emptyAttributeMap =>
      {for (var attr in Attribute.values) attr: 0};

  Map<Attribute, bool> get falseAttributeMap =>
      {for (var attr in Attribute.values) attr: false};

  void syncActiveDraftToCharacter() {
    final creationNotifier = ref.read(characterCreationProvider.notifier);
    final baseScores = state.assignedAttributes.map(
      (attribute, value) => MapEntry(attribute.name, value),
    );
    final racialChoices = buildRacialAttributeChoices();

    // The first write rebuilds this provider through its Character dependency.
    creationNotifier.syncAttributesDraft(baseScores);
    creationNotifier.syncRacialAttributeChoicesDraft(racialChoices);
  }

  void _updateActiveDraft({
    Map<Attribute, int>? assignedAttributes,
    List<int?>? remainingValues,
    List<RollBoxState>? boxStates,
    int? purchacePoints,
  }) {
    _updateDraft(
      state.selectionType,
      assignedAttributes: assignedAttributes,
      remainingValues: remainingValues,
      boxStates: boxStates,
      purchacePoints: purchacePoints,
    );
  }

  void _updateDraft(
    SelectType type, {
    Map<Attribute, int>? assignedAttributes,
    List<int?>? remainingValues,
    List<RollBoxState>? boxStates,
    int? purchacePoints,
  }) {
    final activeDraft = state.drafts[type] ?? _initialDraft(type);
    final draft = activeDraft.copyWith(
      assignedAttributes: assignedAttributes ?? activeDraft.assignedAttributes,
      remainingValues: remainingValues ?? activeDraft.remainingValues,
      boxStates: boxStates ?? activeDraft.boxStates,
      purchacePoints: purchacePoints ?? activeDraft.purchacePoints,
    );
    state = state.copyWith(
      drafts: {...state.drafts, type: draft},
    );
  }

  bool get hasRacialBonusMode =>
      state.fixedRaceBonuses.isNotEmpty ||
      state.resolvedBonusRules.any((rule) => !_isFlexibleRule(rule));

  bool get hasFlexiblePlusTwoOneMode =>
      state.resolvedBonusRules.any((rule) => _isFlexiblePlusTwoOneRule(rule));

  bool get hasFlexibleThreePlusOneMode =>
      state.resolvedBonusRules.any((rule) => _isFlexibleThreePlusOneRule(rule));

  void setBonusMode(AttributeBonusMode mode) {
    if (state.bonusMode == mode) return;

    final (bonusesPlusOne, bonusesPlusTwo) = _buildBonusMaps(
      fixedRaceBonuses: _activeFixedRaceBonuses(
        mode: mode,
        fixedRaceBonuses: state.fixedRaceBonuses,
      ),
      selectedByRule: state.selectedBonusAttributesByRule,
      rules: _activeRules(rules: state.resolvedBonusRules, mode: mode),
    );

    state = state.copyWith(
      bonusMode: mode,
      bonusesPlusOne: bonusesPlusOne,
      bonusesPlusTwo: bonusesPlusTwo,
    );
  }

  void changeType(SelectType type) {
    final drafts = {...state.drafts};
    drafts.putIfAbsent(type, () => _initialDraft(type));
    state = state.copyWith(selectionType: type, drafts: drafts);
  }

  void updateManualAttribute(Attribute attribute, int value) {
    if (state.selectionType != SelectType.manual) return;

    _updateActiveDraft(
      assignedAttributes: {
        ...state.assignedAttributes,
        attribute: value,
      },
    );
  }

  void changeAttributeBy(Attribute attribute, int delta) {
    if (state.selectionType != SelectType.purchace) return;

    final currentValue = state.assignedAttributes[attribute] ?? 8;
    final newValue = currentValue + delta;

    if (newValue < 3 || newValue > 18) return;

    final cost = _calculateCost(newValue) - _calculateCost(currentValue);
    if (state.purchacePoints - cost < 0) return;

    _updateActiveDraft(
      assignedAttributes: {
        ...state.assignedAttributes,
        attribute: newValue,
      },
      purchacePoints: state.purchacePoints - cost,
    );
  }

  int _calculateCost(int value) {
    switch (value) {
      case 18:
        return 19;
      case 17:
        return 15;
      case 16:
        return 12;
      case 15:
        return 9;
      case 14:
        return 7;
      case 13:
        return 5;
      case 12:
        return 4;
      case 11:
        return 3;
      case 10:
        return 2;
      case 9:
        return 1;
      case 8:
        return 0;
      case 7:
        return -1;
      case 6:
        return -2;
      case 5:
        return -4;
      case 4:
        return -6;
      case 3:
        return -9;
      default:
        return 0;
    }
  }

  void rollValueAt(int index) async {
    final type = state.selectionType;
    if (type != SelectType.random ||
        index < 0 ||
        index >= 6 ||
        index >= state.remainingValues.length ||
        index >= state.boxStates.length) {
      return;
    }

    _updateDraft(
      type,
      remainingValues: _normalizedRandomValues(state.remainingValues),
      boxStates: _normalizedRandomStates(
        state.boxStates,
        state.remainingValues,
      )..[index] = RollBoxState.rolling,
    );

    await Future.delayed(const Duration(milliseconds: 500));

    final draft = state.drafts[type];
    if (draft == null ||
        index < 0 ||
        index >= 6 ||
        index >= draft.remainingValues.length ||
        index >= draft.boxStates.length) {
      return;
    }

    final value = _rollDice();
    _updateDraft(
      type,
      remainingValues: _normalizedRandomValues(draft.remainingValues)
        ..[index] = value,
      boxStates: _normalizedRandomStates(
        draft.boxStates,
        draft.remainingValues,
      )..[index] = RollBoxState.filled,
    );
  }

  int _rollDice() {
    final rng = Random();
    final rolls = List.generate(4, (_) => rng.nextInt(6) + 1);
    rolls.sort();
    return rolls.sublist(1).reduce((a, b) => a + b);
  }

  void toggleBonus({
    required Attribute attribute,
    required int bonusValue,
    required bool? value,
  }) {
    if (!hasSelectableBonusRules(bonusValue)) return;

    if (value != true) {
      _removeSelectedBonus(attribute, bonusValue);
      return;
    }

    if (_isAttributeSelectedForBonus(attribute, bonusValue)) return;
    if (_isAttributeSelectedForBonus(
      attribute,
      _oppositeBonusValue(bonusValue),
    )) {
      return;
    }

    final candidateRules = _activeRules(
      rules: state.resolvedBonusRules,
      mode: state.bonusMode,
    ).where((rule) {
      return rule.bonusValue == bonusValue &&
          rule.allowedAttributes.contains(attribute);
    }).toList();
    if (candidateRules.isEmpty) return;

    final updatedSelections =
        _cloneSelections(state.selectedBonusAttributesByRule);
    final ruleWithSpace = candidateRules.firstWhere(
      (rule) =>
          (updatedSelections[rule.groupKey] ?? const <Attribute>{}).length <
          rule.pickCount,
      orElse: () => candidateRules.first,
    );
    final selectedForRule = <Attribute>{
      ...?updatedSelections[ruleWithSpace.groupKey],
    };

    if (selectedForRule.length >= ruleWithSpace.pickCount &&
        selectedForRule.isNotEmpty &&
        ruleWithSpace.mustBeDistinct) {
      selectedForRule.remove(selectedForRule.first);
    }

    if (selectedForRule.length >= ruleWithSpace.pickCount &&
        !ruleWithSpace.mustBeDistinct) {
      return;
    }

    selectedForRule.add(attribute);
    updatedSelections[ruleWithSpace.groupKey] = selectedForRule;
    _applySelectableBonusState(updatedSelections);
  }

  bool hasSelectableBonusRules(int bonusValue) {
    return _activeRules(
      rules: state.resolvedBonusRules,
      mode: state.bonusMode,
    ).any((rule) => rule.bonusValue == bonusValue);
  }

  bool isBonusAvailable({
    required Attribute attribute,
    required int bonusValue,
  }) {
    return _activeRules(
      rules: state.resolvedBonusRules,
      mode: state.bonusMode,
    ).any((rule) {
      return rule.bonusValue == bonusValue &&
          rule.allowedAttributes.contains(attribute);
    });
  }

  bool isBonusEditable({
    required Attribute attribute,
    required int bonusValue,
  }) {
    return _activeRules(
      rules: state.resolvedBonusRules,
      mode: state.bonusMode,
    ).any((rule) {
      return rule.bonusValue == bonusValue &&
          rule.allowedAttributes.contains(attribute) &&
          !rule.defaultAttributes.contains(attribute);
    });
  }

  Map<Attribute, int> mergeStatsAndBonuses() {
    return state.assignedAttributes.map((attribute, value) {
      final fixedBonus = _activeFixedRaceBonuses(
            mode: state.bonusMode,
            fixedRaceBonuses: state.fixedRaceBonuses,
          )[attribute] ??
          0;
      final selectableBonus = _selectedBonusValue(attribute);

      return MapEntry(attribute, value + fixedBonus + selectableBonus);
    });
  }

  List<CharacterChoiceData> buildRacialAttributeChoices() {
    final result = <CharacterChoiceData>[];
    final creationState = ref.read(characterCreationProvider);
    final raceId = creationState.character.race?.id;
    final hasFlexibleModes =
        state.resolvedBonusRules.any((rule) => _isFlexibleRule(rule));
    final modeGroup = creationState.raceChoiceGroups
        .map((view) => view.group)
        .where(
          (group) =>
              group?.sourceRaceId == raceId &&
              group?.referenceKey.endsWith('_ability_bonus_mode') == true,
        )
        .firstOrNull;

    if (raceId != null && hasFlexibleModes && modeGroup != null) {
      result.add(
        CharacterChoiceData(
          groupKey: modeGroup.referenceKey,
          optionKey: state.bonusMode.name,
        ),
      );
    }

    for (final rule in _activeRules(
      rules: state.resolvedBonusRules,
      mode: state.bonusMode,
    )) {
      final attributes = state.selectedBonusAttributesByRule[rule.groupKey] ??
          const <Attribute>{};

      for (final attribute in attributes) {
        result.add(
          CharacterChoiceData(
            groupKey: rule.groupKey,
            selectionIndex: result.length,
            optionKey:
                rule.optionKeyByAttribute[attribute.name] ?? attribute.name,
          ),
        );
      }
    }

    return result;
  }

  void unselectAttribute(Attribute attribute) {
    final currentValue = state.assignedAttributes[attribute];
    if (currentValue == 0) return;

    final updatedValues = [...state.remainingValues];
    final updatedStates = [...state.boxStates];
    final isRandom = state.selectionType == SelectType.random;

    if (isRandom) {
      final normalizedValues = _normalizedRandomValues(updatedValues);
      final normalizedStates = _normalizedRandomStates(
        updatedStates,
        normalizedValues,
      );
      final emptyIndex =
          normalizedStates.indexWhere((s) => s == RollBoxState.empty);
      final targetIndex =
          emptyIndex == -1 ? normalizedStates.length - 1 : emptyIndex;
      normalizedValues[targetIndex] = currentValue;
      normalizedStates[targetIndex] = RollBoxState.filled;
      updatedValues
        ..clear()
        ..addAll(normalizedValues);
      updatedStates
        ..clear()
        ..addAll(normalizedStates);
    } else {
      updatedValues.add(currentValue);
    }

    _updateActiveDraft(
      assignedAttributes: {
        ...state.assignedAttributes,
        attribute: 0,
      },
      remainingValues: updatedValues,
      boxStates: updatedStates,
    );
  }

  void moveAssignedAttribute(Attribute source, Attribute target) {
    if (source == target ||
        (state.selectionType != SelectType.defaultType &&
            state.selectionType != SelectType.random)) {
      return;
    }

    final sourceValue = state.assignedAttributes[source] ?? 0;
    if (sourceValue == 0) return;

    final targetValue = state.assignedAttributes[target] ?? 0;
    _updateActiveDraft(
      assignedAttributes: {
        ...state.assignedAttributes,
        source: targetValue,
        target: sourceValue,
      },
    );
  }

  void onAcceptAttributeDrag(
    DragTargetDetails<AttributeDragData> details,
    Attribute target,
  ) {
    final drag = details.data;
    final source = drag.sourceAttribute;
    if (source != null) {
      if ((state.assignedAttributes[source] ?? 0) != drag.value) return;
      moveAssignedAttribute(source, target);
      return;
    }

    onAcceptWithDetailes(
      DragTargetDetails<int>(data: drag.value, offset: details.offset),
      target,
    );
  }

  void onAcceptWithDetailes(
    DragTargetDetails<int> details,
    Attribute attribute,
  ) {
    final incomingValue = details.data;
    final fromIndex =
        state.remainingValues.indexWhere((v) => v == incomingValue);
    if (fromIndex == -1) return;

    final updatedValues = [...state.remainingValues];
    final updatedStates = [...state.boxStates];
    final currentValue = state.assignedAttributes[attribute];

    if (state.selectionType == SelectType.random) {
      final normalizedValues = _normalizedRandomValues(updatedValues);
      final normalizedStates = _normalizedRandomStates(
        updatedStates,
        normalizedValues,
      );
      if (currentValue != 0) {
        normalizedValues[fromIndex] = currentValue;
        normalizedStates[fromIndex] = RollBoxState.filled;
      } else {
        normalizedValues[fromIndex] = null;
        normalizedStates[fromIndex] = RollBoxState.empty;
      }
      updatedValues
        ..clear()
        ..addAll(normalizedValues);
      updatedStates
        ..clear()
        ..addAll(normalizedStates);
    } else {
      updatedValues.removeAt(fromIndex);
      if (currentValue != 0) {
        updatedValues.add(currentValue);
      }
    }

    _updateActiveDraft(
      remainingValues: updatedValues,
      boxStates: updatedStates,
      assignedAttributes: {
        ...state.assignedAttributes,
        attribute: incomingValue,
      },
    );
  }
}
