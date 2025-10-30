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

abstract class BackgroundData implements _i1.SerializableModel {
  BackgroundData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.skillProficiencies,
    this.toolProficiencies,
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
    List<String>? skillProficiencies,
    List<String>? toolProficiencies,
    String? feature,
    String? suggestedPersonality,
    String? suggestedIdeal,
    String? suggestedBond,
    String? suggestedFlaw,
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
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      skillProficiencies: (jsonSerialization['skillProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      toolProficiencies: (jsonSerialization['toolProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      feature: jsonSerialization['feature'] as String?,
      suggestedPersonality:
          jsonSerialization['suggestedPersonality'] as String?,
      suggestedIdeal: jsonSerialization['suggestedIdeal'] as String?,
      suggestedBond: jsonSerialization['suggestedBond'] as String?,
      suggestedFlaw: jsonSerialization['suggestedFlaw'] as String?,
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

  List<String>? skillProficiencies;

  List<String>? toolProficiencies;

  String? feature;

  String? suggestedPersonality;

  String? suggestedIdeal;

  String? suggestedBond;

  String? suggestedFlaw;

  /// Returns a shallow copy of this [BackgroundData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BackgroundData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? skillProficiencies,
    List<String>? toolProficiencies,
    String? feature,
    String? suggestedPersonality,
    String? suggestedIdeal,
    String? suggestedBond,
    String? suggestedFlaw,
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
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(),
      if (toolProficiencies != null)
        'toolProficiencies': toolProficiencies?.toJson(),
      if (feature != null) 'feature': feature,
      if (suggestedPersonality != null)
        'suggestedPersonality': suggestedPersonality,
      if (suggestedIdeal != null) 'suggestedIdeal': suggestedIdeal,
      if (suggestedBond != null) 'suggestedBond': suggestedBond,
      if (suggestedFlaw != null) 'suggestedFlaw': suggestedFlaw,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
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
    List<String>? skillProficiencies,
    List<String>? toolProficiencies,
    String? feature,
    String? suggestedPersonality,
    String? suggestedIdeal,
    String? suggestedBond,
    String? suggestedFlaw,
  }) : super._(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          skillProficiencies: skillProficiencies,
          toolProficiencies: toolProficiencies,
          feature: feature,
          suggestedPersonality: suggestedPersonality,
          suggestedIdeal: suggestedIdeal,
          suggestedBond: suggestedBond,
          suggestedFlaw: suggestedFlaw,
        );

  /// Returns a shallow copy of this [BackgroundData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
    Object? toolProficiencies = _Undefined,
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
      skillProficiencies: skillProficiencies is List<String>?
          ? skillProficiencies
          : this.skillProficiencies?.map((e0) => e0).toList(),
      toolProficiencies: toolProficiencies is List<String>?
          ? toolProficiencies
          : this.toolProficiencies?.map((e0) => e0).toList(),
      feature: feature is String? ? feature : this.feature,
      suggestedPersonality: suggestedPersonality is String?
          ? suggestedPersonality
          : this.suggestedPersonality,
      suggestedIdeal:
          suggestedIdeal is String? ? suggestedIdeal : this.suggestedIdeal,
      suggestedBond:
          suggestedBond is String? ? suggestedBond : this.suggestedBond,
      suggestedFlaw:
          suggestedFlaw is String? ? suggestedFlaw : this.suggestedFlaw,
    );
  }
}
