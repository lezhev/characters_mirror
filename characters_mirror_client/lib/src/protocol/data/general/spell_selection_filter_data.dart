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
import '../../enums/character_spell_selection_kind.dart' as _icuuceor;
import '../../enums/spell/spell_school.dart' as _iusxccb8;

abstract class SpellSelectionFilterData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SpellSelectionFilterData._({
    this.spellListClassKey,
    this.minimumSpellLevel,
    this.maximumSpellLevel,
    this.schools,
    this.kinds,
    this.unrestrictedChoicesByLevel,
  });

  factory SpellSelectionFilterData({
    String? spellListClassKey,
    int? minimumSpellLevel,
    int? maximumSpellLevel,
    List<_iusxccb8.SpellSchool>? schools,
    List<_icuuceor.CharacterSpellSelectionKind>? kinds,
    Map<int, int>? unrestrictedChoicesByLevel,
  }) = _SpellSelectionFilterDataImpl;

  factory SpellSelectionFilterData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SpellSelectionFilterData(
      spellListClassKey: jsonSerialization['spellListClassKey'] as String?,
      minimumSpellLevel: jsonSerialization['minimumSpellLevel'] as int?,
      maximumSpellLevel: jsonSerialization['maximumSpellLevel'] as int?,
      schools: jsonSerialization['schools'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_iusxccb8.SpellSchool>>(
              jsonSerialization['schools'],
            ),
      kinds: jsonSerialization['kinds'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_icuuceor.CharacterSpellSelectionKind>>(
                  jsonSerialization['kinds'],
                ),
      unrestrictedChoicesByLevel:
          jsonSerialization['unrestrictedChoicesByLevel'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<Map<int, int>>(
              jsonSerialization['unrestrictedChoicesByLevel'],
            ),
    );
  }

  String? spellListClassKey;

  int? minimumSpellLevel;

  int? maximumSpellLevel;

  List<_iusxccb8.SpellSchool>? schools;

  List<_icuuceor.CharacterSpellSelectionKind>? kinds;

  Map<int, int>? unrestrictedChoicesByLevel;

  /// Returns a shallow copy of this [SpellSelectionFilterData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SpellSelectionFilterData copyWith({
    String? spellListClassKey,
    int? minimumSpellLevel,
    int? maximumSpellLevel,
    List<_iusxccb8.SpellSchool>? schools,
    List<_icuuceor.CharacterSpellSelectionKind>? kinds,
    Map<int, int>? unrestrictedChoicesByLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SpellSelectionFilterData',
      if (spellListClassKey != null) 'spellListClassKey': spellListClassKey,
      if (minimumSpellLevel != null) 'minimumSpellLevel': minimumSpellLevel,
      if (maximumSpellLevel != null) 'maximumSpellLevel': maximumSpellLevel,
      if (schools != null)
        'schools': schools?.toJson(valueToJson: (v) => v.toJson()),
      if (kinds != null) 'kinds': kinds?.toJson(valueToJson: (v) => v.toJson()),
      if (unrestrictedChoicesByLevel != null)
        'unrestrictedChoicesByLevel': unrestrictedChoicesByLevel?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SpellSelectionFilterData',
      if (spellListClassKey != null) 'spellListClassKey': spellListClassKey,
      if (minimumSpellLevel != null) 'minimumSpellLevel': minimumSpellLevel,
      if (maximumSpellLevel != null) 'maximumSpellLevel': maximumSpellLevel,
      if (schools != null)
        'schools': schools?.toJson(valueToJson: (v) => v.toJson()),
      if (kinds != null) 'kinds': kinds?.toJson(valueToJson: (v) => v.toJson()),
      if (unrestrictedChoicesByLevel != null)
        'unrestrictedChoicesByLevel': unrestrictedChoicesByLevel?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpellSelectionFilterDataImpl extends SpellSelectionFilterData {
  _SpellSelectionFilterDataImpl({
    String? spellListClassKey,
    int? minimumSpellLevel,
    int? maximumSpellLevel,
    List<_iusxccb8.SpellSchool>? schools,
    List<_icuuceor.CharacterSpellSelectionKind>? kinds,
    Map<int, int>? unrestrictedChoicesByLevel,
  }) : super._(
         spellListClassKey: spellListClassKey,
         minimumSpellLevel: minimumSpellLevel,
         maximumSpellLevel: maximumSpellLevel,
         schools: schools,
         kinds: kinds,
         unrestrictedChoicesByLevel: unrestrictedChoicesByLevel,
       );

  /// Returns a shallow copy of this [SpellSelectionFilterData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SpellSelectionFilterData copyWith({
    Object? spellListClassKey = _Undefined,
    Object? minimumSpellLevel = _Undefined,
    Object? maximumSpellLevel = _Undefined,
    Object? schools = _Undefined,
    Object? kinds = _Undefined,
    Object? unrestrictedChoicesByLevel = _Undefined,
  }) {
    return SpellSelectionFilterData(
      spellListClassKey: spellListClassKey is String?
          ? spellListClassKey
          : this.spellListClassKey,
      minimumSpellLevel: minimumSpellLevel is int?
          ? minimumSpellLevel
          : this.minimumSpellLevel,
      maximumSpellLevel: maximumSpellLevel is int?
          ? maximumSpellLevel
          : this.maximumSpellLevel,
      schools: schools is List<_iusxccb8.SpellSchool>?
          ? schools
          : this.schools?.map((e0) => e0).toList(),
      kinds: kinds is List<_icuuceor.CharacterSpellSelectionKind>?
          ? kinds
          : this.kinds?.map((e0) => e0).toList(),
      unrestrictedChoicesByLevel: unrestrictedChoicesByLevel is Map<int, int>?
          ? unrestrictedChoicesByLevel
          : this.unrestrictedChoicesByLevel?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
    );
  }
}
