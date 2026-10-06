import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/repositories/reference_character_repository.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/level_up/presentation/level_down_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeCharacterRepository extends CharacterRepository {
  _FakeCharacterRepository(this.saved);

  final CharacterData saved;
  LevelDownRequest? request;

  @override
  Future<CharacterData> applyLevelDown(LevelDownRequest request) async {
    this.request = request;
    return saved;
  }
}

void main() {
  testWidgets('level-down page applies request and returns the saved character',
      (tester) async {
    final saved = CharacterData(id: 17, version: 6);
    final repository = _FakeCharacterRepository(saved);
    final navigatorKey = GlobalKey<NavigatorState>();
    final request = LevelDownRequest(
      characterId: 17,
      expectedVersion: 5,
      classEntryId: 'warlock-entry',
    );

    await tester.pumpWidget(ProviderScope(
      overrides: [characterRepositoryProvider.overrideWithValue(repository)],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        home: const Scaffold(body: Text('Character sheet')),
      ),
    ));
    navigatorKey.currentState!.push<CharacterData>(MaterialPageRoute(
      builder: (_) => LevelDownPage(request: request),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Понижение уровня'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('level-down-apply')));
    await tester.pumpAndSettle();

    expect(repository.request, same(request));
    expect(find.text('Character sheet'), findsOneWidget);
    expect(find.text('Понижение уровня'), findsNothing);
  });
}
