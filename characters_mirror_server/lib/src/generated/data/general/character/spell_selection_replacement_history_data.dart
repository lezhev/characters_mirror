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
import '../../../data/general/spell_selection_filter_data.dart' as _i2;

abstract class SpellSelectionReplacementHistoryData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
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
    _i2.SpellSelectionFilterData? selectionFilter,
    int? selectionRuleLevel,
    bool? selectionUnrestricted,
    required int replacedAtClassLevel,
  }) = _SpellSelectionReplacementHistoryDataImpl;

  factory SpellSelectionReplacementHistoryData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SpellSelectionReplacementHistoryData(
      spellId: jsonSerialization['spellId'] as int?,
      spellKey: jsonSerialization['spellKey'] as String?,
      selectionFilter: jsonSerialization['selectionFilter'] == null
          ? null
          : _i2.SpellSelectionFilterData.fromJson(
              (jsonSerialization['selectionFilter'] as Map<String, dynamic>)),
      selectionRuleLevel: jsonSerialization['selectionRuleLevel'] as int?,
      selectionUnrestricted:
          jsonSerialization['selectionUnrestricted'] as bool?,
      replacedAtClassLevel: jsonSerialization['replacedAtClassLevel'] as int,
    );
  }

  int? spellId;

  String? spellKey;

  _i2.SpellSelectionFilterData? selectionFilter;

  int? selectionRuleLevel;

  bool? selectionUnrestricted;

  int replacedAtClassLevel;

  /// Returns a shallow copy of this [SpellSelectionReplacementHistoryData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SpellSelectionReplacementHistoryData copyWith({
    int? spellId,
    String? spellKey,
    _i2.SpellSelectionFilterData? selectionFilter,
    int? selectionRuleLevel,
    bool? selectionUnrestricted,
    int? replacedAtClassLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
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
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpellSelectionReplacementHistoryDataImpl
    extends SpellSelectionReplacementHistoryData {
  _SpellSelectionReplacementHistoryDataImpl({
    int? spellId,
    String? spellKey,
    _i2.SpellSelectionFilterData? selectionFilter,
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
  @_i1.useResult
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
      selectionFilter: selectionFilter is _i2.SpellSelectionFilterData?
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
