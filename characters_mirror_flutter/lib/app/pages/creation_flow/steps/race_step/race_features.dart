import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/race_step/state/race_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/expand_section.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/smooth_switcher.dart';
import 'package:characters_mirror_flutter/app/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RaceFeatures extends HookConsumerWidget {
  final RaceData selectedRace;

  const RaceFeatures({super.key, required this.selectedRace});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final isFutureFeaturesExpanded = useState(false);
    final colorScheme = Theme.of(context).colorScheme;

    List<Widget> buildFeatureSection(List<RaceFeatureData> list) {
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
        widgets.add(
          RaceFeatureCard(
            feature: feature,
          ),
        );
      }

      return widgets;
    }

    return ref.watch(raceStateProvider).when(
          data: (data) {
            final hasFeatures =
                data.features.isNotEmpty || data.futureFeatures.isNotEmpty;
            final hasSubraces = data.subraces.isNotEmpty;

            if (!hasFeatures && !hasSubraces) {
              return Center(
                child: Text('COMING SOON', style: textTheme.displayLarge),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if ((selectedRace.description ?? '').trim().isNotEmpty) ...[
                  const Gap(4),
                  Text('Описание', style: textTheme.headlineSmall),
                  const Gap(4),
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: colorScheme.primary,
                  ),
                  const Gap(8),
                  Text(
                    selectedRace.description!,
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.justify,
                  ),
                ],
                if (hasSubraces) ...[
                  const Gap(16),
                  Text('Подрасы', style: textTheme.headlineSmall),
                  const Gap(4),
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: colorScheme.primary,
                  ),
                  const Gap(8),
                  const SubraceChoice(),
                ],
                if (hasFeatures) ...[
                  const Gap(16),
                  Text('Особенности расы', style: textTheme.headlineSmall),
                  const Gap(4),
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: colorScheme.primary,
                  ),
                  const Gap(2),
                ],
                if (data.features.isNotEmpty)
                  ...buildFeatureSection(data.features),
                if (data.futureFeatures.isNotEmpty) ...[
                  const Gap(8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Будущие умения',
                          style: textTheme.titleMedium,
                        ),
                        IconButton(
                          onPressed: () => isFutureFeaturesExpanded.value =
                              !isFutureFeaturesExpanded.value,
                          icon: AnimatedRotation(
                            turns: isFutureFeaturesExpanded.value ? 0.5 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: const Icon(Icons.expand_more),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(6),
                  Container(
                    height: 2,
                    width: double.infinity,
                    color: colorScheme.outlineVariant,
                  ),
                  ExpandableSection(
                    extraOffset: 64,
                    expand: isFutureFeaturesExpanded.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: buildFeatureSection(data.futureFeatures),
                    ),
                  ),
                ],
              ],
            );
          },
          error: (e, s) => errorWidget(
              e: e,
              s: s,
              refresh: () => ref.refresh(raceStateProvider),
              context: context),
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}

class RaceFeatureCard extends HookConsumerWidget {
  final RaceFeatureData feature;

  const RaceFeatureCard({super.key, required this.feature});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final isExpanded = useState(false);

    return ref.watch(raceStateProvider).when(
          data: (data) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.surfaceDim,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            feature.name ?? '',
                            style: textTheme.labelLarge,
                          ),
                          IconButton(
                            onPressed: () =>
                                isExpanded.value = !isExpanded.value,
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
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            feature.description ?? '',
                            style: textTheme.bodyMedium,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          error: (e, s) => errorWidget(
              e: e,
              s: s,
              refresh: () => ref.refresh(raceStateProvider),
              context: context),
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
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
            final subclasses = data.subraces;
            final selected = data.selectedSubrace;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: const BoxConstraints(maxHeight: 32),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: subclasses.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Material(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              data.selectedSubrace == data.subraces[index]
                                  ? ref
                                      .read(raceStateProvider.notifier)
                                      .unselectSubrace()
                                  : ref
                                      .read(raceStateProvider.notifier)
                                      .selectSubrace(data.subraces[index]);
                            },
                            splashColor: colorScheme.surfaceContainerLowest
                                .withValues(alpha: 0.7),
                            highlightColor: Colors.transparent,
                            child: Ink(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      data.selectedSubrace == subclasses[index]
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
                                    data.subraces[index].name!,
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
                                selected.description ?? '',
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
          error: (e, s) => errorWidget(
              e: e,
              s: s,
              refresh: () => ref.refresh(raceStateProvider),
              context: context),
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
