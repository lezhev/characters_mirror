import 'package:flutter/material.dart';

class JumpToDetailsButton extends StatefulWidget {
  const JumpToDetailsButton({
    super.key,
    required this.onPressed,
    required this.isVisible,
  });

  final VoidCallback onPressed;
  final bool isVisible;

  @override
  State<JumpToDetailsButton> createState() => _JumpToDetailsButtonState();
}

class _JumpToDetailsButtonState extends State<JumpToDetailsButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceController;
  late final Animation<double> _bounceOffset;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );
    _bounceOffset = Tween<double>(begin: 0, end: -4).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );
    if (widget.isVisible) _startAttentionBounce();
  }

  @override
  void didUpdateWidget(covariant JumpToDetailsButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _startAttentionBounce();
    }
  }

  void _startAttentionBounce() {
    _bounceController.repeat(reverse: true, count: 3);
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _bounceController,
      child: AnimatedOpacity(
        key: const ValueKey('creation-scroll-hint-opacity'),
        opacity: widget.isVisible ? 1 : 0,
        duration: const Duration(milliseconds: 180),
        child: IgnorePointer(
          ignoring: !widget.isVisible,
          child: Semantics(
            label: 'Прокрутить вниз',
            button: true,
            child: Material(
              color: colorScheme.surface.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(22),
              child: InkWell(
                key: const ValueKey('creation-scroll-hint'),
                onTap: widget.isVisible ? widget.onPressed : null,
                borderRadius: BorderRadius.circular(22),
                child: SizedBox(
                  width: 176,
                  height: 38,
                  child: Center(
                    child: CustomPaint(
                      size: const Size(28, 12),
                      painter: _DownChevronPainter(
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      builder: (context, child) => Transform.translate(
        offset: Offset(0, _bounceOffset.value),
        child: child,
      ),
    );
  }
}

class _DownChevronPainter extends CustomPainter {
  const _DownChevronPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(1, 2)
      ..lineTo(size.width / 2, size.height * 0.42)
      ..lineTo(size.width - 1, 2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _DownChevronPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
