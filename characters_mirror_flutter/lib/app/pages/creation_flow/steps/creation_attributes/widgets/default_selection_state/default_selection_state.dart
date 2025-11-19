import 'package:characters_mirror_flutter/app/pages/creation_flow/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/creation_attributes/common/attribute_enum.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/creation_attributes/state/attributes_state.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'default_selection_state.freezed.dart';
part 'default_selection_state.g.dart';

@freezed
sealed class DefaultSelectionStateModel with _$DefaultSelectionStateModel {
  factory DefaultSelectionStateModel({
    @Default({}) Map<Attribute, int> assignedAttributes,
    @Default({}) Map<Attribute, bool> bonusesPlusOne,
    @Default({}) Map<Attribute, bool> bonusesPlusTwo,
    @Default([]) List<int> remainingValues,
    @Default([]) List<Attribute> plusOneOrder,
    @Default([]) List<Attribute> plusTwoOrder,
    required Map<Attribute, int> raceAttributeBonuses,
  }) = _DefaultSelectionStateModel;
}

@riverpod
class DefaultSelectionState extends _$DefaultSelectionState {
  @override
  DefaultSelectionStateModel build() {
    return DefaultSelectionStateModel(
        raceAttributeBonuses: getRaceAttributeBonuses(),
        assignedAttributes: emptyAttriuteMap,
        bonusesPlusOne: falseAttriuteMap,
        bonusesPlusTwo: falseAttriuteMap,
        remainingValues: [15, 14, 13, 12, 10, 8]);
  }

  Map<Attribute, int> get emptyAttriuteMap {
    return {
      Attribute.strength: 0,
      Attribute.dexterity: 0,
      Attribute.constitution: 0,
      Attribute.intelligence: 0,
      Attribute.wisdom: 0,
      Attribute.charisma: 0,
    };
  }

  Map<Attribute, bool> get falseAttriuteMap {
    return {
      Attribute.strength: false,
      Attribute.dexterity: false,
      Attribute.constitution: false,
      Attribute.intelligence: false,
      Attribute.wisdom: false,
      Attribute.charisma: false,
    };
  }

  Map<Attribute, int> getRaceAttributeBonuses() {
    final race =
        ref.read(characterCreationProvider.select((c) => c.character.race));

    return race?.abilityBonuses
            ?.map((k, v) => MapEntry(Attribute.values.byName(k), v)) ??
        emptyAttriuteMap;
  }

  void toggleBonus({
    required Attribute attribute,
    required int bonusValue,
    required bool? value,
  }) {
    const maxPlusOne = 3;
    const maxPlusTwo = 1;

    final isPlusOne = bonusValue == 1;

    final plusOneCount =
        state.bonusesPlusOne.values.where((v) => v == true).length;

    final plusTwoCount =
        state.bonusesPlusTwo.values.where((v) => v == true).length;

    if (value != true) {
      if (isPlusOne) {
        state = state.copyWith(
          bonusesPlusOne: {...state.bonusesPlusOne, attribute: false},
          plusOneOrder:
              state.plusOneOrder.where((a) => a != attribute).toList(),
        );
      } else {
        state = state.copyWith(
          bonusesPlusTwo: {...state.bonusesPlusTwo, attribute: false},
          plusTwoOrder:
              state.plusTwoOrder.where((a) => a != attribute).toList(),
        );
      }

      ref
          .read(attributesStateProvider.notifier)
          .changeAttributes(mergeStatsAndBonuses());
      return;
    }

    if (!isPlusOne) {
      if (state.bonusesPlusOne[attribute] == true) return;

      if (plusTwoCount >= maxPlusTwo) {
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
      } else {
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

      if (plusOneCount > 1) {
        final toRemove = plusOneCount - 1;
        final removeList = state.plusOneOrder.take(toRemove);
        final updatedMap = {...state.bonusesPlusOne};

        for (final a in removeList) {
          updatedMap[a] = false;
        }

        state = state.copyWith(
          bonusesPlusOne: updatedMap,
          plusOneOrder: state.plusOneOrder.skip(toRemove).toList(),
        );
      }

      ref
          .read(attributesStateProvider.notifier)
          .changeAttributes(mergeStatsAndBonuses());
      return;
    }

    if (state.bonusesPlusTwo[attribute] == true) return;

    if (plusTwoCount == 1) {
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

      ref
          .read(attributesStateProvider.notifier)
          .changeAttributes(mergeStatsAndBonuses());
      return;
    }

    // Если +2 нет → обычные правила (макс 3 +1)
    if (plusOneCount >= maxPlusOne) {
      // убираем самый ранний +1
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

    ref
        .read(attributesStateProvider.notifier)
        .changeAttributes(mergeStatsAndBonuses());
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
    if (state.assignedAttributes[attribute] == 0) {
      return;
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
      remainingValues: [
        ...state.remainingValues,
        state.assignedAttributes[attribute]!
      ],
    );

    ref
        .read(attributesStateProvider.notifier)
        .changeAttributes(mergeStatsAndBonuses());
  }

  void onAcceptWithDetailes(
      DragTargetDetails<int> details, Attribute attribute) {
    final incomingValue = details.data;
    final currentValue = state.assignedAttributes[attribute];
    final updated = [...state.remainingValues];

    // Удаляем incomingValue
    updated.remove(incomingValue);

    // Если было значение в таргете — добавляем его обратно
    if (currentValue != 0) {
      updated.add(currentValue!);
    }

    state = state.copyWith(
      remainingValues: updated,
      assignedAttributes: {
        ...state.assignedAttributes,
        attribute: incomingValue,
      },
    );
    ref
        .read(attributesStateProvider.notifier)
        .changeAttributes(mergeStatsAndBonuses());
  }
}
