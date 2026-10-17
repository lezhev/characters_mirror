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
import '../../enums/character_feature_source_type.dart' as _ilvqooqk;
import '../../enums/feature_relation_type.dart' as _i1fmwm2o;

abstract class FeatureRelationData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FeatureRelationData._({
    this.id,
    required this.sourceType,
    required this.sourceReferenceKey,
    required this.targetType,
    required this.targetReferenceKey,
    required this.relationType,
    this.propertyMappings,
    required this.priority,
    this.mergeDisplay,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory FeatureRelationData({
    int? id,
    required _ilvqooqk.CharacterFeatureSourceType sourceType,
    required String sourceReferenceKey,
    required _ilvqooqk.CharacterFeatureSourceType targetType,
    required String targetReferenceKey,
    required _i1fmwm2o.FeatureRelationType relationType,
    Map<String, String>? propertyMappings,
    required int priority,
    bool? mergeDisplay,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FeatureRelationDataImpl;

  factory FeatureRelationData.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeatureRelationData(
      id: jsonSerialization['id'] as int?,
      sourceType: _ilvqooqk.CharacterFeatureSourceType.fromJson(
        (jsonSerialization['sourceType'] as String),
      ),
      sourceReferenceKey: jsonSerialization['sourceReferenceKey'] as String,
      targetType: _ilvqooqk.CharacterFeatureSourceType.fromJson(
        (jsonSerialization['targetType'] as String),
      ),
      targetReferenceKey: jsonSerialization['targetReferenceKey'] as String,
      relationType: _i1fmwm2o.FeatureRelationType.fromJson(
        (jsonSerialization['relationType'] as String),
      ),
      propertyMappings: jsonSerialization['propertyMappings'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['propertyMappings'],
            ),
      priority: jsonSerialization['priority'] as int,
      mergeDisplay: jsonSerialization['mergeDisplay'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['mergeDisplay']),
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

  _ilvqooqk.CharacterFeatureSourceType sourceType;

  String sourceReferenceKey;

  _ilvqooqk.CharacterFeatureSourceType targetType;

  String targetReferenceKey;

  _i1fmwm2o.FeatureRelationType relationType;

  Map<String, String>? propertyMappings;

  int priority;

  bool? mergeDisplay;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [FeatureRelationData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FeatureRelationData copyWith({
    int? id,
    _ilvqooqk.CharacterFeatureSourceType? sourceType,
    String? sourceReferenceKey,
    _ilvqooqk.CharacterFeatureSourceType? targetType,
    String? targetReferenceKey,
    _i1fmwm2o.FeatureRelationType? relationType,
    Map<String, String>? propertyMappings,
    int? priority,
    bool? mergeDisplay,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeatureRelationData',
      if (id != null) 'id': id,
      'sourceType': sourceType.toJson(),
      'sourceReferenceKey': sourceReferenceKey,
      'targetType': targetType.toJson(),
      'targetReferenceKey': targetReferenceKey,
      'relationType': relationType.toJson(),
      if (propertyMappings != null)
        'propertyMappings': propertyMappings?.toJson(),
      'priority': priority,
      if (mergeDisplay != null) 'mergeDisplay': mergeDisplay,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeatureRelationData',
      if (id != null) 'id': id,
      'sourceType': sourceType.toJson(),
      'sourceReferenceKey': sourceReferenceKey,
      'targetType': targetType.toJson(),
      'targetReferenceKey': targetReferenceKey,
      'relationType': relationType.toJson(),
      if (propertyMappings != null)
        'propertyMappings': propertyMappings?.toJson(),
      'priority': priority,
      if (mergeDisplay != null) 'mergeDisplay': mergeDisplay,
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

class _FeatureRelationDataImpl extends FeatureRelationData {
  _FeatureRelationDataImpl({
    int? id,
    required _ilvqooqk.CharacterFeatureSourceType sourceType,
    required String sourceReferenceKey,
    required _ilvqooqk.CharacterFeatureSourceType targetType,
    required String targetReferenceKey,
    required _i1fmwm2o.FeatureRelationType relationType,
    Map<String, String>? propertyMappings,
    required int priority,
    bool? mergeDisplay,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         sourceType: sourceType,
         sourceReferenceKey: sourceReferenceKey,
         targetType: targetType,
         targetReferenceKey: targetReferenceKey,
         relationType: relationType,
         propertyMappings: propertyMappings,
         priority: priority,
         mergeDisplay: mergeDisplay,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FeatureRelationData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FeatureRelationData copyWith({
    Object? id = _Undefined,
    _ilvqooqk.CharacterFeatureSourceType? sourceType,
    String? sourceReferenceKey,
    _ilvqooqk.CharacterFeatureSourceType? targetType,
    String? targetReferenceKey,
    _i1fmwm2o.FeatureRelationType? relationType,
    Object? propertyMappings = _Undefined,
    int? priority,
    Object? mergeDisplay = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return FeatureRelationData(
      id: id is int? ? id : this.id,
      sourceType: sourceType ?? this.sourceType,
      sourceReferenceKey: sourceReferenceKey ?? this.sourceReferenceKey,
      targetType: targetType ?? this.targetType,
      targetReferenceKey: targetReferenceKey ?? this.targetReferenceKey,
      relationType: relationType ?? this.relationType,
      propertyMappings: propertyMappings is Map<String, String>?
          ? propertyMappings
          : this.propertyMappings?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
      priority: priority ?? this.priority,
      mergeDisplay: mergeDisplay is bool? ? mergeDisplay : this.mergeDisplay,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
