import 'package:flutter/material.dart';

class SavingThrowProficiencyToggle extends StatelessWidget {
  static const double size = 36;

  const SavingThrowProficiencyToggle({
    required this.value,
    required this.onChanged,
    super.key,
    this.activeSemanticLabel = 'Владение спасброском включено',
    this.inactiveSemanticLabel = 'Владение спасброском выключено',
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String activeSemanticLabel;
  final String inactiveSemanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final borderColor = value
        ? colorScheme.primary
        : colorScheme.outline.withValues(alpha: 0.8);
    final dotColor = value ? colorScheme.primary : Colors.transparent;

    return Semantics(
      button: true,
      label: value ? activeSemanticLabel : inactiveSemanticLabel,
      child: InkResponse(
        onTap: () => onChanged(!value),
        radius: 24,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: borderColor,
                  width: value ? 1.5 : 1.2,
                ),
              ),
              alignment: Alignment.center,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: dotColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
