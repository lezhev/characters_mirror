import 'dart:async';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/level_up/data/level_up_gateway.dart';
import 'package:characters_mirror_flutter/features/level_up/presentation/level_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _PendingGateway implements LevelUpGateway {
  final pending = <Completer<LevelUpPreview>>[];
  @override
  Future<LevelUpPreview> preview(LevelUpRequest request) {
    final result = Completer<LevelUpPreview>();
    pending.add(result);
    return result.future;
  }

  @override
  Future<CharacterData> apply(LevelUpRequest request) async => CharacterData();
}

void main() {
  testWidgets(
      'background previews allow repeated taps and child navigation without a footer spinner',
      (tester) async {
    final gateway = _PendingGateway();
    final entry = CharacterClassEntryData(
        id: 'entry',
        level: 3,
        classData: ClassData(id: 1, name: 'Class', hitDieValue: 8));
    final preview = LevelUpPreview(
        before: CharacterData(
            classEntries: [entry],
            derived: CharacterDerivedData(
                abilityScores: {Ability.constitution: 15}, totalLevel: 3)),
        character: CharacterData(
            classEntries: [entry.copyWith(level: 4)],
            derived: CharacterDerivedData(
                abilityScores: {Ability.constitution: 15}, totalLevel: 4)),
        classStep: ClassStepView(),
        missingDecisions: ['ASI'],
        choiceGroups: [
          ChoiceGroupView(
              group: ChoiceGroupData(
                  referenceKey: 'asi',
                  type: ChoiceType.abilityIncrease,
                  allowDuplicates: true,
                  selectionCount: 2),
              options: [
                ChoiceOptionData(
                    choiceGroupId: 1,
                    optionKey: 'con',
                    grantedAbilityBonuses: {'constitution': 1})
              ])
        ],
        spellDelta: ClassSpellDeltaView(
            cantripsToAdd: 0,
            knownSpellsToAdd: 0,
            spellbookSpellsToAdd: 0,
            knownSpellReplacements: 0));
    await tester.pumpWidget(ProviderScope(
        overrides: [levelUpGatewayProvider.overrideWithValue(gateway)],
        child: MaterialApp(
            home: LevelUpPage(
                request: LevelUpRequest(
                    characterId: 1,
                    expectedVersion: 1,
                    classEntryId: 'entry',
                    hitDieRoll: 5)))));
    gateway.pending.single.complete(preview);
    await tester.pumpAndSettle();
    final con = find.byKey(const ValueKey('asi-constitution'));
    await tester.ensureVisible(con);
    await tester.tap(con);
    await tester.pump();
    await tester.tap(con);
    await tester.pump();
    expect(find.text('Характеристики · 2 / 2'), findsOneWidget);
    expect(gateway.pending.length, 3);
    expect(find.byType(LinearProgressIndicator), findsNothing);
    expect(
        tester
            .widget<FilledButton>(find.byKey(const ValueKey('level-up-apply')))
            .onPressed,
        isNull);
    await tester.tap(find.text('Выбрать черту'));
    await tester.pumpAndSettle();
    expect(find.text('Черты'), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Характеристики · 2 / 2'), findsOneWidget);
    for (final pending in gateway.pending.skip(1)) {
      pending.complete(preview);
    }
    await tester.pump();
  });
}
