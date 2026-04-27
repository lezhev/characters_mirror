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
import '../../../data/general/character/character_class_entry_data.dart' as _i2;
import '../../../enums/skill.dart' as _i3;
import '../../../enums/character_skill_selection_kind.dart' as _i4;

abstract class CharacterSkillSelectionData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CharacterSkillSelectionData._({
    this.id,
    this.classEntry,
    this.classDataId,
    this.backgroundDataId,
    this.skill,
    this.kind,
    this.selectionIndex,
    this.updatedAt,
  });

  factory CharacterSkillSelectionData({
    String? id,
    _i2.CharacterClassEntryData? classEntry,
    int? classDataId,
    int? backgroundDataId,
    _i3.Skill? skill,
    _i4.CharacterSkillSelectionKind? kind,
    int? selectionIndex,
    DateTime? updatedAt,
  }) = _CharacterSkillSelectionDataImpl;

  factory CharacterSkillSelectionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterSkillSelectionData(
      id: jsonSerialization['id'] as String?,
      classEntry: jsonSerialization['classEntry'] == null
          ? null
          : _i2.CharacterClassEntryData.fromJson(
              (jsonSerialization['classEntry'] as Map<String, dynamic>)),
      classDataId: jsonSerialization['classDataId'] as int?,
      backgroundDataId: jsonSerialization['backgroundDataId'] as int?,
      skill: jsonSerialization['skill'] == null
          ? null
          : _i3.Skill.fromJson((jsonSerialization['skill'] as String)),
      kind: jsonSerialization['kind'] == null
          ? null
          : _i4.CharacterSkillSelectionKind.fromJson(
              (jsonSerialization['kind'] as String)),
      selectionIndex: jsonSerialization['selectionIndex'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  String? id;

  _i2.CharacterClassEntryData? classEntry;

  int? classDataId;

  int? backgroundDataId;

  _i3.Skill? skill;

  _i4.CharacterSkillSelectionKind? kind;

  int? selectionIndex;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [CharacterSkillSelectionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterSkillSelectionData copyWith({
    String? id,
    _i2.CharacterClassEntryData? classEntry,
    int? classDataId,
    int? backgroundDataId,
    _i3.Skill? skill,
    _i4.CharacterSkillSelectionKind? kind,
    int? selectionIndex,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (classEntry != null) 'classEntry': classEntry?.toJson(),
      if (classDataId != null) 'classDataId': classDataId,
      if (backgroundDataId != null) 'backgroundDataId': backgroundDataId,
      if (skill != null) 'skill': skill?.toJson(),
      if (kind != null) 'kind': kind?.toJson(),
      if (selectionIndex != null) 'selectionIndex': selectionIndex,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (classEntry != null) 'classEntry': classEntry?.toJsonForProtocol(),
      if (classDataId != null) 'classDataId': classDataId,
      if (backgroundDataId != null) 'backgroundDataId': backgroundDataId,
      if (skill != null) 'skill': skill?.toJson(),
      if (kind != null) 'kind': kind?.toJson(),
      if (selectionIndex != null) 'selectionIndex': selectionIndex,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSkillSelectionDataImpl extends CharacterSkillSelectionData {
  _CharacterSkillSelectionDataImpl({
    String? id,
    _i2.CharacterClassEntryData? classEntry,
    int? classDataId,
    int? backgroundDataId,
    _i3.Skill? skill,
    _i4.CharacterSkillSelectionKind? kind,
    int? selectionIndex,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          classEntry: classEntry,
          classDataId: classDataId,
          backgroundDataId: backgroundDataId,
          skill: skill,
          kind: kind,
          selectionIndex: selectionIndex,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [CharacterSkillSelectionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterSkillSelectionData copyWith({
    Object? id = _Undefined,
    Object? classEntry = _Undefined,
    Object? classDataId = _Undefined,
    Object? backgroundDataId = _Undefined,
    Object? skill = _Undefined,
    Object? kind = _Undefined,
    Object? selectionIndex = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return CharacterSkillSelectionData(
      id: id is String? ? id : this.id,
      classEntry: classEntry is _i2.CharacterClassEntryData?
          ? classEntry
          : this.classEntry?.copyWith(),
      classDataId: classDataId is int? ? classDataId : this.classDataId,
      backgroundDataId:
          backgroundDataId is int? ? backgroundDataId : this.backgroundDataId,
      skill: skill is _i3.Skill? ? skill : this.skill,
      kind: kind is _i4.CharacterSkillSelectionKind? ? kind : this.kind,
      selectionIndex:
          selectionIndex is int? ? selectionIndex : this.selectionIndex,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
