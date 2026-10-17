import 'package:characters_mirror_shared/dungeon_master.dart';
import 'dm_item_presentation.dart';
import 'dm_resource_presentation.dart';
import 'dm_statblock_context.dart';
import 'dm_statblock_labels.dart';
import 'dm_statblock_models.dart';
import 'dm_statblock_values.dart';
import 'dm_proficiency_presentation.dart';
import 'dm_legendary_presentation.dart';
import 'dm_visual_groups.dart';
import 'dm_magic_presentation.dart';
export 'dm_statblock_models.dart';

class DmStatblock {
  DmStatblock._(this.name, this.identity, this.image, this.abilities,
      this.blocks, DmMagicView? magic)
      : groups = dmVisualGroups(blocks, magic: magic),
        proficiencySummary = List.unmodifiable(dmCompactProficiencies(blocks
            .where((b) => b.section == DmSection.saves)
            .expand((b) => b.lines)
            .toList()));
  final String name, identity;
  final Uri? image;
  final List<DmAbilityView> abilities;
  final List<DmBlockView> blocks;
  final List<DmVisualGroup> groups;
  final List<DmStatLine> proficiencySummary;

  factory DmStatblock.fromCreature(NormalizedCreature creature,
      {Map<String, Object?> sourceActor = const {}}) {
    final context = DmStatContext(creature, sourceActor);
    final rows = <DmSection, List<DmStatLine>>{};
    final grouped = <DmSection, List<DmItemView>>{};
    final identity = creature.identity, combat = creature.combat;
    final type = dmMap(identity['creatureType']);
    final typeLabel = type.isEmpty
        ? dmLocalized(identity['creatureType'], dmTypeLabels)
        : dmText(type['custom']).isNotEmpty
            ? dmText(type['custom'])
            : dmLocalized(type['value'], dmTypeLabels);
    final heading = [
      dmLocalized(identity['size'], dmSizeLabels),
      typeLabel,
      if (dmHasValue(type['subtype'])) '(${dmText(type['subtype'])})',
      if (dmHasValue(type['swarm']))
        'рой ${dmLocalized(type['swarm'], dmSizeLabels)}',
      dmLocalized(identity['alignment'], {
        'unaligned': 'без мировоззрения',
        'any': 'любое мировоззрение',
        'lawful evil': 'законно-злой',
        'lawful good': 'законно-добрый',
        'lawful neutral': 'законно-нейтральный',
        'neutral evil': 'нейтрально-злой',
        'neutral good': 'нейтрально-добрый',
        'neutral': 'нейтральный',
        'chaotic evil': 'хаотично-злой',
        'chaotic good': 'хаотично-добрый',
        'chaotic neutral': 'хаотично-нейтральный'
      })
    ].where((s) => s.isNotEmpty).join(' · ');
    final xp = dmNumber(dmMap(dmMap(context.system['details'])['xp'])['value']);
    final source = dmMap(identity['sourceBook']);
    final sourceText = source.isEmpty
        ? dmText(identity['sourceBook'])
        : [
            dmText(source['custom']),
            dmText(source['book']),
            if (dmHasValue(source['page'])) 'стр. ${dmText(source['page'])}'
          ].where((s) => s.isNotEmpty).join(' · ');
    rows[DmSection.identity] = [
      DmStatLine(
          'ПО',
          dmText(identity['challengeRating']).isEmpty
              ? '—'
              : dmText(identity['challengeRating'])),
      if (xp != null) DmStatLine('Опыт', '$xp'),
      if (sourceText.isNotEmpty) DmStatLine('Источник', sourceText),
    ];
    final movement = dmMap(combat['movement']);
    final speed = <String>[];
    for (final entry in {
      'walk': 'пешком',
      'burrow': 'копая',
      'climb': 'лазая',
      'fly': 'летая',
      'swim': 'плавая'
    }.entries) {
      final value = dmNumber(movement[entry.key]);
      if (value != null && (entry.key == 'walk' || value != 0)) {
        speed.add(
            '${entry.value} $value ${dmLocalized(movement['units'], dmUnitLabels)}'
                .trim());
      }
    }
    if (movement['hover'] == true) speed.add('парение');
    if (dmHasValue(movement['special'])) speed.add(dmText(movement['special']));
    rows[DmSection.combat] = [
      DmStatLine('КД', creature.armorClass?.toString() ?? '—'),
      if (dmHasValue(combat['armorClassSource']) &&
          combat['armorClassSource'] != 'default')
        DmStatLine(
            'Защита',
            dmLocalized(combat['armorClassSource'], {
              'natural': 'природный доспех',
              'flat': 'фиксированная КД',
              'custom': 'особая КД',
              'mage': 'магический доспех',
              'draconic': 'драконья защита',
              'unarmoredMonk': 'защита без доспеха монаха',
              'unarmoredBarb': 'защита без доспеха варвара',
            })),
      if (combat['armorClassSource'] == 'custom' &&
          dmReadableArmorFormula(combat['armorClassFormula']).isNotEmpty)
        DmStatLine(
            'Формула КД', dmReadableArmorFormula(combat['armorClassFormula'])),
      DmStatLine('HP', creature.hpMax?.toString() ?? '—'),
      if (dmHasValue(combat['hpFormula']))
        DmStatLine('Формула HP', dmText(combat['hpFormula'])),
      DmStatLine('Инициатива', dmSigned(creature.initiativeBonus)),
      DmStatLine('Скорость', speed.isEmpty ? '—' : speed.join('; ')),
      if (context.proficiency != null)
        DmStatLine('Бонус мастерства', dmSigned(context.proficiency)),
    ];
    final abilities = [
      for (final entry in dmAbilityLabels.entries)
        DmAbilityView(
            entry.value,
            dmText(dmMap(creature.abilities[entry.key])['score']).isEmpty
                ? '—'
                : dmText(dmMap(creature.abilities[entry.key])['score']),
            dmSigned(context.modifier(entry.key)))
    ];
    rows[DmSection.saves] = dmProficiencyLines(context);
    rows[DmSection.defenses] = [
      for (final entry in {
        'damageResistances': 'Сопротивления урону',
        'damageImmunities': 'Иммунитеты к урону',
        'damageVulnerabilities': 'Уязвимости',
        'conditionImmunities': 'Иммунитеты к состояниям'
      }.entries)
        if (dmTrait(
                creature.defenses[entry.key],
                entry.key == 'conditionImmunities'
                    ? dmConditionLabels
                    : dmDamageLabels)
            .isNotEmpty)
          DmStatLine(
              entry.value,
              dmTrait(
                  creature.defenses[entry.key],
                  entry.key == 'conditionImmunities'
                      ? dmConditionLabels
                      : dmDamageLabels)),
    ];
    rows[DmSection.senses] = _senses(context);
    rows[DmSection.resources] = dmResourceLines(context);
    final legendary = dmMap(creature.resources['legact']);
    if ((dmNumber(legendary['max']) ?? 0) > 0) {
      rows[DmSection.legendary] = [
        DmStatLine('Действия (макс.)', dmText(legendary['max'])),
        const DmStatLine('Восстановление', 'в начале своего хода'),
      ];
    }
    final resistance = dmMap(creature.resources['legres']);
    if ((dmNumber(resistance['max']) ?? 0) > 0) {
      final recovery = dmLegendaryResistanceRecovery(context);
      rows[DmSection.legendaryResistance] = [
        DmStatLine(
            'Легендарные сопротивления (макс.)', dmText(resistance['max'])),
        if (recovery != null)
          DmStatLine('Восстановление сопротивлений', recovery),
      ];
    }
    final lair = dmMap(creature.resources['lair']);
    if (lair['value'] == true) {
      rows[DmSection.lair] = [
        if (dmHasValue(lair['initiative']))
          DmStatLine('Инициатива логова', dmText(lair['initiative'])),
        const DmStatLine('Логово', 'см. описание существа'),
      ];
    }
    final occurrences = <String, int>{};
    final presentedItems = <DmItemView>[];
    for (var index = 0; index < creature.items.length; index++) {
      final item = creature.items[index];
      final sourceId = dmText(item.fields['sourceItemId']);
      final base = sourceId.isEmpty ? 'item-$index' : sourceId;
      final ordinal = occurrences.update(base, (v) => v + 1, ifAbsent: () => 0);
      final view = dmPresentItem(item, '$base:$ordinal', context);
      presentedItems.add(view);
      grouped.putIfAbsent(view.section, () => []).add(view);
    }
    final blocks = <DmBlockView>[];
    for (final section in DmSection.values) {
      final lines = rows[section] ?? const <DmStatLine>[];
      final items = grouped[section] ?? const <DmItemView>[];
      if ({
            DmSection.identity,
            DmSection.combat,
            DmSection.abilities,
            DmSection.senses
          }.contains(section) ||
          lines.isNotEmpty ||
          items.isNotEmpty) {
        blocks.add(DmBlockView(section,
            lines: List.unmodifiable(lines), items: List.unmodifiable(items)));
      }
    }
    return DmStatblock._(
        creature.name,
        heading,
        dmSafeImage(identity['tokenUrl']),
        List.unmodifiable(abilities),
        List.unmodifiable(blocks),
        dmMagicView(context, presentedItems));
  }
}

