import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum ButtonVariant { filled, outlined, text }

class Button extends HookWidget {
  final VoidCallback onPressed;
  final double height;
  final double width;
  final String title;
  final ButtonVariant variant;
  final Widget? leading;
  final Widget? trailing;
  final Color? color;
  final Color? textColor;

  const Button._({
    required this.onPressed,
    required this.title,
    required this.variant,
    this.width = 152.0,
    this.height = 48.0,
    this.leading,
    this.trailing,
    this.color,
    this.textColor,
    super.key,
  });

  const Button.filled({
    required String title,
    required VoidCallback onPressed,
    double height = 48.0,
    double width = 152.0,
    Widget? leading,
    Widget? trailing,
    Color? color,
    Color? textColor,
    Key? key,
  }) : this._(
          title: title,
          onPressed: onPressed,
          height: height,
          width: width,
          variant: ButtonVariant.filled,
          leading: leading,
          trailing: trailing,
          color: color,
          textColor: textColor,
          key: key,
        );

  const Button.outlined({
    required String title,
    required VoidCallback onPressed,
    double height = 48.0,
    double width = 152.0,
    Widget? leading,
    Widget? trailing,
    Color? color,
    Color? textColor,
    Key? key,
  }) : this._(
          title: title,
          onPressed: onPressed,
          height: height,
          width: width,
          variant: ButtonVariant.outlined,
          leading: leading,
          trailing: trailing,
          color: color,
          textColor: textColor,
          key: key,
        );

  const Button.text({
    required String title,
    required VoidCallback onPressed,
    double height = 48.0,
    double width = 128.0,
    Widget? leading,
    Widget? trailing,
    Color? textColor,
    Key? key,
  }) : this._(
          title: title,
          onPressed: onPressed,
          height: height,
          width: width,
          variant: ButtonVariant.text,
          leading: leading,
          trailing: trailing,
          textColor: textColor,
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);
    final colorScheme = Theme.of(context).colorScheme;

    final bgColor = switch (variant) {
      ButtonVariant.filled => isHovered.value
          ? (color ?? colorScheme.primary)
          : (color ?? colorScheme.primary).withValues(alpha: 0.92),
      _ => Colors.transparent,
    };

    final border = switch (variant) {
      ButtonVariant.outlined => Border.all(
          color: isHovered.value
              ? (color ?? colorScheme.primary)
              : (color ?? colorScheme.primary).withValues(alpha: 0.7),
          width: 1.5,
        ),
      _ => null,
    };

    final txtColor = switch (variant) {
      ButtonVariant.filled => textColor ?? colorScheme.onPrimary,
      _ => textColor ?? color ?? colorScheme.primary,
    };

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: AnimatedContainer(
        width: width,
        height: height,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: border,
          boxShadow: variant == ButtonVariant.filled && isHovered.value
              ? [
                  BoxShadow(
                    color:
                        (color ?? colorScheme.primary).withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onPressed,
            splashColor: txtColor.withValues(alpha: 0.2),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leading != null) ...[leading!, const SizedBox(width: 24)],
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: txtColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (trailing != null) ...[
                    const SizedBox(width: 24),
                    trailing!
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
