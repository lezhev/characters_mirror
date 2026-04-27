/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../../data/general/character/character_class_entry_data.dart' as _i2;
import '../../../data/spell_data.dart' as _i3;
import '../../../enums/character_spell_selection_kind.dart' as _i4;

abstract class CharacterSpellSelectionData implements _i1.SerializableModel {
  CharacterSpellSelectionData._({
    this.id,
    this.classEntry,
    this.classDataId,
    this.spell,
    this.spellId,
    this.spellKey,
    this.kind,
    this.selectionIndex,
    this.updatedAt,
  });

  factory CharacterSpellSelectionData({
    String? id,
    _i2.CharacterClassEntryData? classEntry,
    int? classDataId,
    _i3.SpellData? spell,
    int? spellId,
    String? spellKey,
    _i4.CharacterSpellSelectionKind? kind,
    int? selectionIndex,
    DateTime? updatedAt,
  }) = _CharacterSpellSelectionDataImpl;

  factory CharacterSpellSelectionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterSpellSelectionData(
      id: jsonSerialization['id'] as String?,
      classEntry: jsonSerialization['classEntry'] == null
          ? null
          : _i2.CharacterClassEntryData.fromJson(
              (jsonSerialization['classEntry'] as Map<String, dynamic>)),
      classDataId: jsonSerialization['classDataId'] as int?,
      spell: jsonSerialization['spell'] == null
          ? null
          : _i3.SpellData.fromJson(
              (jsonSerialization['spell'] as Map<String, dynamic>)),
      spellId: jsonSerialization['spellId'] as int?,
      spellKey: jsonSerialization['spellKey'] as String?,
      kind: jsonSerialization['kind'] == null
          ? null
          : _i4.CharacterSpellSelectionKind.fromJson(
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

  _i3.SpellData? spell;

  int? spellId;

  String? spellKey;

  _i4.CharacterSpellSelectionKind? kind;

  int? selectionIndex;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [CharacterSpellSelectionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterSpellSelectionData copyWith({
    String? id,
    _i2.CharacterClassEntryData? classEntry,
    int? classDataId,
    _i3.SpellData? spell,
    int? spellId,
    String? spellKey,
    _i4.CharacterSpellSelectionKind? kind,
    int? selectionIndex,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (classEntry != null) 'classEntry': classEntry?.toJson(),
      if (classDataId != null) 'classDataId': classDataId,
      if (spell != null) 'spell': spell?.toJson(),
      if (spellId != null) 'spellId': spellId,
      if (spellKey != null) 'spellKey': spellKey,
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

class _CharacterSpellSelectionDataImpl extends CharacterSpellSelectionData {
  _CharacterSpellSelectionDataImpl({
    String? id,
    _i2.CharacterClassEntryData? classEntry,
    int? classDataId,
    _i3.SpellData? spell,
    int? spellId,
    String? spellKey,
    _i4.CharacterSpellSelectionKind? kind,
    int? selectionIndex,
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
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [CharacterSpellSelectionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
    Object? updatedAt = _Undefined,
  }) {
    return CharacterSpellSelectionData(
      id: id is String? ? id : this.id,
      classEntry: classEntry is _i2.CharacterClassEntryData?
          ? classEntry
          : this.classEntry?.copyWith(),
      classDataId: classDataId is int? ? classDataId : this.classDataId,
      spell: spell is _i3.SpellData? ? spell : this.spell?.copyWith(),
      spellId: spellId is int? ? spellId : this.spellId,
      spellKey: spellKey is String? ? spellKey : this.spellKey,
      kind: kind is _i4.CharacterSpellSelectionKind? ? kind : this.kind,
      selectionIndex:
          selectionIndex is int? ? selectionIndex : this.selectionIndex,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
