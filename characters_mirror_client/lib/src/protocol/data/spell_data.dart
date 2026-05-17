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
import '../enums/spell/spell_school.dart' as _i2;
import '../enums/spell/spell_attack_type.dart' as _i3;
import '../enums/damage_type.dart' as _i4;
import '../data/spell_scaling_data.dart' as _i5;
import '../data/damage_part_data.dart' as _i6;
import '../enums/condition_type.dart' as _i7;
import '../enums/spell/spell_target_type.dart' as _i8;
import '../enums/spell/area_of_effect_type.dart' as _i9;
import '../enums/spell/spell_duration_type.dart' as _i10;

abstract class SpellData implements _i1.SerializableModel {
  SpellData._({
    this.id,
    this.referenceKey,
    this.name,
    this.description,
    this.shortDescription,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.level,
    this.schoolValue,
    this.castingTime,
    this.range,
    this.duration,
    this.concentration,
    this.ritual,
    this.higherLevel,
    this.savingThrowAbility,
    this.requiresSavingThrow,
    this.attackType,
    this.requiresAttackRoll,
    this.damageType,
    this.damageDice,
    this.damageScaling,
    this.damageParts,
    this.conditions,
    this.targetType,
    this.areaOfEffectType,
    this.areaOfEffectSize,
    this.areaOfEffectSecondarySize,
    this.areaOfEffectHeight,
    this.materialDescription,
    this.materialCost,
    this.materialConsumed,
    this.durationType,
    this.isHealing,
    this.healingDice,
    this.requiresLineOfSight,
    this.requiresVerbal,
    this.requiresSomatic,
    this.requiresMaterial,
    this.availableForClassIds,
    this.availableForSubclassIds,
  });

  factory SpellData({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? shortDescription,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    _i2.SpellSchool? schoolValue,
    String? castingTime,
    String? range,
    String? duration,
    bool? concentration,
    bool? ritual,
    String? higherLevel,
    String? savingThrowAbility,
    bool? requiresSavingThrow,
    _i3.SpellAttackType? attackType,
    bool? requiresAttackRoll,
    _i4.DamageType? damageType,
    String? damageDice,
    _i5.SpellScalingData? damageScaling,
    List<_i6.DamagePartData>? damageParts,
    List<_i7.ConditionType>? conditions,
    _i8.SpellTargetType? targetType,
    _i9.AreaOfEffectType? areaOfEffectType,
    int? areaOfEffectSize,
    int? areaOfEffectSecondarySize,
    int? areaOfEffectHeight,
    String? materialDescription,
    int? materialCost,
    bool? materialConsumed,
    _i10.SpellDurationType? durationType,
    bool? isHealing,
    String? healingDice,
    bool? requiresLineOfSight,
    bool? requiresVerbal,
    bool? requiresSomatic,
    bool? requiresMaterial,
    List<int>? availableForClassIds,
    List<int>? availableForSubclassIds,
  }) = _SpellDataImpl;

