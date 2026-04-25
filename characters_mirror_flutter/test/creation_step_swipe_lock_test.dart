import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/attributes_step.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/widgets/drag_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('attribute drag does not navigate to the previous step',
      (tester) async {
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
          builder: (_, __) => const AttributesStep(),
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

    final source = find
        .byWidgetPredicate(
          (widget) => widget is DragBox && widget.value == 15,
        )
        .first;
    final target = find.byType(DragTarget<int>).first;
    final dragOffset = tester.getCenter(target) - tester.getCenter(source);

    expect(dragOffset.dx.abs(), greaterThan(80));
    expect(dragOffset.dx.abs(), greaterThan(dragOffset.dy.abs() * 1.4));

    await tester.drag(source, dragOffset);
    await tester.pumpAndSettle();

    expect(find.byType(AttributesStep), findsOneWidget);
    expect(find.text('background route'), findsNothing);
  });
}
