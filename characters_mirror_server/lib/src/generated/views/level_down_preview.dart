/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../data/general/character/character_data.dart' as _i2;
import '../data/general/class/class_feature_data.dart' as _i3;
import '../data/general/class/subclass_feature_data.dart' as _i4;
import '../data/general/choice_group_data.dart' as _i5;
import '../data/general/character/character_choice_data.dart' as _i6;
import '../views/level_down_invalid_choice_view.dart' as _i7;

abstract class LevelDownPreview
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
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
    required _i2.CharacterData before,
    required _i2.CharacterData character,
    required String classEntryId,
    required int oldLevel,
    required int targetLevel,
    required List<_i3.ClassFeatureData> removedClassFeatures,
    required List<_i4.SubclassFeatureData> removedSubclassFeatures,
    required List<_i5.ChoiceGroupData> removedChoiceGroups,
    required List<_i6.CharacterChoiceData> removedChoices,
    required List<_i7.LevelDownInvalidChoiceView> invalidChoices,
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
      before: _i2.CharacterData.fromJson(
          (jsonSerialization['before'] as Map<String, dynamic>)),
      character: _i2.CharacterData.fromJson(
          (jsonSerialization['character'] as Map<String, dynamic>)),
      classEntryId: jsonSerialization['classEntryId'] as String,
      oldLevel: jsonSerialization['oldLevel'] as int,
      targetLevel: jsonSerialization['targetLevel'] as int,
      removedClassFeatures: (jsonSerialization['removedClassFeatures'] as List)
          .map(
              (e) => _i3.ClassFeatureData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      removedSubclassFeatures:
          (jsonSerialization['removedSubclassFeatures'] as List)
              .map((e) =>
                  _i4.SubclassFeatureData.fromJson((e as Map<String, dynamic>)))
              .toList(),
      removedChoiceGroups: (jsonSerialization['removedChoiceGroups'] as List)
          .map((e) => _i5.ChoiceGroupData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      removedChoices: (jsonSerialization['removedChoices'] as List)
          .map((e) =>
              _i6.CharacterChoiceData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      invalidChoices: (jsonSerialization['invalidChoices'] as List)
          .map((e) => _i7.LevelDownInvalidChoiceView.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      oldMaxHp: jsonSerialization['oldMaxHp'] as int?,
      newMaxHp: jsonSerialization['newMaxHp'] as int?,
      oldProficiencyBonus: jsonSerialization['oldProficiencyBonus'] as int?,
      newProficiencyBonus: jsonSerialization['newProficiencyBonus'] as int?,
      oldResourceMaxima: (jsonSerialization['oldResourceMaxima'] as Map)
          .map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      newResourceMaxima: (jsonSerialization['newResourceMaxima'] as Map)
          .map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      oldSpellSlots: (jsonSerialization['oldSpellSlots'] as List)
          .fold<Map<int, int>>(
              {}, (t, e) => {...t, e['k'] as int: e['v'] as int}),
      newSpellSlots: (jsonSerialization['newSpellSlots'] as List)
          .fold<Map<int, int>>(
              {}, (t, e) => {...t, e['k'] as int: e['v'] as int}),
      oldPactSlots: (jsonSerialization['oldPactSlots'] as List)
          .fold<Map<int, int>>(
              {}, (t, e) => {...t, e['k'] as int: e['v'] as int}),
      newPactSlots: (jsonSerialization['newPactSlots'] as List)
          .fold<Map<int, int>>(
              {}, (t, e) => {...t, e['k'] as int: e['v'] as int}),
      missingDecisions: (jsonSerialization['missingDecisions'] as List)
          .map((e) => e as String)
          .toList(),
    );
  }

  _i2.CharacterData before;

  _i2.CharacterData character;

  String classEntryId;

  int oldLevel;

  int targetLevel;

  List<_i3.ClassFeatureData> removedClassFeatures;

  List<_i4.SubclassFeatureData> removedSubclassFeatures;

  List<_i5.ChoiceGroupData> removedChoiceGroups;

  List<_i6.CharacterChoiceData> removedChoices;

  List<_i7.LevelDownInvalidChoiceView> invalidChoices;

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
  @_i1.useResult
  LevelDownPreview copyWith({
    _i2.CharacterData? before,
    _i2.CharacterData? character,
    String? classEntryId,
    int? oldLevel,
    int? targetLevel,
    List<_i3.ClassFeatureData>? removedClassFeatures,
    List<_i4.SubclassFeatureData>? removedSubclassFeatures,
    List<_i5.ChoiceGroupData>? removedChoiceGroups,
    List<_i6.CharacterChoiceData>? removedChoices,
    List<_i7.LevelDownInvalidChoiceView>? invalidChoices,
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
      'before': before.toJson(),
      'character': character.toJson(),
      'classEntryId': classEntryId,
      'oldLevel': oldLevel,
      'targetLevel': targetLevel,
      'removedClassFeatures':
          removedClassFeatures.toJson(valueToJson: (v) => v.toJson()),
      'removedSubclassFeatures':
          removedSubclassFeatures.toJson(valueToJson: (v) => v.toJson()),
      'removedChoiceGroups':
          removedChoiceGroups.toJson(valueToJson: (v) => v.toJson()),
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
      'before': before.toJsonForProtocol(),
      'character': character.toJsonForProtocol(),
      'classEntryId': classEntryId,
      'oldLevel': oldLevel,
      'targetLevel': targetLevel,
      'removedClassFeatures': removedClassFeatures.toJson(
          valueToJson: (v) => v.toJsonForProtocol()),
      'removedSubclassFeatures': removedSubclassFeatures.toJson(
          valueToJson: (v) => v.toJsonForProtocol()),
      'removedChoiceGroups':
          removedChoiceGroups.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'removedChoices':
          removedChoices.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'invalidChoices':
          invalidChoices.toJson(valueToJson: (v) => v.toJsonForProtocol()),
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
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LevelDownPreviewImpl extends LevelDownPreview {
  _LevelDownPreviewImpl({
    required _i2.CharacterData before,
    required _i2.CharacterData character,
    required String classEntryId,
    required int oldLevel,
    required int targetLevel,
    required List<_i3.ClassFeatureData> removedClassFeatures,
    required List<_i4.SubclassFeatureData> removedSubclassFeatures,
    required List<_i5.ChoiceGroupData> removedChoiceGroups,
    required List<_i6.CharacterChoiceData> removedChoices,
    required List<_i7.LevelDownInvalidChoiceView> invalidChoices,
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
  @_i1.useResult
  @override
  LevelDownPreview copyWith({
    _i2.CharacterData? before,
    _i2.CharacterData? character,
    String? classEntryId,
    int? oldLevel,
    int? targetLevel,
    List<_i3.ClassFeatureData>? removedClassFeatures,
    List<_i4.SubclassFeatureData>? removedSubclassFeatures,
    List<_i5.ChoiceGroupData>? removedChoiceGroups,
    List<_i6.CharacterChoiceData>? removedChoices,
    List<_i7.LevelDownInvalidChoiceView>? invalidChoices,
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
      removedClassFeatures: removedClassFeatures ??
          this.removedClassFeatures.map((e0) => e0.copyWith()).toList(),
      removedSubclassFeatures: removedSubclassFeatures ??
          this.removedSubclassFeatures.map((e0) => e0.copyWith()).toList(),
      removedChoiceGroups: removedChoiceGroups ??
          this.removedChoiceGroups.map((e0) => e0.copyWith()).toList(),
      removedChoices: removedChoices ??
          this.removedChoices.map((e0) => e0.copyWith()).toList(),
      invalidChoices: invalidChoices ??
          this.invalidChoices.map((e0) => e0.copyWith()).toList(),
      oldMaxHp: oldMaxHp is int? ? oldMaxHp : this.oldMaxHp,
      newMaxHp: newMaxHp is int? ? newMaxHp : this.newMaxHp,
      oldProficiencyBonus: oldProficiencyBonus is int?
          ? oldProficiencyBonus
          : this.oldProficiencyBonus,
      newProficiencyBonus: newProficiencyBonus is int?
          ? newProficiencyBonus
          : this.newProficiencyBonus,
      oldResourceMaxima: oldResourceMaxima ??
          this.oldResourceMaxima.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      newResourceMaxima: newResourceMaxima ??
          this.newResourceMaxima.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      oldSpellSlots: oldSpellSlots ??
          this.oldSpellSlots.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      newSpellSlots: newSpellSlots ??
          this.newSpellSlots.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      oldPactSlots: oldPactSlots ??
          this.oldPactSlots.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      newPactSlots: newPactSlots ??
          this.newPactSlots.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      missingDecisions:
          missingDecisions ?? this.missingDecisions.map((e0) => e0).toList(),
    );
  }
}
