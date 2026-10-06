import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/features/level_up/presentation/level_up_spells.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

SpellData spell(int id, {int level = 1}) => SpellData(
    id: id,
    name: 'Spell $id',
    level: level,
    castingTime: '1 действие',
    range: '60 футов',
    duration: '1 минута',
    description: 'Full description $id');

LevelUpPreview preview(CharacterSpellSelectionKind kind,
        {bool replacement = false, int count = 1}) =>
    LevelUpPreview(
        before: CharacterData(spellSelections: [
          CharacterSpellSelectionData(
              id: 'old-selection',
              classEntry: CharacterClassEntryData(id: 'entry'),
              kind: CharacterSpellSelectionKind.knownSpell,
              spellId: 9,
              spell: spell(9)),
        ]),
        character: CharacterData(),
        classStep: ClassStepView(spellSelectionGroups: [
          ClassSpellSelectionGroupView(kind: kind, options: [
            spell(1,
                level:
                    kind == CharacterSpellSelectionKind.knownCantrip ? 0 : 1),
            spell(2, level: 2),
            spell(3, level: 2),
          ])
        ]),
        choiceGroups: [],
        missingDecisions: [],
        spellDelta: ClassSpellDeltaView(
            cantripsToAdd:
                !replacement && kind == CharacterSpellSelectionKind.knownCantrip
                    ? count
                    : 0,
            knownSpellsToAdd:
                !replacement && kind == CharacterSpellSelectionKind.knownSpell
                    ? count
                    : 0,
            spellbookSpellsToAdd: !replacement &&
                    kind == CharacterSpellSelectionKind.spellbookSpell
                ? count
                : 0,
            knownSpellReplacements: replacement ? 1 : 0));

LevelUpRequest request({List<LevelUpSpellChoice>? choices}) => LevelUpRequest(
    characterId: 1, expectedVersion: 1, classEntryId: 'entry', spells: choices);

Future<void> pumpSpells(WidgetTester tester, LevelUpPreview data,
        {LevelUpRequest? draft,
        required void Function(CharacterSpellSelectionKind, List<int>, String?)
            onChanged}) =>
    tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: LevelUpSpells(
                preview: data,
                request: draft ?? request(),
                onChanged: onChanged))));

Finder card(int id) => find.widgetWithText(Card, 'Spell $id');
Finder checkbox(int id) =>
    find.descendant(of: card(id), matching: find.byType(Checkbox));
Finder info(int id) =>
    find.descendant(of: card(id), matching: find.byIcon(Icons.info_outline));

Future<void> inspect(WidgetTester tester, int id) async {
  await tester.tap(info(id));
  await tester.pumpAndSettle();
  expect(find.text('Full description $id'), findsOneWidget);
  await tester.tap(find.text('Закрыть'));
  await tester.pumpAndSettle();
}

