/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../../enums/character_spell_selection_kind.dart' as _i2;

abstract class LevelUpSpellChoice implements _i1.SerializableModel {
  LevelUpSpellChoice._({
    required this.spellId,
    required this.kind,
    this.replacesSelectionId,
  });

  factory LevelUpSpellChoice({
    required int spellId,
    required _i2.CharacterSpellSelectionKind kind,
    String? replacesSelectionId,
  }) = _LevelUpSpellChoiceImpl;

  factory LevelUpSpellChoice.fromJson(Map<String, dynamic> jsonSerialization) {
    return LevelUpSpellChoice(
      spellId: jsonSerialization['spellId'] as int,
      kind: _i2.CharacterSpellSelectionKind.fromJson(
          (jsonSerialization['kind'] as String)),
      replacesSelectionId: jsonSerialization['replacesSelectionId'] as String?,
    );
  }

  int spellId;

  _i2.CharacterSpellSelectionKind kind;

  String? replacesSelectionId;

  /// Returns a shallow copy of this [LevelUpSpellChoice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LevelUpSpellChoice copyWith({
    int? spellId,
    _i2.CharacterSpellSelectionKind? kind,
    String? replacesSelectionId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'spellId': spellId,
      'kind': kind.toJson(),
      if (replacesSelectionId != null)
        'replacesSelectionId': replacesSelectionId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LevelUpSpellChoiceImpl extends LevelUpSpellChoice {
  _LevelUpSpellChoiceImpl({
    required int spellId,
    required _i2.CharacterSpellSelectionKind kind,
    String? replacesSelectionId,
  }) : super._(
          spellId: spellId,
          kind: kind,
          replacesSelectionId: replacesSelectionId,
        );

  /// Returns a shallow copy of this [LevelUpSpellChoice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LevelUpSpellChoice copyWith({
    int? spellId,
    _i2.CharacterSpellSelectionKind? kind,
    Object? replacesSelectionId = _Undefined,
  }) {
    return LevelUpSpellChoice(
      spellId: spellId ?? this.spellId,
      kind: kind ?? this.kind,
      replacesSelectionId: replacesSelectionId is String?
          ? replacesSelectionId
          : this.replacesSelectionId,
    );
  }
}
