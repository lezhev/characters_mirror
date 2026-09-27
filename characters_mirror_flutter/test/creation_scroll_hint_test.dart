import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_step_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('scroll hint follows remaining content and viewport metrics',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final router = GoRouter(
      initialLocation: '/create/attributes',
      routes: [
        GoRoute(
          path: '/create/attributes',
          builder: (_, __) => CreationStepScaffold(
            route: 'personal',
            onBack: () {},
            onPressedNext: () {},
            onStepTap: null,
            scrollHintAction: () {},
            body: const SizedBox(
              height: 1400,
              child: Center(child: Text('long content')),
            ),
          ),
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    final opacityFinder =
        find.byKey(const ValueKey('creation-scroll-hint-opacity'));
    expect(tester.widget<AnimatedOpacity>(opacityFinder).opacity, 1);

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -1200),
    );
    await tester.pumpAndSettle();
    expect(tester.widget<AnimatedOpacity>(opacityFinder).opacity, 0);

    await tester.binding.setSurfaceSize(const Size(360, 1800));
    await tester.pumpAndSettle();
    expect(tester.widget<AnimatedOpacity>(opacityFinder).opacity, 0);
    expect(tester.takeException(), isNull);
  });
}
