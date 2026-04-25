import 'package:characters_mirror_flutter/core/ui/pointer_swipe_policy.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_step_swipe_lock.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_app_bar.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_nav_bar.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  final EdgeInsetsGeometry contentPadding;

  @override
  ConsumerState<CreationStepScaffold> createState() =>
      _CreationStepScaffoldState();
}

class _CreationStepScaffoldState extends ConsumerState<CreationStepScaffold> {
  Offset? _swipeStart;
  bool _lockedCurrentSwipe = false;

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
        final next = currentStep.next;
        if (next != null) {
          navigateToStep(next);
        }
      } else {
        final previous = currentStep.previous;
        if (previous != null) {
          navigateToStep(previous);
        }
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(CreationAppBar.height),
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
            child: widget.scrollableBody
                ? SingleChildScrollView(child: widget.body)
                : widget.body,
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: CreationNavBar(
            onPressedNext: widget.onPressedNext,
            route: widget.route,
          ),
        ),
      ),
    );
  }
}
