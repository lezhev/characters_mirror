import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/weapon_property_localization.dart';
import 'package:flutter/foundation.dart';

String formatAttackBonus(CharacterData character, CharacterAttackData attack) {
  final proficiencyBonus = character.derived?.proficiencyBonus ?? 0;
  final abilityModifier = attack.leadingAbility == null
      ? 0
      : character.derived?.abilityModifiers?[attack.leadingAbility!.name] ?? 0;
  final customBonus = attack.customAttackBonus ?? 0;
  final total = proficiencyBonus + abilityModifier + customBonus;
  return total >= 0 ? '+$total' : '$total';
}

String formatDamageLabel(CharacterAttackData attack) {
  return attack.damage ?? 'Урон';
}

String formatHpLabel(CharacterData character) {
  final maxHp = character.derived?.maxHp ?? 0;
  final currentHp = character.currentHp ?? maxHp;
  final temporaryHp = character.temporaryHp ?? 0;
  return '$currentHp / $maxHp ($temporaryHp)';
}

String formatInitiativeLabel(CharacterData character) {
  final initiative = character.derived?.initiative ?? 0;
  return initiative >= 0 ? '+$initiative' : '$initiative';
}

String formatArmorClassLabel(CharacterData character) {
  return '${character.derived?.armorClass ?? 0}';
}

String abilityLabel(Ability ability) {
  switch (ability) {
    case Ability.strength:
      return 'Сила';
    case Ability.dexterity:
      return 'Ловкость';
    case Ability.constitution:
      return 'Телосложение';
    case Ability.intelligence:
      return 'Интеллект';
    case Ability.wisdom:
      return 'Мудрость';
    case Ability.charisma:
      return 'Харизма';
  }
}

String damageTypeLabel(DamageType damageType) {
  switch (damageType) {
    case DamageType.acid:
      return 'Кислота';
    case DamageType.bludgeoning:
      return 'Дробящий';
    case DamageType.cold:
      return 'Холод';
    case DamageType.fire:
      return 'Огонь';
    case DamageType.force:
      return 'Силовой';
    case DamageType.lightning:
      return 'Молния';
    case DamageType.necrotic:
      return 'Некротический';
    case DamageType.piercing:
      return 'Колющий';
    case DamageType.poison:
      return 'Яд';
    case DamageType.psychic:
      return 'Психический';
    case DamageType.radiant:
      return 'Излучение';
    case DamageType.slashing:
      return 'Рубящий';
    case DamageType.thunder:
      return 'Гром';
  }
}

String attackTagLabel(String tag) {
  final property = weaponPropertyFromTag(tag);
  return property == null ? tag : weaponPropertyRuLabel(property);
}

List<String> matchingWeaponPropertySuggestions({
  required String query,
  required List<String> selectedTags,
}) {
  final normalizedQuery = query.trim().toLowerCase();
  if (normalizedQuery.isEmpty) {
    return const [];
  }

  return WeaponProperty.values.map((property) => property.name).where((tag) {
    final alreadySelected = selectedTags.any(
      (selectedTag) => _normalizedAttackTagName(selectedTag) == tag,
    );
    if (alreadySelected) {
      return false;
    }
    return tag.startsWith(normalizedQuery);
  }).toList();
}

String _normalizedAttackTagName(String tag) {
  return weaponPropertyFromTag(tag)?.name ?? tag.trim().toLowerCase();
}

String? normalizedAttackText(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return null;
  }
  return trimmed;
}

bool attackEquals(CharacterAttackData? left, CharacterAttackData right) {
  if (left == null) {
    return false;
  }

  return left.name == right.name &&
      left.leadingAbility == right.leadingAbility &&
      left.damage == right.damage &&
      left.customAttackBonus == right.customAttackBonus &&
      left.damageType == right.damageType &&
      left.description == right.description &&
      listEquals(left.tags, right.tags);
}

bool matchesSelectedFeatureTags(
  CharacterFeatureViewData feature,
  Set<FeatureTag> selectedTags,
) {
  if (selectedTags.isEmpty) {
    return false;
  }

  final featureTags =
      feature.tags ?? feature.defaultTags ?? const <FeatureTag>[];
  return featureTags.any(selectedTags.contains);
}
