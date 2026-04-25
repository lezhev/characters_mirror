import 'dart:math' show Random;

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/attribute_enum.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/selection_type.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'attribute_state.freezed.dart';
part 'attribute_state.g.dart';

enum RollBoxState { initial, rolling, filled, empty }

enum AttributeBonusMode { racial, flexiblePlusTwoOne, flexibleThreePlusOne }

@freezed
sealed class AttributeBonusRule with _$AttributeBonusRule {
  const factory AttributeBonusRule({
    required String groupKey,
    required int choiceSetId,
    required ChoiceSourceType sourceType,
    required int sourceId,
    required int bonusValue,
    required int pickCount,
    required bool mustBeDistinct,
    required Set<Attribute> allowedAttributes,
    @Default({}) Set<Attribute> defaultAttributes,
  }) = _AttributeBonusRule;
}

@freezed
sealed class AttributeStateModel with _$AttributeStateModel {
  factory AttributeStateModel({
    @Default(SelectType.defaultType) SelectType selectionType,
    @Default(AttributeBonusMode.racial) AttributeBonusMode bonusMode,
    @Default({}) Map<Attribute, int> assignedAttributes,
    @Default({}) Map<Attribute, bool> bonusesPlusOne,
    @Default({}) Map<Attribute, bool> bonusesPlusTwo,
    @Default([]) List<int?> remainingValues,
    @Default([]) List<RollBoxState> boxStates,
    @Default(27) int purchacePoints,
    @Default({}) Map<Attribute, int> fixedRaceBonuses,
    @Default([]) List<AttributeBonusRule> resolvedBonusRules,
    @Default({}) Map<String, Set<Attribute>> selectedBonusAttributesByRule,
  }) = _AttributeStateModel;
}

@Riverpod(keepAlive: true)
class AttributeState extends _$AttributeState {
  static const _flexibleGroupKeyPrefix = 'race_flexible_bonus';
  static const _flexiblePlusTwoGroupKey = '${_flexibleGroupKeyPrefix}_plus2';
  static const _flexiblePlusOneGroupKey = '${_flexibleGroupKeyPrefix}_plus1';
  static const _flexibleThreePlusOneGroupKey =
      '${_flexibleGroupKeyPrefix}_three_plus1';
  static const bonusModeGroupKey = 'race_bonus_mode';
  AttributeStateModel? _previousState;
  int? _draftRevision;
  bool _isListeningToSelf = false;

