import 'package:characters_mirror_shared/dungeon_master.dart';
import 'dm_statblock_context.dart';
import 'dm_statblock_labels.dart';
import 'dm_statblock_models.dart';
import 'dm_statblock_values.dart';
import 'dm_legendary_presentation.dart';

DmSection dmItemSection(NormalizedCreatureItem item, [DmStatContext? context]) {
  final linked =
      context == null ? null : dmLinkedLegendarySection(item, context);
  if (linked != null) return linked;
  if (item.itemType == 'spell') return DmSection.spells;
  final source = dmMap(item.fields['sourceSystem']);
  if (item.itemType == 'consumable' && source['consumableType'] == 'ammo') {
    return DmSection.equipment;
  }
  final activation =
      item.activationType ?? dmText(dmMap(source['activation'])['type']);
  final explicit = switch (activation) {
    'action' => DmSection.actions,
    'bonus' => DmSection.bonus,
    'reaction' => DmSection.reactions,
    'legendary' => DmSection.legendary,
    'mythic' => DmSection.mythic,
    'lair' => DmSection.lair,
    'regional' => DmSection.regional,
    _ => null,
  };
  if (explicit != null) return explicit;
  if (item.itemType == 'feat' && {'', 'none'}.contains(activation)) {
    if ({'mwak', 'rwak', 'msak', 'rsak', 'save', 'heal'}
        .contains(item.fields['actionType'])) {
      return DmSection.other;
    }
    return DmSection.traits;
  }
  if ({'weapon', 'equipment', 'consumable', 'loot', 'tool', 'backpack'}
          .contains(item.itemType) &&
      {'', 'none'}.contains(activation)) {
    return DmSection.equipment;
  }
  return DmSection.other;
}

DmItemView dmPresentItem(
    NormalizedCreatureItem item, String id, DmStatContext context) {
  final f = item.fields, source = dmMap(f['sourceSystem']);
  final section = dmItemSection(item, context);
  final lines = <DmStatLine>[];
  void add(String label, String value) {
    if (value.isNotEmpty) lines.add(DmStatLine(label, value));
  }

  final attack = section != DmSection.equipment &&
      {'mwak', 'rwak', 'msak', 'rsak'}.contains(f['actionType']);
  final ability = context.attackAbility(item);
  if (attack) {
    add('Атака', '${dmSigned(context.attackTotal(item))} к попаданию');
    if (context.attackTotal(item) == null && dmHasValue(f['attackBonus'])) {
      add('Дополнительный бонус атаки', dmText(f['attackBonus']));
    }
  }
  final parts = f['damageParts'];
  final damage = <String>[];
  if (parts is List) {
    for (final part in parts) {
      if (part is List && part.isNotEmpty && dmText(part.first).isNotEmpty) {
        damage.add(
            '${context.formula(dmText(part.first), ability: ability, spellLevel: item.spellLevel)}'
            '${part.length > 1 && dmText(part[1]).isNotEmpty ? ' (${dmLocalized(part[1], dmDamageLabels)})' : ''}');
      }
    }
  }
  add(f['actionType'] == 'heal' ? 'Лечение' : 'Урон', damage.join(' + '));
  if (dmHasValue(f['versatileDamage'])) {
    add('Двумя руками',
        context.formula(dmText(f['versatileDamage']), ability: ability));
  }
  if (dmHasValue(f['formula'])) {
    add(
        'Дополнительная формула',
        context.formula(dmText(f['formula']),
            ability: ability, spellLevel: item.spellLevel));
  }
  if (dmHasValue(f['saveAbility'])) {
    add('Спасбросок',
        '${dmLocalized(f['saveAbility'], dmAbilityLabels)} СЛ ${context.saveDc(item) ?? '—'}');
  }
  if (section != DmSection.equipment) {
    add('Дистанция', dmDistance(dmMap(f['range'])));
  }
  final target = dmMap(f['target']);
  if (dmHasValue(target['type']) && target['type'] != 'none') {
    add(
        'Цель',
        [
          dmText(target['value']),
          dmLocalized(target['units'], dmUnitLabels),
          dmLocalized(target['type'], {
            'creature': 'существо',
            'ally': 'союзник',
            'enemy': 'противник',
            'object': 'объект',
            'space': 'точка',
            'self': 'на себя',
            'cone': 'конус',
            'line': 'линия',
            'sphere': 'сфера',
            'radius': 'радиус',
            'cube': 'куб',
            'cylinder': 'цилиндр',
            'wall': 'стена'
          }),
          if (dmHasValue(target['width'])) 'ширина ${dmText(target['width'])}'
        ].where((s) => s.isNotEmpty).join(' '));
  }
  final activation = item.activationType ?? '';
  final cost = dmNumber(f['activationCost']);
  if (activation.isNotEmpty && activation != 'none') {
    add('Активация',
        '${dmLocalized(activation, dmActivationLabels)}${cost != null ? ' · $cost' : ''}');
  }
  add('Условие', dmText(f['activationCondition']));
  final uses = dmMap(f['uses']);
  if (dmHasValue(uses['max'])) {
    add(
        'Использования (макс.)',
        '${context.formula(dmText(uses['max']), ability: ability)}'
            '${dmHasValue(uses['per']) ? ' / ${dmLocalized(uses['per'], dmRecoveryLabels)}' : ''}');
    add('Восстановление', dmText(uses['recovery']));
  }
  final recharge = dmNumber(dmMap(f['recharge'])['value']);
  if (recharge != null) add('Перезарядка', recharge == 6 ? '6' : '$recharge–6');
  final consume = dmMap(f['consume']);
  final sharedLegendaryCost = activation == 'legendary' &&
      consume['type'] == 'attribute' &&
      consume['target'] == 'resources.legact.value' &&
      cost != null &&
      cost == dmNumber(consume['amount']);
  if (dmHasValue(consume['type']) && !sharedLegendaryCost) {
    final linked = context.creature.items
        .where((i) => i.fields['sourceItemId'] == consume['target']);
    add(
        'Расход',
        '${dmText(consume['amount'])} ${dmLocalized(consume['type'], {
              'ammo': 'боеприпасов',
              'attribute': 'ресурса',
              'material': 'материалов',
              'charges': 'зарядов'
            })}'
                '${linked.isNotEmpty ? ' · ${linked.first.name}' : ''}'
            .trim());
  }
  if (item.itemType == 'spell') _spellLines(item, add);
  final properties = dmMap(source['properties']);
  final propertyText = [
    for (final entry in {
      'fin': 'Фехтовальное',
      'lgt': 'Лёгкое',
      'hvy': 'Тяжёлое',
      'amm': 'Боеприпасы',
      'two': 'Двуручное',
      'rch': 'Досягаемость',
      'lod': 'Перезарядка',
      'thr': 'Метательное',
      'ver': 'Универсальное',
      'mgc': 'Магическое',
      'sil': 'Посеребрённое',
      'ada': 'Адамантиновое',
      'spc': 'Особое'
    }.entries)
      if (properties[entry.key] == true) entry.value
  ];
  add('Свойства', propertyText.join(', '));
  if (section == DmSection.equipment) {
    if (dmHasValue(source['quantity'])) {
      add('Количество', dmText(source['quantity']));
    }
    if (source['equipped'] is bool) {
      add('Надето', source['equipped'] == true ? 'Да' : 'Нет');
    }
    final armor = dmMap(source['armor']);
    if (dmHasValue(armor['value'])) {
      add('КД экипировки', dmText(armor['value']));
    }
  }
  final short = <String>[
    if (item.itemType == 'spell')
      item.spellLevel == 0 ? 'Заговор' : 'Уровень ${item.spellLevel ?? '—'}',
    for (final line in lines
        .where((l) => {
              'Атака',
              'Урон',
              'Лечение',
              'Спасбросок',
              'Перезарядка',
              'Использования (макс.)'
            }.contains(l.label))
        .take(2))
      {'Атака', 'Урон', 'Лечение'}.contains(line.label)
          ? line.value
          : line.text,
  ];
  return DmItemView(
      id: id,
      name: item.name,
      section: section,
      summary: short.join(' · '),
      description: item.description,
      costLabel: item.activationType == 'legendary' && cost != null
          ? '$cost ${cost == 1 ? 'действие' : cost >= 2 && cost <= 4 ? 'действия' : 'действий'}'
          : null,
      isLegendaryRules:
          section == DmSection.legendary && item.activationType != 'legendary',
      lines: List.unmodifiable(lines));
}

