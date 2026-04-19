import 'package:characters_mirror_client/characters_mirror_client.dart';

String weaponPropertyRuLabel(WeaponProperty property) {
  switch (property) {
    case WeaponProperty.ammunition:
      return 'Боеприпас';
    case WeaponProperty.finesse:
      return 'Фехтовальное';
    case WeaponProperty.heavy:
      return 'Тяжёлое';
    case WeaponProperty.light:
      return 'Лёгкое';
    case WeaponProperty.loading:
      return 'Перезарядка';
    case WeaponProperty.range:
      return 'Дистанция';
    case WeaponProperty.reach:
      return 'Досягаемость';
    case WeaponProperty.special:
      return 'Особое';
    case WeaponProperty.thrown:
      return 'Метательное';
    case WeaponProperty.twoHanded:
      return 'Двуручное';
    case WeaponProperty.versatile:
      return 'Универсальное';
  }
}

WeaponProperty? weaponPropertyFromTag(String tag) {
  final normalized = tag.trim().toLowerCase();
  if (normalized.isEmpty) {
    return null;
  }

  for (final property in WeaponProperty.values) {
    if (property.name.toLowerCase() == normalized) {
      return property;
    }
  }

  return switch (normalized) {
    'two-handed' || 'two_handed' => WeaponProperty.twoHanded,
    _ => null,
  };
}
