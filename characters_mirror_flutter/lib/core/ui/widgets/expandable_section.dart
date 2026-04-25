import 'package:flutter/material.dart';

class ExpandableSection extends StatefulWidget {
  final bool expand;
  final Widget child;
  final Duration duration;
  final double extraOffset;
  final bool autoScrollOnExpand;

  const ExpandableSection({
    super.key,
    this.extraOffset = 0,
    this.autoScrollOnExpand = true,
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
      controller.forward().whenComplete(() {
        if (mounted && widget.autoScrollOnExpand) {
          _scrollToBottom();
        }
      });
    } else if (!widget.expand && oldWidget.expand) {
      controller.reverse();
    }
  }

  void _scrollToBottom() {
    final context = _key.currentContext;
    if (!mounted || context == null || !context.mounted) return;

    final scrollable = Scrollable.of(context);
    if (!scrollable.mounted) return;

    final scrollableRenderObject = scrollable.context.findRenderObject();
    final renderObject = context.findRenderObject();
    if (scrollableRenderObject == null ||
        !scrollableRenderObject.attached ||
        renderObject is! RenderBox ||
        !renderObject.attached) {
      return;
    }

    final position = scrollable.position;

    final bottomOffset = renderObject
        .localToGlobal(
          Offset(0, renderObject.size.height),
          ancestor: scrollableRenderObject,
        )
        .dy;

    final viewportHeight = scrollable.context.size?.height;
    if (viewportHeight == null) return;

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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