  @override
  AttributeStateModel build() {
    if (!_isListeningToSelf) {
      listenSelf((_, next) {
        _previousState = next;
      });
      _isListeningToSelf = true;
    }

    final draftRevision = ref.watch(
      characterCreationProvider.select((c) => c.draftRevision),
    );
    final previous = _draftRevision == draftRevision ? _previousState : null;
    _draftRevision = draftRevision;
    final race =
        ref.watch(characterCreationProvider.select((c) => c.character.race));
    final subrace =
        ref.watch(characterCreationProvider.select((c) => c.character.subrace));
    final useFlexibleAbilityBonuses = ref.watch(
      characterCreationProvider.select(
        (c) => c.character.useFlexibleAbilityBonuses ?? false,
      ),
    );
    final savedChoices = ref.watch(
            characterCreationProvider.select((c) => c.character.choices)) ??
        const <CharacterChoiceData>[];
    final savedScores = ref.watch(
          characterCreationProvider.select(
            (c) => c.character.baseAbilityScores,
          ),
        ) ??
        const <String, int>{};

    final fixedRaceBonuses =
        _resolveFixedRaceBonuses(race: race, subrace: subrace);
    final resolvedBonusRules = _resolveSelectableBonusRules(
      race: race,
      subrace: subrace,
      includeFlexibleRules: useFlexibleAbilityBonuses,
    );
    final restoredBonusMode = _restoreBonusMode(
      fixedRaceBonuses: fixedRaceBonuses,
      rules: resolvedBonusRules,
      savedChoices: savedChoices,
    );
    final bonusMode = previous != null &&
            _isBonusModeAvailable(
              previous.bonusMode,
              fixedRaceBonuses: fixedRaceBonuses,
              rules: resolvedBonusRules,
            )
        ? previous.bonusMode
        : restoredBonusMode;
    final selectedBonusAttributesByRule = _restoreSelectedBonusAttributes(
      rules: resolvedBonusRules,
      savedChoices: savedChoices,
      previousSelections: previous?.selectedBonusAttributesByRule,
    );
    final activeFixedRaceBonuses = _activeFixedRaceBonuses(
      mode: bonusMode,
      fixedRaceBonuses: fixedRaceBonuses,
    );
    final (bonusesPlusOne, bonusesPlusTwo) = _buildBonusMaps(
      fixedRaceBonuses: activeFixedRaceBonuses,
      selectedByRule: selectedBonusAttributesByRule,
      rules: _activeRules(
        rules: resolvedBonusRules,
        mode: bonusMode,
      ),
    );
    final restoredAttributes = _restoreAssignedAttributes(savedScores);
    final assignedAttributes =
        previous?.assignedAttributes ?? restoredAttributes;
    final selectionType = previous?.selectionType ?? SelectType.defaultType;
    final remainingValues = previous?.remainingValues ??
        _initialRemainingValues(
          selectionType: selectionType,
          assignedAttributes: assignedAttributes,
        );
    final boxStates = previous?.boxStates ??
        _initialBoxStates(
          selectionType: selectionType,
          remainingValues: remainingValues,
        );

    final nextState = AttributeStateModel(
      selectionType: selectionType,
      bonusMode: bonusMode,
      fixedRaceBonuses: fixedRaceBonuses,
      resolvedBonusRules: resolvedBonusRules,
      selectedBonusAttributesByRule: selectedBonusAttributesByRule,
      bonusesPlusOne: bonusesPlusOne,
      bonusesPlusTwo: bonusesPlusTwo,
      assignedAttributes: assignedAttributes,
      remainingValues: selectionType == SelectType.random
          ? _normalizedRandomValues(remainingValues)
          : remainingValues,
      boxStates: selectionType == SelectType.random
          ? _normalizedRandomStates(boxStates, remainingValues)
          : boxStates,
      purchacePoints: previous?.purchacePoints ?? 27,
    );
    _previousState = nextState;
    return nextState;
  }

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
          groupKey: bonusModeGroupKey,
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

  Map<Attribute, int> _resolveFixedRaceBonuses({
    RaceData? race,
    SubraceData? subrace,
  }) {
    final resolved = <Attribute, int>{};

    void addBonus(Attribute attribute, int? bonusValue) {
      if (bonusValue == null || bonusValue == 0) return;
      resolved[attribute] = (resolved[attribute] ?? 0) + bonusValue;
    }

    addBonus(Attribute.strength, race?.strengthBonus);
    addBonus(Attribute.dexterity, race?.dexterityBonus);
    addBonus(Attribute.constitution, race?.constitutionBonus);
    addBonus(Attribute.intelligence, race?.intelligenceBonus);
    addBonus(Attribute.wisdom, race?.wisdomBonus);
    addBonus(Attribute.charisma, race?.charismaBonus);

    addBonus(Attribute.strength, subrace?.strengthBonus);
    addBonus(Attribute.dexterity, subrace?.dexterityBonus);
    addBonus(Attribute.constitution, subrace?.constitutionBonus);
    addBonus(Attribute.intelligence, subrace?.intelligenceBonus);
    addBonus(Attribute.wisdom, subrace?.wisdomBonus);
    addBonus(Attribute.charisma, subrace?.charismaBonus);
    return resolved;
  }

