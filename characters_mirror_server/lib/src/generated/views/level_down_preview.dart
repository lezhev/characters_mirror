/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
import '../data/general/character/character_choice_data.dart' as _ic1a1q8y;
import '../data/general/character/character_data.dart' as _iokyyhkm;
import '../data/general/choice_group_data.dart' as _igmk6n2e;
import '../data/general/class/class_feature_data.dart' as _ikfzlvib;
import '../data/general/class/subclass_feature_data.dart' as _itaxdcfb;
import '../views/level_down_invalid_choice_view.dart' as _i77exzmx;

abstract class LevelDownPreview
    implements _is.SerializableModel, _is.ProtocolSerialization {
  LevelDownPreview._({
    required this.before,
    required this.character,
    required this.classEntryId,
    required this.oldLevel,
    required this.targetLevel,
    required this.removedClassFeatures,
    required this.removedSubclassFeatures,
    required this.removedChoiceGroups,
    required this.removedChoices,
    required this.invalidChoices,
    this.oldMaxHp,
    this.newMaxHp,
    this.oldProficiencyBonus,
    this.newProficiencyBonus,
    required this.oldResourceMaxima,
    required this.newResourceMaxima,
    required this.oldSpellSlots,
    required this.newSpellSlots,
    required this.oldPactSlots,
    required this.newPactSlots,
    required this.missingDecisions,
  });

  factory LevelDownPreview({
    required _iokyyhkm.CharacterData before,
    required _iokyyhkm.CharacterData character,
    required String classEntryId,
    required int oldLevel,
    required int targetLevel,
    required List<_ikfzlvib.ClassFeatureData> removedClassFeatures,
    required List<_itaxdcfb.SubclassFeatureData> removedSubclassFeatures,
    required List<_igmk6n2e.ChoiceGroupData> removedChoiceGroups,
    required List<_ic1a1q8y.CharacterChoiceData> removedChoices,
    required List<_i77exzmx.LevelDownInvalidChoiceView> invalidChoices,
    int? oldMaxHp,
    int? newMaxHp,
    int? oldProficiencyBonus,
    int? newProficiencyBonus,
    required Map<String, int> oldResourceMaxima,
    required Map<String, int> newResourceMaxima,
    required Map<int, int> oldSpellSlots,
    required Map<int, int> newSpellSlots,
    required Map<int, int> oldPactSlots,
    required Map<int, int> newPactSlots,
    required List<String> missingDecisions,
  }) = _LevelDownPreviewImpl;

  factory LevelDownPreview.fromJson(Map<String, dynamic> jsonSerialization) {
    return LevelDownPreview(
      before: _ikmnmw29.Protocol().deserialize<_iokyyhkm.CharacterData>(
        jsonSerialization['before'],
      ),
      character: _ikmnmw29.Protocol().deserialize<_iokyyhkm.CharacterData>(
        jsonSerialization['character'],
      ),
      classEntryId: jsonSerialization['classEntryId'] as String,
      oldLevel: jsonSerialization['oldLevel'] as int,
      targetLevel: jsonSerialization['targetLevel'] as int,
      removedClassFeatures: _ikmnmw29.Protocol()
          .deserialize<List<_ikfzlvib.ClassFeatureData>>(
            jsonSerialization['removedClassFeatures'],
          ),
      removedSubclassFeatures: _ikmnmw29.Protocol()
          .deserialize<List<_itaxdcfb.SubclassFeatureData>>(
            jsonSerialization['removedSubclassFeatures'],
          ),
      removedChoiceGroups: _ikmnmw29.Protocol()
          .deserialize<List<_igmk6n2e.ChoiceGroupData>>(
            jsonSerialization['removedChoiceGroups'],
          ),
      removedChoices: _ikmnmw29.Protocol()
          .deserialize<List<_ic1a1q8y.CharacterChoiceData>>(
            jsonSerialization['removedChoices'],
          ),
      invalidChoices: _ikmnmw29.Protocol()
          .deserialize<List<_i77exzmx.LevelDownInvalidChoiceView>>(
            jsonSerialization['invalidChoices'],
          ),
      oldMaxHp: jsonSerialization['oldMaxHp'] as int?,
      newMaxHp: jsonSerialization['newMaxHp'] as int?,
      oldProficiencyBonus: jsonSerialization['oldProficiencyBonus'] as int?,
      newProficiencyBonus: jsonSerialization['newProficiencyBonus'] as int?,
      oldResourceMaxima: _ikmnmw29.Protocol().deserialize<Map<String, int>>(
        jsonSerialization['oldResourceMaxima'],
      ),
      newResourceMaxima: _ikmnmw29.Protocol().deserialize<Map<String, int>>(
        jsonSerialization['newResourceMaxima'],
      ),
      oldSpellSlots: _ikmnmw29.Protocol().deserialize<Map<int, int>>(
        jsonSerialization['oldSpellSlots'],
      ),
      newSpellSlots: _ikmnmw29.Protocol().deserialize<Map<int, int>>(
        jsonSerialization['newSpellSlots'],
      ),
      oldPactSlots: _ikmnmw29.Protocol().deserialize<Map<int, int>>(
        jsonSerialization['oldPactSlots'],
      ),
      newPactSlots: _ikmnmw29.Protocol().deserialize<Map<int, int>>(
        jsonSerialization['newPactSlots'],
      ),
      missingDecisions: _ikmnmw29.Protocol().deserialize<List<String>>(
        jsonSerialization['missingDecisions'],
      ),
    );
  }

  _iokyyhkm.CharacterData before;

  _iokyyhkm.CharacterData character;

  String classEntryId;

  int oldLevel;

  int targetLevel;

  List<_ikfzlvib.ClassFeatureData> removedClassFeatures;

  List<_itaxdcfb.SubclassFeatureData> removedSubclassFeatures;

  List<_igmk6n2e.ChoiceGroupData> removedChoiceGroups;

  List<_ic1a1q8y.CharacterChoiceData> removedChoices;

  List<_i77exzmx.LevelDownInvalidChoiceView> invalidChoices;

  int? oldMaxHp;

  int? newMaxHp;

  int? oldProficiencyBonus;

  int? newProficiencyBonus;

  Map<String, int> oldResourceMaxima;

  Map<String, int> newResourceMaxima;

  Map<int, int> oldSpellSlots;

  Map<int, int> newSpellSlots;

  Map<int, int> oldPactSlots;

  Map<int, int> newPactSlots;

  List<String> missingDecisions;

  /// Returns a shallow copy of this [LevelDownPreview]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LevelDownPreview copyWith({
    _iokyyhkm.CharacterData? before,
    _iokyyhkm.CharacterData? character,
    String? classEntryId,
    int? oldLevel,
    int? targetLevel,
    List<_ikfzlvib.ClassFeatureData>? removedClassFeatures,
    List<_itaxdcfb.SubclassFeatureData>? removedSubclassFeatures,
    List<_igmk6n2e.ChoiceGroupData>? removedChoiceGroups,
    List<_ic1a1q8y.CharacterChoiceData>? removedChoices,
    List<_i77exzmx.LevelDownInvalidChoiceView>? invalidChoices,
    int? oldMaxHp,
    int? newMaxHp,
    int? oldProficiencyBonus,
    int? newProficiencyBonus,
    Map<String, int>? oldResourceMaxima,
    Map<String, int>? newResourceMaxima,
    Map<int, int>? oldSpellSlots,
    Map<int, int>? newSpellSlots,
    Map<int, int>? oldPactSlots,
    Map<int, int>? newPactSlots,
    List<String>? missingDecisions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LevelDownPreview',
      'before': before.toJson(),
      'character': character.toJson(),
      'classEntryId': classEntryId,
      'oldLevel': oldLevel,
      'targetLevel': targetLevel,
      'removedClassFeatures': removedClassFeatures.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'removedSubclassFeatures': removedSubclassFeatures.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'removedChoiceGroups': removedChoiceGroups.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'removedChoices': removedChoices.toJson(valueToJson: (v) => v.toJson()),
      'invalidChoices': invalidChoices.toJson(valueToJson: (v) => v.toJson()),
      if (oldMaxHp != null) 'oldMaxHp': oldMaxHp,
      if (newMaxHp != null) 'newMaxHp': newMaxHp,
      if (oldProficiencyBonus != null)
        'oldProficiencyBonus': oldProficiencyBonus,
      if (newProficiencyBonus != null)
        'newProficiencyBonus': newProficiencyBonus,
      'oldResourceMaxima': oldResourceMaxima.toJson(),
      'newResourceMaxima': newResourceMaxima.toJson(),
      'oldSpellSlots': oldSpellSlots.toJson(),
      'newSpellSlots': newSpellSlots.toJson(),
      'oldPactSlots': oldPactSlots.toJson(),
      'newPactSlots': newPactSlots.toJson(),
      'missingDecisions': missingDecisions.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LevelDownPreview',
      'before': before.toJsonForProtocol(),
      'character': character.toJsonForProtocol(),
      'classEntryId': classEntryId,
      'oldLevel': oldLevel,
      'targetLevel': targetLevel,
      'removedClassFeatures': removedClassFeatures.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'removedSubclassFeatures': removedSubclassFeatures.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'removedChoiceGroups': removedChoiceGroups.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'removedChoices': removedChoices.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'invalidChoices': invalidChoices.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      if (oldMaxHp != null) 'oldMaxHp': oldMaxHp,
      if (newMaxHp != null) 'newMaxHp': newMaxHp,
      if (oldProficiencyBonus != null)
        'oldProficiencyBonus': oldProficiencyBonus,
      if (newProficiencyBonus != null)
        'newProficiencyBonus': newProficiencyBonus,
      'oldResourceMaxima': oldResourceMaxima.toJson(),
      'newResourceMaxima': newResourceMaxima.toJson(),
      'oldSpellSlots': oldSpellSlots.toJson(),
      'newSpellSlots': newSpellSlots.toJson(),
      'oldPactSlots': oldPactSlots.toJson(),
      'newPactSlots': newPactSlots.toJson(),
      'missingDecisions': missingDecisions.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LevelDownPreviewImpl extends LevelDownPreview {
  _LevelDownPreviewImpl({
    required _iokyyhkm.CharacterData before,
    required _iokyyhkm.CharacterData character,
    required String classEntryId,
    required int oldLevel,
    required int targetLevel,
    required List<_ikfzlvib.ClassFeatureData> removedClassFeatures,
    required List<_itaxdcfb.SubclassFeatureData> removedSubclassFeatures,
    required List<_igmk6n2e.ChoiceGroupData> removedChoiceGroups,
    required List<_ic1a1q8y.CharacterChoiceData> removedChoices,
    required List<_i77exzmx.LevelDownInvalidChoiceView> invalidChoices,
    int? oldMaxHp,
    int? newMaxHp,
    int? oldProficiencyBonus,
    int? newProficiencyBonus,
    required Map<String, int> oldResourceMaxima,
    required Map<String, int> newResourceMaxima,
    required Map<int, int> oldSpellSlots,
    required Map<int, int> newSpellSlots,
    required Map<int, int> oldPactSlots,
    required Map<int, int> newPactSlots,
    required List<String> missingDecisions,
  }) : super._(
         before: before,
         character: character,
         classEntryId: classEntryId,
         oldLevel: oldLevel,
         targetLevel: targetLevel,
         removedClassFeatures: removedClassFeatures,
         removedSubclassFeatures: removedSubclassFeatures,
         removedChoiceGroups: removedChoiceGroups,
         removedChoices: removedChoices,
         invalidChoices: invalidChoices,
         oldMaxHp: oldMaxHp,
         newMaxHp: newMaxHp,
         oldProficiencyBonus: oldProficiencyBonus,
         newProficiencyBonus: newProficiencyBonus,
         oldResourceMaxima: oldResourceMaxima,
         newResourceMaxima: newResourceMaxima,
         oldSpellSlots: oldSpellSlots,
         newSpellSlots: newSpellSlots,
         oldPactSlots: oldPactSlots,
         newPactSlots: newPactSlots,
         missingDecisions: missingDecisions,
       );

  /// Returns a shallow copy of this [LevelDownPreview]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LevelDownPreview copyWith({
    _iokyyhkm.CharacterData? before,
    _iokyyhkm.CharacterData? character,
    String? classEntryId,
    int? oldLevel,
    int? targetLevel,
    List<_ikfzlvib.ClassFeatureData>? removedClassFeatures,
    List<_itaxdcfb.SubclassFeatureData>? removedSubclassFeatures,
    List<_igmk6n2e.ChoiceGroupData>? removedChoiceGroups,
    List<_ic1a1q8y.CharacterChoiceData>? removedChoices,
    List<_i77exzmx.LevelDownInvalidChoiceView>? invalidChoices,
    Object? oldMaxHp = _Undefined,
    Object? newMaxHp = _Undefined,
    Object? oldProficiencyBonus = _Undefined,
    Object? newProficiencyBonus = _Undefined,
    Map<String, int>? oldResourceMaxima,
    Map<String, int>? newResourceMaxima,
    Map<int, int>? oldSpellSlots,
    Map<int, int>? newSpellSlots,
    Map<int, int>? oldPactSlots,
    Map<int, int>? newPactSlots,
    List<String>? missingDecisions,
  }) {
    return LevelDownPreview(
      before: before ?? this.before.copyWith(),
      character: character ?? this.character.copyWith(),
      classEntryId: classEntryId ?? this.classEntryId,
      oldLevel: oldLevel ?? this.oldLevel,
      targetLevel: targetLevel ?? this.targetLevel,
      removedClassFeatures:
          removedClassFeatures ??
          this.removedClassFeatures.map((e0) => e0.copyWith()).toList(),
      removedSubclassFeatures:
          removedSubclassFeatures ??
          this.removedSubclassFeatures.map((e0) => e0.copyWith()).toList(),
      removedChoiceGroups:
          removedChoiceGroups ??
          this.removedChoiceGroups.map((e0) => e0.copyWith()).toList(),
      removedChoices:
          removedChoices ??
          this.removedChoices.map((e0) => e0.copyWith()).toList(),
      invalidChoices:
          invalidChoices ??
          this.invalidChoices.map((e0) => e0.copyWith()).toList(),
      oldMaxHp: oldMaxHp is int? ? oldMaxHp : this.oldMaxHp,
      newMaxHp: newMaxHp is int? ? newMaxHp : this.newMaxHp,
      oldProficiencyBonus: oldProficiencyBonus is int?
          ? oldProficiencyBonus
          : this.oldProficiencyBonus,
      newProficiencyBonus: newProficiencyBonus is int?
          ? newProficiencyBonus
          : this.newProficiencyBonus,
      oldResourceMaxima:
          oldResourceMaxima ??
          this.oldResourceMaxima.map((key0, value0) => MapEntry(key0, value0)),
      newResourceMaxima:
          newResourceMaxima ??
          this.newResourceMaxima.map((key0, value0) => MapEntry(key0, value0)),
      oldSpellSlots:
          oldSpellSlots ??
          this.oldSpellSlots.map((key0, value0) => MapEntry(key0, value0)),
      newSpellSlots:
          newSpellSlots ??
          this.newSpellSlots.map((key0, value0) => MapEntry(key0, value0)),
      oldPactSlots:
          oldPactSlots ??
          this.oldPactSlots.map((key0, value0) => MapEntry(key0, value0)),
      newPactSlots:
          newPactSlots ??
          this.newPactSlots.map((key0, value0) => MapEntry(key0, value0)),
      missingDecisions:
          missingDecisions ?? this.missingDecisions.map((e0) => e0).toList(),
    );
  }
}
