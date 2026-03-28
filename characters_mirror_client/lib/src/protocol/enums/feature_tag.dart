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

  static FeatureTag fromJson(int index) {
    switch (index) {
      case 0:
        return FeatureTag.action;
      case 1:
        return FeatureTag.bonusAction;
      case 2:
        return FeatureTag.reaction;
      case 3:
        return FeatureTag.passive;
      case 4:
        return FeatureTag.resource;
      case 5:
        return FeatureTag.spellcasting;
      case 6:
        return FeatureTag.defense;
      case 7:
        return FeatureTag.mobility;
      case 8:
        return FeatureTag.utility;
      case 9:
        return FeatureTag.social;
      case 10:
        return FeatureTag.exploration;
      case 11:
        return FeatureTag.combat;
      default:
        throw ArgumentError(
            'Value "$index" cannot be converted to "FeatureTag"');
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
