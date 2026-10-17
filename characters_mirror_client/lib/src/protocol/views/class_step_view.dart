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
import 'package:characters_mirror_client/src/protocol/protocol.dart'
    as _isnx6jbi;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../data/general/class/class_data.dart' as _iazz3r73;
import '../data/general/class/class_feature_data.dart' as _ikfzlvib;
import '../data/general/class/class_level_data.dart' as _isltky3q;
import '../data/general/class/subclass_feature_data.dart' as _itaxdcfb;
import '../data/general/feature_modifier_data.dart' as _izvavhwe;
import '../views/choice_group_view.dart' as _i8vdv0v3;
import '../views/class_spell_selection_group_view.dart' as _inoc2q7y;
import '../views/class_step_feature_view.dart' as _iz0dpit7;
import '../views/class_step_subclass_choice_view.dart' as _iidev6by;
import '../views/proficiency_bundle_view.dart' as _i1vdqqdk;
import '../views/skill_selection_group_view.dart' as _ihq8n2m8;
import '../views/starting_equipment_block_view.dart' as _ixcahpkd;

abstract class ClassStepView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    _iazz3r73.ClassData? classData,
    int? selectedLevel,
    List<_ikfzlvib.ClassFeatureData>? currentLevelFeatures,
    List<_ikfzlvib.ClassFeatureData>? futureLevelFeatures,
    List<_itaxdcfb.SubclassFeatureData>? currentSubclassFeatures,
    List<_itaxdcfb.SubclassFeatureData>? futureSubclassFeatures,
    List<_iz0dpit7.ClassStepFeatureView>? currentLevelFeatureViews,
    List<_iz0dpit7.ClassStepFeatureView>? futureLevelFeatureViews,
    List<_iz0dpit7.ClassStepFeatureView>? currentSubclassFeatureViews,
    List<_iz0dpit7.ClassStepFeatureView>? futureSubclassFeatureViews,
    _iidev6by.ClassStepSubclassChoiceView? subclassChoice,
    List<_i8vdv0v3.ChoiceGroupView>? choiceGroups,
    List<_ihq8n2m8.SkillSelectionGroupView>? skillSelectionGroups,
    List<_inoc2q7y.ClassSpellSelectionGroupView>? spellSelectionGroups,
    List<_ixcahpkd.StartingEquipmentBlockView>? startingEquipmentBlocks,
    _i1vdqqdk.ProficiencyBundleView? startingProficiencies,
    List<String>? multiclassWarnings,
    List<_isltky3q.ClassLevelData>? progression,
    List<_izvavhwe.FeatureModifierData>? featureModifiers,
  }) = _ClassStepViewImpl;

  factory ClassStepView.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassStepView(
      classData: jsonSerialization['classData'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_iazz3r73.ClassData>(
              jsonSerialization['classData'],
            ),
      selectedLevel: jsonSerialization['selectedLevel'] as int?,
      currentLevelFeatures: jsonSerialization['currentLevelFeatures'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_ikfzlvib.ClassFeatureData>>(
              jsonSerialization['currentLevelFeatures'],
            ),
      futureLevelFeatures: jsonSerialization['futureLevelFeatures'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_ikfzlvib.ClassFeatureData>>(
              jsonSerialization['futureLevelFeatures'],
            ),
      currentSubclassFeatures:
          jsonSerialization['currentSubclassFeatures'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_itaxdcfb.SubclassFeatureData>>(
                  jsonSerialization['currentSubclassFeatures'],
                ),
      futureSubclassFeatures:
          jsonSerialization['futureSubclassFeatures'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_itaxdcfb.SubclassFeatureData>>(
                  jsonSerialization['futureSubclassFeatures'],
                ),
      currentLevelFeatureViews:
          jsonSerialization['currentLevelFeatureViews'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_iz0dpit7.ClassStepFeatureView>>(
                  jsonSerialization['currentLevelFeatureViews'],
                ),
      futureLevelFeatureViews:
          jsonSerialization['futureLevelFeatureViews'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_iz0dpit7.ClassStepFeatureView>>(
                  jsonSerialization['futureLevelFeatureViews'],
                ),
      currentSubclassFeatureViews:
          jsonSerialization['currentSubclassFeatureViews'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_iz0dpit7.ClassStepFeatureView>>(
                  jsonSerialization['currentSubclassFeatureViews'],
                ),
      futureSubclassFeatureViews:
          jsonSerialization['futureSubclassFeatureViews'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_iz0dpit7.ClassStepFeatureView>>(
                  jsonSerialization['futureSubclassFeatureViews'],
                ),
      subclassChoice: jsonSerialization['subclassChoice'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<_iidev6by.ClassStepSubclassChoiceView>(
                  jsonSerialization['subclassChoice'],
                ),
      choiceGroups: jsonSerialization['choiceGroups'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_i8vdv0v3.ChoiceGroupView>>(
              jsonSerialization['choiceGroups'],
            ),
      skillSelectionGroups: jsonSerialization['skillSelectionGroups'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_ihq8n2m8.SkillSelectionGroupView>>(
                  jsonSerialization['skillSelectionGroups'],
                ),
      spellSelectionGroups: jsonSerialization['spellSelectionGroups'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_inoc2q7y.ClassSpellSelectionGroupView>>(
                  jsonSerialization['spellSelectionGroups'],
                ),
      startingEquipmentBlocks:
          jsonSerialization['startingEquipmentBlocks'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_ixcahpkd.StartingEquipmentBlockView>>(
                  jsonSerialization['startingEquipmentBlocks'],
                ),
      startingProficiencies: jsonSerialization['startingProficiencies'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_i1vdqqdk.ProficiencyBundleView>(
              jsonSerialization['startingProficiencies'],
            ),
      multiclassWarnings: jsonSerialization['multiclassWarnings'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['multiclassWarnings'],
            ),
      progression: jsonSerialization['progression'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_isltky3q.ClassLevelData>>(
              jsonSerialization['progression'],
            ),
      featureModifiers: jsonSerialization['featureModifiers'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_izvavhwe.FeatureModifierData>>(
                  jsonSerialization['featureModifiers'],
                ),
    );
  }

  _iazz3r73.ClassData? classData;

  int? selectedLevel;

  List<_ikfzlvib.ClassFeatureData>? currentLevelFeatures;

  List<_ikfzlvib.ClassFeatureData>? futureLevelFeatures;

  List<_itaxdcfb.SubclassFeatureData>? currentSubclassFeatures;

  List<_itaxdcfb.SubclassFeatureData>? futureSubclassFeatures;

  List<_iz0dpit7.ClassStepFeatureView>? currentLevelFeatureViews;

  List<_iz0dpit7.ClassStepFeatureView>? futureLevelFeatureViews;

  List<_iz0dpit7.ClassStepFeatureView>? currentSubclassFeatureViews;

  List<_iz0dpit7.ClassStepFeatureView>? futureSubclassFeatureViews;

  _iidev6by.ClassStepSubclassChoiceView? subclassChoice;

  List<_i8vdv0v3.ChoiceGroupView>? choiceGroups;

  List<_ihq8n2m8.SkillSelectionGroupView>? skillSelectionGroups;

  List<_inoc2q7y.ClassSpellSelectionGroupView>? spellSelectionGroups;

  List<_ixcahpkd.StartingEquipmentBlockView>? startingEquipmentBlocks;

  _i1vdqqdk.ProficiencyBundleView? startingProficiencies;

  List<String>? multiclassWarnings;

  List<_isltky3q.ClassLevelData>? progression;

  List<_izvavhwe.FeatureModifierData>? featureModifiers;

  /// Returns a shallow copy of this [ClassStepView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ClassStepView copyWith({
    _iazz3r73.ClassData? classData,
    int? selectedLevel,
    List<_ikfzlvib.ClassFeatureData>? currentLevelFeatures,
    List<_ikfzlvib.ClassFeatureData>? futureLevelFeatures,
    List<_itaxdcfb.SubclassFeatureData>? currentSubclassFeatures,
    List<_itaxdcfb.SubclassFeatureData>? futureSubclassFeatures,
    List<_iz0dpit7.ClassStepFeatureView>? currentLevelFeatureViews,
    List<_iz0dpit7.ClassStepFeatureView>? futureLevelFeatureViews,
    List<_iz0dpit7.ClassStepFeatureView>? currentSubclassFeatureViews,
    List<_iz0dpit7.ClassStepFeatureView>? futureSubclassFeatureViews,
    _iidev6by.ClassStepSubclassChoiceView? subclassChoice,
    List<_i8vdv0v3.ChoiceGroupView>? choiceGroups,
    List<_ihq8n2m8.SkillSelectionGroupView>? skillSelectionGroups,
    List<_inoc2q7y.ClassSpellSelectionGroupView>? spellSelectionGroups,
    List<_ixcahpkd.StartingEquipmentBlockView>? startingEquipmentBlocks,
    _i1vdqqdk.ProficiencyBundleView? startingProficiencies,
    List<String>? multiclassWarnings,
    List<_isltky3q.ClassLevelData>? progression,
    List<_izvavhwe.FeatureModifierData>? featureModifiers,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClassStepView',
      if (classData != null) 'classData': classData?.toJson(),
      if (selectedLevel != null) 'selectedLevel': selectedLevel,
      if (currentLevelFeatures != null)
        'currentLevelFeatures': currentLevelFeatures?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (futureLevelFeatures != null)
        'futureLevelFeatures': futureLevelFeatures?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (currentSubclassFeatures != null)
        'currentSubclassFeatures': currentSubclassFeatures?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (futureSubclassFeatures != null)
        'futureSubclassFeatures': futureSubclassFeatures?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (currentLevelFeatureViews != null)
        'currentLevelFeatureViews': currentLevelFeatureViews?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (futureLevelFeatureViews != null)
        'futureLevelFeatureViews': futureLevelFeatureViews?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (currentSubclassFeatureViews != null)
        'currentSubclassFeatureViews': currentSubclassFeatureViews?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (futureSubclassFeatureViews != null)
        'futureSubclassFeatureViews': futureSubclassFeatureViews?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (subclassChoice != null) 'subclassChoice': subclassChoice?.toJson(),
      if (choiceGroups != null)
        'choiceGroups': choiceGroups?.toJson(valueToJson: (v) => v.toJson()),
      if (skillSelectionGroups != null)
        'skillSelectionGroups': skillSelectionGroups?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (spellSelectionGroups != null)
        'spellSelectionGroups': spellSelectionGroups?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (startingEquipmentBlocks != null)
        'startingEquipmentBlocks': startingEquipmentBlocks?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (startingProficiencies != null)
        'startingProficiencies': startingProficiencies?.toJson(),
      if (multiclassWarnings != null)
        'multiclassWarnings': multiclassWarnings?.toJson(),
      if (progression != null)
        'progression': progression?.toJson(valueToJson: (v) => v.toJson()),
      if (featureModifiers != null)
        'featureModifiers': featureModifiers?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClassStepView',
      if (classData != null) 'classData': classData?.toJsonForProtocol(),
      if (selectedLevel != null) 'selectedLevel': selectedLevel,
      if (currentLevelFeatures != null)
        'currentLevelFeatures': currentLevelFeatures?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (futureLevelFeatures != null)
        'futureLevelFeatures': futureLevelFeatures?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (currentSubclassFeatures != null)
        'currentSubclassFeatures': currentSubclassFeatures?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (futureSubclassFeatures != null)
        'futureSubclassFeatures': futureSubclassFeatures?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (currentLevelFeatureViews != null)
        'currentLevelFeatureViews': currentLevelFeatureViews?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (futureLevelFeatureViews != null)
        'futureLevelFeatureViews': futureLevelFeatureViews?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (currentSubclassFeatureViews != null)
        'currentSubclassFeatureViews': currentSubclassFeatureViews?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (futureSubclassFeatureViews != null)
        'futureSubclassFeatureViews': futureSubclassFeatureViews?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (subclassChoice != null)
        'subclassChoice': subclassChoice?.toJsonForProtocol(),
      if (choiceGroups != null)
        'choiceGroups': choiceGroups?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (skillSelectionGroups != null)
        'skillSelectionGroups': skillSelectionGroups?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (spellSelectionGroups != null)
        'spellSelectionGroups': spellSelectionGroups?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (startingEquipmentBlocks != null)
        'startingEquipmentBlocks': startingEquipmentBlocks?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (startingProficiencies != null)
        'startingProficiencies': startingProficiencies?.toJsonForProtocol(),
      if (multiclassWarnings != null)
        'multiclassWarnings': multiclassWarnings?.toJson(),
      if (progression != null)
        'progression': progression?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (featureModifiers != null)
        'featureModifiers': featureModifiers?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassStepViewImpl extends ClassStepView {
  _ClassStepViewImpl({
    _iazz3r73.ClassData? classData,
    int? selectedLevel,
    List<_ikfzlvib.ClassFeatureData>? currentLevelFeatures,
    List<_ikfzlvib.ClassFeatureData>? futureLevelFeatures,
    List<_itaxdcfb.SubclassFeatureData>? currentSubclassFeatures,
    List<_itaxdcfb.SubclassFeatureData>? futureSubclassFeatures,
    List<_iz0dpit7.ClassStepFeatureView>? currentLevelFeatureViews,
    List<_iz0dpit7.ClassStepFeatureView>? futureLevelFeatureViews,
    List<_iz0dpit7.ClassStepFeatureView>? currentSubclassFeatureViews,
    List<_iz0dpit7.ClassStepFeatureView>? futureSubclassFeatureViews,
    _iidev6by.ClassStepSubclassChoiceView? subclassChoice,
    List<_i8vdv0v3.ChoiceGroupView>? choiceGroups,
    List<_ihq8n2m8.SkillSelectionGroupView>? skillSelectionGroups,
    List<_inoc2q7y.ClassSpellSelectionGroupView>? spellSelectionGroups,
    List<_ixcahpkd.StartingEquipmentBlockView>? startingEquipmentBlocks,
    _i1vdqqdk.ProficiencyBundleView? startingProficiencies,
    List<String>? multiclassWarnings,
    List<_isltky3q.ClassLevelData>? progression,
    List<_izvavhwe.FeatureModifierData>? featureModifiers,
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
  @_isc.useResult
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
      classData: classData is _iazz3r73.ClassData?
          ? classData
          : this.classData?.copyWith(),
      selectedLevel: selectedLevel is int? ? selectedLevel : this.selectedLevel,
      currentLevelFeatures:
          currentLevelFeatures is List<_ikfzlvib.ClassFeatureData>?
          ? currentLevelFeatures
          : this.currentLevelFeatures?.map((e0) => e0.copyWith()).toList(),
      futureLevelFeatures:
          futureLevelFeatures is List<_ikfzlvib.ClassFeatureData>?
          ? futureLevelFeatures
          : this.futureLevelFeatures?.map((e0) => e0.copyWith()).toList(),
      currentSubclassFeatures:
          currentSubclassFeatures is List<_itaxdcfb.SubclassFeatureData>?
          ? currentSubclassFeatures
          : this.currentSubclassFeatures?.map((e0) => e0.copyWith()).toList(),
      futureSubclassFeatures:
          futureSubclassFeatures is List<_itaxdcfb.SubclassFeatureData>?
          ? futureSubclassFeatures
          : this.futureSubclassFeatures?.map((e0) => e0.copyWith()).toList(),
      currentLevelFeatureViews:
          currentLevelFeatureViews is List<_iz0dpit7.ClassStepFeatureView>?
          ? currentLevelFeatureViews
          : this.currentLevelFeatureViews?.map((e0) => e0.copyWith()).toList(),
      futureLevelFeatureViews:
          futureLevelFeatureViews is List<_iz0dpit7.ClassStepFeatureView>?
          ? futureLevelFeatureViews
          : this.futureLevelFeatureViews?.map((e0) => e0.copyWith()).toList(),
      currentSubclassFeatureViews:
          currentSubclassFeatureViews is List<_iz0dpit7.ClassStepFeatureView>?
          ? currentSubclassFeatureViews
          : this.currentSubclassFeatureViews
                ?.map((e0) => e0.copyWith())
                .toList(),
      futureSubclassFeatureViews:
          futureSubclassFeatureViews is List<_iz0dpit7.ClassStepFeatureView>?
          ? futureSubclassFeatureViews
          : this.futureSubclassFeatureViews
                ?.map((e0) => e0.copyWith())
                .toList(),
      subclassChoice: subclassChoice is _iidev6by.ClassStepSubclassChoiceView?
          ? subclassChoice
          : this.subclassChoice?.copyWith(),
      choiceGroups: choiceGroups is List<_i8vdv0v3.ChoiceGroupView>?
          ? choiceGroups
          : this.choiceGroups?.map((e0) => e0.copyWith()).toList(),
      skillSelectionGroups:
          skillSelectionGroups is List<_ihq8n2m8.SkillSelectionGroupView>?
          ? skillSelectionGroups
          : this.skillSelectionGroups?.map((e0) => e0.copyWith()).toList(),
      spellSelectionGroups:
          spellSelectionGroups is List<_inoc2q7y.ClassSpellSelectionGroupView>?
          ? spellSelectionGroups
          : this.spellSelectionGroups?.map((e0) => e0.copyWith()).toList(),
      startingEquipmentBlocks:
          startingEquipmentBlocks is List<_ixcahpkd.StartingEquipmentBlockView>?
          ? startingEquipmentBlocks
          : this.startingEquipmentBlocks?.map((e0) => e0.copyWith()).toList(),
      startingProficiencies:
          startingProficiencies is _i1vdqqdk.ProficiencyBundleView?
          ? startingProficiencies
          : this.startingProficiencies?.copyWith(),
      multiclassWarnings: multiclassWarnings is List<String>?
          ? multiclassWarnings
          : this.multiclassWarnings?.map((e0) => e0).toList(),
      progression: progression is List<_isltky3q.ClassLevelData>?
          ? progression
          : this.progression?.map((e0) => e0.copyWith()).toList(),
      featureModifiers: featureModifiers is List<_izvavhwe.FeatureModifierData>?
          ? featureModifiers
          : this.featureModifiers?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
