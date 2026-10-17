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
import '../../../data/general/race/race_data.dart' as _ittxuxz1;
import '../../../data/general/race/race_feature_data.dart' as _ib72xv5p;
import '../../../enums/armor_category.dart' as _irzuusaf;
import '../../../enums/damage_type.dart' as _ij9bzpyl;
import '../../../enums/skill.dart' as _iqrhamom;

abstract class SubraceData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SubraceData._({
    this.id,
    this.name,
    required this.parentRaceId,
    this.parentRace,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.strengthBonus,
    this.dexterityBonus,
    this.constitutionBonus,
    this.intelligenceBonus,
    this.wisdomBonus,
    this.charismaBonus,
    this.traits,
    this.speedOverride,
    this.visionRangeOverride,
    this.skillProficiencies,
    this.resistances,
    this.armorProficiencies,
    this.weaponProficiencyKeys,
    this.toolProficiencyKeys,
    this.features,
  });

  factory SubraceData({
    int? id,
    String? name,
    required int parentRaceId,
    _ittxuxz1.RaceData? parentRace,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? strengthBonus,
    int? dexterityBonus,
    int? constitutionBonus,
    int? intelligenceBonus,
    int? wisdomBonus,
    int? charismaBonus,
    List<String>? traits,
    int? speedOverride,
    int? visionRangeOverride,
    List<_iqrhamom.Skill>? skillProficiencies,
    List<_ij9bzpyl.DamageType>? resistances,
    List<_irzuusaf.ArmorCategory>? armorProficiencies,
    List<String>? weaponProficiencyKeys,
    List<String>? toolProficiencyKeys,
    List<_ib72xv5p.RaceFeatureData>? features,
  }) = _SubraceDataImpl;

  factory SubraceData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubraceData(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String?,
      parentRaceId: jsonSerialization['parentRaceId'] as int,
      parentRace: jsonSerialization['parentRace'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_ittxuxz1.RaceData>(
              jsonSerialization['parentRace'],
            ),
      description: jsonSerialization['description'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      strengthBonus: jsonSerialization['strengthBonus'] as int?,
      dexterityBonus: jsonSerialization['dexterityBonus'] as int?,
      constitutionBonus: jsonSerialization['constitutionBonus'] as int?,
      intelligenceBonus: jsonSerialization['intelligenceBonus'] as int?,
      wisdomBonus: jsonSerialization['wisdomBonus'] as int?,
      charismaBonus: jsonSerialization['charismaBonus'] as int?,
      traits: jsonSerialization['traits'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['traits'],
            ),
      speedOverride: jsonSerialization['speedOverride'] as int?,
      visionRangeOverride: jsonSerialization['visionRangeOverride'] as int?,
      skillProficiencies: jsonSerialization['skillProficiencies'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_iqrhamom.Skill>>(
              jsonSerialization['skillProficiencies'],
            ),
      resistances: jsonSerialization['resistances'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_ij9bzpyl.DamageType>>(
              jsonSerialization['resistances'],
            ),
      armorProficiencies: jsonSerialization['armorProficiencies'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_irzuusaf.ArmorCategory>>(
              jsonSerialization['armorProficiencies'],
            ),
      weaponProficiencyKeys: jsonSerialization['weaponProficiencyKeys'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['weaponProficiencyKeys'],
            ),
      toolProficiencyKeys: jsonSerialization['toolProficiencyKeys'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['toolProficiencyKeys'],
            ),
      features: jsonSerialization['features'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_ib72xv5p.RaceFeatureData>>(
              jsonSerialization['features'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? name;

  int parentRaceId;

  _ittxuxz1.RaceData? parentRace;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int? strengthBonus;

  int? dexterityBonus;

  int? constitutionBonus;

  int? intelligenceBonus;

  int? wisdomBonus;

  int? charismaBonus;

  List<String>? traits;

  int? speedOverride;

  int? visionRangeOverride;

  List<_iqrhamom.Skill>? skillProficiencies;

  List<_ij9bzpyl.DamageType>? resistances;

  List<_irzuusaf.ArmorCategory>? armorProficiencies;

  List<String>? weaponProficiencyKeys;

  List<String>? toolProficiencyKeys;

  List<_ib72xv5p.RaceFeatureData>? features;

  /// Returns a shallow copy of this [SubraceData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SubraceData copyWith({
    int? id,
    String? name,
    int? parentRaceId,
    _ittxuxz1.RaceData? parentRace,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? strengthBonus,
    int? dexterityBonus,
    int? constitutionBonus,
    int? intelligenceBonus,
    int? wisdomBonus,
    int? charismaBonus,
    List<String>? traits,
    int? speedOverride,
    int? visionRangeOverride,
    List<_iqrhamom.Skill>? skillProficiencies,
    List<_ij9bzpyl.DamageType>? resistances,
    List<_irzuusaf.ArmorCategory>? armorProficiencies,
    List<String>? weaponProficiencyKeys,
    List<String>? toolProficiencyKeys,
    List<_ib72xv5p.RaceFeatureData>? features,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubraceData',
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      'parentRaceId': parentRaceId,
      if (parentRace != null) 'parentRace': parentRace?.toJson(),
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (strengthBonus != null) 'strengthBonus': strengthBonus,
      if (dexterityBonus != null) 'dexterityBonus': dexterityBonus,
      if (constitutionBonus != null) 'constitutionBonus': constitutionBonus,
      if (intelligenceBonus != null) 'intelligenceBonus': intelligenceBonus,
      if (wisdomBonus != null) 'wisdomBonus': wisdomBonus,
      if (charismaBonus != null) 'charismaBonus': charismaBonus,
      if (traits != null) 'traits': traits?.toJson(),
      if (speedOverride != null) 'speedOverride': speedOverride,
      if (visionRangeOverride != null)
        'visionRangeOverride': visionRangeOverride,
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (resistances != null)
        'resistances': resistances?.toJson(valueToJson: (v) => v.toJson()),
      if (armorProficiencies != null)
        'armorProficiencies': armorProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (weaponProficiencyKeys != null)
        'weaponProficiencyKeys': weaponProficiencyKeys?.toJson(),
      if (toolProficiencyKeys != null)
        'toolProficiencyKeys': toolProficiencyKeys?.toJson(),
      if (features != null)
        'features': features?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SubraceData',
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      'parentRaceId': parentRaceId,
      if (parentRace != null) 'parentRace': parentRace?.toJsonForProtocol(),
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (strengthBonus != null) 'strengthBonus': strengthBonus,
      if (dexterityBonus != null) 'dexterityBonus': dexterityBonus,
      if (constitutionBonus != null) 'constitutionBonus': constitutionBonus,
      if (intelligenceBonus != null) 'intelligenceBonus': intelligenceBonus,
      if (wisdomBonus != null) 'wisdomBonus': wisdomBonus,
      if (charismaBonus != null) 'charismaBonus': charismaBonus,
      if (traits != null) 'traits': traits?.toJson(),
      if (speedOverride != null) 'speedOverride': speedOverride,
      if (visionRangeOverride != null)
        'visionRangeOverride': visionRangeOverride,
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (resistances != null)
        'resistances': resistances?.toJson(valueToJson: (v) => v.toJson()),
      if (armorProficiencies != null)
        'armorProficiencies': armorProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (weaponProficiencyKeys != null)
        'weaponProficiencyKeys': weaponProficiencyKeys?.toJson(),
      if (toolProficiencyKeys != null)
        'toolProficiencyKeys': toolProficiencyKeys?.toJson(),
      if (features != null)
        'features': features?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubraceDataImpl extends SubraceData {
  _SubraceDataImpl({
    int? id,
    String? name,
    required int parentRaceId,
    _ittxuxz1.RaceData? parentRace,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? strengthBonus,
    int? dexterityBonus,
    int? constitutionBonus,
    int? intelligenceBonus,
    int? wisdomBonus,
    int? charismaBonus,
    List<String>? traits,
    int? speedOverride,
    int? visionRangeOverride,
    List<_iqrhamom.Skill>? skillProficiencies,
    List<_ij9bzpyl.DamageType>? resistances,
    List<_irzuusaf.ArmorCategory>? armorProficiencies,
    List<String>? weaponProficiencyKeys,
    List<String>? toolProficiencyKeys,
    List<_ib72xv5p.RaceFeatureData>? features,
  }) : super._(
         id: id,
         name: name,
         parentRaceId: parentRaceId,
         parentRace: parentRace,
         description: description,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
         strengthBonus: strengthBonus,
         dexterityBonus: dexterityBonus,
         constitutionBonus: constitutionBonus,
         intelligenceBonus: intelligenceBonus,
         wisdomBonus: wisdomBonus,
         charismaBonus: charismaBonus,
         traits: traits,
         speedOverride: speedOverride,
         visionRangeOverride: visionRangeOverride,
         skillProficiencies: skillProficiencies,
         resistances: resistances,
         armorProficiencies: armorProficiencies,
         weaponProficiencyKeys: weaponProficiencyKeys,
         toolProficiencyKeys: toolProficiencyKeys,
         features: features,
       );

  /// Returns a shallow copy of this [SubraceData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SubraceData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    int? parentRaceId,
    Object? parentRace = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? strengthBonus = _Undefined,
    Object? dexterityBonus = _Undefined,
    Object? constitutionBonus = _Undefined,
    Object? intelligenceBonus = _Undefined,
    Object? wisdomBonus = _Undefined,
    Object? charismaBonus = _Undefined,
    Object? traits = _Undefined,
    Object? speedOverride = _Undefined,
    Object? visionRangeOverride = _Undefined,
    Object? skillProficiencies = _Undefined,
    Object? resistances = _Undefined,
    Object? armorProficiencies = _Undefined,
    Object? weaponProficiencyKeys = _Undefined,
    Object? toolProficiencyKeys = _Undefined,
    Object? features = _Undefined,
  }) {
    return SubraceData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      parentRaceId: parentRaceId ?? this.parentRaceId,
      parentRace: parentRace is _ittxuxz1.RaceData?
          ? parentRace
          : this.parentRace?.copyWith(),
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      strengthBonus: strengthBonus is int? ? strengthBonus : this.strengthBonus,
      dexterityBonus: dexterityBonus is int?
          ? dexterityBonus
          : this.dexterityBonus,
      constitutionBonus: constitutionBonus is int?
          ? constitutionBonus
          : this.constitutionBonus,
      intelligenceBonus: intelligenceBonus is int?
          ? intelligenceBonus
          : this.intelligenceBonus,
      wisdomBonus: wisdomBonus is int? ? wisdomBonus : this.wisdomBonus,
      charismaBonus: charismaBonus is int? ? charismaBonus : this.charismaBonus,
      traits: traits is List<String>?
          ? traits
          : this.traits?.map((e0) => e0).toList(),
      speedOverride: speedOverride is int? ? speedOverride : this.speedOverride,
      visionRangeOverride: visionRangeOverride is int?
          ? visionRangeOverride
          : this.visionRangeOverride,
      skillProficiencies: skillProficiencies is List<_iqrhamom.Skill>?
          ? skillProficiencies
          : this.skillProficiencies?.map((e0) => e0).toList(),
      resistances: resistances is List<_ij9bzpyl.DamageType>?
          ? resistances
          : this.resistances?.map((e0) => e0).toList(),
      armorProficiencies: armorProficiencies is List<_irzuusaf.ArmorCategory>?
          ? armorProficiencies
          : this.armorProficiencies?.map((e0) => e0).toList(),
      weaponProficiencyKeys: weaponProficiencyKeys is List<String>?
          ? weaponProficiencyKeys
          : this.weaponProficiencyKeys?.map((e0) => e0).toList(),
      toolProficiencyKeys: toolProficiencyKeys is List<String>?
          ? toolProficiencyKeys
          : this.toolProficiencyKeys?.map((e0) => e0).toList(),
      features: features is List<_ib72xv5p.RaceFeatureData>?
          ? features
          : this.features?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
