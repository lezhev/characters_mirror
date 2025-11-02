import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PageSizeLimiter extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const PageSizeLimiter({
    required this.child,
    this.maxWidth = 1000,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return child;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Container(
          color: Theme.of(context).colorScheme.surfaceBright,
          child: child,
        ),
      ),
    );
  }
}
