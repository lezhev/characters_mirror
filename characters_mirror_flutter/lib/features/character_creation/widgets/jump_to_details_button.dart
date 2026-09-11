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

    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      child: const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 28,
      ),
    );
  }
}
