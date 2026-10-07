import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/spell_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('escaped newlines become paragraphs without changing stored text',
      (tester) async {
    const stored = r'Первый абзац.\n\nВторой абзац.';
    final spell = SpellData(name: 'Описание', description: stored);
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: SpellDetailsDialog(spell: spell)),
    ));
    expect(find.text('Первый абзац.\n\nВторой абзац.'), findsOneWidget);
    expect(spell.description, stored);
  });
}
