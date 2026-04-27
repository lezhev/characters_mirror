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
import '../../../enums/character_alignment.dart' as _i2;
import '../../../data/general/race/race_data.dart' as _i3;
import '../../../data/general/race/subrace_data.dart' as _i4;
import '../../../data/background_data.dart' as _i5;
import '../../../data/general/character/character_inventory_item_data.dart'
    as _i6;
import '../../../data/general/character/character_skill_proficiency_state.dart'
    as _i7;
import '../../../enums/ability.dart' as _i8;
import '../../../data/general/character/character_note_data.dart' as _i9;
import '../../../data/general/character/character_attack_data.dart' as _i10;
import '../../../data/general/character/character_feature_override_data.dart'
    as _i11;
import '../../../data/general/character/character_class_entry_data.dart'
    as _i12;
import '../../../data/general/character/character_choice_data.dart' as _i13;
import '../../../data/general/character/character_skill_selection_data.dart'
    as _i14;
import '../../../data/general/character/character_spell_selection_data.dart'
    as _i15;
import '../../../data/general/character/character_starting_equipment_selection_data.dart'
    as _i16;
import '../../../data/general/character/character_derived_data.dart' as _i17;

abstract class CharacterData implements _i1.SerializableModel {
  CharacterData._({
    this.id,
    this.name,
    this.age,
    this.height,
    this.weight,
    this.eyes,
    this.skin,
    this.hair,
    this.appearance,
    this.backstory,
    this.goals,
    this.alliesOrganizations,
    this.personalityTraits,
    this.ideals,
    this.bonds,
    this.flaws,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.experience,
    this.alignmentValue,
    this.race,
    this.subrace,
    this.background,
    this.baseAbilityScores,
    this.customAbilityBonuses,
    this.useFlexibleAbilityBonuses,
    this.temporaryHp,
    this.currentHp,
    this.inspiration,
    this.equipment,
    this.manualSkillProficiencies,
    this.manualSavingThrowProficiencies,
    this.notes,
    this.attacks,
    this.featureOverrides,
    this.classEntries,
    this.choices,
    this.skillSelections,
    this.spellSelections,
    this.startingEquipmentSelections,
    this.derived,
  });

  factory CharacterData({
    int? id,
    String? name,
    String? age,
    String? height,
    String? weight,
    String? eyes,
    String? skin,
    String? hair,
    String? appearance,
    String? backstory,
    String? goals,
    String? alliesOrganizations,
    String? personalityTraits,
    String? ideals,
    String? bonds,
    String? flaws,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? experience,
    _i2.CharacterAlignment? alignmentValue,
    _i3.RaceData? race,
    _i4.SubraceData? subrace,
    _i5.BackgroundData? background,
    Map<String, int>? baseAbilityScores,
    Map<String, int>? customAbilityBonuses,
    bool? useFlexibleAbilityBonuses,
    int? temporaryHp,
    int? currentHp,
    bool? inspiration,
    List<_i6.CharacterInventoryItemData>? equipment,
    List<_i7.CharacterSkillProficiencyState>? manualSkillProficiencies,
    List<_i8.Ability>? manualSavingThrowProficiencies,
    List<_i9.CharacterNoteData>? notes,
    List<_i10.CharacterAttackData>? attacks,
    List<_i11.CharacterFeatureOverrideData>? featureOverrides,
    List<_i12.CharacterClassEntryData>? classEntries,
    List<_i13.CharacterChoiceData>? choices,
    List<_i14.CharacterSkillSelectionData>? skillSelections,
    List<_i15.CharacterSpellSelectionData>? spellSelections,
    List<_i16.CharacterStartingEquipmentSelectionData>?
        startingEquipmentSelections,
    _i17.CharacterDerivedData? derived,
  }) = _CharacterDataImpl;

