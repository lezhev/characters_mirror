import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/spell_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('spell page separates always prepared and selected spells',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SpellPageContent(
            character: CharacterData(
              spellSelections: [
                CharacterSpellSelectionData(
                  spell: SpellData(
                    referenceKey: 'magic_missile',
                    name: 'Magic Missile',
                  ),
                  spellKey: 'magic_missile',
                  kind: CharacterSpellSelectionKind.knownSpell,
                  selectionIndex: 0,
                ),
              ],
              derived: CharacterDerivedData(
                spellSlots: const {1: 2},
                pactSlots: const {2: 1},
                grantedSpellKeys: const [
                  'bless',
                  'magic_missile',
                  'thaumaturgy',
                ],
                alwaysPreparedSpellKeys: const ['bless'],
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Заклинания'), findsOneWidget);
    expect(find.text('Всегда наготове'), findsOneWidget);
    expect(find.text('bless'), findsOneWidget);
    expect(find.text('Известные заклинания'), findsOneWidget);
    expect(find.text('Magic Missile'), findsOneWidget);
    expect(find.text('Прочие источники'), findsOneWidget);
    expect(find.text('thaumaturgy'), findsOneWidget);
    expect(find.text('1 ур. x2'), findsOneWidget);
    expect(find.text('Договор: 2 ур. x1'), findsOneWidget);
  });

  testWidgets('spell page keeps always prepared spells without selections',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SpellPageContent(
            character: CharacterData(
              spellSelections: const [],
              derived: CharacterDerivedData(
                grantedSpellKeys: const ['shield'],
                alwaysPreparedSpellKeys: const ['shield'],
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Всегда наготове'), findsOneWidget);
    expect(find.text('shield'), findsOneWidget);
    expect(find.text('Известные заклинания'), findsNothing);
    expect(find.text('Заклинаний пока нет'), findsNothing);
  });
}
