import 'package:flutter/material.dart';

class CompactValueButton extends StatelessWidget {
  const CompactValueButton({
    required this.label,
    super.key,
    this.onPressed,
    this.width,
  });

  final String label;
  final VoidCallback? onPressed;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final button = OutlinedButton(
      onPressed: onPressed ?? () {},
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );

    if (onPressed != null) {
      return width == null ? button : SizedBox(width: width, child: button);
    }

    return IgnorePointer(
      child: width == null ? button : SizedBox(width: width, child: button),
    );
  }
}