  factory CharacterData.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterData(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String?,
      age: jsonSerialization['age'] as String?,
      height: jsonSerialization['height'] as String?,
      weight: jsonSerialization['weight'] as String?,
      eyes: jsonSerialization['eyes'] as String?,
      skin: jsonSerialization['skin'] as String?,
      hair: jsonSerialization['hair'] as String?,
      appearance: jsonSerialization['appearance'] as String?,
      backstory: jsonSerialization['backstory'] as String?,
      goals: jsonSerialization['goals'] as String?,
      alliesOrganizations: jsonSerialization['alliesOrganizations'] as String?,
      personalityTraits: jsonSerialization['personalityTraits'] as String?,
      ideals: jsonSerialization['ideals'] as String?,
      bonds: jsonSerialization['bonds'] as String?,
      flaws: jsonSerialization['flaws'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      experience: jsonSerialization['experience'] as int?,
      alignmentValue: jsonSerialization['alignmentValue'] == null
          ? null
          : _i2.CharacterAlignment.fromJson(
              (jsonSerialization['alignmentValue'] as String)),
      race: jsonSerialization['race'] == null
          ? null
          : _i3.RaceData.fromJson(
              (jsonSerialization['race'] as Map<String, dynamic>)),
      subrace: jsonSerialization['subrace'] == null
          ? null
          : _i4.SubraceData.fromJson(
              (jsonSerialization['subrace'] as Map<String, dynamic>)),
      background: jsonSerialization['background'] == null
          ? null
          : _i5.BackgroundData.fromJson(
              (jsonSerialization['background'] as Map<String, dynamic>)),
      baseAbilityScores: (jsonSerialization['baseAbilityScores'] as Map?)
          ?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      customAbilityBonuses: (jsonSerialization['customAbilityBonuses'] as Map?)
          ?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      useFlexibleAbilityBonuses:
          jsonSerialization['useFlexibleAbilityBonuses'] as bool?,
      temporaryHp: jsonSerialization['temporaryHp'] as int?,
      currentHp: jsonSerialization['currentHp'] as int?,
      inspiration: jsonSerialization['inspiration'] as bool?,
      equipment: (jsonSerialization['equipment'] as List?)
          ?.map((e) => _i6.CharacterInventoryItemData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      manualSkillProficiencies:
          (jsonSerialization['manualSkillProficiencies'] as List?)
              ?.map((e) => _i7.CharacterSkillProficiencyState.fromJson(
                  (e as Map<String, dynamic>)))
              .toList(),
      manualSavingThrowProficiencies:
          (jsonSerialization['manualSavingThrowProficiencies'] as List?)
              ?.map((e) => _i8.Ability.fromJson((e as String)))
              .toList(),
      notes: (jsonSerialization['notes'] as List?)
          ?.map((e) =>
              _i9.CharacterNoteData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      attacks: (jsonSerialization['attacks'] as List?)
          ?.map((e) =>
              _i10.CharacterAttackData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      featureOverrides: (jsonSerialization['featureOverrides'] as List?)
          ?.map((e) => _i11.CharacterFeatureOverrideData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      classEntries: (jsonSerialization['classEntries'] as List?)
          ?.map((e) => _i12.CharacterClassEntryData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      choices: (jsonSerialization['choices'] as List?)
          ?.map((e) =>
              _i13.CharacterChoiceData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      skillSelections: (jsonSerialization['skillSelections'] as List?)
          ?.map((e) => _i14.CharacterSkillSelectionData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      spellSelections: (jsonSerialization['spellSelections'] as List?)
          ?.map((e) => _i15.CharacterSpellSelectionData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      startingEquipmentSelections:
          (jsonSerialization['startingEquipmentSelections'] as List?)
              ?.map((e) =>
                  _i16.CharacterStartingEquipmentSelectionData.fromJson(
                      (e as Map<String, dynamic>)))
              .toList(),
      derived: jsonSerialization['derived'] == null
          ? null
          : _i17.CharacterDerivedData.fromJson(
              (jsonSerialization['derived'] as Map<String, dynamic>)),
    );
  }

  int? id;

  String? name;

  String? age;

  String? height;

  String? weight;

  String? eyes;

  String? skin;

  String? hair;

  String? appearance;

  String? backstory;

  String? goals;

  String? alliesOrganizations;

  String? personalityTraits;

  String? ideals;

  String? bonds;

  String? flaws;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int? experience;

  _i2.CharacterAlignment? alignmentValue;

  _i3.RaceData? race;

  _i4.SubraceData? subrace;

  _i5.BackgroundData? background;

  Map<String, int>? baseAbilityScores;

  Map<String, int>? customAbilityBonuses;

  bool? useFlexibleAbilityBonuses;

  int? temporaryHp;

  int? currentHp;

  bool? inspiration;

  List<_i6.CharacterInventoryItemData>? equipment;

  List<_i7.CharacterSkillProficiencyState>? manualSkillProficiencies;

  List<_i8.Ability>? manualSavingThrowProficiencies;

  List<_i9.CharacterNoteData>? notes;

  List<_i10.CharacterAttackData>? attacks;

  List<_i11.CharacterFeatureOverrideData>? featureOverrides;

  List<_i12.CharacterClassEntryData>? classEntries;

  List<_i13.CharacterChoiceData>? choices;

  List<_i14.CharacterSkillSelectionData>? skillSelections;

  List<_i15.CharacterSpellSelectionData>? spellSelections;

  List<_i16.CharacterStartingEquipmentSelectionData>?
      startingEquipmentSelections;

  _i17.CharacterDerivedData? derived;

  /// Returns a shallow copy of this [CharacterData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterData copyWith({
    int? id,
    String? name,
    String? age,
    String? height,
    String? weight,
    String? eyes,
    String? skin,
    String? hair,
    String? appearance,
    String? backstory,
    String? goals,
    String? alliesOrganizations,
    String? personalityTraits,
    String? ideals,
    String? bonds,
    String? flaws,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? experience,
    _i2.CharacterAlignment? alignmentValue,
    _i3.RaceData? race,
    _i4.SubraceData? subrace,
    _i5.BackgroundData? background,
    Map<String, int>? baseAbilityScores,
    Map<String, int>? customAbilityBonuses,
    bool? useFlexibleAbilityBonuses,
    int? temporaryHp,
    int? currentHp,
    bool? inspiration,
    List<_i6.CharacterInventoryItemData>? equipment,
    List<_i7.CharacterSkillProficiencyState>? manualSkillProficiencies,
    List<_i8.Ability>? manualSavingThrowProficiencies,
    List<_i9.CharacterNoteData>? notes,
    List<_i10.CharacterAttackData>? attacks,
    List<_i11.CharacterFeatureOverrideData>? featureOverrides,
    List<_i12.CharacterClassEntryData>? classEntries,
    List<_i13.CharacterChoiceData>? choices,
    List<_i14.CharacterSkillSelectionData>? skillSelections,
    List<_i15.CharacterSpellSelectionData>? spellSelections,
    List<_i16.CharacterStartingEquipmentSelectionData>?
        startingEquipmentSelections,
    _i17.CharacterDerivedData? derived,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (age != null) 'age': age,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (eyes != null) 'eyes': eyes,
      if (skin != null) 'skin': skin,
      if (hair != null) 'hair': hair,
      if (appearance != null) 'appearance': appearance,
      if (backstory != null) 'backstory': backstory,
      if (goals != null) 'goals': goals,
      if (alliesOrganizations != null)
        'alliesOrganizations': alliesOrganizations,
      if (personalityTraits != null) 'personalityTraits': personalityTraits,
      if (ideals != null) 'ideals': ideals,
      if (bonds != null) 'bonds': bonds,
      if (flaws != null) 'flaws': flaws,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (experience != null) 'experience': experience,
      if (alignmentValue != null) 'alignmentValue': alignmentValue?.toJson(),
      if (race != null) 'race': race?.toJson(),
      if (subrace != null) 'subrace': subrace?.toJson(),
      if (background != null) 'background': background?.toJson(),
      if (baseAbilityScores != null)
        'baseAbilityScores': baseAbilityScores?.toJson(),
      if (customAbilityBonuses != null)
        'customAbilityBonuses': customAbilityBonuses?.toJson(),
      if (useFlexibleAbilityBonuses != null)
        'useFlexibleAbilityBonuses': useFlexibleAbilityBonuses,
      if (temporaryHp != null) 'temporaryHp': temporaryHp,
      if (currentHp != null) 'currentHp': currentHp,
      if (inspiration != null) 'inspiration': inspiration,
      if (equipment != null)
        'equipment': equipment?.toJson(valueToJson: (v) => v.toJson()),
      if (manualSkillProficiencies != null)
        'manualSkillProficiencies':
            manualSkillProficiencies?.toJson(valueToJson: (v) => v.toJson()),
      if (manualSavingThrowProficiencies != null)
        'manualSavingThrowProficiencies': manualSavingThrowProficiencies
            ?.toJson(valueToJson: (v) => v.toJson()),
      if (notes != null) 'notes': notes?.toJson(valueToJson: (v) => v.toJson()),
      if (attacks != null)
        'attacks': attacks?.toJson(valueToJson: (v) => v.toJson()),
      if (featureOverrides != null)
        'featureOverrides':
            featureOverrides?.toJson(valueToJson: (v) => v.toJson()),
      if (classEntries != null)
        'classEntries': classEntries?.toJson(valueToJson: (v) => v.toJson()),
      if (choices != null)
        'choices': choices?.toJson(valueToJson: (v) => v.toJson()),
      if (skillSelections != null)
        'skillSelections':
            skillSelections?.toJson(valueToJson: (v) => v.toJson()),
      if (spellSelections != null)
        'spellSelections':
            spellSelections?.toJson(valueToJson: (v) => v.toJson()),
      if (startingEquipmentSelections != null)
        'startingEquipmentSelections':
            startingEquipmentSelections?.toJson(valueToJson: (v) => v.toJson()),
      if (derived != null) 'derived': derived?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterDataImpl extends CharacterData {
  _CharacterDataImpl({
    int? id,
    String? name,
    String? age,
    String? height,
    String? weight,
    String? eyes,
    String? skin,
    String? hair,
    String? appearance,
    String? backstory,
    String? goals,
    String? alliesOrganizations,
    String? personalityTraits,
    String? ideals,
    String? bonds,
    String? flaws,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? experience,
    _i2.CharacterAlignment? alignmentValue,
    _i3.RaceData? race,
    _i4.SubraceData? subrace,
    _i5.BackgroundData? background,
    Map<String, int>? baseAbilityScores,
    Map<String, int>? customAbilityBonuses,
    bool? useFlexibleAbilityBonuses,
    int? temporaryHp,
    int? currentHp,
    bool? inspiration,
    List<_i6.CharacterInventoryItemData>? equipment,
    List<_i7.CharacterSkillProficiencyState>? manualSkillProficiencies,
    List<_i8.Ability>? manualSavingThrowProficiencies,
    List<_i9.CharacterNoteData>? notes,
    List<_i10.CharacterAttackData>? attacks,
    List<_i11.CharacterFeatureOverrideData>? featureOverrides,
    List<_i12.CharacterClassEntryData>? classEntries,
    List<_i13.CharacterChoiceData>? choices,
    List<_i14.CharacterSkillSelectionData>? skillSelections,
    List<_i15.CharacterSpellSelectionData>? spellSelections,
    List<_i16.CharacterStartingEquipmentSelectionData>?
        startingEquipmentSelections,
    _i17.CharacterDerivedData? derived,
  }) : super._(
          id: id,
          name: name,
          age: age,
          height: height,
          weight: weight,
          eyes: eyes,
          skin: skin,
          hair: hair,
          appearance: appearance,
          backstory: backstory,
          goals: goals,
          alliesOrganizations: alliesOrganizations,
          personalityTraits: personalityTraits,
          ideals: ideals,
          bonds: bonds,
          flaws: flaws,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          experience: experience,
          alignmentValue: alignmentValue,
          race: race,
          subrace: subrace,
          background: background,
          baseAbilityScores: baseAbilityScores,
          customAbilityBonuses: customAbilityBonuses,
          useFlexibleAbilityBonuses: useFlexibleAbilityBonuses,
          temporaryHp: temporaryHp,
          currentHp: currentHp,
          inspiration: inspiration,
          equipment: equipment,
          manualSkillProficiencies: manualSkillProficiencies,
          manualSavingThrowProficiencies: manualSavingThrowProficiencies,
          notes: notes,
          attacks: attacks,
          featureOverrides: featureOverrides,
          classEntries: classEntries,
          choices: choices,
          skillSelections: skillSelections,
          spellSelections: spellSelections,
          startingEquipmentSelections: startingEquipmentSelections,
          derived: derived,
        );

  /// Returns a shallow copy of this [CharacterData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? age = _Undefined,
    Object? height = _Undefined,
    Object? weight = _Undefined,
    Object? eyes = _Undefined,
    Object? skin = _Undefined,
    Object? hair = _Undefined,
    Object? appearance = _Undefined,
    Object? backstory = _Undefined,
    Object? goals = _Undefined,
    Object? alliesOrganizations = _Undefined,
    Object? personalityTraits = _Undefined,
    Object? ideals = _Undefined,
    Object? bonds = _Undefined,
    Object? flaws = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? experience = _Undefined,
    Object? alignmentValue = _Undefined,
    Object? race = _Undefined,
    Object? subrace = _Undefined,
    Object? background = _Undefined,
    Object? baseAbilityScores = _Undefined,
    Object? customAbilityBonuses = _Undefined,
    Object? useFlexibleAbilityBonuses = _Undefined,
    Object? temporaryHp = _Undefined,
    Object? currentHp = _Undefined,
    Object? inspiration = _Undefined,
    Object? equipment = _Undefined,
    Object? manualSkillProficiencies = _Undefined,
    Object? manualSavingThrowProficiencies = _Undefined,
    Object? notes = _Undefined,
    Object? attacks = _Undefined,
    Object? featureOverrides = _Undefined,
    Object? classEntries = _Undefined,
    Object? choices = _Undefined,
    Object? skillSelections = _Undefined,
    Object? spellSelections = _Undefined,
    Object? startingEquipmentSelections = _Undefined,
    Object? derived = _Undefined,
  }) {
    return CharacterData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      age: age is String? ? age : this.age,
      height: height is String? ? height : this.height,
      weight: weight is String? ? weight : this.weight,
      eyes: eyes is String? ? eyes : this.eyes,
      skin: skin is String? ? skin : this.skin,
      hair: hair is String? ? hair : this.hair,
      appearance: appearance is String? ? appearance : this.appearance,
      backstory: backstory is String? ? backstory : this.backstory,
      goals: goals is String? ? goals : this.goals,
      alliesOrganizations: alliesOrganizations is String?
          ? alliesOrganizations
          : this.alliesOrganizations,
      personalityTraits: personalityTraits is String?
          ? personalityTraits
          : this.personalityTraits,
      ideals: ideals is String? ? ideals : this.ideals,
      bonds: bonds is String? ? bonds : this.bonds,
      flaws: flaws is String? ? flaws : this.flaws,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      experience: experience is int? ? experience : this.experience,
      alignmentValue: alignmentValue is _i2.CharacterAlignment?
          ? alignmentValue
          : this.alignmentValue,
      race: race is _i3.RaceData? ? race : this.race?.copyWith(),
      subrace: subrace is _i4.SubraceData? ? subrace : this.subrace?.copyWith(),
      background: background is _i5.BackgroundData?
          ? background
          : this.background?.copyWith(),
      baseAbilityScores: baseAbilityScores is Map<String, int>?
          ? baseAbilityScores
          : this.baseAbilityScores?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      customAbilityBonuses: customAbilityBonuses is Map<String, int>?
          ? customAbilityBonuses
          : this.customAbilityBonuses?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      useFlexibleAbilityBonuses: useFlexibleAbilityBonuses is bool?
          ? useFlexibleAbilityBonuses
          : this.useFlexibleAbilityBonuses,
      temporaryHp: temporaryHp is int? ? temporaryHp : this.temporaryHp,
      currentHp: currentHp is int? ? currentHp : this.currentHp,
      inspiration: inspiration is bool? ? inspiration : this.inspiration,
      equipment: equipment is List<_i6.CharacterInventoryItemData>?
          ? equipment
          : this.equipment?.map((e0) => e0.copyWith()).toList(),
      manualSkillProficiencies: manualSkillProficiencies
              is List<_i7.CharacterSkillProficiencyState>?
          ? manualSkillProficiencies
          : this.manualSkillProficiencies?.map((e0) => e0.copyWith()).toList(),
      manualSavingThrowProficiencies:
          manualSavingThrowProficiencies is List<_i8.Ability>?
              ? manualSavingThrowProficiencies
              : this.manualSavingThrowProficiencies?.map((e0) => e0).toList(),
      notes: notes is List<_i9.CharacterNoteData>?
          ? notes
          : this.notes?.map((e0) => e0.copyWith()).toList(),
      attacks: attacks is List<_i10.CharacterAttackData>?
          ? attacks
          : this.attacks?.map((e0) => e0.copyWith()).toList(),
      featureOverrides:
          featureOverrides is List<_i11.CharacterFeatureOverrideData>?
              ? featureOverrides
              : this.featureOverrides?.map((e0) => e0.copyWith()).toList(),
      classEntries: classEntries is List<_i12.CharacterClassEntryData>?
          ? classEntries
          : this.classEntries?.map((e0) => e0.copyWith()).toList(),
      choices: choices is List<_i13.CharacterChoiceData>?
          ? choices
          : this.choices?.map((e0) => e0.copyWith()).toList(),
      skillSelections:
          skillSelections is List<_i14.CharacterSkillSelectionData>?
              ? skillSelections
              : this.skillSelections?.map((e0) => e0.copyWith()).toList(),
      spellSelections:
          spellSelections is List<_i15.CharacterSpellSelectionData>?
              ? spellSelections
              : this.spellSelections?.map((e0) => e0.copyWith()).toList(),
      startingEquipmentSelections: startingEquipmentSelections
              is List<_i16.CharacterStartingEquipmentSelectionData>?
          ? startingEquipmentSelections
          : this
              .startingEquipmentSelections
              ?.map((e0) => e0.copyWith())
              .toList(),
      derived: derived is _i17.CharacterDerivedData?
          ? derived
          : this.derived?.copyWith(),
    );
  }
}
