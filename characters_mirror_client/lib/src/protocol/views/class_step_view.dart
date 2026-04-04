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
import '../data/general/class/class_data.dart' as _i2;
import '../data/general/class/class_feature_data.dart' as _i3;
import '../data/general/class/subclass_feature_data.dart' as _i4;
import '../views/class_step_subclass_choice_view.dart' as _i5;
import '../views/class_choice_group_view.dart' as _i6;
import '../views/proficiency_bundle_view.dart' as _i7;
import '../data/general/class/class_level_data.dart' as _i8;

abstract class ClassStepView implements _i1.SerializableModel {
  ClassStepView._({
    this.classData,
    this.selectedLevel,
    this.currentLevelFeatures,
    this.futureLevelFeatures,
    this.currentSubclassFeatures,
    this.futureSubclassFeatures,
    this.subclassChoice,
    this.choiceGroups,
    this.startingProficiencies,
    this.multiclassWarnings,
    this.progression,
  });

  factory ClassStepView({
    _i2.ClassData? classData,
    int? selectedLevel,
    List<_i3.ClassFeatureData>? currentLevelFeatures,
    List<_i3.ClassFeatureData>? futureLevelFeatures,
    List<_i4.SubclassFeatureData>? currentSubclassFeatures,
    List<_i4.SubclassFeatureData>? futureSubclassFeatures,
    _i5.ClassStepSubclassChoiceView? subclassChoice,
    List<_i6.ClassChoiceGroupView>? choiceGroups,
    _i7.ProficiencyBundleView? startingProficiencies,
    List<String>? multiclassWarnings,
    List<_i8.ClassLevelData>? progression,
  }) = _ClassStepViewImpl;

