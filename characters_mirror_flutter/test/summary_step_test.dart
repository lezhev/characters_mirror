import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/summary_step/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('summary step renders grouped sections from draft state',
      (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(characterCreationProvider.notifier);
    notifier.setName('Мелифаро');
    notifier.setRace(
      RaceData(
        id: 1,
        name: 'Человек',
        size: CreatureSize.medium,
        speed: 30,
      ),
    );
    notifier.setBackground(
      BackgroundData(
        id: 2,
        name: 'Мудрец',
      ),
    );
    notifier.applyPrimaryClassSelection(
      classData: ClassData(
        id: 3,
        name: 'Wizard',
        imageURL: 'wizard',
      ),
      level: 3,
      spellSelections: [
        CharacterSpellSelectionData(
          classDataId: 3,
          spell: SpellData(
            referenceKey: 'magic_missile',
            name: 'Magic Missile',
          ),
          spellKey: 'magic_missile',
          kind: CharacterSpellSelectionKind.knownSpell,
          selectionIndex: 0,
        ),
      ],
    );
    notifier.syncAttributesDraft(const {
      'strength': 10,
      'intelligence': 16,
    });
    notifier.setChoices([
      CharacterChoiceData(
        sourceType: ChoiceSourceType.background,
        selectedText: 'Драконий',
      ),
    ]);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: '/create/summary',
            routes: [
              GoRoute(
                path: '/create/summary',
                builder: (_, __) => const SummaryStep(),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Сводка персонажа'), findsOneWidget);
    expect(find.text('Выборы'), findsOneWidget);
    expect(find.text('Базовые характеристики'), findsOneWidget);
    expect(find.text('Мелифаро'), findsOneWidget);
    expect(find.text('Человек'), findsOneWidget);
    expect(find.text('Wizard'), findsOneWidget);
    expect(find.text('Драконий'), findsOneWidget);
    expect(find.text('Magic Missile'), findsOneWidget);
  });
}
