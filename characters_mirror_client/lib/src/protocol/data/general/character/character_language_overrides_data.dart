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
import '../../../enums/language.dart' as _iiw0j43j;

abstract class CharacterLanguageOverridesData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CharacterLanguageOverridesData._({this.added, this.removed, this.custom});

  factory CharacterLanguageOverridesData({
    List<_iiw0j43j.Language>? added,
    List<_iiw0j43j.Language>? removed,
    List<String>? custom,
  }) = _CharacterLanguageOverridesDataImpl;

  factory CharacterLanguageOverridesData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterLanguageOverridesData(
      added: jsonSerialization['added'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_iiw0j43j.Language>>(
              jsonSerialization['added'],
            ),
      removed: jsonSerialization['removed'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_iiw0j43j.Language>>(
              jsonSerialization['removed'],
            ),
      custom: jsonSerialization['custom'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['custom'],
            ),
    );
  }

  List<_iiw0j43j.Language>? added;

  List<_iiw0j43j.Language>? removed;

  List<String>? custom;

  /// Returns a shallow copy of this [CharacterLanguageOverridesData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CharacterLanguageOverridesData copyWith({
    List<_iiw0j43j.Language>? added,
    List<_iiw0j43j.Language>? removed,
    List<String>? custom,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterLanguageOverridesData',
      if (added != null) 'added': added?.toJson(valueToJson: (v) => v.toJson()),
      if (removed != null)
        'removed': removed?.toJson(valueToJson: (v) => v.toJson()),
      if (custom != null) 'custom': custom?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CharacterLanguageOverridesData',
      if (added != null) 'added': added?.toJson(valueToJson: (v) => v.toJson()),
      if (removed != null)
        'removed': removed?.toJson(valueToJson: (v) => v.toJson()),
      if (custom != null) 'custom': custom?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterLanguageOverridesDataImpl
    extends CharacterLanguageOverridesData {
  _CharacterLanguageOverridesDataImpl({
    List<_iiw0j43j.Language>? added,
    List<_iiw0j43j.Language>? removed,
    List<String>? custom,
  }) : super._(added: added, removed: removed, custom: custom);

  /// Returns a shallow copy of this [CharacterLanguageOverridesData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CharacterLanguageOverridesData copyWith({
    Object? added = _Undefined,
    Object? removed = _Undefined,
    Object? custom = _Undefined,
  }) {
    return CharacterLanguageOverridesData(
      added: added is List<_iiw0j43j.Language>?
          ? added
          : this.added?.map((e0) => e0).toList(),
      removed: removed is List<_iiw0j43j.Language>?
          ? removed
          : this.removed?.map((e0) => e0).toList(),
      custom: custom is List<String>?
          ? custom
          : this.custom?.map((e0) => e0).toList(),
    );
  }
}
