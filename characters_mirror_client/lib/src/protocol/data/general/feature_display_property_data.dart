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
import '../../enums/feature_display_property_value_kind.dart' as _i4;

abstract class FeatureDisplayPropertyData implements _i1.SerializableModel {
  FeatureDisplayPropertyData._({
    this.id,
    this.sourceClassFeatureId,
    this.sourceClassFeature,
    this.sourceSubclassFeatureId,
    this.sourceSubclassFeature,
    required this.key,
    required this.label,
    required this.valueKind,
    this.staticValue,
    this.progression,
    this.formula,
    this.sortOrder,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory FeatureDisplayPropertyData({
    int? id,
    int? sourceClassFeatureId,
    _i2.ClassFeatureData? sourceClassFeature,
    int? sourceSubclassFeatureId,
    _i3.SubclassFeatureData? sourceSubclassFeature,
    required String key,
    required String label,
    required _i4.FeatureDisplayPropertyValueKind valueKind,
    String? staticValue,
    Map<int, String>? progression,
    String? formula,
    int? sortOrder,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FeatureDisplayPropertyDataImpl;

  factory FeatureDisplayPropertyData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return FeatureDisplayPropertyData(
      id: jsonSerialization['id'] as int?,
      sourceClassFeatureId: jsonSerialization['sourceClassFeatureId'] as int?,
      sourceClassFeature: jsonSerialization['sourceClassFeature'] == null
          ? null
          : _i2.ClassFeatureData.fromJson(
              (jsonSerialization['sourceClassFeature']
                  as Map<String, dynamic>)),
      sourceSubclassFeatureId:
          jsonSerialization['sourceSubclassFeatureId'] as int?,
      sourceSubclassFeature: jsonSerialization['sourceSubclassFeature'] == null
          ? null
          : _i3.SubclassFeatureData.fromJson(
              (jsonSerialization['sourceSubclassFeature']
                  as Map<String, dynamic>)),
      key: jsonSerialization['key'] as String,
      label: jsonSerialization['label'] as String,
      valueKind: _i4.FeatureDisplayPropertyValueKind.fromJson(
          (jsonSerialization['valueKind'] as String)),
      staticValue: jsonSerialization['staticValue'] as String?,
      progression: (jsonSerialization['progression'] as List?)
          ?.fold<Map<int, String>>(
              {}, (t, e) => {...t, e['k'] as int: e['v'] as String}),
      formula: jsonSerialization['formula'] as String?,
      sortOrder: jsonSerialization['sortOrder'] as int?,
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

  int? sourceClassFeatureId;

  _i2.ClassFeatureData? sourceClassFeature;

  int? sourceSubclassFeatureId;

  _i3.SubclassFeatureData? sourceSubclassFeature;

  String key;

  String label;

  _i4.FeatureDisplayPropertyValueKind valueKind;

  String? staticValue;

  Map<int, String>? progression;

  String? formula;

  int? sortOrder;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [FeatureDisplayPropertyData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureDisplayPropertyData copyWith({
    int? id,
    int? sourceClassFeatureId,
    _i2.ClassFeatureData? sourceClassFeature,
    int? sourceSubclassFeatureId,
    _i3.SubclassFeatureData? sourceSubclassFeature,
    String? key,
    String? label,
    _i4.FeatureDisplayPropertyValueKind? valueKind,
    String? staticValue,
    Map<int, String>? progression,
    String? formula,
    int? sortOrder,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (sourceClassFeatureId != null)
        'sourceClassFeatureId': sourceClassFeatureId,
      if (sourceClassFeature != null)
        'sourceClassFeature': sourceClassFeature?.toJson(),
      if (sourceSubclassFeatureId != null)
        'sourceSubclassFeatureId': sourceSubclassFeatureId,
      if (sourceSubclassFeature != null)
        'sourceSubclassFeature': sourceSubclassFeature?.toJson(),
      'key': key,
      'label': label,
      'valueKind': valueKind.toJson(),
      if (staticValue != null) 'staticValue': staticValue,
      if (progression != null) 'progression': progression?.toJson(),
      if (formula != null) 'formula': formula,
      if (sortOrder != null) 'sortOrder': sortOrder,
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

class _FeatureDisplayPropertyDataImpl extends FeatureDisplayPropertyData {
  _FeatureDisplayPropertyDataImpl({
    int? id,
    int? sourceClassFeatureId,
    _i2.ClassFeatureData? sourceClassFeature,
    int? sourceSubclassFeatureId,
    _i3.SubclassFeatureData? sourceSubclassFeature,
    required String key,
    required String label,
    required _i4.FeatureDisplayPropertyValueKind valueKind,
    String? staticValue,
    Map<int, String>? progression,
    String? formula,
    int? sortOrder,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          sourceClassFeatureId: sourceClassFeatureId,
          sourceClassFeature: sourceClassFeature,
          sourceSubclassFeatureId: sourceSubclassFeatureId,
          sourceSubclassFeature: sourceSubclassFeature,
          key: key,
          label: label,
          valueKind: valueKind,
          staticValue: staticValue,
          progression: progression,
          formula: formula,
          sortOrder: sortOrder,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [FeatureDisplayPropertyData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatureDisplayPropertyData copyWith({
    Object? id = _Undefined,
    Object? sourceClassFeatureId = _Undefined,
    Object? sourceClassFeature = _Undefined,
    Object? sourceSubclassFeatureId = _Undefined,
    Object? sourceSubclassFeature = _Undefined,
    String? key,
    String? label,
    _i4.FeatureDisplayPropertyValueKind? valueKind,
    Object? staticValue = _Undefined,
    Object? progression = _Undefined,
    Object? formula = _Undefined,
    Object? sortOrder = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return FeatureDisplayPropertyData(
      id: id is int? ? id : this.id,
      sourceClassFeatureId: sourceClassFeatureId is int?
          ? sourceClassFeatureId
          : this.sourceClassFeatureId,
      sourceClassFeature: sourceClassFeature is _i2.ClassFeatureData?
          ? sourceClassFeature
          : this.sourceClassFeature?.copyWith(),
      sourceSubclassFeatureId: sourceSubclassFeatureId is int?
          ? sourceSubclassFeatureId
          : this.sourceSubclassFeatureId,
      sourceSubclassFeature: sourceSubclassFeature is _i3.SubclassFeatureData?
          ? sourceSubclassFeature
          : this.sourceSubclassFeature?.copyWith(),
      key: key ?? this.key,
      label: label ?? this.label,
      valueKind: valueKind ?? this.valueKind,
      staticValue: staticValue is String? ? staticValue : this.staticValue,
      progression: progression is Map<int, String>?
          ? progression
          : this.progression?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      formula: formula is String? ? formula : this.formula,
      sortOrder: sortOrder is int? ? sortOrder : this.sortOrder,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
