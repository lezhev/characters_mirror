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
import '../../data/general/class/class_feature_data.dart' as _i2;
import '../../data/general/class/subclass_feature_data.dart' as _i3;
import '../../enums/feature_modifier_target.dart' as _i4;
import '../../enums/feature_modifier_operation.dart' as _i5;
import '../../data/general/feature_modifier_value_data.dart' as _i6;
import '../../data/general/feature_modifier_condition_data.dart' as _i7;

abstract class FeatureModifierData implements _i1.SerializableModel {
  FeatureModifierData._({
    this.id,
    required this.referenceKey,
    this.classFeatureId,
    this.classFeature,
    this.subclassFeatureId,
    this.subclassFeature,
    required this.target,
    required this.operation,
    required this.value,
    this.conditions,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory FeatureModifierData({
    int? id,
    required String referenceKey,
    int? classFeatureId,
    _i2.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i3.SubclassFeatureData? subclassFeature,
    required _i4.FeatureModifierTarget target,
    required _i5.FeatureModifierOperation operation,
    required _i6.FeatureModifierValueData value,
    List<_i7.FeatureModifierConditionData>? conditions,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FeatureModifierDataImpl;

  factory FeatureModifierData.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeatureModifierData(
      id: jsonSerialization['id'] as int?,
      referenceKey: jsonSerialization['referenceKey'] as String,
      classFeatureId: jsonSerialization['classFeatureId'] as int?,
      classFeature: jsonSerialization['classFeature'] == null
          ? null
          : _i2.ClassFeatureData.fromJson(
              (jsonSerialization['classFeature'] as Map<String, dynamic>)),
      subclassFeatureId: jsonSerialization['subclassFeatureId'] as int?,
      subclassFeature: jsonSerialization['subclassFeature'] == null
          ? null
          : _i3.SubclassFeatureData.fromJson(
              (jsonSerialization['subclassFeature'] as Map<String, dynamic>)),
      target: _i4.FeatureModifierTarget.fromJson(
          (jsonSerialization['target'] as int)),
      operation: _i5.FeatureModifierOperation.fromJson(
          (jsonSerialization['operation'] as int)),
      value: _i6.FeatureModifierValueData.fromJson(
          (jsonSerialization['value'] as Map<String, dynamic>)),
      conditions: (jsonSerialization['conditions'] as List?)
          ?.map((e) => _i7.FeatureModifierConditionData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String referenceKey;

  int? classFeatureId;

  _i2.ClassFeatureData? classFeature;

  int? subclassFeatureId;

  _i3.SubclassFeatureData? subclassFeature;

  _i4.FeatureModifierTarget target;

  _i5.FeatureModifierOperation operation;

  _i6.FeatureModifierValueData value;

  List<_i7.FeatureModifierConditionData>? conditions;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [FeatureModifierData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureModifierData copyWith({
    int? id,
    String? referenceKey,
    int? classFeatureId,
    _i2.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i3.SubclassFeatureData? subclassFeature,
    _i4.FeatureModifierTarget? target,
    _i5.FeatureModifierOperation? operation,
    _i6.FeatureModifierValueData? value,
    List<_i7.FeatureModifierConditionData>? conditions,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'referenceKey': referenceKey,
      if (classFeatureId != null) 'classFeatureId': classFeatureId,
      if (classFeature != null) 'classFeature': classFeature?.toJson(),
      if (subclassFeatureId != null) 'subclassFeatureId': subclassFeatureId,
      if (subclassFeature != null) 'subclassFeature': subclassFeature?.toJson(),
      'target': target.toJson(),
      'operation': operation.toJson(),
      'value': value.toJson(),
      if (conditions != null)
        'conditions': conditions?.toJson(valueToJson: (v) => v.toJson()),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureModifierDataImpl extends FeatureModifierData {
  _FeatureModifierDataImpl({
    int? id,
    required String referenceKey,
    int? classFeatureId,
    _i2.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i3.SubclassFeatureData? subclassFeature,
    required _i4.FeatureModifierTarget target,
    required _i5.FeatureModifierOperation operation,
    required _i6.FeatureModifierValueData value,
    List<_i7.FeatureModifierConditionData>? conditions,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          referenceKey: referenceKey,
          classFeatureId: classFeatureId,
          classFeature: classFeature,
          subclassFeatureId: subclassFeatureId,
          subclassFeature: subclassFeature,
          target: target,
          operation: operation,
          value: value,
          conditions: conditions,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [FeatureModifierData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatureModifierData copyWith({
    Object? id = _Undefined,
    String? referenceKey,
    Object? classFeatureId = _Undefined,
    Object? classFeature = _Undefined,
    Object? subclassFeatureId = _Undefined,
    Object? subclassFeature = _Undefined,
    _i4.FeatureModifierTarget? target,
    _i5.FeatureModifierOperation? operation,
    _i6.FeatureModifierValueData? value,
    Object? conditions = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return FeatureModifierData(
      id: id is int? ? id : this.id,
      referenceKey: referenceKey ?? this.referenceKey,
      classFeatureId:
          classFeatureId is int? ? classFeatureId : this.classFeatureId,
      classFeature: classFeature is _i2.ClassFeatureData?
          ? classFeature
          : this.classFeature?.copyWith(),
      subclassFeatureId: subclassFeatureId is int?
          ? subclassFeatureId
          : this.subclassFeatureId,
      subclassFeature: subclassFeature is _i3.SubclassFeatureData?
          ? subclassFeature
          : this.subclassFeature?.copyWith(),
      target: target ?? this.target,
      operation: operation ?? this.operation,
      value: value ?? this.value.copyWith(),
      conditions: conditions is List<_i7.FeatureModifierConditionData>?
          ? conditions
          : this.conditions?.map((e0) => e0.copyWith()).toList(),
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
