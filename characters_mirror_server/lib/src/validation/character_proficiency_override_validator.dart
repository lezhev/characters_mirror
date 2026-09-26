import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

import 'rules.dart';
import 'validation_exception.dart';

abstract final class CharacterProficiencyOverrideValidator {
  static CharacterData normalize(CharacterData character) {
    return character.copyWith(
      manualLanguageOverrides: _normalizeLanguageOverrides(
        character.manualLanguageOverrides,
      ),
      manualToolProficiencyOverrides: _normalizeToolOverrides(
        character.manualToolProficiencyOverrides,
      ),
      manualWeaponProficiencyOverrides: _normalizeWeaponOverrides(
        character.manualWeaponProficiencyOverrides,
      ),
      manualArmorTrainingOverrides: _normalizeArmorOverrides(
        character.manualArmorTrainingOverrides,
      ),
    );
  }

  static void validate(CharacterData character) {
    final rawLanguages = character.manualLanguageOverrides;
    _validateEnumValues('manualLanguageOverrides.added', rawLanguages?.added);
    _validateEnumValues(
      'manualLanguageOverrides.removed',
      rawLanguages?.removed,
    );
    Rules.proficiencyOverrideCollection(
      'manualLanguageOverrides.custom',
      rawLanguages?.custom,
    );

    final rawTools = character.manualToolProficiencyOverrides;
    _validateKeys(
        'manualToolProficiencyOverrides.addedKeys', rawTools?.addedKeys);
    _validateKeys(
      'manualToolProficiencyOverrides.removedKeys',
      rawTools?.removedKeys,
    );
    Rules.proficiencyOverrideCollection(
      'manualToolProficiencyOverrides.custom',
      rawTools?.custom,
    );

    final rawWeapons = character.manualWeaponProficiencyOverrides;
    _validateEnumValues(
      'manualWeaponProficiencyOverrides.addedCategories',
      rawWeapons?.addedCategories,
    );
    _validateEnumValues(
      'manualWeaponProficiencyOverrides.removedCategories',
      rawWeapons?.removedCategories,
    );
    _validateKeys(
      'manualWeaponProficiencyOverrides.addedKeys',
      rawWeapons?.addedKeys,
    );
    _validateKeys(
      'manualWeaponProficiencyOverrides.removedKeys',
      rawWeapons?.removedKeys,
    );
    Rules.proficiencyOverrideCollection(
      'manualWeaponProficiencyOverrides.custom',
      rawWeapons?.custom,
    );

    final rawArmor = character.manualArmorTrainingOverrides;
    _validateEnumValues(
      'manualArmorTrainingOverrides.addedCategories',
      rawArmor?.addedCategories,
    );
    _validateEnumValues(
      'manualArmorTrainingOverrides.removedCategories',
      rawArmor?.removedCategories,
    );
    Rules.proficiencyOverrideCollection(
      'manualArmorTrainingOverrides.custom',
      rawArmor?.custom,
    );

    final normalized = normalize(character);
    final languages = normalized.manualLanguageOverrides;
    _validateEnumValues('manualLanguageOverrides.added', languages?.added);
    _validateEnumValues('manualLanguageOverrides.removed', languages?.removed);
    _validateCustomValues('manualLanguageOverrides.custom', languages?.custom);

    final tools = normalized.manualToolProficiencyOverrides;
    _validateKeys('manualToolProficiencyOverrides.addedKeys', tools?.addedKeys);
    _validateKeys(
      'manualToolProficiencyOverrides.removedKeys',
      tools?.removedKeys,
    );
    _validateCustomValues(
        'manualToolProficiencyOverrides.custom', tools?.custom);

    final weapons = normalized.manualWeaponProficiencyOverrides;
    _validateEnumValues(
      'manualWeaponProficiencyOverrides.addedCategories',
      weapons?.addedCategories,
    );
    _validateEnumValues(
      'manualWeaponProficiencyOverrides.removedCategories',
      weapons?.removedCategories,
    );
    _validateKeys(
      'manualWeaponProficiencyOverrides.addedKeys',
      weapons?.addedKeys,
    );
    _validateKeys(
      'manualWeaponProficiencyOverrides.removedKeys',
      weapons?.removedKeys,
    );
    _validateCustomValues(
      'manualWeaponProficiencyOverrides.custom',
      weapons?.custom,
    );

    final armor = normalized.manualArmorTrainingOverrides;
    _validateEnumValues(
      'manualArmorTrainingOverrides.addedCategories',
      armor?.addedCategories,
    );
    _validateEnumValues(
      'manualArmorTrainingOverrides.removedCategories',
      armor?.removedCategories,
    );
    _validateCustomValues('manualArmorTrainingOverrides.custom', armor?.custom);
  }

