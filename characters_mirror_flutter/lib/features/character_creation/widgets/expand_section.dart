import 'package:flutter/material.dart';

class ExpandableSection extends StatefulWidget {
  final bool expand;
  final Widget child;
  final Duration duration;

  final double extraOffset;

  const ExpandableSection({
    super.key,
    this.extraOffset = 0,
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

  final _key = GlobalKey();

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

    if (widget.expand && !oldWidget.expand) {
      controller.forward().whenComplete(_scrollToBottom);
    } else if (!widget.expand && oldWidget.expand) {
      controller.reverse();
    }
  }

  void _scrollToBottom() {
    final context = _key.currentContext;
    if (context == null) return;

    final scrollable = Scrollable.of(context);

    final position = scrollable.position;

    final renderBox = context.findRenderObject() as RenderBox;

    // Находим нижнюю точку секции относительно Scrollable
    final bottomOffset = renderBox
        .localToGlobal(
          Offset(0, renderBox.size.height),
          ancestor: scrollable.context.findRenderObject(),
        )
        .dy;

    final viewportHeight = scrollable.context.size!.height;

    if (bottomOffset > viewportHeight) {
      final diff = bottomOffset - viewportHeight;
      position.animateTo(
        (position.pixels + diff + widget.extraOffset)
            .clamp(position.minScrollExtent, position.maxScrollExtent),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: sizeAnimation,
      axisAlignment: -1,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: KeyedSubtree(
          key: _key,
          child: widget.child,
        ),
      ),
    );
  }
}
