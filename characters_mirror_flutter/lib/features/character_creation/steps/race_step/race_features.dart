import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/expandable_section.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/state/race_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/widgets/race_feature_sections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RaceFeatures extends HookConsumerWidget {
  const RaceFeatures({
    required this.selectedRace,
    super.key,
  });

  final RaceData selectedRace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFutureFeaturesExpanded = useState(false);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final raceName = selectedRace.name?.trim();
    final raceTitle =
        raceName == null || raceName.isEmpty ? 'Описание' : raceName;

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
                  AppSectionHeader(title: raceTitle),
                  const Gap(8),
                  Text(
                    selectedRace.description!,
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.justify,
                  ),
                ],
                if (hasSubraces) ...[
                  const Gap(16),
                  const AppSectionHeader(title: 'Подрасы'),
                  const Gap(8),
                  const SubraceChoice(),
                ],
                if (hasFeatures) ...[
                  const Gap(16),
                  const AppSectionHeader(title: 'Особенности расы'),
                  const Gap(2),
                ],
                if (data.features.isNotEmpty)
                  ...buildRaceFeatureSection(context, data.features),
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
                  const Gap(6),
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
                      children: buildRaceFeatureSection(
                        context,
                        data.futureFeatures,
                      ),
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
            context: context,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
