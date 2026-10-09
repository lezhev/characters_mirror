import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpellHighlightView extends StatelessWidget {
  const SpellHighlightView({required this.highlight, this.style, super.key});

  final SpellHighlight highlight;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final h = highlight;
    if (h.kind == SpellHighlightKind.healing) {
      return Semantics(
        container: true,
        label: '${h.label}: ${h.value}',
        excludeSemantics: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/svg/heal.svg',
              key: const ValueKey('spell-healing-icon'),
              width: 18,
              height: 18,
              excludeFromSemantics: true,
            ),
            const SizedBox(width: 6),
            if (h.label != 'Лечение') Text('${h.label}: ', style: style),
            Flexible(child: Text(h.value, style: style)),
          ],
        ),
      );
    }
    if (h.kind != SpellHighlightKind.damage || h.damageParts.isEmpty) {
      return Text('${h.label}: ${h.value}', style: style);
    }
    final separate = h.damageParts.any((part) => part.notes != null);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (h.label != 'Урон') Text('${h.label}:', style: style),
        for (var index = 0; index < h.damageParts.length; index++) ...[
          if (index > 0) Text(separate ? ';' : '+', style: style),
          _DamagePartView(part: h.damageParts[index], style: style),
        ],
      ],
    );
  }
}

class _DamagePartView extends StatelessWidget {
  const _DamagePartView({required this.part, this.style});
  final SpellDamageHighlight part;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final type =
        DamageType.values.where((t) => t.name == part.damageType).firstOrNull;
    final value =
        '${part.formula}${part.notes == null ? '' : ' — ${part.notes}'}';
    if (type == null) return Text('Урон: $value', style: style);
    final label = switch (type) {
      DamageType.acid => 'Урон кислотой',
      DamageType.bludgeoning => 'Дробящий урон',
      DamageType.cold => 'Урон холодом',
      DamageType.fire => 'Урон огнём',
      DamageType.force => 'Силовой урон',
      DamageType.lightning => 'Урон электричеством',
      DamageType.necrotic => 'Некротический урон',
      DamageType.piercing => 'Колющий урон',
      DamageType.poison => 'Урон ядом',
      DamageType.psychic => 'Психический урон',
      DamageType.radiant => 'Урон излучением',
      DamageType.slashing => 'Рубящий урон',
      DamageType.thunder => 'Урон громом',
    };
    return Semantics(
      container: true,
      label: '$label: $value',
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/svg/damage_types/${type.name}.svg',
            key: ValueKey('damage-type-icon-${type.name}'),
            width: 18,
            height: 18,
            excludeFromSemantics: true,
          ),
          const SizedBox(width: 6),
          Flexible(child: Text(value, style: style)),
        ],
      ),
    );
  }
}
