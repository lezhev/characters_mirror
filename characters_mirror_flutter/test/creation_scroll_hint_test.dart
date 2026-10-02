import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_selection_step_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('tap scrolls to details and dismisses hint until next selection',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final selection = ValueNotifier<int?>(1);
    addTearDown(selection.dispose);
    final detailsKey = GlobalKey();
    await _pumpHintStep(tester, selection, detailsKey);

    expect(_hintOpacity(tester), 1);
    final hintSize = tester.widget<SizedBox>(
      find.byKey(const ValueKey('creation-scroll-hint-size')),
    );
    expect(hintSize.width, 264);
    expect(hintSize.height, 26);
    final hintMaterial = tester.widget<Material>(
      find
          .ancestor(
            of: find.byKey(const ValueKey('creation-scroll-hint')),
            matching: find.byType(Material),
          )
          .first,
    );
    expect(hintMaterial.color!.a, 1);

    await tester.tap(find.byKey(const ValueKey('creation-scroll-hint')));
    await tester.pumpAndSettle();
    expect(_hintOpacity(tester), 0);
    expect(
      (tester.getTopLeft(find.byKey(detailsKey)).dy -
              tester.getTopLeft(find.byType(SingleChildScrollView)).dy)
          .abs(),
      lessThan(2),
    );

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, 650),
    );
    await tester.pumpAndSettle();
    expect(_hintOpacity(tester), 0);

    await tester.binding.setSurfaceSize(const Size(360, 820));
    await tester.pumpAndSettle();
    expect(_hintOpacity(tester), 0);

    await tester.tap(find.byKey(const ValueKey('change-selection')));
    await tester.pumpAndSettle();
    expect(_hintOpacity(tester), 1);
  });

  testWidgets('manual scroll dismisses at the details viewport midpoint',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final selection = ValueNotifier<int?>(1);
    addTearDown(selection.dispose);
    final detailsKey = GlobalKey();
    await _pumpHintStep(tester, selection, detailsKey);

    expect(_hintOpacity(tester), 1);
    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -180),
    );
    await tester.pumpAndSettle();
    expect(_detailsTop(tester, detailsKey),
        greaterThan(_viewportMidpoint(tester)));
    expect(_hintOpacity(tester), 1);

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -100),
    );
    await tester.pumpAndSettle();
    expect(_detailsTop(tester, detailsKey),
        lessThanOrEqualTo(_viewportMidpoint(tester)));
    expect(_hintOpacity(tester), 0);
    final position = Scrollable.of(detailsKey.currentContext!).position;
    expect(position.pixels, lessThan(position.maxScrollExtent / 2));

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, 350),
    );
    await tester.pumpAndSettle();
    expect(_hintOpacity(tester), 0);

    await tester.tap(find.byKey(const ValueKey('change-selection')));
    await tester.pumpAndSettle();
    expect(_hintOpacity(tester), 1);
    expect(tester.takeException(), isNull);
  });
}

double _hintOpacity(WidgetTester tester) => tester
    .widget<AnimatedOpacity>(
      find.byKey(const ValueKey('creation-scroll-hint-opacity')),
    )
    .opacity;

double _detailsTop(WidgetTester tester, GlobalKey detailsKey) =>
    tester.getTopLeft(find.byKey(detailsKey)).dy;

double _viewportMidpoint(WidgetTester tester) {
  final viewport = tester.getRect(find.byType(SingleChildScrollView));
  return viewport.top + viewport.height / 2;
}

Future<void> _pumpHintStep(
  WidgetTester tester,
  ValueNotifier<int?> selection,
  GlobalKey detailsKey,
) async {
  final router = GoRouter(
    initialLocation: '/create/race',
    routes: [
      GoRoute(
        path: '/create/race',
        builder: (_, __) => ValueListenableBuilder<int?>(
          valueListenable: selection,
          builder: (context, selected, _) => CreationSelectionStepScaffold(
            route: 'background',
            onBack: () {},
            onPressedNext: () {},
            onStepTap: null,
            scrollHintSelection: selected,
            showJumpButton: selected != null,
            detailsKey: detailsKey,
            onJumpToDetails: () {
              final target = detailsKey.currentContext;
              if (target == null) return;
              Scrollable.ensureVisible(
                target,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                alignment: 0,
              );
            },
            selection: SizedBox(
              height: 520,
              child: Align(
                alignment: Alignment.topCenter,
                child: ElevatedButton(
                  key: const ValueKey('change-selection'),
                  onPressed: () => selection.value = selected == 1 ? 2 : 1,
                  child: const Text('Change selection'),
                ),
              ),
            ),
            details: selected == null
                ? null
                : SizedBox(
                    height: 1000,
                    child: Text('Details for $selected'),
                  ),
          ),
        ),
      ),
    ],
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(child: MaterialApp.router(routerConfig: router)),
  );
  await tester.pumpAndSettle();
}
