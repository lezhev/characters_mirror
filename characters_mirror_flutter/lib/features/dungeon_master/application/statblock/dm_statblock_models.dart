enum DmSection {
  identity('Существо'),
  combat('Боевые параметры'),
  abilities('Характеристики'),
  saves('Спасброски и навыки'),
  defenses('Защита'),
  senses('Чувства и языки'),
  traits('Особенности'),
  actions('Действия'),
  bonus('Бонусные действия'),
  reactions('Реакции'),
  legendary('Легендарные действия'),
  legendaryResistance('Легендарные сопротивления'),
  mythic('Мифические действия'),
  lair('Действия логова'),
  regional('Региональные эффекты'),
  spells('Заклинания'),
  resources('Ресурсы'),
  equipment('Снаряжение'),
  other('Прочее');

  const DmSection(this.title);
  final String title;
}

class DmStatLine {
  const DmStatLine(this.label, this.value);
  final String label, value;
  String get text => '$label: $value';
}

class DmAbilityView {
  const DmAbilityView(this.label, this.score, this.modifier);
  final String label, score, modifier;
}

class DmItemView {
  const DmItemView(
      {required this.id,
      required this.name,
      required this.section,
      required this.summary,
      required this.description,
      required this.lines,
      this.displayLines,
      this.costLabel,
      this.isLegendaryRules = false});
  final String id, name, summary, description;
  final DmSection section;
  final List<DmStatLine> lines;
  final List<DmStatLine>? displayLines;
  final String? costLabel;
  final bool isLegendaryRules;
}

class DmBlockView {
  const DmBlockView(this.section,
      {this.lines = const [], this.items = const []});
  final DmSection section;
  final List<DmStatLine> lines;
  final List<DmItemView> items;
}

class DmVisualGroup {
  const DmVisualGroup(this.id, this.title, this.blocks,
      {this.magic, this.legendary});
  final String id, title;
  final List<DmBlockView> blocks;
  final DmMagicView? magic;
  final DmLegendaryView? legendary;
}

class DmLegendaryView {
  const DmLegendaryView(this.metrics, this.periods, this.rules, this.actions);
  final List<DmStatLine> metrics;
  final List<String> periods;
  final List<DmItemView> rules, actions;
}

class DmSpellGroup {
  const DmSpellGroup(this.id, this.title, this.usage, this.items);
  final String id, title, usage;
  final List<DmItemView> items;
}

class DmMagicView {
  const DmMagicView(
      {required this.header,
      required this.rules,
      required this.spells,
      required this.resourceLabels});
  final List<DmStatLine> header;
  final List<DmItemView> rules;
  final List<DmSpellGroup> spells;
  // Only resources with a visible, corresponding spell group are relocated.
  final Set<String> resourceLabels;
}
