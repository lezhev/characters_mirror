import 'dm_statblock_context.dart';
import 'dm_statblock_models.dart';
import 'dm_statblock_values.dart';

List<DmStatLine> dmResourceLines(DmStatContext context) {
  final result = <DmStatLine>[];
  for (final entry in context.creature.resources.entries) {
    if ({'legact', 'legres', 'lair'}.contains(entry.key)) continue;
    final resource = dmMap(entry.value);
    final max = dmText(resource['max']);
    final label = dmText(resource['label']);
    if (max.isEmpty || (dmNumber(max) == 0 && label.isEmpty)) continue;
    if (label.isNotEmpty) {
      result.add(DmStatLine('$label (макс.)', max));
    }
  }
  final caps = dmSpellSlotCaps(context);
  for (var circle = 1; circle <= 9; circle++) {
    final max = caps['spell$circle'];
    if (max != null) result.add(DmStatLine(dmSlotLabel(circle), '$max'));
  }
  final pactMax = caps['pact'];
  if (pactMax != null) {
    final pactLevel = dmPactLevel(context);
    result.add(DmStatLine('Ячейки магии договора (макс.)',
        '$pactMax${pactLevel == null ? '' : ' · уровень $pactLevel'}'));
  }
  return result;
}

String dmSlotLabel(int circle) => 'Ячейки $circle-го уровня (макс.)';

Map<String, num> dmSpellSlotCaps(DmStatContext context) {
  final result = <String, num>{};
  final level = dmNumber(dmMap(context.system['details'])['spellLevel']);
  final slots = level != null &&
          level == level.roundToDouble() &&
          level >= 1 &&
          level <= 20
      ? _slotTable[level.toInt() - 1]
      : null;
  for (var circle = 1; circle <= 9; circle++) {
    final data = dmMap(context.creature.spellSlots['spell$circle']);
    final override = dmNumber(data['override']);
    final explicit = override ?? dmNumber(data['max']);
    final max = explicit ??
        (slots != null
            ? circle <= slots.length
                ? slots[circle - 1]
                : 0
            : null);
    if (max == null || max < 0 || (max == 0 && explicit == null)) continue;
    result['spell$circle'] = max;
  }
  final pact = dmMap(context.creature.spellSlots['pact']);
  final pactMax = dmNumber(pact['override']) ?? dmNumber(pact['max']);
  if (pactMax != null && pactMax > 0) {
    result['pact'] = pactMax;
  }
  return result;
}

num? dmPactLevel(DmStatContext context) {
  final level = dmNumber(dmMap(context.system['details'])['spellLevel']);
  return dmNumber(dmMap(context.creature.spellSlots['pact'])['level']) ??
      (level != null && level > 0
          ? ((level > 10 ? 10 : level) / 2).ceil()
          : null);
}

// D&D 2014 full caster progression, used by Foundry NPC details.spellLevel.
// A slot's exported `value` is current state and is never treated as its cap.
const _slotTable = <List<int>>[
  [2],
  [3],
  [4, 2],
  [4, 3],
  [4, 3, 2],
  [4, 3, 3],
  [4, 3, 3, 1],
  [4, 3, 3, 2],
  [4, 3, 3, 3, 1],
  [4, 3, 3, 3, 2],
  [4, 3, 3, 3, 2, 1],
  [4, 3, 3, 3, 2, 1],
  [4, 3, 3, 3, 2, 1, 1],
  [4, 3, 3, 3, 2, 1, 1],
  [4, 3, 3, 3, 2, 1, 1, 1],
  [4, 3, 3, 3, 2, 1, 1, 1],
  [4, 3, 3, 3, 2, 1, 1, 1, 1],
  [4, 3, 3, 3, 3, 1, 1, 1, 1],
  [4, 3, 3, 3, 3, 2, 1, 1, 1],
  [4, 3, 3, 3, 3, 2, 2, 1, 1],
];
