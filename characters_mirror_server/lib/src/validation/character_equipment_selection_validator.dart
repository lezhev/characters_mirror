import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

import 'rules.dart';
import 'validation_exception.dart';

abstract final class CharacterEquipmentSelectionValidator {
  static Future<CharacterData> normalizeAndValidate(
    Session session,
    CharacterData character, {
    Transaction? transaction,
  }) async {
    final equippedArmor = await _normalizeSelection(
      session,
      'equippedArmor',
      character.equippedArmor,
      expectShield: false,
      transaction: transaction,
    );
    final equippedShield = await _normalizeSelection(
      session,
      'equippedShield',
      character.equippedShield,
      expectShield: true,
      transaction: transaction,
    );
    return character.copyWith(
      equippedArmor: equippedArmor,
      equippedShield: equippedShield,
    );
  }

  static Future<CharacterEquipmentSelectionData?> _normalizeSelection(
    Session session,
    String field,
    CharacterEquipmentSelectionData? selection, {
    required bool expectShield,
    Transaction? transaction,
  }) async {
    if (selection == null) return null;
    if (selection.referenceKey == null) {
      final name = selection.name.trim();
      if (name.isEmpty) {
        throw InputValidationException(field, 'name cannot be empty.');
      }
      Rules.shortText(field, name);
      return CharacterEquipmentSelectionData(name: name);
    }
    final key = selection.referenceKey!.trim();
    if (key.isEmpty) {
      throw InputValidationException(
        '$field.referenceKey',
        'must identify an existing armor reference.',
      );
    }

    final matches = await ArmorData.db.find(
      session,
      where: (t) => t.referenceKey.equals(key),
      limit: 2,
      transaction: transaction,
    );
    if (matches.length != 1) {
      throw InputValidationException(
        '$field.referenceKey',
        'must identify an existing armor reference.',
      );
    }
    final armor = matches.single;
    final category = armor.categoryValue;
    final matchesExpectedSlot = expectShield
        ? category == ArmorCategory.shield
        : category == ArmorCategory.light ||
            category == ArmorCategory.medium ||
            category == ArmorCategory.heavy;
    if (!matchesExpectedSlot) {
      throw InputValidationException(
        field,
        expectShield
            ? 'must reference shield armor.'
            : 'cannot reference shield armor.',
      );
    }
    final canonicalName = armor.name?.trim() ?? '';
    if (canonicalName.isEmpty) {
      throw InputValidationException(
        '$field.referenceKey',
        'references armor without a canonical name.',
      );
    }
    return CharacterEquipmentSelectionData(
      referenceKey: armor.referenceKey,
      name: canonicalName,
    );
  }
}
