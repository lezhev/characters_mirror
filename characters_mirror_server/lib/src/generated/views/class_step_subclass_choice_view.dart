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
import '../data/general/class/subclass_data.dart' as _ijcb6jld;

abstract class ClassStepSubclassChoiceView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ClassStepSubclassChoiceView._({
    this.requiredLevel,
    this.sourceFeatureId,
    this.subclasses,
  });

  factory ClassStepSubclassChoiceView({
    int? requiredLevel,
    int? sourceFeatureId,
    List<_ijcb6jld.SubclassData>? subclasses,
  }) = _ClassStepSubclassChoiceViewImpl;

  factory ClassStepSubclassChoiceView.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ClassStepSubclassChoiceView(
      requiredLevel: jsonSerialization['requiredLevel'] as int?,
      sourceFeatureId: jsonSerialization['sourceFeatureId'] as int?,
      subclasses: jsonSerialization['subclasses'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ijcb6jld.SubclassData>>(
              jsonSerialization['subclasses'],
            ),
    );
  }

  int? requiredLevel;

  int? sourceFeatureId;

  List<_ijcb6jld.SubclassData>? subclasses;

  /// Returns a shallow copy of this [ClassStepSubclassChoiceView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ClassStepSubclassChoiceView copyWith({
    int? requiredLevel,
    int? sourceFeatureId,
    List<_ijcb6jld.SubclassData>? subclasses,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClassStepSubclassChoiceView',
      if (requiredLevel != null) 'requiredLevel': requiredLevel,
      if (sourceFeatureId != null) 'sourceFeatureId': sourceFeatureId,
      if (subclasses != null)
        'subclasses': subclasses?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClassStepSubclassChoiceView',
      if (requiredLevel != null) 'requiredLevel': requiredLevel,
      if (sourceFeatureId != null) 'sourceFeatureId': sourceFeatureId,
      if (subclasses != null)
        'subclasses': subclasses?.toJson(
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

class _ClassStepSubclassChoiceViewImpl extends ClassStepSubclassChoiceView {
  _ClassStepSubclassChoiceViewImpl({
    int? requiredLevel,
    int? sourceFeatureId,
    List<_ijcb6jld.SubclassData>? subclasses,
  }) : super._(
         requiredLevel: requiredLevel,
         sourceFeatureId: sourceFeatureId,
         subclasses: subclasses,
       );

  /// Returns a shallow copy of this [ClassStepSubclassChoiceView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ClassStepSubclassChoiceView copyWith({
    Object? requiredLevel = _Undefined,
    Object? sourceFeatureId = _Undefined,
    Object? subclasses = _Undefined,
  }) {
    return ClassStepSubclassChoiceView(
      requiredLevel: requiredLevel is int? ? requiredLevel : this.requiredLevel,
      sourceFeatureId: sourceFeatureId is int?
          ? sourceFeatureId
          : this.sourceFeatureId,
      subclasses: subclasses is List<_ijcb6jld.SubclassData>?
          ? subclasses
          : this.subclasses?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
