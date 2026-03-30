import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/attribute_enum.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/state/attribute_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PurchaceColumn extends ConsumerWidget {
  const PurchaceColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(attributeStateProvider.notifier);
    return SizedBox(
      width: 68, // внешний контейнер
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: Attribute.values.map((attribute) {
          final value = notifier.mergeStatsAndBonuses()[attribute];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: SizedBox(
              height: 60,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none, // кнопки могут выступать
                children: [
                  // основной квадрат с бордером
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      value.toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  // кнопка минус слева с задником
                  Positioned(
                    left: -10,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        iconSize: 16,
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          notifier.changeAttributeBy(attribute, -1);
                        },
                      ),
                    ),
                  ),
                  // кнопка плюс справа с задником
                  Positioned(
                    right: -10,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        iconSize: 16,
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          notifier.changeAttributeBy(attribute, 1);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
