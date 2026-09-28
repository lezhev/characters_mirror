import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/button.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_step_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets(
      'next step starts at the top after the previous step was scrolled',
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
            _ScrollStep(
              label: 'attributes',
              onNext: (context) => context.go('/create/personal'),
            ),
          ),
        ),
        GoRoute(
          path: '/create/personal',
          pageBuilder: (_, state) => _stepPage(
            state,
            const _ScrollStep(label: 'personal'),
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

    await tester.drag(
      find.byType(SingleChildScrollView).first,
      const Offset(0, -600),
    );
    await tester.pumpAndSettle();
    expect(
      Scrollable.of(tester.element(find.text('attributes start')))
          .position
          .pixels,
      greaterThan(0),
    );

    await tester.tap(find.byType(Button).last);
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/create/personal');

    final destinationTop = tester.getRect(find.text('personal start')).top;
    final appBarBottom =
        tester.getRect(find.byKey(const ValueKey('creation-app-bar'))).bottom;
    expect(destinationTop, closeTo(appBarBottom + 8, 1));
    expect(
      Scrollable.of(tester.element(find.text('personal start')))
          .position
          .pixels,
      0,
    );

    expect(
      tester.getRect(find.text('personal start')).top,
      closeTo(destinationTop, 1),
    );
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
    transitionsBuilder: (_, __, ___, child) => child,
  );
}

class _ScrollStep extends StatelessWidget {
  const _ScrollStep({required this.label, this.onNext});

  final String label;
  final void Function(BuildContext)? onNext;

  @override
  Widget build(BuildContext context) => CreationStepScaffold(
        route: 'personal',
        onBack: () {},
        onStepTap: null,
        onPressedNext: () => onNext?.call(context),
        body: SizedBox(
          height: 1300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$label start'),
              const SizedBox(height: 1200),
              Text('$label end'),
            ],
          ),
        ),
      );
}
