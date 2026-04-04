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
import '../data/background_data.dart' as _i2;
import '../views/class_choice_group_view.dart' as _i3;

abstract class BackgroundStepView implements _i1.SerializableModel {
  BackgroundStepView._({
    this.background,
    this.choiceGroups,
  });

  factory BackgroundStepView({
    _i2.BackgroundData? background,
    List<_i3.ClassChoiceGroupView>? choiceGroups,
  }) = _BackgroundStepViewImpl;

  factory BackgroundStepView.fromJson(Map<String, dynamic> jsonSerialization) {
    return BackgroundStepView(
      background: jsonSerialization['background'] == null
          ? null
          : _i2.BackgroundData.fromJson(
              (jsonSerialization['background'] as Map<String, dynamic>)),
      choiceGroups: (jsonSerialization['choiceGroups'] as List?)
          ?.map((e) =>
              _i3.ClassChoiceGroupView.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  _i2.BackgroundData? background;

  List<_i3.ClassChoiceGroupView>? choiceGroups;

  /// Returns a shallow copy of this [BackgroundStepView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BackgroundStepView copyWith({
    _i2.BackgroundData? background,
    List<_i3.ClassChoiceGroupView>? choiceGroups,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (background != null) 'background': background?.toJson(),
      if (choiceGroups != null)
        'choiceGroups': choiceGroups?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BackgroundStepViewImpl extends BackgroundStepView {
  _BackgroundStepViewImpl({
    _i2.BackgroundData? background,
    List<_i3.ClassChoiceGroupView>? choiceGroups,
  }) : super._(
          background: background,
          choiceGroups: choiceGroups,
        );

  /// Returns a shallow copy of this [BackgroundStepView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BackgroundStepView copyWith({
    Object? background = _Undefined,
    Object? choiceGroups = _Undefined,
  }) {
    return BackgroundStepView(
      background: background is _i2.BackgroundData?
          ? background
          : this.background?.copyWith(),
      choiceGroups: choiceGroups is List<_i3.ClassChoiceGroupView>?
          ? choiceGroups
          : this.choiceGroups?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
