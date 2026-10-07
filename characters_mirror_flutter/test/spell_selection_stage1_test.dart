import 'dart:convert';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character_spells/spell_selection_support.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_sync_operations.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_operation_replay.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/state/class_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/spells_step/spells_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  test('legacy intelligence alone does not imply spellbook mode', () {
    final data = ClassData(spellcastingAbilityValue: Ability.intelligence);
    expect(spellMode(data), ClassSpellSelectionMode.known);
    expect(
        spellMode(
            data, ClassLevelData(classDataId: 1, level: 1, spellbookSpells: 6)),
        ClassSpellSelectionMode.spellbook);
    expect(
        spellMode(ClassData(),
            ClassLevelData(classDataId: 1, level: 1, knownCantrips: 1)),
        ClassSpellSelectionMode.known);
    expect(
        spellMode(
            data,
            ClassLevelData(
                classDataId: 1,
                level: 1,
                preparedSpellFormula: 'intelligence modifier + wizard level')),
        ClassSpellSelectionMode.spellbook);
    expect(
        spellMode(
            data.copyWith(spellSelectionMode: ClassSpellSelectionMode.none),
            ClassLevelData(
                classDataId: 1,
                level: 1,
                preparedSpellFormula: 'intelligence modifier + wizard level')),
        ClassSpellSelectionMode.none);
  });
  final shield =
      SpellData(id: 1, referenceKey: 'shield', name: 'Shield', level: 1);
  final sleep =
      SpellData(id: 2, referenceKey: 'sleep', name: 'Sleep', level: 1);
  final wizard = CharacterClassEntryData(
      id: 'wizard-entry',
      level: 1,
      classData: ClassData(
          id: 1,
          name: 'Arbitrary translated name',
          spellSelectionMode: ClassSpellSelectionMode.spellbook));
  final bard = CharacterClassEntryData(
      id: 'bard-entry',
      level: 1,
      classData: ClassData(
          id: 2,
          name: 'Wizard',
          spellSelectionMode: ClassSpellSelectionMode.known));
  CharacterSpellSelectionData selection(
          SpellData spell, CharacterSpellSelectionKind kind,
          {CharacterClassEntryData? entry}) =>
      CharacterSpellSelectionData(
          classEntry: entry ?? wizard,
          classDataId: (entry ?? wizard).classData!.id,
          spell: spell,
          spellId: spell.id,
          spellKey: spell.referenceKey,
          kind: kind);
  final bookGroup = ClassSpellSelectionGroupView(
      classDataId: 1,
      selectionCount: 6,
      kind: CharacterSpellSelectionKind.spellbookSpell,
      options: [shield, sleep]);
  final preparedGroup = ClassSpellSelectionGroupView(
      classDataId: 1,
      selectionCount: 4,
      kind: CharacterSpellSelectionKind.preparedSpell,
      optionSourceSelectionKind: CharacterSpellSelectionKind.spellbookSpell,
      options: [shield, sleep]);

  test('creation state saves book kind and clears dependent preparations',
      () async {
    final container = ProviderContainer(overrides: [
      classRepositoryProvider.overrideWithValue(
          _SpellClassRepository(wizard.classData!, [preparedGroup, bookGroup]))
    ]);
    addTearDown(container.dispose);
    await container.read(classStateProvider.future);
    final controller = container.read(classStateProvider.notifier);
    await controller.selectClass(wizard.classData!);
    controller.toggleSpellSelection(preparedGroup, sleep);
    expect(
        container.read(classStateProvider).requireValue.selectedSpellSelections,
        isEmpty);
    controller.toggleSpellSelection(bookGroup, shield);
    controller.toggleSpellSelection(preparedGroup, shield);
    controller.syncSpellSelectionsToCreationDraft();
    final saved =
        container.read(characterCreationProvider).character.spellSelections!;
    expect(saved.map((s) => s.kind), [
      CharacterSpellSelectionKind.spellbookSpell,
      CharacterSpellSelectionKind.preparedSpell
    ]);
    expect(saved.every((s) => s.classEntry?.classData?.id == 1), isTrue);
    controller.clearSpellSelectionGroup(bookGroup);
    expect(
        container.read(classStateProvider).requireValue.selectedSpellSelections,
        isEmpty);
  });

  test('prepared draft options follow only this class draft spellbook', () {
    final selections = [
      selection(shield, CharacterSpellSelectionKind.spellbookSpell),
      selection(sleep, CharacterSpellSelectionKind.knownSpell),
      selection(sleep, CharacterSpellSelectionKind.spellbookSpell, entry: bard)
    ];
    expect(draftSpellOptions(preparedGroup, selections), [shield]);
    expect(draftSpellOptions(preparedGroup, []), isEmpty);
  });
  test(
      'normalization handles dependency order, duplicates and removed book spells',
      () {
    final selections = [
      selection(shield, CharacterSpellSelectionKind.spellbookSpell),
      selection(shield, CharacterSpellSelectionKind.spellbookSpell),
      selection(shield, CharacterSpellSelectionKind.preparedSpell),
      selection(sleep, CharacterSpellSelectionKind.preparedSpell)
    ];
    final normalized =
        normalizeDraftSpells(selections, [preparedGroup, bookGroup]);
    expect(normalized.map((s) => s.kind), [
      CharacterSpellSelectionKind.spellbookSpell,
      CharacterSpellSelectionKind.preparedSpell
    ]);
    expect(
        normalizeDraftSpells(
            normalized
                .where(
                    (s) => s.kind != CharacterSpellSelectionKind.spellbookSpell)
                .toList(),
            [preparedGroup, bookGroup]),
        isEmpty);
  });
  test(
      'spell page pool uses explicit mode, entry and kind, ignoring class name',
      () {
    final character = CharacterData(classEntries: [
      wizard,
      bard
    ], spellSelections: [
      selection(shield, CharacterSpellSelectionKind.spellbookSpell),
      selection(sleep, CharacterSpellSelectionKind.knownSpell),
      selection(sleep, CharacterSpellSelectionKind.spellbookSpell, entry: bard)
    ]);
    expect(preparationPoolForEntry(character, wizard, null, [shield, sleep]),
        [shield]);
    expect(preparationPoolForEntry(character, bard, null, [shield, sleep]),
        isEmpty);
    final cleric = CharacterClassEntryData(
        id: 'cleric',
        classData: ClassData(
            id: 3,
            name: 'Wizard',
            spellSelectionMode: ClassSpellSelectionMode.prepared));
    final bless =
        SpellData(referenceKey: 'bless', level: 1, availableForClassIds: [3]);
    expect(preparationPoolForEntry(character, cleric, null, [bless, shield]),
        [bless]);
  });
  test('identity keeps entry sources and kinds and uses catalog fallback', () {
    final a = selection(shield, CharacterSpellSelectionKind.spellbookSpell);
    expect(
        selectionIdentity(a),
        isNot(selectionIdentity(
            a.copyWith(kind: CharacterSpellSelectionKind.preparedSpell))));
    expect(selectionIdentity(a),
        isNot(selectionIdentity(a.copyWith(classEntry: bard))));
    expect(
        selectionIdentity(a), selectionIdentity(a.copyWith(classDataId: 999)));
    expect(selectionIdentity(a.copyWith(classEntry: null, classDataId: 1)),
        isNot(selectionIdentity(a.copyWith(classEntry: null, classDataId: 2))));
  });
  test('sync serialization and replay retain all sources and kinds', () {
    final previous =
        CharacterData(id: 42, version: 1, classEntries: [wizard, bard]);
    final next = previous.copyWith(spellSelections: [
      selection(shield, CharacterSpellSelectionKind.spellbookSpell)
          .copyWith(id: 'book'),
      selection(shield, CharacterSpellSelectionKind.preparedSpell)
          .copyWith(id: 'prepared'),
      selection(shield, CharacterSpellSelectionKind.knownSpell, entry: bard)
          .copyWith(id: 'known')
    ]);
    var sequence = 0;
    final operations = buildCharacterSyncOperations(
        previous: previous,
        next: next,
        localId: 42,
        serverId: 42,
        createdAt: DateTime.utc(2026, 10, 5),
        nextChangeId: () => 'change-${sequence++}');
    expect(operations, hasLength(3));
    var replayed = previous;
    for (final operation in operations) {
      final decoded = CharacterSyncOperationData.fromJson(
          jsonDecode(jsonEncode(operation.toJson())) as Map<String, dynamic>);
      replayed = replayCharacterSyncOperation(replayed, decoded);
    }
    expect(replayed.spellSelections!.map(selectionIdentity).toSet(),
        next.spellSelections!.map(selectionIdentity).toSet());
    expect(replayed.spellSelections!.map((s) => s.id).toSet(),
        {'book', 'prepared', 'known'});
  });
  test('manual learning and forgetting preserve other sources', () {
    final character = CharacterData(classEntries: [
      wizard,
      bard
    ], spellSelections: [
      selection(shield, CharacterSpellSelectionKind.spellbookSpell)
          .copyWith(selectionIndex: 4),
      selection(shield, CharacterSpellSelectionKind.knownSpell, entry: bard)
          .copyWith(selectionIndex: 9)
    ]);
    expect(learnedSpellSelection(character, sleep, 1).kind,
        CharacterSpellSelectionKind.spellbookSpell);
    expect(learnedSpellSelection(character, sleep, 2).kind,
        CharacterSpellSelectionKind.knownSpell);
    final kept = forgetSpellSelections(character, shield, 1);
    expect(kept.single.classEntry!.id, bard.id);
    expect(kept.single.selectionIndex, 9);
  });
  test('next spell slot is scoped by class entry and selection kind', () {
    final otherEntry = CharacterClassEntryData(
      id: 'other-wizard-entry',
      classData: wizard.classData,
    );
    final selections = [
      selection(shield, CharacterSpellSelectionKind.knownSpell, entry: wizard)
          .copyWith(selectionIndex: 9),
      selection(shield, CharacterSpellSelectionKind.knownCantrip, entry: wizard)
          .copyWith(selectionIndex: 40),
      selection(shield, CharacterSpellSelectionKind.spellbookSpell,
              entry: wizard)
          .copyWith(selectionIndex: 30),
      selection(shield, CharacterSpellSelectionKind.knownSpell,
              entry: otherEntry)
          .copyWith(selectionIndex: 50),
    ];

    expect(
      nextSpellSelectionIndex(
        selections,
        classEntry: wizard,
        classDataId: wizard.classData!.id,
        kind: CharacterSpellSelectionKind.knownSpell,
      ),
      10,
    );
    expect(
      nextSpellSelectionIndex(
        selections,
        classEntry: wizard,
        classDataId: wizard.classData!.id,
        kind: CharacterSpellSelectionKind.knownCantrip,
      ),
      41,
    );
    expect(
      nextSpellSelectionIndex(
        selections,
        classEntry: wizard,
        classDataId: wizard.classData!.id,
        kind: CharacterSpellSelectionKind.spellbookSpell,
      ),
      31,
    );
    expect(
      nextSpellSelectionIndex(
        selections,
        classEntry: otherEntry,
        classDataId: otherEntry.classData!.id,
        kind: CharacterSpellSelectionKind.knownSpell,
      ),
      51,
    );
  });
  test('preparing creates prepared kind without learning or copying to book',
      () {
    final character = CharacterData(classEntries: [
      wizard
    ], spellSelections: [
      selection(shield, CharacterSpellSelectionKind.spellbookSpell)
    ]);
    final selections = prepareSpellSelections(character, shield, 1, true);
    expect(selections.map((s) => s.kind), [
      CharacterSpellSelectionKind.spellbookSpell,
      CharacterSpellSelectionKind.preparedSpell
    ]);
    expect(() => prepareSpellSelections(character, sleep, 1, true),
        throwsStateError);
  });
  test('JSON and offline reference cache retain new nullable fields and kinds',
      () async {
    final cache = OfflineCacheDatabase.openInMemory();
    addTearDown(cache.close);
    final character = CharacterData(classEntries: [
      wizard,
      bard
    ], spellSelections: [
      selection(shield, CharacterSpellSelectionKind.spellbookSpell),
      selection(shield, CharacterSpellSelectionKind.preparedSpell),
      selection(shield, CharacterSpellSelectionKind.knownSpell, entry: bard)
    ]);
    final local = await cache.saveLocal(7, character);
    final loaded = await cache.getCharacter(7, local.localId);
    expect(loaded!.character.spellSelections, hasLength(3));
    expect(loaded.character.classEntries!.first.classData!.spellSelectionMode,
        ClassSpellSelectionMode.spellbook);
    expect(loaded.character.spellSelections!.first.kind,
        CharacterSpellSelectionKind.spellbookSpell);
    final row = ClassLevelData(
        classDataId: 1,
        level: 2,
        spellbookSpells: 8,
        knownSpellReplacements: 1,
        preparedSpellRule: PreparedSpellRuleData(
            ability: Ability.intelligence,
            rounding: PreparedSpellRounding.floor));
    final roundTrip = ClassLevelData.fromJson(
        jsonDecode(jsonEncode(row.toJson())) as Map<String, dynamic>);
    expect(preparedLimit(roundTrip, {'intelligence': 16}), 5);
    await cache.putReferenceList(
        'class_level', 'all', [row], (value) => value.toJson());
    final cachedRows = await cache.getReferenceList(
        'class_level', 'all', ClassLevelData.fromJson);
    expect(cachedRows!.single.spellbookSpells, 8);
    expect(cachedRows.single.knownSpellReplacements, 1);
    expect(preparedLimit(cachedRows.single, {'intelligence': 16}), 5);
    final old = ClassData.fromJson({'name': 'Old caster'});
    expect(old.spellSelectionMode, isNull);
    final oldRow = ClassLevelData.fromJson({
      'classDataId': 1,
      'level': 2,
      'preparedSpellFormula': 'charisma modifier + paladin level'
    });
    expect(oldRow.spellbookSpells, isNull);
    expect(preparedLimit(oldRow, {'charisma': 16}), 4);
  });
  testWidgets(
      'Wizard prepared selector renders only selected draft book spells',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ClassSpellSelectionSection(groups: [
      preparedGroup
    ], selections: [
      selection(shield, CharacterSpellSelectionKind.spellbookSpell)
    ], onToggleSpell: (_, __) {}, onClearGroup: (_) {}))));
    await tester.tap(find.text('Подготовленные заклинания'));
    await tester.pumpAndSettle();
    expect(find.text('Shield'), findsOneWidget);
    expect(find.text('Sleep'), findsNothing);
  });
}

class _SpellClassRepository extends ClassRepository {
  _SpellClassRepository(this.data, this.groups);
  final ClassData data;
  final List<ClassSpellSelectionGroupView> groups;
  @override
  Future<List<ClassData>> getAll() async => [data];
  @override
  Future<ClassStepView> getStepView(int classId,
          {int selectedLevel = 1,
          bool isStartingClass = true,
          int? selectedSubclassId,
          Map<String, int>? abilityScores}) async =>
      ClassStepView(
          classData: data,
          selectedLevel: selectedLevel,
          spellSelectionGroups: groups);
}
