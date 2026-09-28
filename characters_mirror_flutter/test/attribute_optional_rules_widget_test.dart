import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/widgets/attribute_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'optional rules are hidden without a race and retained when shown',
      (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await tester.binding.setSurfaceSize(const Size(1024, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(body: Column(children: [AttributeSelection()])),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final optionalRules =
        find.byKey(const ValueKey('attribute-optional-rules'));
    expect(optionalRules, findsNothing);

    container
        .read(characterCreationProvider.notifier)
        .setUseFlexibleAbilityBonuses(true);
    container.read(characterCreationProvider.notifier).syncRaceDraft(
          selectedRace: RaceData(name: 'Unpersisted race'),
        );
    await tester.pump();
    expect(optionalRules, findsNothing);

    container.read(characterCreationProvider.notifier).syncRaceDraft(
          selectedRace: RaceData(id: 1, name: 'Human'),
        );
    await tester.pump();

    expect(optionalRules, findsOneWidget);
    expect(tester.widget<SwitchListTile>(optionalRules).value, isTrue);
    expect(
      tester.getRect(optionalRules).top,
      greaterThan(
        tester
            .getRect(find.byKey(const ValueKey('attribute-value-strength')))
            .bottom,
      ),
    );
    expect(tester.takeException(), isNull);
  });
}
