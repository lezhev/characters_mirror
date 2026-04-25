import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_step_scaffold.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('Creation step swipe navigation', () {
    testWidgets('ignores mouse horizontal swipes', (tester) async {
      await _pumpCreationSwipeHarness(tester);

      expect(find.text('attributes body'), findsOneWidget);

      await _dragWithPointerKind(
        tester,
        find.text('attributes body'),
        const Offset(-700, 0),
        PointerDeviceKind.mouse,
      );

      expect(find.text('attributes body'), findsOneWidget);
      expect(find.text('personal route'), findsNothing);
    });

    testWidgets('keeps touch horizontal swipes enabled', (tester) async {
      await _pumpCreationSwipeHarness(tester);

      expect(find.text('attributes body'), findsOneWidget);

      await tester.drag(find.text('attributes body'), const Offset(-700, 0));
      await tester.pumpAndSettle();

      expect(find.text('personal route'), findsOneWidget);
    });
  });
}

Future<void> _pumpCreationSwipeHarness(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(1280, 900));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  final router = GoRouter(
    initialLocation: '/create/attributes',
    routes: [
      GoRoute(
        path: '/create/background',
        builder: (_, __) => const Scaffold(body: Text('background route')),
      ),
      GoRoute(
        path: '/create/attributes',
        builder: (_, __) => const _CreationSwipeHarness(),
      ),
      GoRoute(
        path: '/create/personal',
        builder: (_, __) => const Scaffold(body: Text('personal route')),
      ),
    ],
  );

  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp.router(
        theme: darkTheme,
        routerConfig: router,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _dragWithPointerKind(
  WidgetTester tester,
  Finder target,
  Offset offset,
  PointerDeviceKind kind,
) async {
  final start = tester.getCenter(target);
  final gesture = await tester.createGesture(kind: kind);
  await gesture.down(start);
  await tester.pump();
  await gesture.moveTo(start + offset);
  await tester.pump();
  await gesture.up();
  await tester.pumpAndSettle();
}

class _CreationSwipeHarness extends StatelessWidget {
  const _CreationSwipeHarness();

  @override
  Widget build(BuildContext context) {
    return CreationStepScaffold(
      route: '/create/attributes',
      onBack: () {},
      onStepTap: null,
      onPressedNext: () {},
      body: const SizedBox(
        height: 600,
        child: Center(child: Text('attributes body')),
      ),
    );
  }
}
