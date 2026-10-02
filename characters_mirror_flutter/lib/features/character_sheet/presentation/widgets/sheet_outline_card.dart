import 'package:flutter/material.dart';

class SheetOutlineCard extends StatelessWidget {
  const SheetOutlineCard({
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(12),
    this.borderRadius = 12,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      side: BorderSide(color: Theme.of(context).colorScheme.outline),
      borderRadius: BorderRadius.circular(borderRadius),
    );

    return Material(
      color: Colors.transparent,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
