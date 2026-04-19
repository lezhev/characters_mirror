import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    this.title,
    super.key,
    this.titleStyle,
    this.spacing = 4,
    this.showDivider = true,
    this.dividerColor,
    this.trailing,
  });

  final String? title;
  final TextStyle? titleStyle;
  final double spacing;
  final bool showDivider;
  final Color? dividerColor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title ?? '',
                style: titleStyle ?? theme.textTheme.headlineSmall,
              ),
            ),
            if (trailing != null) ...[
              const Gap(8),
              trailing!,
            ],
          ],
        ),
        if (showDivider) ...[
          Gap(spacing),
          Container(
            width: double.infinity,
            height: 2,
            color: dividerColor ?? theme.colorScheme.primary,
          ),
        ],
      ],
    );
  }
}
