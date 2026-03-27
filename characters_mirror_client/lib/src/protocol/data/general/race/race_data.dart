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
import '../../../data/spell_data.dart' as _i2;

abstract class RaceData implements _i1.SerializableModel {
  RaceData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.speed,
    this.size,
    this.abilityBonuses,
    this.traits,
    this.languages,
    this.visionType,
    this.resistances,
    this.skillProficiencies,
    this.armorProficiencies,
    this.weaponProficiencies,
    this.toolProficiencies,
    this.spellcasting,
    this.imageURL,
  });

  factory RaceData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? speed,
    String? size,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<String>? languages,
    String? visionType,
    List<String>? resistances,
    List<String>? skillProficiencies,
    List<String>? armorProficiencies,
    List<String>? weaponProficiencies,
    List<String>? toolProficiencies,
    Map<String, _i2.SpellData>? spellcasting,
    String? imageURL,
  }) = _RaceDataImpl;

  factory RaceData.fromJson(Map<String, dynamic> jsonSerialization) {
    return RaceData(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      speed: jsonSerialization['speed'] as int?,
      size: jsonSerialization['size'] as String?,
      abilityBonuses:
          (jsonSerialization['abilityBonuses'] as Map?)?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      traits: (jsonSerialization['traits'] as List?)
          ?.map((e) => e as String)
          .toList(),
      languages: (jsonSerialization['languages'] as List?)
          ?.map((e) => e as String)
          .toList(),
      visionType: jsonSerialization['visionType'] as String?,
      resistances: (jsonSerialization['resistances'] as List?)
          ?.map((e) => e as String)
          .toList(),
      skillProficiencies: (jsonSerialization['skillProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      armorProficiencies: (jsonSerialization['armorProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      weaponProficiencies: (jsonSerialization['weaponProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      toolProficiencies: (jsonSerialization['toolProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      spellcasting:
          (jsonSerialization['spellcasting'] as Map?)?.map((k, v) => MapEntry(
                k as String,
                _i2.SpellData.fromJson((v as Map<String, dynamic>)),
              )),
      imageURL: jsonSerialization['imageURL'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int? speed;

  String? size;

  Map<String, int>? abilityBonuses;

  List<String>? traits;

  List<String>? languages;

  String? visionType;

  List<String>? resistances;

  List<String>? skillProficiencies;

  List<String>? armorProficiencies;

  List<String>? weaponProficiencies;

  List<String>? toolProficiencies;

  Map<String, _i2.SpellData>? spellcasting;

  String? imageURL;

  /// Returns a shallow copy of this [RaceData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RaceData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? speed,
    String? size,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<String>? languages,
    String? visionType,
    List<String>? resistances,
    List<String>? skillProficiencies,
    List<String>? armorProficiencies,
    List<String>? weaponProficiencies,
    List<String>? toolProficiencies,
    Map<String, _i2.SpellData>? spellcasting,
    String? imageURL,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (speed != null) 'speed': speed,
      if (size != null) 'size': size,
      if (abilityBonuses != null) 'abilityBonuses': abilityBonuses?.toJson(),
      if (traits != null) 'traits': traits?.toJson(),
      if (languages != null) 'languages': languages?.toJson(),
      if (visionType != null) 'visionType': visionType,
      if (resistances != null) 'resistances': resistances?.toJson(),
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(),
      if (armorProficiencies != null)
        'armorProficiencies': armorProficiencies?.toJson(),
      if (weaponProficiencies != null)
        'weaponProficiencies': weaponProficiencies?.toJson(),
      if (toolProficiencies != null)
        'toolProficiencies': toolProficiencies?.toJson(),
      if (spellcasting != null)
        'spellcasting': spellcasting?.toJson(valueToJson: (v) => v.toJson()),
      if (imageURL != null) 'imageURL': imageURL,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RaceDataImpl extends RaceData {
  _RaceDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? speed,
    String? size,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<String>? languages,
    String? visionType,
    List<String>? resistances,
    List<String>? skillProficiencies,
    List<String>? armorProficiencies,
    List<String>? weaponProficiencies,
    List<String>? toolProficiencies,
    Map<String, _i2.SpellData>? spellcasting,
    String? imageURL,
  }) : super._(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          speed: speed,
          size: size,
          abilityBonuses: abilityBonuses,
          traits: traits,
          languages: languages,
          visionType: visionType,
          resistances: resistances,
          skillProficiencies: skillProficiencies,
          armorProficiencies: armorProficiencies,
          weaponProficiencies: weaponProficiencies,
          toolProficiencies: toolProficiencies,
          spellcasting: spellcasting,
          imageURL: imageURL,
        );

  /// Returns a shallow copy of this [RaceData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RaceData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? speed = _Undefined,
    Object? size = _Undefined,
    Object? abilityBonuses = _Undefined,
    Object? traits = _Undefined,
    Object? languages = _Undefined,
    Object? visionType = _Undefined,
    Object? resistances = _Undefined,
    Object? skillProficiencies = _Undefined,
    Object? armorProficiencies = _Undefined,
    Object? weaponProficiencies = _Undefined,
    Object? toolProficiencies = _Undefined,
    Object? spellcasting = _Undefined,
    Object? imageURL = _Undefined,
  }) {
    return RaceData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      speed: speed is int? ? speed : this.speed,
      size: size is String? ? size : this.size,
      abilityBonuses: abilityBonuses is Map<String, int>?
          ? abilityBonuses
          : this.abilityBonuses?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      traits: traits is List<String>?
          ? traits
          : this.traits?.map((e0) => e0).toList(),
      languages: languages is List<String>?
          ? languages
          : this.languages?.map((e0) => e0).toList(),
      visionType: visionType is String? ? visionType : this.visionType,
      resistances: resistances is List<String>?
          ? resistances
          : this.resistances?.map((e0) => e0).toList(),
      skillProficiencies: skillProficiencies is List<String>?
          ? skillProficiencies
          : this.skillProficiencies?.map((e0) => e0).toList(),
      armorProficiencies: armorProficiencies is List<String>?
          ? armorProficiencies
          : this.armorProficiencies?.map((e0) => e0).toList(),
      weaponProficiencies: weaponProficiencies is List<String>?
          ? weaponProficiencies
          : this.weaponProficiencies?.map((e0) => e0).toList(),
      toolProficiencies: toolProficiencies is List<String>?
          ? toolProficiencies
          : this.toolProficiencies?.map((e0) => e0).toList(),
      spellcasting: spellcasting is Map<String, _i2.SpellData>?
          ? spellcasting
          : this.spellcasting?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0.copyWith(),
                  )),
      imageURL: imageURL is String? ? imageURL : this.imageURL,
    );
  }
}
