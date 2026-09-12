import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart'
    as protocol;
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/roll_results_overlay.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_save_timing.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/attributes/attributes_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/attributes/widgets/expertise_flag_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'attributes_page_test/attributes_page_scenarios.dart';

void main() {
  _registerAttributesPageTests();
}

protocol.CharacterSkillProficiencyLevel? _savedSkillLevel(
  _FakeCharacterRepository repository,
  protocol.Skill skill,
) {
  final savedSkills = repository.charactersById[1]?.manualSkillProficiencies;
  return savedSkills?.firstWhere((state) => state.skill == skill).level;
}

Future<void> _pumpAttributesPage(
  WidgetTester tester,
  _FakeCharacterRepository repository, {
  Size surfaceSize = const Size(800, 900),
}) async {
  await tester.binding.setSurfaceSize(surfaceSize);
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        characterRepositoryProvider.overrideWithValue(repository),
      ],
      child: MaterialApp(
        theme: darkTheme,
        home: RollResultsOverlay(
          child: Scaffold(
            body: AttributesPage(
              characterId: 1,
              onClose: _noop,
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _pumpCharacterSheetAutosave(WidgetTester tester) async {
  await tester.pump(characterSheetAutosaveDelay);
  await tester.pump();
}

void _noop() {}

Finder _skillToggleTapTarget(WidgetTester tester, protocol.Skill skill) {
  final toggle = find.byKey(ValueKey('skill-toggle-${skill.name}'));
  return find.descendant(
    of: toggle,
    matching: find.byType(InkResponse),
  );
}

class _FakeCharacterRepository extends CharacterRepository {
  _FakeCharacterRepository({
    required Map<int, protocol.CharacterData> charactersById,
  }) : _charactersById = Map<int, protocol.CharacterData>.from(charactersById);

  final Map<int, protocol.CharacterData> _charactersById;

  Map<int, protocol.CharacterData> get charactersById => _charactersById;

  @override
  Future<protocol.CharacterData> getCharacter(int characterId) async {
    final character = _charactersById[characterId];
    if (character == null) {
      throw Exception('Character not found');
    }
    return character;
  }

  @override
  Future<protocol.CharacterData> saveCharacter(
    protocol.CharacterData character,
  ) async {
    final id = character.id ?? 1;
    final saved = character.copyWith(id: id);
    _charactersById[id] = saved;
    return saved;
  }

  @override
  Future<List<protocol.CharacterData>> getAll() async {
    return _charactersById.values.toList();
  }

  @override
  Future<protocol.CharacterData?> getById(int id) async {
    return _charactersById[id];
  }

  @override
  Future<protocol.CharacterData> upsert(protocol.CharacterData entity) {
    return saveCharacter(entity);
  }

  @override
  Future<void> delete(int id) async {
    _charactersById.remove(id);
  }
}

class _DelayedCharacterRepository extends _FakeCharacterRepository {
  _DelayedCharacterRepository({
    required super.charactersById,
  });

  final savedCharacters = <protocol.CharacterData>[];
  final _saveCompleters = <Completer<protocol.CharacterData>>[];

  int get pendingSaveCount => _saveCompleters.length;

  @override
  Future<protocol.CharacterData> saveCharacter(
    protocol.CharacterData character,
  ) {
    savedCharacters.add(character);
    final completer = Completer<protocol.CharacterData>();
    _saveCompleters.add(completer);
    return completer.future;
  }

  void completeSave(int index) {
    final saved = savedCharacters[index].copyWith(
      id: savedCharacters[index].id ?? 1,
    );
    charactersById[saved.id ?? 1] = saved;
    _saveCompleters[index].complete(saved);
  }
}
