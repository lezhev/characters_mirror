import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/background_step/state/background_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_app_bar.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/jump_to_details_button.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_nav_bar.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_shimmer.dart';
import 'package:characters_mirror_flutter/app/theme/theme.dart';
import 'package:characters_mirror_flutter/app/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/app/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BackgroundStep extends HookConsumerWidget {
  const BackgroundStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsKey = useMemoized(GlobalKey.new);
    final dismissedSelectionKey = useState<String?>(null);

    return ref.watch(backgroundStateProvider).when(
      data: (data) {
        final selectedBackgroundKey =
            data.selectedBackground == null
                ? null
                : '${data.selectedBackground!.id ?? data.selectedBackground!.name}';
        final showJumpButton =
            selectedBackgroundKey != null &&
            dismissedSelectionKey.value != selectedBackgroundKey;

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(CreationAppBar.height),
            child: CreationAppBar(
              title: "Создание персонажа",
              onBack: () {
                ref.read(characterCreationProvider.notifier).reset();
                context.go('/characters');
              },
              onStepTap: (target) => _syncAndGo(
                context: context,
                ref: ref,
                data: data,
                target: target,
              ),
            ),
          ),
          body: PageSizeLimiter(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        BackgroundTileView(),
                        if (data.selectedBackground != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 88.0),
                            child: KeyedSubtree(
                              key: detailsKey,
                              child: BackgroundFeatures(
                                selectedBackground: data.selectedBackground!,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (showJumpButton)
                  JumpToDetailsButton(
                    onPressed: () {
                      dismissedSelectionKey.value = selectedBackgroundKey;
                      _scrollToDetails(detailsKey);
                    },
                  ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: CreationNavBar(
                onPressedNext: () {
                  final notifier =
                      ref.read(characterCreationProvider.notifier);
                  notifier.syncBackgroundDraft(data.selectedBackground);
                  notifier.nextStep(context);
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

void _syncAndGo({
  required BuildContext context,
  required WidgetRef ref,
  required BackgroundStateModel data,
  required Step target,
}) {
  final notifier = ref.read(characterCreationProvider.notifier);
  notifier.syncBackgroundDraft(data.selectedBackground);
  notifier.goToStep(context, target);
}

Future<void> _scrollToDetails(GlobalKey key) async {
  final context = key.currentContext;
  if (context == null) return;

  await Scrollable.ensureVisible(
    context,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOutCubic,
    alignment: 0.0,
  );
}

class BackgroundFeatures extends StatelessWidget {
  final BackgroundData selectedBackground;

  const BackgroundFeatures({super.key, required this.selectedBackground});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final cards = <Widget>[
      if (_hasText(selectedBackground.description))
        BackgroundFeatureCard(
          title: 'Описание',
          child: Text(
            selectedBackground.description!,
            style: textTheme.bodyMedium,
            textAlign: TextAlign.justify,
          ),
        ),
      if (_hasText(selectedBackground.feature))
        BackgroundFeatureCard(
          title: 'Особенность',
          child: Text(
            selectedBackground.feature!,
            style: textTheme.bodyMedium,
            textAlign: TextAlign.justify,
          ),
        ),
      if (_hasAnyValues([
        selectedBackground.skillProficiencies,
        selectedBackground.toolProficiencies,
        selectedBackground.languages,
      ]))
        BackgroundFeatureCard(
          title: 'Владения и языки',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BackgroundValueGroup(
                label: 'Владение навыками',
                values: selectedBackground.skillProficiencies,
              ),
              _BackgroundValueGroup(
                label: 'Владение инструментами',
                values: selectedBackground.toolProficiencies,
              ),
              _BackgroundValueGroup(
                label: 'Языки',
                values: selectedBackground.languages,
              ),
            ],
          ),
        ),
      if (_hasTextList(selectedBackground.items) ||
          selectedBackground.coins != null)
        BackgroundFeatureCard(
          title: 'Снаряжение и ресурсы',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BackgroundValueGroup(
                label: 'Предметы',
                values: selectedBackground.items,
              ),
              if (selectedBackground.coins != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Монеты: ${_formatCoins(selectedBackground.coins!)}',
                    style: textTheme.bodyMedium,
                  ),
                ),
            ],
          ),
        ),
      if (_hasAnyValues([
        selectedBackground.suggestedPersonality,
        selectedBackground.suggestedIdeal,
        selectedBackground.suggestedBond,
        selectedBackground.suggestedFlaw,
      ]))
        BackgroundFeatureCard(
          title: 'Ролевые зацепки',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BackgroundPromptGroup(
                label: 'Черты характера',
                values: selectedBackground.suggestedPersonality,
              ),
              _BackgroundPromptGroup(
                label: 'Идеалы',
                values: selectedBackground.suggestedIdeal,
              ),
              _BackgroundPromptGroup(
                label: 'Привязанности',
                values: selectedBackground.suggestedBond,
              ),
              _BackgroundPromptGroup(
                label: 'Слабости',
                values: selectedBackground.suggestedFlaw,
              ),
            ],
          ),
        ),
    ];

    if (cards.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text('COMING SOON', style: textTheme.displayLarge),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(4),
        Text('Особенности предыстории', style: textTheme.headlineSmall),
        const Gap(4),
        Container(
            width: double.infinity, height: 2, color: colorScheme.primary),
        const Gap(2),
        ...cards,
      ],
    );
  }
}

class BackgroundFeatureCard extends StatelessWidget {
  final String title;
  final Widget child;

  const BackgroundFeatureCard({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: double.infinity,
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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.labelLarge),
              const Gap(8),
              child,
            ],
          ),
        ),
      ),
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

class _BackgroundValueGroup extends StatelessWidget {
  final String label;
  final List<dynamic>? values;

  const _BackgroundValueGroup({
    required this.label,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    if (!_hasTextList(values)) {
      return const SizedBox.shrink();
    }

    final textTheme = Theme.of(context).textTheme;
    final chips = values!
        .map(_displayValue)
        .where((value) => value.trim().isNotEmpty)
        .map(
          (value) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(value, style: textTheme.bodySmall),
          ),
        )
        .toList();

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: textTheme.titleSmall),
          const Gap(6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: chips,
          ),
        ],
      ),
    );
  }
}

class _BackgroundPromptGroup extends StatelessWidget {
  final String label;
  final List<String>? values;

  const _BackgroundPromptGroup({
    required this.label,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    if (!_hasTextList(values)) {
      return const SizedBox.shrink();
    }

    final textTheme = Theme.of(context).textTheme;
    final prompts = values!.where((value) => value.trim().isNotEmpty).toList();

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: textTheme.titleSmall),
          const Gap(6),
          ...prompts.map(
            (value) => Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                '• $value',
                style: textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

bool _hasText(String? value) => value != null && value.trim().isNotEmpty;

bool _hasTextList(List<dynamic>? values) =>
    values != null &&
    values.any((value) => _displayValue(value).trim().isNotEmpty);

bool _hasAnyValues(List<List<dynamic>?> groups) =>
    groups.any((group) => _hasTextList(group));

String _formatCoins(double value) {
  return value.truncateToDouble() == value
      ? value.toInt().toString()
      : value.toString();
}

String _displayValue(dynamic value) {
  if (value == null) return '';
  if (value is String) return value;

  final raw = value.name?.toString() ?? value.toString();
  final normalized = raw.replaceAllMapped(
    RegExp(r'([a-z])([A-Z])'),
    (match) => '${match.group(1)} ${match.group(2)}',
  );

  return normalized.isEmpty
      ? normalized
      : normalized[0].toUpperCase() + normalized.substring(1);
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
