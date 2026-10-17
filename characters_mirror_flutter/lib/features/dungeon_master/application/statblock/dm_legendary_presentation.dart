import 'package:characters_mirror_shared/dungeon_master.dart';
import 'dm_statblock_context.dart';
import 'dm_statblock_models.dart';
import 'dm_statblock_values.dart';

DmSection? dmLinkedLegendarySection(
    NormalizedCreatureItem item, DmStatContext context) {
  if (item.itemType != 'feat') return null;
  final consume = dmMap(item.fields['consume']);
  if (consume['type'] == 'attribute' &&
      consume['target'] == 'resources.legres.value' &&
      (dmNumber(consume['amount']) ?? 0) > 0) {
    return DmSection.legendaryResistance;
  }
  if (!{'', 'none', 'special'}.contains(item.activationType ?? '')) return null;
  final text = _canonicalText(item.description);
  final name = _canonicalText(item.name);
  final resistance =
      dmNumber(dmMap(context.creature.resources['legres'])['max']);
  if (resistance != null &&
      resistance > 0 &&
      {
        'legendary resistance',
        'легендарная устойчивость',
        'легендарное сопротивление',
        'легендарные сопротивления'
      }.contains(name) &&
      ((text.contains('fails a saving throw') &&
              text.contains('succeed instead')) ||
          ((text.contains('проваливает испытание') ||
                  text.contains('проваливает спасбросок')) &&
              (text.contains('сделать его успешным') ||
                  text.contains('преуспеть'))))) {
    return DmSection.legendaryResistance;
  }
  final cap = dmNumber(dmMap(context.creature.resources['legact'])['max']);
  final hasActions =
      context.creature.items.any((i) => i.activationType == 'legendary');
  if (cap == null ||
      cap <= 0 ||
      !hasActions ||
      !{'legendary actions', 'легендарные действия'}.contains(name) ||
      !{'', 'none'}.contains(item.activationType ?? '')) {
    return null;
  }
  final count = cap == cap.roundToDouble() ? '${cap.toInt()}' : '$cap';
  final english = text.contains('$count legendary actions') &&
      text.contains("end of another creature's turn") &&
      text.contains('start of its turn');
  final russian = text.contains('$count легендарн') &&
      text.contains('конце хода другого существа') &&
      text.contains('начале своего хода');
  return english || russian ? DmSection.legendary : null;
}

String? dmLegendaryResistanceRecovery(DmStatContext context) {
  final linked = context.creature.items.where((i) =>
      dmLinkedLegendarySection(i, context) == DmSection.legendaryResistance);
  final recovery = <String>{};
  for (final item in linked) {
    final uses = dmMap(item.fields['uses']);
    final per = dmText(uses['per']);
    if ({'day', 'lr', 'sr'}.contains(per)) {
      recovery.add(switch (per) {
        'day' => 'за сутки',
        'lr' => 'после продолжительного отдыха',
        _ => 'после короткого отдыха'
      });
    } else {
      final text = _canonicalText(item.description);
      final cap = dmNumber(dmMap(context.creature.resources['legres'])['max']);
      if (cap != null &&
          (text.contains('${cap.toInt()} в день') ||
              text.contains('${cap.toInt()}/day'))) {
        recovery.add('за сутки');
      }
    }
  }
  return recovery.length == 1 ? recovery.single : null;
}

String _canonicalText(String text) => text
    .toLowerCase()
    .replaceAll('’', "'")
    .replaceAll(RegExp(r'\s+'), ' ')
    .trim();

DmLegendaryView dmLegendaryView(List<DmBlockView> blocks) {
  final metrics = <DmStatLine>[], periods = <String>[];
  final rules = <DmItemView>[], actions = <DmItemView>[];
  for (final block in blocks) {
    for (final line in block.lines.where((l) => l.label.endsWith('(макс.)'))) {
      final resistance = block.section == DmSection.legendaryResistance;
      final recovery =
          block.lines.where((l) => l.label == 'Восстановление сопротивлений');
      metrics.add(DmStatLine(
          resistance ? 'Сопротивления' : 'Легендарные действия', line.value));
      periods.add(!resistance
          ? 'за раунд'
          : recovery.isEmpty
              ? ''
              : recovery.first.value == 'за сутки'
                  ? 'в день'
                  : recovery.first.value);
    }
    for (final item in block.items) {
      final linkedRules = item.isLegendaryRules ||
          block.section == DmSection.legendaryResistance;
      (linkedRules && (item.description.isNotEmpty || item.summary.isNotEmpty)
              ? rules
              : actions)
          .add(item);
    }
  }
  return DmLegendaryView(List.unmodifiable(metrics), List.unmodifiable(periods),
      List.unmodifiable(rules), List.unmodifiable(actions));
}