  factory ClassStepView.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassStepView(
      classData: jsonSerialization['classData'] == null
          ? null
          : _i2.ClassData.fromJson(
              (jsonSerialization['classData'] as Map<String, dynamic>)),
      selectedLevel: jsonSerialization['selectedLevel'] as int?,
      currentLevelFeatures: (jsonSerialization['currentLevelFeatures'] as List?)
          ?.map(
              (e) => _i3.ClassFeatureData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      futureLevelFeatures: (jsonSerialization['futureLevelFeatures'] as List?)
          ?.map(
              (e) => _i3.ClassFeatureData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      currentSubclassFeatures:
          (jsonSerialization['currentSubclassFeatures'] as List?)
              ?.map((e) =>
                  _i4.SubclassFeatureData.fromJson((e as Map<String, dynamic>)))
              .toList(),
      futureSubclassFeatures:
          (jsonSerialization['futureSubclassFeatures'] as List?)
              ?.map((e) =>
                  _i4.SubclassFeatureData.fromJson((e as Map<String, dynamic>)))
              .toList(),
      subclassChoice: jsonSerialization['subclassChoice'] == null
          ? null
          : _i5.ClassStepSubclassChoiceView.fromJson(
              (jsonSerialization['subclassChoice'] as Map<String, dynamic>)),
      choiceGroups: (jsonSerialization['choiceGroups'] as List?)
          ?.map((e) =>
              _i6.ClassChoiceGroupView.fromJson((e as Map<String, dynamic>)))
          .toList(),
      startingProficiencies: jsonSerialization['startingProficiencies'] == null
          ? null
          : _i7.ProficiencyBundleView.fromJson(
              (jsonSerialization['startingProficiencies']
                  as Map<String, dynamic>)),
      multiclassWarnings: (jsonSerialization['multiclassWarnings'] as List?)
          ?.map((e) => e as String)
          .toList(),
      progression: (jsonSerialization['progression'] as List?)
          ?.map((e) => _i8.ClassLevelData.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  _i2.ClassData? classData;

  int? selectedLevel;

  List<_i3.ClassFeatureData>? currentLevelFeatures;

  List<_i3.ClassFeatureData>? futureLevelFeatures;

  List<_i4.SubclassFeatureData>? currentSubclassFeatures;

  List<_i4.SubclassFeatureData>? futureSubclassFeatures;

  _i5.ClassStepSubclassChoiceView? subclassChoice;

  List<_i6.ClassChoiceGroupView>? choiceGroups;

  _i7.ProficiencyBundleView? startingProficiencies;

  List<String>? multiclassWarnings;

  List<_i8.ClassLevelData>? progression;

  /// Returns a shallow copy of this [ClassStepView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassStepView copyWith({
    _i2.ClassData? classData,
    int? selectedLevel,
    List<_i3.ClassFeatureData>? currentLevelFeatures,
    List<_i3.ClassFeatureData>? futureLevelFeatures,
    List<_i4.SubclassFeatureData>? currentSubclassFeatures,
    List<_i4.SubclassFeatureData>? futureSubclassFeatures,
    _i5.ClassStepSubclassChoiceView? subclassChoice,
    List<_i6.ClassChoiceGroupView>? choiceGroups,
    _i7.ProficiencyBundleView? startingProficiencies,
    List<String>? multiclassWarnings,
    List<_i8.ClassLevelData>? progression,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (classData != null) 'classData': classData?.toJson(),
      if (selectedLevel != null) 'selectedLevel': selectedLevel,
      if (currentLevelFeatures != null)
        'currentLevelFeatures':
            currentLevelFeatures?.toJson(valueToJson: (v) => v.toJson()),
      if (futureLevelFeatures != null)
        'futureLevelFeatures':
            futureLevelFeatures?.toJson(valueToJson: (v) => v.toJson()),
      if (currentSubclassFeatures != null)
        'currentSubclassFeatures':
            currentSubclassFeatures?.toJson(valueToJson: (v) => v.toJson()),
      if (futureSubclassFeatures != null)
        'futureSubclassFeatures':
            futureSubclassFeatures?.toJson(valueToJson: (v) => v.toJson()),
      if (subclassChoice != null) 'subclassChoice': subclassChoice?.toJson(),
      if (choiceGroups != null)
        'choiceGroups': choiceGroups?.toJson(valueToJson: (v) => v.toJson()),
      if (startingProficiencies != null)
        'startingProficiencies': startingProficiencies?.toJson(),
      if (multiclassWarnings != null)
        'multiclassWarnings': multiclassWarnings?.toJson(),
      if (progression != null)
        'progression': progression?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassStepViewImpl extends ClassStepView {
  _ClassStepViewImpl({
    _i2.ClassData? classData,
    int? selectedLevel,
    List<_i3.ClassFeatureData>? currentLevelFeatures,
    List<_i3.ClassFeatureData>? futureLevelFeatures,
    List<_i4.SubclassFeatureData>? currentSubclassFeatures,
    List<_i4.SubclassFeatureData>? futureSubclassFeatures,
    _i5.ClassStepSubclassChoiceView? subclassChoice,
    List<_i6.ClassChoiceGroupView>? choiceGroups,
    _i7.ProficiencyBundleView? startingProficiencies,
    List<String>? multiclassWarnings,
    List<_i8.ClassLevelData>? progression,
  }) : super._(
          classData: classData,
          selectedLevel: selectedLevel,
          currentLevelFeatures: currentLevelFeatures,
          futureLevelFeatures: futureLevelFeatures,
          currentSubclassFeatures: currentSubclassFeatures,
          futureSubclassFeatures: futureSubclassFeatures,
          subclassChoice: subclassChoice,
          choiceGroups: choiceGroups,
          startingProficiencies: startingProficiencies,
          multiclassWarnings: multiclassWarnings,
          progression: progression,
        );

  /// Returns a shallow copy of this [ClassStepView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassStepView copyWith({
    Object? classData = _Undefined,
    Object? selectedLevel = _Undefined,
    Object? currentLevelFeatures = _Undefined,
    Object? futureLevelFeatures = _Undefined,
    Object? currentSubclassFeatures = _Undefined,
    Object? futureSubclassFeatures = _Undefined,
    Object? subclassChoice = _Undefined,
    Object? choiceGroups = _Undefined,
    Object? startingProficiencies = _Undefined,
    Object? multiclassWarnings = _Undefined,
    Object? progression = _Undefined,
  }) {
    return ClassStepView(
      classData:
          classData is _i2.ClassData? ? classData : this.classData?.copyWith(),
      selectedLevel: selectedLevel is int? ? selectedLevel : this.selectedLevel,
      currentLevelFeatures: currentLevelFeatures is List<_i3.ClassFeatureData>?
          ? currentLevelFeatures
          : this.currentLevelFeatures?.map((e0) => e0.copyWith()).toList(),
      futureLevelFeatures: futureLevelFeatures is List<_i3.ClassFeatureData>?
          ? futureLevelFeatures
          : this.futureLevelFeatures?.map((e0) => e0.copyWith()).toList(),
      currentSubclassFeatures: currentSubclassFeatures
              is List<_i4.SubclassFeatureData>?
          ? currentSubclassFeatures
          : this.currentSubclassFeatures?.map((e0) => e0.copyWith()).toList(),
      futureSubclassFeatures: futureSubclassFeatures
              is List<_i4.SubclassFeatureData>?
          ? futureSubclassFeatures
          : this.futureSubclassFeatures?.map((e0) => e0.copyWith()).toList(),
      subclassChoice: subclassChoice is _i5.ClassStepSubclassChoiceView?
          ? subclassChoice
          : this.subclassChoice?.copyWith(),
      choiceGroups: choiceGroups is List<_i6.ClassChoiceGroupView>?
          ? choiceGroups
          : this.choiceGroups?.map((e0) => e0.copyWith()).toList(),
      startingProficiencies: startingProficiencies is _i7.ProficiencyBundleView?
          ? startingProficiencies
          : this.startingProficiencies?.copyWith(),
      multiclassWarnings: multiclassWarnings is List<String>?
          ? multiclassWarnings
          : this.multiclassWarnings?.map((e0) => e0).toList(),
      progression: progression is List<_i8.ClassLevelData>?
          ? progression
          : this.progression?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
