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

abstract class CharacterFeatureViewData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CharacterFeatureViewData._({
    required this.sourceType,
    required this.sourceId,
    this.sourceName,
    this.level,
    this.defaultName,
    this.defaultDescription,
    this.defaultTags,
    this.name,
    this.description,
    this.tags,
    this.isCustomized,
  });

  factory CharacterFeatureViewData({
    required _i2.CharacterFeatureSourceType sourceType,
    required int sourceId,
    String? sourceName,
    int? level,
    String? defaultName,
    String? defaultDescription,
    List<_i3.FeatureTag>? defaultTags,
    String? name,
    String? description,
    List<_i3.FeatureTag>? tags,
    bool? isCustomized,
  }) = _CharacterFeatureViewDataImpl;

  factory CharacterFeatureViewData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterFeatureViewData(
      sourceType: _i2.CharacterFeatureSourceType.fromJson(
          (jsonSerialization['sourceType'] as String)),
      sourceId: jsonSerialization['sourceId'] as int,
      sourceName: jsonSerialization['sourceName'] as String?,
      level: jsonSerialization['level'] as int?,
      defaultName: jsonSerialization['defaultName'] as String?,
      defaultDescription: jsonSerialization['defaultDescription'] as String?,
      defaultTags: (jsonSerialization['defaultTags'] as List?)
          ?.map((e) => _i3.FeatureTag.fromJson((e as String)))
          .toList(),
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      tags: (jsonSerialization['tags'] as List?)
          ?.map((e) => _i3.FeatureTag.fromJson((e as String)))
          .toList(),
      isCustomized: jsonSerialization['isCustomized'] as bool?,
    );
  }

  _i2.CharacterFeatureSourceType sourceType;

  int sourceId;

  String? sourceName;

  int? level;

  String? defaultName;

  String? defaultDescription;

  List<_i3.FeatureTag>? defaultTags;

  String? name;

  String? description;

  List<_i3.FeatureTag>? tags;

  bool? isCustomized;

  /// Returns a shallow copy of this [CharacterFeatureViewData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterFeatureViewData copyWith({
    _i2.CharacterFeatureSourceType? sourceType,
    int? sourceId,
    String? sourceName,
    int? level,
    String? defaultName,
    String? defaultDescription,
    List<_i3.FeatureTag>? defaultTags,
    String? name,
    String? description,
    List<_i3.FeatureTag>? tags,
    bool? isCustomized,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'sourceType': sourceType.toJson(),
      'sourceId': sourceId,
      if (sourceName != null) 'sourceName': sourceName,
      if (level != null) 'level': level,
      if (defaultName != null) 'defaultName': defaultName,
      if (defaultDescription != null) 'defaultDescription': defaultDescription,
      if (defaultTags != null)
        'defaultTags': defaultTags?.toJson(valueToJson: (v) => v.toJson()),
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (isCustomized != null) 'isCustomized': isCustomized,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'sourceType': sourceType.toJson(),
      'sourceId': sourceId,
      if (sourceName != null) 'sourceName': sourceName,
      if (level != null) 'level': level,
      if (defaultName != null) 'defaultName': defaultName,
      if (defaultDescription != null) 'defaultDescription': defaultDescription,
      if (defaultTags != null)
        'defaultTags': defaultTags?.toJson(valueToJson: (v) => v.toJson()),
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (isCustomized != null) 'isCustomized': isCustomized,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterFeatureViewDataImpl extends CharacterFeatureViewData {
  _CharacterFeatureViewDataImpl({
    required _i2.CharacterFeatureSourceType sourceType,
    required int sourceId,
    String? sourceName,
    int? level,
    String? defaultName,
    String? defaultDescription,
    List<_i3.FeatureTag>? defaultTags,
    String? name,
    String? description,
    List<_i3.FeatureTag>? tags,
    bool? isCustomized,
  }) : super._(
          sourceType: sourceType,
          sourceId: sourceId,
          sourceName: sourceName,
          level: level,
          defaultName: defaultName,
          defaultDescription: defaultDescription,
          defaultTags: defaultTags,
          name: name,
          description: description,
          tags: tags,
          isCustomized: isCustomized,
        );

  /// Returns a shallow copy of this [CharacterFeatureViewData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterFeatureViewData copyWith({
    _i2.CharacterFeatureSourceType? sourceType,
    int? sourceId,
    Object? sourceName = _Undefined,
    Object? level = _Undefined,
    Object? defaultName = _Undefined,
    Object? defaultDescription = _Undefined,
    Object? defaultTags = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? tags = _Undefined,
    Object? isCustomized = _Undefined,
  }) {
    return CharacterFeatureViewData(
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      sourceName: sourceName is String? ? sourceName : this.sourceName,
      level: level is int? ? level : this.level,
      defaultName: defaultName is String? ? defaultName : this.defaultName,
      defaultDescription: defaultDescription is String?
          ? defaultDescription
          : this.defaultDescription,
      defaultTags: defaultTags is List<_i3.FeatureTag>?
          ? defaultTags
          : this.defaultTags?.map((e0) => e0).toList(),
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      tags: tags is List<_i3.FeatureTag>?
          ? tags
          : this.tags?.map((e0) => e0).toList(),
      isCustomized: isCustomized is bool? ? isCustomized : this.isCustomized,
    );
  }
}
