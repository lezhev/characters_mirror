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
import 'package:characters_mirror_client/src/protocol/protocol.dart'
    as _isnx6jbi;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../../data/general/character/level_up_choice_replacement_data.dart'
    as _isutjq79;
import '../../../data/general/character/level_up_spell_choice.dart'
    as _is7zxvhe;

abstract class LevelUpRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LevelUpRequest._({
    this.choiceReplacements,
    required this.characterId,
    required this.expectedVersion,
    required this.classEntryId,
    this.hitDieRoll,
    this.subclassId,
    this.choices,
    this.spells,
  });

  factory LevelUpRequest({
    List<_isutjq79.LevelUpChoiceReplacementData>? choiceReplacements,
    required int characterId,
    required int expectedVersion,
    required String classEntryId,
    int? hitDieRoll,
    int? subclassId,
    Map<String, List<String>>? choices,
    List<_is7zxvhe.LevelUpSpellChoice>? spells,
  }) = _LevelUpRequestImpl;

  factory LevelUpRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return LevelUpRequest(
      choiceReplacements: jsonSerialization['choiceReplacements'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_isutjq79.LevelUpChoiceReplacementData>>(
                  jsonSerialization['choiceReplacements'],
                ),
      characterId: jsonSerialization['characterId'] as int,
      expectedVersion: jsonSerialization['expectedVersion'] as int,
      classEntryId: jsonSerialization['classEntryId'] as String,
      hitDieRoll: jsonSerialization['hitDieRoll'] as int?,
      subclassId: jsonSerialization['subclassId'] as int?,
      choices: jsonSerialization['choices'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<Map<String, List<String>>>(
              jsonSerialization['choices'],
            ),
      spells: jsonSerialization['spells'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_is7zxvhe.LevelUpSpellChoice>>(
                  jsonSerialization['spells'],
                ),
    );
  }

  List<_isutjq79.LevelUpChoiceReplacementData>? choiceReplacements;

  int characterId;

  int expectedVersion;

  String classEntryId;

  int? hitDieRoll;

  int? subclassId;

  Map<String, List<String>>? choices;

  List<_is7zxvhe.LevelUpSpellChoice>? spells;

  /// Returns a shallow copy of this [LevelUpRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LevelUpRequest copyWith({
    List<_isutjq79.LevelUpChoiceReplacementData>? choiceReplacements,
    int? characterId,
    int? expectedVersion,
    String? classEntryId,
    int? hitDieRoll,
    int? subclassId,
    Map<String, List<String>>? choices,
    List<_is7zxvhe.LevelUpSpellChoice>? spells,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LevelUpRequest',
      if (choiceReplacements != null)
        'choiceReplacements': choiceReplacements?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
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
      '__className__': 'LevelUpRequest',
      if (choiceReplacements != null)
        'choiceReplacements': choiceReplacements?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
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
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LevelUpRequestImpl extends LevelUpRequest {
  _LevelUpRequestImpl({
    List<_isutjq79.LevelUpChoiceReplacementData>? choiceReplacements,
    required int characterId,
    required int expectedVersion,
    required String classEntryId,
    int? hitDieRoll,
    int? subclassId,
    Map<String, List<String>>? choices,
    List<_is7zxvhe.LevelUpSpellChoice>? spells,
  }) : super._(
         choiceReplacements: choiceReplacements,
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
  @_isc.useResult
  @override
  LevelUpRequest copyWith({
    Object? choiceReplacements = _Undefined,
    int? characterId,
    int? expectedVersion,
    String? classEntryId,
    Object? hitDieRoll = _Undefined,
    Object? subclassId = _Undefined,
    Object? choices = _Undefined,
    Object? spells = _Undefined,
  }) {
    return LevelUpRequest(
      choiceReplacements:
          choiceReplacements is List<_isutjq79.LevelUpChoiceReplacementData>?
          ? choiceReplacements
          : this.choiceReplacements?.map((e0) => e0.copyWith()).toList(),
      characterId: characterId ?? this.characterId,
      expectedVersion: expectedVersion ?? this.expectedVersion,
      classEntryId: classEntryId ?? this.classEntryId,
      hitDieRoll: hitDieRoll is int? ? hitDieRoll : this.hitDieRoll,
      subclassId: subclassId is int? ? subclassId : this.subclassId,
      choices: choices is Map<String, List<String>>?
          ? choices
          : this.choices?.map(
              (key0, value0) => MapEntry(key0, value0.map((e1) => e1).toList()),
            ),
      spells: spells is List<_is7zxvhe.LevelUpSpellChoice>?
          ? spells
          : this.spells?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
