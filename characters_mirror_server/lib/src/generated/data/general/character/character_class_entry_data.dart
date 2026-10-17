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
import '../../../data/general/class/class_data.dart' as _i7s9vfyh;
import '../../../data/general/class/subclass_data.dart' as _i6yrac43;
import '../../../enums/hit_point_mode.dart' as _ivn6s9bn;

abstract class CharacterClassEntryData
    implements _is.SerializableModel, _is.ProtocolSerialization {
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
    this.updatedAt,
  });

  factory CharacterClassEntryData({
    String? id,
    _i7s9vfyh.ClassData? classData,
    _i6yrac43.SubclassData? subclass,
    int? level,
    bool? isStartingClass,
    int? classOrder,
    _ivn6s9bn.HitPointMode? hpMode,
    List<int>? hpRolledValues,
    String? notes,
    DateTime? updatedAt,
  }) = _CharacterClassEntryDataImpl;

  factory CharacterClassEntryData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterClassEntryData(
      id: jsonSerialization['id'] as String?,
      classData: jsonSerialization['classData'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i7s9vfyh.ClassData>(
              jsonSerialization['classData'],
            ),
      subclass: jsonSerialization['subclass'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i6yrac43.SubclassData>(
              jsonSerialization['subclass'],
            ),
      level: jsonSerialization['level'] as int?,
      isStartingClass: jsonSerialization['isStartingClass'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['isStartingClass'],
            ),
      classOrder: jsonSerialization['classOrder'] as int?,
      hpMode: jsonSerialization['hpMode'] == null
          ? null
          : _ivn6s9bn.HitPointMode.fromJson(
              (jsonSerialization['hpMode'] as String),
            ),
      hpRolledValues: jsonSerialization['hpRolledValues'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<int>>(
              jsonSerialization['hpRolledValues'],
            ),
      notes: jsonSerialization['notes'] as String?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  String? id;

  _i7s9vfyh.ClassData? classData;

  _i6yrac43.SubclassData? subclass;

  int? level;

  bool? isStartingClass;

  int? classOrder;

  _ivn6s9bn.HitPointMode? hpMode;

  List<int>? hpRolledValues;

  String? notes;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [CharacterClassEntryData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CharacterClassEntryData copyWith({
    String? id,
    _i7s9vfyh.ClassData? classData,
    _i6yrac43.SubclassData? subclass,
    int? level,
    bool? isStartingClass,
    int? classOrder,
    _ivn6s9bn.HitPointMode? hpMode,
    List<int>? hpRolledValues,
    String? notes,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterClassEntryData',
      if (id != null) 'id': id,
      if (classData != null) 'classData': classData?.toJson(),
      if (subclass != null) 'subclass': subclass?.toJson(),
      if (level != null) 'level': level,
      if (isStartingClass != null) 'isStartingClass': isStartingClass,
      if (classOrder != null) 'classOrder': classOrder,
      if (hpMode != null) 'hpMode': hpMode?.toJson(),
      if (hpRolledValues != null) 'hpRolledValues': hpRolledValues?.toJson(),
      if (notes != null) 'notes': notes,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CharacterClassEntryData',
      if (id != null) 'id': id,
      if (classData != null) 'classData': classData?.toJsonForProtocol(),
      if (subclass != null) 'subclass': subclass?.toJsonForProtocol(),
      if (level != null) 'level': level,
      if (isStartingClass != null) 'isStartingClass': isStartingClass,
      if (classOrder != null) 'classOrder': classOrder,
      if (hpMode != null) 'hpMode': hpMode?.toJson(),
      if (hpRolledValues != null) 'hpRolledValues': hpRolledValues?.toJson(),
      if (notes != null) 'notes': notes,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterClassEntryDataImpl extends CharacterClassEntryData {
  _CharacterClassEntryDataImpl({
    String? id,
    _i7s9vfyh.ClassData? classData,
    _i6yrac43.SubclassData? subclass,
    int? level,
    bool? isStartingClass,
    int? classOrder,
    _ivn6s9bn.HitPointMode? hpMode,
    List<int>? hpRolledValues,
    String? notes,
    DateTime? updatedAt,
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
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CharacterClassEntryData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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
    Object? updatedAt = _Undefined,
  }) {
    return CharacterClassEntryData(
      id: id is String? ? id : this.id,
      classData: classData is _i7s9vfyh.ClassData?
          ? classData
          : this.classData?.copyWith(),
      subclass: subclass is _i6yrac43.SubclassData?
          ? subclass
          : this.subclass?.copyWith(),
      level: level is int? ? level : this.level,
      isStartingClass: isStartingClass is bool?
          ? isStartingClass
          : this.isStartingClass,
      classOrder: classOrder is int? ? classOrder : this.classOrder,
      hpMode: hpMode is _ivn6s9bn.HitPointMode? ? hpMode : this.hpMode,
      hpRolledValues: hpRolledValues is List<int>?
          ? hpRolledValues
          : this.hpRolledValues?.map((e0) => e0).toList(),
      notes: notes is String? ? notes : this.notes,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
