import 'foundry_json_reader.dart';

FoundryJson foundryCombat(
    FoundryJson system, List<FoundryJson> items, FoundryJsonReader reader) {
  final attributes = reader.object(system['attributes'], 'system.attributes');
  final abilities = reader.object(system['abilities'], 'system.abilities');
  final ac = reader.object(attributes['ac'], 'system.attributes.ac');
  final hp = reader.object(attributes['hp'], 'system.attributes.hp');
  final init = reader.object(attributes['init'], 'system.attributes.init');
  final initAbility = reader.text(init['ability'], 'init.ability');
  final ability =
      initAbility == null || initAbility.isEmpty ? 'dex' : initAbility;
  final score = reader.integer(
      reader.object(abilities[ability], 'abilities.$ability')['value'],
      'abilities.$ability.value');
  final bonusRaw = init['bonus'];
  final bonus = bonusRaw == null || bonusRaw == ''
      ? 0
      : reader.integer(bonusRaw, 'init.bonus');
  final armorClass = _armorClass(ac, abilities, items, reader);
  if (armorClass == null) {
    reader.diagnostics
        .add('Не удалось вычислить КД; значение оставлено неизвестным.');
  }
  if (score == null || bonus == null) {
    reader.diagnostics
        .add('Не удалось вычислить инициативу; настройки сохранены.');
  }
  return {
    'armorClass': armorClass,
    'armorClassSource': ac['calc'],
    'armorClassFormula': reader.text(ac['formula'], 'ac.formula'),
    'armorClassSettings': ac,
    'hpMax': reader.nonNegative(hp['max'], 'hp.max'),
    'hpInitial': reader.nonNegative(hp['value'], 'hp.value'),
    'hpFormula': reader.text(hp['formula'], 'hp.formula'),
    'hpSettings': hp,
    'initiativeAbility': ability,
    'initiativeBonus': score != null && bonus != null
        ? ((score - 10) / 2).floor() + bonus
        : null,
    'initiativeExtraBonus': bonusRaw,
    'initiativeSettings': init,
    'movement': reader.object(attributes['movement'], 'attributes.movement'),
    'senses': reader.object(attributes['senses'], 'attributes.senses'),
  };
}

int? _armorClass(FoundryJson ac, FoundryJson abilities, List<FoundryJson> items,
    FoundryJsonReader reader) {
  final calc = ac['calc'];
  if (ac['flat'] != null && {'flat', 'natural'}.contains(calc)) {
    return reader.nonNegative(ac['flat'], 'ac.flat');
  }
  if (calc != null && calc != '' && calc != 'default') {
    reader.diagnostics.add(
        'Формула КД не интерпретируется автоматически: ${ac['formula'] ?? calc}.');
    return null;
  }
  final dex = reader.integer(
      reader.object(abilities['dex'], 'abilities.dex')['value'],
      'abilities.dex.value');
  final worn = items
      .where((item) => item['type'] == 'equipment')
      .map((item) => reader.object(item['system'], 'equipment.system'))
      .where((item) => item['equipped'] == true)
      .map((item) => reader.object(item['armor'], 'equipment.armor'))
      .where((armor) =>
          armor['type'] != null &&
          armor['type'] != '' &&
          armor['type'] != 'trinket')
      .toList();
  final shields = worn.where((armor) => armor['type'] == 'shield').toList();
  final body = worn.where((armor) => armor['type'] != 'shield').toList();
  if (body.length > 1 || shields.length > 1) {
    reader.diagnostics.add('Неоднозначная экипировка доспехов или щитов.');
    return null;
  }
  var shield = 0;
  if (shields.isNotEmpty) {
    final value = reader.nonNegative(shields.single['value'], 'shield.value');
    if (value == null) return null;
    shield = value;
  }
  if (body.isEmpty) {
    return dex == null ? null : 10 + ((dex - 10) / 2).floor() + shield;
  }
  final armor = body.single;
  final base = reader.nonNegative(armor['value'], 'armor.value');
  if (base == null) return null;
  if (armor['type'] == 'heavy') return base + shield;
  if (!{'light', 'medium'}.contains(armor['type']) || dex == null) return null;
  var modifier = ((dex - 10) / 2).floor();
  final cap = armor['dex'] == null
      ? (armor['type'] == 'medium' ? 2 : null)
      : reader.integer(armor['dex'], 'armor.dex');
  if (armor['dex'] != null && cap == null) return null;
  if (cap != null && modifier > cap) modifier = cap;
  return base + modifier + shield;
}
