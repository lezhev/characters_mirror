import 'package:characters_mirror_flutter/features/character_portrait/application/character_portrait_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterPortrait extends ConsumerWidget {
  const CharacterPortrait({
    required this.characterId,
    this.size = 128,
    this.borderRadius = 16,
    this.fit = BoxFit.cover,
    super.key,
  });

  final int characterId;
  final double size;
  final double borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portrait = ref.watch(
      characterPortraitControllerProvider(characterId),
    );

    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox.square(
      dimension: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: ColoredBox(
          color: colorScheme.surfaceContainerHighest,
          child: portrait.when(
            data: (url) {
              if (url == null) {
                return const _PortraitPlaceholder();
              }

              return Image.network(
                url.toString(),
                fit: fit,
                width: size,
                height: size,
                errorBuilder: (_, __, ___) {
                  return const _PortraitError();
                },
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (_, __) => const _PortraitError(),
          ),
        ),
      ),
    );
  }
}

class _PortraitPlaceholder extends StatelessWidget {
  const _PortraitPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.person_outline,
        size: 40,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _PortraitError extends StatelessWidget {
  const _PortraitError();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.broken_image_outlined,
        size: 32,
        color: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
