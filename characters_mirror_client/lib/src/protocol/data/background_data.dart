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
import '../enums/skill.dart' as _ic5go03x;

abstract class BackgroundData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BackgroundData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.skillProficiencies,
    this.availableSkills,
    this.skillCount,
    this.toolProficiencyKeys,
    this.languageCount,
    this.items,
    this.coins,
    this.feature,
    this.suggestedPersonality,
    this.suggestedIdeal,
    this.suggestedBond,
    this.suggestedFlaw,
  });

  factory BackgroundData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_ic5go03x.Skill>? skillProficiencies,
    List<_ic5go03x.Skill>? availableSkills,
    int? skillCount,
    List<String>? toolProficiencyKeys,
    int? languageCount,
    List<String>? items,
    double? coins,
    String? feature,
    List<String>? suggestedPersonality,
    List<String>? suggestedIdeal,
    List<String>? suggestedBond,
    List<String>? suggestedFlaw,
  }) = _BackgroundDataImpl;

  factory BackgroundData.fromJson(Map<String, dynamic> jsonSerialization) {
    return BackgroundData(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      skillProficiencies: jsonSerialization['skillProficiencies'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_ic5go03x.Skill>>(
              jsonSerialization['skillProficiencies'],
            ),
      availableSkills: jsonSerialization['availableSkills'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_ic5go03x.Skill>>(
              jsonSerialization['availableSkills'],
            ),
      skillCount: jsonSerialization['skillCount'] as int?,
      toolProficiencyKeys: jsonSerialization['toolProficiencyKeys'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['toolProficiencyKeys'],
            ),
      languageCount: jsonSerialization['languageCount'] as int?,
      items: jsonSerialization['items'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['items'],
            ),
      coins: (jsonSerialization['coins'] as num?)?.toDouble(),
      feature: jsonSerialization['feature'] as String?,
      suggestedPersonality: jsonSerialization['suggestedPersonality'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['suggestedPersonality'],
            ),
      suggestedIdeal: jsonSerialization['suggestedIdeal'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['suggestedIdeal'],
            ),
      suggestedBond: jsonSerialization['suggestedBond'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['suggestedBond'],
            ),
      suggestedFlaw: jsonSerialization['suggestedFlaw'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['suggestedFlaw'],
            ),
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

  List<_ic5go03x.Skill>? skillProficiencies;

  List<_ic5go03x.Skill>? availableSkills;

  int? skillCount;

  List<String>? toolProficiencyKeys;

  int? languageCount;

  List<String>? items;

  double? coins;

  String? feature;

  List<String>? suggestedPersonality;

  List<String>? suggestedIdeal;

  List<String>? suggestedBond;

  List<String>? suggestedFlaw;

  /// Returns a shallow copy of this [BackgroundData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BackgroundData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_ic5go03x.Skill>? skillProficiencies,
    List<_ic5go03x.Skill>? availableSkills,
    int? skillCount,
    List<String>? toolProficiencyKeys,
    int? languageCount,
    List<String>? items,
    double? coins,
    String? feature,
    List<String>? suggestedPersonality,
    List<String>? suggestedIdeal,
    List<String>? suggestedBond,
    List<String>? suggestedFlaw,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BackgroundData',
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (availableSkills != null)
        'availableSkills': availableSkills?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (skillCount != null) 'skillCount': skillCount,
      if (toolProficiencyKeys != null)
        'toolProficiencyKeys': toolProficiencyKeys?.toJson(),
      if (languageCount != null) 'languageCount': languageCount,
      if (items != null) 'items': items?.toJson(),
      if (coins != null) 'coins': coins,
      if (feature != null) 'feature': feature,
      if (suggestedPersonality != null)
        'suggestedPersonality': suggestedPersonality?.toJson(),
      if (suggestedIdeal != null) 'suggestedIdeal': suggestedIdeal?.toJson(),
      if (suggestedBond != null) 'suggestedBond': suggestedBond?.toJson(),
      if (suggestedFlaw != null) 'suggestedFlaw': suggestedFlaw?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BackgroundData',
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (availableSkills != null)
        'availableSkills': availableSkills?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (skillCount != null) 'skillCount': skillCount,
      if (toolProficiencyKeys != null)
        'toolProficiencyKeys': toolProficiencyKeys?.toJson(),
      if (languageCount != null) 'languageCount': languageCount,
      if (items != null) 'items': items?.toJson(),
      if (coins != null) 'coins': coins,
      if (feature != null) 'feature': feature,
      if (suggestedPersonality != null)
        'suggestedPersonality': suggestedPersonality?.toJson(),
      if (suggestedIdeal != null) 'suggestedIdeal': suggestedIdeal?.toJson(),
      if (suggestedBond != null) 'suggestedBond': suggestedBond?.toJson(),
      if (suggestedFlaw != null) 'suggestedFlaw': suggestedFlaw?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BackgroundDataImpl extends BackgroundData {
  _BackgroundDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_ic5go03x.Skill>? skillProficiencies,
    List<_ic5go03x.Skill>? availableSkills,
    int? skillCount,
    List<String>? toolProficiencyKeys,
    int? languageCount,
    List<String>? items,
    double? coins,
    String? feature,
    List<String>? suggestedPersonality,
    List<String>? suggestedIdeal,
    List<String>? suggestedBond,
    List<String>? suggestedFlaw,
  }) : super._(
         id: id,
         name: name,
         description: description,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
         skillProficiencies: skillProficiencies,
         availableSkills: availableSkills,
         skillCount: skillCount,
         toolProficiencyKeys: toolProficiencyKeys,
         languageCount: languageCount,
         items: items,
         coins: coins,
         feature: feature,
         suggestedPersonality: suggestedPersonality,
         suggestedIdeal: suggestedIdeal,
         suggestedBond: suggestedBond,
         suggestedFlaw: suggestedFlaw,
       );

  /// Returns a shallow copy of this [BackgroundData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BackgroundData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? skillProficiencies = _Undefined,
    Object? availableSkills = _Undefined,
    Object? skillCount = _Undefined,
    Object? toolProficiencyKeys = _Undefined,
    Object? languageCount = _Undefined,
    Object? items = _Undefined,
    Object? coins = _Undefined,
    Object? feature = _Undefined,
    Object? suggestedPersonality = _Undefined,
    Object? suggestedIdeal = _Undefined,
    Object? suggestedBond = _Undefined,
    Object? suggestedFlaw = _Undefined,
  }) {
    return BackgroundData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      skillProficiencies: skillProficiencies is List<_ic5go03x.Skill>?
          ? skillProficiencies
          : this.skillProficiencies?.map((e0) => e0).toList(),
      availableSkills: availableSkills is List<_ic5go03x.Skill>?
          ? availableSkills
          : this.availableSkills?.map((e0) => e0).toList(),
      skillCount: skillCount is int? ? skillCount : this.skillCount,
      toolProficiencyKeys: toolProficiencyKeys is List<String>?
          ? toolProficiencyKeys
          : this.toolProficiencyKeys?.map((e0) => e0).toList(),
      languageCount: languageCount is int? ? languageCount : this.languageCount,
      items: items is List<String>?
          ? items
          : this.items?.map((e0) => e0).toList(),
      coins: coins is double? ? coins : this.coins,
      feature: feature is String? ? feature : this.feature,
      suggestedPersonality: suggestedPersonality is List<String>?
          ? suggestedPersonality
          : this.suggestedPersonality?.map((e0) => e0).toList(),
      suggestedIdeal: suggestedIdeal is List<String>?
          ? suggestedIdeal
          : this.suggestedIdeal?.map((e0) => e0).toList(),
      suggestedBond: suggestedBond is List<String>?
          ? suggestedBond
          : this.suggestedBond?.map((e0) => e0).toList(),
      suggestedFlaw: suggestedFlaw is List<String>?
          ? suggestedFlaw
          : this.suggestedFlaw?.map((e0) => e0).toList(),
    );
  }
}
