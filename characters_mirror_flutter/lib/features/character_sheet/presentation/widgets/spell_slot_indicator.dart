import 'package:flutter/material.dart';

enum SpellSlotVariant { standard, pact }

class SpellSlotIndicator extends StatelessWidget {
  const SpellSlotIndicator({
    required this.value,
    required this.level,
    this.variant = SpellSlotVariant.standard,
    this.onPressed,
    super.key,
  });

  final bool value;
  final int level;
  final SpellSlotVariant variant;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final pact = variant == SpellSlotVariant.pact;
    final color = pact ? scheme.secondary : scheme.primary;
    final shape = pact ? BoxShape.rectangle : BoxShape.circle;
    final label = '${pact ? 'Ячейка магии договора' : 'Ячейка заклинания'} '
        '$level круга, ${value ? 'доступна' : 'использована'}';
    return Semantics(
      label: label,
      button: onPressed != null,
      selected: value,
      child: InkWell(
        customBorder:
            pact ? const RoundedRectangleBorder() : const CircleBorder(),
        onTap: onPressed,
        child: SizedBox.square(
          dimension: 22,
          child: Center(
            child: SizedBox.square(
              dimension: 18,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    shape: shape, border: Border.all(color: color)),
                child: value
                    ? Center(
                        child: SizedBox.square(
                        dimension: 10,
                        child: DecoratedBox(
                            decoration:
                                BoxDecoration(shape: shape, color: color)),
                      ))
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
