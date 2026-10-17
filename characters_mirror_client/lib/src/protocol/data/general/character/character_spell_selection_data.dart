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
import '../../../data/general/character/character_class_entry_data.dart'
    as _inzx0vvj;
import '../../../data/general/character/spell_selection_replacement_history_data.dart'
    as _iks8679o;
import '../../../data/general/spell_selection_filter_data.dart' as _iv73j5oi;
import '../../../data/spell_data.dart' as _isenpj1r;
import '../../../enums/character_spell_selection_kind.dart' as _ioezer4n;

abstract class CharacterSpellSelectionData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CharacterSpellSelectionData._({
    this.id,
    this.classEntry,
    this.classDataId,
    this.spell,
    this.spellId,
    this.spellKey,
    this.kind,
    this.selectionIndex,
    this.selectionFilter,
    this.selectionRuleLevel,
    this.selectionUnrestricted,
    this.spellReplacementHistory,
    this.updatedAt,
  });

  factory CharacterSpellSelectionData({
    String? id,
    _inzx0vvj.CharacterClassEntryData? classEntry,
    int? classDataId,
    _isenpj1r.SpellData? spell,
    int? spellId,
    String? spellKey,
    _ioezer4n.CharacterSpellSelectionKind? kind,
    int? selectionIndex,
    _iv73j5oi.SpellSelectionFilterData? selectionFilter,
    int? selectionRuleLevel,
    bool? selectionUnrestricted,
    List<_iks8679o.SpellSelectionReplacementHistoryData>?
    spellReplacementHistory,
    DateTime? updatedAt,
  }) = _CharacterSpellSelectionDataImpl;

  factory CharacterSpellSelectionData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterSpellSelectionData(
      id: jsonSerialization['id'] as String?,
      classEntry: jsonSerialization['classEntry'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_inzx0vvj.CharacterClassEntryData>(
              jsonSerialization['classEntry'],
            ),
      classDataId: jsonSerialization['classDataId'] as int?,
      spell: jsonSerialization['spell'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_isenpj1r.SpellData>(
              jsonSerialization['spell'],
            ),
      spellId: jsonSerialization['spellId'] as int?,
      spellKey: jsonSerialization['spellKey'] as String?,
      kind: jsonSerialization['kind'] == null
          ? null
          : _ioezer4n.CharacterSpellSelectionKind.fromJson(
              (jsonSerialization['kind'] as String),
            ),
      selectionIndex: jsonSerialization['selectionIndex'] as int?,
      selectionFilter: jsonSerialization['selectionFilter'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<_iv73j5oi.SpellSelectionFilterData>(
                  jsonSerialization['selectionFilter'],
                ),
      selectionRuleLevel: jsonSerialization['selectionRuleLevel'] as int?,
      selectionUnrestricted: jsonSerialization['selectionUnrestricted'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['selectionUnrestricted'],
            ),
      spellReplacementHistory:
          jsonSerialization['spellReplacementHistory'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<
              List<_iks8679o.SpellSelectionReplacementHistoryData>
            >(jsonSerialization['spellReplacementHistory']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  String? id;

  _inzx0vvj.CharacterClassEntryData? classEntry;

  int? classDataId;

  _isenpj1r.SpellData? spell;

  int? spellId;

  String? spellKey;

  _ioezer4n.CharacterSpellSelectionKind? kind;

  int? selectionIndex;

  _iv73j5oi.SpellSelectionFilterData? selectionFilter;

  int? selectionRuleLevel;

  bool? selectionUnrestricted;

  List<_iks8679o.SpellSelectionReplacementHistoryData>? spellReplacementHistory;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [CharacterSpellSelectionData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CharacterSpellSelectionData copyWith({
    String? id,
    _inzx0vvj.CharacterClassEntryData? classEntry,
    int? classDataId,
    _isenpj1r.SpellData? spell,
    int? spellId,
    String? spellKey,
    _ioezer4n.CharacterSpellSelectionKind? kind,
    int? selectionIndex,
    _iv73j5oi.SpellSelectionFilterData? selectionFilter,
    int? selectionRuleLevel,
    bool? selectionUnrestricted,
    List<_iks8679o.SpellSelectionReplacementHistoryData>?
    spellReplacementHistory,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterSpellSelectionData',
      if (id != null) 'id': id,
      if (classEntry != null) 'classEntry': classEntry?.toJson(),
      if (classDataId != null) 'classDataId': classDataId,
      if (spell != null) 'spell': spell?.toJson(),
      if (spellId != null) 'spellId': spellId,
      if (spellKey != null) 'spellKey': spellKey,
      if (kind != null) 'kind': kind?.toJson(),
      if (selectionIndex != null) 'selectionIndex': selectionIndex,
      if (selectionFilter != null) 'selectionFilter': selectionFilter?.toJson(),
      if (selectionRuleLevel != null) 'selectionRuleLevel': selectionRuleLevel,
      if (selectionUnrestricted != null)
        'selectionUnrestricted': selectionUnrestricted,
      if (spellReplacementHistory != null)
        'spellReplacementHistory': spellReplacementHistory?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CharacterSpellSelectionData',
      if (id != null) 'id': id,
      if (classEntry != null) 'classEntry': classEntry?.toJsonForProtocol(),
      if (classDataId != null) 'classDataId': classDataId,
      if (spell != null) 'spell': spell?.toJsonForProtocol(),
      if (spellId != null) 'spellId': spellId,
      if (spellKey != null) 'spellKey': spellKey,
      if (kind != null) 'kind': kind?.toJson(),
      if (selectionIndex != null) 'selectionIndex': selectionIndex,
      if (selectionFilter != null)
        'selectionFilter': selectionFilter?.toJsonForProtocol(),
      if (selectionRuleLevel != null) 'selectionRuleLevel': selectionRuleLevel,
      if (selectionUnrestricted != null)
        'selectionUnrestricted': selectionUnrestricted,
      if (spellReplacementHistory != null)
        'spellReplacementHistory': spellReplacementHistory?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSpellSelectionDataImpl extends CharacterSpellSelectionData {
  _CharacterSpellSelectionDataImpl({
    String? id,
    _inzx0vvj.CharacterClassEntryData? classEntry,
    int? classDataId,
    _isenpj1r.SpellData? spell,
    int? spellId,
    String? spellKey,
    _ioezer4n.CharacterSpellSelectionKind? kind,
    int? selectionIndex,
    _iv73j5oi.SpellSelectionFilterData? selectionFilter,
    int? selectionRuleLevel,
    bool? selectionUnrestricted,
    List<_iks8679o.SpellSelectionReplacementHistoryData>?
    spellReplacementHistory,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         classEntry: classEntry,
         classDataId: classDataId,
         spell: spell,
         spellId: spellId,
         spellKey: spellKey,
         kind: kind,
         selectionIndex: selectionIndex,
         selectionFilter: selectionFilter,
         selectionRuleLevel: selectionRuleLevel,
         selectionUnrestricted: selectionUnrestricted,
         spellReplacementHistory: spellReplacementHistory,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CharacterSpellSelectionData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CharacterSpellSelectionData copyWith({
    Object? id = _Undefined,
    Object? classEntry = _Undefined,
    Object? classDataId = _Undefined,
    Object? spell = _Undefined,
    Object? spellId = _Undefined,
    Object? spellKey = _Undefined,
    Object? kind = _Undefined,
    Object? selectionIndex = _Undefined,
    Object? selectionFilter = _Undefined,
    Object? selectionRuleLevel = _Undefined,
    Object? selectionUnrestricted = _Undefined,
    Object? spellReplacementHistory = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return CharacterSpellSelectionData(
      id: id is String? ? id : this.id,
      classEntry: classEntry is _inzx0vvj.CharacterClassEntryData?
          ? classEntry
          : this.classEntry?.copyWith(),
      classDataId: classDataId is int? ? classDataId : this.classDataId,
      spell: spell is _isenpj1r.SpellData? ? spell : this.spell?.copyWith(),
      spellId: spellId is int? ? spellId : this.spellId,
      spellKey: spellKey is String? ? spellKey : this.spellKey,
      kind: kind is _ioezer4n.CharacterSpellSelectionKind? ? kind : this.kind,
      selectionIndex: selectionIndex is int?
          ? selectionIndex
          : this.selectionIndex,
      selectionFilter: selectionFilter is _iv73j5oi.SpellSelectionFilterData?
          ? selectionFilter
          : this.selectionFilter?.copyWith(),
      selectionRuleLevel: selectionRuleLevel is int?
          ? selectionRuleLevel
          : this.selectionRuleLevel,
      selectionUnrestricted: selectionUnrestricted is bool?
          ? selectionUnrestricted
          : this.selectionUnrestricted,
      spellReplacementHistory:
          spellReplacementHistory
              is List<_iks8679o.SpellSelectionReplacementHistoryData>?
          ? spellReplacementHistory
          : this.spellReplacementHistory?.map((e0) => e0.copyWith()).toList(),
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
