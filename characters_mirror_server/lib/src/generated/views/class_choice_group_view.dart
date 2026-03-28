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
import '../data/general/class/class_choice_group_data.dart' as _i2;
import '../data/general/class/class_choice_option_data.dart' as _i3;

abstract class ClassChoiceGroupView
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ClassChoiceGroupView._({
    this.group,
    this.options,
  });

  factory ClassChoiceGroupView({
    _i2.ClassChoiceGroupData? group,
    List<_i3.ClassChoiceOptionData>? options,
  }) = _ClassChoiceGroupViewImpl;

  factory ClassChoiceGroupView.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ClassChoiceGroupView(
      group: jsonSerialization['group'] == null
          ? null
          : _i2.ClassChoiceGroupData.fromJson(
              (jsonSerialization['group'] as Map<String, dynamic>)),
      options: (jsonSerialization['options'] as List?)
          ?.map((e) =>
              _i3.ClassChoiceOptionData.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  _i2.ClassChoiceGroupData? group;

  List<_i3.ClassChoiceOptionData>? options;

  /// Returns a shallow copy of this [ClassChoiceGroupView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassChoiceGroupView copyWith({
    _i2.ClassChoiceGroupData? group,
    List<_i3.ClassChoiceOptionData>? options,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (group != null) 'group': group?.toJson(),
      if (options != null)
        'options': options?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (group != null) 'group': group?.toJsonForProtocol(),
      if (options != null)
        'options': options?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassChoiceGroupViewImpl extends ClassChoiceGroupView {
  _ClassChoiceGroupViewImpl({
    _i2.ClassChoiceGroupData? group,
    List<_i3.ClassChoiceOptionData>? options,
  }) : super._(
          group: group,
          options: options,
        );

  /// Returns a shallow copy of this [ClassChoiceGroupView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassChoiceGroupView copyWith({
    Object? group = _Undefined,
    Object? options = _Undefined,
  }) {
    return ClassChoiceGroupView(
      group:
          group is _i2.ClassChoiceGroupData? ? group : this.group?.copyWith(),
      options: options is List<_i3.ClassChoiceOptionData>?
          ? options
          : this.options?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