void _spellLines(
    NormalizedCreatureItem item, void Function(String, String) add) {
  final props = dmMap(item.fields['spellProperties']);
  add('Уровень',
      item.spellLevel == 0 ? 'Заговор' : '${item.spellLevel ?? '—'}');
  add('Школа', dmLocalized(props['school'], dmSchoolLabels));
  final duration = dmMap(props['duration']);
  add(
      'Длительность',
      [dmText(duration['value']), dmLocalized(duration['units'], dmUnitLabels)]
          .where((s) => s.isNotEmpty)
          .join(' '));
  final components = dmMap(props['components']);
  add(
      'Компоненты',
      [
        if (components['vocal'] == true) 'В',
        if (components['somatic'] == true) 'С',
        if (components['material'] == true) 'М',
      ].join(', '));
  if (components['material'] == true) {
    final materials = dmMap(props['materials']);
    add('Материалы', dmText(materials['value']));
    if (dmNumber(materials['cost']) case final num cost when cost > 0) {
      add('Стоимость материалов', '$cost зм');
    }
    if (materials['consumed'] is bool) {
      add('Материалы расходуются',
          materials['consumed'] == true ? 'Да' : 'Нет');
    }
  }
  if (components['concentration'] == true) add('Концентрация', 'Да');
  if (components['ritual'] == true) add('Ритуал', 'Да');
  final mode = dmMap(props['preparation'])['mode'];
  final uses = dmMap(item.fields['uses']);
  add(
      'Применение',
      item.spellLevel == 0 || mode == 'atwill'
          ? 'Неограниченно'
          : dmHasValue(uses['max'])
              ? 'Ограниченное число использований'
              : {'prepared', 'always', 'pact'}.contains(mode)
                  ? 'Ячейка заклинания'
                  : mode == 'innate'
                      ? 'Врождённое заклинание; см. описание'
                      : 'См. описание');
  final scaling = dmMap(props['scaling']);
  if (dmHasValue(scaling['formula'])) {
    add('Усиление', dmText(scaling['formula']));
  }
}
