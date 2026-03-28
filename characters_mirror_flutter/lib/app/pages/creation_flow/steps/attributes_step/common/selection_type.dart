import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/state/attribute_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SelectType { random, defaultType, manual, purchace }

extension SelectTypeTitle on SelectType {
  String get title {
    switch (this) {
      case SelectType.random:
        return 'Случайно';
      case SelectType.defaultType:
        return 'Стандартно';
      case SelectType.manual:
        return 'Вручную';
      case SelectType.purchace:
        return 'Закупка';
    }
  }

  IconData get icon {
    switch (this) {
      case SelectType.random:
        return Icons.casino_outlined;
      case SelectType.defaultType:
        return Icons.view_list_outlined;
      case SelectType.manual:
        return Icons.keyboard_outlined;
      case SelectType.purchace:
        return Icons.paid_outlined;
    }
  }
}

class SelectionType extends ConsumerWidget {
  const SelectionType({super.key, required this.type});
  final SelectType type;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(
      attributeStateProvider.select((state) => state.selectionType == type),
    );
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        tooltip: type.title,
        style: IconButton.styleFrom(
          backgroundColor: isSelected
              ? colorScheme.primaryContainer
              : colorScheme.surfaceContainerHighest,
          foregroundColor: isSelected
              ? colorScheme.onPrimaryContainer
              : colorScheme.onSurfaceVariant,
        ),
        onPressed: () {
          ref.read(attributeStateProvider.notifier).changeType(type);
        },
        icon: Icon(type.icon),
      ),
    );
  }
}
