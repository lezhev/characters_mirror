import 'package:flutter/material.dart';

import 'page_size_limiter.dart';

class PageSizeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PageSizeAppBar({
    required this.title,
    this.leading,
    this.actions = const [],
    this.maxWidth = 1000,
    this.automaticallyImplyLeading = true,
    super.key,
  });

  final Widget title;
  final Widget? leading;
  final List<Widget> actions;
  final double maxWidth;
  final bool automaticallyImplyLeading;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final showBackButton = leading == null &&
        automaticallyImplyLeading &&
        (ModalRoute.of(context)?.canPop ?? false);

    return Material(
      color: colorScheme.surfaceContainerHigh,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: kToolbarHeight,
          child: PageSizeLimiter(
            maxWidth: maxWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  if (leading != null || showBackButton)
                    SizedBox(
                      width: 48,
                      child: leading ?? const BackButton(),
                    )
                  else
                    const SizedBox(width: 8),
                  Expanded(
                    child: DefaultTextStyle(
                      style: Theme.of(context).appBarTheme.titleTextStyle ??
                          Theme.of(context).textTheme.titleLarge!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      child: title,
                    ),
                  ),
                  if (actions.isNotEmpty) ...[
                    for (final action in actions) action,
                    const SizedBox(width: 8),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
