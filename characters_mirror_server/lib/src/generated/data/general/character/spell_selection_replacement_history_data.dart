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
import '../../../data/general/spell_selection_filter_data.dart' as _iv73j5oi;

abstract class SpellSelectionReplacementHistoryData
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SpellSelectionReplacementHistoryData._({
    this.spellId,
    this.spellKey,
    this.selectionFilter,
    this.selectionRuleLevel,
    this.selectionUnrestricted,
    required this.replacedAtClassLevel,
  });

  factory SpellSelectionReplacementHistoryData({
    int? spellId,
    String? spellKey,
    _iv73j5oi.SpellSelectionFilterData? selectionFilter,
    int? selectionRuleLevel,
    bool? selectionUnrestricted,
    required int replacedAtClassLevel,
  }) = _SpellSelectionReplacementHistoryDataImpl;

  factory SpellSelectionReplacementHistoryData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SpellSelectionReplacementHistoryData(
      spellId: jsonSerialization['spellId'] as int?,
      spellKey: jsonSerialization['spellKey'] as String?,
      selectionFilter: jsonSerialization['selectionFilter'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_iv73j5oi.SpellSelectionFilterData>(
                  jsonSerialization['selectionFilter'],
                ),
      selectionRuleLevel: jsonSerialization['selectionRuleLevel'] as int?,
      selectionUnrestricted: jsonSerialization['selectionUnrestricted'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['selectionUnrestricted'],
            ),
      replacedAtClassLevel: jsonSerialization['replacedAtClassLevel'] as int,
    );
  }

  int? spellId;

  String? spellKey;

  _iv73j5oi.SpellSelectionFilterData? selectionFilter;

  int? selectionRuleLevel;

  bool? selectionUnrestricted;

  int replacedAtClassLevel;

  /// Returns a shallow copy of this [SpellSelectionReplacementHistoryData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SpellSelectionReplacementHistoryData copyWith({
    int? spellId,
    String? spellKey,
    _iv73j5oi.SpellSelectionFilterData? selectionFilter,
    int? selectionRuleLevel,
    bool? selectionUnrestricted,
    int? replacedAtClassLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SpellSelectionReplacementHistoryData',
      if (spellId != null) 'spellId': spellId,
      if (spellKey != null) 'spellKey': spellKey,
      if (selectionFilter != null) 'selectionFilter': selectionFilter?.toJson(),
      if (selectionRuleLevel != null) 'selectionRuleLevel': selectionRuleLevel,
      if (selectionUnrestricted != null)
        'selectionUnrestricted': selectionUnrestricted,
      'replacedAtClassLevel': replacedAtClassLevel,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SpellSelectionReplacementHistoryData',
      if (spellId != null) 'spellId': spellId,
      if (spellKey != null) 'spellKey': spellKey,
      if (selectionFilter != null)
        'selectionFilter': selectionFilter?.toJsonForProtocol(),
      if (selectionRuleLevel != null) 'selectionRuleLevel': selectionRuleLevel,
      if (selectionUnrestricted != null)
        'selectionUnrestricted': selectionUnrestricted,
      'replacedAtClassLevel': replacedAtClassLevel,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpellSelectionReplacementHistoryDataImpl
    extends SpellSelectionReplacementHistoryData {
  _SpellSelectionReplacementHistoryDataImpl({
    int? spellId,
    String? spellKey,
    _iv73j5oi.SpellSelectionFilterData? selectionFilter,
    int? selectionRuleLevel,
    bool? selectionUnrestricted,
    required int replacedAtClassLevel,
  }) : super._(
         spellId: spellId,
         spellKey: spellKey,
         selectionFilter: selectionFilter,
         selectionRuleLevel: selectionRuleLevel,
         selectionUnrestricted: selectionUnrestricted,
         replacedAtClassLevel: replacedAtClassLevel,
       );

  /// Returns a shallow copy of this [SpellSelectionReplacementHistoryData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SpellSelectionReplacementHistoryData copyWith({
    Object? spellId = _Undefined,
    Object? spellKey = _Undefined,
    Object? selectionFilter = _Undefined,
    Object? selectionRuleLevel = _Undefined,
    Object? selectionUnrestricted = _Undefined,
    int? replacedAtClassLevel,
  }) {
    return SpellSelectionReplacementHistoryData(
      spellId: spellId is int? ? spellId : this.spellId,
      spellKey: spellKey is String? ? spellKey : this.spellKey,
      selectionFilter: selectionFilter is _iv73j5oi.SpellSelectionFilterData?
          ? selectionFilter
          : this.selectionFilter?.copyWith(),
      selectionRuleLevel: selectionRuleLevel is int?
          ? selectionRuleLevel
          : this.selectionRuleLevel,
      selectionUnrestricted: selectionUnrestricted is bool?
          ? selectionUnrestricted
          : this.selectionUnrestricted,
      replacedAtClassLevel: replacedAtClassLevel ?? this.replacedAtClassLevel,
    );
  }
}
