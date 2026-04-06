import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/feature_tag_localization.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/character_feature_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AbilitiesPage extends ConsumerWidget {
  const AbilitiesPage({
    required this.characterId,
    super.key,
  });

  final int characterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(characterSheetControllerProvider(characterId));
    final selectedFeatureTags =
        ref.watch(selectedFightFeatureTagsProvider(characterId));

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => _AbilitiesErrorState(
        message: humanReadableError(error),
        onRetry: () => ref
            .read(characterSheetControllerProvider(characterId).notifier)
            .reload(),
      ),
      data: (character) {
        final activeFeatures = character.derived?.activeFeatures ??
            const <CharacterFeatureViewData>[];

        return Padding(
          padding: const EdgeInsets.all(12),
          child: PageSizeLimiter(
            child: ListView(
              children: [
                Text(
                  'Способности',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                Text(
                  'Выберите теги, которые будут показываться на вкладке "Бой".',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final tag in _allFeatureTags)
                      FilterChip(
                        label: Text(featureTagRuLabel(tag)),
                        selected: selectedFeatureTags.contains(tag),
                        onSelected: (selected) {
                          final next = <FeatureTag>{
                            ...selectedFeatureTags,
                          };
                          if (selected) {
                            next.add(tag);
                          } else {
                            next.remove(tag);
                          }
                          ref
                                  .read(
                                    selectedFightFeatureTagsProvider(characterId)
                                        .notifier,
                                  )
                                  .state =
                              next;
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                if (activeFeatures.isEmpty)
                  Text(
                    'Способности появятся после выбора класса, расы или других источников.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                for (var index = 0; index < activeFeatures.length; index++) ...[
                  CharacterFeatureCard(
                    feature: activeFeatures[index],
                    onSave: ({
                      String? name,
                      String? description,
                      List<FeatureTag>? tags,
                    }) {
                      return ref
                          .read(
                            characterSheetControllerProvider(characterId)
                                .notifier,
                          )
                          .saveFeatureOverride(
                            activeFeatures[index],
                            name: name,
                            description: description,
                            tags: tags,
                          );
                    },
                    onReset: () => ref
                        .read(
                          characterSheetControllerProvider(characterId)
                              .notifier,
                        )
                        .resetFeatureOverride(activeFeatures[index]),
                  ),
                  if (index < activeFeatures.length - 1)
                    const SizedBox(height: 8),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

final _allFeatureTags = [...FeatureTag.values]
  ..sort(
    (left, right) =>
        featureTagRuLabel(left).compareTo(featureTagRuLabel(right)),
  );

class _AbilitiesErrorState extends StatelessWidget {
  const _AbilitiesErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onRetry,
              child: const Text('Попробовать снова'),
            ),
          ],
        ),
      ),
    );
  }
}
