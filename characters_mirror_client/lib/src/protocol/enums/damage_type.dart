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

enum DamageType implements _i1.SerializableModel {
  acid,
  bludgeoning,
  cold,
  fire,
  force,
  lightning,
  necrotic,
  piercing,
  poison,
  psychic,
  radiant,
  slashing,
  thunder;

  static DamageType fromJson(String name) {
    switch (name) {
      case 'acid':
        return DamageType.acid;
      case 'bludgeoning':
        return DamageType.bludgeoning;
      case 'cold':
        return DamageType.cold;
      case 'fire':
        return DamageType.fire;
      case 'force':
        return DamageType.force;
      case 'lightning':
        return DamageType.lightning;
      case 'necrotic':
        return DamageType.necrotic;
      case 'piercing':
        return DamageType.piercing;
      case 'poison':
        return DamageType.poison;
      case 'psychic':
        return DamageType.psychic;
      case 'radiant':
        return DamageType.radiant;
      case 'slashing':
        return DamageType.slashing;
      case 'thunder':
        return DamageType.thunder;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "DamageType"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
