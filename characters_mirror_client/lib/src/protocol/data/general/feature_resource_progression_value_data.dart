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
import '../../data/general/feature_resource_definition_data.dart' as _i2;

abstract class FeatureResourceProgressionValueData
    implements _i1.SerializableModel {
  FeatureResourceProgressionValueData._({
    this.id,
    this.resourceDefinitionId,
    this.resourceDefinition,
    required this.level,
    required this.value,
  });

  factory FeatureResourceProgressionValueData({
    int? id,
    int? resourceDefinitionId,
    _i2.FeatureResourceDefinitionData? resourceDefinition,
    required int level,
    required int value,
  }) = _FeatureResourceProgressionValueDataImpl;

  factory FeatureResourceProgressionValueData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return FeatureResourceProgressionValueData(
      id: jsonSerialization['id'] as int?,
      resourceDefinitionId: jsonSerialization['resourceDefinitionId'] as int?,
      resourceDefinition: jsonSerialization['resourceDefinition'] == null
          ? null
          : _i2.FeatureResourceDefinitionData.fromJson(
              (jsonSerialization['resourceDefinition']
                  as Map<String, dynamic>)),
      level: jsonSerialization['level'] as int,
      value: jsonSerialization['value'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? resourceDefinitionId;

  _i2.FeatureResourceDefinitionData? resourceDefinition;

  int level;

  int value;

  /// Returns a shallow copy of this [FeatureResourceProgressionValueData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureResourceProgressionValueData copyWith({
    int? id,
    int? resourceDefinitionId,
    _i2.FeatureResourceDefinitionData? resourceDefinition,
    int? level,
    int? value,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (resourceDefinitionId != null)
        'resourceDefinitionId': resourceDefinitionId,
      if (resourceDefinition != null)
        'resourceDefinition': resourceDefinition?.toJson(),
      'level': level,
      'value': value,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureResourceProgressionValueDataImpl
    extends FeatureResourceProgressionValueData {
  _FeatureResourceProgressionValueDataImpl({
    int? id,
    int? resourceDefinitionId,
    _i2.FeatureResourceDefinitionData? resourceDefinition,
    required int level,
    required int value,
  }) : super._(
          id: id,
          resourceDefinitionId: resourceDefinitionId,
          resourceDefinition: resourceDefinition,
          level: level,
          value: value,
        );

  /// Returns a shallow copy of this [FeatureResourceProgressionValueData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatureResourceProgressionValueData copyWith({
    Object? id = _Undefined,
    Object? resourceDefinitionId = _Undefined,
    Object? resourceDefinition = _Undefined,
    int? level,
    int? value,
  }) {
    return FeatureResourceProgressionValueData(
      id: id is int? ? id : this.id,
      resourceDefinitionId: resourceDefinitionId is int?
          ? resourceDefinitionId
          : this.resourceDefinitionId,
      resourceDefinition:
          resourceDefinition is _i2.FeatureResourceDefinitionData?
              ? resourceDefinition
              : this.resourceDefinition?.copyWith(),
      level: level ?? this.level,
      value: value ?? this.value,
    );
  }
}
