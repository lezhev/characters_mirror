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
import '../../../data/general/character/level_up_spell_choice.dart' as _i2;

abstract class LevelUpRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  LevelUpRequest._({
    required this.characterId,
    required this.expectedVersion,
    required this.classEntryId,
    this.hitDieRoll,
    this.subclassId,
    this.choices,
    this.spells,
  });

  factory LevelUpRequest({
    required int characterId,
    required int expectedVersion,
    required String classEntryId,
    int? hitDieRoll,
    int? subclassId,
    Map<String, List<String>>? choices,
    List<_i2.LevelUpSpellChoice>? spells,
  }) = _LevelUpRequestImpl;

  factory LevelUpRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return LevelUpRequest(
      characterId: jsonSerialization['characterId'] as int,
      expectedVersion: jsonSerialization['expectedVersion'] as int,
      classEntryId: jsonSerialization['classEntryId'] as String,
      hitDieRoll: jsonSerialization['hitDieRoll'] as int?,
      subclassId: jsonSerialization['subclassId'] as int?,
      choices: (jsonSerialization['choices'] as Map?)?.map((k, v) => MapEntry(
            k as String,
            (v as List).map((e) => e as String).toList(),
          )),
      spells: (jsonSerialization['spells'] as List?)
          ?.map((e) =>
              _i2.LevelUpSpellChoice.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  int characterId;

  int expectedVersion;

  String classEntryId;

  int? hitDieRoll;

  int? subclassId;

  Map<String, List<String>>? choices;

  List<_i2.LevelUpSpellChoice>? spells;

  /// Returns a shallow copy of this [LevelUpRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LevelUpRequest copyWith({
    int? characterId,
    int? expectedVersion,
    String? classEntryId,
    int? hitDieRoll,
    int? subclassId,
    Map<String, List<String>>? choices,
    List<_i2.LevelUpSpellChoice>? spells,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'characterId': characterId,
      'expectedVersion': expectedVersion,
      'classEntryId': classEntryId,
      if (hitDieRoll != null) 'hitDieRoll': hitDieRoll,
      if (subclassId != null) 'subclassId': subclassId,
      if (choices != null)
        'choices': choices?.toJson(valueToJson: (v) => v.toJson()),
      if (spells != null)
        'spells': spells?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'characterId': characterId,
      'expectedVersion': expectedVersion,
      'classEntryId': classEntryId,
      if (hitDieRoll != null) 'hitDieRoll': hitDieRoll,
      if (subclassId != null) 'subclassId': subclassId,
      if (choices != null)
        'choices': choices?.toJson(valueToJson: (v) => v.toJson()),
      if (spells != null)
        'spells': spells?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LevelUpRequestImpl extends LevelUpRequest {
  _LevelUpRequestImpl({
    required int characterId,
    required int expectedVersion,
    required String classEntryId,
    int? hitDieRoll,
    int? subclassId,
    Map<String, List<String>>? choices,
    List<_i2.LevelUpSpellChoice>? spells,
  }) : super._(
          characterId: characterId,
          expectedVersion: expectedVersion,
          classEntryId: classEntryId,
          hitDieRoll: hitDieRoll,
          subclassId: subclassId,
          choices: choices,
          spells: spells,
        );

  /// Returns a shallow copy of this [LevelUpRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LevelUpRequest copyWith({
    int? characterId,
    int? expectedVersion,
    String? classEntryId,
    Object? hitDieRoll = _Undefined,
    Object? subclassId = _Undefined,
    Object? choices = _Undefined,
    Object? spells = _Undefined,
  }) {
    return LevelUpRequest(
      characterId: characterId ?? this.characterId,
      expectedVersion: expectedVersion ?? this.expectedVersion,
      classEntryId: classEntryId ?? this.classEntryId,
      hitDieRoll: hitDieRoll is int? ? hitDieRoll : this.hitDieRoll,
      subclassId: subclassId is int? ? subclassId : this.subclassId,
      choices: choices is Map<String, List<String>>?
          ? choices
          : this.choices?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0.map((e1) => e1).toList(),
                  )),
      spells: spells is List<_i2.LevelUpSpellChoice>?
          ? spells
          : this.spells?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
