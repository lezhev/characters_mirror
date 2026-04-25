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

abstract class CharacterNoteData implements _i1.SerializableModel {
  CharacterNoteData._({
    this.id,
    this.text,
    this.updatedAt,
  });

  factory CharacterNoteData({
    String? id,
    String? text,
    DateTime? updatedAt,
  }) = _CharacterNoteDataImpl;

  factory CharacterNoteData.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterNoteData(
      id: jsonSerialization['id'] as String?,
      text: jsonSerialization['text'] as String?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  String? id;

  String? text;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [CharacterNoteData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterNoteData copyWith({
    String? id,
    String? text,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (text != null) 'text': text,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterNoteDataImpl extends CharacterNoteData {
  _CharacterNoteDataImpl({
    String? id,
    String? text,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          text: text,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [CharacterNoteData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterNoteData copyWith({
    Object? id = _Undefined,
    Object? text = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return CharacterNoteData(
      id: id is String? ? id : this.id,
      text: text is String? ? text : this.text,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