List<DmStatLine> _senses(DmStatContext context) {
  final senses = dmMap(context.creature.otherStats['senses']);
  final text = <String>[];
  for (final entry in {
    'darkvision': 'тёмное зрение',
    'blindsight': 'слепое зрение',
    'tremorsense': 'чувство вибрации',
    'truesight': 'истинное зрение'
  }.entries) {
    final distance = dmNumber(senses[entry.key]);
    if (distance != null && distance != 0) {
      text.add(
          '${entry.value} $distance ${dmLocalized(senses['units'], dmUnitLabels)}'
              .trim());
    }
  }
  if (dmHasValue(senses['special'])) text.add(dmText(senses['special']));
  final perception = dmMap(dmMap(context.creature.otherStats['skills'])['prc']);
  final passive = perception.isEmpty
      ? null
      : context.sum([
          10,
          context.skillTotal(perception),
          dmBonus(dmMap(perception['bonuses'])['passive'])
        ]);
  final languages =
      dmTrait(context.creature.otherStats['languages'], dmLanguageLabels);
  return [
    DmStatLine('Чувства', text.isEmpty ? '—' : text.join('; ')),
    if (passive != null) DmStatLine('Пассивное Восприятие', '$passive'),
    DmStatLine('Языки', languages.isEmpty ? '—' : languages)
  ];
}
