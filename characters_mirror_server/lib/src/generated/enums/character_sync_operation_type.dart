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

enum CharacterSyncOperationType implements _i1.SerializableModel {
  createCharacter,
  deleteCharacter,
  setField,
  setMapEntry,
  removeMapEntry,
  upsertListItem,
  removeListItem,
  addSetMember,
  removeSetMember,
  setMemberValue,
  applyDamage,
  heal,
  grantTemporaryHp,
  adjustSpellSlots,
  castSpell,
  adjustHitDice,
  adjustResource,
  adjustExperience,
  applyRest,
  recoverSpellSlots;

  static CharacterSyncOperationType fromJson(int index) {
    switch (index) {
      case 0:
        return CharacterSyncOperationType.createCharacter;
      case 1:
        return CharacterSyncOperationType.deleteCharacter;
      case 2:
        return CharacterSyncOperationType.setField;
      case 3:
        return CharacterSyncOperationType.setMapEntry;
      case 4:
        return CharacterSyncOperationType.removeMapEntry;
      case 5:
        return CharacterSyncOperationType.upsertListItem;
      case 6:
        return CharacterSyncOperationType.removeListItem;
      case 7:
        return CharacterSyncOperationType.addSetMember;
      case 8:
        return CharacterSyncOperationType.removeSetMember;
      case 9:
        return CharacterSyncOperationType.setMemberValue;
      case 10:
        return CharacterSyncOperationType.applyDamage;
      case 11:
        return CharacterSyncOperationType.heal;
      case 12:
        return CharacterSyncOperationType.grantTemporaryHp;
      case 13:
        return CharacterSyncOperationType.adjustSpellSlots;
      case 14:
        return CharacterSyncOperationType.castSpell;
      case 15:
        return CharacterSyncOperationType.adjustHitDice;
      case 16:
        return CharacterSyncOperationType.adjustResource;
      case 17:
        return CharacterSyncOperationType.adjustExperience;
      case 18:
        return CharacterSyncOperationType.applyRest;
      case 19:
        return CharacterSyncOperationType.recoverSpellSlots;
      default:
        throw ArgumentError(
            'Value "$index" cannot be converted to "CharacterSyncOperationType"');
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
