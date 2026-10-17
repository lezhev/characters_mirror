import 'dm_statblock_models.dart';
import 'dm_legendary_presentation.dart';

List<DmVisualGroup> dmVisualGroups(List<DmBlockView> blocks,
    {DmMagicView? magic}) {
  final groups = <String, List<DmBlockView>>{};
  final titles = <String, String>{};
  final ruleIds = magic?.rules.map((i) => i.id).toSet() ?? <String>{};
  for (final block in blocks) {
    final visual = DmBlockView(block.section,
        lines: block.section == DmSection.resources
            ? List.unmodifiable(block.lines.where(
                (l) => !(magic?.resourceLabels.contains(l.label) ?? false)))
            : block.lines,
        items: block.section == DmSection.spells
            ? List.unmodifiable([...?magic?.rules, ...block.items])
            : List.unmodifiable(
                block.items.where((i) => !ruleIds.contains(i.id))));
    if (visual.lines.isEmpty &&
        visual.items.isEmpty &&
        !{
          DmSection.identity,
          DmSection.combat,
          DmSection.abilities,
          DmSection.senses
        }.contains(block.section)) {
      continue;
    }
    final (id, title) = switch (block.section) {
      DmSection.identity ||
      DmSection.combat ||
      DmSection.abilities ||
      DmSection.saves =>
        ('core', ''),
      DmSection.defenses || DmSection.senses => (
          'awareness',
          'Защита, чувства и языки'
        ),
      DmSection.legendary || DmSection.legendaryResistance => (
          'legendary',
          'Легендарные возможности'
        ),
      _ => (block.section.name, block.section.title),
    };
    groups.putIfAbsent(id, () => []).add(visual);
    titles[id] = title;
  }
  return List.unmodifiable([
    for (final entry in groups.entries)
      DmVisualGroup(
          entry.key,
          titles[entry.key]!,
          List.unmodifiable([
            for (final block in entry.value)
              block.section != DmSection.legendary
                  ? block
                  : DmBlockView(block.section,
                      lines: block.lines,
                      items: List.unmodifiable([
                        ...block.items.where((i) => i.isLegendaryRules),
                        ...block.items.where((i) => !i.isLegendaryRules),
                      ])),
          ]),
          magic: entry.key == 'spells' ? magic : null,
          legendary:
              entry.key == 'legendary' ? dmLegendaryView(entry.value) : null)
  ]);
}
