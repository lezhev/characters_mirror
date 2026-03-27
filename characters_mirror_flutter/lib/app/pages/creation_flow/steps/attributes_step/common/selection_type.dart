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
}

class SelectionType extends ConsumerWidget {
  const SelectionType({super.key, required this.type});
  final SelectType type;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
          tooltip: type.title,
          onPressed: () {
            ref.read(attributeStateProvider.notifier).changeType(type);
          },
          icon: Icon(Icons.access_time)),
    );
  }
}