  List<AttributeBonusRule> _resolveSelectableBonusRules({
    RaceData? race,
    SubraceData? subrace,
    required bool includeFlexibleRules,
  }) {
    final rules = <AttributeBonusRule>[];

    void addRules({
      required List<RaceFeatureData>? features,
      required ChoiceSourceType sourceType,
      required int? sourceId,
    }) {
      if (sourceId == null) return;
      for (final feature in _creationFeatures(features)) {
        for (final choiceSet
            in feature.choiceSets ?? const <RaceChoiceSetData>[]) {
          if (choiceSet.kind != RaceChoiceKind.abilityBonusChoice) continue;

          final allowedAttributesByBonus = <int, Set<Attribute>>{};
          for (final option
              in choiceSet.choiceOptions ?? const <RaceChoiceOptionData>[]) {
            final attribute = _attributeFromAbility(option.ability);
            final bonusValue = option.bonusValue ?? 0;
            if (attribute == null || bonusValue == 0) {
              continue;
            }

            allowedAttributesByBonus
                .putIfAbsent(bonusValue, () => <Attribute>{})
                .add(attribute);
          }

          final choiceSetId = choiceSet.id ?? 0;
          final pickCount = choiceSet.pickCount ?? 0;
          if (choiceSetId <= 0 || pickCount <= 0) continue;

          for (final entry in allowedAttributesByBonus.entries) {
            if (entry.value.isEmpty) continue;

            rules.add(
              AttributeBonusRule(
                groupKey: _choiceSetGroupKey(
                  choiceSetId,
                  bonusValue: entry.key,
                ),
                choiceSetId: choiceSetId,
                sourceType: sourceType,
                sourceId: sourceId,
                bonusValue: entry.key,
                pickCount: pickCount,
                mustBeDistinct: choiceSet.mustBeDistinct ?? true,
                allowedAttributes: entry.value,
                defaultAttributes: _defaultAttributesForRule(
                  allowedAttributes: entry.value,
                  pickCount: pickCount,
                ),
              ),
            );
          }
        }
      }
    }

    addRules(
      features: race?.features,
      sourceType: ChoiceSourceType.race,
      sourceId: race?.id,
    );
    addRules(
      features: subrace?.features,
      sourceType: ChoiceSourceType.subrace,
      sourceId: subrace?.id,
    );
    if (includeFlexibleRules) {
      rules.addAll(
        _buildFlexibleRules(raceId: race?.id),
      );
    }
    return rules;
  }

  AttributeBonusMode _restoreBonusMode({
    required Map<Attribute, int> fixedRaceBonuses,
    required List<AttributeBonusRule> rules,
    required List<CharacterChoiceData> savedChoices,
  }) {
    for (final choice in savedChoices) {
      if (choice.groupKey != bonusModeGroupKey) continue;
      final parsedMode = _bonusModeFromRaw(choice.selectedText);
      if (parsedMode != null &&
          (parsedMode == AttributeBonusMode.racial ||
              _activeRules(rules: rules, mode: parsedMode).isNotEmpty)) {
        return parsedMode;
      }
    }

    final hasFlexibleThreePlusOneChoice =
        rules.any(_isFlexibleThreePlusOneRule) &&
            savedChoices.any(
              (choice) => choice.groupKey == _flexibleThreePlusOneGroupKey,
            );
    if (hasFlexibleThreePlusOneChoice) {
      return AttributeBonusMode.flexibleThreePlusOne;
    }

    final hasFlexibleChoice = rules.any(_isFlexiblePlusTwoOneRule) &&
        savedChoices.any(
          (choice) =>
              choice.groupKey?.startsWith(_flexibleGroupKeyPrefix) == true,
        );
    if (hasFlexibleChoice) {
      return AttributeBonusMode.flexiblePlusTwoOne;
    }

    if (fixedRaceBonuses.isNotEmpty ||
        rules.any((rule) => !_isFlexibleRule(rule))) {
      return AttributeBonusMode.racial;
    }

    return AttributeBonusMode.flexiblePlusTwoOne;
  }

