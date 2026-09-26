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
import '../../../enums/language.dart' as _i2;

abstract class CharacterLanguageOverridesData implements _i1.SerializableModel {
  CharacterLanguageOverridesData._({
    this.added,
    this.removed,
    this.custom,
  });

  factory CharacterLanguageOverridesData({
    List<_i2.Language>? added,
    List<_i2.Language>? removed,
    List<String>? custom,
  }) = _CharacterLanguageOverridesDataImpl;

  factory CharacterLanguageOverridesData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterLanguageOverridesData(
      added: (jsonSerialization['added'] as List?)
          ?.map((e) => _i2.Language.fromJson((e as String)))
          .toList(),
      removed: (jsonSerialization['removed'] as List?)
          ?.map((e) => _i2.Language.fromJson((e as String)))
          .toList(),
      custom: (jsonSerialization['custom'] as List?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  List<_i2.Language>? added;

  List<_i2.Language>? removed;

  List<String>? custom;

  /// Returns a shallow copy of this [CharacterLanguageOverridesData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterLanguageOverridesData copyWith({
    List<_i2.Language>? added,
    List<_i2.Language>? removed,
    List<String>? custom,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (added != null) 'added': added?.toJson(valueToJson: (v) => v.toJson()),
      if (removed != null)
        'removed': removed?.toJson(valueToJson: (v) => v.toJson()),
      if (custom != null) 'custom': custom?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterLanguageOverridesDataImpl
    extends CharacterLanguageOverridesData {
  _CharacterLanguageOverridesDataImpl({
    List<_i2.Language>? added,
    List<_i2.Language>? removed,
    List<String>? custom,
  }) : super._(
          added: added,
          removed: removed,
          custom: custom,
        );

  /// Returns a shallow copy of this [CharacterLanguageOverridesData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterLanguageOverridesData copyWith({
    Object? added = _Undefined,
    Object? removed = _Undefined,
    Object? custom = _Undefined,
  }) {
    return CharacterLanguageOverridesData(
      added: added is List<_i2.Language>?
          ? added
          : this.added?.map((e0) => e0).toList(),
      removed: removed is List<_i2.Language>?
          ? removed
          : this.removed?.map((e0) => e0).toList(),
      custom: custom is List<String>?
          ? custom
          : this.custom?.map((e0) => e0).toList(),
    );
  }
}
