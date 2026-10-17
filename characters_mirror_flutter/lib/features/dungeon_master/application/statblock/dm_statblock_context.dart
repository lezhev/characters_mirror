import 'package:characters_mirror_shared/dungeon_master.dart';
import 'dm_statblock_values.dart';

/// Computes only base 2014 values; never evaluates Foundry formulas or effects.
class DmStatContext {
  DmStatContext(this.creature, this.actor);
  final NormalizedCreature creature;
  final Map<String, Object?> actor;
  Map<String, Object?> get system => dmMap(actor['system']);
  Map<String, Object?> get attributes => dmMap(system['attributes']);
  Map<String, Object?> get global => dmMap(creature.otherStats['bonuses']);
  num? get proficiency {
    final explicit = dmNumber(creature.otherStats['proficiencyBonus']);
    if (explicit != null) return explicit;
    final cr = dmNumber(creature.identity['challengeRatingValue']);
    if (cr == null || cr < 0 || cr > 30) return null;
    return 2 + (((cr < 1 ? 1 : cr) - 1) / 4).floor();
  }

  int? modifier(String ability) =>
      dmModifier(dmMap(creature.abilities[ability])['score']);
  String get casting => dmText(attributes['spellcasting']);
  num? sum(List<num?> terms) =>
      terms.any((v) => v == null) ? null : terms.fold<num>(0, (a, b) => a + b!);
  num? skillTotal(Map<String, Object?> skill) {
    final ability = dmText(skill['ability']);
    final prof = dmNumber(skill['value']);
    return sum([
      modifier(ability),
      prof == 0
          ? 0
          : prof != null && proficiency != null
              ? (prof * proficiency!).floor()
              : null,
      dmBonus(dmMap(skill['bonuses'])['check']),
      dmBonus(dmMap(dmMap(creature.abilities[ability])['bonuses'])['check']),
      dmBonus(dmMap(global['abilities'])['check']),
      dmBonus(dmMap(global['abilities'])['skill'])
    ]);
  }

  num? saveTotal(String ability) {
    final value = dmMap(creature.abilities[ability]);
    final prof = dmNumber(value['saveProficiency']);
    return sum([
      modifier(ability),
      prof == 0
          ? 0
          : prof != null && proficiency != null
              ? prof * proficiency!
              : null,
      dmBonus(dmMap(value['bonuses'])['save']),
      dmBonus(dmMap(global['abilities'])['save'])
    ]);
  }

  String attackAbility(NormalizedCreatureItem item) {
    final explicit = dmText(item.fields['attackAbility']);
    if (explicit.isNotEmpty) return explicit;
    if (item.itemType == 'spell') return casting;
    final source = dmMap(item.fields['sourceSystem']);
    if (item.itemType == 'weapon' &&
        dmMap(source['properties'])['fin'] == true) {
      final str = modifier('str'), dex = modifier('dex');
      return str == null || dex == null
          ? ''
          : dex >= str
              ? 'dex'
              : 'str';
    }
    if (item.itemType == 'weapon' &&
        {'simpleR', 'martialR'}.contains(source['weaponType'])) {
      return 'dex';
    }
    return switch (item.fields['actionType']) {
      'mwak' => 'str',
      'rwak' => 'dex',
      'msak' || 'rsak' => casting,
      _ => '',
    };
  }

  String formula(String input, {String? ability, int? spellLevel}) {
    var result = input;
    final mod = ability == null ? null : modifier(ability);
    if (mod != null) result = result.replaceAll('@mod', '$mod');
    if (proficiency != null) {
      result = result.replaceAll('@prof', '${proficiency!}');
    }
    if (spellLevel != null) {
      result = result.replaceAll('@item.level', '$spellLevel');
    }
    return result;
  }

  num? additiveBonus(Object? value, {String? ability}) {
    if (!dmHasValue(value)) return 0;
    final text = formula(dmText(value), ability: ability).replaceAll(' ', '');
    // Deliberately excludes dice, functions, JS and arbitrary expressions.
    if (!RegExp(r'^[+-]?\d+(?:[+-]\d+)*$').hasMatch(text)) return null;
    return RegExp(r'[+-]?\d+')
        .allMatches(text)
        .fold<num>(0, (a, b) => a + num.parse(b.group(0)!));
  }

  num? attackTotal(NormalizedCreatureItem item) {
    final f = item.fields, source = dmMap(f['sourceSystem']);
    final ability = attackAbility(item);
    final needsProf = !{'weapon', 'consumable'}.contains(item.itemType) ||
        source['proficient'] == true;
    if ({'weapon', 'consumable'}.contains(item.itemType) &&
        source['proficient'] is! bool) {
      return null;
    }
    final consume = dmMap(f['consume']);
    if (consume['type'] == 'ammo') {
      final ammo = creature.items
          .where((i) => i.fields['sourceItemId'] == consume['target']);
      if (ammo.any((i) =>
          dmHasValue(i.fields['attackBonus']) &&
          dmNumber(i.fields['attackBonus']) != 0)) {
        return null;
      }
    }
    return sum([
      modifier(ability),
      needsProf ? proficiency : 0,
      additiveBonus(f['attackBonus'], ability: ability),
      additiveBonus(dmMap(global[dmText(f['actionType'])])['attack'],
          ability: ability)
    ]);
  }

  num? saveDc(NormalizedCreatureItem item) {
    final f = item.fields, scaling = dmText(f['saveScaling']);
    if (scaling == 'flat') return dmNumber(f['saveDc']);
    final ability = scaling == 'spell' ? casting : scaling;
    if (ability.isEmpty) return dmNumber(f['saveDc']);
    return sum([
      8,
      modifier(ability),
      proficiency,
      dmBonus(dmMap(global['spell'])['dc'])
    ]);
  }
}
