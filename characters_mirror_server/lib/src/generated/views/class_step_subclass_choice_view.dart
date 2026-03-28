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
import '../data/general/class/subclass_data.dart' as _i2;

abstract class ClassStepSubclassChoiceView
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ClassStepSubclassChoiceView._({
    this.requiredLevel,
    this.subclasses,
  });

  factory ClassStepSubclassChoiceView({
    int? requiredLevel,
    List<_i2.SubclassData>? subclasses,
  }) = _ClassStepSubclassChoiceViewImpl;

  factory ClassStepSubclassChoiceView.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ClassStepSubclassChoiceView(
      requiredLevel: jsonSerialization['requiredLevel'] as int?,
      subclasses: (jsonSerialization['subclasses'] as List?)
          ?.map((e) => _i2.SubclassData.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  int? requiredLevel;

  List<_i2.SubclassData>? subclasses;

  /// Returns a shallow copy of this [ClassStepSubclassChoiceView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassStepSubclassChoiceView copyWith({
    int? requiredLevel,
    List<_i2.SubclassData>? subclasses,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (requiredLevel != null) 'requiredLevel': requiredLevel,
      if (subclasses != null)
        'subclasses': subclasses?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (requiredLevel != null) 'requiredLevel': requiredLevel,
      if (subclasses != null)
        'subclasses':
            subclasses?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassStepSubclassChoiceViewImpl extends ClassStepSubclassChoiceView {
  _ClassStepSubclassChoiceViewImpl({
    int? requiredLevel,
    List<_i2.SubclassData>? subclasses,
  }) : super._(
          requiredLevel: requiredLevel,
          subclasses: subclasses,
        );

  /// Returns a shallow copy of this [ClassStepSubclassChoiceView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassStepSubclassChoiceView copyWith({
    Object? requiredLevel = _Undefined,
    Object? subclasses = _Undefined,
  }) {
    return ClassStepSubclassChoiceView(
      requiredLevel: requiredLevel is int? ? requiredLevel : this.requiredLevel,
      subclasses: subclasses is List<_i2.SubclassData>?
          ? subclasses
          : this.subclasses?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
