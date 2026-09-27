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
part 'attribute_state/attribute_editing_operations.dart';

enum RollBoxState { initial, rolling, filled, empty }

class AttributeDragData {
  const AttributeDragData({required this.value, this.sourceAttribute});

  final int value;
  final Attribute? sourceAttribute;
}

enum AttributeBonusMode { racial, flexiblePlusTwoOne, flexibleThreePlusOne }

@freezed
sealed class AttributeModeDraft with _$AttributeModeDraft {
  const factory AttributeModeDraft({
    @Default({}) Map<Attribute, int> assignedAttributes,
    @Default([]) List<int?> remainingValues,
    @Default([]) List<RollBoxState> boxStates,
    @Default(27) int purchacePoints,
  }) = _AttributeModeDraft;
}

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
    @Default({}) Map<String, String> optionKeyByAttribute,
    @Default({}) Map<String, String> attributeKeyByOption,
    @Default({}) Set<Attribute> defaultAttributes,
  }) = _AttributeBonusRule;
}

@freezed
sealed class AttributeStateModel with _$AttributeStateModel {
  const factory AttributeStateModel({
    @Default(SelectType.defaultType) SelectType selectionType,
    @Default({}) Map<SelectType, AttributeModeDraft> drafts,
    @Default(AttributeBonusMode.racial) AttributeBonusMode bonusMode,
    @Default({}) Map<Attribute, bool> bonusesPlusOne,
    @Default({}) Map<Attribute, bool> bonusesPlusTwo,
    @Default({}) Map<Attribute, int> fixedRaceBonuses,
    @Default([]) List<AttributeBonusRule> resolvedBonusRules,
    @Default({}) Map<String, Set<Attribute>> selectedBonusAttributesByRule,
  }) = _AttributeStateModel;
}

extension AttributeStateModelActiveDraft on AttributeStateModel {
  AttributeModeDraft get activeDraft => drafts[selectionType]!;

  Map<Attribute, int> get assignedAttributes => activeDraft.assignedAttributes;

  List<int?> get remainingValues => activeDraft.remainingValues;

  List<RollBoxState> get boxStates => activeDraft.boxStates;

  int get purchacePoints => activeDraft.purchacePoints;
}

@Riverpod(keepAlive: true)
class AttributeState extends _$AttributeState {
  static const _flexibleGroupKeyPrefix = 'race_flexible_bonus';
  static const _flexiblePlusTwoGroupKeyPrefix =
      '${_flexibleGroupKeyPrefix}_plus2_';
  static const _flexiblePlusOneGroupKeyPrefix =
      '${_flexibleGroupKeyPrefix}_plus1_';
  static const _flexibleThreePlusOneGroupKeyPrefix =
      '${_flexibleGroupKeyPrefix}_three_plus1_';
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
    final choiceGroups = ref.watch(
      characterCreationProvider.select((c) => c.raceChoiceGroups),
    );

    final fixedRaceBonuses =
        _resolveFixedRaceBonuses(race: race, subrace: subrace);
    final resolvedBonusRules = _resolveSelectableBonusRules(
      choiceGroups: choiceGroups,
      raceId: race?.id,
      subraceId: subrace?.id,
      includeFlexibleRules: useFlexibleAbilityBonuses,
    );
    final restoredBonusMode = _restoreBonusMode(
      fixedRaceBonuses: fixedRaceBonuses,
      rules: resolvedBonusRules,
      savedChoices: savedChoices,
      choiceGroups: choiceGroups,
      raceId: race?.id,
    );
    final bonusMode = previous?.bonusMode ?? restoredBonusMode;
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
    final selectionType = previous?.selectionType ?? SelectType.defaultType;
    final drafts = previous?.drafts ??
        {
          SelectType.defaultType: _initialDraft(
            SelectType.defaultType,
            assignedAttributes: _restoreAssignedAttributes(savedScores),
          ),
        };
    final activeDraft = drafts[selectionType]!;
    final normalizedActiveDraft = selectionType == SelectType.random
        ? activeDraft.copyWith(
            remainingValues:
                _normalizedRandomValues(activeDraft.remainingValues),
            boxStates: _normalizedRandomStates(
              activeDraft.boxStates,
              activeDraft.remainingValues,
            ),
          )
        : activeDraft;

