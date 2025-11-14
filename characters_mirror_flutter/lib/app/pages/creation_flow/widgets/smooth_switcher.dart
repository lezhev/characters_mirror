import 'package:flutter/material.dart';

class SmoothSwitcher extends StatefulWidget {
  final Widget? child;
  final Duration duration;

  const SmoothSwitcher({
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

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: widget.duration);
    _fade = CurvedAnimation(parent: _c, curve: Curves.easeInOut);
    _size = CurvedAnimation(parent: _c, curve: Curves.easeInOut);

    _currentChild = widget.child;
    _c.value = 1; // стартуем в "показанном" состоянии
  }

  @override
  void didUpdateWidget(covariant SmoothSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.child?.key != oldWidget.child?.key) {
      // Сначала скрываем старый
      _c.reverse().then((_) {
        // Меняем child
        setState(() => _currentChild = widget.child);
        // И показываем новый
        _c.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: FadeTransition(
        opacity: _fade,
        child: SizeTransition(
          sizeFactor: _size,
          axisAlignment: -1,
          child: _currentChild,
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
