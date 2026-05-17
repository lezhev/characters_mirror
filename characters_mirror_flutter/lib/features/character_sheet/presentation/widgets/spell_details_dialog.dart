import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/material.dart';

Future<void> showSpellDetailsDialog(
  BuildContext context,
  SpellData spell,
) {
  return showDialog<void>(
    context: context,
    builder: (context) => SpellDetailsDialog(spell: spell),
  );
}

class SpellDetailsDialog extends StatelessWidget {
  const SpellDetailsDialog({
    required this.spell,
    super.key,
  });

  final SpellData spell;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final description = _normalizedText(spell.description);
    final higherLevel = _normalizedText(spell.higherLevel);

    return AlertDialog(
      title: Text(spellName(spell)),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _SpellInfoChip(label: spellLevelLabel(spell)),
                if (spell.schoolValue != null)
                  _SpellInfoChip(label: spellSchoolLabel(spell.schoolValue!)),
              ],
            ),
            const SizedBox(height: 12),
            SpellPrimaryMetadata(
              spell: spell,
              showHiddenLabels: true,
            ),
            if (description != null) ...[
              const SizedBox(height: 16),
              Text(description),
            ],
            if (higherLevel != null) ...[
              const SizedBox(height: 16),
              Text(
                'На высоких уровнях',
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: 6),
              Text(higherLevel),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Закрыть'),
        ),
      ],
    );
  }
}

class _SpellInfoChip extends StatelessWidget {
  const _SpellInfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          label,
          style: theme.textTheme.labelMedium,
        ),
      ),
    );
  }
}

class SpellPrimaryMetadata extends StatelessWidget {
  const SpellPrimaryMetadata({
    required this.spell,
    super.key,
    this.showHiddenLabels = false,
  });

  final SpellData spell;
  final bool showHiddenLabels;

  @override
  Widget build(BuildContext context) {
    final items = [
      if (_normalizedText(spell.castingTime) != null)
        SpellMetadataItem(
          icon: Icons.bolt,
          label: spellCastingTimeLabel(spell.castingTime!),
        ),
      if (_normalizedText(spell.range) != null)
        SpellMetadataItem(
          icon: Icons.swap_horiz,
          label: spell.range!.trim(),
        ),
      if (_normalizedText(spell.duration) != null)
        SpellMetadataItem(
          icon: Icons.hourglass_empty,
          label: spell.duration!.trim(),
        ),
      if (spell.concentration == true)
        SpellMetadataItem(
          icon: Icons.blur_on,
          label: 'Концентрация',
          showLabel: showHiddenLabels,
        ),
      if (spell.ritual == true)
        SpellMetadataItem(
          customIcon: const RitualIcon(),
          label: 'Ритуал',
          showLabel: showHiddenLabels,
        ),
    ];
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 14,
      runSpacing: 6,
      children: items,
    );
  }
}

class SpellMetadataItem extends StatelessWidget {
  const SpellMetadataItem({
    required this.label,
    super.key,
    this.icon,
    this.customIcon,
    this.showLabel = true,
  });

  final IconData? icon;
  final Widget? customIcon;
  final String label;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        customIcon ?? Icon(icon, size: 16, color: colorScheme.primary),
        if (showLabel) ...[
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

class SpellIconLegend extends StatelessWidget {
  const SpellIconLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      runSpacing: 8,
      children: const [
        SpellMetadataItem(
          icon: Icons.bolt,
          label: 'Время накладывания',
        ),
        SpellMetadataItem(
          icon: Icons.swap_horiz,
          label: 'Дистанция',
        ),
        SpellMetadataItem(
          icon: Icons.hourglass_empty,
          label: 'Длительность',
        ),
        SpellMetadataItem(
          icon: Icons.blur_on,
          label: 'Концентрация',
        ),
        SpellMetadataItem(
          customIcon: RitualIcon(),
          label: 'Ритуал',
        ),
      ],
    );
  }
}

class SpellResolutionText extends StatelessWidget {
  const SpellResolutionText({
    required this.label,
    super.key,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
    );
  }
}

class RitualIcon extends StatelessWidget {
  const RitualIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size.square(16),
      painter: _RitualIconPainter(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class _RitualIconPainter extends CustomPainter {
  const _RitualIconPainter({
    required this.color,
  });

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width / 9;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;

    canvas.drawCircle(center, radius, paint);

    final triangle = Path()
      ..moveTo(center.dx, size.height * 0.28)
      ..lineTo(size.width * 0.72, size.height * 0.68)
      ..lineTo(size.width * 0.28, size.height * 0.68)
      ..close();
    canvas.drawPath(triangle, paint);
  }

  @override
  bool shouldRepaint(_RitualIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

String spellName(SpellData spell) {
  return _normalizedText(spell.name) ??
      _normalizedText(spell.referenceKey) ??
      'Заклинание';
}

String? spellKey(SpellData? spell) {
  return _normalizedText(spell?.referenceKey) ?? _normalizedText(spell?.name);
}

String spellLevelLabel(SpellData spell) {
  final level = spell.level ?? 0;
  return level <= 0 ? 'Заговор' : '$level уровень';
}

String spellSchoolLabel(SpellSchool school) {
  switch (school) {
    case SpellSchool.abjuration:
      return 'Ограждение';
    case SpellSchool.conjuration:
      return 'Вызов';
    case SpellSchool.divination:
      return 'Прорицание';
    case SpellSchool.enchantment:
      return 'Очарование';
    case SpellSchool.evocation:
      return 'Воплощение';
    case SpellSchool.illusion:
      return 'Иллюзия';
    case SpellSchool.necromancy:
      return 'Некромантия';
    case SpellSchool.transmutation:
      return 'Преобразование';
  }
}

String spellCastingTimeLabel(String value) {
  final trimmed = value.trim();
  if (trimmed.toLowerCase().startsWith('реакция')) {
    return 'Реакция';
  }
  return trimmed;
}

String? spellResolutionLabel(SpellData spell) {
  if (spell.requiresAttackRoll == true) {
    return 'Атака';
  }
  if (spell.requiresSavingThrow == true) {
    final ability = savingThrowAbilityLabel(spell.savingThrowAbility);
    return ability == null ? 'Спасбросок' : '$ability спасбросок';
  }
  return null;
}

String? savingThrowAbilityLabel(String? value) {
  switch (_normalizedText(value)?.toLowerCase()) {
    case 'strength':
    case 'str':
    case 'сила':
      return 'STR';
    case 'dexterity':
    case 'dex':
    case 'ловкость':
      return 'DEX';
    case 'constitution':
    case 'con':
    case 'телосложение':
      return 'CON';
    case 'intelligence':
    case 'int':
    case 'интеллект':
      return 'INT';
    case 'wisdom':
    case 'wis':
    case 'мудрость':
      return 'WIS';
    case 'charisma':
    case 'cha':
    case 'харизма':
      return 'CHA';
  }
  return _normalizedText(value);
}

String? _normalizedText(String? value) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}
