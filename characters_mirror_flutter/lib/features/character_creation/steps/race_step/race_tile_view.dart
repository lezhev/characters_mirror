import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/state/race_state.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const double _raceIconSafeSpaceSize = 110.4;
const double _raceIconCircleSize = 96;
const double _gridIconScale = 1.3;
const double _listIconScale = 1;
const double _tilePadding = 4;
const double _gridIconSafeSpaceSize = _raceIconSafeSpaceSize * _gridIconScale;
const double _gridTileSize = _gridIconSafeSpaceSize + 34 + _tilePadding * 2;
const double _listIconSafeSpaceSize = _raceIconSafeSpaceSize * _listIconScale;
const double _listTileHeight = _listIconSafeSpaceSize + _tilePadding * 2;
const double _compactLayoutBreakpoint = 420;

enum RaceTileLayout {
  grid,
  list,
}

class RaceTileView extends HookConsumerWidget {
  const RaceTileView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(raceStateProvider).when(
          data: (data) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final appWidth = constraints.maxWidth;
                if (appWidth <= _compactLayoutBreakpoint) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.allRaces.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      return RaceTile(
                        race: data.allRaces[index],
                        layout: RaceTileLayout.list,
                      );
                    },
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    crossAxisCount: appWidth > 680 ? 3 : 2,
                    mainAxisExtent: _gridTileSize,
                  ),
                  itemCount: data.allRaces.length,
                  itemBuilder: (context, index) {
                    return RaceTile(
                      race: data.allRaces[index],
                      layout: RaceTileLayout.grid,
                    );
                  },
                );
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
  final RaceTileLayout layout;

  const RaceTile({
    super.key,
    required this.race,
    this.layout = RaceTileLayout.grid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isHovered = useState(false);

    return ref.watch(raceStateProvider).when(
          data: (data) {
            final isSelected = _isSelectedRace(data.selectedRace, race);
            final isGrid = layout == RaceTileLayout.grid;

            return Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: isGrid ? _gridTileSize : double.infinity,
                height: isGrid ? _gridTileSize : _listTileHeight,
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent,
                  child: MouseRegion(
                    onEnter: (_) => isHovered.value = true,
                    onExit: (_) => isHovered.value = false,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        isSelected
                            ? ref
                                .read(raceStateProvider.notifier)
                                .unselectRace()
                            : ref
                                .read(raceStateProvider.notifier)
                                .selectRace(race);
                      },
                      splashColor: colorScheme.surfaceContainerLowest
                          .withValues(alpha: 0.7),
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
                            color: isHovered.value || isSelected
                                ? colorScheme.outline
                                : Colors.transparent,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(_tilePadding),
                          child: _RaceTileContent(
                            race: race,
                            layout: layout,
                            colorScheme: colorScheme,
                          ),
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
            context: context,
          ),
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}

class _RaceTileContent extends StatelessWidget {
  const _RaceTileContent({
    required this.race,
    required this.layout,
    required this.colorScheme,
  });

  final RaceData race;
  final RaceTileLayout layout;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final title = race.name ?? '';
    final description = race.description?.trim();

    if (layout == RaceTileLayout.list) {
      return Row(
        children: [
          _RaceIcon(
            race: race,
            colorScheme: colorScheme,
            scale: _listIconScale,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelLarge,
                ),
                if (description != null && description.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _RaceIcon(
          race: race,
          colorScheme: colorScheme,
          scale: _gridIconScale,
        ),
        const SizedBox(height: 4),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.labelLarge,
        ),
      ],
    );
  }
}

class _RaceIcon extends StatelessWidget {
  const _RaceIcon({
    required this.race,
    required this.colorScheme,
    required this.scale,
  });

  final RaceData race;
  final ColorScheme colorScheme;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final safeSpaceSize = _raceIconSafeSpaceSize * scale;
    final circleSize = _raceIconCircleSize * scale;

    return SizedBox(
      width: safeSpaceSize,
      height: safeSpaceSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            'assets/svg/races/${race.imageURL}.svg', // ${race.imageURL}
            width: safeSpaceSize,
            height: safeSpaceSize,
            colorFilter: ColorFilter.mode(
              colorScheme.surfaceContainerLowest,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}

bool _isSelectedRace(RaceData? selectedRace, RaceData race) {
  final selectedId = selectedRace?.id;
  final raceId = race.id;
  if (selectedId != null && raceId != null) {
    return selectedId == raceId;
  }
  return selectedRace == race;
}
