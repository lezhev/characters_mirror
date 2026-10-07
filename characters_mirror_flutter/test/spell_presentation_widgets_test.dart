import 'dart:io';
import 'dart:ui' as ui;
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/spell_card.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/spell_page.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/roll_results_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'fixtures/representative_spells.dart';

const _capture = bool.fromEnvironment('SPELL_UI_SCREENSHOTS');
void main() {
  for (final spell in representativeSpells()) {
    testWidgets('universal collapsed/expanded 320px: ${spell.name}',
        (tester) async {
      tester.view.physicalSize = const Size(320, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      if (_capture) {
        await tester.runAsync(() async {
          final loader = FontLoader('VerificationUI')
            ..addFont(File('C:/Windows/Fonts/segoeui.ttf')
                .readAsBytes()
                .then((b) => ByteData.sublistView(b)));
          await loader.load();
        });
      }
      final boundary = GlobalKey();
      await tester.pumpWidget(RepaintBoundary(
          key: boundary,
          child: MaterialApp(
              theme: ThemeData(fontFamily: _capture ? 'VerificationUI' : null),
              home: Scaffold(
                  body: ListView(padding: const EdgeInsets.all(12), children: [
                SpellCard(
                    spell: spell,
                    presentationContext: const SpellPresentationContext(
                        casterLevel: 7,
                        castLevel: 3,
                        attackBonus: 6,
                        saveDc: 14),
                    trailing: const Icon(Icons.auto_awesome)),
              ])))));
      await tester.pumpAndSettle();
      final description = spellDescriptionText(spell.description)!;
      expect(find.text(description), findsNothing);
      expect(tester.takeException(), isNull);
      if (_capture && spell.referenceKey == 'fixture_0') {
        await _save(tester, boundary, 'collapsed');
      }
      await tester.tap(find.byType(SpellCard));
      await tester.pumpAndSettle();
      expect(find.text(description), findsOneWidget);
      final text = tester.widget<Text>(find.text(description));
      expect(text.maxLines, isNull);
      expect(text.overflow, isNot(TextOverflow.ellipsis));
      expect(tester.takeException(), isNull);
      if (_capture && spell.referenceKey == 'fixture_0') {
        await _save(tester, boundary, 'expanded');
      }
    });
  }

  testWidgets(
      'cast chooser previews upcast and spends explicitly selected pact source',
      (tester) async {
    final spell = SpellData(
        referenceKey: 'spell',
        name: 'Заклинание',
        level: 1,
        damageDice: '1d6',
        damageScaling: SpellScalingData(
            mode: SpellScalingMode.slotLevel, scalingBySlotLevel: {3: '3d6'}));
    final source = SpellSourceContextData(
        sourceKey: 'class:1',
        label: 'Wizard',
        castingAbility: Ability.intelligence,
        known: true,
        prepared: true,
        alwaysPrepared: true,
        granted: true,
        canUseSlots: true);
    SpellCastContext? selected;
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: SpellPageContent(
      onSpellCastContext: (_, cast) async => selected = cast,
      character: CharacterData(
          derived: CharacterDerivedData(spellSlots: {
        1: 1,
        3: 1
      }, pactSlots: {
        3: 2
      }, resolvedSpells: [
        ResolvedCharacterSpellData(
            spellKey: 'spell', spell: spell, sources: [source])
      ])),
    ))));
    await tester.tap(find.byKey(const ValueKey('cast-spell-spell')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('spell-cast-choice-2')));
    await tester.pump();
    expect(find.text('Урон: 3к6'), findsOneWidget);
    await tester.tap(find.text('Наложить'));
    await tester.pumpAndSettle();
    expect(selected!.castLevel, 3);
    expect(selected!.slotSource, SpellSlotSource.pact);
    expect(selected!.source.sourceKey, 'class:1');
  });

  testWidgets('one card retains wizard and cleric ability choice',
      (tester) async {
    final spell = SpellData(
        referenceKey: 'spell',
        name: 'Общий заговор',
        level: 0,
        attackType: SpellAttackType.rangedSpell);
    SpellSourceContextData source(int id, Ability ability, String name) =>
        SpellSourceContextData(
            sourceKey: 'class:$id',
            label: name,
            castingAbility: ability,
            known: true,
            prepared: true,
            alwaysPrepared: false,
            granted: false,
            canUseSlots: true);
    SpellCastContext? selected;
    await tester.pumpWidget(MaterialApp(
        home: RollResultsOverlay(
            child: Scaffold(
                body: SpellPageContent(
      onSpellCastContext: (_, cast) async => selected = cast,
      character: CharacterData(
          derived: CharacterDerivedData(proficiencyBonus: 3, abilityModifiers: {
        Ability.intelligence: 4,
        Ability.wisdom: 1
      }, resolvedSpells: [
        ResolvedCharacterSpellData(spellKey: 'spell', spell: spell, sources: [
          source(1, Ability.intelligence, 'Wizard'),
          source(2, Ability.wisdom, 'Cleric')
        ]),
      ])),
    )))));
    expect(find.text('Общий заговор'), findsOneWidget);
    expect(find.text('Атака: Дальняя +7'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('cast-spell-spell')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('spell-cast-choice-1')));
    await tester.pump();
    expect(find.text('Атака: Дальняя +4'), findsOneWidget);
    await tester.tap(find.text('Наложить'));
    await tester.pumpAndSettle();
    expect(selected!.castingAbility, 'wisdom');
  });
}

Future<void> _save(WidgetTester tester, GlobalKey key, String name) async {
  await tester.runAsync(() async {
    final boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 1);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    final file =
        File('D:/SUAI/characters_mirror/.tmp/spell-refactor-$name-320.png');
    await file.writeAsBytes(data!.buffer.asUint8List());
    image.dispose();
  });
}
