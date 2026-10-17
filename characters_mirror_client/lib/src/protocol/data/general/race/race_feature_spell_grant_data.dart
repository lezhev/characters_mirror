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
import '../../../data/general/race/race_feature_data.dart' as _ib72xv5p;
import '../../../data/general/spell_activation_data.dart' as _ispxy1n8;
import '../../../data/spell_data.dart' as _isenpj1r;
import '../../../enums/ability.dart' as _iw3bk51e;
import '../../../enums/rest_type.dart' as _igwcjrvt;

abstract class RaceFeatureSpellGrantData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RaceFeatureSpellGrantData._({
    this.id,
    required this.featureId,
    this.feature,
    required this.spellId,
    this.spell,
    this.grantedAtLevel,
    this.activation,
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
    _ib72xv5p.RaceFeatureData? feature,
    required int spellId,
    _isenpj1r.SpellData? spell,
    int? grantedAtLevel,
    _ispxy1n8.SpellActivationData? activation,
    _iw3bk51e.Ability? castingAbility,
    _igwcjrvt.RestType? freeCastsPerRest,
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
    Map<String, dynamic> jsonSerialization,
  ) {
    return RaceFeatureSpellGrantData(
      id: jsonSerialization['id'] as int?,
      featureId: jsonSerialization['featureId'] as int,
      feature: jsonSerialization['feature'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_ib72xv5p.RaceFeatureData>(
              jsonSerialization['feature'],
            ),
      spellId: jsonSerialization['spellId'] as int,
      spell: jsonSerialization['spell'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_isenpj1r.SpellData>(
              jsonSerialization['spell'],
            ),
      grantedAtLevel: jsonSerialization['grantedAtLevel'] as int?,
      activation: jsonSerialization['activation'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_ispxy1n8.SpellActivationData>(
              jsonSerialization['activation'],
            ),
      castingAbility: jsonSerialization['castingAbility'] == null
          ? null
          : _iw3bk51e.Ability.fromJson(
              (jsonSerialization['castingAbility'] as String),
            ),
      freeCastsPerRest: jsonSerialization['freeCastsPerRest'] == null
          ? null
          : _igwcjrvt.RestType.fromJson(
              (jsonSerialization['freeCastsPerRest'] as String),
            ),
      freeCastsFormula: jsonSerialization['freeCastsFormula'] as String?,
      castAtSpellLevel: jsonSerialization['castAtSpellLevel'] as int?,
      canAlsoCastWithSpellSlots:
          jsonSerialization['canAlsoCastWithSpellSlots'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['canAlsoCastWithSpellSlots'],
            ),
      notes: jsonSerialization['notes'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int featureId;

  _ib72xv5p.RaceFeatureData? feature;

  int spellId;

  _isenpj1r.SpellData? spell;

  int? grantedAtLevel;

  _ispxy1n8.SpellActivationData? activation;

  _iw3bk51e.Ability? castingAbility;

  _igwcjrvt.RestType? freeCastsPerRest;

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
  @_isc.useResult
  RaceFeatureSpellGrantData copyWith({
    int? id,
    int? featureId,
    _ib72xv5p.RaceFeatureData? feature,
    int? spellId,
    _isenpj1r.SpellData? spell,
    int? grantedAtLevel,
    _ispxy1n8.SpellActivationData? activation,
    _iw3bk51e.Ability? castingAbility,
    _igwcjrvt.RestType? freeCastsPerRest,
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
      '__className__': 'RaceFeatureSpellGrantData',
      if (id != null) 'id': id,
      'featureId': featureId,
      if (feature != null) 'feature': feature?.toJson(),
      'spellId': spellId,
      if (spell != null) 'spell': spell?.toJson(),
      if (grantedAtLevel != null) 'grantedAtLevel': grantedAtLevel,
      if (activation != null) 'activation': activation?.toJson(),
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RaceFeatureSpellGrantData',
      if (id != null) 'id': id,
      'featureId': featureId,
      if (feature != null) 'feature': feature?.toJsonForProtocol(),
      'spellId': spellId,
      if (spell != null) 'spell': spell?.toJsonForProtocol(),
      if (grantedAtLevel != null) 'grantedAtLevel': grantedAtLevel,
      if (activation != null) 'activation': activation?.toJsonForProtocol(),
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
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RaceFeatureSpellGrantDataImpl extends RaceFeatureSpellGrantData {
  _RaceFeatureSpellGrantDataImpl({
    int? id,
    required int featureId,
    _ib72xv5p.RaceFeatureData? feature,
    required int spellId,
    _isenpj1r.SpellData? spell,
    int? grantedAtLevel,
    _ispxy1n8.SpellActivationData? activation,
    _iw3bk51e.Ability? castingAbility,
    _igwcjrvt.RestType? freeCastsPerRest,
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
         activation: activation,
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
  @_isc.useResult
  @override
  RaceFeatureSpellGrantData copyWith({
    Object? id = _Undefined,
    int? featureId,
    Object? feature = _Undefined,
    int? spellId,
    Object? spell = _Undefined,
    Object? grantedAtLevel = _Undefined,
    Object? activation = _Undefined,
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
      feature: feature is _ib72xv5p.RaceFeatureData?
          ? feature
          : this.feature?.copyWith(),
      spellId: spellId ?? this.spellId,
      spell: spell is _isenpj1r.SpellData? ? spell : this.spell?.copyWith(),
      grantedAtLevel: grantedAtLevel is int?
          ? grantedAtLevel
          : this.grantedAtLevel,
      activation: activation is _ispxy1n8.SpellActivationData?
          ? activation
          : this.activation?.copyWith(),
      castingAbility: castingAbility is _iw3bk51e.Ability?
          ? castingAbility
          : this.castingAbility,
      freeCastsPerRest: freeCastsPerRest is _igwcjrvt.RestType?
          ? freeCastsPerRest
          : this.freeCastsPerRest,
      freeCastsFormula: freeCastsFormula is String?
          ? freeCastsFormula
          : this.freeCastsFormula,
      castAtSpellLevel: castAtSpellLevel is int?
          ? castAtSpellLevel
          : this.castAtSpellLevel,
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
