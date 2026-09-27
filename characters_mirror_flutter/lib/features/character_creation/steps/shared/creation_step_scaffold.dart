import 'package:characters_mirror_flutter/core/router/navigation_helpers.dart';
import 'package:characters_mirror_flutter/core/ui/pointer_swipe_policy.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_step_swipe_lock.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_app_bar.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_nav_bar.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/jump_to_details_button.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _creationStepContentHeroTag = 'creation-step-content';

class CreationStepScaffold extends ConsumerStatefulWidget {
  const CreationStepScaffold({
    required this.body,
    required this.onBack,
    required this.onStepTap,
    required this.onPressedNext,
    required this.route,
    super.key,
    this.title = 'Создание персонажа',
    this.scrollableBody = true,
    this.floatingActionButton,
    this.scrollHintAction,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
  });

  final Widget body;
  final VoidCallback onBack;
  final Future<void> Function(Step target)? onStepTap;
  final VoidCallback onPressedNext;
  final String route;
  final String title;
  final bool scrollableBody;
  final Widget? floatingActionButton;
  final VoidCallback? scrollHintAction;
  final EdgeInsetsGeometry contentPadding;

  @override
  ConsumerState<CreationStepScaffold> createState() =>
      _CreationStepScaffoldState();
}

class _CreationStepScaffoldState extends ConsumerState<CreationStepScaffold> {
  late final ScrollController _bodyScrollController;
  bool _showScrollHint = false;
  Offset? _swipeStart;
  bool _lockedCurrentSwipe = false;

  @override
  void initState() {
    super.initState();
    _bodyScrollController = ScrollController()
      ..addListener(_updateScrollHintVisibility);
  }

  @override
  void dispose() {
    _bodyScrollController
      ..removeListener(_updateScrollHintVisibility)
      ..dispose();
    super.dispose();
  }

  void _scheduleScrollHintUpdate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _updateScrollHintVisibility();
    });
  }

  void _updateScrollHintVisibility() {
    final shouldShow = widget.scrollHintAction != null &&
        widget.scrollableBody &&
        _bodyScrollController.hasClients &&
        _bodyScrollController.position.hasContentDimensions &&
        _bodyScrollController.position.maxScrollExtent -
                _bodyScrollController.position.pixels >
            64;
    if (_showScrollHint == shouldShow || !mounted) return;
    setState(() => _showScrollHint = shouldShow);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(creationStepSwipeLockedProvider, (_, next) {
      if (next) {
        _lockedCurrentSwipe = true;
      }
    });

    final providerStep = ref.watch(
      characterCreationProvider.select((state) => state.step),
    );
    final routeStep = CreationStepX.fromContext(context);
    final currentStep = routeStep ?? providerStep;
    final notifier = ref.read(characterCreationProvider.notifier);
    final swipeLocked = ref.watch(creationStepSwipeLockedProvider);
    _scheduleScrollHintUpdate();

    Future<void> navigateToStep(Step target) async {
      FocusScope.of(context).unfocus();
      if (widget.onStepTap != null) {
        await widget.onStepTap!(target);
      } else {
        notifier.goToStep(context, target);
      }
    }

    void handlePointerUp(PointerUpEvent event) {
      final start = _swipeStart;
      _swipeStart = null;
      final shouldIgnoreSwipe = swipeLocked || _lockedCurrentSwipe;
      _lockedCurrentSwipe = false;
      if (start == null || shouldIgnoreSwipe) {
        return;
      }

      final delta = event.position - start;
      if (delta.dx.abs() < 80 || delta.dx.abs() < delta.dy.abs() * 1.4) {
        return;
      }

      if (delta.dx < 0) {
        final next = notifier.nextVisibleStep(currentStep);
        if (next != null) {
          navigateToStep(next);
        }
      } else {
        final previous = notifier.previousVisibleStep(currentStep);
        if (previous != null) {
          navigateToStep(previous);
        }
      }
    }

    void handleBackNavigation() {
      final previous = notifier.previousVisibleStep(currentStep);
      if (previous == null) {
        popOrGo(context, '/characters');
        return;
      }

      navigateToStep(previous);
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        handleBackNavigation();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(CreationAppBar.height),
          key: const ValueKey('creation-app-bar'),
          child: CreationAppBar(
            title: widget.title,
            onBack: widget.onBack,
            onStepTap: widget.onStepTap,
          ),
        ),
        body: Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (event) {
            _lockedCurrentSwipe =
                swipeLocked || !allowsSwipeNavigationForPointer(event.kind);
            _swipeStart = _lockedCurrentSwipe ? null : event.position;
          },
          onPointerUp: handlePointerUp,
          onPointerCancel: (_) {
            _swipeStart = null;
            _lockedCurrentSwipe = false;
          },
          child: PageSizeLimiter(
            child: Padding(
              padding: widget.contentPadding,
              child: Hero(
                tag: _creationStepContentHeroTag,
                createRectTween: (begin, end) => RectTween(
                  begin: begin,
                  end: end,
                ),
                flightShuttleBuilder: _creationStepFlightShuttle,
                child: widget.scrollableBody
                    ? NotificationListener<ScrollMetricsNotification>(
                        onNotification: (_) {
                          _scheduleScrollHintUpdate();
                          return false;
                        },
                        child: SingleChildScrollView(
                          controller: _bodyScrollController,
                          child: widget.body,
                        ),
                      )
                    : widget.body,
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: CreationNavBar(
              onPressedNext: widget.onPressedNext,
              route: widget.route,
            ),
          ),
        ),
        floatingActionButton: widget.scrollHintAction == null
            ? widget.floatingActionButton
            : JumpToDetailsButton(
                onPressed: widget.scrollHintAction!,
                isVisible: _showScrollHint,
              ),
        floatingActionButtonLocation: widget.scrollHintAction == null
            ? null
            : FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

Widget _creationStepFlightShuttle(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  final fromStep = CreationStepX.fromContext(fromHeroContext);
  final toStep = CreationStepX.fromContext(toHeroContext);
  final isMovingForward =
      fromStep == null || toStep == null || toStep.index >= fromStep.index;
  final horizontalOffset = isMovingForward ? 1.0 : -1.0;
  final progress = flightDirection == HeroFlightDirection.push
      ? animation
      : ReverseAnimation(animation);
  final position = Tween<Offset>(
    begin: Offset(horizontalOffset, 0),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(parent: progress, curve: Curves.easeInOutCubic),
  );
  final destinationHero = toHeroContext.widget as Hero;

  return SlideTransition(
    position: position,
    child: Material(
      color: Colors.transparent,
      child: destinationHero.child,
    ),
  );
}
