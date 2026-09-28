import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_selection_step_scaffold.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_step_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('loading to loaded selection keeps the creation shell mounted',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final isLoaded = ValueNotifier(false);
    addTearDown(isLoaded.dispose);
    final router = GoRouter(
      initialLocation: '/create/race',
      routes: [
        GoRoute(
          path: '/create/race',
          builder: (_, __) => ValueListenableBuilder<bool>(
            valueListenable: isLoaded,
            builder: (context, loaded, _) => loaded
                ? CreationSelectionStepScaffold(
                    route: 'background',
                    onBack: () {},
                    onStepTap: null,
                    onPressedNext: () {},
                    selection: const Text('loaded selection'),
                  )
                : CreationSelectionStepScaffold.loading(
                    route: 'background',
                    onBack: () {},
                  ),
          ),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(child: MaterialApp.router(routerConfig: router)),
    );
    await tester.pump();

    final shellBeforeLoad = tester.element(find.byType(CreationStepScaffold));
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(CreationStepScaffold), findsOneWidget);

    isLoaded.value = true;
    await tester.pump();

    expect(find.text('loaded selection'), findsOneWidget);
    expect(
      identical(
        shellBeforeLoad,
        tester.element(find.byType(CreationStepScaffold)),
      ),
      isTrue,
    );
    expect(tester.takeException(), isNull);
  });
}
