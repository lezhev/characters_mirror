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

abstract class MagicItemData implements _i1.SerializableModel {
  MagicItemData._({
    this.id,
    this.referenceKey,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.rarity,
    this.type,
    this.requiresAttunement,
    this.attunementCondition,
    this.bonus,
    this.charges,
    this.rechargeCondition,
    this.effects,
  });

  factory MagicItemData({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? rarity,
    String? type,
    bool? requiresAttunement,
    String? attunementCondition,
    Map<String, int>? bonus,
    int? charges,
    String? rechargeCondition,
    List<String>? effects,
  }) = _MagicItemDataImpl;

  factory MagicItemData.fromJson(Map<String, dynamic> jsonSerialization) {
    return MagicItemData(
      id: jsonSerialization['id'] as int?,
      referenceKey: jsonSerialization['referenceKey'] as String?,
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
      rarity: jsonSerialization['rarity'] as String?,
      type: jsonSerialization['type'] as String?,
      requiresAttunement: jsonSerialization['requiresAttunement'] as bool?,
      attunementCondition: jsonSerialization['attunementCondition'] as String?,
      bonus: (jsonSerialization['bonus'] as Map?)?.map((k, v) => MapEntry(
            k as String,
            v as int,
          )),
      charges: jsonSerialization['charges'] as int?,
      rechargeCondition: jsonSerialization['rechargeCondition'] as String?,
      effects: (jsonSerialization['effects'] as List?)
          ?.map((e) => e as String)
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

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  String? rarity;

  String? type;

  bool? requiresAttunement;

  String? attunementCondition;

  Map<String, int>? bonus;

  int? charges;

  String? rechargeCondition;

  List<String>? effects;

  /// Returns a shallow copy of this [MagicItemData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MagicItemData copyWith({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? rarity,
    String? type,
    bool? requiresAttunement,
    String? attunementCondition,
    Map<String, int>? bonus,
    int? charges,
    String? rechargeCondition,
    List<String>? effects,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (rarity != null) 'rarity': rarity,
      if (type != null) 'type': type,
      if (requiresAttunement != null) 'requiresAttunement': requiresAttunement,
      if (attunementCondition != null)
        'attunementCondition': attunementCondition,
      if (bonus != null) 'bonus': bonus?.toJson(),
      if (charges != null) 'charges': charges,
      if (rechargeCondition != null) 'rechargeCondition': rechargeCondition,
      if (effects != null) 'effects': effects?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MagicItemDataImpl extends MagicItemData {
  _MagicItemDataImpl({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? rarity,
    String? type,
    bool? requiresAttunement,
    String? attunementCondition,
    Map<String, int>? bonus,
    int? charges,
    String? rechargeCondition,
    List<String>? effects,
  }) : super._(
          id: id,
          referenceKey: referenceKey,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          rarity: rarity,
          type: type,
          requiresAttunement: requiresAttunement,
          attunementCondition: attunementCondition,
          bonus: bonus,
          charges: charges,
          rechargeCondition: rechargeCondition,
          effects: effects,
        );

  /// Returns a shallow copy of this [MagicItemData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MagicItemData copyWith({
    Object? id = _Undefined,
    Object? referenceKey = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? rarity = _Undefined,
    Object? type = _Undefined,
    Object? requiresAttunement = _Undefined,
    Object? attunementCondition = _Undefined,
    Object? bonus = _Undefined,
    Object? charges = _Undefined,
    Object? rechargeCondition = _Undefined,
    Object? effects = _Undefined,
  }) {
    return MagicItemData(
      id: id is int? ? id : this.id,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      rarity: rarity is String? ? rarity : this.rarity,
      type: type is String? ? type : this.type,
      requiresAttunement: requiresAttunement is bool?
          ? requiresAttunement
          : this.requiresAttunement,
      attunementCondition: attunementCondition is String?
          ? attunementCondition
          : this.attunementCondition,
      bonus: bonus is Map<String, int>?
          ? bonus
          : this.bonus?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      charges: charges is int? ? charges : this.charges,
      rechargeCondition: rechargeCondition is String?
          ? rechargeCondition
          : this.rechargeCondition,
      effects: effects is List<String>?
          ? effects
          : this.effects?.map((e0) => e0).toList(),
    );
  }
}
