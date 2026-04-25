import 'package:flutter/material.dart';

class DragBox extends StatelessWidget {
  final int value;

  final bool isDragging;

  const DragBox(this.value, {super.key, required this.isDragging});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: isDragging
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.8)
            : Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          value.toString(),
          style: textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
