import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart'
    as protocol;
import 'package:characters_mirror_flutter/core/dice/dice_roller.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/roll_results_overlay.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/hit_points_calculator.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/helpers/fight_page_formatters.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/widgets/combat_stat_settings_sheet.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/widgets/combat_stats_row.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/widgets/hit_points_calculator_sheet.dart';
import 'package:characters_mirror_flutter/utils/calculate_max_hp_for_character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

part 'hit_points_calculator_test/hit_points_scenarios.dart';
part 'hit_points_calculator_test/hit_points_sheet_scenarios.dart';

void main() {
  _registerHitPointsCalculatorTests();
  _registerHitPointsSheetTests();
}

class _FakeCharacterRepository extends CharacterRepository {
  _FakeCharacterRepository(this.character);

  protocol.CharacterData character;
  protocol.CharacterData? savedCharacter;
  int saveCallCount = 0;

  @override
  Future<protocol.CharacterData> getCharacter(int characterId) async {
    return character;
  }

  @override
  Future<protocol.CharacterData> saveCharacter(
    protocol.CharacterData character,
  ) async {
    saveCallCount += 1;
    savedCharacter = character;
    this.character = character;
    return character;
  }
}

class _ControlledCharacterRepository extends CharacterRepository {
  _ControlledCharacterRepository(this.character);

  protocol.CharacterData character;
  final savedCharacters = <protocol.CharacterData>[];
  final _saveCompleters = <Completer<protocol.CharacterData>>[];

  @override
  Future<protocol.CharacterData> getCharacter(int characterId) async {
    return character;
  }

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
    final saved = savedCharacters[index];
    character = saved;
    _saveCompleters[index].complete(saved);
  }

  void failSave(int index) {
    _saveCompleters[index].completeError(Exception('save failed'));
  }
}
