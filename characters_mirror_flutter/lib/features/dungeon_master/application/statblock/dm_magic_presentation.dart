import 'package:characters_mirror_shared/dungeon_master.dart';
import 'dm_resource_presentation.dart';
import 'dm_statblock_context.dart';
import 'dm_statblock_labels.dart';
import 'dm_statblock_models.dart';
import 'dm_statblock_values.dart';

/// Groups structured spell metadata only. Descriptions remain opaque text.
DmMagicView? dmMagicView(DmStatContext context, List<DmItemView> items) {
  final sources = context.creature.items;
  final spellIndexes = [
    for (var i = 0; i < sources.length; i++)
      if (sources[i].itemType == 'spell') i
  ];
  if (spellIndexes.isEmpty) return null;
  final caps = dmSpellSlotCaps(context);
  final groups = <String, List<DmItemView>>{};
  final titles = <String, String>{}, usages = <String, String>{};
  final relocated = <String>{};
  final modes = <String>{};
  for (final index in spellIndexes) {
    final spell = sources[index];
    final mode = _mode(spell);
    modes.add(mode);
    final level = spell.spellLevel;
    final validLevel = level != null && level >= 0 && level <= 9;
    final circle = level == 0
        ? 'Заговоры'
        : validLevel
            ? '$level-й круг'
            : 'Уровень не указан';
    final uses = dmMap(spell.fields['uses']);
    final max = dmText(uses['max']);
    final limited = _limited(spell);
    var usage = limited
        ? '$max${dmHasValue(uses['per']) ? ' / ${dmLocalized(uses['per'], dmRecoveryLabels)}' : ''}'
        : '';
    final category = switch (mode) {
      'standard' => '',
      'atwill' => 'Неограниченное применение',
      'innate' => 'Врождённые',
      'pact' => 'Магия договора',
      'limited' => 'Ограниченное применение',
      _ => 'Особое применение',
    };
    final resource = _linkedResource(spell, context);
    if (resource != null) {
      final consume = dmMap(spell.fields['consume']);
      usage =
          '${resource.value} (макс.)${dmHasValue(consume['amount']) ? ' · расход ${dmText(consume['amount'])}' : ''}${usage.isEmpty ? '' : ' · $usage'}';
      relocated.add(resource.label);
    }
    if (!limited) {
      if (mode == 'atwill' || (mode == 'standard' && level == 0)) {
        usage = 'Неограниченно';
      } else if (mode == 'standard' && validLevel && level > 0) {
        final cap = caps['spell$level'];
        if (cap != null) {
          usage = dmSlotCount(cap);
          relocated.add(dmSlotLabel(level));
        }
      } else if (mode == 'pact' && caps['pact'] != null) {
        final pactLevel = dmPactLevel(context);
        usage =
            '${dmSlotCount(caps['pact']!)}${pactLevel == null ? '' : ' · $pactLevel-й круг ячеек'}';
        relocated.add('Ячейки магии договора (макс.)');
      }
    }
    final id = '$mode:${mode == 'pact' ? '' : level}:$usage';
    groups.putIfAbsent(id, () => []).add(items[index]);
    titles[id] = [category, if (mode != 'pact') circle]
        .where((v) => v.isNotEmpty)
        .join(' · ');
    usages[id] = usage;
  }
  final rules = <DmItemView>[];
  // A full title alone is insufficient: require a passive feat, an actor's
  // casting ability, and a matching explicit spell mode. Ambiguous duplicates
  // and text-only casters retain their existing primary feature location.
  if (dmAbilityLabels.containsKey(context.casting) &&
      context.modifier(context.casting) != null) {
    for (final kind in ['standard', 'innate']) {
      if (!modes.contains(kind)) continue;
      if (kind == 'standard' &&
          (dmNumber(dmMap(context.system['details'])['spellLevel']) ?? 0) <=
              0) {
        continue;
      }
      final candidates = [
        for (var i = 0; i < sources.length; i++)
          if (_rulesKind(sources[i]) == kind &&
              items[i].section == DmSection.traits)
            items[i]
      ];
      if (candidates.length == 1) rules.add(candidates.single);
    }
  }
  final ability = context.casting;
  final known = dmAbilityLabels.containsKey(ability);
  final dc = known
      ? context.sum([
          8,
          context.modifier(ability),
          context.proficiency,
          dmBonus(dmMap(context.global['spell'])['dc'])
        ])
      : null;
  num? attack(String type) => known
      ? context.sum([
          context.modifier(ability),
          context.proficiency,
          context.additiveBonus(dmMap(context.global[type])['attack'],
              ability: ability)
        ])
      : null;
  final melee = attack('msak'), ranged = attack('rsak');
  final keys = groups.keys.toList()
    ..sort((a, b) {
      final ma = a.split(':').first, mb = b.split(':').first;
      const order = [
        'standard',
        'atwill',
        'limited',
        'innate',
        'pact',
        'other'
      ];
      final modeOrder = order.indexOf(ma).compareTo(order.indexOf(mb));
      if (modeOrder != 0) return modeOrder;
      final la = int.tryParse(a.split(':')[1]) ?? 99,
          lb = int.tryParse(b.split(':')[1]) ?? 99;
      return la.compareTo(lb);
    });
  return DmMagicView(
    header: List.unmodifiable([
      if (known) DmStatLine('Характеристика', dmAbilityLabels[ability]!),
      if (dc != null) DmStatLine('СЛ заклинаний', '$dc'),
      if (melee != null && melee == ranged)
        DmStatLine('Бонус атаки', dmSigned(melee)),
    ]),
    rules: List.unmodifiable(rules),
    spells: List.unmodifiable([
      for (final key in keys)
        DmSpellGroup(
            key, titles[key]!, usages[key]!, List.unmodifiable(groups[key]!))
    ]),
    resourceLabels: Set.unmodifiable(relocated),
  );
}

