import 'package:characters_mirror_client/characters_mirror_client.dart'
    as protocol;
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/feature_tag_widgets.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/abilities_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('abilities page writes feature tag filter through shared grid',
      (tester) async {
    final repository = _FakeCharacterRepository(
      protocol.CharacterData(
        id: 1,
        derived: protocol.CharacterDerivedData(
          activeFeatures: [
            protocol.CharacterFeatureViewData(
              sourceType: protocol.CharacterFeatureSourceType.classFeature,
              sourceId: 1,
              name: 'Second Wind',
              description: 'Regain hit points.',
              defaultTags: const [protocol.FeatureTag.combat],
            ),
          ],
        ),
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          characterRepositoryProvider.overrideWithValue(repository),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: AbilitiesPage(characterId: 1),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final container = ProviderScope.containerOf(
      tester.element(find.byType(AbilitiesPage)),
    );
    expect(
      container.read(selectedFightFeatureTagsProvider(1)),
      contains(protocol.FeatureTag.combat),
    );

    expect(find.byType(FeatureTagSelectionGrid), findsOneWidget);
    expect(find.byType(FilterChip), findsNothing);
    expect(
      tester.getTopLeft(find.text('Теги способностей')).dy,
      greaterThan(tester.getTopLeft(find.text('Second Wind')).dy),
    );

    final combatTile = find.byKey(const ValueKey('feature-tag-tile-combat'));
    await tester.ensureVisible(combatTile);
    await tester.tap(combatTile);
    await tester.pump();

    expect(
      container.read(selectedFightFeatureTagsProvider(1)),
      isNot(contains(protocol.FeatureTag.combat)),
    );
  });
}

class _FakeCharacterRepository extends CharacterRepository {
  _FakeCharacterRepository(this.character);

  protocol.CharacterData character;

  @override
  Future<protocol.CharacterData> getCharacter(int characterId) async {
    return character;
  }

  @override
  Future<protocol.CharacterData?> getById(int id) async {
    return character;
  }

  @override
  Future<List<protocol.CharacterData>> getAll() async {
    return [character];
  }

  @override
  Future<protocol.CharacterData> saveCharacter(
    protocol.CharacterData character,
  ) async {
    this.character = character;
    return character;
  }

  @override
  Future<protocol.CharacterData> upsert(protocol.CharacterData entity) {
    return saveCharacter(entity);
  }

  @override
  Future<void> delete(int id) async {}
}
