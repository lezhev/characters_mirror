import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/feature_tag_localization.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/helpers/sheet_autosave.dart';
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
        final classFeatures = [
          for (final feature in activeFeatures)
            if (_isClassFeature(feature)) feature,
        ];
        final raceFeatures = [
          for (final feature in activeFeatures)
            if (_isRaceFeature(feature)) feature,
        ];

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
                              .state = next;
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
                if (classFeatures.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  _FeatureSectionHeader(
                    title: 'Класс',
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 8),
                  ..._buildFeatureCards(
                    features: classFeatures,
                    ref: ref,
                    characterId: characterId,
                    context: context,
                  ),
                ],
                if (raceFeatures.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _FeatureSectionHeader(
                    title: 'Раса',
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 8),
                  ..._buildFeatureCards(
                    features: raceFeatures,
                    ref: ref,
                    characterId: characterId,
                    context: context,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

final _allFeatureTags = [...FeatureTag.values]..sort(
    (left, right) =>
        featureTagRuLabel(left).compareTo(featureTagRuLabel(right)),
  );

List<Widget> _buildFeatureCards({
  required List<CharacterFeatureViewData> features,
  required WidgetRef ref,
  required int characterId,
  required BuildContext context,
}) {
  return [
    for (var index = 0; index < features.length; index++) ...[
      CharacterFeatureCard(
        feature: features[index],
        onSave: ({
          String? name,
          String? description,
          List<FeatureTag>? tags,
        }) {
          return ref
              .read(
                characterSheetControllerProvider(characterId).notifier,
              )
              .saveFeatureOverride(
                features[index],
                name: name,
                description: description,
                tags: tags,
              );
        },
        onReset: () => ref
            .read(
              characterSheetControllerProvider(characterId).notifier,
            )
            .resetFeatureOverride(features[index]),
        onSetResource: (resourceKey, current) {
          runCharacterSheetSave(
            context,
            ref
                .read(
                  characterSheetControllerProvider(characterId).notifier,
                )
                .setFeatureResource(features[index], resourceKey, current),
          );
          return Future.value();
        },
      ),
      if (index < features.length - 1) const SizedBox(height: 8),
    ],
  ];
}

bool _isClassFeature(CharacterFeatureViewData feature) {
  switch (feature.sourceType) {
    case CharacterFeatureSourceType.classFeature:
    case CharacterFeatureSourceType.subclassFeature:
      return true;
    case CharacterFeatureSourceType.raceFeature:
    case CharacterFeatureSourceType.subraceFeature:
      return false;
  }
}

bool _isRaceFeature(CharacterFeatureViewData feature) {
  switch (feature.sourceType) {
    case CharacterFeatureSourceType.classFeature:
    case CharacterFeatureSourceType.subclassFeature:
      return false;
    case CharacterFeatureSourceType.raceFeature:
    case CharacterFeatureSourceType.subraceFeature:
      return true;
  }
}

class _FeatureSectionHeader extends StatelessWidget {
  const _FeatureSectionHeader({
    required this.title,
    required this.color,
  });

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: color,
          ),
    );
  }
}

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
