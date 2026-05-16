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
import '../../../enums/character_feature_source_type.dart' as _i2;

abstract class CharacterResourceStateData implements _i1.SerializableModel {
  CharacterResourceStateData._({
    required this.sourceType,
    required this.sourceId,
    required this.resourceKey,
    required this.current,
  });

  factory CharacterResourceStateData({
    required _i2.CharacterFeatureSourceType sourceType,
    required int sourceId,
    required String resourceKey,
    required int current,
  }) = _CharacterResourceStateDataImpl;

  factory CharacterResourceStateData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterResourceStateData(
      sourceType: _i2.CharacterFeatureSourceType.fromJson(
          (jsonSerialization['sourceType'] as String)),
      sourceId: jsonSerialization['sourceId'] as int,
      resourceKey: jsonSerialization['resourceKey'] as String,
      current: jsonSerialization['current'] as int,
    );
  }

  _i2.CharacterFeatureSourceType sourceType;

  int sourceId;

  String resourceKey;

  int current;

  /// Returns a shallow copy of this [CharacterResourceStateData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterResourceStateData copyWith({
    _i2.CharacterFeatureSourceType? sourceType,
    int? sourceId,
    String? resourceKey,
    int? current,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'sourceType': sourceType.toJson(),
      'sourceId': sourceId,
      'resourceKey': resourceKey,
      'current': current,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CharacterResourceStateDataImpl extends CharacterResourceStateData {
  _CharacterResourceStateDataImpl({
    required _i2.CharacterFeatureSourceType sourceType,
    required int sourceId,
    required String resourceKey,
    required int current,
  }) : super._(
          sourceType: sourceType,
          sourceId: sourceId,
          resourceKey: resourceKey,
          current: current,
        );

  /// Returns a shallow copy of this [CharacterResourceStateData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterResourceStateData copyWith({
    _i2.CharacterFeatureSourceType? sourceType,
    int? sourceId,
    String? resourceKey,
    int? current,
  }) {
    return CharacterResourceStateData(
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      resourceKey: resourceKey ?? this.resourceKey,
      current: current ?? this.current,
    );
  }
}
