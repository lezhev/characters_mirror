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
import '../../enums/choice_requirement_type.dart' as _i2;
import '../../enums/ability.dart' as _i3;

abstract class ChoiceRequirementData implements _i1.SerializableModel {
  ChoiceRequirementData._({
    required this.type,
    this.classKey,
    this.ability,
    this.value,
    this.referenceKey,
    this.choiceGroupKey,
    this.optionKey,
  });

  factory ChoiceRequirementData({
    required _i2.ChoiceRequirementType type,
    String? classKey,
    _i3.Ability? ability,
    int? value,
    String? referenceKey,
    String? choiceGroupKey,
    String? optionKey,
  }) = _ChoiceRequirementDataImpl;

  factory ChoiceRequirementData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ChoiceRequirementData(
      type: _i2.ChoiceRequirementType.fromJson(
          (jsonSerialization['type'] as String)),
      classKey: jsonSerialization['classKey'] as String?,
      ability: jsonSerialization['ability'] == null
          ? null
          : _i3.Ability.fromJson((jsonSerialization['ability'] as String)),
      value: jsonSerialization['value'] as int?,
      referenceKey: jsonSerialization['referenceKey'] as String?,
      choiceGroupKey: jsonSerialization['choiceGroupKey'] as String?,
      optionKey: jsonSerialization['optionKey'] as String?,
    );
  }

  _i2.ChoiceRequirementType type;

  String? classKey;

  _i3.Ability? ability;

  int? value;

  String? referenceKey;

  String? choiceGroupKey;

  String? optionKey;

  /// Returns a shallow copy of this [ChoiceRequirementData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChoiceRequirementData copyWith({
    _i2.ChoiceRequirementType? type,
    String? classKey,
    _i3.Ability? ability,
    int? value,
    String? referenceKey,
    String? choiceGroupKey,
    String? optionKey,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type.toJson(),
      if (classKey != null) 'classKey': classKey,
      if (ability != null) 'ability': ability?.toJson(),
      if (value != null) 'value': value,
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (choiceGroupKey != null) 'choiceGroupKey': choiceGroupKey,
      if (optionKey != null) 'optionKey': optionKey,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChoiceRequirementDataImpl extends ChoiceRequirementData {
  _ChoiceRequirementDataImpl({
    required _i2.ChoiceRequirementType type,
    String? classKey,
    _i3.Ability? ability,
    int? value,
    String? referenceKey,
    String? choiceGroupKey,
    String? optionKey,
  }) : super._(
          type: type,
          classKey: classKey,
          ability: ability,
          value: value,
          referenceKey: referenceKey,
          choiceGroupKey: choiceGroupKey,
          optionKey: optionKey,
        );

  /// Returns a shallow copy of this [ChoiceRequirementData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChoiceRequirementData copyWith({
    _i2.ChoiceRequirementType? type,
    Object? classKey = _Undefined,
    Object? ability = _Undefined,
    Object? value = _Undefined,
    Object? referenceKey = _Undefined,
    Object? choiceGroupKey = _Undefined,
    Object? optionKey = _Undefined,
  }) {
    return ChoiceRequirementData(
      type: type ?? this.type,
      classKey: classKey is String? ? classKey : this.classKey,
      ability: ability is _i3.Ability? ? ability : this.ability,
      value: value is int? ? value : this.value,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      choiceGroupKey:
          choiceGroupKey is String? ? choiceGroupKey : this.choiceGroupKey,
      optionKey: optionKey is String? ? optionKey : this.optionKey,
    );
  }
}
