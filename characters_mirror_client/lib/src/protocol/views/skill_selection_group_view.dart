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
import '../enums/character_skill_selection_kind.dart' as _i4at49vy;
import '../enums/skill.dart' as _ic5go03x;

abstract class SkillSelectionGroupView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SkillSelectionGroupView._({
    this.kind,
    this.selectionCount,
    this.classDataId,
    this.backgroundDataId,
    this.options,
  });

  factory SkillSelectionGroupView({
    _i4at49vy.CharacterSkillSelectionKind? kind,
    int? selectionCount,
    int? classDataId,
    int? backgroundDataId,
    List<_ic5go03x.Skill>? options,
  }) = _SkillSelectionGroupViewImpl;

  factory SkillSelectionGroupView.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SkillSelectionGroupView(
      kind: jsonSerialization['kind'] == null
          ? null
          : _i4at49vy.CharacterSkillSelectionKind.fromJson(
              (jsonSerialization['kind'] as String),
            ),
      selectionCount: jsonSerialization['selectionCount'] as int?,
      classDataId: jsonSerialization['classDataId'] as int?,
      backgroundDataId: jsonSerialization['backgroundDataId'] as int?,
      options: jsonSerialization['options'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_ic5go03x.Skill>>(
              jsonSerialization['options'],
            ),
    );
  }

  _i4at49vy.CharacterSkillSelectionKind? kind;

  int? selectionCount;

  int? classDataId;

  int? backgroundDataId;

  List<_ic5go03x.Skill>? options;

  /// Returns a shallow copy of this [SkillSelectionGroupView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SkillSelectionGroupView copyWith({
    _i4at49vy.CharacterSkillSelectionKind? kind,
    int? selectionCount,
    int? classDataId,
    int? backgroundDataId,
    List<_ic5go03x.Skill>? options,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SkillSelectionGroupView',
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
      '__className__': 'SkillSelectionGroupView',
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
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SkillSelectionGroupViewImpl extends SkillSelectionGroupView {
  _SkillSelectionGroupViewImpl({
    _i4at49vy.CharacterSkillSelectionKind? kind,
    int? selectionCount,
    int? classDataId,
    int? backgroundDataId,
    List<_ic5go03x.Skill>? options,
  }) : super._(
         kind: kind,
         selectionCount: selectionCount,
         classDataId: classDataId,
         backgroundDataId: backgroundDataId,
         options: options,
       );

  /// Returns a shallow copy of this [SkillSelectionGroupView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SkillSelectionGroupView copyWith({
    Object? kind = _Undefined,
    Object? selectionCount = _Undefined,
    Object? classDataId = _Undefined,
    Object? backgroundDataId = _Undefined,
    Object? options = _Undefined,
  }) {
    return SkillSelectionGroupView(
      kind: kind is _i4at49vy.CharacterSkillSelectionKind? ? kind : this.kind,
      selectionCount: selectionCount is int?
          ? selectionCount
          : this.selectionCount,
      classDataId: classDataId is int? ? classDataId : this.classDataId,
      backgroundDataId: backgroundDataId is int?
          ? backgroundDataId
          : this.backgroundDataId,
      options: options is List<_ic5go03x.Skill>?
          ? options
          : this.options?.map((e0) => e0).toList(),
    );
  }
}
