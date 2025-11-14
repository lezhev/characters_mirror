/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../../data/general/character/character_data.dart' as _i2;
import '../../../data/general/class/class_data.dart' as _i3;
import '../../../data/general/class/subclass_data.dart' as _i4;

abstract class CharacterClassRelation implements _i1.SerializableModel {
  CharacterClassRelation._({
    this.id,
    required this.characterId,
    this.character,
    required this.classDataId,
    this.classData,
    required this.subclassId,
    this.subclass,
    required this.level,
    this.spellcastingProgression,
  });

  factory CharacterClassRelation({
    int? id,
    required int characterId,
    _i2.CharacterData? character,
    required int classDataId,
    _i3.ClassData? classData,
    required int subclassId,
    _i4.SubclassData? subclass,
    required int level,
    String? spellcastingProgression,
  }) = _CharacterClassRelationImpl;

  factory CharacterClassRelation.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterClassRelation(
      id: jsonSerialization['id'] as int?,
      characterId: jsonSerialization['characterId'] as int,
      character: jsonSerialization['character'] == null
          ? null
          : _i2.CharacterData.fromJson(
              (jsonSerialization['character'] as Map<String, dynamic>)),
      classDataId: jsonSerialization['classDataId'] as int,
      classData: jsonSerialization['classData'] == null
          ? null
          : _i3.ClassData.fromJson(
              (jsonSerialization['classData'] as Map<String, dynamic>)),
      subclassId: jsonSerialization['subclassId'] as int,
      subclass: jsonSerialization['subclass'] == null
          ? null
          : _i4.SubclassData.fromJson(
              (jsonSerialization['subclass'] as Map<String, dynamic>)),
      level: jsonSerialization['level'] as int,
      spellcastingProgression:
          jsonSerialization['spellcastingProgression'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int characterId;

  _i2.CharacterData? character;

  int classDataId;

  _i3.ClassData? classData;

  int subclassId;

  _i4.SubclassData? subclass;

  int level;

  String? spellcastingProgression;

  /// Returns a shallow copy of this [CharacterClassRelation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterClassRelation copyWith({
    int? id,
    int? characterId,
    _i2.CharacterData? character,
    int? classDataId,
    _i3.ClassData? classData,
    int? subclassId,
    _i4.SubclassData? subclass,
    int? level,
    String? spellcastingProgression,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'characterId': characterId,
      if (character != null) 'character': character?.toJson(),
      'classDataId': classDataId,
      if (classData != null) 'classData': classData?.toJson(),
      'subclassId': subclassId,
      if (subclass != null) 'subclass': subclass?.toJson(),
      'level': level,
      if (spellcastingProgression != null)
        'spellcastingProgression': spellcastingProgression,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterClassRelationImpl extends CharacterClassRelation {
  _CharacterClassRelationImpl({
    int? id,
    required int characterId,
    _i2.CharacterData? character,
    required int classDataId,
    _i3.ClassData? classData,
    required int subclassId,
    _i4.SubclassData? subclass,
    required int level,
    String? spellcastingProgression,
  }) : super._(
          id: id,
          characterId: characterId,
          character: character,
          classDataId: classDataId,
          classData: classData,
          subclassId: subclassId,
          subclass: subclass,
          level: level,
          spellcastingProgression: spellcastingProgression,
        );

  /// Returns a shallow copy of this [CharacterClassRelation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterClassRelation copyWith({
    Object? id = _Undefined,
    int? characterId,
    Object? character = _Undefined,
    int? classDataId,
    Object? classData = _Undefined,
    int? subclassId,
    Object? subclass = _Undefined,
    int? level,
    Object? spellcastingProgression = _Undefined,
  }) {
    return CharacterClassRelation(
      id: id is int? ? id : this.id,
      characterId: characterId ?? this.characterId,
      character: character is _i2.CharacterData?
          ? character
          : this.character?.copyWith(),
      classDataId: classDataId ?? this.classDataId,
      classData:
          classData is _i3.ClassData? ? classData : this.classData?.copyWith(),
      subclassId: subclassId ?? this.subclassId,
      subclass:
          subclass is _i4.SubclassData? ? subclass : this.subclass?.copyWith(),
      level: level ?? this.level,
      spellcastingProgression: spellcastingProgression is String?
          ? spellcastingProgression
          : this.spellcastingProgression,
    );
  }
}
