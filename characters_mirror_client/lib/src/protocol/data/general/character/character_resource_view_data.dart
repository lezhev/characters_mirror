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
import '../../../enums/feature_resource_kind.dart' as _i2;
import '../../../enums/rest_type.dart' as _i3;
import '../../../enums/feature_resource_trigger.dart' as _i4;

abstract class CharacterResourceViewData implements _i1.SerializableModel {
  CharacterResourceViewData._({
    required this.key,
    this.name,
    required this.kind,
    required this.current,
    required this.max,
    this.isUnlimited,
    this.resetOn,
    this.usageResetOn,
    this.activationTrigger,
  });

  factory CharacterResourceViewData({
    required String key,
    String? name,
    required _i2.FeatureResourceKind kind,
    required int current,
    required int max,
    bool? isUnlimited,
    _i3.RestType? resetOn,
    _i3.RestType? usageResetOn,
    _i4.FeatureResourceTrigger? activationTrigger,
  }) = _CharacterResourceViewDataImpl;

  factory CharacterResourceViewData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterResourceViewData(
      key: jsonSerialization['key'] as String,
      name: jsonSerialization['name'] as String?,
      kind: _i2.FeatureResourceKind.fromJson(
          (jsonSerialization['kind'] as String)),
      current: jsonSerialization['current'] as int,
      max: jsonSerialization['max'] as int,
      isUnlimited: jsonSerialization['isUnlimited'] as bool?,
      resetOn: jsonSerialization['resetOn'] == null
          ? null
          : _i3.RestType.fromJson((jsonSerialization['resetOn'] as String)),
      usageResetOn: jsonSerialization['usageResetOn'] == null
          ? null
          : _i3.RestType.fromJson(
              (jsonSerialization['usageResetOn'] as String)),
      activationTrigger: jsonSerialization['activationTrigger'] == null
          ? null
          : _i4.FeatureResourceTrigger.fromJson(
              (jsonSerialization['activationTrigger'] as String)),
    );
  }

  String key;

  String? name;

  _i2.FeatureResourceKind kind;

  int current;

  int max;

  bool? isUnlimited;

  _i3.RestType? resetOn;

  _i3.RestType? usageResetOn;

  _i4.FeatureResourceTrigger? activationTrigger;

  /// Returns a shallow copy of this [CharacterResourceViewData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterResourceViewData copyWith({
    String? key,
    String? name,
    _i2.FeatureResourceKind? kind,
    int? current,
    int? max,
    bool? isUnlimited,
    _i3.RestType? resetOn,
    _i3.RestType? usageResetOn,
    _i4.FeatureResourceTrigger? activationTrigger,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      if (name != null) 'name': name,
      'kind': kind.toJson(),
      'current': current,
      'max': max,
      if (isUnlimited != null) 'isUnlimited': isUnlimited,
      if (resetOn != null) 'resetOn': resetOn?.toJson(),
      if (usageResetOn != null) 'usageResetOn': usageResetOn?.toJson(),
      if (activationTrigger != null)
        'activationTrigger': activationTrigger?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterResourceViewDataImpl extends CharacterResourceViewData {
  _CharacterResourceViewDataImpl({
    required String key,
    String? name,
    required _i2.FeatureResourceKind kind,
    required int current,
    required int max,
    bool? isUnlimited,
    _i3.RestType? resetOn,
    _i3.RestType? usageResetOn,
    _i4.FeatureResourceTrigger? activationTrigger,
  }) : super._(
          key: key,
          name: name,
          kind: kind,
          current: current,
          max: max,
          isUnlimited: isUnlimited,
          resetOn: resetOn,
          usageResetOn: usageResetOn,
          activationTrigger: activationTrigger,
        );

  /// Returns a shallow copy of this [CharacterResourceViewData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterResourceViewData copyWith({
    String? key,
    Object? name = _Undefined,
    _i2.FeatureResourceKind? kind,
    int? current,
    int? max,
    Object? isUnlimited = _Undefined,
    Object? resetOn = _Undefined,
    Object? usageResetOn = _Undefined,
    Object? activationTrigger = _Undefined,
  }) {
    return CharacterResourceViewData(
      key: key ?? this.key,
      name: name is String? ? name : this.name,
      kind: kind ?? this.kind,
      current: current ?? this.current,
      max: max ?? this.max,
      isUnlimited: isUnlimited is bool? ? isUnlimited : this.isUnlimited,
      resetOn: resetOn is _i3.RestType? ? resetOn : this.resetOn,
      usageResetOn:
          usageResetOn is _i3.RestType? ? usageResetOn : this.usageResetOn,
      activationTrigger: activationTrigger is _i4.FeatureResourceTrigger?
          ? activationTrigger
          : this.activationTrigger,
    );
  }
}
