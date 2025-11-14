import 'package:flutter/material.dart';

class ExpandableSection extends StatefulWidget {
  final bool expand;
  final Widget child;
  final Duration duration;

  const ExpandableSection({
    super.key,
    required this.expand,
    required this.child,
    this.duration = const Duration(milliseconds: 250),
  });

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> sizeAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    sizeAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );

    fadeAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );

    if (widget.expand) controller.value = 1;
  }

  @override
  void didUpdateWidget(covariant ExpandableSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.expand ? controller.forward() : controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: sizeAnimation,
      axisAlignment: -1,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: widget.child,
      ),
    );
  }
}
