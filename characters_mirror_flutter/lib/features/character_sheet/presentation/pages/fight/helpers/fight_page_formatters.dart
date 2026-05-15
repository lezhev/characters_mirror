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
  final parts = _normalizedDamageParts(attack.damageParts);
  if (parts.isEmpty) {
    return attack.damage ?? 'Урон';
  }
  return parts.map(_formatDamagePartLabel).join(' + ');
}

String formatDamageRollValue(CharacterAttackData attack) {
  final formulas = [
    for (final part in effectiveAttackDamageParts(attack))
      if (normalizedAttackText(part.formula) != null)
        normalizedAttackText(part.formula)!,
  ];
  return formulas.join(' + ');
}

List<DamagePartData> effectiveAttackDamageParts(CharacterAttackData attack) {
  final parts = _normalizedDamageParts(attack.damageParts);
  if (parts.isNotEmpty) {
    return parts;
  }

  final formula = normalizedAttackText(attack.damage);
  if (formula == null && attack.damageType == null) {
    return const <DamagePartData>[];
  }
  return [
    DamagePartData(
      formula: formula,
      damageType: attack.damageType,
    ),
  ];
}

List<DamagePartData> effectiveSpellDamageParts(SpellData spell) {
  final parts = _normalizedDamageParts(spell.damageParts);
  if (parts.isNotEmpty) {
    return parts;
  }

  final formula = normalizedAttackText(spell.damageDice);
  if (formula == null &&
      spell.damageType == null &&
      spell.damageScaling == null) {
    return const <DamagePartData>[];
  }
  return [
    DamagePartData(
      formula: formula,
      damageType: spell.damageType,
      scaling: spell.damageScaling,
    ),
  ];
}

String _formatDamagePartLabel(DamagePartData part) {
  final formula = normalizedAttackText(part.formula);
  final damageType = part.damageType;
  if (formula == null && damageType == null) {
    return 'Урон';
  }
  if (formula == null) {
    return damageTypeLabel(damageType!).toLowerCase();
  }
  if (damageType == null) {
    return formula;
  }
  return '$formula ${damageTypeLabel(damageType).toLowerCase()}';
}

List<DamagePartData> _normalizedDamageParts(List<DamagePartData>? parts) {
  return [
    for (final part in parts ?? const <DamagePartData>[])
      if (normalizedAttackText(part.formula) != null ||
          part.damageType != null ||
          part.scaling != null ||
          normalizedAttackText(part.notes) != null)
        DamagePartData(
          formula: normalizedAttackText(part.formula),
          damageType: part.damageType,
          scaling: part.scaling,
          notes: normalizedAttackText(part.notes),
        ),
  ];
}

String formatHpLabel(CharacterData character) {
  final maxHp = character.derived?.maxHp ?? 0;
  final currentHp = character.currentHp ?? maxHp;
  final temporaryHp = character.temporaryHp ?? 0;
  if (temporaryHp <= 0) {
    return '$currentHp / $maxHp';
  }
  return '$currentHp / $maxHp ($temporaryHp)';
}

String formatInitiativeLabel(CharacterData character) {
  final initiative = character.derived?.initiative ?? 0;
  return initiative >= 0 ? '+$initiative' : '$initiative';
}

String formatArmorClassLabel(CharacterData character) {
  return '${character.derived?.armorClass ?? 0}';
}

String formatSpeedLabel(CharacterData character) {
  return '${character.derived?.speed ?? 0}';
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
      _damagePartListsEqual(left.damageParts, right.damageParts) &&
      left.description == right.description &&
      listEquals(left.tags, right.tags);
}

bool _damagePartListsEqual(
  List<DamagePartData>? left,
  List<DamagePartData>? right,
) {
  final normalizedLeft = _normalizedDamageParts(left);
  final normalizedRight = _normalizedDamageParts(right);
  if (normalizedLeft.length != normalizedRight.length) {
    return false;
  }
  for (var index = 0; index < normalizedLeft.length; index++) {
    final leftPart = normalizedLeft[index];
    final rightPart = normalizedRight[index];
    if (leftPart.formula != rightPart.formula ||
        leftPart.damageType != rightPart.damageType ||
        leftPart.notes != rightPart.notes ||
        leftPart.scaling?.toJson().toString() !=
            rightPart.scaling?.toJson().toString()) {
      return false;
    }
  }
  return true;
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
