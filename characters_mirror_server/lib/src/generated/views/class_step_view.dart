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
import '../data/general/class/class_data.dart' as _i2;
import '../data/general/class/class_feature_data.dart' as _i3;
import '../data/general/class/subclass_feature_data.dart' as _i4;
import '../views/class_step_feature_view.dart' as _i5;
import '../views/class_step_subclass_choice_view.dart' as _i6;
import '../views/choice_group_view.dart' as _i7;
import '../views/skill_selection_group_view.dart' as _i8;
import '../views/class_spell_selection_group_view.dart' as _i9;
import '../views/starting_equipment_block_view.dart' as _i10;
import '../views/proficiency_bundle_view.dart' as _i11;
import '../data/general/class/class_level_data.dart' as _i12;
import '../data/general/feature_modifier_data.dart' as _i13;

abstract class ClassStepView
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ClassStepView._({
    this.classData,
    this.selectedLevel,
    this.currentLevelFeatures,
    this.futureLevelFeatures,
    this.currentSubclassFeatures,
    this.futureSubclassFeatures,
    this.currentLevelFeatureViews,
    this.futureLevelFeatureViews,
    this.currentSubclassFeatureViews,
    this.futureSubclassFeatureViews,
    this.subclassChoice,
    this.choiceGroups,
    this.skillSelectionGroups,
    this.spellSelectionGroups,
    this.startingEquipmentBlocks,
    this.startingProficiencies,
    this.multiclassWarnings,
    this.progression,
    this.featureModifiers,
  });

  factory ClassStepView({
    _i2.ClassData? classData,
    int? selectedLevel,
    List<_i3.ClassFeatureData>? currentLevelFeatures,
    List<_i3.ClassFeatureData>? futureLevelFeatures,
    List<_i4.SubclassFeatureData>? currentSubclassFeatures,
    List<_i4.SubclassFeatureData>? futureSubclassFeatures,
    List<_i5.ClassStepFeatureView>? currentLevelFeatureViews,
    List<_i5.ClassStepFeatureView>? futureLevelFeatureViews,
    List<_i5.ClassStepFeatureView>? currentSubclassFeatureViews,
    List<_i5.ClassStepFeatureView>? futureSubclassFeatureViews,
    _i6.ClassStepSubclassChoiceView? subclassChoice,
    List<_i7.ChoiceGroupView>? choiceGroups,
    List<_i8.SkillSelectionGroupView>? skillSelectionGroups,
    List<_i9.ClassSpellSelectionGroupView>? spellSelectionGroups,
    List<_i10.StartingEquipmentBlockView>? startingEquipmentBlocks,
    _i11.ProficiencyBundleView? startingProficiencies,
    List<String>? multiclassWarnings,
    List<_i12.ClassLevelData>? progression,
    List<_i13.FeatureModifierData>? featureModifiers,
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
      currentLevelFeatureViews: (jsonSerialization['currentLevelFeatureViews']
              as List?)
          ?.map((e) =>
              _i5.ClassStepFeatureView.fromJson((e as Map<String, dynamic>)))
          .toList(),
      futureLevelFeatureViews: (jsonSerialization['futureLevelFeatureViews']
              as List?)
          ?.map((e) =>
              _i5.ClassStepFeatureView.fromJson((e as Map<String, dynamic>)))
          .toList(),
      currentSubclassFeatureViews:
          (jsonSerialization['currentSubclassFeatureViews'] as List?)
              ?.map((e) => _i5.ClassStepFeatureView.fromJson(
                  (e as Map<String, dynamic>)))
              .toList(),
      futureSubclassFeatureViews:
          (jsonSerialization['futureSubclassFeatureViews'] as List?)
              ?.map((e) => _i5.ClassStepFeatureView.fromJson(
                  (e as Map<String, dynamic>)))
              .toList(),
      subclassChoice: jsonSerialization['subclassChoice'] == null
          ? null
          : _i6.ClassStepSubclassChoiceView.fromJson(
              (jsonSerialization['subclassChoice'] as Map<String, dynamic>)),
      choiceGroups: (jsonSerialization['choiceGroups'] as List?)
          ?.map(
              (e) => _i7.ChoiceGroupView.fromJson((e as Map<String, dynamic>)))
          .toList(),
      skillSelectionGroups: (jsonSerialization['skillSelectionGroups'] as List?)
          ?.map((e) =>
              _i8.SkillSelectionGroupView.fromJson((e as Map<String, dynamic>)))
          .toList(),
      spellSelectionGroups: (jsonSerialization['spellSelectionGroups'] as List?)
          ?.map((e) => _i9.ClassSpellSelectionGroupView.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      startingEquipmentBlocks:
          (jsonSerialization['startingEquipmentBlocks'] as List?)
              ?.map((e) => _i10.StartingEquipmentBlockView.fromJson(
                  (e as Map<String, dynamic>)))
              .toList(),
      startingProficiencies: jsonSerialization['startingProficiencies'] == null
          ? null
          : _i11.ProficiencyBundleView.fromJson(
              (jsonSerialization['startingProficiencies']
                  as Map<String, dynamic>)),
      multiclassWarnings: (jsonSerialization['multiclassWarnings'] as List?)
          ?.map((e) => e as String)
          .toList(),
      progression: (jsonSerialization['progression'] as List?)
          ?.map(
              (e) => _i12.ClassLevelData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      featureModifiers: (jsonSerialization['featureModifiers'] as List?)
          ?.map((e) =>
              _i13.FeatureModifierData.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  _i2.ClassData? classData;

  int? selectedLevel;

  List<_i3.ClassFeatureData>? currentLevelFeatures;

  List<_i3.ClassFeatureData>? futureLevelFeatures;

  List<_i4.SubclassFeatureData>? currentSubclassFeatures;

  List<_i4.SubclassFeatureData>? futureSubclassFeatures;

  List<_i5.ClassStepFeatureView>? currentLevelFeatureViews;

  List<_i5.ClassStepFeatureView>? futureLevelFeatureViews;

  List<_i5.ClassStepFeatureView>? currentSubclassFeatureViews;

  List<_i5.ClassStepFeatureView>? futureSubclassFeatureViews;

  _i6.ClassStepSubclassChoiceView? subclassChoice;

  List<_i7.ChoiceGroupView>? choiceGroups;

  List<_i8.SkillSelectionGroupView>? skillSelectionGroups;

  List<_i9.ClassSpellSelectionGroupView>? spellSelectionGroups;

  List<_i10.StartingEquipmentBlockView>? startingEquipmentBlocks;

  _i11.ProficiencyBundleView? startingProficiencies;

  List<String>? multiclassWarnings;

  List<_i12.ClassLevelData>? progression;

  List<_i13.FeatureModifierData>? featureModifiers;

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
    List<_i5.ClassStepFeatureView>? currentLevelFeatureViews,
    List<_i5.ClassStepFeatureView>? futureLevelFeatureViews,
    List<_i5.ClassStepFeatureView>? currentSubclassFeatureViews,
    List<_i5.ClassStepFeatureView>? futureSubclassFeatureViews,
    _i6.ClassStepSubclassChoiceView? subclassChoice,
    List<_i7.ChoiceGroupView>? choiceGroups,
    List<_i8.SkillSelectionGroupView>? skillSelectionGroups,
    List<_i9.ClassSpellSelectionGroupView>? spellSelectionGroups,
    List<_i10.StartingEquipmentBlockView>? startingEquipmentBlocks,
    _i11.ProficiencyBundleView? startingProficiencies,
    List<String>? multiclassWarnings,
    List<_i12.ClassLevelData>? progression,
    List<_i13.FeatureModifierData>? featureModifiers,
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
      if (currentLevelFeatureViews != null)
        'currentLevelFeatureViews':
            currentLevelFeatureViews?.toJson(valueToJson: (v) => v.toJson()),
      if (futureLevelFeatureViews != null)
        'futureLevelFeatureViews':
            futureLevelFeatureViews?.toJson(valueToJson: (v) => v.toJson()),
      if (currentSubclassFeatureViews != null)
        'currentSubclassFeatureViews':
            currentSubclassFeatureViews?.toJson(valueToJson: (v) => v.toJson()),
      if (futureSubclassFeatureViews != null)
        'futureSubclassFeatureViews':
            futureSubclassFeatureViews?.toJson(valueToJson: (v) => v.toJson()),
      if (subclassChoice != null) 'subclassChoice': subclassChoice?.toJson(),
      if (choiceGroups != null)
        'choiceGroups': choiceGroups?.toJson(valueToJson: (v) => v.toJson()),
      if (skillSelectionGroups != null)
        'skillSelectionGroups':
            skillSelectionGroups?.toJson(valueToJson: (v) => v.toJson()),
      if (spellSelectionGroups != null)
        'spellSelectionGroups':
            spellSelectionGroups?.toJson(valueToJson: (v) => v.toJson()),
      if (startingEquipmentBlocks != null)
        'startingEquipmentBlocks':
            startingEquipmentBlocks?.toJson(valueToJson: (v) => v.toJson()),
      if (startingProficiencies != null)
        'startingProficiencies': startingProficiencies?.toJson(),
      if (multiclassWarnings != null)
        'multiclassWarnings': multiclassWarnings?.toJson(),
      if (progression != null)
        'progression': progression?.toJson(valueToJson: (v) => v.toJson()),
      if (featureModifiers != null)
        'featureModifiers':
            featureModifiers?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (classData != null) 'classData': classData?.toJsonForProtocol(),
      if (selectedLevel != null) 'selectedLevel': selectedLevel,
      if (currentLevelFeatures != null)
        'currentLevelFeatures': currentLevelFeatures?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (futureLevelFeatures != null)
        'futureLevelFeatures': futureLevelFeatures?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (currentSubclassFeatures != null)
        'currentSubclassFeatures': currentSubclassFeatures?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (futureSubclassFeatures != null)
        'futureSubclassFeatures': futureSubclassFeatures?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (currentLevelFeatureViews != null)
        'currentLevelFeatureViews': currentLevelFeatureViews?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (futureLevelFeatureViews != null)
        'futureLevelFeatureViews': futureLevelFeatureViews?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (currentSubclassFeatureViews != null)
        'currentSubclassFeatureViews': currentSubclassFeatureViews?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (futureSubclassFeatureViews != null)
        'futureSubclassFeatureViews': futureSubclassFeatureViews?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (subclassChoice != null)
        'subclassChoice': subclassChoice?.toJsonForProtocol(),
      if (choiceGroups != null)
        'choiceGroups':
            choiceGroups?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (skillSelectionGroups != null)
        'skillSelectionGroups': skillSelectionGroups?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (spellSelectionGroups != null)
        'spellSelectionGroups': spellSelectionGroups?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (startingEquipmentBlocks != null)
        'startingEquipmentBlocks': startingEquipmentBlocks?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (startingProficiencies != null)
        'startingProficiencies': startingProficiencies?.toJsonForProtocol(),
      if (multiclassWarnings != null)
        'multiclassWarnings': multiclassWarnings?.toJson(),
      if (progression != null)
        'progression':
            progression?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (featureModifiers != null)
        'featureModifiers':
            featureModifiers?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
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
    List<_i5.ClassStepFeatureView>? currentLevelFeatureViews,
    List<_i5.ClassStepFeatureView>? futureLevelFeatureViews,
    List<_i5.ClassStepFeatureView>? currentSubclassFeatureViews,
    List<_i5.ClassStepFeatureView>? futureSubclassFeatureViews,
    _i6.ClassStepSubclassChoiceView? subclassChoice,
    List<_i7.ChoiceGroupView>? choiceGroups,
    List<_i8.SkillSelectionGroupView>? skillSelectionGroups,
    List<_i9.ClassSpellSelectionGroupView>? spellSelectionGroups,
    List<_i10.StartingEquipmentBlockView>? startingEquipmentBlocks,
    _i11.ProficiencyBundleView? startingProficiencies,
    List<String>? multiclassWarnings,
    List<_i12.ClassLevelData>? progression,
    List<_i13.FeatureModifierData>? featureModifiers,
  }) : super._(
          classData: classData,
          selectedLevel: selectedLevel,
          currentLevelFeatures: currentLevelFeatures,
          futureLevelFeatures: futureLevelFeatures,
          currentSubclassFeatures: currentSubclassFeatures,
          futureSubclassFeatures: futureSubclassFeatures,
          currentLevelFeatureViews: currentLevelFeatureViews,
          futureLevelFeatureViews: futureLevelFeatureViews,
          currentSubclassFeatureViews: currentSubclassFeatureViews,
          futureSubclassFeatureViews: futureSubclassFeatureViews,
          subclassChoice: subclassChoice,
          choiceGroups: choiceGroups,
          skillSelectionGroups: skillSelectionGroups,
          spellSelectionGroups: spellSelectionGroups,
          startingEquipmentBlocks: startingEquipmentBlocks,
          startingProficiencies: startingProficiencies,
          multiclassWarnings: multiclassWarnings,
          progression: progression,
          featureModifiers: featureModifiers,
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
    Object? currentLevelFeatureViews = _Undefined,
    Object? futureLevelFeatureViews = _Undefined,
    Object? currentSubclassFeatureViews = _Undefined,
    Object? futureSubclassFeatureViews = _Undefined,
    Object? subclassChoice = _Undefined,
    Object? choiceGroups = _Undefined,
    Object? skillSelectionGroups = _Undefined,
    Object? spellSelectionGroups = _Undefined,
    Object? startingEquipmentBlocks = _Undefined,
    Object? startingProficiencies = _Undefined,
    Object? multiclassWarnings = _Undefined,
    Object? progression = _Undefined,
    Object? featureModifiers = _Undefined,
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
      currentLevelFeatureViews: currentLevelFeatureViews
              is List<_i5.ClassStepFeatureView>?
          ? currentLevelFeatureViews
          : this.currentLevelFeatureViews?.map((e0) => e0.copyWith()).toList(),
      futureLevelFeatureViews: futureLevelFeatureViews
              is List<_i5.ClassStepFeatureView>?
          ? futureLevelFeatureViews
          : this.futureLevelFeatureViews?.map((e0) => e0.copyWith()).toList(),
      currentSubclassFeatureViews:
          currentSubclassFeatureViews is List<_i5.ClassStepFeatureView>?
              ? currentSubclassFeatureViews
              : this
                  .currentSubclassFeatureViews
                  ?.map((e0) => e0.copyWith())
                  .toList(),
      futureSubclassFeatureViews:
          futureSubclassFeatureViews is List<_i5.ClassStepFeatureView>?
              ? futureSubclassFeatureViews
              : this
                  .futureSubclassFeatureViews
                  ?.map((e0) => e0.copyWith())
                  .toList(),
      subclassChoice: subclassChoice is _i6.ClassStepSubclassChoiceView?
          ? subclassChoice
          : this.subclassChoice?.copyWith(),
      choiceGroups: choiceGroups is List<_i7.ChoiceGroupView>?
          ? choiceGroups
          : this.choiceGroups?.map((e0) => e0.copyWith()).toList(),
      skillSelectionGroups:
          skillSelectionGroups is List<_i8.SkillSelectionGroupView>?
              ? skillSelectionGroups
              : this.skillSelectionGroups?.map((e0) => e0.copyWith()).toList(),
      spellSelectionGroups:
          spellSelectionGroups is List<_i9.ClassSpellSelectionGroupView>?
              ? spellSelectionGroups
              : this.spellSelectionGroups?.map((e0) => e0.copyWith()).toList(),
      startingEquipmentBlocks: startingEquipmentBlocks
              is List<_i10.StartingEquipmentBlockView>?
          ? startingEquipmentBlocks
          : this.startingEquipmentBlocks?.map((e0) => e0.copyWith()).toList(),
      startingProficiencies:
          startingProficiencies is _i11.ProficiencyBundleView?
              ? startingProficiencies
              : this.startingProficiencies?.copyWith(),
      multiclassWarnings: multiclassWarnings is List<String>?
          ? multiclassWarnings
          : this.multiclassWarnings?.map((e0) => e0).toList(),
      progression: progression is List<_i12.ClassLevelData>?
          ? progression
          : this.progression?.map((e0) => e0.copyWith()).toList(),
      featureModifiers: featureModifiers is List<_i13.FeatureModifierData>?
          ? featureModifiers
          : this.featureModifiers?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
