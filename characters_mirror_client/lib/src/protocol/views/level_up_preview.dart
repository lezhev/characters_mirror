/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:characters_mirror_client/src/protocol/protocol.dart'
    as _isnx6jbi;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../data/general/character/character_data.dart' as _iokyyhkm;
import '../views/choice_group_view.dart' as _i8vdv0v3;
import '../views/class_spell_delta_view.dart' as _idq5r9zx;
import '../views/class_step_view.dart' as _i84fjfjk;

abstract class LevelUpPreview
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LevelUpPreview._({
    required this.before,
    required this.character,
    required this.classStep,
    required this.choiceGroups,
    required this.spellDelta,
    required this.missingDecisions,
  });

  factory LevelUpPreview({
    required _iokyyhkm.CharacterData before,
    required _iokyyhkm.CharacterData character,
    required _i84fjfjk.ClassStepView classStep,
    required List<_i8vdv0v3.ChoiceGroupView> choiceGroups,
    required _idq5r9zx.ClassSpellDeltaView spellDelta,
    required List<String> missingDecisions,
  }) = _LevelUpPreviewImpl;

  factory LevelUpPreview.fromJson(Map<String, dynamic> jsonSerialization) {
    return LevelUpPreview(
      before: _isnx6jbi.Protocol().deserialize<_iokyyhkm.CharacterData>(
        jsonSerialization['before'],
      ),
      character: _isnx6jbi.Protocol().deserialize<_iokyyhkm.CharacterData>(
        jsonSerialization['character'],
      ),
      classStep: _isnx6jbi.Protocol().deserialize<_i84fjfjk.ClassStepView>(
        jsonSerialization['classStep'],
      ),
      choiceGroups: _isnx6jbi.Protocol()
          .deserialize<List<_i8vdv0v3.ChoiceGroupView>>(
            jsonSerialization['choiceGroups'],
          ),
      spellDelta: _isnx6jbi.Protocol()
          .deserialize<_idq5r9zx.ClassSpellDeltaView>(
            jsonSerialization['spellDelta'],
          ),
      missingDecisions: _isnx6jbi.Protocol().deserialize<List<String>>(
        jsonSerialization['missingDecisions'],
      ),
    );
  }

  _iokyyhkm.CharacterData before;

  _iokyyhkm.CharacterData character;

  _i84fjfjk.ClassStepView classStep;

  List<_i8vdv0v3.ChoiceGroupView> choiceGroups;

  _idq5r9zx.ClassSpellDeltaView spellDelta;

  List<String> missingDecisions;

  /// Returns a shallow copy of this [LevelUpPreview]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LevelUpPreview copyWith({
    _iokyyhkm.CharacterData? before,
    _iokyyhkm.CharacterData? character,
    _i84fjfjk.ClassStepView? classStep,
    List<_i8vdv0v3.ChoiceGroupView>? choiceGroups,
    _idq5r9zx.ClassSpellDeltaView? spellDelta,
    List<String>? missingDecisions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LevelUpPreview',
      'before': before.toJson(),
      'character': character.toJson(),
      'classStep': classStep.toJson(),
      'choiceGroups': choiceGroups.toJson(valueToJson: (v) => v.toJson()),
      'spellDelta': spellDelta.toJson(),
      'missingDecisions': missingDecisions.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LevelUpPreview',
      'before': before.toJsonForProtocol(),
      'character': character.toJsonForProtocol(),
      'classStep': classStep.toJsonForProtocol(),
      'choiceGroups': choiceGroups.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'spellDelta': spellDelta.toJsonForProtocol(),
      'missingDecisions': missingDecisions.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _LevelUpPreviewImpl extends LevelUpPreview {
  _LevelUpPreviewImpl({
    required _iokyyhkm.CharacterData before,
    required _iokyyhkm.CharacterData character,
    required _i84fjfjk.ClassStepView classStep,
    required List<_i8vdv0v3.ChoiceGroupView> choiceGroups,
    required _idq5r9zx.ClassSpellDeltaView spellDelta,
    required List<String> missingDecisions,
  }) : super._(
         before: before,
         character: character,
         classStep: classStep,
         choiceGroups: choiceGroups,
         spellDelta: spellDelta,
         missingDecisions: missingDecisions,
       );

  /// Returns a shallow copy of this [LevelUpPreview]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LevelUpPreview copyWith({
    _iokyyhkm.CharacterData? before,
    _iokyyhkm.CharacterData? character,
    _i84fjfjk.ClassStepView? classStep,
    List<_i8vdv0v3.ChoiceGroupView>? choiceGroups,
    _idq5r9zx.ClassSpellDeltaView? spellDelta,
    List<String>? missingDecisions,
  }) {
    return LevelUpPreview(
      before: before ?? this.before.copyWith(),
      character: character ?? this.character.copyWith(),
      classStep: classStep ?? this.classStep.copyWith(),
      choiceGroups:
          choiceGroups ?? this.choiceGroups.map((e0) => e0.copyWith()).toList(),
      spellDelta: spellDelta ?? this.spellDelta.copyWith(),
      missingDecisions:
          missingDecisions ?? this.missingDecisions.map((e0) => e0).toList(),
    );
  }
}
