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
import '../data/general/spell_selection_filter_data.dart' as _iebyih8m;
import '../data/spell_data.dart' as _iavpgfjb;
import '../enums/character_spell_selection_kind.dart' as _i7flvdu3;

abstract class ClassSpellSelectionGroupView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ClassSpellSelectionGroupView._({
    this.selectionFilter,
    this.unrestrictedSelectionCount,
    this.kind,
    this.optionSourceSelectionKind,
    this.selectionCount,
    this.classDataId,
    this.classLevel,
    this.options,
  });

  factory ClassSpellSelectionGroupView({
    _iebyih8m.SpellSelectionFilterData? selectionFilter,
    int? unrestrictedSelectionCount,
    _i7flvdu3.CharacterSpellSelectionKind? kind,
    _i7flvdu3.CharacterSpellSelectionKind? optionSourceSelectionKind,
    int? selectionCount,
    int? classDataId,
    int? classLevel,
    List<_iavpgfjb.SpellData>? options,
  }) = _ClassSpellSelectionGroupViewImpl;

  factory ClassSpellSelectionGroupView.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ClassSpellSelectionGroupView(
      selectionFilter: jsonSerialization['selectionFilter'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<_iebyih8m.SpellSelectionFilterData>(
                  jsonSerialization['selectionFilter'],
                ),
      unrestrictedSelectionCount:
          jsonSerialization['unrestrictedSelectionCount'] as int?,
      kind: jsonSerialization['kind'] == null
          ? null
          : _i7flvdu3.CharacterSpellSelectionKind.fromJson(
              (jsonSerialization['kind'] as String),
            ),
      optionSourceSelectionKind:
          jsonSerialization['optionSourceSelectionKind'] == null
          ? null
          : _i7flvdu3.CharacterSpellSelectionKind.fromJson(
              (jsonSerialization['optionSourceSelectionKind'] as String),
            ),
      selectionCount: jsonSerialization['selectionCount'] as int?,
      classDataId: jsonSerialization['classDataId'] as int?,
      classLevel: jsonSerialization['classLevel'] as int?,
      options: jsonSerialization['options'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_iavpgfjb.SpellData>>(
              jsonSerialization['options'],
            ),
    );
  }

  _iebyih8m.SpellSelectionFilterData? selectionFilter;

  int? unrestrictedSelectionCount;

  _i7flvdu3.CharacterSpellSelectionKind? kind;

  _i7flvdu3.CharacterSpellSelectionKind? optionSourceSelectionKind;

  int? selectionCount;

  int? classDataId;

  int? classLevel;

  List<_iavpgfjb.SpellData>? options;

  /// Returns a shallow copy of this [ClassSpellSelectionGroupView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ClassSpellSelectionGroupView copyWith({
    _iebyih8m.SpellSelectionFilterData? selectionFilter,
    int? unrestrictedSelectionCount,
    _i7flvdu3.CharacterSpellSelectionKind? kind,
    _i7flvdu3.CharacterSpellSelectionKind? optionSourceSelectionKind,
    int? selectionCount,
    int? classDataId,
    int? classLevel,
    List<_iavpgfjb.SpellData>? options,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClassSpellSelectionGroupView',
      if (selectionFilter != null) 'selectionFilter': selectionFilter?.toJson(),
      if (unrestrictedSelectionCount != null)
        'unrestrictedSelectionCount': unrestrictedSelectionCount,
      if (kind != null) 'kind': kind?.toJson(),
      if (optionSourceSelectionKind != null)
        'optionSourceSelectionKind': optionSourceSelectionKind?.toJson(),
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
      '__className__': 'ClassSpellSelectionGroupView',
      if (selectionFilter != null)
        'selectionFilter': selectionFilter?.toJsonForProtocol(),
      if (unrestrictedSelectionCount != null)
        'unrestrictedSelectionCount': unrestrictedSelectionCount,
      if (kind != null) 'kind': kind?.toJson(),
      if (optionSourceSelectionKind != null)
        'optionSourceSelectionKind': optionSourceSelectionKind?.toJson(),
      if (selectionCount != null) 'selectionCount': selectionCount,
      if (classDataId != null) 'classDataId': classDataId,
      if (classLevel != null) 'classLevel': classLevel,
      if (options != null)
        'options': options?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassSpellSelectionGroupViewImpl extends ClassSpellSelectionGroupView {
  _ClassSpellSelectionGroupViewImpl({
    _iebyih8m.SpellSelectionFilterData? selectionFilter,
    int? unrestrictedSelectionCount,
    _i7flvdu3.CharacterSpellSelectionKind? kind,
    _i7flvdu3.CharacterSpellSelectionKind? optionSourceSelectionKind,
    int? selectionCount,
    int? classDataId,
    int? classLevel,
    List<_iavpgfjb.SpellData>? options,
  }) : super._(
         selectionFilter: selectionFilter,
         unrestrictedSelectionCount: unrestrictedSelectionCount,
         kind: kind,
         optionSourceSelectionKind: optionSourceSelectionKind,
         selectionCount: selectionCount,
         classDataId: classDataId,
         classLevel: classLevel,
         options: options,
       );

  /// Returns a shallow copy of this [ClassSpellSelectionGroupView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ClassSpellSelectionGroupView copyWith({
    Object? selectionFilter = _Undefined,
    Object? unrestrictedSelectionCount = _Undefined,
    Object? kind = _Undefined,
    Object? optionSourceSelectionKind = _Undefined,
    Object? selectionCount = _Undefined,
    Object? classDataId = _Undefined,
    Object? classLevel = _Undefined,
    Object? options = _Undefined,
  }) {
    return ClassSpellSelectionGroupView(
      selectionFilter: selectionFilter is _iebyih8m.SpellSelectionFilterData?
          ? selectionFilter
          : this.selectionFilter?.copyWith(),
      unrestrictedSelectionCount: unrestrictedSelectionCount is int?
          ? unrestrictedSelectionCount
          : this.unrestrictedSelectionCount,
      kind: kind is _i7flvdu3.CharacterSpellSelectionKind? ? kind : this.kind,
      optionSourceSelectionKind:
          optionSourceSelectionKind is _i7flvdu3.CharacterSpellSelectionKind?
          ? optionSourceSelectionKind
          : this.optionSourceSelectionKind,
      selectionCount: selectionCount is int?
          ? selectionCount
          : this.selectionCount,
      classDataId: classDataId is int? ? classDataId : this.classDataId,
      classLevel: classLevel is int? ? classLevel : this.classLevel,
      options: options is List<_iavpgfjb.SpellData>?
          ? options
          : this.options?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
