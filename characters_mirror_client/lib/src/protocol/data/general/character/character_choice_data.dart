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
import '../../../data/general/character/character_data.dart' as _i2;
import '../../../data/general/character/character_class_entry_data.dart' as _i3;
import '../../../enums/choice_source_type.dart' as _i4;

abstract class CharacterChoiceData implements _i1.SerializableModel {
  CharacterChoiceData._({
    this.id,
    required this.characterId,
    this.character,
    this.classEntryId,
    this.classEntry,
    this.sourceType,
    this.sourceId,
    this.groupKey,
    this.optionKey,
    this.selectedSpellKey,
    this.selectedItemKey,
    this.selectedText,
    this.selectedCount,
  });

  factory CharacterChoiceData({
    int? id,
    required int characterId,
    _i2.CharacterData? character,
    int? classEntryId,
    _i3.CharacterClassEntryData? classEntry,
    _i4.ChoiceSourceType? sourceType,
    int? sourceId,
    String? groupKey,
    String? optionKey,
    String? selectedSpellKey,
    String? selectedItemKey,
    String? selectedText,
    int? selectedCount,
  }) = _CharacterChoiceDataImpl;

  factory CharacterChoiceData.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterChoiceData(
      id: jsonSerialization['id'] as int?,
      characterId: jsonSerialization['characterId'] as int,
      character: jsonSerialization['character'] == null
          ? null
          : _i2.CharacterData.fromJson(
              (jsonSerialization['character'] as Map<String, dynamic>)),
      classEntryId: jsonSerialization['classEntryId'] as int?,
      classEntry: jsonSerialization['classEntry'] == null
          ? null
          : _i3.CharacterClassEntryData.fromJson(
              (jsonSerialization['classEntry'] as Map<String, dynamic>)),
      sourceType: jsonSerialization['sourceType'] == null
          ? null
          : _i4.ChoiceSourceType.fromJson(
              (jsonSerialization['sourceType'] as String)),
      sourceId: jsonSerialization['sourceId'] as int?,
      groupKey: jsonSerialization['groupKey'] as String?,
      optionKey: jsonSerialization['optionKey'] as String?,
      selectedSpellKey: jsonSerialization['selectedSpellKey'] as String?,
      selectedItemKey: jsonSerialization['selectedItemKey'] as String?,
      selectedText: jsonSerialization['selectedText'] as String?,
      selectedCount: jsonSerialization['selectedCount'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int characterId;

  _i2.CharacterData? character;

  int? classEntryId;

  _i3.CharacterClassEntryData? classEntry;

  _i4.ChoiceSourceType? sourceType;

  int? sourceId;

  String? groupKey;

  String? optionKey;

  String? selectedSpellKey;

  String? selectedItemKey;

  String? selectedText;

  int? selectedCount;

  /// Returns a shallow copy of this [CharacterChoiceData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterChoiceData copyWith({
    int? id,
    int? characterId,
    _i2.CharacterData? character,
    int? classEntryId,
    _i3.CharacterClassEntryData? classEntry,
    _i4.ChoiceSourceType? sourceType,
    int? sourceId,
    String? groupKey,
    String? optionKey,
    String? selectedSpellKey,
    String? selectedItemKey,
    String? selectedText,
    int? selectedCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'characterId': characterId,
      if (character != null) 'character': character?.toJson(),
      if (classEntryId != null) 'classEntryId': classEntryId,
      if (classEntry != null) 'classEntry': classEntry?.toJson(),
      if (sourceType != null) 'sourceType': sourceType?.toJson(),
      if (sourceId != null) 'sourceId': sourceId,
      if (groupKey != null) 'groupKey': groupKey,
      if (optionKey != null) 'optionKey': optionKey,
      if (selectedSpellKey != null) 'selectedSpellKey': selectedSpellKey,
      if (selectedItemKey != null) 'selectedItemKey': selectedItemKey,
      if (selectedText != null) 'selectedText': selectedText,
      if (selectedCount != null) 'selectedCount': selectedCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterChoiceDataImpl extends CharacterChoiceData {
  _CharacterChoiceDataImpl({
    int? id,
    required int characterId,
    _i2.CharacterData? character,
    int? classEntryId,
    _i3.CharacterClassEntryData? classEntry,
    _i4.ChoiceSourceType? sourceType,
    int? sourceId,
    String? groupKey,
    String? optionKey,
    String? selectedSpellKey,
    String? selectedItemKey,
    String? selectedText,
    int? selectedCount,
  }) : super._(
          id: id,
          characterId: characterId,
          character: character,
          classEntryId: classEntryId,
          classEntry: classEntry,
          sourceType: sourceType,
          sourceId: sourceId,
          groupKey: groupKey,
          optionKey: optionKey,
          selectedSpellKey: selectedSpellKey,
          selectedItemKey: selectedItemKey,
          selectedText: selectedText,
          selectedCount: selectedCount,
        );

  /// Returns a shallow copy of this [CharacterChoiceData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterChoiceData copyWith({
    Object? id = _Undefined,
    int? characterId,
    Object? character = _Undefined,
    Object? classEntryId = _Undefined,
    Object? classEntry = _Undefined,
    Object? sourceType = _Undefined,
    Object? sourceId = _Undefined,
    Object? groupKey = _Undefined,
    Object? optionKey = _Undefined,
    Object? selectedSpellKey = _Undefined,
    Object? selectedItemKey = _Undefined,
    Object? selectedText = _Undefined,
    Object? selectedCount = _Undefined,
  }) {
    return CharacterChoiceData(
      id: id is int? ? id : this.id,
      characterId: characterId ?? this.characterId,
      character: character is _i2.CharacterData?
          ? character
          : this.character?.copyWith(),
      classEntryId: classEntryId is int? ? classEntryId : this.classEntryId,
      classEntry: classEntry is _i3.CharacterClassEntryData?
          ? classEntry
          : this.classEntry?.copyWith(),
      sourceType:
          sourceType is _i4.ChoiceSourceType? ? sourceType : this.sourceType,
      sourceId: sourceId is int? ? sourceId : this.sourceId,
      groupKey: groupKey is String? ? groupKey : this.groupKey,
      optionKey: optionKey is String? ? optionKey : this.optionKey,
      selectedSpellKey: selectedSpellKey is String?
          ? selectedSpellKey
          : this.selectedSpellKey,
      selectedItemKey:
          selectedItemKey is String? ? selectedItemKey : this.selectedItemKey,
      selectedText: selectedText is String? ? selectedText : this.selectedText,
      selectedCount: selectedCount is int? ? selectedCount : this.selectedCount,
    );
  }
}
