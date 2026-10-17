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
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
import '../data/general/character/character_resource_view_data.dart'
    as _iocsu8t1;
import '../data/general/class/class_feature_data.dart' as _ikfzlvib;
import '../data/general/class/subclass_feature_data.dart' as _itaxdcfb;
import '../views/feature_display_property_view.dart' as _imbo00y5;

abstract class ClassStepFeatureView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ClassStepFeatureView._({
    this.classFeature,
    this.subclassFeature,
    this.displayProperties,
    this.resources,
  });

  factory ClassStepFeatureView({
    _ikfzlvib.ClassFeatureData? classFeature,
    _itaxdcfb.SubclassFeatureData? subclassFeature,
    List<_imbo00y5.FeatureDisplayPropertyView>? displayProperties,
    List<_iocsu8t1.CharacterResourceViewData>? resources,
  }) = _ClassStepFeatureViewImpl;

  factory ClassStepFeatureView.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ClassStepFeatureView(
      classFeature: jsonSerialization['classFeature'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_ikfzlvib.ClassFeatureData>(
              jsonSerialization['classFeature'],
            ),
      subclassFeature: jsonSerialization['subclassFeature'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_itaxdcfb.SubclassFeatureData>(
              jsonSerialization['subclassFeature'],
            ),
      displayProperties: jsonSerialization['displayProperties'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_imbo00y5.FeatureDisplayPropertyView>>(
                  jsonSerialization['displayProperties'],
                ),
      resources: jsonSerialization['resources'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_iocsu8t1.CharacterResourceViewData>>(
                  jsonSerialization['resources'],
                ),
    );
  }

  _ikfzlvib.ClassFeatureData? classFeature;

  _itaxdcfb.SubclassFeatureData? subclassFeature;

  List<_imbo00y5.FeatureDisplayPropertyView>? displayProperties;

  List<_iocsu8t1.CharacterResourceViewData>? resources;

  /// Returns a shallow copy of this [ClassStepFeatureView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ClassStepFeatureView copyWith({
    _ikfzlvib.ClassFeatureData? classFeature,
    _itaxdcfb.SubclassFeatureData? subclassFeature,
    List<_imbo00y5.FeatureDisplayPropertyView>? displayProperties,
    List<_iocsu8t1.CharacterResourceViewData>? resources,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClassStepFeatureView',
      if (classFeature != null) 'classFeature': classFeature?.toJson(),
      if (subclassFeature != null) 'subclassFeature': subclassFeature?.toJson(),
      if (displayProperties != null)
        'displayProperties': displayProperties?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (resources != null)
        'resources': resources?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClassStepFeatureView',
      if (classFeature != null)
        'classFeature': classFeature?.toJsonForProtocol(),
      if (subclassFeature != null)
        'subclassFeature': subclassFeature?.toJsonForProtocol(),
      if (displayProperties != null)
        'displayProperties': displayProperties?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (resources != null)
        'resources': resources?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassStepFeatureViewImpl extends ClassStepFeatureView {
  _ClassStepFeatureViewImpl({
    _ikfzlvib.ClassFeatureData? classFeature,
    _itaxdcfb.SubclassFeatureData? subclassFeature,
    List<_imbo00y5.FeatureDisplayPropertyView>? displayProperties,
    List<_iocsu8t1.CharacterResourceViewData>? resources,
  }) : super._(
         classFeature: classFeature,
         subclassFeature: subclassFeature,
         displayProperties: displayProperties,
         resources: resources,
       );

  /// Returns a shallow copy of this [ClassStepFeatureView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ClassStepFeatureView copyWith({
    Object? classFeature = _Undefined,
    Object? subclassFeature = _Undefined,
    Object? displayProperties = _Undefined,
    Object? resources = _Undefined,
  }) {
    return ClassStepFeatureView(
      classFeature: classFeature is _ikfzlvib.ClassFeatureData?
          ? classFeature
          : this.classFeature?.copyWith(),
      subclassFeature: subclassFeature is _itaxdcfb.SubclassFeatureData?
          ? subclassFeature
          : this.subclassFeature?.copyWith(),
      displayProperties:
          displayProperties is List<_imbo00y5.FeatureDisplayPropertyView>?
          ? displayProperties
          : this.displayProperties?.map((e0) => e0.copyWith()).toList(),
      resources: resources is List<_iocsu8t1.CharacterResourceViewData>?
          ? resources
          : this.resources?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