  Map<String, Set<Attribute>> _restoreSelectedBonusAttributes({
    required List<AttributeBonusRule> rules,
    required List<CharacterChoiceData> savedChoices,
    Map<String, Set<Attribute>>? previousSelections,
  }) {
    final restored = <String, Set<Attribute>>{
      for (final rule in rules) rule.groupKey: <Attribute>{},
    };

    for (final rule in rules) {
      final matchingChoices = savedChoices.where((choice) {
        return choice.sourceType == rule.sourceType &&
            choice.sourceId == rule.sourceId &&
            choice.groupKey == rule.groupKey;
      }).toList();

      final previousSelected = previousSelections?[rule.groupKey];
      if (previousSelected != null) {
        restored[rule.groupKey] = previousSelected
            .where((attribute) => rule.allowedAttributes.contains(attribute))
            .take(rule.pickCount)
            .toSet();
        continue;
      }

      if (matchingChoices.isEmpty) {
        restored[rule.groupKey] = {...rule.defaultAttributes};
        continue;
      }

      final selected = <Attribute>{};
      for (final choice in matchingChoices) {
        final attribute = _attributeFromAbility(choice.selectedAbility) ??
            _attributeFromKey(choice.optionKey);
        if (attribute == null || !rule.allowedAttributes.contains(attribute)) {
          continue;
        }

        if (selected.length >= rule.pickCount) break;
        selected.add(attribute);
      }
      restored[rule.groupKey] = selected;
    }

    return restored;
  }

  bool _isBonusModeAvailable(
    AttributeBonusMode mode, {
    required Map<Attribute, int> fixedRaceBonuses,
    required List<AttributeBonusRule> rules,
  }) {
    if (mode == AttributeBonusMode.racial) {
      return fixedRaceBonuses.isNotEmpty ||
          rules.any((rule) => !_isFlexibleRule(rule));
    }
    return _activeRules(rules: rules, mode: mode).isNotEmpty;
  }

  Set<Attribute> _defaultAttributesForRule({
    required Set<Attribute> allowedAttributes,
    required int pickCount,
  }) {
    if (allowedAttributes.length <= pickCount) {
      return allowedAttributes;
    }
    return const <Attribute>{};
  }

  Map<Attribute, int> _restoreAssignedAttributes(Map<String, int> savedScores) {
    return {
      for (final attribute in Attribute.values)
        attribute: savedScores[attribute.name] ?? 0,
    };
  }

  List<int?> _initialRemainingValues({
    required SelectType selectionType,
    required Map<Attribute, int> assignedAttributes,
  }) {
    switch (selectionType) {
      case SelectType.defaultType:
        final remaining = [...defaultAttributes];
        for (final value
            in assignedAttributes.values.where((value) => value != 0)) {
          remaining.remove(value);
        }
        return remaining;
      case SelectType.random:
        return List<int?>.filled(6, null);
      case SelectType.purchace:
      case SelectType.manual:
        return const [];
    }
  }

  List<RollBoxState> _initialBoxStates({
    required SelectType selectionType,
    required List<int?> remainingValues,
  }) {
    if (selectionType != SelectType.random) {
      return selectionType == SelectType.defaultType
          ? List.filled(6, RollBoxState.initial)
          : const [];
    }
    return [
      for (final value in _normalizedRandomValues(remainingValues))
        value == null ? RollBoxState.initial : RollBoxState.filled,
    ];
  }

  List<int?> _normalizedRandomValues(List<int?> values) {
    return [
      for (var index = 0; index < 6; index++)
        index < values.length ? values[index] : null,
    ];
  }

  List<RollBoxState> _normalizedRandomStates(
    List<RollBoxState> states,
    List<int?> values,
  ) {
    final normalizedValues = _normalizedRandomValues(values);
    return [
      for (var index = 0; index < 6; index++)
        _normalizedRandomStateAt(
          index < states.length ? states[index] : null,
          normalizedValues[index],
        ),
    ];
  }

  RollBoxState _normalizedRandomStateAt(RollBoxState? state, int? value) {
    if (state == RollBoxState.rolling) {
      return RollBoxState.rolling;
    }
    if (value != null) {
      return RollBoxState.filled;
    }
    if (state == RollBoxState.empty) {
      return RollBoxState.empty;
    }
    return RollBoxState.initial;
  }

  Map<Attribute, int> _activeFixedRaceBonuses({
    required AttributeBonusMode mode,
    required Map<Attribute, int> fixedRaceBonuses,
  }) {
    return mode == AttributeBonusMode.racial
        ? fixedRaceBonuses
        : const <Attribute, int>{};
  }

