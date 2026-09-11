// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of '../attribute_state.dart';

extension AttributeStateEditingOperations on AttributeState {
  List<int?> get defaultAttributes => [15, 14, 13, 12, 10, 8];

  Map<Attribute, int> get emptyAttributeMap =>
      {for (var attr in Attribute.values) attr: 0};

  Map<Attribute, bool> get falseAttributeMap =>
      {for (var attr in Attribute.values) attr: false};

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
    switch (type) {
      case SelectType.random:
        state = state.copyWith(
          selectionType: type,
          assignedAttributes: emptyAttributeMap,
          boxStates: List.filled(6, RollBoxState.initial),
          remainingValues: List.filled(6, null),
        );
      case SelectType.defaultType:
        state = state.copyWith(
          selectionType: type,
          assignedAttributes: emptyAttributeMap,
          remainingValues: defaultAttributes,
          boxStates: List.filled(6, RollBoxState.initial),
        );
      case SelectType.purchace:
        state = state.copyWith(
          selectionType: type,
          assignedAttributes: {for (var attr in Attribute.values) attr: 8},
          purchacePoints: 27,
          remainingValues: const [],
          boxStates: const [],
        );
      case SelectType.manual:
        state = state.copyWith(
          selectionType: type,
          assignedAttributes: emptyAttributeMap,
          remainingValues: const [],
          boxStates: const [],
        );
    }
  }

  void updateManualAttribute(Attribute attribute, int value) {
    if (state.selectionType != SelectType.manual) return;

    state = state.copyWith(
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

    state = state.copyWith(
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
    if (state.selectionType != SelectType.random ||
        index < 0 ||
        index >= 6 ||
        index >= state.remainingValues.length ||
        index >= state.boxStates.length) {
      return;
    }

    state = state.copyWith(
      remainingValues: _normalizedRandomValues(state.remainingValues),
      boxStates: _normalizedRandomStates(
        state.boxStates,
        state.remainingValues,
      )..[index] = RollBoxState.rolling,
    );

    await Future.delayed(const Duration(milliseconds: 500));

    final value = _rollDice();
    if (state.selectionType != SelectType.random ||
        index < 0 ||
        index >= 6 ||
        index >= state.remainingValues.length ||
        index >= state.boxStates.length) {
      return;
    }

    state = state.copyWith(
      remainingValues: _normalizedRandomValues(state.remainingValues)
        ..[index] = value,
      boxStates: _normalizedRandomStates(
        state.boxStates,
        state.remainingValues,
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
    final raceId =
        ref.read(characterCreationProvider.select((c) => c.character.race?.id));
    final hasFlexibleModes =
        state.resolvedBonusRules.any((rule) => _isFlexibleRule(rule));

    if (raceId != null && hasFlexibleModes) {
      result.add(
        CharacterChoiceData(
          sourceType: ChoiceSourceType.race,
          sourceId: raceId,
          groupKey: AttributeState.bonusModeGroupKey,
          selectedText: state.bonusMode.name,
        ),
      );
    }

    for (final rule in _activeRules(
      rules: state.resolvedBonusRules,
      mode: state.bonusMode,
    )) {
      if (rule.sourceId <= 0) continue;

      final attributes = state.selectedBonusAttributesByRule[rule.groupKey] ??
          const <Attribute>{};

      for (final attribute in attributes) {
        result.add(
          CharacterChoiceData(
            sourceType: rule.sourceType,
            sourceId: rule.sourceId,
            groupKey: rule.groupKey,
            selectionIndex: result.length,
            optionKey: attribute.name,
            selectedAbility: _abilityFromAttribute(attribute),
            selectedCount: rule.bonusValue,
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

    state = state.copyWith(
      assignedAttributes: {
        ...state.assignedAttributes,
        attribute: 0,
      },
      remainingValues: updatedValues,
      boxStates: updatedStates,
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

    state = state.copyWith(
      remainingValues: updatedValues,
      boxStates: updatedStates,
      assignedAttributes: {
        ...state.assignedAttributes,
        attribute: incomingValue,
      },
    );
  }
}
