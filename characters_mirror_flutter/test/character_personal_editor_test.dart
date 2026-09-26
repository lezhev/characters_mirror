import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_save_timing.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/character_personal_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'external canonical value updates a focused clean controller without save',
      (tester) async {
    var character = CharacterData(id: 1, name: 'PHONE');
    var saveCount = 0;
    late StateSetter rebuild;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              rebuild = setState;
              return SingleChildScrollView(
                child: CharacterPersonalEditor(
                  character: character,
                  onChanged: ({
                    name,
                    age,
                    height,
                    weight,
                    eyes,
                    skin,
                    hair,
                    alignmentValue,
                    appearance,
                    backstory,
                    goals,
                    alliesOrganizations,
                    personalityTraits,
                    ideals,
                    bonds,
                    flaws,
                  }) async {
                    saveCount += 1;
                  },
                ),
              );
            },
          ),
        ),
      ),
    );

    final nameField = find.byWidgetPredicate(
      (widget) => widget is TextField && widget.decoration?.labelText == 'Имя',
    );
    await tester.tap(nameField);
    expect(tester.widget<TextField>(nameField).controller?.text, 'PHONE');

    rebuild(() {
      character = CharacterData(id: 1, name: 'WEB', version: 2);
    });
    await tester.pump();

    expect(tester.widget<TextField>(nameField).controller?.text, 'WEB');
    await tester.pump(characterSheetAutosaveDelay);
    expect(saveCount, 0);
  });
}
