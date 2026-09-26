import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/class_race_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('class details show ToolData names instead of raw keys',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          toolCatalogProvider.overrideWith(
            (ref) async => [
              ToolData(
                referenceKey: 'thieves_tools',
                name: 'Воровские инструменты',
              ),
            ],
          ),
        ],
        child: MaterialApp(
          home: ClassRaceDetailsPage(
            character: CharacterData(
              classEntries: [
                CharacterClassEntryData(
                  level: 1,
                  classOrder: 0,
                  classData: ClassData(
                    name: 'Плут',
                    toolTrainingKeys: const ['thieves_tools'],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Воровские инструменты'), findsOneWidget);
    expect(find.text('thieves_tools'), findsNothing);
  });
}
