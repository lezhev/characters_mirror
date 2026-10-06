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
import '../data/general/class/class_feature_data.dart' as _i2;
import '../data/general/class/subclass_feature_data.dart' as _i3;
import '../views/feature_display_property_view.dart' as _i4;
import '../data/general/character/character_resource_view_data.dart' as _i5;

abstract class ClassStepFeatureView implements _i1.SerializableModel {
  ClassStepFeatureView._({
    this.classFeature,
    this.subclassFeature,
    this.displayProperties,
    this.resources,
  });

  factory ClassStepFeatureView({
    _i2.ClassFeatureData? classFeature,
    _i3.SubclassFeatureData? subclassFeature,
    List<_i4.FeatureDisplayPropertyView>? displayProperties,
    List<_i5.CharacterResourceViewData>? resources,
  }) = _ClassStepFeatureViewImpl;

  factory ClassStepFeatureView.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ClassStepFeatureView(
      classFeature: jsonSerialization['classFeature'] == null
          ? null
          : _i2.ClassFeatureData.fromJson(
              (jsonSerialization['classFeature'] as Map<String, dynamic>)),
      subclassFeature: jsonSerialization['subclassFeature'] == null
          ? null
          : _i3.SubclassFeatureData.fromJson(
              (jsonSerialization['subclassFeature'] as Map<String, dynamic>)),
      displayProperties: (jsonSerialization['displayProperties'] as List?)
          ?.map((e) => _i4.FeatureDisplayPropertyView.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      resources: (jsonSerialization['resources'] as List?)
          ?.map((e) => _i5.CharacterResourceViewData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
    );
  }

  _i2.ClassFeatureData? classFeature;

  _i3.SubclassFeatureData? subclassFeature;

  List<_i4.FeatureDisplayPropertyView>? displayProperties;

  List<_i5.CharacterResourceViewData>? resources;

  /// Returns a shallow copy of this [ClassStepFeatureView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassStepFeatureView copyWith({
    _i2.ClassFeatureData? classFeature,
    _i3.SubclassFeatureData? subclassFeature,
    List<_i4.FeatureDisplayPropertyView>? displayProperties,
    List<_i5.CharacterResourceViewData>? resources,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (classFeature != null) 'classFeature': classFeature?.toJson(),
      if (subclassFeature != null) 'subclassFeature': subclassFeature?.toJson(),
      if (displayProperties != null)
        'displayProperties':
            displayProperties?.toJson(valueToJson: (v) => v.toJson()),
      if (resources != null)
        'resources': resources?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassStepFeatureViewImpl extends ClassStepFeatureView {
  _ClassStepFeatureViewImpl({
    _i2.ClassFeatureData? classFeature,
    _i3.SubclassFeatureData? subclassFeature,
    List<_i4.FeatureDisplayPropertyView>? displayProperties,
    List<_i5.CharacterResourceViewData>? resources,
  }) : super._(
          classFeature: classFeature,
          subclassFeature: subclassFeature,
          displayProperties: displayProperties,
          resources: resources,
        );

  /// Returns a shallow copy of this [ClassStepFeatureView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassStepFeatureView copyWith({
    Object? classFeature = _Undefined,
    Object? subclassFeature = _Undefined,
    Object? displayProperties = _Undefined,
    Object? resources = _Undefined,
  }) {
    return ClassStepFeatureView(
      classFeature: classFeature is _i2.ClassFeatureData?
          ? classFeature
          : this.classFeature?.copyWith(),
      subclassFeature: subclassFeature is _i3.SubclassFeatureData?
          ? subclassFeature
          : this.subclassFeature?.copyWith(),
      displayProperties:
          displayProperties is List<_i4.FeatureDisplayPropertyView>?
              ? displayProperties
              : this.displayProperties?.map((e0) => e0.copyWith()).toList(),
      resources: resources is List<_i5.CharacterResourceViewData>?
          ? resources
          : this.resources?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
