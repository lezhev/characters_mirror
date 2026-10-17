import 'dart:convert';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // These indexes are already stored in character snapshots and sync queues.
  final legacyValues = <(Object, int, Object Function(int))>[
    (CharacterChangeType.delete, 1, CharacterChangeType.fromJson),
    (CharacterEntityType.character, 0, CharacterEntityType.fromJson),
    (CharacterInventoryItemType.custom, 4, CharacterInventoryItemType.fromJson),
    (CharacterSpeedKind.flying, 3, CharacterSpeedKind.fromJson),
    (
      CharacterSyncOperationType.recoverSpellSlots,
      19,
      CharacterSyncOperationType.fromJson,
    ),
    (CharacterSyncTargetType.member, 6, CharacterSyncTargetType.fromJson),
    (CreatureSize.medium, 2, CreatureSize.fromJson),
    (
      FeatureModifierConditionType.selectedChoiceOption,
      5,
      FeatureModifierConditionType.fromJson,
    ),
    (FeatureModifierOperation.setValue, 2, FeatureModifierOperation.fromJson),
    (FeatureModifierRounding.floor, 0, FeatureModifierRounding.fromJson),
    (FeatureModifierTarget.spellRange, 8, FeatureModifierTarget.fromJson),
    (FeatureModifierValueKind.castLevel, 4, FeatureModifierValueKind.fromJson),
    (ToolCategory.musicalInstrument, 1, ToolCategory.fromJson),
  ];

  for (final (value, legacyIndex, decode) in legacyValues) {
    test('${value.runtimeType} retains its legacy numeric wire value', () {
      expect(jsonEncode(value), '$legacyIndex');
      expect(decode(legacyIndex), value);
    });
  }
}