bool _limited(NormalizedCreatureItem item) {
  final max = dmMap(item.fields['uses'])['max'];
  return dmHasValue(max) && (dmNumber(max) == null || dmNumber(max)! > 0);
}

String _mode(NormalizedCreatureItem item) {
  final mode = dmText(
      dmMap(dmMap(item.fields['spellProperties'])['preparation'])['mode']);
  final consume = dmMap(item.fields['consume']);
  // Linked charges/attributes can override a preparation default. Never assign
  // them a normal slot just because their spell level is known.
  if (dmHasValue(consume['type'])) return 'other';
  if (mode == 'innate' || mode == 'pact') return mode;
  if (_limited(item)) return 'limited';
  if (mode == 'atwill') return 'atwill';
  if ({'prepared', 'always'}.contains(mode)) return 'standard';
  return 'other';
}

DmStatLine? _linkedResource(
    NormalizedCreatureItem spell, DmStatContext context) {
  final consume = dmMap(spell.fields['consume']);
  final path = dmText(consume['target']).split('.');
  if (consume['type'] != 'attribute' ||
      path.length != 3 ||
      path[0] != 'resources' ||
      path[2] != 'value' ||
      {'legact', 'legres', 'lair'}.contains(path[1])) {
    return null;
  }
  final resource = dmMap(context.creature.resources[path[1]]);
  final label = dmText(resource['label']), max = dmNumber(resource['max']);
  if (label.isEmpty || max == null || max < 0) return null;
  return DmStatLine('$label (макс.)', '$label: $max');
}

String? _rulesKind(NormalizedCreatureItem item) {
  if (item.itemType != 'feat' ||
      !{'', 'none'}.contains(item.activationType ?? '') ||
      dmHasValue(dmMap(item.fields['consume'])['type']) ||
      {'mwak', 'rwak', 'msak', 'rsak', 'save', 'heal'}
          .contains(item.fields['actionType'])) {
    return null;
  }
  return switch (item.name.trim().toLowerCase()) {
    'spellcasting' || 'заклинания' || 'использование заклинаний' => 'standard',
    'innate spellcasting' ||
    'врождённое колдовство' ||
    'врождённые заклинания' =>
      'innate',
    _ => null,
  };
}

String dmSlotCount(num count) =>
    '$count ${count == 1 ? 'ячейка' : count >= 2 && count <= 4 ? 'ячейки' : 'ячеек'}';
