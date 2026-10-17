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
import '../dungeon_master/dm_creature_summary.dart' as _it59w3qe;

abstract class DmCreatureImportResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DmCreatureImportResult._({required this.creature, required this.duplicate});

  factory DmCreatureImportResult({
    required _it59w3qe.DmCreatureSummary creature,
    required bool duplicate,
  }) = _DmCreatureImportResultImpl;

  factory DmCreatureImportResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DmCreatureImportResult(
      creature: _isnx6jbi.Protocol().deserialize<_it59w3qe.DmCreatureSummary>(
        jsonSerialization['creature'],
      ),
      duplicate: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['duplicate'],
      ),
    );
  }

  _it59w3qe.DmCreatureSummary creature;

  bool duplicate;

  /// Returns a shallow copy of this [DmCreatureImportResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DmCreatureImportResult copyWith({
    _it59w3qe.DmCreatureSummary? creature,
    bool? duplicate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DmCreatureImportResult',
      'creature': creature.toJson(),
      'duplicate': duplicate,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DmCreatureImportResult',
      'creature': creature.toJsonForProtocol(),
      'duplicate': duplicate,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _DmCreatureImportResultImpl extends DmCreatureImportResult {
  _DmCreatureImportResultImpl({
    required _it59w3qe.DmCreatureSummary creature,
    required bool duplicate,
  }) : super._(creature: creature, duplicate: duplicate);

  /// Returns a shallow copy of this [DmCreatureImportResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DmCreatureImportResult copyWith({
    _it59w3qe.DmCreatureSummary? creature,
    bool? duplicate,
  }) {
    return DmCreatureImportResult(
      creature: creature ?? this.creature.copyWith(),
      duplicate: duplicate ?? this.duplicate,
    );
  }
}
