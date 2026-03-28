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
import '../data/general/character/character_data.dart' as _i2;
import '../data/general/character/character_class_entry_data.dart' as _i3;
import '../data/general/character/character_choice_data.dart' as _i4;
import '../data/general/character/character_sheet_snapshot_data.dart' as _i5;

abstract class CharacterSheetView implements _i1.SerializableModel {
  CharacterSheetView._({
    this.character,
    this.classEntries,
    this.choices,
    this.snapshot,
  });

  factory CharacterSheetView({
    _i2.CharacterData? character,
    List<_i3.CharacterClassEntryData>? classEntries,
    List<_i4.CharacterChoiceData>? choices,
    _i5.CharacterSheetSnapshotData? snapshot,
  }) = _CharacterSheetViewImpl;

  factory CharacterSheetView.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterSheetView(
      character: jsonSerialization['character'] == null
          ? null
          : _i2.CharacterData.fromJson(
              (jsonSerialization['character'] as Map<String, dynamic>)),
      classEntries: (jsonSerialization['classEntries'] as List?)
          ?.map((e) =>
              _i3.CharacterClassEntryData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      choices: (jsonSerialization['choices'] as List?)
          ?.map((e) =>
              _i4.CharacterChoiceData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      snapshot: jsonSerialization['snapshot'] == null
          ? null
          : _i5.CharacterSheetSnapshotData.fromJson(
              (jsonSerialization['snapshot'] as Map<String, dynamic>)),
    );
  }

  _i2.CharacterData? character;

  List<_i3.CharacterClassEntryData>? classEntries;

  List<_i4.CharacterChoiceData>? choices;

  _i5.CharacterSheetSnapshotData? snapshot;

  /// Returns a shallow copy of this [CharacterSheetView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterSheetView copyWith({
    _i2.CharacterData? character,
    List<_i3.CharacterClassEntryData>? classEntries,
    List<_i4.CharacterChoiceData>? choices,
    _i5.CharacterSheetSnapshotData? snapshot,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (character != null) 'character': character?.toJson(),
      if (classEntries != null)
        'classEntries': classEntries?.toJson(valueToJson: (v) => v.toJson()),
      if (choices != null)
        'choices': choices?.toJson(valueToJson: (v) => v.toJson()),
      if (snapshot != null) 'snapshot': snapshot?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSheetViewImpl extends CharacterSheetView {
  _CharacterSheetViewImpl({
    _i2.CharacterData? character,
    List<_i3.CharacterClassEntryData>? classEntries,
    List<_i4.CharacterChoiceData>? choices,
    _i5.CharacterSheetSnapshotData? snapshot,
  }) : super._(
          character: character,
          classEntries: classEntries,
          choices: choices,
          snapshot: snapshot,
        );

  /// Returns a shallow copy of this [CharacterSheetView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterSheetView copyWith({
    Object? character = _Undefined,
    Object? classEntries = _Undefined,
    Object? choices = _Undefined,
    Object? snapshot = _Undefined,
  }) {
    return CharacterSheetView(
      character: character is _i2.CharacterData?
          ? character
          : this.character?.copyWith(),
      classEntries: classEntries is List<_i3.CharacterClassEntryData>?
          ? classEntries
          : this.classEntries?.map((e0) => e0.copyWith()).toList(),
      choices: choices is List<_i4.CharacterChoiceData>?
          ? choices
          : this.choices?.map((e0) => e0.copyWith()).toList(),
      snapshot: snapshot is _i5.CharacterSheetSnapshotData?
          ? snapshot
          : this.snapshot?.copyWith(),
    );
  }
}
