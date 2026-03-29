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
import '../../../data/general/race/race_feature_data.dart' as _i2;
import '../../../data/spell_data.dart' as _i3;
import '../../../enums/ability.dart' as _i4;
import '../../../enums/rest_type.dart' as _i5;

abstract class RaceFeatureSpellGrantData implements _i1.SerializableModel {
  RaceFeatureSpellGrantData._({
    this.id,
    required this.featureId,
    this.feature,
    required this.spellId,
    this.spell,
    this.grantedAtLevel,
    this.castingAbility,
    this.freeCastsPerRest,
    this.freeCastsFormula,
    this.castAtSpellLevel,
    this.canAlsoCastWithSpellSlots,
    this.notes,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory RaceFeatureSpellGrantData({
    int? id,
    required int featureId,
    _i2.RaceFeatureData? feature,
    required int spellId,
    _i3.SpellData? spell,
    int? grantedAtLevel,
    _i4.Ability? castingAbility,
    _i5.RestType? freeCastsPerRest,
    String? freeCastsFormula,
    int? castAtSpellLevel,
    bool? canAlsoCastWithSpellSlots,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _RaceFeatureSpellGrantDataImpl;

  factory RaceFeatureSpellGrantData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return RaceFeatureSpellGrantData(
      id: jsonSerialization['id'] as int?,
      featureId: jsonSerialization['featureId'] as int,
      feature: jsonSerialization['feature'] == null
          ? null
          : _i2.RaceFeatureData.fromJson(
              (jsonSerialization['feature'] as Map<String, dynamic>)),
      spellId: jsonSerialization['spellId'] as int,
      spell: jsonSerialization['spell'] == null
          ? null
          : _i3.SpellData.fromJson(
              (jsonSerialization['spell'] as Map<String, dynamic>)),
      grantedAtLevel: jsonSerialization['grantedAtLevel'] as int?,
      castingAbility: jsonSerialization['castingAbility'] == null
          ? null
          : _i4.Ability.fromJson(
              (jsonSerialization['castingAbility'] as String)),
      freeCastsPerRest: jsonSerialization['freeCastsPerRest'] == null
          ? null
          : _i5.RestType.fromJson(
              (jsonSerialization['freeCastsPerRest'] as String)),
      freeCastsFormula: jsonSerialization['freeCastsFormula'] as String?,
      castAtSpellLevel: jsonSerialization['castAtSpellLevel'] as int?,
      canAlsoCastWithSpellSlots:
          jsonSerialization['canAlsoCastWithSpellSlots'] as bool?,
      notes: jsonSerialization['notes'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int featureId;

  _i2.RaceFeatureData? feature;

  int spellId;

  _i3.SpellData? spell;

  int? grantedAtLevel;

  _i4.Ability? castingAbility;

  _i5.RestType? freeCastsPerRest;

  String? freeCastsFormula;

  int? castAtSpellLevel;

  bool? canAlsoCastWithSpellSlots;

  String? notes;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [RaceFeatureSpellGrantData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RaceFeatureSpellGrantData copyWith({
    int? id,
    int? featureId,
    _i2.RaceFeatureData? feature,
    int? spellId,
    _i3.SpellData? spell,
    int? grantedAtLevel,
    _i4.Ability? castingAbility,
    _i5.RestType? freeCastsPerRest,
    String? freeCastsFormula,
    int? castAtSpellLevel,
    bool? canAlsoCastWithSpellSlots,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'featureId': featureId,
      if (feature != null) 'feature': feature?.toJson(),
      'spellId': spellId,
      if (spell != null) 'spell': spell?.toJson(),
      if (grantedAtLevel != null) 'grantedAtLevel': grantedAtLevel,
      if (castingAbility != null) 'castingAbility': castingAbility?.toJson(),
      if (freeCastsPerRest != null)
        'freeCastsPerRest': freeCastsPerRest?.toJson(),
      if (freeCastsFormula != null) 'freeCastsFormula': freeCastsFormula,
      if (castAtSpellLevel != null) 'castAtSpellLevel': castAtSpellLevel,
      if (canAlsoCastWithSpellSlots != null)
        'canAlsoCastWithSpellSlots': canAlsoCastWithSpellSlots,
      if (notes != null) 'notes': notes,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RaceFeatureSpellGrantDataImpl extends RaceFeatureSpellGrantData {
  _RaceFeatureSpellGrantDataImpl({
    int? id,
    required int featureId,
    _i2.RaceFeatureData? feature,
    required int spellId,
    _i3.SpellData? spell,
    int? grantedAtLevel,
    _i4.Ability? castingAbility,
    _i5.RestType? freeCastsPerRest,
    String? freeCastsFormula,
    int? castAtSpellLevel,
    bool? canAlsoCastWithSpellSlots,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          featureId: featureId,
          feature: feature,
          spellId: spellId,
          spell: spell,
          grantedAtLevel: grantedAtLevel,
          castingAbility: castingAbility,
          freeCastsPerRest: freeCastsPerRest,
          freeCastsFormula: freeCastsFormula,
          castAtSpellLevel: castAtSpellLevel,
          canAlsoCastWithSpellSlots: canAlsoCastWithSpellSlots,
          notes: notes,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [RaceFeatureSpellGrantData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RaceFeatureSpellGrantData copyWith({
    Object? id = _Undefined,
    int? featureId,
    Object? feature = _Undefined,
    int? spellId,
    Object? spell = _Undefined,
    Object? grantedAtLevel = _Undefined,
    Object? castingAbility = _Undefined,
    Object? freeCastsPerRest = _Undefined,
    Object? freeCastsFormula = _Undefined,
    Object? castAtSpellLevel = _Undefined,
    Object? canAlsoCastWithSpellSlots = _Undefined,
    Object? notes = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return RaceFeatureSpellGrantData(
      id: id is int? ? id : this.id,
      featureId: featureId ?? this.featureId,
      feature:
          feature is _i2.RaceFeatureData? ? feature : this.feature?.copyWith(),
      spellId: spellId ?? this.spellId,
      spell: spell is _i3.SpellData? ? spell : this.spell?.copyWith(),
      grantedAtLevel:
          grantedAtLevel is int? ? grantedAtLevel : this.grantedAtLevel,
      castingAbility:
          castingAbility is _i4.Ability? ? castingAbility : this.castingAbility,
      freeCastsPerRest: freeCastsPerRest is _i5.RestType?
          ? freeCastsPerRest
          : this.freeCastsPerRest,
      freeCastsFormula: freeCastsFormula is String?
          ? freeCastsFormula
          : this.freeCastsFormula,
      castAtSpellLevel:
          castAtSpellLevel is int? ? castAtSpellLevel : this.castAtSpellLevel,
      canAlsoCastWithSpellSlots: canAlsoCastWithSpellSlots is bool?
          ? canAlsoCastWithSpellSlots
          : this.canAlsoCastWithSpellSlots,
      notes: notes is String? ? notes : this.notes,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
