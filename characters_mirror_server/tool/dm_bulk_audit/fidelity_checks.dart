import 'package:characters_mirror_shared/dungeon_master.dart';
import 'package:html/parser.dart' as html;
import 'bulk_inventory.dart';

class FidelityIssue {
  FidelityIssue(this.category, this.field, this.reason);
  final String category, field, reason;
}

/// Independent preservation assertions, never a second creature normalizer.
List<FidelityIssue> checkFidelity(
    AuditJson source, NormalizedCreature creature) {
  final issues = <FidelityIssue>[];
  final system = object(source['system']);
  final attributes = object(system['attributes']);
  final details = object(system['details']);
  final traits = object(system['traits']);
  void equal(Object? from, Object? to, String field) {
    if (from != null && !sameJson(from, to)) {
      issues.add(FidelityIssue('data_loss', field,
          'Source value differs from normalized/round-trip value.'));
    }
  }

  equal(source['name'], creature.identity['originalName'],
      'identity.originalName');
  equal(details['type'], creature.identity['creatureType'],
      'identity.creatureType');
  equal(traits['size'], creature.identity['size'], 'identity.size');
  equal(details['alignment'], creature.identity['alignment'],
      'identity.alignment');
  equal(details['source'], creature.identity['sourceBook'],
      'identity.sourceBook');
  equal(
      details['cr'] is num ? details['cr'] : num.tryParse('${details['cr']}'),
      creature.identity['challengeRatingValue'],
      'identity.challengeRatingValue');
  equal(object(attributes['hp'])['formula'], creature.combat['hpFormula'],
      'combat.hpFormula');
  equal(object(attributes['hp']), creature.combat['hpSettings'],
      'combat.hpSettings');
  equal(object(attributes['init']), creature.combat['initiativeSettings'],
      'combat.initiativeSettings');
  equal(object(attributes['ac']), creature.combat['armorClassSettings'],
      'combat.armorClassSettings');
  equal(attributes['movement'], creature.combat['movement'], 'combat.movement');
  equal(attributes['senses'], creature.combat['senses'], 'combat.senses');
  equal(system['skills'], creature.otherStats['skills'], 'otherStats.skills');
  equal(traits['languages'], creature.otherStats['languages'],
      'otherStats.languages');
  equal(system['spells'], creature.spellSlots, 'spellSlots');
  equal(system['resources'], creature.resources, 'resources');
  for (final key in ['str', 'dex', 'con', 'int', 'wis', 'cha']) {
    final ability = object(object(system['abilities'])[key]);
    final normalized = object(creature.abilities[key]);
    equal(ability['value'], normalized['score'], 'abilities.$key.score');
    equal(ability['proficient'], normalized['saveProficiency'],
        'abilities.$key.saveProficiency');
    equal(ability['bonuses'], normalized['bonuses'], 'abilities.$key.bonuses');
  }
  for (final pair in {
    'dr': 'damageResistances',
    'di': 'damageImmunities',
    'dv': 'damageVulnerabilities',
    'ci': 'conditionImmunities',
    'dm': 'damageModifiers'
  }.entries) {
    equal(traits[pair.key], creature.defenses[pair.value],
        'defenses.${pair.value}');
  }
  final items = source['items'] is List ? source['items'] as List : [];
  if (items.length != creature.items.length) {
    issues.add(FidelityIssue('item_loss', 'items',
        '${items.length} source items vs ${creature.items.length} normalized items.'));
  }
  for (var i = 0; i < items.length && i < creature.items.length; i++) {
    final item = object(items[i]);
    final data = object(item['system']);
    final normalized = creature.items[i];
    equal(item['_id'], normalized.fields['sourceItemId'],
        'items[$i].sourceItemId');
    equal(item['name'], normalized.name, 'items[$i].name');
    equal(item['type'], normalized.itemType, 'items[$i].itemType');
    equal(data, normalized.fields['sourceSystem'], 'items[$i].sourceSystem');
    equal(item['effects'], normalized.fields['effects'], 'items[$i].effects');
    for (final key in ['uses', 'recharge', 'consume', 'range', 'target']) {
      equal(data[key], normalized.fields[key], 'items[$i].$key');
    }
    equal(object(data['damage'])['parts'], normalized.fields['damageParts'],
        'items[$i].damageParts');
    equal(data['level'], normalized.spellLevel, 'items[$i].spellLevel');
    final attack = data['attackBonus'] ?? object(data['attack'])['bonus'];
    equal(attack, normalized.fields['attackBonus'], 'items[$i].attackBonus');
    final rawDescription = object(data['description'])['value'];
    if (rawDescription is String) {
      final fragment = html.parseFragment(rawDescription);
      for (final element
          in fragment.querySelectorAll('script,style,iframe,object')) {
        element.remove();
      }
      if ((fragment.text ?? '').trim().isNotEmpty &&
          normalized.description.trim().isEmpty) {
        issues.add(FidelityIssue('html_conversion', 'items[$i].description',
            'Visible source text disappeared.'));
      }
    }
  }
  // Unknown derived values must have an explicit diagnostic, not false defaults.
  if (creature.armorClass == null &&
      !creature.diagnostics.any((d) => d.contains('КД'))) {
    issues.add(FidelityIssue(
        'armor_formula', 'combat.armorClass', 'Unknown AC without a warning.'));
  }
  if (creature.initiativeBonus == null &&
      !creature.diagnostics.any((d) => d.contains('инициатив'))) {
    issues.add(FidelityIssue('initiative_formula', 'combat.initiativeBonus',
        'Unknown initiative without a warning.'));
  }
  for (final pair
      in {'max': creature.hpMax, 'value': creature.hpInitial}.entries) {
    final value = object(attributes['hp'])[pair.key];
    if (value is num && value >= 0) {
      equal(value, pair.value, 'combat.hp.${pair.key}');
    }
  }
  final ac = object(attributes['ac']);
  if (ac['flat'] is num && {'flat', 'natural'}.contains(ac['calc'])) {
    equal(ac['flat'], creature.armorClass, 'combat.armorClass');
  }
  final init = object(attributes['init']);
  final abilityKey =
      init['ability'] is String && (init['ability'] as String).isNotEmpty
          ? init['ability']
          : 'dex';
  final score = object(object(system['abilities'])[abilityKey])['value'];
  final bonus = init['bonus'] == null || init['bonus'] == ''
      ? 0
      : num.tryParse('${init['bonus']}');
  if (score is num && bonus != null && bonus == bonus.round()) {
    equal(((score - 10) / 2).floor() + bonus, creature.initiativeBonus,
        'combat.initiativeBonus');
  }
  final equippedArmor = items.where((item) =>
      object(item)['type'] == 'equipment' &&
      object(object(item)['system'])['equipped'] == true &&
      object(object(object(item)['system'])['armor'])['value'] is num);
  final dex = object(object(system['abilities'])['dex'])['value'];
  if (ac['calc'] == 'default' && dex is num) {
    // Rule-level oracle for known armor types; no creature-name exceptions.
    final armors = equippedArmor
        .map((item) => object(object(object(item)['system'])['armor']))
        .toList();
    final body = armors.where((armor) => armor['type'] != 'shield').toList();
    final shields = armors.where((armor) => armor['type'] == 'shield').toList();
    if (body.length <= 1 &&
        shields.length <= 1 &&
        armors.every((armor) =>
            {'light', 'medium', 'heavy', 'shield'}.contains(armor['type']))) {
      final dexMod = ((dex - 10) / 2).floor();
      final shield = shields.isEmpty ? 0 : shields.single['value'] as num;
      num expected = 10 + dexMod + shield;
      if (body.isNotEmpty) {
        final armor = body.single;
        final cap = armor['dex'] ?? (armor['type'] == 'medium' ? 2 : null);
        final modifier = armor['type'] == 'heavy'
            ? 0
            : cap is num && dexMod > cap
                ? cap
                : dexMod;
        expected = (armor['value'] as num) + modifier + shield;
      }
      equal(expected, creature.armorClass, 'combat.armorClass.equipment');
    }
  }
  return issues;
}

String diagnosticCategory(String text) {
  if (text.contains('dnd5e') ||
      text.contains('версия') ||
      text.contains('Версия')) {
    return 'foundry_version';
  }
  if (text.contains('тип предмета')) return 'unknown_item_type';
  if (text.contains('КД') || text.contains('доспехов')) return 'armor_formula';
  if (text.contains('init') || text.contains('инициатив')) {
    return 'initiative_formula';
  }
  if (text.contains('damage')) return 'damage_format';
  if (text.contains('description')) return 'html_conversion';
  if (text.contains('resources') ||
      text.contains('uses') ||
      text.contains('recharge')) {
    return 'invalid_resources';
  }
  return 'other_warning';
}
