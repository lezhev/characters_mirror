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
import '../enums/character_skill_selection_kind.dart' as _i2;
import '../enums/skill.dart' as _i3;

abstract class SkillSelectionGroupView
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  SkillSelectionGroupView._({
    this.kind,
    this.selectionCount,
    this.classDataId,
    this.backgroundDataId,
    this.options,
  });

  factory SkillSelectionGroupView({
    _i2.CharacterSkillSelectionKind? kind,
    int? selectionCount,
    int? classDataId,
    int? backgroundDataId,
    List<_i3.Skill>? options,
  }) = _SkillSelectionGroupViewImpl;

  factory SkillSelectionGroupView.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SkillSelectionGroupView(
      kind: jsonSerialization['kind'] == null
          ? null
          : _i2.CharacterSkillSelectionKind.fromJson(
              (jsonSerialization['kind'] as String)),
      selectionCount: jsonSerialization['selectionCount'] as int?,
      classDataId: jsonSerialization['classDataId'] as int?,
      backgroundDataId: jsonSerialization['backgroundDataId'] as int?,
      options: (jsonSerialization['options'] as List?)
          ?.map((e) => _i3.Skill.fromJson((e as String)))
          .toList(),
    );
  }

  _i2.CharacterSkillSelectionKind? kind;

  int? selectionCount;

  int? classDataId;

  int? backgroundDataId;

  List<_i3.Skill>? options;

  /// Returns a shallow copy of this [SkillSelectionGroupView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SkillSelectionGroupView copyWith({
    _i2.CharacterSkillSelectionKind? kind,
    int? selectionCount,
    int? classDataId,
    int? backgroundDataId,
    List<_i3.Skill>? options,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (kind != null) 'kind': kind?.toJson(),
      if (selectionCount != null) 'selectionCount': selectionCount,
      if (classDataId != null) 'classDataId': classDataId,
      if (backgroundDataId != null) 'backgroundDataId': backgroundDataId,
      if (options != null)
        'options': options?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (kind != null) 'kind': kind?.toJson(),
      if (selectionCount != null) 'selectionCount': selectionCount,
      if (classDataId != null) 'classDataId': classDataId,
      if (backgroundDataId != null) 'backgroundDataId': backgroundDataId,
      if (options != null)
        'options': options?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SkillSelectionGroupViewImpl extends SkillSelectionGroupView {
  _SkillSelectionGroupViewImpl({
    _i2.CharacterSkillSelectionKind? kind,
    int? selectionCount,
    int? classDataId,
    int? backgroundDataId,
    List<_i3.Skill>? options,
  }) : super._(
          kind: kind,
          selectionCount: selectionCount,
          classDataId: classDataId,
          backgroundDataId: backgroundDataId,
          options: options,
        );

  /// Returns a shallow copy of this [SkillSelectionGroupView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SkillSelectionGroupView copyWith({
    Object? kind = _Undefined,
    Object? selectionCount = _Undefined,
    Object? classDataId = _Undefined,
    Object? backgroundDataId = _Undefined,
    Object? options = _Undefined,
  }) {
    return SkillSelectionGroupView(
      kind: kind is _i2.CharacterSkillSelectionKind? ? kind : this.kind,
      selectionCount:
          selectionCount is int? ? selectionCount : this.selectionCount,
      classDataId: classDataId is int? ? classDataId : this.classDataId,
      backgroundDataId:
          backgroundDataId is int? ? backgroundDataId : this.backgroundDataId,
      options: options is List<_i3.Skill>?
          ? options
          : this.options?.map((e0) => e0).toList(),
    );
  }
}
