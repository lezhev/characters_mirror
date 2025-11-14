import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PageSizeLimiter extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const PageSizeLimiter({
    required this.child,
    super.key,
    this.maxWidth = 1000.0,
  });

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return child;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;
          final contentWidth =
              availableWidth > maxWidth ? maxWidth : availableWidth;
          final sidePadding =
              availableWidth > maxWidth ? (availableWidth - maxWidth) / 2 : 0.0;

          return Row(
            children: [
              SizedBox(width: sidePadding),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentWidth),
                child: child,
              ),
              SizedBox(width: sidePadding),
            ],
          );
        },
      ),
    );
  }
}
