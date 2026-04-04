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
import '../../../enums/ability.dart' as _i2;
import '../../../enums/damage_type.dart' as _i3;

abstract class CharacterAttackData implements _i1.SerializableModel {
  CharacterAttackData._({
    this.name,
    this.leadingAbility,
    this.damage,
    this.customAttackBonus,
    this.damageType,
    this.tags,
    this.description,
  });

  factory CharacterAttackData({
    String? name,
    _i2.Ability? leadingAbility,
    String? damage,
    int? customAttackBonus,
    _i3.DamageType? damageType,
    List<String>? tags,
    String? description,
  }) = _CharacterAttackDataImpl;

  factory CharacterAttackData.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterAttackData(
      name: jsonSerialization['name'] as String?,
      leadingAbility: jsonSerialization['leadingAbility'] == null
          ? null
          : _i2.Ability.fromJson(
              (jsonSerialization['leadingAbility'] as String)),
      damage: jsonSerialization['damage'] as String?,
      customAttackBonus: jsonSerialization['customAttackBonus'] as int?,
      damageType: jsonSerialization['damageType'] == null
          ? null
          : _i3.DamageType.fromJson(
              (jsonSerialization['damageType'] as String)),
      tags: (jsonSerialization['tags'] as List?)
          ?.map((e) => e as String)
          .toList(),
      description: jsonSerialization['description'] as String?,
    );
  }

  String? name;

  _i2.Ability? leadingAbility;

  String? damage;

  int? customAttackBonus;

  _i3.DamageType? damageType;

  List<String>? tags;

  String? description;

  /// Returns a shallow copy of this [CharacterAttackData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterAttackData copyWith({
    String? name,
    _i2.Ability? leadingAbility,
    String? damage,
    int? customAttackBonus,
    _i3.DamageType? damageType,
    List<String>? tags,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (leadingAbility != null) 'leadingAbility': leadingAbility?.toJson(),
      if (damage != null) 'damage': damage,
      if (customAttackBonus != null) 'customAttackBonus': customAttackBonus,
      if (damageType != null) 'damageType': damageType?.toJson(),
      if (tags != null) 'tags': tags?.toJson(),
      if (description != null) 'description': description,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterAttackDataImpl extends CharacterAttackData {
  _CharacterAttackDataImpl({
    String? name,
    _i2.Ability? leadingAbility,
    String? damage,
    int? customAttackBonus,
    _i3.DamageType? damageType,
    List<String>? tags,
    String? description,
  }) : super._(
          name: name,
          leadingAbility: leadingAbility,
          damage: damage,
          customAttackBonus: customAttackBonus,
          damageType: damageType,
          tags: tags,
          description: description,
        );

  /// Returns a shallow copy of this [CharacterAttackData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterAttackData copyWith({
    Object? name = _Undefined,
    Object? leadingAbility = _Undefined,
    Object? damage = _Undefined,
    Object? customAttackBonus = _Undefined,
    Object? damageType = _Undefined,
    Object? tags = _Undefined,
    Object? description = _Undefined,
  }) {
    return CharacterAttackData(
      name: name is String? ? name : this.name,
      leadingAbility:
          leadingAbility is _i2.Ability? ? leadingAbility : this.leadingAbility,
      damage: damage is String? ? damage : this.damage,
      customAttackBonus: customAttackBonus is int?
          ? customAttackBonus
          : this.customAttackBonus,
      damageType: damageType is _i3.DamageType? ? damageType : this.damageType,
      tags: tags is List<String>? ? tags : this.tags?.map((e0) => e0).toList(),
      description: description is String? ? description : this.description,
    );
  }
}
