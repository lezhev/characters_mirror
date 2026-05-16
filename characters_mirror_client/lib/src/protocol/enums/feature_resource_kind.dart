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

enum FeatureResourceKind implements _i1.SerializableModel {
  uses,
  points,
  dice,
  slots,
  special;

  static FeatureResourceKind fromJson(String name) {
    switch (name) {
      case 'uses':
        return FeatureResourceKind.uses;
      case 'points':
        return FeatureResourceKind.points;
      case 'dice':
        return FeatureResourceKind.dice;
      case 'slots':
        return FeatureResourceKind.slots;
      case 'special':
        return FeatureResourceKind.special;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "FeatureResourceKind"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
