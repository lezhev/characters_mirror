import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/class_step/state/class_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/expand_section.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/smooth_switcher.dart';
import 'package:characters_mirror_flutter/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClassFeatures extends HookConsumerWidget {
  final ClassData selectedClass;

  const ClassFeatures({super.key, required this.selectedClass});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final isFutureFeaturesExpanded = useState(false);
    final colorScheme = Theme.of(context).colorScheme;

    List<Widget> buildFeatureSection(List<ClassFeatureData> list) {
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
          ClassFeatureCard(
            feature: feature,
          ),
        );
      }

      return widgets;
    }

    return ref.watch(classStateProvider).when(
          data: (data) {
            if (data.features.isEmpty && data.futureFeatures.isEmpty) {
              return Center(
                child: Text('COMING SOON', style: textTheme.displayLarge),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(4),
                Text('Классовые умения', style: textTheme.headlineSmall),
                const Gap(4),
                Container(
                    width: double.infinity,
                    height: 2,
                    color: colorScheme.primary),
                const Gap(2),
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
                  AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    child: isFutureFeaturesExpanded.value
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: buildFeatureSection(data.futureFeatures),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ],
            );
          },
          error: (e, s) => Text('$e, $s'),
          loading: () => Text(
            'LOADING',
            style: textTheme.displayLarge,
          ),
        );
  }
}

class ClassFeatureCard extends HookConsumerWidget {
  final ClassFeatureData feature;

  const ClassFeatureCard({super.key, required this.feature});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final isExpanded = useState(false);

    return ref.watch(classStateProvider).when(
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
                        expand: isExpanded.value,
                        child: Column(
                          children: [
                            Gap(2),
                            Text(
                              feature.description ?? '',
                              style: textTheme.bodySmall,
                              textAlign: TextAlign.justify,
                            ),
                            if (feature.variantOptions != null)
                              ClassOptionChoice(feature: feature),
                            if (data.subclasses.first.levelRequired ==
                                feature.level)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SubclassChoice(),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          error: (e, s) => Text('$e, $s'),
          loading: () => Text(
            'LOADING',
            style: textTheme.displayLarge,
          ),
        );
  }
}

class SubclassChoice extends ConsumerWidget {
  const SubclassChoice({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    return ref.watch(classStateProvider).when(
        data: (data) {
          final subclasses = data.subclasses;
          final selected = data.selectedSubclass;
          return Column(
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: 32),
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
                            data.selectedSubclass == data.subclasses[index]
                                ? ref
                                    .read(classStateProvider.notifier)
                                    .unselectSubclass()
                                : ref
                                    .read(classStateProvider.notifier)
                                    .selectSubclass(data.subclasses[index]);
                          },
                          splashColor: colorScheme.surfaceContainerLowest
                              .withValues(alpha: 0.7),
                          highlightColor: Colors.transparent,
                          child: Ink(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    data.selectedSubclass == subclasses[index]
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
                                  data.subclasses[index].name!,
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
              Gap(12),
              SmoothSwitcher(
                child: selected != null
                    ? Text(
                        selected.description ?? '',
                        key: ValueKey(selected.id ?? 'empty'),
                      )
                    : const SizedBox.shrink(key: ValueKey('empty')),
              ),
            ],
          );
        },
        //TODO
        error: (e, s) => Text('data'),
        loading: () => CircularProgressIndicator());
  }
}

class ClassOptionChoice extends ConsumerWidget {
  final ClassFeatureData feature;

  const ClassOptionChoice({super.key, required this.feature});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ref.watch(classStateProvider).when(
          data: (data) {
            final classOptions = data.classOptions;
            final selected = data.selectedOption?[feature.level];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(8),
                LayoutBuilder(
                  builder: (context, constraints) {
                    const minItemWidth = 180.0;
                    final spacing = 8.0;
                    final maxItemsPerRow = (constraints.maxWidth + spacing) ~/
                        (minItemWidth + spacing);
                    final itemWidth = (constraints.maxWidth -
                            spacing * (maxItemsPerRow - 1)) /
                        maxItemsPerRow;

                    return Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: classOptions.map((option) {
                        return SizedBox(
                          width: itemWidth,
                          child: Material(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                final isSelected = selected == option;

                                isSelected
                                    ? ref
                                        .read(classStateProvider.notifier)
                                        .unselectClassOption(feature.level)
                                    : ref
                                        .read(classStateProvider.notifier)
                                        .selectOption(option, feature.level);
                              },
                              child: Ink(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        data.selectedOption?[feature.level] ==
                                                option
                                            ? colorScheme.outlineVariant
                                            : colorScheme.outline,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Center(
                                    child: Text(option.name!,
                                        style: textTheme.bodySmall)),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                const Gap(12),
                SmoothSwitcher(
                  child: selected != null
                      ? Text(
                          selected.description ?? '',
                          key: ValueKey(selected.id ?? 'empty'),
                        )
                      : const SizedBox.shrink(key: ValueKey('empty')),
                ),
              ],
            );
          },
          error: (e, s) => const Text('Error loading data'),
          loading: () => const CircularProgressIndicator(),
        );
  }
}
