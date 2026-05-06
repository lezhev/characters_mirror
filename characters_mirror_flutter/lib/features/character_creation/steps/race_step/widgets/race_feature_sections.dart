import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/expandable_section.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/smooth_switcher.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/state/race_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/widgets/race_choice_set_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

List<Widget> buildRaceFeatureSection(
  BuildContext context,
  List<RaceFeatureData> list,
) {
  final textTheme = Theme.of(context).textTheme;
  final colorScheme = Theme.of(context).colorScheme;
  final widgets = <Widget>[];
  int? currentLevel;

  for (final feature in list) {
    if (feature.level != currentLevel) {
      currentLevel = feature.level;
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 4),
          child: Text(
            'Уровень $currentLevel',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
            ),
          ),
        ),
      );
    }
    widgets.add(RaceFeatureCard(feature: feature));
  }

  return widgets;
}

class RaceFeatureCard extends HookConsumerWidget {
  const RaceFeatureCard({
    required this.feature,
    super.key,
  });

  final RaceFeatureData feature;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final isExpanded = useState(false);

    return ref.watch(raceStateProvider).when(
          data: (data) {
            final choiceSets =
                feature.choiceSets ?? const <RaceChoiceSetData>[];
            final spellGrants =
                feature.spellGrants ?? const <RaceFeatureSpellGrantData>[];
            final description = feature.shortDescription ?? feature.description;

            return AppSurfaceCard(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          feature.name ?? '',
                          style: textTheme.titleMedium,
                        ),
                      ),
                      IconButton(
                        onPressed: () => isExpanded.value = !isExpanded.value,
                        icon: AnimatedRotation(
                          turns: isExpanded.value ? 0.5 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: const Icon(Icons.expand_more),
                        ),
                      ),
                    ],
                  ),
                  ExpandableSection(
                    extraOffset: 64,
                    expand: isExpanded.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((description ?? '').trim().isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              description!,
                              style: textTheme.bodyMedium,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        if (spellGrants.isNotEmpty) ...[
                          const Gap(12),
                          Text('Заклинания', style: textTheme.titleSmall),
                          const Gap(8),
                          ...spellGrants.map(
                            (grant) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text(
                                spellGrantLabel(grant),
                                style: textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                        if (choiceSets.isNotEmpty) ...[
                          const Gap(12),
                          Text('Выборы', style: textTheme.titleSmall),
                          const Gap(8),
                          ...choiceSets.map(
                            (choiceSet) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: RaceChoiceSetCard(
                                choiceSet: choiceSet,
                                selectedOptions:
                                    data.selectedChoiceOptionsByGroup[
                                            choiceSetGroupKey(choiceSet.id) ??
                                                ''] ??
                                        const <RaceChoiceOptionData>[],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          error: (_, __) => const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}

class SubraceChoice extends ConsumerWidget {
  const SubraceChoice({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return ref.watch(raceStateProvider).when(
          data: (data) {
            final subraces = data.subraces;
            final selected = data.selectedSubrace;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: subraces.length,
                    itemBuilder: (context, index) {
                      final subrace = subraces[index];
                      final isSelected = data.selectedSubrace == subrace;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Material(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              isSelected
                                  ? ref
                                      .read(raceStateProvider.notifier)
                                      .unselectSubrace()
                                  : ref
                                      .read(raceStateProvider.notifier)
                                      .selectSubrace(subrace);
                            },
                            splashColor: colorScheme.surfaceContainerLowest
                                .withValues(alpha: 0.7),
                            highlightColor: Colors.transparent,
                            child: Ink(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected
                                      ? colorScheme.outlineVariant
                                      : colorScheme.outline,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Center(
                                  child: Text(
                                    subrace.name ?? '',
                                    style: textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Gap(12),
                SmoothSwitcher(
                  extraOffset: 64,
                  child: selected != null
                      ? Column(
                          key: ValueKey(selected.id ?? 'empty'),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if ((selected.description ?? '').trim().isNotEmpty)
                              Text(
                                selected.description!,
                                style: textTheme.bodyMedium,
                                textAlign: TextAlign.justify,
                              ),
                          ],
                        )
                      : const SizedBox.shrink(key: ValueKey('empty')),
                ),
              ],
            );
          },
          error: (_, __) => const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
