import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CharacterTileMenuButton extends StatelessWidget {
  const CharacterTileMenuButton({
    required this.isDeleteArmed,
    required this.isDeleting,
    super.key,
    this.onDeleteIntent,
    this.onMenuDismissed,
    this.onDeleteConfirm,
  });

  final bool isDeleteArmed;
  final bool isDeleting;
  final VoidCallback? onDeleteIntent;
  final VoidCallback? onMenuDismissed;
  final VoidCallback? onDeleteConfirm;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (isDeleting) {
      return SizedBox(
        width: 40,
        height: 40,
        child: Center(
          child: SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: colorScheme.primary,
            ),
          ),
        ),
      );
    }

    return MenuAnchor(
      onClose: onMenuDismissed,
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.surfaceContainerHigh,
        ),
        side: WidgetStatePropertyAll(
          BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
      ),
      menuChildren: [
        MenuItemButton(
          closeOnActivate: isDeleteArmed,
          onPressed: () {
            if (isDeleteArmed) {
              onDeleteConfirm?.call();
              return;
            }

            onDeleteIntent?.call();
          },
          child: Row(
            children: [
              Icon(
                Icons.delete_outline,
                size: 20,
                color: colorScheme.error,
              ),
              const Gap(12),
              Text(
                isDeleteArmed ? 'Точно удалить?' : 'Удалить',
                style: TextStyle(color: colorScheme.error),
              ),
            ],
          ),
        ),
      ],
      builder: (context, controller, child) {
        return IconButton(
          tooltip: 'Действия',
          splashRadius: 18,
          visualDensity: VisualDensity.compact,
          padding: const EdgeInsets.all(4),
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
              return;
            }

            controller.open();
          },
          icon: const Icon(Icons.more_vert),
        );
      },
    );
  }
}
