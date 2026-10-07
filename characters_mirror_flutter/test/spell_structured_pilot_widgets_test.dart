import 'dart:convert';
import 'dart:io';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/spell_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final manifest = (jsonDecode(
              File('../docs/spell-structured-pilot.json').readAsStringSync())
          as List)
      .cast<Map<String, dynamic>>();
  for (final entry in manifest) {
    final spell = SpellData.fromJson({
      ...entry['before'] as Map<String, dynamic>,
      ...entry['changes'] as Map<String, dynamic>,
    });
    testWidgets('real pilot card 320px large text: ${spell.referenceKey}',
        (tester) async {
      tester.view.physicalSize = const Size(320, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(MaterialApp(
          builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.3)),
              child: child!),
          home: Scaffold(
              body: ListView(padding: const EdgeInsets.all(12), children: [
            SpellCard(
                spell: spell,
                presentationContext: SpellPresentationContext(
                    casterLevel: 17,
                    castLevel: (spell.level ?? 0) == 0 ? 0 : 9,
                    abilityModifier: 4,
                    attackBonus: 7,
                    saveDc: 15))
          ]))));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.tap(find.text(spell.name!));
      await tester.pumpAndSettle();
      final full = spellDescriptionText(spell.description)!;
      expect(find.text(full), findsOneWidget);
      final text = tester.widget<Text>(find.text(full));
      expect(text.maxLines, isNull);
      expect(text.overflow, isNot(TextOverflow.ellipsis));
      expect(tester.takeException(), isNull);
    });
  }
}
