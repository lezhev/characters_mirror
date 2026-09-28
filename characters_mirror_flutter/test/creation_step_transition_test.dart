import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/button.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_step_scaffold.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_step_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets(
      'slides step content forward and backward while app bar stays put',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1024, 768));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final router = GoRouter(
      initialLocation: '/create/attributes',
      routes: [
        GoRoute(
          path: '/create/attributes',
          pageBuilder: (_, state) => _stepPage(
            state,
            _TransitionStep(
              route: '/create/attributes',
              label: 'attributes marker',
              onNext: (context) {
                ProviderScope.containerOf(context)
                    .read(creationStepTransitionDirectionProvider.notifier)
                    .state = 1;
                context.go('/create/personal');
              },
            ),
          ),
        ),
        GoRoute(
          path: '/create/personal',
          pageBuilder: (_, state) => _stepPage(
            state,
            _TransitionStep(
              route: '/create/personal',
              label: 'personal marker',
              onNext: (context) {
                ProviderScope.containerOf(context)
                    .read(creationStepTransitionDirectionProvider.notifier)
                    .state = -1;
                context.go('/create/attributes');
              },
              contentPadding: const EdgeInsets.fromLTRB(16, 80, 16, 8),
            ),
          ),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(theme: darkTheme, routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    final appBarBefore = tester.getRect(find.byKey(
      const ValueKey('creation-app-bar'),
    ));
    final contentCenterX = tester.getCenter(find.text('attributes marker')).dx;
    await tester.tap(find.byType(Button).last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 70));

    expect(find.text('personal marker'), findsOneWidget);
    final personalTopDuringTransition =
        tester.getRect(find.text('personal marker')).top;
    expect(
      tester.getCenter(find.text('personal marker')).dx,
      greaterThan(contentCenterX),
    );
    for (final appBar in tester.widgetList<PreferredSize>(
      find.byKey(const ValueKey('creation-app-bar')),
    )) {
      expect(tester.getRect(find.byWidget(appBar)), appBarBefore);
    }

    await tester.pumpAndSettle();
    expect(tester.getCenter(find.text('personal marker')).dx, contentCenterX);
    expect(
      tester.getRect(find.text('personal marker')).top,
      closeTo(personalTopDuringTransition, 1),
    );

    await tester.tap(find.byType(Button).last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 70));

    expect(find.text('attributes marker'), findsOneWidget);
    final attributesTopDuringTransition =
        tester.getRect(find.text('attributes marker')).top;
    expect(
      tester.getCenter(find.text('attributes marker')).dx,
      lessThan(contentCenterX),
    );
    await tester.pumpAndSettle();
    expect(tester.getCenter(find.text('attributes marker')).dx, contentCenterX);
    expect(
      tester.getRect(find.text('attributes marker')).top,
      closeTo(attributesTopDuringTransition, 1),
    );

    router.go('/create/personal');
    await tester.pump(const Duration(milliseconds: 60));
    router.go('/create/attributes');
    await tester.pumpAndSettle();
    expect(find.text('attributes marker'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

CustomTransitionPage<void> _stepPage(GoRouterState state, Widget child) {
  const duration = Duration(milliseconds: 280);
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    transitionsBuilder: (_, animation, secondaryAnimation, child) =>
        CreationStepTransitionScope(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    ),
  );
}

class _TransitionStep extends StatelessWidget {
  const _TransitionStep({
    required this.route,
    required this.label,
    required this.onNext,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
  });

  final String route;
  final String label;
  final void Function(BuildContext) onNext;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) => CreationStepScaffold(
        route: route,
        onBack: () {},
        onStepTap: null,
        onPressedNext: () => onNext(context),
        contentPadding: contentPadding,
        body: SizedBox(
          height: 480,
          child: Center(child: Text(label)),
        ),
      );
}
