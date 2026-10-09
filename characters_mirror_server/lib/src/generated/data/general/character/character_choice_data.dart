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
import '../../../data/general/character/choice_replacement_history_data.dart'
    as _i2;
import '../../../data/general/character/character_class_entry_data.dart' as _i3;

abstract class CharacterChoiceData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CharacterChoiceData._({
    this.id,
    this.replacementHistory,
    this.classEntry,
    this.groupKey,
    this.optionKey,
    this.selectionIndex,
    this.updatedAt,
  });

  factory CharacterChoiceData({
    String? id,
    List<_i2.ChoiceReplacementHistoryData>? replacementHistory,
    _i3.CharacterClassEntryData? classEntry,
    String? groupKey,
    String? optionKey,
    int? selectionIndex,
    DateTime? updatedAt,
  }) = _CharacterChoiceDataImpl;

  factory CharacterChoiceData.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterChoiceData(
      id: jsonSerialization['id'] as String?,
      replacementHistory: (jsonSerialization['replacementHistory'] as List?)
          ?.map((e) => _i2.ChoiceReplacementHistoryData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      classEntry: jsonSerialization['classEntry'] == null
          ? null
          : _i3.CharacterClassEntryData.fromJson(
              (jsonSerialization['classEntry'] as Map<String, dynamic>)),
      groupKey: jsonSerialization['groupKey'] as String?,
      optionKey: jsonSerialization['optionKey'] as String?,
      selectionIndex: jsonSerialization['selectionIndex'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  List<_i2.ChoiceReplacementHistoryData>? replacementHistory;

  String? id;

  _i3.CharacterClassEntryData? classEntry;

  String? groupKey;

  String? optionKey;

  int? selectionIndex;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [CharacterChoiceData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterChoiceData copyWith({
    String? id,
    List<_i2.ChoiceReplacementHistoryData>? replacementHistory,
    _i3.CharacterClassEntryData? classEntry,
    String? groupKey,
    String? optionKey,
    int? selectionIndex,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (replacementHistory != null)
        'replacementHistory':
            replacementHistory?.toJson(valueToJson: (v) => v.toJson()),
      if (classEntry != null) 'classEntry': classEntry?.toJson(),
      if (groupKey != null) 'groupKey': groupKey,
      if (optionKey != null) 'optionKey': optionKey,
      if (selectionIndex != null) 'selectionIndex': selectionIndex,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (replacementHistory != null)
        'replacementHistory': replacementHistory?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (classEntry != null) 'classEntry': classEntry?.toJsonForProtocol(),
      if (groupKey != null) 'groupKey': groupKey,
      if (optionKey != null) 'optionKey': optionKey,
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

class _CharacterChoiceDataImpl extends CharacterChoiceData {
  _CharacterChoiceDataImpl({
    String? id,
    List<_i2.ChoiceReplacementHistoryData>? replacementHistory,
    _i3.CharacterClassEntryData? classEntry,
    String? groupKey,
    String? optionKey,
    int? selectionIndex,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          replacementHistory: replacementHistory,
          classEntry: classEntry,
          groupKey: groupKey,
          optionKey: optionKey,
          selectionIndex: selectionIndex,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [CharacterChoiceData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterChoiceData copyWith({
    Object? id = _Undefined,
    Object? replacementHistory = _Undefined,
    Object? classEntry = _Undefined,
    Object? groupKey = _Undefined,
    Object? optionKey = _Undefined,
    Object? selectionIndex = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return CharacterChoiceData(
      id: id is String? ? id : this.id,
      replacementHistory:
          replacementHistory is List<_i2.ChoiceReplacementHistoryData>?
              ? replacementHistory
              : this.replacementHistory?.map((e0) => e0.copyWith()).toList(),
      classEntry: classEntry is _i3.CharacterClassEntryData?
          ? classEntry
          : this.classEntry?.copyWith(),
      groupKey: groupKey is String? ? groupKey : this.groupKey,
      optionKey: optionKey is String? ? optionKey : this.optionKey,
      selectionIndex:
          selectionIndex is int? ? selectionIndex : this.selectionIndex,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
