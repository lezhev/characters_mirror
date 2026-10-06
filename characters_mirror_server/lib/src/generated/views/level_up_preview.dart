/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../data/general/character/character_data.dart' as _i2;
import '../views/class_step_view.dart' as _i3;
import '../views/choice_group_view.dart' as _i4;
import '../views/class_spell_delta_view.dart' as _i5;

abstract class LevelUpPreview
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  LevelUpPreview._({
    required this.before,
    required this.character,
    required this.classStep,
    required this.choiceGroups,
    required this.spellDelta,
    required this.missingDecisions,
  });

  factory LevelUpPreview({
    required _i2.CharacterData before,
    required _i2.CharacterData character,
    required _i3.ClassStepView classStep,
    required List<_i4.ChoiceGroupView> choiceGroups,
    required _i5.ClassSpellDeltaView spellDelta,
    required List<String> missingDecisions,
  }) = _LevelUpPreviewImpl;

  factory LevelUpPreview.fromJson(Map<String, dynamic> jsonSerialization) {
    return LevelUpPreview(
      before: _i2.CharacterData.fromJson(
          (jsonSerialization['before'] as Map<String, dynamic>)),
      character: _i2.CharacterData.fromJson(
          (jsonSerialization['character'] as Map<String, dynamic>)),
      classStep: _i3.ClassStepView.fromJson(
          (jsonSerialization['classStep'] as Map<String, dynamic>)),
      choiceGroups: (jsonSerialization['choiceGroups'] as List)
          .map((e) => _i4.ChoiceGroupView.fromJson((e as Map<String, dynamic>)))
          .toList(),
      spellDelta: _i5.ClassSpellDeltaView.fromJson(
          (jsonSerialization['spellDelta'] as Map<String, dynamic>)),
      missingDecisions: (jsonSerialization['missingDecisions'] as List)
          .map((e) => e as String)
          .toList(),
    );
  }

  _i2.CharacterData before;

  _i2.CharacterData character;

  _i3.ClassStepView classStep;

  List<_i4.ChoiceGroupView> choiceGroups;

  _i5.ClassSpellDeltaView spellDelta;

  List<String> missingDecisions;

  /// Returns a shallow copy of this [LevelUpPreview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LevelUpPreview copyWith({
    _i2.CharacterData? before,
    _i2.CharacterData? character,
    _i3.ClassStepView? classStep,
    List<_i4.ChoiceGroupView>? choiceGroups,
    _i5.ClassSpellDeltaView? spellDelta,
    List<String>? missingDecisions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
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
      'before': before.toJsonForProtocol(),
      'character': character.toJsonForProtocol(),
      'classStep': classStep.toJsonForProtocol(),
      'choiceGroups':
          choiceGroups.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'spellDelta': spellDelta.toJsonForProtocol(),
      'missingDecisions': missingDecisions.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _LevelUpPreviewImpl extends LevelUpPreview {
  _LevelUpPreviewImpl({
    required _i2.CharacterData before,
    required _i2.CharacterData character,
    required _i3.ClassStepView classStep,
    required List<_i4.ChoiceGroupView> choiceGroups,
    required _i5.ClassSpellDeltaView spellDelta,
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
  @_i1.useResult
  @override
  LevelUpPreview copyWith({
    _i2.CharacterData? before,
    _i2.CharacterData? character,
    _i3.ClassStepView? classStep,
    List<_i4.ChoiceGroupView>? choiceGroups,
    _i5.ClassSpellDeltaView? spellDelta,
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
