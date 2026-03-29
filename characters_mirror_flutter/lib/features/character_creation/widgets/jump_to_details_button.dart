import 'package:flutter/material.dart';

class JumpToDetailsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const JumpToDetailsButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      minimum: const EdgeInsets.only(right: 16, bottom: 16),
      child: Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 6,
            minimumSize: const Size(52, 52),
            padding: EdgeInsets.zero,
            shape: const CircleBorder(),
            backgroundColor: colorScheme.surfaceContainerHighest,
            foregroundColor: colorScheme.onSurface,
            shadowColor: colorScheme.shadow,
            side: BorderSide(color: colorScheme.outline),
          ),
          child: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 28,
          ),
        ),
      ),
    );
  }
}
