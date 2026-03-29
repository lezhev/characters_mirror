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
import '../../../enums/hit_point_mode.dart' as _i5;

abstract class CharacterClassEntryData implements _i1.SerializableModel {
  CharacterClassEntryData._({
    this.id,
    required this.characterId,
    this.character,
    required this.classDataId,
    this.classData,
    this.subclassId,
    this.subclass,
    required this.level,
    this.isStartingClass,
    this.classOrder,
    this.hpMode,
    this.hpRolledValues,
    this.notes,
  });

  factory CharacterClassEntryData({
    int? id,
    required int characterId,
    _i2.CharacterData? character,
    required int classDataId,
    _i3.ClassData? classData,
    int? subclassId,
    _i4.SubclassData? subclass,
    required int level,
    bool? isStartingClass,
    int? classOrder,
    _i5.HitPointMode? hpMode,
    List<int>? hpRolledValues,
    String? notes,
  }) = _CharacterClassEntryDataImpl;

  factory CharacterClassEntryData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterClassEntryData(
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
      subclassId: jsonSerialization['subclassId'] as int?,
      subclass: jsonSerialization['subclass'] == null
          ? null
          : _i4.SubclassData.fromJson(
              (jsonSerialization['subclass'] as Map<String, dynamic>)),
      level: jsonSerialization['level'] as int,
      isStartingClass: jsonSerialization['isStartingClass'] as bool?,
      classOrder: jsonSerialization['classOrder'] as int?,
      hpMode: jsonSerialization['hpMode'] == null
          ? null
          : _i5.HitPointMode.fromJson((jsonSerialization['hpMode'] as String)),
      hpRolledValues: (jsonSerialization['hpRolledValues'] as List?)
          ?.map((e) => e as int)
          .toList(),
      notes: jsonSerialization['notes'] as String?,
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

  int? subclassId;

  _i4.SubclassData? subclass;

  int level;

  bool? isStartingClass;

  int? classOrder;

  _i5.HitPointMode? hpMode;

  List<int>? hpRolledValues;

  String? notes;

  /// Returns a shallow copy of this [CharacterClassEntryData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterClassEntryData copyWith({
    int? id,
    int? characterId,
    _i2.CharacterData? character,
    int? classDataId,
    _i3.ClassData? classData,
    int? subclassId,
    _i4.SubclassData? subclass,
    int? level,
    bool? isStartingClass,
    int? classOrder,
    _i5.HitPointMode? hpMode,
    List<int>? hpRolledValues,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'characterId': characterId,
      if (character != null) 'character': character?.toJson(),
      'classDataId': classDataId,
      if (classData != null) 'classData': classData?.toJson(),
      if (subclassId != null) 'subclassId': subclassId,
      if (subclass != null) 'subclass': subclass?.toJson(),
      'level': level,
      if (isStartingClass != null) 'isStartingClass': isStartingClass,
      if (classOrder != null) 'classOrder': classOrder,
      if (hpMode != null) 'hpMode': hpMode?.toJson(),
      if (hpRolledValues != null) 'hpRolledValues': hpRolledValues?.toJson(),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterClassEntryDataImpl extends CharacterClassEntryData {
  _CharacterClassEntryDataImpl({
    int? id,
    required int characterId,
    _i2.CharacterData? character,
    required int classDataId,
    _i3.ClassData? classData,
    int? subclassId,
    _i4.SubclassData? subclass,
    required int level,
    bool? isStartingClass,
    int? classOrder,
    _i5.HitPointMode? hpMode,
    List<int>? hpRolledValues,
    String? notes,
  }) : super._(
          id: id,
          characterId: characterId,
          character: character,
          classDataId: classDataId,
          classData: classData,
          subclassId: subclassId,
          subclass: subclass,
          level: level,
          isStartingClass: isStartingClass,
          classOrder: classOrder,
          hpMode: hpMode,
          hpRolledValues: hpRolledValues,
          notes: notes,
        );

  /// Returns a shallow copy of this [CharacterClassEntryData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterClassEntryData copyWith({
    Object? id = _Undefined,
    int? characterId,
    Object? character = _Undefined,
    int? classDataId,
    Object? classData = _Undefined,
    Object? subclassId = _Undefined,
    Object? subclass = _Undefined,
    int? level,
    Object? isStartingClass = _Undefined,
    Object? classOrder = _Undefined,
    Object? hpMode = _Undefined,
    Object? hpRolledValues = _Undefined,
    Object? notes = _Undefined,
  }) {
    return CharacterClassEntryData(
      id: id is int? ? id : this.id,
      characterId: characterId ?? this.characterId,
      character: character is _i2.CharacterData?
          ? character
          : this.character?.copyWith(),
      classDataId: classDataId ?? this.classDataId,
      classData:
          classData is _i3.ClassData? ? classData : this.classData?.copyWith(),
      subclassId: subclassId is int? ? subclassId : this.subclassId,
      subclass:
          subclass is _i4.SubclassData? ? subclass : this.subclass?.copyWith(),
      level: level ?? this.level,
      isStartingClass:
          isStartingClass is bool? ? isStartingClass : this.isStartingClass,
      classOrder: classOrder is int? ? classOrder : this.classOrder,
      hpMode: hpMode is _i5.HitPointMode? ? hpMode : this.hpMode,
      hpRolledValues: hpRolledValues is List<int>?
          ? hpRolledValues
          : this.hpRolledValues?.map((e0) => e0).toList(),
      notes: notes is String? ? notes : this.notes,
    );
  }
}
