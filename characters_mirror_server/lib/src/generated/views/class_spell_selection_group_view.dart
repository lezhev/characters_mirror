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
import '../enums/character_spell_selection_kind.dart' as _i2;
import '../data/spell_data.dart' as _i3;

abstract class ClassSpellSelectionGroupView
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ClassSpellSelectionGroupView._({
    this.kind,
    this.selectionCount,
    this.classDataId,
    this.classLevel,
    this.options,
  });

  factory ClassSpellSelectionGroupView({
    _i2.CharacterSpellSelectionKind? kind,
    int? selectionCount,
    int? classDataId,
    int? classLevel,
    List<_i3.SpellData>? options,
  }) = _ClassSpellSelectionGroupViewImpl;

  factory ClassSpellSelectionGroupView.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ClassSpellSelectionGroupView(
      kind: jsonSerialization['kind'] == null
          ? null
          : _i2.CharacterSpellSelectionKind.fromJson(
              (jsonSerialization['kind'] as String)),
      selectionCount: jsonSerialization['selectionCount'] as int?,
      classDataId: jsonSerialization['classDataId'] as int?,
      classLevel: jsonSerialization['classLevel'] as int?,
      options: (jsonSerialization['options'] as List?)
          ?.map((e) => _i3.SpellData.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  _i2.CharacterSpellSelectionKind? kind;

  int? selectionCount;

  int? classDataId;

  int? classLevel;

  List<_i3.SpellData>? options;

  /// Returns a shallow copy of this [ClassSpellSelectionGroupView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassSpellSelectionGroupView copyWith({
    _i2.CharacterSpellSelectionKind? kind,
    int? selectionCount,
    int? classDataId,
    int? classLevel,
    List<_i3.SpellData>? options,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (kind != null) 'kind': kind?.toJson(),
      if (selectionCount != null) 'selectionCount': selectionCount,
      if (classDataId != null) 'classDataId': classDataId,
      if (classLevel != null) 'classLevel': classLevel,
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
      if (classLevel != null) 'classLevel': classLevel,
      if (options != null)
        'options': options?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassSpellSelectionGroupViewImpl extends ClassSpellSelectionGroupView {
  _ClassSpellSelectionGroupViewImpl({
    _i2.CharacterSpellSelectionKind? kind,
    int? selectionCount,
    int? classDataId,
    int? classLevel,
    List<_i3.SpellData>? options,
  }) : super._(
          kind: kind,
          selectionCount: selectionCount,
          classDataId: classDataId,
          classLevel: classLevel,
          options: options,
        );

  /// Returns a shallow copy of this [ClassSpellSelectionGroupView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassSpellSelectionGroupView copyWith({
    Object? kind = _Undefined,
    Object? selectionCount = _Undefined,
    Object? classDataId = _Undefined,
    Object? classLevel = _Undefined,
    Object? options = _Undefined,
  }) {
    return ClassSpellSelectionGroupView(
      kind: kind is _i2.CharacterSpellSelectionKind? ? kind : this.kind,
      selectionCount:
          selectionCount is int? ? selectionCount : this.selectionCount,
      classDataId: classDataId is int? ? classDataId : this.classDataId,
      classLevel: classLevel is int? ? classLevel : this.classLevel,
      options: options is List<_i3.SpellData>?
          ? options
          : this.options?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
