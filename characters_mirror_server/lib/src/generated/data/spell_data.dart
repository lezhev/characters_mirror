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
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
import '../data/damage_part_data.dart' as _ipkv4dir;
import '../data/spell_scaling_data.dart' as _i5v09j9p;
import '../enums/condition_type.dart' as _i1o92bv5;
import '../enums/damage_type.dart' as _ijnkp14j;
import '../enums/spell/area_of_effect_type.dart' as _iic2crl0;
import '../enums/spell/area_size_measurement.dart' as _i21ejzqp;
import '../enums/spell/spell_attack_type.dart' as _iwtd0xj0;
import '../enums/spell/spell_duration_type.dart' as _i5aarrae;
import '../enums/spell/spell_school.dart' as _i2lm2lxc;
import '../enums/spell/spell_target_type.dart' as _i9llguqy;

abstract class SpellData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SpellData._({
    this.id,
    String? referenceKey,
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
    this.areaOfEffectSizeKind,
    this.areaOfEffectSecondarySize,
    this.areaOfEffectHeight,
    this.materialDescription,
    this.materialCost,
    this.materialConsumed,
    this.durationType,
    this.isHealing,
    this.healingDice,
    this.healingScaling,
    this.healingAddsCastingModifier,
    this.requiresLineOfSight,
    this.requiresVerbal,
    this.requiresSomatic,
    this.requiresMaterial,
    this.availableForClassIds,
    this.availableForSubclassIds,
  }) : referenceKey = referenceKey ?? '';

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
    _i2lm2lxc.SpellSchool? schoolValue,
    String? castingTime,
    String? range,
    String? duration,
    bool? concentration,
    bool? ritual,
    String? higherLevel,
    String? savingThrowAbility,
    bool? requiresSavingThrow,
    _iwtd0xj0.SpellAttackType? attackType,
    bool? requiresAttackRoll,
    _ijnkp14j.DamageType? damageType,
    String? damageDice,
    _i5v09j9p.SpellScalingData? damageScaling,
    List<_ipkv4dir.DamagePartData>? damageParts,
    List<_i1o92bv5.ConditionType>? conditions,
    _i9llguqy.SpellTargetType? targetType,
    _iic2crl0.AreaOfEffectType? areaOfEffectType,
    int? areaOfEffectSize,
    _i21ejzqp.AreaSizeMeasurement? areaOfEffectSizeKind,
    int? areaOfEffectSecondarySize,
    int? areaOfEffectHeight,
    String? materialDescription,
    int? materialCost,
    bool? materialConsumed,
    _i5aarrae.SpellDurationType? durationType,
    bool? isHealing,
    String? healingDice,
    _i5v09j9p.SpellScalingData? healingScaling,
    bool? healingAddsCastingModifier,
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
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      level: jsonSerialization['level'] as int?,
      schoolValue: jsonSerialization['schoolValue'] == null
          ? null
          : _i2lm2lxc.SpellSchool.fromJson(
              (jsonSerialization['schoolValue'] as String),
            ),
      castingTime: jsonSerialization['castingTime'] as String?,
      range: jsonSerialization['range'] as String?,
      duration: jsonSerialization['duration'] as String?,
      concentration: jsonSerialization['concentration'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['concentration']),
      ritual: jsonSerialization['ritual'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['ritual']),
      higherLevel: jsonSerialization['higherLevel'] as String?,
      savingThrowAbility: jsonSerialization['savingThrowAbility'] as String?,
      requiresSavingThrow: jsonSerialization['requiresSavingThrow'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['requiresSavingThrow'],
            ),
      attackType: jsonSerialization['attackType'] == null
          ? null
          : _iwtd0xj0.SpellAttackType.fromJson(
              (jsonSerialization['attackType'] as String),
            ),
      requiresAttackRoll: jsonSerialization['requiresAttackRoll'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['requiresAttackRoll'],
            ),
      damageType: jsonSerialization['damageType'] == null
          ? null
          : _ijnkp14j.DamageType.fromJson(
              (jsonSerialization['damageType'] as String),
            ),
      damageDice: jsonSerialization['damageDice'] as String?,
      damageScaling: jsonSerialization['damageScaling'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i5v09j9p.SpellScalingData>(
              jsonSerialization['damageScaling'],
            ),
      damageParts: jsonSerialization['damageParts'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ipkv4dir.DamagePartData>>(
              jsonSerialization['damageParts'],
            ),
      conditions: jsonSerialization['conditions'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_i1o92bv5.ConditionType>>(
              jsonSerialization['conditions'],
            ),
      targetType: jsonSerialization['targetType'] == null
          ? null
          : _i9llguqy.SpellTargetType.fromJson(
              (jsonSerialization['targetType'] as String),
            ),
      areaOfEffectType: jsonSerialization['areaOfEffectType'] == null
          ? null
          : _iic2crl0.AreaOfEffectType.fromJson(
              (jsonSerialization['areaOfEffectType'] as String),
            ),
      areaOfEffectSize: jsonSerialization['areaOfEffectSize'] as int?,
      areaOfEffectSizeKind: jsonSerialization['areaOfEffectSizeKind'] == null
          ? null
          : _i21ejzqp.AreaSizeMeasurement.fromJson(
              (jsonSerialization['areaOfEffectSizeKind'] as String),
            ),
      areaOfEffectSecondarySize:
          jsonSerialization['areaOfEffectSecondarySize'] as int?,
      areaOfEffectHeight: jsonSerialization['areaOfEffectHeight'] as int?,
      materialDescription: jsonSerialization['materialDescription'] as String?,
      materialCost: jsonSerialization['materialCost'] as int?,
      materialConsumed: jsonSerialization['materialConsumed'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['materialConsumed'],
            ),
      durationType: jsonSerialization['durationType'] == null
          ? null
          : _i5aarrae.SpellDurationType.fromJson(
              (jsonSerialization['durationType'] as String),
            ),
      isHealing: jsonSerialization['isHealing'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isHealing']),
      healingDice: jsonSerialization['healingDice'] as String?,
      healingScaling: jsonSerialization['healingScaling'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i5v09j9p.SpellScalingData>(
              jsonSerialization['healingScaling'],
            ),
      healingAddsCastingModifier:
          jsonSerialization['healingAddsCastingModifier'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['healingAddsCastingModifier'],
            ),
      requiresLineOfSight: jsonSerialization['requiresLineOfSight'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['requiresLineOfSight'],
            ),
      requiresVerbal: jsonSerialization['requiresVerbal'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['requiresVerbal']),
      requiresSomatic: jsonSerialization['requiresSomatic'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['requiresSomatic'],
            ),
      requiresMaterial: jsonSerialization['requiresMaterial'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['requiresMaterial'],
            ),
      availableForClassIds: jsonSerialization['availableForClassIds'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<int>>(
              jsonSerialization['availableForClassIds'],
            ),
      availableForSubclassIds:
          jsonSerialization['availableForSubclassIds'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<int>>(
              jsonSerialization['availableForSubclassIds'],
            ),
    );
  }

  static final t = SpellDataTable();

  static const db = SpellDataRepository._();

  @override
  int? id;

  String referenceKey;

  String? name;

  String? description;

  String? shortDescription;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int? level;

  _i2lm2lxc.SpellSchool? schoolValue;

  String? castingTime;

  String? range;

  String? duration;

  bool? concentration;

  bool? ritual;

  String? higherLevel;

  String? savingThrowAbility;

  bool? requiresSavingThrow;

  _iwtd0xj0.SpellAttackType? attackType;

  bool? requiresAttackRoll;

  _ijnkp14j.DamageType? damageType;

  String? damageDice;

  _i5v09j9p.SpellScalingData? damageScaling;

  List<_ipkv4dir.DamagePartData>? damageParts;

  List<_i1o92bv5.ConditionType>? conditions;

  _i9llguqy.SpellTargetType? targetType;

  _iic2crl0.AreaOfEffectType? areaOfEffectType;

  int? areaOfEffectSize;

  _i21ejzqp.AreaSizeMeasurement? areaOfEffectSizeKind;

  int? areaOfEffectSecondarySize;

  int? areaOfEffectHeight;

  String? materialDescription;

  int? materialCost;

  bool? materialConsumed;

  _i5aarrae.SpellDurationType? durationType;

  bool? isHealing;

  String? healingDice;

  _i5v09j9p.SpellScalingData? healingScaling;

  bool? healingAddsCastingModifier;

  bool? requiresLineOfSight;

  bool? requiresVerbal;

  bool? requiresSomatic;

  bool? requiresMaterial;

  List<int>? availableForClassIds;

  List<int>? availableForSubclassIds;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SpellData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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
    _i2lm2lxc.SpellSchool? schoolValue,
    String? castingTime,
    String? range,
    String? duration,
    bool? concentration,
    bool? ritual,
    String? higherLevel,
    String? savingThrowAbility,
    bool? requiresSavingThrow,
    _iwtd0xj0.SpellAttackType? attackType,
    bool? requiresAttackRoll,
    _ijnkp14j.DamageType? damageType,
    String? damageDice,
    _i5v09j9p.SpellScalingData? damageScaling,
    List<_ipkv4dir.DamagePartData>? damageParts,
    List<_i1o92bv5.ConditionType>? conditions,
    _i9llguqy.SpellTargetType? targetType,
    _iic2crl0.AreaOfEffectType? areaOfEffectType,
    int? areaOfEffectSize,
    _i21ejzqp.AreaSizeMeasurement? areaOfEffectSizeKind,
    int? areaOfEffectSecondarySize,
    int? areaOfEffectHeight,
    String? materialDescription,
    int? materialCost,
    bool? materialConsumed,
    _i5aarrae.SpellDurationType? durationType,
    bool? isHealing,
    String? healingDice,
    _i5v09j9p.SpellScalingData? healingScaling,
    bool? healingAddsCastingModifier,
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
      '__className__': 'SpellData',
      if (id != null) 'id': id,
      'referenceKey': referenceKey,
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
      if (areaOfEffectSizeKind != null)
        'areaOfEffectSizeKind': areaOfEffectSizeKind?.toJson(),
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
      if (healingScaling != null) 'healingScaling': healingScaling?.toJson(),
      if (healingAddsCastingModifier != null)
        'healingAddsCastingModifier': healingAddsCastingModifier,
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SpellData',
      if (id != null) 'id': id,
      'referenceKey': referenceKey,
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
        'damageParts': damageParts?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (conditions != null)
        'conditions': conditions?.toJson(valueToJson: (v) => v.toJson()),
      if (targetType != null) 'targetType': targetType?.toJson(),
      if (areaOfEffectType != null)
        'areaOfEffectType': areaOfEffectType?.toJson(),
      if (areaOfEffectSize != null) 'areaOfEffectSize': areaOfEffectSize,
      if (areaOfEffectSizeKind != null)
        'areaOfEffectSizeKind': areaOfEffectSizeKind?.toJson(),
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
      if (healingScaling != null)
        'healingScaling': healingScaling?.toJsonForProtocol(),
      if (healingAddsCastingModifier != null)
        'healingAddsCastingModifier': healingAddsCastingModifier,
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

  static SpellDataInclude include() {
    return SpellDataInclude._();
  }

  static SpellDataIncludeList includeList({
    _is.WhereExpressionBuilder<SpellDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SpellDataTable>? orderBy,
    _is.OrderByListBuilder<SpellDataTable>? orderByList,
    SpellDataInclude? include,
  }) {
    return SpellDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SpellData.t),
      orderByList: orderByList?.call(SpellData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
    _i2lm2lxc.SpellSchool? schoolValue,
    String? castingTime,
    String? range,
    String? duration,
    bool? concentration,
    bool? ritual,
    String? higherLevel,
    String? savingThrowAbility,
    bool? requiresSavingThrow,
    _iwtd0xj0.SpellAttackType? attackType,
    bool? requiresAttackRoll,
    _ijnkp14j.DamageType? damageType,
    String? damageDice,
    _i5v09j9p.SpellScalingData? damageScaling,
    List<_ipkv4dir.DamagePartData>? damageParts,
    List<_i1o92bv5.ConditionType>? conditions,
    _i9llguqy.SpellTargetType? targetType,
    _iic2crl0.AreaOfEffectType? areaOfEffectType,
    int? areaOfEffectSize,
    _i21ejzqp.AreaSizeMeasurement? areaOfEffectSizeKind,
    int? areaOfEffectSecondarySize,
    int? areaOfEffectHeight,
    String? materialDescription,
    int? materialCost,
    bool? materialConsumed,
    _i5aarrae.SpellDurationType? durationType,
    bool? isHealing,
    String? healingDice,
    _i5v09j9p.SpellScalingData? healingScaling,
    bool? healingAddsCastingModifier,
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
         areaOfEffectSizeKind: areaOfEffectSizeKind,
         areaOfEffectSecondarySize: areaOfEffectSecondarySize,
         areaOfEffectHeight: areaOfEffectHeight,
         materialDescription: materialDescription,
         materialCost: materialCost,
         materialConsumed: materialConsumed,
         durationType: durationType,
         isHealing: isHealing,
         healingDice: healingDice,
         healingScaling: healingScaling,
         healingAddsCastingModifier: healingAddsCastingModifier,
         requiresLineOfSight: requiresLineOfSight,
         requiresVerbal: requiresVerbal,
         requiresSomatic: requiresSomatic,
         requiresMaterial: requiresMaterial,
         availableForClassIds: availableForClassIds,
         availableForSubclassIds: availableForSubclassIds,
       );

  /// Returns a shallow copy of this [SpellData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SpellData copyWith({
    Object? id = _Undefined,
    String? referenceKey,
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
    Object? areaOfEffectSizeKind = _Undefined,
    Object? areaOfEffectSecondarySize = _Undefined,
    Object? areaOfEffectHeight = _Undefined,
    Object? materialDescription = _Undefined,
    Object? materialCost = _Undefined,
    Object? materialConsumed = _Undefined,
    Object? durationType = _Undefined,
    Object? isHealing = _Undefined,
    Object? healingDice = _Undefined,
    Object? healingScaling = _Undefined,
    Object? healingAddsCastingModifier = _Undefined,
    Object? requiresLineOfSight = _Undefined,
    Object? requiresVerbal = _Undefined,
    Object? requiresSomatic = _Undefined,
    Object? requiresMaterial = _Undefined,
    Object? availableForClassIds = _Undefined,
    Object? availableForSubclassIds = _Undefined,
  }) {
    return SpellData(
      id: id is int? ? id : this.id,
      referenceKey: referenceKey ?? this.referenceKey,
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
      schoolValue: schoolValue is _i2lm2lxc.SpellSchool?
          ? schoolValue
          : this.schoolValue,
      castingTime: castingTime is String? ? castingTime : this.castingTime,
      range: range is String? ? range : this.range,
      duration: duration is String? ? duration : this.duration,
      concentration: concentration is bool?
          ? concentration
          : this.concentration,
      ritual: ritual is bool? ? ritual : this.ritual,
      higherLevel: higherLevel is String? ? higherLevel : this.higherLevel,
      savingThrowAbility: savingThrowAbility is String?
          ? savingThrowAbility
          : this.savingThrowAbility,
      requiresSavingThrow: requiresSavingThrow is bool?
          ? requiresSavingThrow
          : this.requiresSavingThrow,
      attackType: attackType is _iwtd0xj0.SpellAttackType?
          ? attackType
          : this.attackType,
      requiresAttackRoll: requiresAttackRoll is bool?
          ? requiresAttackRoll
          : this.requiresAttackRoll,
      damageType: damageType is _ijnkp14j.DamageType?
          ? damageType
          : this.damageType,
      damageDice: damageDice is String? ? damageDice : this.damageDice,
      damageScaling: damageScaling is _i5v09j9p.SpellScalingData?
          ? damageScaling
          : this.damageScaling?.copyWith(),
      damageParts: damageParts is List<_ipkv4dir.DamagePartData>?
          ? damageParts
          : this.damageParts?.map((e0) => e0.copyWith()).toList(),
      conditions: conditions is List<_i1o92bv5.ConditionType>?
          ? conditions
          : this.conditions?.map((e0) => e0).toList(),
      targetType: targetType is _i9llguqy.SpellTargetType?
          ? targetType
          : this.targetType,
      areaOfEffectType: areaOfEffectType is _iic2crl0.AreaOfEffectType?
          ? areaOfEffectType
          : this.areaOfEffectType,
      areaOfEffectSize: areaOfEffectSize is int?
          ? areaOfEffectSize
          : this.areaOfEffectSize,
      areaOfEffectSizeKind:
          areaOfEffectSizeKind is _i21ejzqp.AreaSizeMeasurement?
          ? areaOfEffectSizeKind
          : this.areaOfEffectSizeKind,
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
      materialConsumed: materialConsumed is bool?
          ? materialConsumed
          : this.materialConsumed,
      durationType: durationType is _i5aarrae.SpellDurationType?
          ? durationType
          : this.durationType,
      isHealing: isHealing is bool? ? isHealing : this.isHealing,
      healingDice: healingDice is String? ? healingDice : this.healingDice,
      healingScaling: healingScaling is _i5v09j9p.SpellScalingData?
          ? healingScaling
          : this.healingScaling?.copyWith(),
      healingAddsCastingModifier: healingAddsCastingModifier is bool?
          ? healingAddsCastingModifier
          : this.healingAddsCastingModifier,
      requiresLineOfSight: requiresLineOfSight is bool?
          ? requiresLineOfSight
          : this.requiresLineOfSight,
      requiresVerbal: requiresVerbal is bool?
          ? requiresVerbal
          : this.requiresVerbal,
      requiresSomatic: requiresSomatic is bool?
          ? requiresSomatic
          : this.requiresSomatic,
      requiresMaterial: requiresMaterial is bool?
          ? requiresMaterial
          : this.requiresMaterial,
      availableForClassIds: availableForClassIds is List<int>?
          ? availableForClassIds
          : this.availableForClassIds?.map((e0) => e0).toList(),
      availableForSubclassIds: availableForSubclassIds is List<int>?
          ? availableForSubclassIds
          : this.availableForSubclassIds?.map((e0) => e0).toList(),
    );
  }
}

class SpellDataUpdateTable extends _is.UpdateTable<SpellDataTable> {
  SpellDataUpdateTable(super.table);

  _is.ColumnValue<String, String> referenceKey(String value) =>
      _is.ColumnValue(table.referenceKey, value);

  _is.ColumnValue<String, String> name(String? value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<String, String> shortDescription(String? value) =>
      _is.ColumnValue(table.shortDescription, value);

  _is.ColumnValue<String, String> source(String? value) =>
      _is.ColumnValue(table.source, value);

  _is.ColumnValue<int, int> version(int? value) =>
      _is.ColumnValue(table.version, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);

  _is.ColumnValue<int, int> level(int? value) =>
      _is.ColumnValue(table.level, value);

  _is.ColumnValue<_i2lm2lxc.SpellSchool, _i2lm2lxc.SpellSchool> schoolValue(
    _i2lm2lxc.SpellSchool? value,
  ) => _is.ColumnValue(table.schoolValue, value);

  _is.ColumnValue<String, String> castingTime(String? value) =>
      _is.ColumnValue(table.castingTime, value);

  _is.ColumnValue<String, String> range(String? value) =>
      _is.ColumnValue(table.range, value);

  _is.ColumnValue<String, String> duration(String? value) =>
      _is.ColumnValue(table.duration, value);

  _is.ColumnValue<bool, bool> concentration(bool? value) =>
      _is.ColumnValue(table.concentration, value);

  _is.ColumnValue<bool, bool> ritual(bool? value) =>
      _is.ColumnValue(table.ritual, value);

  _is.ColumnValue<String, String> higherLevel(String? value) =>
      _is.ColumnValue(table.higherLevel, value);

  _is.ColumnValue<String, String> savingThrowAbility(String? value) =>
      _is.ColumnValue(table.savingThrowAbility, value);

  _is.ColumnValue<bool, bool> requiresSavingThrow(bool? value) =>
      _is.ColumnValue(table.requiresSavingThrow, value);

  _is.ColumnValue<_iwtd0xj0.SpellAttackType, _iwtd0xj0.SpellAttackType>
  attackType(_iwtd0xj0.SpellAttackType? value) =>
      _is.ColumnValue(table.attackType, value);

  _is.ColumnValue<bool, bool> requiresAttackRoll(bool? value) =>
      _is.ColumnValue(table.requiresAttackRoll, value);

  _is.ColumnValue<_ijnkp14j.DamageType, _ijnkp14j.DamageType> damageType(
    _ijnkp14j.DamageType? value,
  ) => _is.ColumnValue(table.damageType, value);

  _is.ColumnValue<String, String> damageDice(String? value) =>
      _is.ColumnValue(table.damageDice, value);

  _is.ColumnValue<_i5v09j9p.SpellScalingData, _i5v09j9p.SpellScalingData>
  damageScaling(_i5v09j9p.SpellScalingData? value) =>
      _is.ColumnValue(table.damageScaling, value);

  _is.ColumnValue<
    List<_ipkv4dir.DamagePartData>,
    List<_ipkv4dir.DamagePartData>
  >
  damageParts(List<_ipkv4dir.DamagePartData>? value) =>
      _is.ColumnValue(table.damageParts, value);

  _is.ColumnValue<List<_i1o92bv5.ConditionType>, List<_i1o92bv5.ConditionType>>
  conditions(List<_i1o92bv5.ConditionType>? value) =>
      _is.ColumnValue(table.conditions, value);

  _is.ColumnValue<_i9llguqy.SpellTargetType, _i9llguqy.SpellTargetType>
  targetType(_i9llguqy.SpellTargetType? value) =>
      _is.ColumnValue(table.targetType, value);

  _is.ColumnValue<_iic2crl0.AreaOfEffectType, _iic2crl0.AreaOfEffectType>
  areaOfEffectType(_iic2crl0.AreaOfEffectType? value) =>
      _is.ColumnValue(table.areaOfEffectType, value);

  _is.ColumnValue<int, int> areaOfEffectSize(int? value) =>
      _is.ColumnValue(table.areaOfEffectSize, value);

  _is.ColumnValue<_i21ejzqp.AreaSizeMeasurement, _i21ejzqp.AreaSizeMeasurement>
  areaOfEffectSizeKind(_i21ejzqp.AreaSizeMeasurement? value) =>
      _is.ColumnValue(table.areaOfEffectSizeKind, value);

  _is.ColumnValue<int, int> areaOfEffectSecondarySize(int? value) =>
      _is.ColumnValue(table.areaOfEffectSecondarySize, value);

  _is.ColumnValue<int, int> areaOfEffectHeight(int? value) =>
      _is.ColumnValue(table.areaOfEffectHeight, value);

  _is.ColumnValue<String, String> materialDescription(String? value) =>
      _is.ColumnValue(table.materialDescription, value);

  _is.ColumnValue<int, int> materialCost(int? value) =>
      _is.ColumnValue(table.materialCost, value);

  _is.ColumnValue<bool, bool> materialConsumed(bool? value) =>
      _is.ColumnValue(table.materialConsumed, value);

  _is.ColumnValue<_i5aarrae.SpellDurationType, _i5aarrae.SpellDurationType>
  durationType(_i5aarrae.SpellDurationType? value) =>
      _is.ColumnValue(table.durationType, value);

  _is.ColumnValue<bool, bool> isHealing(bool? value) =>
      _is.ColumnValue(table.isHealing, value);

  _is.ColumnValue<String, String> healingDice(String? value) =>
      _is.ColumnValue(table.healingDice, value);

  _is.ColumnValue<_i5v09j9p.SpellScalingData, _i5v09j9p.SpellScalingData>
  healingScaling(_i5v09j9p.SpellScalingData? value) =>
      _is.ColumnValue(table.healingScaling, value);

  _is.ColumnValue<bool, bool> healingAddsCastingModifier(bool? value) =>
      _is.ColumnValue(table.healingAddsCastingModifier, value);

  _is.ColumnValue<bool, bool> requiresLineOfSight(bool? value) =>
      _is.ColumnValue(table.requiresLineOfSight, value);

  _is.ColumnValue<bool, bool> requiresVerbal(bool? value) =>
      _is.ColumnValue(table.requiresVerbal, value);

  _is.ColumnValue<bool, bool> requiresSomatic(bool? value) =>
      _is.ColumnValue(table.requiresSomatic, value);

  _is.ColumnValue<bool, bool> requiresMaterial(bool? value) =>
      _is.ColumnValue(table.requiresMaterial, value);

  _is.ColumnValue<List<int>, List<int>> availableForClassIds(
    List<int>? value,
  ) => _is.ColumnValue(table.availableForClassIds, value);

  _is.ColumnValue<List<int>, List<int>> availableForSubclassIds(
    List<int>? value,
  ) => _is.ColumnValue(table.availableForSubclassIds, value);
}

class SpellDataTable extends _is.Table<int?> {
  SpellDataTable({super.tableRelation}) : super(tableName: 'spell_data') {
    updateTable = SpellDataUpdateTable(this);
    referenceKey = _is.ColumnString('referenceKey', this);
    name = _is.ColumnString('name', this);
    description = _is.ColumnString('description', this);
    shortDescription = _is.ColumnString('shortDescription', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
    level = _is.ColumnInt('level', this);
    schoolValue = _is.ColumnEnum(
      'schoolValue',
      this,
      _is.EnumSerialization.byName,
    );
    castingTime = _is.ColumnString('castingTime', this);
    range = _is.ColumnString('range', this);
    duration = _is.ColumnString('duration', this);
    concentration = _is.ColumnBool('concentration', this);
    ritual = _is.ColumnBool('ritual', this);
    higherLevel = _is.ColumnString('higherLevel', this);
    savingThrowAbility = _is.ColumnString('savingThrowAbility', this);
    requiresSavingThrow = _is.ColumnBool('requiresSavingThrow', this);
    attackType = _is.ColumnEnum(
      'attackType',
      this,
      _is.EnumSerialization.byName,
    );
    requiresAttackRoll = _is.ColumnBool('requiresAttackRoll', this);
    damageType = _is.ColumnEnum(
      'damageType',
      this,
      _is.EnumSerialization.byName,
    );
    damageDice = _is.ColumnString('damageDice', this);
    damageScaling = _is.ColumnSerializable<_i5v09j9p.SpellScalingData>(
      'damageScaling',
      this,
    );
    damageParts = _is.ColumnSerializable<List<_ipkv4dir.DamagePartData>>(
      'damageParts',
      this,
    );
    conditions = _is.ColumnSerializable<List<_i1o92bv5.ConditionType>>(
      'conditions',
      this,
    );
    targetType = _is.ColumnEnum(
      'targetType',
      this,
      _is.EnumSerialization.byName,
    );
    areaOfEffectType = _is.ColumnEnum(
      'areaOfEffectType',
      this,
      _is.EnumSerialization.byName,
    );
    areaOfEffectSize = _is.ColumnInt('areaOfEffectSize', this);
    areaOfEffectSizeKind = _is.ColumnEnum(
      'areaOfEffectSizeKind',
      this,
      _is.EnumSerialization.byName,
    );
    areaOfEffectSecondarySize = _is.ColumnInt(
      'areaOfEffectSecondarySize',
      this,
    );
    areaOfEffectHeight = _is.ColumnInt('areaOfEffectHeight', this);
    materialDescription = _is.ColumnString('materialDescription', this);
    materialCost = _is.ColumnInt('materialCost', this);
    materialConsumed = _is.ColumnBool('materialConsumed', this);
    durationType = _is.ColumnEnum(
      'durationType',
      this,
      _is.EnumSerialization.byName,
    );
    isHealing = _is.ColumnBool('isHealing', this);
    healingDice = _is.ColumnString('healingDice', this);
    healingScaling = _is.ColumnSerializable<_i5v09j9p.SpellScalingData>(
      'healingScaling',
      this,
    );
    healingAddsCastingModifier = _is.ColumnBool(
      'healingAddsCastingModifier',
      this,
    );
    requiresLineOfSight = _is.ColumnBool('requiresLineOfSight', this);
    requiresVerbal = _is.ColumnBool('requiresVerbal', this);
    requiresSomatic = _is.ColumnBool('requiresSomatic', this);
    requiresMaterial = _is.ColumnBool('requiresMaterial', this);
    availableForClassIds = _is.ColumnSerializable<List<int>>(
      'availableForClassIds',
      this,
    );
    availableForSubclassIds = _is.ColumnSerializable<List<int>>(
      'availableForSubclassIds',
      this,
    );
  }

  late final SpellDataUpdateTable updateTable;

  late final _is.ColumnString referenceKey;

  late final _is.ColumnString name;

  late final _is.ColumnString description;

  late final _is.ColumnString shortDescription;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnInt level;

  late final _is.ColumnEnum<_i2lm2lxc.SpellSchool> schoolValue;

  late final _is.ColumnString castingTime;

  late final _is.ColumnString range;

  late final _is.ColumnString duration;

  late final _is.ColumnBool concentration;

  late final _is.ColumnBool ritual;

  late final _is.ColumnString higherLevel;

  late final _is.ColumnString savingThrowAbility;

  late final _is.ColumnBool requiresSavingThrow;

  late final _is.ColumnEnum<_iwtd0xj0.SpellAttackType> attackType;

  late final _is.ColumnBool requiresAttackRoll;

  late final _is.ColumnEnum<_ijnkp14j.DamageType> damageType;

  late final _is.ColumnString damageDice;

  late final _is.ColumnSerializable<_i5v09j9p.SpellScalingData> damageScaling;

  late final _is.ColumnSerializable<List<_ipkv4dir.DamagePartData>> damageParts;

  late final _is.ColumnSerializable<List<_i1o92bv5.ConditionType>> conditions;

  late final _is.ColumnEnum<_i9llguqy.SpellTargetType> targetType;

  late final _is.ColumnEnum<_iic2crl0.AreaOfEffectType> areaOfEffectType;

  late final _is.ColumnInt areaOfEffectSize;

  late final _is.ColumnEnum<_i21ejzqp.AreaSizeMeasurement> areaOfEffectSizeKind;

  late final _is.ColumnInt areaOfEffectSecondarySize;

  late final _is.ColumnInt areaOfEffectHeight;

  late final _is.ColumnString materialDescription;

  late final _is.ColumnInt materialCost;

  late final _is.ColumnBool materialConsumed;

  late final _is.ColumnEnum<_i5aarrae.SpellDurationType> durationType;

  late final _is.ColumnBool isHealing;

  late final _is.ColumnString healingDice;

  late final _is.ColumnSerializable<_i5v09j9p.SpellScalingData> healingScaling;

  late final _is.ColumnBool healingAddsCastingModifier;

  late final _is.ColumnBool requiresLineOfSight;

  late final _is.ColumnBool requiresVerbal;

  late final _is.ColumnBool requiresSomatic;

  late final _is.ColumnBool requiresMaterial;

  late final _is.ColumnSerializable<List<int>> availableForClassIds;

  late final _is.ColumnSerializable<List<int>> availableForSubclassIds;

  @override
  List<_is.Column> get columns => [
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
    areaOfEffectSizeKind,
    areaOfEffectSecondarySize,
    areaOfEffectHeight,
    materialDescription,
    materialCost,
    materialConsumed,
    durationType,
    isHealing,
    healingDice,
    healingScaling,
    healingAddsCastingModifier,
    requiresLineOfSight,
    requiresVerbal,
    requiresSomatic,
    requiresMaterial,
    availableForClassIds,
    availableForSubclassIds,
  ];
}

class SpellDataInclude extends _is.IncludeObject {
  SpellDataInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SpellData.t;
}

class SpellDataIncludeList extends _is.IncludeList {
  SpellDataIncludeList._({
    _is.WhereExpressionBuilder<SpellDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SpellData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SpellData.t;
}

class SpellDataRepository {
  const SpellDataRepository._();

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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SpellDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SpellDataTable>? orderBy,
    _is.OrderByListBuilder<SpellDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SpellData>(
      where: where?.call(SpellData.t),
      orderBy: orderBy?.call(SpellData.t),
      orderByList: orderByList?.call(SpellData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SpellDataTable>? where,
    int? offset,
    _is.OrderByBuilder<SpellDataTable>? orderBy,
    _is.OrderByListBuilder<SpellDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SpellData>(
      where: where?.call(SpellData.t),
      orderBy: orderBy?.call(SpellData.t),
      orderByList: orderByList?.call(SpellData.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SpellData] by its [id] or null if no such row exists.
  Future<SpellData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SpellData>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SpellData]s in the list and returns the inserted rows.
  ///
  /// The returned [SpellData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SpellData>> insert(
    _is.DatabaseSession session,
    List<SpellData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SpellData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SpellData] and returns the inserted row.
  ///
  /// The returned [SpellData] will have its `id` field set.
  Future<SpellData> insertRow(
    _is.DatabaseSession session,
    SpellData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SpellData>(row, transaction: transaction);
  }

  /// Upserts all [SpellData]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [SpellData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SpellData>> upsert(
    _is.DatabaseSession session,
    List<SpellData> rows, {
    required _is.ColumnSelections<SpellDataTable> conflictColumns,
    _is.ColumnSelections<SpellDataTable>? updateColumns,
    _is.WhereExpressionBuilder<SpellDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SpellData>(
      rows,
      conflictColumns: conflictColumns(SpellData.t),
      updateColumns: updateColumns?.call(SpellData.t),
      updateWhere: updateWhere?.call(SpellData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SpellData] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [SpellData] will have its `id` field set.
  Future<SpellData?> upsertRow(
    _is.DatabaseSession session,
    SpellData row, {
    required _is.ColumnSelections<SpellDataTable> conflictColumns,
    _is.ColumnSelections<SpellDataTable>? updateColumns,
    _is.WhereExpressionBuilder<SpellDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SpellData>(
      row,
      conflictColumns: conflictColumns(SpellData.t),
      updateColumns: updateColumns?.call(SpellData.t),
      updateWhere: updateWhere?.call(SpellData.t),
      transaction: transaction,
    );
  }

  /// Updates all [SpellData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SpellData>> update(
    _is.DatabaseSession session,
    List<SpellData> rows, {
    _is.ColumnSelections<SpellDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SpellData>(
      rows,
      columns: columns?.call(SpellData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SpellData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SpellData> updateRow(
    _is.DatabaseSession session,
    SpellData row, {
    _is.ColumnSelections<SpellDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SpellData>(
      row,
      columns: columns?.call(SpellData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SpellData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SpellData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SpellDataUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SpellData>(
      id,
      columnValues: columnValues(SpellData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SpellData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SpellData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SpellDataUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SpellDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SpellDataTable>? orderBy,
    _is.OrderByListBuilder<SpellDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SpellData>(
      columnValues: columnValues(SpellData.t.updateTable),
      where: where(SpellData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SpellData.t),
      orderByList: orderByList?.call(SpellData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SpellData]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SpellData>> delete(
    _is.DatabaseSession session,
    List<SpellData> rows, {
    _is.OrderByBuilder<SpellDataTable>? orderBy,
    _is.OrderByListBuilder<SpellDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SpellData>(
      rows,
      orderBy: orderBy?.call(SpellData.t),
      orderByList: orderByList?.call(SpellData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SpellData].
  Future<SpellData> deleteRow(
    _is.DatabaseSession session,
    SpellData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SpellData>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SpellData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SpellDataTable> where,
    _is.OrderByBuilder<SpellDataTable>? orderBy,
    _is.OrderByListBuilder<SpellDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SpellData>(
      where: where(SpellData.t),
      orderBy: orderBy?.call(SpellData.t),
      orderByList: orderByList?.call(SpellData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SpellDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SpellData>(
      where: where?.call(SpellData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SpellData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SpellDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SpellData>(
      where: where(SpellData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
