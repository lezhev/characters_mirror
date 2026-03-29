import 'dart:math' show Random;

import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/attribute_enum.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/selection_type.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'attribute_state.freezed.dart';
part 'attribute_state.g.dart';

enum RollBoxState { initial, rolling, filled, empty }

@freezed
sealed class AttributeStateModel with _$AttributeStateModel {
  factory AttributeStateModel({
    @Default(SelectType.defaultType) SelectType selectionType,
    @Default({}) Map<Attribute, int> assignedAttributes,
    @Default({}) Map<Attribute, bool> bonusesPlusOne,
    @Default({}) Map<Attribute, bool> bonusesPlusTwo,
    @Default([]) List<Attribute> plusOneOrder,
    @Default([]) List<Attribute> plusTwoOrder,
    @Default([]) List<int?> remainingValues,
    @Default([]) List<RollBoxState> boxStates,
    @Default(27) int purchacePoints,
    required Map<Attribute, int> raceAttributeBonuses,
  }) = _AttributeStateModel;
}

@riverpod
class AttributeState extends _$AttributeState {
  @override
  AttributeStateModel build() {
    return AttributeStateModel(
      raceAttributeBonuses: getRaceAttributeBonuses(),
      assignedAttributes: emptyAttributeMap,
      bonusesPlusOne: falseAttributeMap,
      bonusesPlusTwo: falseAttributeMap,
      remainingValues: defaultAttributes,
      boxStates: List.filled(6, RollBoxState.initial),
    );
  }

