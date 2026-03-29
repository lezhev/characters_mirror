import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class CharacterTileView extends StatelessWidget {
  const CharacterTileView({
    required this.onCreateCharacter,
    super.key,
  });

  final VoidCallback onCreateCharacter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CreateCharacterTile(onTap: onCreateCharacter),
        const Gap(16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            maxCrossAxisExtent: 470,
            mainAxisExtent: 96,
          ),
          itemCount: 12,
          itemBuilder: (context, index) {
            return const CharacterTile();
          },
        ),
      ],
    );
  }
}

class _CreateCharacterTile extends StatelessWidget {
  const _CreateCharacterTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: CharacterTileCard(
        onTap: onTap,
        child: Center(
          child: Icon(
            Icons.add,
            size: 30,
            color: colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class CharacterTile extends StatelessWidget {
  const CharacterTile({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CharacterTileCard(
      onTap: () {},
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
                image: const DecorationImage(
                  image: AssetImage('assets/images/melifaro.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Gap(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Character Name',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Gap(4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Level 42',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: colorScheme.primary,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CharacterTileCard extends HookWidget {
  const CharacterTileCard({
    required this.child,
    this.onTap,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
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
          onTap: onTap,
          splashColor:
              colorScheme.surfaceContainerHighest.withValues(alpha: 0.92),
          highlightColor: Colors.transparent,
          child: Ink(
            height: 96,
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
            child: child,
          ),
        ),
      ),
    );
  }
}
