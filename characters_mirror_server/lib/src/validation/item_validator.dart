import 'package:characters_mirror_server/src/generated/protocol.dart';

import 'rules.dart';

abstract final class ItemValidator {
  static void validateInventoryItems(
    String field,
    List<CharacterInventoryItemData>? items,
  ) {
    Rules.mediumCollection(field, items);
    if (items == null) return;

    for (var index = 0; index < items.length; index++) {
      final item = items[index];
      final prefix = '$field[$index]';
      Rules.shortText('$prefix.id', item.id);
      Rules.mediumText('$prefix.name', item.name);
      Rules.nonNegativeInt('$prefix.quantity', item.quantity);
    }
  }

  static void validateAttacks(
    String field,
    List<CharacterAttackData>? attacks,
  ) {
    Rules.mediumCollection(field, attacks);
    if (attacks == null) return;

    for (var index = 0; index < attacks.length; index++) {
      final attack = attacks[index];
      final prefix = '$field[$index]';
      Rules.shortText('$prefix.id', attack.id);
      Rules.shortText('$prefix.name', attack.name);
      Rules.shortText('$prefix.damage', attack.damage);
      Rules.boundedInt(
        '$prefix.customAttackBonus',
        attack.customAttackBonus,
      );
      Rules.mediumText('$prefix.description', attack.description);
      _validateTags('$prefix.tags', attack.tags);
      _validateDamageParts('$prefix.damageParts', attack.damageParts);
    }
  }

  static void _validateTags(String field, List<String>? tags) {
    Rules.smallCollection(field, tags);
    if (tags == null) return;

    for (var index = 0; index < tags.length; index++) {
      Rules.shortText('$field[$index]', tags[index]);
    }
  }

  static void _validateDamageParts(
    String field,
    List<DamagePartData>? damageParts,
  ) {
    Rules.smallCollection(field, damageParts);
    if (damageParts == null) return;

    for (var index = 0; index < damageParts.length; index++) {
      final part = damageParts[index];
      final prefix = '$field[$index]';
      Rules.shortText('$prefix.formula', part.formula);
      Rules.mediumText('$prefix.notes', part.notes);
    }
  }
}