  int _selectedBonusValue(Attribute attribute) {
    var total = 0;
    for (final rule in _activeRules(
      rules: state.resolvedBonusRules,
      mode: state.bonusMode,
    )) {
      final selected = state.selectedBonusAttributesByRule[rule.groupKey] ??
          const <Attribute>{};
      if (selected.contains(attribute)) {
        total += rule.bonusValue;
      }
    }
    return total;
  }

  (Map<Attribute, bool>, Map<Attribute, bool>) _buildBonusMaps({
    required Map<Attribute, int> fixedRaceBonuses,
    required Map<String, Set<Attribute>> selectedByRule,
    required List<AttributeBonusRule> rules,
  }) {
    final bonusesPlusOne = falseAttributeMap;
    final bonusesPlusTwo = falseAttributeMap;

    for (final entry in fixedRaceBonuses.entries) {
      if (entry.value == 1) {
        bonusesPlusOne[entry.key] = true;
      } else if (entry.value == 2) {
        bonusesPlusTwo[entry.key] = true;
      } else if (entry.value >= 3) {
        bonusesPlusOne[entry.key] = true;
        bonusesPlusTwo[entry.key] = true;
      }
    }

    for (final rule in rules) {
      final selected = selectedByRule[rule.groupKey] ?? const <Attribute>{};
      for (final attribute in selected) {
        if (rule.bonusValue == 1) {
          bonusesPlusOne[attribute] = true;
        } else if (rule.bonusValue == 2) {
          bonusesPlusTwo[attribute] = true;
        }
      }
    }

    return (bonusesPlusOne, bonusesPlusTwo);
  }

  List<AttributeBonusRule> _buildFlexibleRules({
    required int? raceId,
  }) {
    final sourceId = raceId ?? 0;

    return [
      AttributeBonusRule(
        groupKey: _flexiblePlusTwoGroupKey,
        choiceSetId: -2,
        sourceType: ChoiceSourceType.race,
        sourceId: sourceId,
        bonusValue: 2,
        pickCount: 1,
        mustBeDistinct: true,
        allowedAttributes: Attribute.values.toSet(),
      ),
      AttributeBonusRule(
        groupKey: _flexiblePlusOneGroupKey,
        choiceSetId: -1,
        sourceType: ChoiceSourceType.race,
        sourceId: sourceId,
        bonusValue: 1,
        pickCount: 1,
        mustBeDistinct: true,
        allowedAttributes: Attribute.values.toSet(),
      ),
      AttributeBonusRule(
        groupKey: _flexibleThreePlusOneGroupKey,
        choiceSetId: -3,
        sourceType: ChoiceSourceType.race,
        sourceId: sourceId,
        bonusValue: 1,
        pickCount: 3,
        mustBeDistinct: true,
        allowedAttributes: Attribute.values.toSet(),
      ),
    ];
  }

  Map<String, Set<Attribute>> _cloneSelections(
    Map<String, Set<Attribute>> source,
  ) {
    return {
      for (final entry in source.entries) entry.key: {...entry.value},
    };
  }

  void _applySelectableBonusState(Map<String, Set<Attribute>> selections) {
    final normalized = {
      for (final rule in state.resolvedBonusRules)
        rule.groupKey: {...?selections[rule.groupKey]},
    };
    final (bonusesPlusOne, bonusesPlusTwo) = _buildBonusMaps(
      fixedRaceBonuses: _activeFixedRaceBonuses(
        mode: state.bonusMode,
        fixedRaceBonuses: state.fixedRaceBonuses,
      ),
      selectedByRule: normalized,
      rules:
          _activeRules(rules: state.resolvedBonusRules, mode: state.bonusMode),
    );

    state = state.copyWith(
      selectedBonusAttributesByRule: normalized,
      bonusesPlusOne: bonusesPlusOne,
      bonusesPlusTwo: bonusesPlusTwo,
    );
  }