  static Future<void> validateReferenceKeys(
    Session session,
    CharacterData character, {
    Transaction? transaction,
  }) async {
    final toolKeys = <String>{
      ...?character.manualToolProficiencyOverrides?.addedKeys,
      ...?character.manualToolProficiencyOverrides?.removedKeys,
    };
    if (toolKeys.isNotEmpty) {
      final rows = await ToolData.db.find(
        session,
        where: (t) => t.referenceKey.inSet(toolKeys),
        transaction: transaction,
      );
      final knownKeys = {for (final row in rows) row.referenceKey};
      final unknown = toolKeys.difference(knownKeys).firstOrNull;
      if (unknown != null) {
        throw InputValidationException(
          'manualToolProficiencyOverrides',
          'contains unknown ToolData.referenceKey "$unknown".',
        );
      }
    }

    final weaponKeys = <String>{
      ...?character.manualWeaponProficiencyOverrides?.addedKeys,
      ...?character.manualWeaponProficiencyOverrides?.removedKeys,
    };
    if (weaponKeys.isNotEmpty) {
      final rows = await WeaponData.db.find(
        session,
        where: (t) => t.referenceKey.inSet(weaponKeys),
        transaction: transaction,
      );
      final knownKeys = {for (final row in rows) row.referenceKey};
      final unknown = weaponKeys.difference(knownKeys).firstOrNull;
      if (unknown != null) {
        throw InputValidationException(
          'manualWeaponProficiencyOverrides',
          'contains unknown WeaponData.referenceKey "$unknown".',
        );
      }
    }
  }

  static CharacterLanguageOverridesData? _normalizeLanguageOverrides(
    CharacterLanguageOverridesData? value,
  ) {
    if (value == null) return null;
    return value.copyWith(
      added: _uniqueEnums(value.added),
      removed: _uniqueEnums(value.removed),
      custom: _normalizeCustom(value.custom),
    );
  }

  static CharacterToolProficiencyOverridesData? _normalizeToolOverrides(
    CharacterToolProficiencyOverridesData? value,
  ) {
    if (value == null) return null;
    return value.copyWith(
      addedKeys: _uniqueStrings(value.addedKeys),
      removedKeys: _uniqueStrings(value.removedKeys),
      custom: _normalizeCustom(value.custom),
    );
  }

  static CharacterWeaponProficiencyOverridesData? _normalizeWeaponOverrides(
    CharacterWeaponProficiencyOverridesData? value,
  ) {
    if (value == null) return null;
    return value.copyWith(
      addedCategories: _uniqueEnums(value.addedCategories),
      removedCategories: _uniqueEnums(value.removedCategories),
      addedKeys: _uniqueStrings(value.addedKeys),
      removedKeys: _uniqueStrings(value.removedKeys),
      custom: _normalizeCustom(value.custom),
    );
  }

  static CharacterArmorTrainingOverridesData? _normalizeArmorOverrides(
    CharacterArmorTrainingOverridesData? value,
  ) {
    if (value == null) return null;
    return value.copyWith(
      addedCategories: _uniqueEnums(value.addedCategories),
      removedCategories: _uniqueEnums(value.removedCategories),
      custom: _normalizeCustom(value.custom),
    );
  }

  static List<T>? _uniqueEnums<T extends Enum>(List<T>? values) {
    if (values == null) return null;
    final unique = values.toSet().toList();
    unique.sort((left, right) => left.name.compareTo(right.name));
    return unique;
  }

  static List<String>? _uniqueStrings(List<String>? values) {
    if (values == null) return null;
    final unique = values.toSet().toList()..sort();
    return unique;
  }

  static List<String>? _normalizeCustom(List<String>? values) {
    if (values == null) return null;
    final seen = <String>{};
    final normalized = <String>[];
    for (final rawValue in values) {
      final value = rawValue.trim();
      if (seen.add(value.toLowerCase())) normalized.add(value);
    }
    return normalized;
  }

  static void _validateEnumValues<T extends Enum>(
    String field,
    List<T>? values,
  ) {
    Rules.proficiencyOverrideCollection(field, values);
  }

  static void _validateKeys(String field, List<String>? values) {
    Rules.proficiencyOverrideCollection(field, values);
    if (values == null) return;
    for (var index = 0; index < values.length; index++) {
      final value = values[index];
      Rules.shortText('$field[$index]', value);
      if (value.trim().isEmpty) {
        throw InputValidationException('$field[$index]', 'must not be empty.');
      }
    }
  }

  static void _validateCustomValues(String field, List<String>? values) {
    Rules.proficiencyOverrideCollection(field, values);
    if (values == null) return;
    for (var index = 0; index < values.length; index++) {
      final value = values[index];
      Rules.shortText('$field[$index]', value);
      if (value.isEmpty) {
        throw InputValidationException('$field[$index]', 'must not be empty.');
      }
    }
  }
}
