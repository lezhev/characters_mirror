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
import '../../../enums/choice_source_type.dart' as _i3;
import '../../../enums/ability.dart' as _i4;
import '../../../enums/language.dart' as _i5;

abstract class CharacterChoiceData implements _i1.SerializableModel {
  CharacterChoiceData._({
    this.id,
    this.classEntry,
    this.sourceType,
    this.sourceId,
    this.groupKey,
    this.optionKey,
    this.selectionIndex,
    this.selectedAbility,
    this.selectedLanguage,
    this.selectedToolKey,
    this.selectedSpellKey,
    this.selectedItemKey,
    this.selectedFeatId,
    this.selectedText,
    this.selectedCount,
  });

  factory CharacterChoiceData({
    int? id,
    _i2.CharacterClassEntryData? classEntry,
    _i3.ChoiceSourceType? sourceType,
    int? sourceId,
    String? groupKey,
    String? optionKey,
    int? selectionIndex,
    _i4.Ability? selectedAbility,
    _i5.Language? selectedLanguage,
    String? selectedToolKey,
    String? selectedSpellKey,
    String? selectedItemKey,
    int? selectedFeatId,
    String? selectedText,
    int? selectedCount,
  }) = _CharacterChoiceDataImpl;

  factory CharacterChoiceData.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterChoiceData(
      id: jsonSerialization['id'] as int?,
      classEntry: jsonSerialization['classEntry'] == null
          ? null
          : _i2.CharacterClassEntryData.fromJson(
              (jsonSerialization['classEntry'] as Map<String, dynamic>)),
      sourceType: jsonSerialization['sourceType'] == null
          ? null
          : _i3.ChoiceSourceType.fromJson(
              (jsonSerialization['sourceType'] as String)),
      sourceId: jsonSerialization['sourceId'] as int?,
      groupKey: jsonSerialization['groupKey'] as String?,
      optionKey: jsonSerialization['optionKey'] as String?,
      selectionIndex: jsonSerialization['selectionIndex'] as int?,
      selectedAbility: jsonSerialization['selectedAbility'] == null
          ? null
          : _i4.Ability.fromJson(
              (jsonSerialization['selectedAbility'] as String)),
      selectedLanguage: jsonSerialization['selectedLanguage'] == null
          ? null
          : _i5.Language.fromJson(
              (jsonSerialization['selectedLanguage'] as String)),
      selectedToolKey: jsonSerialization['selectedToolKey'] as String?,
      selectedSpellKey: jsonSerialization['selectedSpellKey'] as String?,
      selectedItemKey: jsonSerialization['selectedItemKey'] as String?,
      selectedFeatId: jsonSerialization['selectedFeatId'] as int?,
      selectedText: jsonSerialization['selectedText'] as String?,
      selectedCount: jsonSerialization['selectedCount'] as int?,
    );
  }

  int? id;

  _i2.CharacterClassEntryData? classEntry;

  _i3.ChoiceSourceType? sourceType;

  int? sourceId;

  String? groupKey;

  String? optionKey;

  int? selectionIndex;

  _i4.Ability? selectedAbility;

  _i5.Language? selectedLanguage;

  String? selectedToolKey;

  String? selectedSpellKey;

  String? selectedItemKey;

  int? selectedFeatId;

  String? selectedText;

  int? selectedCount;

  /// Returns a shallow copy of this [CharacterChoiceData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterChoiceData copyWith({
    int? id,
    _i2.CharacterClassEntryData? classEntry,
    _i3.ChoiceSourceType? sourceType,
    int? sourceId,
    String? groupKey,
    String? optionKey,
    int? selectionIndex,
    _i4.Ability? selectedAbility,
    _i5.Language? selectedLanguage,
    String? selectedToolKey,
    String? selectedSpellKey,
    String? selectedItemKey,
    int? selectedFeatId,
    String? selectedText,
    int? selectedCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (classEntry != null) 'classEntry': classEntry?.toJson(),
      if (sourceType != null) 'sourceType': sourceType?.toJson(),
      if (sourceId != null) 'sourceId': sourceId,
      if (groupKey != null) 'groupKey': groupKey,
      if (optionKey != null) 'optionKey': optionKey,
      if (selectionIndex != null) 'selectionIndex': selectionIndex,
      if (selectedAbility != null) 'selectedAbility': selectedAbility?.toJson(),
      if (selectedLanguage != null)
        'selectedLanguage': selectedLanguage?.toJson(),
      if (selectedToolKey != null) 'selectedToolKey': selectedToolKey,
      if (selectedSpellKey != null) 'selectedSpellKey': selectedSpellKey,
      if (selectedItemKey != null) 'selectedItemKey': selectedItemKey,
      if (selectedFeatId != null) 'selectedFeatId': selectedFeatId,
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
    _i2.CharacterClassEntryData? classEntry,
    _i3.ChoiceSourceType? sourceType,
    int? sourceId,
    String? groupKey,
    String? optionKey,
    int? selectionIndex,
    _i4.Ability? selectedAbility,
    _i5.Language? selectedLanguage,
    String? selectedToolKey,
    String? selectedSpellKey,
    String? selectedItemKey,
    int? selectedFeatId,
    String? selectedText,
    int? selectedCount,
  }) : super._(
          id: id,
          classEntry: classEntry,
          sourceType: sourceType,
          sourceId: sourceId,
          groupKey: groupKey,
          optionKey: optionKey,
          selectionIndex: selectionIndex,
          selectedAbility: selectedAbility,
          selectedLanguage: selectedLanguage,
          selectedToolKey: selectedToolKey,
          selectedSpellKey: selectedSpellKey,
          selectedItemKey: selectedItemKey,
          selectedFeatId: selectedFeatId,
          selectedText: selectedText,
          selectedCount: selectedCount,
        );

  /// Returns a shallow copy of this [CharacterChoiceData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterChoiceData copyWith({
    Object? id = _Undefined,
    Object? classEntry = _Undefined,
    Object? sourceType = _Undefined,
    Object? sourceId = _Undefined,
    Object? groupKey = _Undefined,
    Object? optionKey = _Undefined,
    Object? selectionIndex = _Undefined,
    Object? selectedAbility = _Undefined,
    Object? selectedLanguage = _Undefined,
    Object? selectedToolKey = _Undefined,
    Object? selectedSpellKey = _Undefined,
    Object? selectedItemKey = _Undefined,
    Object? selectedFeatId = _Undefined,
    Object? selectedText = _Undefined,
    Object? selectedCount = _Undefined,
  }) {
    return CharacterChoiceData(
      id: id is int? ? id : this.id,
      classEntry: classEntry is _i2.CharacterClassEntryData?
          ? classEntry
          : this.classEntry?.copyWith(),
      sourceType:
          sourceType is _i3.ChoiceSourceType? ? sourceType : this.sourceType,
      sourceId: sourceId is int? ? sourceId : this.sourceId,
      groupKey: groupKey is String? ? groupKey : this.groupKey,
      optionKey: optionKey is String? ? optionKey : this.optionKey,
      selectionIndex:
          selectionIndex is int? ? selectionIndex : this.selectionIndex,
      selectedAbility: selectedAbility is _i4.Ability?
          ? selectedAbility
          : this.selectedAbility,
      selectedLanguage: selectedLanguage is _i5.Language?
          ? selectedLanguage
          : this.selectedLanguage,
      selectedToolKey:
          selectedToolKey is String? ? selectedToolKey : this.selectedToolKey,
      selectedSpellKey: selectedSpellKey is String?
          ? selectedSpellKey
          : this.selectedSpellKey,
      selectedItemKey:
          selectedItemKey is String? ? selectedItemKey : this.selectedItemKey,
      selectedFeatId:
          selectedFeatId is int? ? selectedFeatId : this.selectedFeatId,
      selectedText: selectedText is String? ? selectedText : this.selectedText,
      selectedCount: selectedCount is int? ? selectedCount : this.selectedCount,
    );
  }
}
