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
import '../dungeon_master/dm_creature_summary.dart' as _i2;

abstract class DmCreatureImportResult implements _i1.SerializableModel {
  DmCreatureImportResult._({
    required this.creature,
    required this.duplicate,
  });

  factory DmCreatureImportResult({
    required _i2.DmCreatureSummary creature,
    required bool duplicate,
  }) = _DmCreatureImportResultImpl;

  factory DmCreatureImportResult.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return DmCreatureImportResult(
      creature: _i2.DmCreatureSummary.fromJson(
          (jsonSerialization['creature'] as Map<String, dynamic>)),
      duplicate: jsonSerialization['duplicate'] as bool,
    );
  }

  _i2.DmCreatureSummary creature;

  bool duplicate;

  /// Returns a shallow copy of this [DmCreatureImportResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DmCreatureImportResult copyWith({
    _i2.DmCreatureSummary? creature,
    bool? duplicate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'creature': creature.toJson(),
      'duplicate': duplicate,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DmCreatureImportResultImpl extends DmCreatureImportResult {
  _DmCreatureImportResultImpl({
    required _i2.DmCreatureSummary creature,
    required bool duplicate,
  }) : super._(
          creature: creature,
          duplicate: duplicate,
        );

  /// Returns a shallow copy of this [DmCreatureImportResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DmCreatureImportResult copyWith({
    _i2.DmCreatureSummary? creature,
    bool? duplicate,
  }) {
    return DmCreatureImportResult(
      creature: creature ?? this.creature.copyWith(),
      duplicate: duplicate ?? this.duplicate,
    );
  }
}