  factory SpellData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SpellData(
      id: jsonSerialization['id'] as int?,
      referenceKey: jsonSerialization['referenceKey'] as String?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      shortDescription: jsonSerialization['shortDescription'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      level: jsonSerialization['level'] as int?,
      schoolValue: jsonSerialization['schoolValue'] == null
          ? null
          : _i2.SpellSchool.fromJson(
              (jsonSerialization['schoolValue'] as String)),
      castingTime: jsonSerialization['castingTime'] as String?,
      range: jsonSerialization['range'] as String?,
      duration: jsonSerialization['duration'] as String?,
      concentration: jsonSerialization['concentration'] as bool?,
      ritual: jsonSerialization['ritual'] as bool?,
      higherLevel: jsonSerialization['higherLevel'] as String?,
      savingThrowAbility: jsonSerialization['savingThrowAbility'] as String?,
      requiresSavingThrow: jsonSerialization['requiresSavingThrow'] as bool?,
      attackType: jsonSerialization['attackType'] == null
          ? null
          : _i3.SpellAttackType.fromJson(
              (jsonSerialization['attackType'] as String)),
      requiresAttackRoll: jsonSerialization['requiresAttackRoll'] as bool?,
      damageType: jsonSerialization['damageType'] == null
          ? null
          : _i4.DamageType.fromJson(
              (jsonSerialization['damageType'] as String)),
      damageDice: jsonSerialization['damageDice'] as String?,
      damageScaling: jsonSerialization['damageScaling'] == null
          ? null
          : _i5.SpellScalingData.fromJson(
              (jsonSerialization['damageScaling'] as Map<String, dynamic>)),
      damageParts: (jsonSerialization['damageParts'] as List?)
          ?.map((e) => _i6.DamagePartData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      conditions: (jsonSerialization['conditions'] as List?)
          ?.map((e) => _i7.ConditionType.fromJson((e as String)))
          .toList(),
      targetType: jsonSerialization['targetType'] == null
          ? null
          : _i8.SpellTargetType.fromJson(
              (jsonSerialization['targetType'] as String)),
      areaOfEffectType: jsonSerialization['areaOfEffectType'] == null
          ? null
          : _i9.AreaOfEffectType.fromJson(
              (jsonSerialization['areaOfEffectType'] as String)),
      areaOfEffectSize: jsonSerialization['areaOfEffectSize'] as int?,
      areaOfEffectSecondarySize:
          jsonSerialization['areaOfEffectSecondarySize'] as int?,
      areaOfEffectHeight: jsonSerialization['areaOfEffectHeight'] as int?,
      materialDescription: jsonSerialization['materialDescription'] as String?,
      materialCost: jsonSerialization['materialCost'] as int?,
      materialConsumed: jsonSerialization['materialConsumed'] as bool?,
      durationType: jsonSerialization['durationType'] == null
          ? null
          : _i10.SpellDurationType.fromJson(
              (jsonSerialization['durationType'] as String)),
      isHealing: jsonSerialization['isHealing'] as bool?,
      healingDice: jsonSerialization['healingDice'] as String?,
      requiresLineOfSight: jsonSerialization['requiresLineOfSight'] as bool?,
      requiresVerbal: jsonSerialization['requiresVerbal'] as bool?,
      requiresSomatic: jsonSerialization['requiresSomatic'] as bool?,
      requiresMaterial: jsonSerialization['requiresMaterial'] as bool?,
      availableForClassIds: (jsonSerialization['availableForClassIds'] as List?)
          ?.map((e) => e as int)
          .toList(),
      availableForSubclassIds:
          (jsonSerialization['availableForSubclassIds'] as List?)
              ?.map((e) => e as int)
              .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? referenceKey;

  String? name;

  String? description;

  String? shortDescription;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int? level;

  _i2.SpellSchool? schoolValue;

  String? castingTime;

  String? range;

  String? duration;

  bool? concentration;

  bool? ritual;

  String? higherLevel;

  String? savingThrowAbility;

  bool? requiresSavingThrow;

  _i3.SpellAttackType? attackType;

  bool? requiresAttackRoll;

  _i4.DamageType? damageType;

  String? damageDice;

  _i5.SpellScalingData? damageScaling;

  List<_i6.DamagePartData>? damageParts;

  List<_i7.ConditionType>? conditions;

  _i8.SpellTargetType? targetType;

  _i9.AreaOfEffectType? areaOfEffectType;

  int? areaOfEffectSize;

  int? areaOfEffectSecondarySize;

  int? areaOfEffectHeight;

  String? materialDescription;

  int? materialCost;

  bool? materialConsumed;

  _i10.SpellDurationType? durationType;

  bool? isHealing;

  String? healingDice;

  bool? requiresLineOfSight;

  bool? requiresVerbal;

  bool? requiresSomatic;

  bool? requiresMaterial;

  List<int>? availableForClassIds;

  List<int>? availableForSubclassIds;

  /// Returns a shallow copy of this [SpellData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SpellData copyWith({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? shortDescription,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    _i2.SpellSchool? schoolValue,
    String? castingTime,
    String? range,
    String? duration,
    bool? concentration,
    bool? ritual,
    String? higherLevel,
    String? savingThrowAbility,
    bool? requiresSavingThrow,
    _i3.SpellAttackType? attackType,
    bool? requiresAttackRoll,
    _i4.DamageType? damageType,
    String? damageDice,
    _i5.SpellScalingData? damageScaling,
    List<_i6.DamagePartData>? damageParts,
    List<_i7.ConditionType>? conditions,
    _i8.SpellTargetType? targetType,
    _i9.AreaOfEffectType? areaOfEffectType,
    int? areaOfEffectSize,
    int? areaOfEffectSecondarySize,
    int? areaOfEffectHeight,
    String? materialDescription,
    int? materialCost,
    bool? materialConsumed,
    _i10.SpellDurationType? durationType,
    bool? isHealing,
    String? healingDice,
    bool? requiresLineOfSight,
    bool? requiresVerbal,
    bool? requiresSomatic,
    bool? requiresMaterial,
    List<int>? availableForClassIds,
    List<int>? availableForSubclassIds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (shortDescription != null) 'shortDescription': shortDescription,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (level != null) 'level': level,
      if (schoolValue != null) 'schoolValue': schoolValue?.toJson(),
      if (castingTime != null) 'castingTime': castingTime,
      if (range != null) 'range': range,
      if (duration != null) 'duration': duration,
      if (concentration != null) 'concentration': concentration,
      if (ritual != null) 'ritual': ritual,
      if (higherLevel != null) 'higherLevel': higherLevel,
      if (savingThrowAbility != null) 'savingThrowAbility': savingThrowAbility,
      if (requiresSavingThrow != null)
        'requiresSavingThrow': requiresSavingThrow,
      if (attackType != null) 'attackType': attackType?.toJson(),
      if (requiresAttackRoll != null) 'requiresAttackRoll': requiresAttackRoll,
      if (damageType != null) 'damageType': damageType?.toJson(),
      if (damageDice != null) 'damageDice': damageDice,
      if (damageScaling != null) 'damageScaling': damageScaling?.toJson(),
      if (damageParts != null)
        'damageParts': damageParts?.toJson(valueToJson: (v) => v.toJson()),
      if (conditions != null)
        'conditions': conditions?.toJson(valueToJson: (v) => v.toJson()),
      if (targetType != null) 'targetType': targetType?.toJson(),
      if (areaOfEffectType != null)
        'areaOfEffectType': areaOfEffectType?.toJson(),
      if (areaOfEffectSize != null) 'areaOfEffectSize': areaOfEffectSize,
      if (areaOfEffectSecondarySize != null)
        'areaOfEffectSecondarySize': areaOfEffectSecondarySize,
      if (areaOfEffectHeight != null) 'areaOfEffectHeight': areaOfEffectHeight,
      if (materialDescription != null)
        'materialDescription': materialDescription,
      if (materialCost != null) 'materialCost': materialCost,
      if (materialConsumed != null) 'materialConsumed': materialConsumed,
      if (durationType != null) 'durationType': durationType?.toJson(),
      if (isHealing != null) 'isHealing': isHealing,
      if (healingDice != null) 'healingDice': healingDice,
      if (requiresLineOfSight != null)
        'requiresLineOfSight': requiresLineOfSight,
      if (requiresVerbal != null) 'requiresVerbal': requiresVerbal,
      if (requiresSomatic != null) 'requiresSomatic': requiresSomatic,
      if (requiresMaterial != null) 'requiresMaterial': requiresMaterial,
      if (availableForClassIds != null)
        'availableForClassIds': availableForClassIds?.toJson(),
      if (availableForSubclassIds != null)
        'availableForSubclassIds': availableForSubclassIds?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpellDataImpl extends SpellData {
  _SpellDataImpl({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? shortDescription,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    _i2.SpellSchool? schoolValue,
    String? castingTime,
    String? range,
    String? duration,
    bool? concentration,
    bool? ritual,
    String? higherLevel,
    String? savingThrowAbility,
    bool? requiresSavingThrow,
    _i3.SpellAttackType? attackType,
    bool? requiresAttackRoll,
    _i4.DamageType? damageType,
    String? damageDice,
    _i5.SpellScalingData? damageScaling,
    List<_i6.DamagePartData>? damageParts,
    List<_i7.ConditionType>? conditions,
    _i8.SpellTargetType? targetType,
    _i9.AreaOfEffectType? areaOfEffectType,
    int? areaOfEffectSize,
    int? areaOfEffectSecondarySize,
    int? areaOfEffectHeight,
    String? materialDescription,
    int? materialCost,
    bool? materialConsumed,
    _i10.SpellDurationType? durationType,
    bool? isHealing,
    String? healingDice,
    bool? requiresLineOfSight,
    bool? requiresVerbal,
    bool? requiresSomatic,
    bool? requiresMaterial,
    List<int>? availableForClassIds,
    List<int>? availableForSubclassIds,
  }) : super._(
          id: id,
          referenceKey: referenceKey,
          name: name,
          description: description,
          shortDescription: shortDescription,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          level: level,
          schoolValue: schoolValue,
          castingTime: castingTime,
          range: range,
          duration: duration,
          concentration: concentration,
          ritual: ritual,
          higherLevel: higherLevel,
          savingThrowAbility: savingThrowAbility,
          requiresSavingThrow: requiresSavingThrow,
          attackType: attackType,
          requiresAttackRoll: requiresAttackRoll,
          damageType: damageType,
          damageDice: damageDice,
          damageScaling: damageScaling,
          damageParts: damageParts,
          conditions: conditions,
          targetType: targetType,
          areaOfEffectType: areaOfEffectType,
          areaOfEffectSize: areaOfEffectSize,
          areaOfEffectSecondarySize: areaOfEffectSecondarySize,
          areaOfEffectHeight: areaOfEffectHeight,
          materialDescription: materialDescription,
          materialCost: materialCost,
          materialConsumed: materialConsumed,
          durationType: durationType,
          isHealing: isHealing,
          healingDice: healingDice,
          requiresLineOfSight: requiresLineOfSight,
          requiresVerbal: requiresVerbal,
          requiresSomatic: requiresSomatic,
          requiresMaterial: requiresMaterial,
          availableForClassIds: availableForClassIds,
          availableForSubclassIds: availableForSubclassIds,
        );

  /// Returns a shallow copy of this [SpellData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SpellData copyWith({
    Object? id = _Undefined,
    Object? referenceKey = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? shortDescription = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? level = _Undefined,
    Object? schoolValue = _Undefined,
    Object? castingTime = _Undefined,
    Object? range = _Undefined,
    Object? duration = _Undefined,
    Object? concentration = _Undefined,
    Object? ritual = _Undefined,
    Object? higherLevel = _Undefined,
    Object? savingThrowAbility = _Undefined,
    Object? requiresSavingThrow = _Undefined,
    Object? attackType = _Undefined,
    Object? requiresAttackRoll = _Undefined,
    Object? damageType = _Undefined,
    Object? damageDice = _Undefined,
    Object? damageScaling = _Undefined,
    Object? damageParts = _Undefined,
    Object? conditions = _Undefined,
    Object? targetType = _Undefined,
    Object? areaOfEffectType = _Undefined,
    Object? areaOfEffectSize = _Undefined,
    Object? areaOfEffectSecondarySize = _Undefined,
    Object? areaOfEffectHeight = _Undefined,
    Object? materialDescription = _Undefined,
    Object? materialCost = _Undefined,
    Object? materialConsumed = _Undefined,
    Object? durationType = _Undefined,
    Object? isHealing = _Undefined,
    Object? healingDice = _Undefined,
    Object? requiresLineOfSight = _Undefined,
    Object? requiresVerbal = _Undefined,
    Object? requiresSomatic = _Undefined,
    Object? requiresMaterial = _Undefined,
    Object? availableForClassIds = _Undefined,
    Object? availableForSubclassIds = _Undefined,
  }) {
    return SpellData(
      id: id is int? ? id : this.id,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      shortDescription: shortDescription is String?
          ? shortDescription
          : this.shortDescription,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      level: level is int? ? level : this.level,
      schoolValue:
          schoolValue is _i2.SpellSchool? ? schoolValue : this.schoolValue,
      castingTime: castingTime is String? ? castingTime : this.castingTime,
      range: range is String? ? range : this.range,
      duration: duration is String? ? duration : this.duration,
      concentration:
          concentration is bool? ? concentration : this.concentration,
      ritual: ritual is bool? ? ritual : this.ritual,
      higherLevel: higherLevel is String? ? higherLevel : this.higherLevel,
      savingThrowAbility: savingThrowAbility is String?
          ? savingThrowAbility
          : this.savingThrowAbility,
      requiresSavingThrow: requiresSavingThrow is bool?
          ? requiresSavingThrow
          : this.requiresSavingThrow,
      attackType:
          attackType is _i3.SpellAttackType? ? attackType : this.attackType,
      requiresAttackRoll: requiresAttackRoll is bool?
          ? requiresAttackRoll
          : this.requiresAttackRoll,
      damageType: damageType is _i4.DamageType? ? damageType : this.damageType,
      damageDice: damageDice is String? ? damageDice : this.damageDice,
      damageScaling: damageScaling is _i5.SpellScalingData?
          ? damageScaling
          : this.damageScaling?.copyWith(),
      damageParts: damageParts is List<_i6.DamagePartData>?
          ? damageParts
          : this.damageParts?.map((e0) => e0.copyWith()).toList(),
      conditions: conditions is List<_i7.ConditionType>?
          ? conditions
          : this.conditions?.map((e0) => e0).toList(),
      targetType:
          targetType is _i8.SpellTargetType? ? targetType : this.targetType,
      areaOfEffectType: areaOfEffectType is _i9.AreaOfEffectType?
          ? areaOfEffectType
          : this.areaOfEffectType,
      areaOfEffectSize:
          areaOfEffectSize is int? ? areaOfEffectSize : this.areaOfEffectSize,
      areaOfEffectSecondarySize: areaOfEffectSecondarySize is int?
          ? areaOfEffectSecondarySize
          : this.areaOfEffectSecondarySize,
      areaOfEffectHeight: areaOfEffectHeight is int?
          ? areaOfEffectHeight
          : this.areaOfEffectHeight,
      materialDescription: materialDescription is String?
          ? materialDescription
          : this.materialDescription,
      materialCost: materialCost is int? ? materialCost : this.materialCost,
      materialConsumed:
          materialConsumed is bool? ? materialConsumed : this.materialConsumed,
      durationType: durationType is _i10.SpellDurationType?
          ? durationType
          : this.durationType,
      isHealing: isHealing is bool? ? isHealing : this.isHealing,
      healingDice: healingDice is String? ? healingDice : this.healingDice,
      requiresLineOfSight: requiresLineOfSight is bool?
          ? requiresLineOfSight
          : this.requiresLineOfSight,
      requiresVerbal:
          requiresVerbal is bool? ? requiresVerbal : this.requiresVerbal,
      requiresSomatic:
          requiresSomatic is bool? ? requiresSomatic : this.requiresSomatic,
      requiresMaterial:
          requiresMaterial is bool? ? requiresMaterial : this.requiresMaterial,
      availableForClassIds: availableForClassIds is List<int>?
          ? availableForClassIds
          : this.availableForClassIds?.map((e0) => e0).toList(),
      availableForSubclassIds: availableForSubclassIds is List<int>?
          ? availableForSubclassIds
          : this.availableForSubclassIds?.map((e0) => e0).toList(),
    );
  }
}
