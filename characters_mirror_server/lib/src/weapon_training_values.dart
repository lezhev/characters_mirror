import 'generated/enums/weapon_category.dart';

List<WeaponCategory> weaponCategoriesFromTrainingValues(
  Iterable<String>? values,
) {
  return [
    for (final value in values ?? const <String>[])
      if (_weaponCategoryByName(value) case final category?) category,
  ];
}

List<String> weaponKeysFromTrainingValues(Iterable<String>? values) {
  return [
    for (final value in values ?? const <String>[])
      if (_weaponCategoryByName(value) == null) value,
  ];
}

WeaponCategory? _weaponCategoryByName(String value) {
  for (final category in WeaponCategory.values) {
    if (category.name == value) return category;
  }
  return null;
}
