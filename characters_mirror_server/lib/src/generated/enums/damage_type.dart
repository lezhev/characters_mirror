/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

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

  static DamageType fromJson(int index) {
    switch (index) {
      case 0:
        return DamageType.acid;
      case 1:
        return DamageType.bludgeoning;
      case 2:
        return DamageType.cold;
      case 3:
        return DamageType.fire;
      case 4:
        return DamageType.force;
      case 5:
        return DamageType.lightning;
      case 6:
        return DamageType.necrotic;
      case 7:
        return DamageType.piercing;
      case 8:
        return DamageType.poison;
      case 9:
        return DamageType.psychic;
      case 10:
        return DamageType.radiant;
      case 11:
        return DamageType.slashing;
      case 12:
        return DamageType.thunder;
      default:
        throw ArgumentError(
            'Value "$index" cannot be converted to "DamageType"');
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
