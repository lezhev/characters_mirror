/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../enums/spell/spell_school.dart' as _i2;
import '../enums/spell/spell_attack_type.dart' as _i3;
import '../enums/damage_type.dart' as _i4;
import '../data/spell_scaling_data.dart' as _i5;
import '../data/damage_part_data.dart' as _i6;
import '../enums/condition_type.dart' as _i7;
import '../enums/spell/spell_target_type.dart' as _i8;
import '../enums/spell/area_of_effect_type.dart' as _i9;
import '../enums/spell/spell_duration_type.dart' as _i10;
import '../data/spell_class_availability_data.dart' as _i11;

abstract class SpellData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
    this.classAvailability,
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
    List<_i11.SpellClassAvailabilityData>? classAvailability,
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
      classAvailability: (jsonSerialization['classAvailability'] as List?)
          ?.map((e) => _i11.SpellClassAvailabilityData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = SpellDataTable();

  static const db = SpellDataRepository._();

  @override
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

  List<_i11.SpellClassAvailabilityData>? classAvailability;

  @override
  _i1.Table<int?> get table => t;

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
    List<_i11.SpellClassAvailabilityData>? classAvailability,
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
      if (classAvailability != null)
        'classAvailability':
            classAvailability?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
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
      if (damageScaling != null)
        'damageScaling': damageScaling?.toJsonForProtocol(),
      if (damageParts != null)
        'damageParts':
            damageParts?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
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
      if (classAvailability != null)
        'classAvailability': classAvailability?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static SpellDataInclude include(
      {_i11.SpellClassAvailabilityDataIncludeList? classAvailability}) {
    return SpellDataInclude._(classAvailability: classAvailability);
  }

  static SpellDataIncludeList includeList({
    _i1.WhereExpressionBuilder<SpellDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SpellDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpellDataTable>? orderByList,
    SpellDataInclude? include,
  }) {
    return SpellDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SpellData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SpellData.t),
      include: include,
    );
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
    List<_i11.SpellClassAvailabilityData>? classAvailability,
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
          classAvailability: classAvailability,
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
    Object? classAvailability = _Undefined,
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
      classAvailability:
          classAvailability is List<_i11.SpellClassAvailabilityData>?
              ? classAvailability
              : this.classAvailability?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class SpellDataTable extends _i1.Table<int?> {
  SpellDataTable({super.tableRelation}) : super(tableName: 'spell_data') {
    referenceKey = _i1.ColumnString(
      'referenceKey',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    shortDescription = _i1.ColumnString(
      'shortDescription',
      this,
    );
    source = _i1.ColumnString(
      'source',
      this,
    );
    version = _i1.ColumnInt(
      'version',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
    level = _i1.ColumnInt(
      'level',
      this,
    );
    schoolValue = _i1.ColumnEnum(
      'schoolValue',
      this,
      _i1.EnumSerialization.byName,
    );
    castingTime = _i1.ColumnString(
      'castingTime',
      this,
    );
    range = _i1.ColumnString(
      'range',
      this,
    );
    duration = _i1.ColumnString(
      'duration',
      this,
    );
    concentration = _i1.ColumnBool(
      'concentration',
      this,
    );
    ritual = _i1.ColumnBool(
      'ritual',
      this,
    );
    higherLevel = _i1.ColumnString(
      'higherLevel',
      this,
    );
    savingThrowAbility = _i1.ColumnString(
      'savingThrowAbility',
      this,
    );
    requiresSavingThrow = _i1.ColumnBool(
      'requiresSavingThrow',
      this,
    );
    attackType = _i1.ColumnEnum(
      'attackType',
      this,
      _i1.EnumSerialization.byName,
    );
    requiresAttackRoll = _i1.ColumnBool(
      'requiresAttackRoll',
      this,
    );
    damageType = _i1.ColumnEnum(
      'damageType',
      this,
      _i1.EnumSerialization.byName,
    );
    damageDice = _i1.ColumnString(
      'damageDice',
      this,
    );
    damageScaling = _i1.ColumnSerializable(
      'damageScaling',
      this,
    );
    damageParts = _i1.ColumnSerializable(
      'damageParts',
      this,
    );
    conditions = _i1.ColumnSerializable(
      'conditions',
      this,
    );
    targetType = _i1.ColumnEnum(
      'targetType',
      this,
      _i1.EnumSerialization.byName,
    );
    areaOfEffectType = _i1.ColumnEnum(
      'areaOfEffectType',
      this,
      _i1.EnumSerialization.byName,
    );
    areaOfEffectSize = _i1.ColumnInt(
      'areaOfEffectSize',
      this,
    );
    areaOfEffectSecondarySize = _i1.ColumnInt(
      'areaOfEffectSecondarySize',
      this,
    );
    areaOfEffectHeight = _i1.ColumnInt(
      'areaOfEffectHeight',
      this,
    );
    materialDescription = _i1.ColumnString(
      'materialDescription',
      this,
    );
    materialCost = _i1.ColumnInt(
      'materialCost',
      this,
    );
    materialConsumed = _i1.ColumnBool(
      'materialConsumed',
      this,
    );
    durationType = _i1.ColumnEnum(
      'durationType',
      this,
      _i1.EnumSerialization.byName,
    );
    isHealing = _i1.ColumnBool(
      'isHealing',
      this,
    );
    healingDice = _i1.ColumnString(
      'healingDice',
      this,
    );
    requiresLineOfSight = _i1.ColumnBool(
      'requiresLineOfSight',
      this,
    );
    requiresVerbal = _i1.ColumnBool(
      'requiresVerbal',
      this,
    );
    requiresSomatic = _i1.ColumnBool(
      'requiresSomatic',
      this,
    );
    requiresMaterial = _i1.ColumnBool(
      'requiresMaterial',
      this,
    );
  }

  late final _i1.ColumnString referenceKey;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString shortDescription;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnInt level;

  late final _i1.ColumnEnum<_i2.SpellSchool> schoolValue;

  late final _i1.ColumnString castingTime;

  late final _i1.ColumnString range;

  late final _i1.ColumnString duration;

  late final _i1.ColumnBool concentration;

  late final _i1.ColumnBool ritual;

  late final _i1.ColumnString higherLevel;

  late final _i1.ColumnString savingThrowAbility;

  late final _i1.ColumnBool requiresSavingThrow;

  late final _i1.ColumnEnum<_i3.SpellAttackType> attackType;

  late final _i1.ColumnBool requiresAttackRoll;

  late final _i1.ColumnEnum<_i4.DamageType> damageType;

  late final _i1.ColumnString damageDice;

  late final _i1.ColumnSerializable damageScaling;

  late final _i1.ColumnSerializable damageParts;

  late final _i1.ColumnSerializable conditions;

  late final _i1.ColumnEnum<_i8.SpellTargetType> targetType;

  late final _i1.ColumnEnum<_i9.AreaOfEffectType> areaOfEffectType;

  late final _i1.ColumnInt areaOfEffectSize;

  late final _i1.ColumnInt areaOfEffectSecondarySize;

  late final _i1.ColumnInt areaOfEffectHeight;

  late final _i1.ColumnString materialDescription;

  late final _i1.ColumnInt materialCost;

  late final _i1.ColumnBool materialConsumed;

  late final _i1.ColumnEnum<_i10.SpellDurationType> durationType;

  late final _i1.ColumnBool isHealing;

  late final _i1.ColumnString healingDice;

  late final _i1.ColumnBool requiresLineOfSight;

  late final _i1.ColumnBool requiresVerbal;

  late final _i1.ColumnBool requiresSomatic;

  late final _i1.ColumnBool requiresMaterial;

  _i11.SpellClassAvailabilityDataTable? ___classAvailability;

  _i1.ManyRelation<_i11.SpellClassAvailabilityDataTable>? _classAvailability;

  _i11.SpellClassAvailabilityDataTable get __classAvailability {
    if (___classAvailability != null) return ___classAvailability!;
    ___classAvailability = _i1.createRelationTable(
      relationFieldName: '__classAvailability',
      field: SpellData.t.id,
      foreignField: _i11.SpellClassAvailabilityData.t.spellId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i11.SpellClassAvailabilityDataTable(
              tableRelation: foreignTableRelation),
    );
    return ___classAvailability!;
  }

  _i1.ManyRelation<_i11.SpellClassAvailabilityDataTable> get classAvailability {
    if (_classAvailability != null) return _classAvailability!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'classAvailability',
      field: SpellData.t.id,
      foreignField: _i11.SpellClassAvailabilityData.t.spellId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i11.SpellClassAvailabilityDataTable(
              tableRelation: foreignTableRelation),
    );
    _classAvailability = _i1.ManyRelation<_i11.SpellClassAvailabilityDataTable>(
      tableWithRelations: relationTable,
      table: _i11.SpellClassAvailabilityDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _classAvailability!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        referenceKey,
        name,
        description,
        shortDescription,
        source,
        version,
        createdAt,
        updatedAt,
        level,
        schoolValue,
        castingTime,
        range,
        duration,
        concentration,
        ritual,
        higherLevel,
        savingThrowAbility,
        requiresSavingThrow,
        attackType,
        requiresAttackRoll,
        damageType,
        damageDice,
        damageScaling,
        damageParts,
        conditions,
        targetType,
        areaOfEffectType,
        areaOfEffectSize,
        areaOfEffectSecondarySize,
        areaOfEffectHeight,
        materialDescription,
        materialCost,
        materialConsumed,
        durationType,
        isHealing,
        healingDice,
        requiresLineOfSight,
        requiresVerbal,
        requiresSomatic,
        requiresMaterial,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'classAvailability') {
      return __classAvailability;
    }
    return null;
  }
}

class SpellDataInclude extends _i1.IncludeObject {
  SpellDataInclude._(
      {_i11.SpellClassAvailabilityDataIncludeList? classAvailability}) {
    _classAvailability = classAvailability;
  }

  _i11.SpellClassAvailabilityDataIncludeList? _classAvailability;

  @override
  Map<String, _i1.Include?> get includes =>
      {'classAvailability': _classAvailability};

  @override
  _i1.Table<int?> get table => SpellData.t;
}

class SpellDataIncludeList extends _i1.IncludeList {
  SpellDataIncludeList._({
    _i1.WhereExpressionBuilder<SpellDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SpellData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SpellData.t;
}

class SpellDataRepository {
  const SpellDataRepository._();

  final attach = const SpellDataAttachRepository._();

  final attachRow = const SpellDataAttachRowRepository._();

  /// Returns a list of [SpellData]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<SpellData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpellDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SpellDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpellDataTable>? orderByList,
    _i1.Transaction? transaction,
    SpellDataInclude? include,
  }) async {
    return session.db.find<SpellData>(
      where: where?.call(SpellData.t),
      orderBy: orderBy?.call(SpellData.t),
      orderByList: orderByList?.call(SpellData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [SpellData] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<SpellData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpellDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<SpellDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpellDataTable>? orderByList,
    _i1.Transaction? transaction,
    SpellDataInclude? include,
  }) async {
    return session.db.findFirstRow<SpellData>(
      where: where?.call(SpellData.t),
      orderBy: orderBy?.call(SpellData.t),
      orderByList: orderByList?.call(SpellData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [SpellData] by its [id] or null if no such row exists.
  Future<SpellData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SpellDataInclude? include,
  }) async {
    return session.db.findById<SpellData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [SpellData]s in the list and returns the inserted rows.
  ///
  /// The returned [SpellData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SpellData>> insert(
    _i1.Session session,
    List<SpellData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SpellData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SpellData] and returns the inserted row.
  ///
  /// The returned [SpellData] will have its `id` field set.
  Future<SpellData> insertRow(
    _i1.Session session,
    SpellData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SpellData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SpellData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SpellData>> update(
    _i1.Session session,
    List<SpellData> rows, {
    _i1.ColumnSelections<SpellDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SpellData>(
      rows,
      columns: columns?.call(SpellData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SpellData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SpellData> updateRow(
    _i1.Session session,
    SpellData row, {
    _i1.ColumnSelections<SpellDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SpellData>(
      row,
      columns: columns?.call(SpellData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SpellData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SpellData>> delete(
    _i1.Session session,
    List<SpellData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SpellData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SpellData].
  Future<SpellData> deleteRow(
    _i1.Session session,
    SpellData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SpellData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SpellData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SpellDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SpellData>(
      where: where(SpellData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpellDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SpellData>(
      where: where?.call(SpellData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SpellDataAttachRepository {
  const SpellDataAttachRepository._();

  /// Creates a relation between this [SpellData] and the given [SpellClassAvailabilityData]s
  /// by setting each [SpellClassAvailabilityData]'s foreign key `spellId` to refer to this [SpellData].
  Future<void> classAvailability(
    _i1.Session session,
    SpellData spellData,
    List<_i11.SpellClassAvailabilityData> spellClassAvailabilityData, {
    _i1.Transaction? transaction,
  }) async {
    if (spellClassAvailabilityData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('spellClassAvailabilityData.id');
    }
    if (spellData.id == null) {
      throw ArgumentError.notNull('spellData.id');
    }

    var $spellClassAvailabilityData = spellClassAvailabilityData
        .map((e) => e.copyWith(spellId: spellData.id))
        .toList();
    await session.db.update<_i11.SpellClassAvailabilityData>(
      $spellClassAvailabilityData,
      columns: [_i11.SpellClassAvailabilityData.t.spellId],
      transaction: transaction,
    );
  }
}

class SpellDataAttachRowRepository {
  const SpellDataAttachRowRepository._();

  /// Creates a relation between this [SpellData] and the given [SpellClassAvailabilityData]
  /// by setting the [SpellClassAvailabilityData]'s foreign key `spellId` to refer to this [SpellData].
  Future<void> classAvailability(
    _i1.Session session,
    SpellData spellData,
    _i11.SpellClassAvailabilityData spellClassAvailabilityData, {
    _i1.Transaction? transaction,
  }) async {
    if (spellClassAvailabilityData.id == null) {
      throw ArgumentError.notNull('spellClassAvailabilityData.id');
    }
    if (spellData.id == null) {
      throw ArgumentError.notNull('spellData.id');
    }

    var $spellClassAvailabilityData =
        spellClassAvailabilityData.copyWith(spellId: spellData.id);
    await session.db.updateRow<_i11.SpellClassAvailabilityData>(
      $spellClassAvailabilityData,
      columns: [_i11.SpellClassAvailabilityData.t.spellId],
      transaction: transaction,
    );
  }
}
