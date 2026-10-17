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
import '../../data/general/class/class_feature_data.dart' as _inxbtq9c;
import '../../data/general/class/subclass_feature_data.dart' as _i6bcyp7i;
import '../../data/general/feature_modifier_condition_data.dart' as _ig9xtn4u;
import '../../data/general/feature_modifier_value_data.dart' as _iby00w8q;
import '../../enums/feature_modifier_operation.dart' as _iiz9cg73;
import '../../enums/feature_modifier_target.dart' as _i4cfd6vr;

abstract class FeatureModifierData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    this.spellKey,
    this.minimumCastLevel,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory FeatureModifierData({
    int? id,
    required String referenceKey,
    int? classFeatureId,
    _inxbtq9c.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? subclassFeature,
    required _i4cfd6vr.FeatureModifierTarget target,
    required _iiz9cg73.FeatureModifierOperation operation,
    required _iby00w8q.FeatureModifierValueData value,
    List<_ig9xtn4u.FeatureModifierConditionData>? conditions,
    String? spellKey,
    int? minimumCastLevel,
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
          : _isnx6jbi.Protocol().deserialize<_inxbtq9c.ClassFeatureData>(
              jsonSerialization['classFeature'],
            ),
      subclassFeatureId: jsonSerialization['subclassFeatureId'] as int?,
      subclassFeature: jsonSerialization['subclassFeature'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_i6bcyp7i.SubclassFeatureData>(
              jsonSerialization['subclassFeature'],
            ),
      target: _i4cfd6vr.FeatureModifierTarget.fromJson(
        (jsonSerialization['target'] as int),
      ),
      operation: _iiz9cg73.FeatureModifierOperation.fromJson(
        (jsonSerialization['operation'] as int),
      ),
      value: _isnx6jbi.Protocol()
          .deserialize<_iby00w8q.FeatureModifierValueData>(
            jsonSerialization['value'],
          ),
      conditions: jsonSerialization['conditions'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_ig9xtn4u.FeatureModifierConditionData>>(
                  jsonSerialization['conditions'],
                ),
      spellKey: jsonSerialization['spellKey'] as String?,
      minimumCastLevel: jsonSerialization['minimumCastLevel'] as int?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String referenceKey;

  int? classFeatureId;

  _inxbtq9c.ClassFeatureData? classFeature;

  int? subclassFeatureId;

  _i6bcyp7i.SubclassFeatureData? subclassFeature;

  _i4cfd6vr.FeatureModifierTarget target;

  _iiz9cg73.FeatureModifierOperation operation;

  _iby00w8q.FeatureModifierValueData value;

  List<_ig9xtn4u.FeatureModifierConditionData>? conditions;

  String? spellKey;

  int? minimumCastLevel;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [FeatureModifierData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FeatureModifierData copyWith({
    int? id,
    String? referenceKey,
    int? classFeatureId,
    _inxbtq9c.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? subclassFeature,
    _i4cfd6vr.FeatureModifierTarget? target,
    _iiz9cg73.FeatureModifierOperation? operation,
    _iby00w8q.FeatureModifierValueData? value,
    List<_ig9xtn4u.FeatureModifierConditionData>? conditions,
    String? spellKey,
    int? minimumCastLevel,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeatureModifierData',
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
      if (spellKey != null) 'spellKey': spellKey,
      if (minimumCastLevel != null) 'minimumCastLevel': minimumCastLevel,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeatureModifierData',
      if (id != null) 'id': id,
      'referenceKey': referenceKey,
      if (classFeatureId != null) 'classFeatureId': classFeatureId,
      if (classFeature != null)
        'classFeature': classFeature?.toJsonForProtocol(),
      if (subclassFeatureId != null) 'subclassFeatureId': subclassFeatureId,
      if (subclassFeature != null)
        'subclassFeature': subclassFeature?.toJsonForProtocol(),
      'target': target.toJson(),
      'operation': operation.toJson(),
      'value': value.toJsonForProtocol(),
      if (conditions != null)
        'conditions': conditions?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (spellKey != null) 'spellKey': spellKey,
      if (minimumCastLevel != null) 'minimumCastLevel': minimumCastLevel,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureModifierDataImpl extends FeatureModifierData {
  _FeatureModifierDataImpl({
    int? id,
    required String referenceKey,
    int? classFeatureId,
    _inxbtq9c.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? subclassFeature,
    required _i4cfd6vr.FeatureModifierTarget target,
    required _iiz9cg73.FeatureModifierOperation operation,
    required _iby00w8q.FeatureModifierValueData value,
    List<_ig9xtn4u.FeatureModifierConditionData>? conditions,
    String? spellKey,
    int? minimumCastLevel,
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
         spellKey: spellKey,
         minimumCastLevel: minimumCastLevel,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FeatureModifierData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FeatureModifierData copyWith({
    Object? id = _Undefined,
    String? referenceKey,
    Object? classFeatureId = _Undefined,
    Object? classFeature = _Undefined,
    Object? subclassFeatureId = _Undefined,
    Object? subclassFeature = _Undefined,
    _i4cfd6vr.FeatureModifierTarget? target,
    _iiz9cg73.FeatureModifierOperation? operation,
    _iby00w8q.FeatureModifierValueData? value,
    Object? conditions = _Undefined,
    Object? spellKey = _Undefined,
    Object? minimumCastLevel = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return FeatureModifierData(
      id: id is int? ? id : this.id,
      referenceKey: referenceKey ?? this.referenceKey,
      classFeatureId: classFeatureId is int?
          ? classFeatureId
          : this.classFeatureId,
      classFeature: classFeature is _inxbtq9c.ClassFeatureData?
          ? classFeature
          : this.classFeature?.copyWith(),
      subclassFeatureId: subclassFeatureId is int?
          ? subclassFeatureId
          : this.subclassFeatureId,
      subclassFeature: subclassFeature is _i6bcyp7i.SubclassFeatureData?
          ? subclassFeature
          : this.subclassFeature?.copyWith(),
      target: target ?? this.target,
      operation: operation ?? this.operation,
      value: value ?? this.value.copyWith(),
      conditions: conditions is List<_ig9xtn4u.FeatureModifierConditionData>?
          ? conditions
          : this.conditions?.map((e0) => e0.copyWith()).toList(),
      spellKey: spellKey is String? ? spellKey : this.spellKey,
      minimumCastLevel: minimumCastLevel is int?
          ? minimumCastLevel
          : this.minimumCastLevel,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
