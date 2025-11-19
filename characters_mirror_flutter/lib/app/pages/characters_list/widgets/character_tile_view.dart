import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class CharacterTileView extends ConsumerWidget {
  const CharacterTileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        maxCrossAxisExtent: 470,
        mainAxisExtent: 96,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return CharacterTile();
      },
    );
  }
}

class CharacterTile extends HookConsumerWidget {
  const CharacterTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHovered = useState(false);
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {},
          splashColor:
              colorScheme.surfaceContainerHighest.withValues(alpha: 0.92),
          highlightColor: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.inversePrimary
                      .withValues(alpha: isHovered.value ? 0.2 : 0),
                  blurRadius: isHovered.value ? 4 : 0,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(
                color:
                    isHovered.value ? colorScheme.primary : colorScheme.outline,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: colorScheme.outline,
                        width: 1,
                      ),
                      image: DecorationImage(
                        image: AssetImage('images/melifaro.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Gap(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Character Name',
                          style: Theme.of(context).textTheme.bodyLarge),
                      Gap(4),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('Level 42',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: colorScheme.primary)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
