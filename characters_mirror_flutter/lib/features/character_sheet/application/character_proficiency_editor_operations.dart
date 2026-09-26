import 'package:characters_mirror_client/characters_mirror_client.dart';

/// Applies manual proficiency edits without changing the automatic grants.
class CharacterProficiencyEditorOperations {
  const CharacterProficiencyEditorOperations._();

  static CharacterData addLanguage(CharacterData character, Language value) {
    final current =
        character.manualLanguageOverrides ?? CharacterLanguageOverridesData();
    return character.copyWith(
      manualLanguageOverrides: CharacterLanguageOverridesData(
        added: _contains(current.removed, value)
            ? current.added ?? []
            : _addEnum(current.added, value),
        removed: _removeEnum(current.removed, value),
        custom: current.custom,
      ),
    );
  }

  static CharacterData removeLanguage(CharacterData character, Language value) {
    final current =
        character.manualLanguageOverrides ?? CharacterLanguageOverridesData();
    return character.copyWith(
      manualLanguageOverrides: CharacterLanguageOverridesData(
        added: _removeEnum(current.added, value),
        removed: _contains(current.added, value)
            ? _removeEnum(current.removed, value)
            : _addEnum(current.removed, value),
        custom: current.custom,
      ),
    );
  }

  static CharacterData addCustomLanguage(
      CharacterData character, String label) {
    final current =
        character.manualLanguageOverrides ?? CharacterLanguageOverridesData();
    return character.copyWith(
      manualLanguageOverrides: CharacterLanguageOverridesData(
        added: current.added,
        removed: current.removed,
        custom: _addCustom(current.custom, label),
      ),
    );
  }

  static CharacterData removeCustomLanguage(
      CharacterData character, String label) {
    final current =
        character.manualLanguageOverrides ?? CharacterLanguageOverridesData();
    return character.copyWith(
      manualLanguageOverrides: CharacterLanguageOverridesData(
        added: current.added,
        removed: current.removed,
        custom: _removeString(current.custom, label),
      ),
    );
  }

  static CharacterData resetLanguages(CharacterData character) =>
      character.copyWith(manualLanguageOverrides: null);

  static CharacterData addToolKey(CharacterData character, String key) {
    final current = character.manualToolProficiencyOverrides ??
        CharacterToolProficiencyOverridesData();
    return character.copyWith(
      manualToolProficiencyOverrides: CharacterToolProficiencyOverridesData(
        addedKeys: _containsString(current.removedKeys, key)
            ? current.addedKeys ?? []
            : _addString(current.addedKeys, key),
        removedKeys: _removeString(current.removedKeys, key),
        custom: current.custom,
      ),
    );
  }

  static CharacterData removeToolKey(CharacterData character, String key) {
    final current = character.manualToolProficiencyOverrides ??
        CharacterToolProficiencyOverridesData();
    return character.copyWith(
      manualToolProficiencyOverrides: CharacterToolProficiencyOverridesData(
        addedKeys: _removeString(current.addedKeys, key),
        removedKeys: _containsString(current.addedKeys, key)
            ? _removeString(current.removedKeys, key)
            : _addString(current.removedKeys, key),
        custom: current.custom,
      ),
    );
  }

  static CharacterData addCustomTool(CharacterData character, String label) {
    final current = character.manualToolProficiencyOverrides ??
        CharacterToolProficiencyOverridesData();
    return character.copyWith(
      manualToolProficiencyOverrides: CharacterToolProficiencyOverridesData(
        addedKeys: current.addedKeys,
        removedKeys: current.removedKeys,
        custom: _addCustom(current.custom, label),
      ),
    );
  }

  static CharacterData removeCustomTool(CharacterData character, String label) {
    final current = character.manualToolProficiencyOverrides ??
        CharacterToolProficiencyOverridesData();
    return character.copyWith(
      manualToolProficiencyOverrides: CharacterToolProficiencyOverridesData(
        addedKeys: current.addedKeys,
        removedKeys: current.removedKeys,
        custom: _removeString(current.custom, label),
      ),
    );
  }

  static CharacterData resetTools(CharacterData character) =>
      character.copyWith(manualToolProficiencyOverrides: null);

  static CharacterData addWeaponCategory(
    CharacterData character,
    WeaponCategory category,
  ) {
    final current = character.manualWeaponProficiencyOverrides ??
        CharacterWeaponProficiencyOverridesData();
    return character.copyWith(
      manualWeaponProficiencyOverrides: CharacterWeaponProficiencyOverridesData(
        addedCategories: _contains(current.removedCategories, category)
            ? current.addedCategories ?? []
            : _addEnum(current.addedCategories, category),
        removedCategories: _removeEnum(current.removedCategories, category),
        addedKeys: current.addedKeys,
        removedKeys: current.removedKeys,
        custom: current.custom,
      ),
    );
  }

  static CharacterData removeWeaponCategory(
    CharacterData character,
    WeaponCategory category,
  ) {
    final current = character.manualWeaponProficiencyOverrides ??
        CharacterWeaponProficiencyOverridesData();
    return character.copyWith(
      manualWeaponProficiencyOverrides: CharacterWeaponProficiencyOverridesData(
        addedCategories: _removeEnum(current.addedCategories, category),
        removedCategories: _contains(current.addedCategories, category)
            ? _removeEnum(current.removedCategories, category)
            : _addEnum(current.removedCategories, category),
        addedKeys: current.addedKeys,
        removedKeys: current.removedKeys,
        custom: current.custom,
      ),
    );
  }