  void _removeSelectedBonus(Attribute attribute, int bonusValue) {
    final updatedSelections =
        _cloneSelections(state.selectedBonusAttributesByRule);

    for (final rule in _activeRules(
      rules: state.resolvedBonusRules,
      mode: state.bonusMode,
    ).where((rule) => rule.bonusValue == bonusValue)) {
      final current = updatedSelections[rule.groupKey];
      if (current == null || !current.contains(attribute)) {
        continue;
      }

      current.remove(attribute);
      updatedSelections[rule.groupKey] = current;
      _applySelectableBonusState(updatedSelections);
      return;
    }
  }

  bool _isAttributeSelectedForBonus(Attribute attribute, int bonusValue) {
    final selectedMap =
        bonusValue == 2 ? state.bonusesPlusTwo : state.bonusesPlusOne;
    return selectedMap[attribute] == true;
  }

  int _oppositeBonusValue(int bonusValue) => bonusValue == 2 ? 1 : 2;

  String _choiceSetGroupKey(int choiceSetId, {required int bonusValue}) =>
      'race_choice_${choiceSetId}_bonus_$bonusValue';

  bool _isFlexibleRule(AttributeBonusRule rule) =>
      rule.groupKey.startsWith(_flexibleGroupKeyPrefix);

  bool _isFlexiblePlusTwoOneRule(AttributeBonusRule rule) {
    return rule.groupKey == _flexiblePlusTwoGroupKey ||
        rule.groupKey == _flexiblePlusOneGroupKey;
  }

  bool _isFlexibleThreePlusOneRule(AttributeBonusRule rule) {
    return rule.groupKey == _flexibleThreePlusOneGroupKey;
  }

  List<AttributeBonusRule> _activeRules({
    required List<AttributeBonusRule> rules,
    required AttributeBonusMode mode,
  }) {
    return rules.where((rule) {
      switch (mode) {
        case AttributeBonusMode.racial:
          return !_isFlexibleRule(rule);
        case AttributeBonusMode.flexiblePlusTwoOne:
          return _isFlexiblePlusTwoOneRule(rule);
        case AttributeBonusMode.flexibleThreePlusOne:
          return _isFlexibleThreePlusOneRule(rule);
      }
    }).toList();
  }

  Attribute? _attributeFromKey(String? raw) {
    switch (raw?.trim()) {
      case 'strength':
        return Attribute.strength;
      case 'dexterity':
        return Attribute.dexterity;
      case 'constitution':
        return Attribute.constitution;
      case 'intelligence':
        return Attribute.intelligence;
      case 'wisdom':
        return Attribute.wisdom;
      case 'charisma':
        return Attribute.charisma;
      default:
        return null;
    }
  }

  Attribute? _attributeFromAbility(Ability? ability) {
    switch (ability) {
      case Ability.strength:
        return Attribute.strength;
      case Ability.dexterity:
        return Attribute.dexterity;
      case Ability.constitution:
        return Attribute.constitution;
      case Ability.intelligence:
        return Attribute.intelligence;
      case Ability.wisdom:
        return Attribute.wisdom;
      case Ability.charisma:
        return Attribute.charisma;
      case null:
        return null;
    }
  }

  Ability? _abilityFromAttribute(Attribute attribute) {
    switch (attribute) {
      case Attribute.strength:
        return Ability.strength;
      case Attribute.dexterity:
        return Ability.dexterity;
      case Attribute.constitution:
        return Ability.constitution;
      case Attribute.intelligence:
        return Ability.intelligence;
      case Attribute.wisdom:
        return Ability.wisdom;
      case Attribute.charisma:
        return Ability.charisma;
    }
  }

  List<RaceFeatureData> _creationFeatures(List<RaceFeatureData>? features) {
    return (features ?? const <RaceFeatureData>[])
        .where((feature) => (feature.level ?? 1) <= 1)
        .toList();
  }

  AttributeBonusMode? _bonusModeFromRaw(String? raw) {
    if (raw == null) return null;

    for (final mode in AttributeBonusMode.values) {
      if (mode.name == raw) {
        return mode;
      }
    }

    return null;
  }
}
