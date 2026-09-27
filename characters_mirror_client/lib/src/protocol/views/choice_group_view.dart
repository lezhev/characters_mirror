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
import '../data/general/choice_group_data.dart' as _i2;
import '../data/general/choice_option_data.dart' as _i3;

abstract class ChoiceGroupView implements _i1.SerializableModel {
  ChoiceGroupView._({
    this.group,
    this.options,
  });

  factory ChoiceGroupView({
    _i2.ChoiceGroupData? group,
    List<_i3.ChoiceOptionData>? options,
  }) = _ChoiceGroupViewImpl;

  factory ChoiceGroupView.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChoiceGroupView(
      group: jsonSerialization['group'] == null
          ? null
          : _i2.ChoiceGroupData.fromJson(
              (jsonSerialization['group'] as Map<String, dynamic>)),
      options: (jsonSerialization['options'] as List?)
          ?.map(
              (e) => _i3.ChoiceOptionData.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  _i2.ChoiceGroupData? group;

  List<_i3.ChoiceOptionData>? options;

  /// Returns a shallow copy of this [ChoiceGroupView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChoiceGroupView copyWith({
    _i2.ChoiceGroupData? group,
    List<_i3.ChoiceOptionData>? options,
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
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChoiceGroupViewImpl extends ChoiceGroupView {
  _ChoiceGroupViewImpl({
    _i2.ChoiceGroupData? group,
    List<_i3.ChoiceOptionData>? options,
  }) : super._(
          group: group,
          options: options,
        );

  /// Returns a shallow copy of this [ChoiceGroupView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChoiceGroupView copyWith({
    Object? group = _Undefined,
    Object? options = _Undefined,
  }) {
    return ChoiceGroupView(
      group: group is _i2.ChoiceGroupData? ? group : this.group?.copyWith(),
      options: options is List<_i3.ChoiceOptionData>?
          ? options
          : this.options?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
