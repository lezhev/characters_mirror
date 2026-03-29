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

enum FeatureTag implements _i1.SerializableModel {
  action,
  bonusAction,
  reaction,
  passive,
  resource,
  spellcasting,
  defense,
  mobility,
  utility,
  social,
  exploration,
  combat;

  static FeatureTag fromJson(String name) {
    switch (name) {
      case 'action':
        return FeatureTag.action;
      case 'bonusAction':
        return FeatureTag.bonusAction;
      case 'reaction':
        return FeatureTag.reaction;
      case 'passive':
        return FeatureTag.passive;
      case 'resource':
        return FeatureTag.resource;
      case 'spellcasting':
        return FeatureTag.spellcasting;
      case 'defense':
        return FeatureTag.defense;
      case 'mobility':
        return FeatureTag.mobility;
      case 'utility':
        return FeatureTag.utility;
      case 'social':
        return FeatureTag.social;
      case 'exploration':
        return FeatureTag.exploration;
      case 'combat':
        return FeatureTag.combat;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "FeatureTag"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
