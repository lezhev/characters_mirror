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
import '../../../data/damage_part_data.dart' as _iig598dl;
import '../../../enums/ability.dart' as _iw3bk51e;
import '../../../enums/damage_type.dart' as _ij9bzpyl;
import '../../../enums/weapon_category.dart' as _ibtz7e0l;

abstract class CharacterAttackData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CharacterAttackData._({
    this.id,
    this.name,
    this.leadingAbility,
    this.weaponCategory,
    this.damage,
    this.customAttackBonus,
    this.damageType,
    this.damageParts,
    this.tags,
    this.description,
    this.updatedAt,
  });

  factory CharacterAttackData({
    String? id,
    String? name,
    _iw3bk51e.Ability? leadingAbility,
    _ibtz7e0l.WeaponCategory? weaponCategory,
    String? damage,
    int? customAttackBonus,
    _ij9bzpyl.DamageType? damageType,
    List<_iig598dl.DamagePartData>? damageParts,
    List<String>? tags,
    String? description,
    DateTime? updatedAt,
  }) = _CharacterAttackDataImpl;

  factory CharacterAttackData.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterAttackData(
      id: jsonSerialization['id'] as String?,
      name: jsonSerialization['name'] as String?,
      leadingAbility: jsonSerialization['leadingAbility'] == null
          ? null
          : _iw3bk51e.Ability.fromJson(
              (jsonSerialization['leadingAbility'] as String),
            ),
      weaponCategory: jsonSerialization['weaponCategory'] == null
          ? null
          : _ibtz7e0l.WeaponCategory.fromJson(
              (jsonSerialization['weaponCategory'] as String),
            ),
      damage: jsonSerialization['damage'] as String?,
      customAttackBonus: jsonSerialization['customAttackBonus'] as int?,
      damageType: jsonSerialization['damageType'] == null
          ? null
          : _ij9bzpyl.DamageType.fromJson(
              (jsonSerialization['damageType'] as String),
            ),
      damageParts: jsonSerialization['damageParts'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_iig598dl.DamagePartData>>(
              jsonSerialization['damageParts'],
            ),
      tags: jsonSerialization['tags'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['tags'],
            ),
      description: jsonSerialization['description'] as String?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  String? id;

  String? name;

  _iw3bk51e.Ability? leadingAbility;

  _ibtz7e0l.WeaponCategory? weaponCategory;

  String? damage;

  int? customAttackBonus;

  _ij9bzpyl.DamageType? damageType;

  List<_iig598dl.DamagePartData>? damageParts;

  List<String>? tags;

  String? description;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [CharacterAttackData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CharacterAttackData copyWith({
    String? id,
    String? name,
    _iw3bk51e.Ability? leadingAbility,
    _ibtz7e0l.WeaponCategory? weaponCategory,
    String? damage,
    int? customAttackBonus,
    _ij9bzpyl.DamageType? damageType,
    List<_iig598dl.DamagePartData>? damageParts,
    List<String>? tags,
    String? description,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterAttackData',
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (leadingAbility != null) 'leadingAbility': leadingAbility?.toJson(),
      if (weaponCategory != null) 'weaponCategory': weaponCategory?.toJson(),
      if (damage != null) 'damage': damage,
      if (customAttackBonus != null) 'customAttackBonus': customAttackBonus,
      if (damageType != null) 'damageType': damageType?.toJson(),
      if (damageParts != null)
        'damageParts': damageParts?.toJson(valueToJson: (v) => v.toJson()),
      if (tags != null) 'tags': tags?.toJson(),
      if (description != null) 'description': description,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CharacterAttackData',
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (leadingAbility != null) 'leadingAbility': leadingAbility?.toJson(),
      if (weaponCategory != null) 'weaponCategory': weaponCategory?.toJson(),
      if (damage != null) 'damage': damage,
      if (customAttackBonus != null) 'customAttackBonus': customAttackBonus,
      if (damageType != null) 'damageType': damageType?.toJson(),
      if (damageParts != null)
        'damageParts': damageParts?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (tags != null) 'tags': tags?.toJson(),
      if (description != null) 'description': description,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterAttackDataImpl extends CharacterAttackData {
  _CharacterAttackDataImpl({
    String? id,
    String? name,
    _iw3bk51e.Ability? leadingAbility,
    _ibtz7e0l.WeaponCategory? weaponCategory,
    String? damage,
    int? customAttackBonus,
    _ij9bzpyl.DamageType? damageType,
    List<_iig598dl.DamagePartData>? damageParts,
    List<String>? tags,
    String? description,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         leadingAbility: leadingAbility,
         weaponCategory: weaponCategory,
         damage: damage,
         customAttackBonus: customAttackBonus,
         damageType: damageType,
         damageParts: damageParts,
         tags: tags,
         description: description,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CharacterAttackData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CharacterAttackData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? leadingAbility = _Undefined,
    Object? weaponCategory = _Undefined,
    Object? damage = _Undefined,
    Object? customAttackBonus = _Undefined,
    Object? damageType = _Undefined,
    Object? damageParts = _Undefined,
    Object? tags = _Undefined,
    Object? description = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return CharacterAttackData(
      id: id is String? ? id : this.id,
      name: name is String? ? name : this.name,
      leadingAbility: leadingAbility is _iw3bk51e.Ability?
          ? leadingAbility
          : this.leadingAbility,
      weaponCategory: weaponCategory is _ibtz7e0l.WeaponCategory?
          ? weaponCategory
          : this.weaponCategory,
      damage: damage is String? ? damage : this.damage,
      customAttackBonus: customAttackBonus is int?
          ? customAttackBonus
          : this.customAttackBonus,
      damageType: damageType is _ij9bzpyl.DamageType?
          ? damageType
          : this.damageType,
      damageParts: damageParts is List<_iig598dl.DamagePartData>?
          ? damageParts
          : this.damageParts?.map((e0) => e0.copyWith()).toList(),
      tags: tags is List<String>? ? tags : this.tags?.map((e0) => e0).toList(),
      description: description is String? ? description : this.description,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