  static CharacterData addWeaponKey(CharacterData character, String key) {
    final current = character.manualWeaponProficiencyOverrides ??
        CharacterWeaponProficiencyOverridesData();
    return character.copyWith(
      manualWeaponProficiencyOverrides: CharacterWeaponProficiencyOverridesData(
        addedCategories: current.addedCategories,
        removedCategories: current.removedCategories,
        addedKeys: _containsString(current.removedKeys, key)
            ? current.addedKeys ?? []
            : _addString(current.addedKeys, key),
        removedKeys: _removeString(current.removedKeys, key),
        custom: current.custom,
      ),
    );
  }

  static CharacterData removeWeaponKey(CharacterData character, String key) {
    final current = character.manualWeaponProficiencyOverrides ??
        CharacterWeaponProficiencyOverridesData();
    return character.copyWith(
      manualWeaponProficiencyOverrides: CharacterWeaponProficiencyOverridesData(
        addedCategories: current.addedCategories,
        removedCategories: current.removedCategories,
        addedKeys: _removeString(current.addedKeys, key),
        removedKeys: _containsString(current.addedKeys, key)
            ? _removeString(current.removedKeys, key)
            : _addString(current.removedKeys, key),
        custom: current.custom,
      ),
    );
  }

  static CharacterData addCustomWeapon(CharacterData character, String label) {
    final current = character.manualWeaponProficiencyOverrides ??
        CharacterWeaponProficiencyOverridesData();
    return character.copyWith(
      manualWeaponProficiencyOverrides: CharacterWeaponProficiencyOverridesData(
        addedCategories: current.addedCategories,
        removedCategories: current.removedCategories,
        addedKeys: current.addedKeys,
        removedKeys: current.removedKeys,
        custom: _addCustom(current.custom, label),
      ),
    );
  }

  static CharacterData removeCustomWeapon(
      CharacterData character, String label) {
    final current = character.manualWeaponProficiencyOverrides ??
        CharacterWeaponProficiencyOverridesData();
    return character.copyWith(
      manualWeaponProficiencyOverrides: CharacterWeaponProficiencyOverridesData(
        addedCategories: current.addedCategories,
        removedCategories: current.removedCategories,
        addedKeys: current.addedKeys,
        removedKeys: current.removedKeys,
        custom: _removeString(current.custom, label),
      ),
    );
  }

  static CharacterData resetWeapons(CharacterData character) =>
      character.copyWith(manualWeaponProficiencyOverrides: null);

  static CharacterData addArmorCategory(
    CharacterData character,
    ArmorCategory category,
  ) {
    final current = character.manualArmorTrainingOverrides ??
        CharacterArmorTrainingOverridesData();
    return character.copyWith(
      manualArmorTrainingOverrides: CharacterArmorTrainingOverridesData(
        addedCategories: _contains(current.removedCategories, category)
            ? current.addedCategories ?? []
            : _addEnum(current.addedCategories, category),
        removedCategories: _removeEnum(current.removedCategories, category),
        custom: current.custom,
      ),
    );
  }

  static CharacterData removeArmorCategory(
    CharacterData character,
    ArmorCategory category,
  ) {
    final current = character.manualArmorTrainingOverrides ??
        CharacterArmorTrainingOverridesData();
    return character.copyWith(
      manualArmorTrainingOverrides: CharacterArmorTrainingOverridesData(
        addedCategories: _removeEnum(current.addedCategories, category),
        removedCategories: _contains(current.addedCategories, category)
            ? _removeEnum(current.removedCategories, category)
            : _addEnum(current.removedCategories, category),
        custom: current.custom,
      ),
    );
  }

  static CharacterData addCustomArmor(CharacterData character, String label) {
    final current = character.manualArmorTrainingOverrides ??
        CharacterArmorTrainingOverridesData();
    return character.copyWith(
      manualArmorTrainingOverrides: CharacterArmorTrainingOverridesData(
        addedCategories: current.addedCategories,
        removedCategories: current.removedCategories,
        custom: _addCustom(current.custom, label),
      ),
    );
  }

  static CharacterData removeCustomArmor(
      CharacterData character, String label) {
    final current = character.manualArmorTrainingOverrides ??
        CharacterArmorTrainingOverridesData();
    return character.copyWith(
      manualArmorTrainingOverrides: CharacterArmorTrainingOverridesData(
        addedCategories: current.addedCategories,
        removedCategories: current.removedCategories,
        custom: _removeString(current.custom, label),
      ),
    );
  }

  static CharacterData resetArmor(CharacterData character) =>
      character.copyWith(manualArmorTrainingOverrides: null);

  static List<T> _addEnum<T>(List<T>? values, T value) =>
      {...?values, value}.toList();

  static bool _contains<T>(List<T>? values, T value) =>
      values?.contains(value) ?? false;

  static bool _containsString(List<String>? values, String value) =>
      values?.any((item) => item.toLowerCase() == value.toLowerCase()) ?? false;

  static List<T> _removeEnum<T>(List<T>? values, T value) =>
      (values ?? []).where((item) => item != value).toList();

  static List<String> _addString(List<String>? values, String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return values ?? [];
    final current = [...?values];
    if (!current
        .any((item) => item.toLowerCase() == normalized.toLowerCase())) {
      current.add(normalized);
    }
    return current;
  }

  static List<String> _removeString(List<String>? values, String value) =>
      (values ?? [])
          .where((item) => item.toLowerCase() != value.toLowerCase())
          .toList();

  static List<String> _addCustom(List<String>? values, String label) {
    final normalized = label.trim();
    if (normalized.isEmpty) return values ?? [];
    final current = [...?values];
    if (!current
        .any((item) => item.toLowerCase() == normalized.toLowerCase())) {
      current.add(normalized);
    }
    return current;
  }
}
