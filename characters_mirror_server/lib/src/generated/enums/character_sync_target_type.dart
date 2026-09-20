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

enum CharacterSyncTargetType implements _i1.SerializableModel {
  character,
  field,
  mapEntry,
  listItem,
  resource,
  startingEquipmentResolution,
  member;

  static CharacterSyncTargetType fromJson(int index) {
    switch (index) {
      case 0:
        return CharacterSyncTargetType.character;
      case 1:
        return CharacterSyncTargetType.field;
      case 2:
        return CharacterSyncTargetType.mapEntry;
      case 3:
        return CharacterSyncTargetType.listItem;
      case 4:
        return CharacterSyncTargetType.resource;
      case 5:
        return CharacterSyncTargetType.startingEquipmentResolution;
      case 6:
        return CharacterSyncTargetType.member;
      default:
        throw ArgumentError(
            'Value "$index" cannot be converted to "CharacterSyncTargetType"');
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
