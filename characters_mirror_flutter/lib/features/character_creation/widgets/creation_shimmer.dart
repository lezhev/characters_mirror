import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_app_bar.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class CreationShimmer extends ConsumerWidget {
  const CreationShimmer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final appWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = appWidth > 680
        ? 4
        : appWidth > 420
            ? 3
            : 2;
    final shimmerBaseColor = colorScheme.primary.withAlpha(80);
    final shimmerHighlightColor = colorScheme.primary.withAlpha(40);
    final providerStep = ref.watch(
      characterCreationProvider.select((state) => state.step),
    );
    final routeStep = CreationStepX.fromContext(context);
    final currentStep = routeStep ?? providerStep;

    if (routeStep != null && routeStep != providerStep) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(characterCreationProvider.notifier).syncStep(routeStep);
      });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(CreationAppBar.height),
        child: _CreationAppBarShimmer(
          currentStep: currentStep,
          baseColor: shimmerBaseColor,
          highlightColor: shimmerHighlightColor,
        ),
      ),
      body: PageSizeLimiter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: shimmerBaseColor,
                highlightColor: shimmerHighlightColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 64,
                      height: 12,
                      decoration: BoxDecoration(
                        color: colorScheme.onSurface.withAlpha(80),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: PageSizeLimiter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(2, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Shimmer.fromColors(
                  baseColor: shimmerBaseColor,
                  highlightColor: shimmerHighlightColor,
                  child: Container(
                    height: 48,
                    width: 152,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _CreationAppBarShimmer extends StatelessWidget {
  final Step currentStep;
  final Color baseColor;
  final Color highlightColor;

  const _CreationAppBarShimmer({
    required this.currentStep,
    required this.baseColor,
    required this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final neutralBaseColor = colorScheme.surface.withAlpha(40);
    final neutralHighlightColor = colorScheme.primary.withAlpha(40);

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHigh,
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outline,
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: PageSizeLimiter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _ShimmerPiece(
                      baseColor: baseColor,
                      highlightColor: highlightColor,
                      child: const _ShimmerBlock(
                        width: 40,
                        height: 40,
                        radius: 12,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _ShimmerPiece(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: const _ShimmerBlock(
                              width: 180,
                              height: 20,
                              radius: 8,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _ShimmerPiece(
                            baseColor: neutralBaseColor,
                            highlightColor: neutralHighlightColor,
                            child: const _ShimmerBlock(
                              width: 96,
                              height: 14,
                              radius: 7,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surface.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: colorScheme.outline.withValues(alpha: 0.9),
                    ),
                  ),
                  child: _ProgressionShimmer(
                    currentStep: currentStep,
                    activeBaseColor: baseColor,
                    activeHighlightColor: highlightColor,
                    inactiveBaseColor: neutralBaseColor,
                    inactiveHighlightColor: neutralHighlightColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressionShimmer extends StatelessWidget {
  final Step currentStep;
  final Color activeBaseColor;
  final Color activeHighlightColor;
  final Color inactiveBaseColor;
  final Color inactiveHighlightColor;

  const _ProgressionShimmer({
    required this.currentStep,
    required this.activeBaseColor,
    required this.activeHighlightColor,
    required this.inactiveBaseColor,
    required this.inactiveHighlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var index = 0; index < Step.values.length; index++) ...[
          _ShimmerCircle(
            isCurrent: Step.values[index] == currentStep,
            activeBaseColor: activeBaseColor,
            activeHighlightColor: activeHighlightColor,
            inactiveBaseColor: inactiveBaseColor,
            inactiveHighlightColor: inactiveHighlightColor,
          ),
          if (index < Step.values.length - 1)
            Expanded(
              child: _ShimmerPiece(
                baseColor: inactiveBaseColor,
                highlightColor: inactiveHighlightColor,
                child: const _ShimmerBlock(
                  width: double.infinity,
                  height: 4,
                  radius: 2,
                ),
              ),
            ),
        ],
      ],
    );
  }
}

class _ShimmerCircle extends StatelessWidget {
  final bool isCurrent;
  final Color activeBaseColor;
  final Color activeHighlightColor;
  final Color inactiveBaseColor;
  final Color inactiveHighlightColor;

  const _ShimmerCircle({
    required this.isCurrent,
    required this.activeBaseColor,
    required this.activeHighlightColor,
    required this.inactiveBaseColor,
    required this.inactiveHighlightColor,
  });

  @override
  Widget build(BuildContext context) {
    final diameter = _stepDiameter(context, isCurrent);

    return SizedBox(
      width: diameter,
      height: diameter,
      child: _ShimmerPiece(
        baseColor: isCurrent ? activeBaseColor : inactiveBaseColor,
        highlightColor:
            isCurrent ? activeHighlightColor : inactiveHighlightColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _ShimmerBlock(
              width: diameter,
              height: diameter,
              radius: diameter / 2,
            ),
            if (isCurrent)
              const _ShimmerBlock(
                width: 12,
                height: 14,
                radius: 4,
              ),
          ],
        ),
      ),
    );
  }
}

class _ShimmerPiece extends StatelessWidget {
  final Color baseColor;
  final Color highlightColor;
  final Widget child;

  const _ShimmerPiece({
    required this.baseColor,
    required this.highlightColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: child,
    );
  }
}

class _ShimmerBlock extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const _ShimmerBlock({
    required this.width,
    required this.height,
    this.radius = 999,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

double _stepDiameter(BuildContext context, bool isCurrent) {
  final isWide = MediaQuery.of(context).size.width > 500;
  final radius = isCurrent ? (isWide ? 28.0 : 20.0) : (isWide ? 24.0 : 16.0);
  return radius * 2;
}
