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
import '../../../data/general/class/class_data.dart' as _i2;
import '../../../data/general/class/subclass_data.dart' as _i3;
import '../../../enums/hit_point_mode.dart' as _i4;

abstract class CharacterClassEntryData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CharacterClassEntryData._({
    this.id,
    this.classData,
    this.subclass,
    this.level,
    this.isStartingClass,
    this.classOrder,
    this.hpMode,
    this.hpRolledValues,
    this.notes,
  });

  factory CharacterClassEntryData({
    int? id,
    _i2.ClassData? classData,
    _i3.SubclassData? subclass,
    int? level,
    bool? isStartingClass,
    int? classOrder,
    _i4.HitPointMode? hpMode,
    List<int>? hpRolledValues,
    String? notes,
  }) = _CharacterClassEntryDataImpl;

  factory CharacterClassEntryData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterClassEntryData(
      id: jsonSerialization['id'] as int?,
      classData: jsonSerialization['classData'] == null
          ? null
          : _i2.ClassData.fromJson(
              (jsonSerialization['classData'] as Map<String, dynamic>)),
      subclass: jsonSerialization['subclass'] == null
          ? null
          : _i3.SubclassData.fromJson(
              (jsonSerialization['subclass'] as Map<String, dynamic>)),
      level: jsonSerialization['level'] as int?,
      isStartingClass: jsonSerialization['isStartingClass'] as bool?,
      classOrder: jsonSerialization['classOrder'] as int?,
      hpMode: jsonSerialization['hpMode'] == null
          ? null
          : _i4.HitPointMode.fromJson((jsonSerialization['hpMode'] as String)),
      hpRolledValues: (jsonSerialization['hpRolledValues'] as List?)
          ?.map((e) => e as int)
          .toList(),
      notes: jsonSerialization['notes'] as String?,
    );
  }

  int? id;

  _i2.ClassData? classData;

  _i3.SubclassData? subclass;

  int? level;

  bool? isStartingClass;

  int? classOrder;

  _i4.HitPointMode? hpMode;

  List<int>? hpRolledValues;

  String? notes;

  /// Returns a shallow copy of this [CharacterClassEntryData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterClassEntryData copyWith({
    int? id,
    _i2.ClassData? classData,
    _i3.SubclassData? subclass,
    int? level,
    bool? isStartingClass,
    int? classOrder,
    _i4.HitPointMode? hpMode,
    List<int>? hpRolledValues,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (classData != null) 'classData': classData?.toJson(),
      if (subclass != null) 'subclass': subclass?.toJson(),
      if (level != null) 'level': level,
      if (isStartingClass != null) 'isStartingClass': isStartingClass,
      if (classOrder != null) 'classOrder': classOrder,
      if (hpMode != null) 'hpMode': hpMode?.toJson(),
      if (hpRolledValues != null) 'hpRolledValues': hpRolledValues?.toJson(),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (classData != null) 'classData': classData?.toJsonForProtocol(),
      if (subclass != null) 'subclass': subclass?.toJsonForProtocol(),
      if (level != null) 'level': level,
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
    _i2.ClassData? classData,
    _i3.SubclassData? subclass,
    int? level,
    bool? isStartingClass,
    int? classOrder,
    _i4.HitPointMode? hpMode,
    List<int>? hpRolledValues,
    String? notes,
  }) : super._(
          id: id,
          classData: classData,
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
    Object? classData = _Undefined,
    Object? subclass = _Undefined,
    Object? level = _Undefined,
    Object? isStartingClass = _Undefined,
    Object? classOrder = _Undefined,
    Object? hpMode = _Undefined,
    Object? hpRolledValues = _Undefined,
    Object? notes = _Undefined,
  }) {
    return CharacterClassEntryData(
      id: id is int? ? id : this.id,
      classData:
          classData is _i2.ClassData? ? classData : this.classData?.copyWith(),
      subclass:
          subclass is _i3.SubclassData? ? subclass : this.subclass?.copyWith(),
      level: level is int? ? level : this.level,
      isStartingClass:
          isStartingClass is bool? ? isStartingClass : this.isStartingClass,
      classOrder: classOrder is int? ? classOrder : this.classOrder,
      hpMode: hpMode is _i4.HitPointMode? ? hpMode : this.hpMode,
      hpRolledValues: hpRolledValues is List<int>?
          ? hpRolledValues
          : this.hpRolledValues?.map((e0) => e0).toList(),
      notes: notes is String? ? notes : this.notes,
    );
  }
}
