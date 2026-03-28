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

enum SpellTargetType implements _i1.SerializableModel {
  self,
  singleCreature,
  multipleCreatures,
  object,
  point,
  area,
  touch,
  special;

  static SpellTargetType fromJson(int index) {
    switch (index) {
      case 0:
        return SpellTargetType.self;
      case 1:
        return SpellTargetType.singleCreature;
      case 2:
        return SpellTargetType.multipleCreatures;
      case 3:
        return SpellTargetType.object;
      case 4:
        return SpellTargetType.point;
      case 5:
        return SpellTargetType.area;
      case 6:
        return SpellTargetType.touch;
      case 7:
        return SpellTargetType.special;
      default:
        throw ArgumentError(
            'Value "$index" cannot be converted to "SpellTargetType"');
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
