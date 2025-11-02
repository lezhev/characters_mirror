import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddCharacterButton extends HookWidget {
  final VoidCallback onPressed;

  const AddCharacterButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);
    final colorScheme = Theme.of(context).colorScheme;

    final backgroundColor = isHovered.value
        ? colorScheme.primary
        : colorScheme.primary.withOpacity(0.92);

    final textColor = colorScheme.onPrimary;

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isHovered.value
              ? [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onPressed,
            splashColor: colorScheme.onPrimary.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, color: textColor),
                  const SizedBox(width: 8),
                  Text(
                    'Add Character',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
