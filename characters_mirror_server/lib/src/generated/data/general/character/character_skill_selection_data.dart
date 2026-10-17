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
import '../../../data/general/character/character_class_entry_data.dart'
    as _inzx0vvj;
import '../../../enums/character_skill_selection_kind.dart' as _if0i9g7r;
import '../../../enums/skill.dart' as _iqrhamom;

abstract class CharacterSkillSelectionData
    implements _is.SerializableModel, _is.ProtocolSerialization {
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
    _inzx0vvj.CharacterClassEntryData? classEntry,
    int? classDataId,
    int? backgroundDataId,
    _iqrhamom.Skill? skill,
    _if0i9g7r.CharacterSkillSelectionKind? kind,
    int? selectionIndex,
    DateTime? updatedAt,
  }) = _CharacterSkillSelectionDataImpl;

  factory CharacterSkillSelectionData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterSkillSelectionData(
      id: jsonSerialization['id'] as String?,
      classEntry: jsonSerialization['classEntry'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_inzx0vvj.CharacterClassEntryData>(
              jsonSerialization['classEntry'],
            ),
      classDataId: jsonSerialization['classDataId'] as int?,
      backgroundDataId: jsonSerialization['backgroundDataId'] as int?,
      skill: jsonSerialization['skill'] == null
          ? null
          : _iqrhamom.Skill.fromJson((jsonSerialization['skill'] as String)),
      kind: jsonSerialization['kind'] == null
          ? null
          : _if0i9g7r.CharacterSkillSelectionKind.fromJson(
              (jsonSerialization['kind'] as String),
            ),
      selectionIndex: jsonSerialization['selectionIndex'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  String? id;

  _inzx0vvj.CharacterClassEntryData? classEntry;

  int? classDataId;

  int? backgroundDataId;

  _iqrhamom.Skill? skill;

  _if0i9g7r.CharacterSkillSelectionKind? kind;

  int? selectionIndex;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [CharacterSkillSelectionData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CharacterSkillSelectionData copyWith({
    String? id,
    _inzx0vvj.CharacterClassEntryData? classEntry,
    int? classDataId,
    int? backgroundDataId,
    _iqrhamom.Skill? skill,
    _if0i9g7r.CharacterSkillSelectionKind? kind,
    int? selectionIndex,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterSkillSelectionData',
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
      '__className__': 'CharacterSkillSelectionData',
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
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSkillSelectionDataImpl extends CharacterSkillSelectionData {
  _CharacterSkillSelectionDataImpl({
    String? id,
    _inzx0vvj.CharacterClassEntryData? classEntry,
    int? classDataId,
    int? backgroundDataId,
    _iqrhamom.Skill? skill,
    _if0i9g7r.CharacterSkillSelectionKind? kind,
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
  @_is.useResult
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
      classEntry: classEntry is _inzx0vvj.CharacterClassEntryData?
          ? classEntry
          : this.classEntry?.copyWith(),
      classDataId: classDataId is int? ? classDataId : this.classDataId,
      backgroundDataId: backgroundDataId is int?
          ? backgroundDataId
          : this.backgroundDataId,
      skill: skill is _iqrhamom.Skill? ? skill : this.skill,
      kind: kind is _if0i9g7r.CharacterSkillSelectionKind? ? kind : this.kind,
      selectionIndex: selectionIndex is int?
          ? selectionIndex
          : this.selectionIndex,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
