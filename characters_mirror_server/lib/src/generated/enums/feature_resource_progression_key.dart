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

enum FeatureResourceProgressionKey implements _i1.SerializableModel {
  barbarianRages,
  clericChannelDivinityUses,
  fighterActionSurgeUses,
  fighterIndomitableUses,
  battleMasterSuperiorityDice,
  divinerPortentDice;

  static FeatureResourceProgressionKey fromJson(String name) {
    switch (name) {
      case 'barbarianRages':
        return FeatureResourceProgressionKey.barbarianRages;
      case 'clericChannelDivinityUses':
        return FeatureResourceProgressionKey.clericChannelDivinityUses;
      case 'fighterActionSurgeUses':
        return FeatureResourceProgressionKey.fighterActionSurgeUses;
      case 'fighterIndomitableUses':
        return FeatureResourceProgressionKey.fighterIndomitableUses;
      case 'battleMasterSuperiorityDice':
        return FeatureResourceProgressionKey.battleMasterSuperiorityDice;
      case 'divinerPortentDice':
        return FeatureResourceProgressionKey.divinerPortentDice;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "FeatureResourceProgressionKey"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
