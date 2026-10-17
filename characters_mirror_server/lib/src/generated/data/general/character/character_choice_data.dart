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
import '../../../data/general/character/character_class_entry_data.dart'
    as _inzx0vvj;
import '../../../data/general/character/choice_replacement_history_data.dart'
    as _ikw9ov94;

abstract class CharacterChoiceData
    implements _is.SerializableModel, _is.ProtocolSerialization {
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
    List<_ikw9ov94.ChoiceReplacementHistoryData>? replacementHistory,
    _inzx0vvj.CharacterClassEntryData? classEntry,
    String? groupKey,
    String? optionKey,
    int? selectionIndex,
    DateTime? updatedAt,
  }) = _CharacterChoiceDataImpl;

  factory CharacterChoiceData.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterChoiceData(
      id: jsonSerialization['id'] as String?,
      replacementHistory: jsonSerialization['replacementHistory'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_ikw9ov94.ChoiceReplacementHistoryData>>(
                  jsonSerialization['replacementHistory'],
                ),
      classEntry: jsonSerialization['classEntry'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_inzx0vvj.CharacterClassEntryData>(
              jsonSerialization['classEntry'],
            ),
      groupKey: jsonSerialization['groupKey'] as String?,
      optionKey: jsonSerialization['optionKey'] as String?,
      selectionIndex: jsonSerialization['selectionIndex'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  List<_ikw9ov94.ChoiceReplacementHistoryData>? replacementHistory;

  String? id;

  _inzx0vvj.CharacterClassEntryData? classEntry;

  String? groupKey;

  String? optionKey;

  int? selectionIndex;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [CharacterChoiceData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CharacterChoiceData copyWith({
    String? id,
    List<_ikw9ov94.ChoiceReplacementHistoryData>? replacementHistory,
    _inzx0vvj.CharacterClassEntryData? classEntry,
    String? groupKey,
    String? optionKey,
    int? selectionIndex,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterChoiceData',
      if (id != null) 'id': id,
      if (replacementHistory != null)
        'replacementHistory': replacementHistory?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
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
      '__className__': 'CharacterChoiceData',
      if (id != null) 'id': id,
      if (replacementHistory != null)
        'replacementHistory': replacementHistory?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (classEntry != null) 'classEntry': classEntry?.toJsonForProtocol(),
      if (groupKey != null) 'groupKey': groupKey,
      if (optionKey != null) 'optionKey': optionKey,
      if (selectionIndex != null) 'selectionIndex': selectionIndex,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterChoiceDataImpl extends CharacterChoiceData {
  _CharacterChoiceDataImpl({
    String? id,
    List<_ikw9ov94.ChoiceReplacementHistoryData>? replacementHistory,
    _inzx0vvj.CharacterClassEntryData? classEntry,
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
  @_is.useResult
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
          replacementHistory is List<_ikw9ov94.ChoiceReplacementHistoryData>?
          ? replacementHistory
          : this.replacementHistory?.map((e0) => e0.copyWith()).toList(),
      classEntry: classEntry is _inzx0vvj.CharacterClassEntryData?
          ? classEntry
          : this.classEntry?.copyWith(),
      groupKey: groupKey is String? ? groupKey : this.groupKey,
      optionKey: optionKey is String? ? optionKey : this.optionKey,
      selectionIndex: selectionIndex is int?
          ? selectionIndex
          : this.selectionIndex,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
