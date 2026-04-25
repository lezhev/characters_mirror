import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/attributes/helpers/attributes_labels.dart';

String classSummary(List<CharacterClassEntryData>? entries) {
  final labels = [
    for (final entry in sortedClassEntries(entries)) classEntrySummary(entry),
  ];
  if (labels.isEmpty) {
    return 'Класс не выбран';
  }
  return labels.join(', ');
}

String classEntrySummary(CharacterClassEntryData entry) {
  final className = displayName(entry.classData?.name, 'Класс не выбран');
  final parts = <String>[
    if (entry.level == null) className else '$className ${entry.level} уровень',
    if (normalizedText(entry.subclass?.name) != null)
      entry.subclass!.name!.trim(),
  ];
  return parts.join(' • ');
}

String raceSummary(RaceData? race, SubraceData? subrace) {
  final raceName = normalizedText(race?.name);
  final subraceName = normalizedText(subrace?.name);
  if (raceName == null && subraceName == null) {
    return 'Раса не выбрана';
  }
  return [
    if (raceName != null) raceName,
    if (subraceName != null) subraceName,
  ].join(' • ');
}

List<CharacterClassEntryData> sortedClassEntries(
  List<CharacterClassEntryData>? entries,
) {
  return [...?entries]..sort((left, right) {
      final orderCompare =
          (left.classOrder ?? 0).compareTo(right.classOrder ?? 0);
      if (orderCompare != 0) {
        return orderCompare;
      }
      return (left.id ?? '').compareTo(right.id ?? '');
    });
}

String displayName(String? value, String fallback) {
  return normalizedText(value) ?? fallback;
}

String? normalizedText(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return null;
  }
  return trimmed;
}

String joinAbilities(List<Ability> abilities) {
  return abilities.map(abilityLabel).join(', ');
}

String abilityLabel(Ability ability) {
  return attributesAbilityLabel(ability);
}

String joinArmorCategories(List<ArmorCategory> categories) {
  return categories.map(_armorCategoryLabel).join(', ');
}

String joinWeaponCategories(List<WeaponCategory> categories) {
  return categories.map(_weaponCategoryLabel).join(', ');
}

String _armorCategoryLabel(ArmorCategory category) {
  switch (category) {
    case ArmorCategory.light:
      return 'Лёгкая броня';
    case ArmorCategory.medium:
      return 'Средняя броня';
    case ArmorCategory.heavy:
      return 'Тяжёлая броня';
    case ArmorCategory.shield:
      return 'Щиты';
  }
}

String _weaponCategoryLabel(WeaponCategory category) {
  switch (category) {
    case WeaponCategory.simpleMelee:
      return 'Простое рукопашное';
    case WeaponCategory.simpleRanged:
      return 'Простое дальнобойное';
    case WeaponCategory.martialMelee:
      return 'Воинское рукопашное';
    case WeaponCategory.martialRanged:
      return 'Воинское дальнобойное';
  }
}
