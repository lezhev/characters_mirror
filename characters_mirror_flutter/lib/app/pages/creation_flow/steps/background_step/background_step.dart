import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/background_step/state/background_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_app_bar.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_nav_bar.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_shimmer.dart';
import 'package:characters_mirror_flutter/app/theme/theme.dart';
import 'package:characters_mirror_flutter/app/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/app/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BackgroundStep extends ConsumerWidget {
  const BackgroundStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(backgroundStateProvider).when(
      data: (data) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: CreationAppBar(
              title: "Создание персонажа",
              onBack: () => context.go('/characters'),
            ),
          ),
          body: PageSizeLimiter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: BackgroundTileView(),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: CreationNavBar(
                onPressedNext: () {
                  ref
                      .read(characterCreationProvider.notifier)
                      .nextStep(context);
                  ref
                      .read(characterCreationProvider.notifier)
                      .setBackground(data.selectedBackground!);
                },
                route: 'attributes',
              ),
            ),
          ),
        );
      },
      error: (e, s) {
        return errorWidget(
            e: e,
            s: s,
            refresh: () => ref.refresh(backgroundStateProvider),
            context: context);
      },
      loading: () {
        return CreationShimmer();
      },
    );
  }
}

class BackgroundTileView extends HookConsumerWidget {
  const BackgroundTileView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appWidth = MediaQuery.of(context).size.width;

    return ref.watch(backgroundStateProvider).when(
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
              itemCount: data.allBackgrounds.length,
              itemBuilder: (context, index) {
                return BackgroundTile(background: data.allBackgrounds[index]);
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

class BackgroundTile extends HookConsumerWidget {
  final BackgroundData background;

  const BackgroundTile({super.key, required this.background});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isHovered = useState(false);

    return ref.watch(backgroundStateProvider).when(
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
                    data.selectedBackground == background
                        ? ref
                            .read(backgroundStateProvider.notifier)
                            .unselectBackground()
                        : ref
                            .read(backgroundStateProvider.notifier)
                            .selectBackground(background);
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
                        color: isHovered.value ||
                                data.selectedBackground == background
                            ? colorScheme.outline
                            : Colors.transparent,
                        width: data.selectedBackground == background ? 2 : 1,
                      ),
                    ),
                    child: SizedBox(
                      width: 136,
                      height: 136,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 96,
                              height: 96,
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: colorScheme.shadow
                                        .withValues(alpha: 0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  'svg/placeholder.svg',
                                  colorFilter: ColorFilter.mode(
                                    colorScheme.surfaceContainerLowest,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              background.name ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
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
              refresh: () => ref.refresh(backgroundStateProvider),
              context: context),
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