    final nextState = AttributeStateModel(
      selectionType: selectionType,
      drafts: {...drafts, selectionType: normalizedActiveDraft},
      bonusMode: bonusMode,
      fixedRaceBonuses: fixedRaceBonuses,
      resolvedBonusRules: resolvedBonusRules,
      selectedBonusAttributesByRule: selectedBonusAttributesByRule,
      bonusesPlusOne: bonusesPlusOne,
      bonusesPlusTwo: bonusesPlusTwo,
    );
    _previousState = nextState;
    return nextState;
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
    required List<ChoiceGroupView> choiceGroups,
    required int? raceId,
    required int? subraceId,
    required bool includeFlexibleRules,
  }) {
    final rules = <AttributeBonusRule>[];
    for (final view in choiceGroups) {
      final group = view.group;
      if (group == null ||
          group.type != ChoiceType.abilityIncrease ||
          group.referenceKey.isEmpty) {
        continue;
      }
      if (!includeFlexibleRules &&
          group.referenceKey.startsWith(_flexibleGroupKeyPrefix)) {
        continue;
      }
      final isRaceGroup = raceId != null && group.sourceRaceId == raceId;
      final isSubraceGroup =
          subraceId != null && group.sourceSubraceId == subraceId;
      if (!isRaceGroup && !isSubraceGroup) continue;

      final optionKeysByAttribute = <String, String>{};
      final attributesByOptionKey = <String, String>{};
      final bonuses = <int, Set<Attribute>>{};
      for (final option in view.options ?? const <ChoiceOptionData>[]) {
        final optionBonuses = option.grantedAbilityBonuses;
        if (optionBonuses == null) continue;
        for (final effect in optionBonuses.entries) {
          final ability =
              Ability.values.where((item) => item.name == effect.key);
          if (ability.isEmpty || effect.value == 0) continue;
          final attribute = _attributeFromAbility(ability.single);
          if (attribute == null) continue;
          bonuses.putIfAbsent(effect.value, () => <Attribute>{}).add(attribute);
          optionKeysByAttribute[attribute.name] = option.optionKey;
          attributesByOptionKey[option.optionKey] = attribute.name;
        }
      }
      if (bonuses.length != 1) continue;
      final bonus = bonuses.entries.single;
      final pickCount = group.selectionCount ?? 0;
      if (pickCount <= 0 || bonus.value.isEmpty) continue;

      rules.add(
        AttributeBonusRule(
          groupKey: group.referenceKey,
          choiceSetId: group.id ?? 0,
          sourceType:
              isRaceGroup ? ChoiceSourceType.race : ChoiceSourceType.subrace,
          sourceId: group.sourceRaceId ?? group.sourceSubraceId!,
          bonusValue: bonus.key,
          pickCount: pickCount,
          mustBeDistinct: group.allowDuplicates != true,
          allowedAttributes: bonus.value,
          optionKeyByAttribute: optionKeysByAttribute,
          attributeKeyByOption: attributesByOptionKey,
          defaultAttributes: _defaultAttributesForRule(
            allowedAttributes: bonus.value,
            pickCount: pickCount,
          ),
        ),
      );
    }
    return rules;
  }

  AttributeBonusMode _restoreBonusMode({
    required Map<Attribute, int> fixedRaceBonuses,
    required List<AttributeBonusRule> rules,
    required List<CharacterChoiceData> savedChoices,
    required List<ChoiceGroupView> choiceGroups,
    required int? raceId,
  }) {
    for (final choice in savedChoices) {
      final group = choiceGroups
          .map((view) => view.group)
          .where((item) => item?.referenceKey == choice.groupKey)
          .firstOrNull;
      if (group == null ||
          group.sourceRaceId != raceId ||
          !group.referenceKey.endsWith('_ability_bonus_mode')) {
        continue;
      }
      final parsedMode = _bonusModeFromRaw(choice.optionKey);
      if (parsedMode != null &&
          (parsedMode == AttributeBonusMode.racial ||
              _activeRules(rules: rules, mode: parsedMode).isNotEmpty)) {
        return parsedMode;
      }
    }

    final hasFlexibleThreePlusOneChoice =
        rules.any(_isFlexibleThreePlusOneRule) &&
            savedChoices.any(
              (choice) =>
                  choice.groupKey?.startsWith(
                    _flexibleThreePlusOneGroupKeyPrefix,
                  ) ==
                  true,
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
      for (final entry in previousSelections?.entries ??
          const <MapEntry<String, Set<Attribute>>>[])
        entry.key: {...entry.value},
    };

    for (final rule in rules) {
      restored.putIfAbsent(rule.groupKey, () => <Attribute>{});
      final matchingChoices = savedChoices.where((choice) {
        return choice.groupKey == rule.groupKey;
      }).toList();

      final previousSelected = previousSelections?[rule.groupKey];
      if (previousSelected != null) {
        restored[rule.groupKey] = {...previousSelected};
        continue;
      }

      if (matchingChoices.isEmpty) {
        restored[rule.groupKey] = {...rule.defaultAttributes};
        continue;
      }

      final selected = <Attribute>{};
      for (final choice in matchingChoices) {
        final attribute = _attributeFromKey(
          rule.attributeKeyByOption[choice.optionKey] ?? choice.optionKey,
        );
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

  AttributeModeDraft _initialDraft(
    SelectType type, {
    Map<Attribute, int>? assignedAttributes,
  }) {
    final assigned = assignedAttributes ??
        (type == SelectType.purchace
            ? {for (final attribute in Attribute.values) attribute: 8}
            : {for (final attribute in Attribute.values) attribute: 0});
    final remainingValues = _initialRemainingValues(
      selectionType: type,
      assignedAttributes: assigned,
    );
    return AttributeModeDraft(
      assignedAttributes: assigned,
      remainingValues: remainingValues,
      boxStates: _initialBoxStates(
        selectionType: type,
        remainingValues: remainingValues,
      ),
      purchacePoints: 27,
    );
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

  bool _isFlexibleRule(AttributeBonusRule rule) =>
      rule.groupKey.startsWith(_flexibleGroupKeyPrefix);

  bool _isFlexiblePlusTwoOneRule(AttributeBonusRule rule) {
    return rule.groupKey.startsWith(_flexiblePlusTwoGroupKeyPrefix) ||
        rule.groupKey.startsWith(_flexiblePlusOneGroupKeyPrefix);
  }

  bool _isFlexibleThreePlusOneRule(AttributeBonusRule rule) {
    return rule.groupKey.startsWith(_flexibleThreePlusOneGroupKeyPrefix);
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
