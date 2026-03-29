import 'package:flutter/material.dart';

class SmoothSwitcher extends StatefulWidget {
  final Widget? child;
  final Duration duration;

  final double extraOffset;

  const SmoothSwitcher({
    this.extraOffset = 0,
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 220),
  });

  @override
  State<SmoothSwitcher> createState() => _SmoothSwitcherState();
}

class _SmoothSwitcherState extends State<SmoothSwitcher>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _fade;
  late Animation<double> _size;

  Widget? _currentChild;
  final _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: widget.duration);
    _fade = CurvedAnimation(parent: _c, curve: Curves.easeInOut);
    _size = CurvedAnimation(parent: _c, curve: Curves.easeInOut);

    _currentChild = widget.child;
    _c.value = 1;
  }

  @override
  void didUpdateWidget(covariant SmoothSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.child?.key != oldWidget.child?.key) {
      _c.reverse().then((_) {
        setState(() => _currentChild = widget.child);

        _c.forward().whenComplete(_scrollToBottom);
      });
    }
  }

  void _scrollToBottom() {
    final ctx = _key.currentContext;
    if (ctx == null) return;

    final scrollable = Scrollable.of(ctx);

    final position = scrollable.position;
    final renderBox = ctx.findRenderObject() as RenderBox;

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
    return KeyedSubtree(
      key: _key,
      child: ClipRect(
        child: FadeTransition(
          opacity: _fade,
          child: AnimatedBuilder(
            animation: _size,
            builder: (context, child) {
              final t = _size.value;

              return Padding(
                padding: EdgeInsets.only(bottom: (1 - t) * 8),
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: t.clamp(0.0, 1.0),
                  child: child,
                ),
              );
            },
            child: _currentChild,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }
}
