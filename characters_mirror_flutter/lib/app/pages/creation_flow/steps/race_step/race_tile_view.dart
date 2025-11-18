import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/race_step/state/race_state.dart';
import 'package:characters_mirror_flutter/app/theme/theme.dart';
import 'package:characters_mirror_flutter/app/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RaceTileView extends HookConsumerWidget {
  const RaceTileView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appWidth = MediaQuery.of(context).size.width;

    return ref.watch(raceStateProvider).when(
          data: (data) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                crossAxisCount: appWidth > 680
                    ? 4
                    : appWidth > 420
                        ? 3
                        : 2,
                childAspectRatio: 1,
              ),
              itemCount: data.allRaces.length,
              itemBuilder: (context, index) {
                return RaceTile(race: data.allRaces[index]);
              },
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

class RaceTile extends HookConsumerWidget {
  final RaceData race;

  const RaceTile({super.key, required this.race});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isHovered = useState(false);

    return ref.watch(raceStateProvider).when(
          data: (data) {
            return Material(
              borderRadius: BorderRadius.circular(8),
              color: Colors.transparent,
              child: MouseRegion(
                onEnter: (_) => isHovered.value = true,
                onExit: (_) => isHovered.value = false,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    data.selectedRace == race
                        ? ref.read(raceStateProvider.notifier).unselectRace()
                        : ref.read(raceStateProvider.notifier).selectRace(race);
                  },
                  splashColor:
                      colorScheme.surfaceContainerLowest.withValues(alpha: 0.7),
                  highlightColor: Colors.transparent,
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        if (isHovered.value)
                          BoxShadow(
                            color: colorScheme.inversePrimary
                                .withValues(alpha: 0.1),
                            blurRadius: 0,
                            offset: const Offset(0, 2),
                          ),
                      ],
                      border: Border.all(
                        color: isHovered.value || data.selectedRace == race
                            ? colorScheme.outline
                            : Colors.transparent,
                        width: data.selectedRace == race ? 2 : 1,
                      ),
                    ),
                    child: SizedBox(
                      width: 128,
                      height: 128,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius: BorderRadius.circular(128),
                                boxShadow: [
                                  BoxShadow(
                                    color: colorScheme.inversePrimary
                                        .withValues(alpha: 0.1),
                                    blurRadius: 0,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: SvgPicture.asset(
                                'svg/races/${race.imageURL}.svg',
                                width: 96,
                                height: 96,
                                colorFilter: ColorFilter.mode(
                                  colorScheme.surfaceContainerLowest,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            Text(
                              race.name ?? '',
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                      ),
                    ),
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