  List<int?> get defaultAttributes {
    return [15, 14, 13, 12, 10, 8];
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
        );
      case SelectType.purchace:
        state = state.copyWith(
          selectionType: type,
          assignedAttributes: {for (var attr in Attribute.values) attr: 8},
          purchacePoints: 27,
        );
      case SelectType.manual:
        state = state.copyWith(
          selectionType: type,
          assignedAttributes: emptyAttributeMap,
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

  Map<Attribute, int> get emptyAttributeMap =>
      {for (var attr in Attribute.values) attr: 0};

  Map<Attribute, bool> get falseAttributeMap =>
      {for (var attr in Attribute.values) attr: false};

  void changeAttributeBy(Attribute attribute, int delta) {
    if (state.selectionType != SelectType.purchace) return;

    final currentValue = state.assignedAttributes[attribute] ?? 8;
    final newValue = currentValue + delta;

    // Новый диапазон
    if (newValue < 3 || newValue > 18) return;

    final cost = _calculateCost(newValue) - _calculateCost(currentValue);

    // Проверка достаточности очков
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

  Map<Attribute, int> getRaceAttributeBonuses() {
    final race =
        ref.read(characterCreationProvider.select((c) => c.character.race));
    final subrace =
        ref.read(characterCreationProvider.select((c) => c.character.subrace));

    final bonuses = {
      ...(race?.abilityBonuses ?? {}),
      ...(subrace?.abilityBonuses ?? {}),
    };
    final parsed = <Attribute, int>{};

    for (final entry in bonuses.entries) {
      final attribute = _attributeFromKey(entry.key);
      if (attribute == null) {
        debugPrint(
          'Skipping unsupported racial ability bonus key: ${entry.key}',
        );
        continue;
      }
      parsed[attribute] = entry.value;
    }

    return parsed;
  }

  void rollValueAt(int index) async {
    state = state.copyWith(
      boxStates: List<RollBoxState>.from(state.boxStates)
        ..[index] = RollBoxState.rolling,
    );

    await Future.delayed(const Duration(milliseconds: 500));

    final value = _rollDice();

    state = state.copyWith(
      remainingValues: List<int?>.from(state.remainingValues)..[index] = value,
      boxStates: List<RollBoxState>.from(state.boxStates)
        ..[index] = RollBoxState.filled,
    );
  }

  int _rollDice() {
    final rng = Random();
    final rolls = List.generate(4, (_) => rng.nextInt(6) + 1);
    rolls.sort();
    return rolls.sublist(1).reduce((a, b) => a + b);
  }

  void toggleBonus(
      {required Attribute attribute,
      required int bonusValue,
      required bool? value}) {
    final isPlusOne = bonusValue == 1;

    if (value != true) {
      _removeBonus(attribute, isPlusOne);
      return;
    }

    if (isPlusOne) {
      _addPlusOne(attribute);
    } else {
      _addPlusTwo(attribute);
    }
  }

  Map<Attribute, int> mergeStatsAndBonuses() {
    return state.assignedAttributes.map(
      (key, value) => MapEntry(
        key,
        value +
            (state.bonusesPlusTwo[key] == true ? 2 : 0) +
            (state.bonusesPlusOne[key] == true ? 1 : 0),
      ),
    );
  }

  void unselectAttribute(Attribute attribute) {
    final currentValue = state.assignedAttributes[attribute];
    if (currentValue == 0) return;

    final updatedValues = [...state.remainingValues];
    final updatedStates = [...state.boxStates];

    // Для random-режима возвращаем кубик в filled с тем же значением
    final isRandom = state.selectionType == SelectType.random;
    if (isRandom) {
      // Найти индекс кубика, который нужно вернуть
      final emptyIndex =
          updatedStates.indexWhere((s) => s == RollBoxState.empty);
      if (emptyIndex != -1) {
        updatedValues[emptyIndex] = currentValue;
        updatedStates[emptyIndex] = RollBoxState.filled;
      } else {
        // Если нет пустого слота — добавляем в конец
        updatedValues.add(currentValue);
        updatedStates.add(RollBoxState.filled);
      }
    } else {
      // Для default-режима возвращаем само значение
      updatedValues.add(currentValue);
      // boxStates остаются filled
    }

    state = state.copyWith(
      assignedAttributes: {
        ...state.assignedAttributes,
        attribute: 0,
      },
      bonusesPlusOne: {
        ...state.bonusesPlusOne,
        attribute: false,
      },
      bonusesPlusTwo: {
        ...state.bonusesPlusTwo,
        attribute: false,
      },
      remainingValues: updatedValues,
      boxStates: updatedStates,
    );
  }

  void onAcceptWithDetailes(
      DragTargetDetails<int> details, Attribute attribute) {
    final incomingValue = details.data;
    final fromIndex =
        state.remainingValues.indexWhere((v) => v == incomingValue);
    if (fromIndex == -1) return;

    final updatedValues = [...state.remainingValues];
    final updatedStates = [...state.boxStates];

    if (state.selectionType == SelectType.random) {
      updatedValues[fromIndex] = null;
      updatedStates[fromIndex] = RollBoxState.empty;
    } else {
      // default: удаляем только из remainingValues, значение никогда не null
      updatedValues.removeAt(fromIndex);
      updatedStates.removeAt(fromIndex);
    }

    final currentValue = state.assignedAttributes[attribute];
    if (currentValue != 0) {
      updatedValues.add(currentValue);
      updatedStates.add(RollBoxState.filled);
    }

    state = state.copyWith(
      remainingValues: updatedValues,
      boxStates: updatedStates,
      assignedAttributes: {
        ...state.assignedAttributes,
        attribute: incomingValue
      },
    );
  }

  void _removeBonus(Attribute attribute, bool isPlusOne) {
    if (isPlusOne) {
      state = state.copyWith(
        bonusesPlusOne: {...state.bonusesPlusOne, attribute: false},
        plusOneOrder: state.plusOneOrder.where((a) => a != attribute).toList(),
      );
    } else {
      state = state.copyWith(
        bonusesPlusTwo: {...state.bonusesPlusTwo, attribute: false},
        plusTwoOrder: state.plusTwoOrder.where((a) => a != attribute).toList(),
      );
    }
  }

  void _addPlusTwo(Attribute attribute) {
    final plusOneCount =
        state.bonusesPlusOne.values.where((v) => v == true).length;
    final plusTwoCount =
        state.bonusesPlusTwo.values.where((v) => v == true).length;

    if (state.bonusesPlusOne[attribute] == true) return;

    if (plusTwoCount >= 1) {
      _replaceOldestPlusTwo(attribute);
    } else {
      _appendPlusTwo(attribute);
    }

    if (plusOneCount > 1) {
      _removeExcessPlusOnes(plusOneCount - 1);
    }
  }

  void _appendPlusTwo(Attribute attribute) {
    state = state.copyWith(
      bonusesPlusTwo: {
        ...state.bonusesPlusTwo,
        attribute: true,
      },
      plusTwoOrder: [
        ...state.plusTwoOrder,
        attribute,
      ],
    );
  }

  void _replaceOldestPlusTwo(Attribute attribute) {
    final oldest = state.plusTwoOrder.first;

    state = state.copyWith(
      bonusesPlusTwo: {
        ...state.bonusesPlusTwo,
        oldest: false,
        attribute: true,
      },
      plusTwoOrder: [
        ...state.plusTwoOrder.skip(1),
        attribute,
      ],
    );
  }

  void _removeExcessPlusOnes(int count) {
    final toRemove = state.plusOneOrder.take(count);
    final updated = {...state.bonusesPlusOne};

    for (final a in toRemove) {
      updated[a] = false;
    }

    state = state.copyWith(
      bonusesPlusOne: updated,
      plusOneOrder: state.plusOneOrder.skip(count).toList(),
    );
  }

  void _addPlusOne(Attribute attribute) {
    final plusOneCount =
        state.bonusesPlusOne.values.where((v) => v == true).length;
    final plusTwoCount =
        state.bonusesPlusTwo.values.where((v) => v == true).length;

    if (state.bonusesPlusTwo[attribute] == true) return;

    if (plusTwoCount == 1) {
      _addPlusOneWhenPlusTwoPresent(attribute);
      return;
    }

    _addPlusOneNormal(attribute, plusOneCount);
  }

  void _addPlusOneWhenPlusTwoPresent(Attribute attribute) {
    final plusOneCount =
        state.bonusesPlusOne.values.where((v) => v == true).length;

    if (plusOneCount >= 1) {
      final oldest = state.plusOneOrder.first;

      state = state.copyWith(
        bonusesPlusOne: {
          ...state.bonusesPlusOne,
          oldest: false,
          attribute: true,
        },
        plusOneOrder: [
          ...state.plusOneOrder.skip(1),
          attribute,
        ],
      );
    } else {
      state = state.copyWith(
        bonusesPlusOne: {
          ...state.bonusesPlusOne,
          attribute: true,
        },
        plusOneOrder: [
          ...state.plusOneOrder,
          attribute,
        ],
      );
    }
  }

  void _addPlusOneNormal(Attribute attribute, int plusOneCount) {
    const maxPlusOne = 3;

    if (plusOneCount >= maxPlusOne) {
      final oldest = state.plusOneOrder.first;

      state = state.copyWith(
        bonusesPlusOne: {
          ...state.bonusesPlusOne,
          oldest: false,
          attribute: true,
        },
        plusOneOrder: [
          ...state.plusOneOrder.skip(1),
          attribute,
        ],
      );
    } else {
      state = state.copyWith(
        bonusesPlusOne: {
          ...state.bonusesPlusOne,
          attribute: true,
        },
        plusOneOrder: [
          ...state.plusOneOrder,
          attribute,
        ],
      );
    }
  }

  Attribute? _attributeFromKey(String raw) {
    switch (raw.trim()) {
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
}
