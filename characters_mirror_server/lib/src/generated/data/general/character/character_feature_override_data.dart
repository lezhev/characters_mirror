/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../../../enums/character_feature_source_type.dart' as _i2;
import '../../../enums/feature_tag.dart' as _i3;

abstract class CharacterFeatureOverrideData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CharacterFeatureOverrideData._({
    this.id,
    required this.sourceType,
    required this.sourceId,
    this.name,
    this.description,
    this.tags,
    this.updatedAt,
  });

  factory CharacterFeatureOverrideData({
    String? id,
    required _i2.CharacterFeatureSourceType sourceType,
    required int sourceId,
    String? name,
    String? description,
    List<_i3.FeatureTag>? tags,
    DateTime? updatedAt,
  }) = _CharacterFeatureOverrideDataImpl;

  factory CharacterFeatureOverrideData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterFeatureOverrideData(
      id: jsonSerialization['id'] as String?,
      sourceType: _i2.CharacterFeatureSourceType.fromJson(
          (jsonSerialization['sourceType'] as String)),
      sourceId: jsonSerialization['sourceId'] as int,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      tags: (jsonSerialization['tags'] as List?)
          ?.map((e) => _i3.FeatureTag.fromJson((e as String)))
          .toList(),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  String? id;

  _i2.CharacterFeatureSourceType sourceType;

  int sourceId;

  String? name;

  String? description;

  List<_i3.FeatureTag>? tags;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [CharacterFeatureOverrideData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterFeatureOverrideData copyWith({
    String? id,
    _i2.CharacterFeatureSourceType? sourceType,
    int? sourceId,
    String? name,
    String? description,
    List<_i3.FeatureTag>? tags,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'sourceType': sourceType.toJson(),
      'sourceId': sourceId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'sourceType': sourceType.toJson(),
      'sourceId': sourceId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterFeatureOverrideDataImpl extends CharacterFeatureOverrideData {
  _CharacterFeatureOverrideDataImpl({
    String? id,
    required _i2.CharacterFeatureSourceType sourceType,
    required int sourceId,
    String? name,
    String? description,
    List<_i3.FeatureTag>? tags,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          sourceType: sourceType,
          sourceId: sourceId,
          name: name,
          description: description,
          tags: tags,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [CharacterFeatureOverrideData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterFeatureOverrideData copyWith({
    Object? id = _Undefined,
    _i2.CharacterFeatureSourceType? sourceType,
    int? sourceId,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? tags = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return CharacterFeatureOverrideData(
      id: id is String? ? id : this.id,
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      tags: tags is List<_i3.FeatureTag>?
          ? tags
          : this.tags?.map((e0) => e0).toList(),
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