void main() {
  for (final kind in [
    CharacterSpellSelectionKind.knownCantrip,
    CharacterSpellSelectionKind.knownSpell,
    CharacterSpellSelectionKind.spellbookSpell
  ]) {
    testWidgets('$kind uses spell cards and separates selection from details',
        (tester) async {
      List<int>? chosen;
      await pumpSpells(tester, preview(kind), onChanged: (k, ids, replaces) {
        expect(k, kind);
        expect(replaces, isNull);
        chosen = ids;
      });
      await tester.tap(find.text(
          kind == CharacterSpellSelectionKind.knownCantrip
              ? 'Заговоры'
              : 'Заклинания'));
      await tester.pumpAndSettle();
      expect(card(1), findsOneWidget);
      expect(tester.getCenter(checkbox(1)).dx,
          lessThan(tester.getCenter(find.text('Spell 1')).dx));
      expect(tester.getCenter(info(1)).dx,
          greaterThan(tester.getCenter(find.text('Spell 1')).dx));
      expect(find.text('60 футов'), findsWidgets);
      expect(find.text('Full description 1'), findsNothing);
      await inspect(tester, 1);
      expect(tester.widget<Checkbox>(checkbox(1)).value, false);
      await tester.tap(find.text('Spell 1'));
      await tester.pump();
      expect(tester.widget<Checkbox>(checkbox(1)).value, true);
      expect(find.byType(AlertDialog), findsNothing);
      await inspect(tester, 1);
      expect(tester.widget<Checkbox>(checkbox(1)).value, true);
      await tester.tap(checkbox(1));
      await tester.pump();
      expect(tester.widget<Checkbox>(checkbox(1)).value, false);
      await tester.tap(find.text('Spell 2'));
      await tester.pump();
      await tester.tap(find.text('Готово'));
      await tester.pumpAndSettle();
      expect(chosen, [2]);
    });
  }

  testWidgets(
      'full selection still allows inspecting an unselected spell and filtering',
      (tester) async {
    await pumpSpells(
        tester, preview(CharacterSpellSelectionKind.knownSpell, count: 2),
        onChanged: (_, __, ___) {});
    await tester.tap(find.text('Заклинания'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Spell 1'));
    await tester.tap(find.text('Spell 2'));
    await tester.pump();
    expect(tester.widget<Checkbox>(checkbox(3)).onChanged, isNull);
    await inspect(tester, 3);
    expect(find.text('Выбрано 2 / 2'), findsOneWidget);
    await tester.tap(find.text('2 уровень'));
    await tester.pump();
    expect(card(1), findsNothing);
    await tester.enterText(find.byType(TextField), 'Spell 3');
    await tester.pump();
    expect(card(2), findsNothing);
    expect(card(3), findsOneWidget);
  });

  testWidgets(
      'both replacement pickers use spell cards and preserve selection IDs',
      (tester) async {
    List<int>? chosen;
    String? replaced;
    await pumpSpells(tester,
        preview(CharacterSpellSelectionKind.knownSpell, replacement: true),
        onChanged: (_, ids, id) {
      chosen = ids;
      replaced = id;
    });
    await tester.tap(find.text('Заменить заклинание'));
    await tester.pumpAndSettle();
    expect(card(9), findsOneWidget);
    await inspect(tester, 9);
    await tester.tap(find.text('Spell 9'));
    await tester.pump();
    await tester.tap(find.text('Готово'));
    await tester.pumpAndSettle();
    expect(card(1), findsOneWidget);
    await inspect(tester, 1);
    await tester.tap(find.text('Spell 1'));
    await tester.pump();
    await tester.tap(find.text('Готово'));
    await tester.pumpAndSettle();
    expect(chosen, [1]);
    expect(replaced, 'old-selection');
  });

  testWidgets('hub draft spells use cards whose taps remove the selection',
      (tester) async {
    final updates = <(List<int>, String?)>[];
    await pumpSpells(
        tester,
        preview(CharacterSpellSelectionKind.knownSpell, replacement: true)
            .copyWith(
                spellDelta: ClassSpellDeltaView(
                    cantripsToAdd: 0,
                    knownSpellsToAdd: 1,
                    spellbookSpellsToAdd: 0,
                    knownSpellReplacements: 1)),
        draft: request(choices: [
          LevelUpSpellChoice(
              kind: CharacterSpellSelectionKind.knownSpell, spellId: 1),
          LevelUpSpellChoice(
              kind: CharacterSpellSelectionKind.knownSpell,
              spellId: 2,
              replacesSelectionId: 'old-selection')
        ]),
        onChanged: (_, ids, replaces) => updates.add((ids, replaces)));
    expect(card(1), findsOneWidget);
    expect(card(2), findsOneWidget);
    await inspect(tester, 1);
    await inspect(tester, 2);
    expect(updates, isEmpty);
    await tester.tap(find.text('Spell 1'));
    await tester.pump();
    expect(updates.last.$1, isEmpty);
    expect(updates.last.$2, isNull);
    await tester.tap(checkbox(2));
    await tester.pump();
    expect(updates.last.$1, isEmpty);
    expect(updates.last.$2, 'old-selection');
  });

  testWidgets('selection cards fit a narrow screen in the app theme',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(
        theme: darkTheme,
        home: Scaffold(
            body: LevelUpSpells(
                preview: preview(CharacterSpellSelectionKind.knownSpell),
                request: request(),
                onChanged: (_, __, ___) {}))));
    await tester.tap(find.text('Заклинания'));
    await tester.pumpAndSettle();
    expect(card(1), findsOneWidget);
    expect(tester.takeException(), isNull);
    await inspect(tester, 1);
    expect(tester.takeException(), isNull);
  });
}
