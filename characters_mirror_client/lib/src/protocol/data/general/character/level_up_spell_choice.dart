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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../../enums/character_spell_selection_kind.dart' as _ioezer4n;

abstract class LevelUpSpellChoice
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LevelUpSpellChoice._({
    required this.spellId,
    required this.kind,
    this.replacesSelectionId,
  });

  factory LevelUpSpellChoice({
    required int spellId,
    required _ioezer4n.CharacterSpellSelectionKind kind,
    String? replacesSelectionId,
  }) = _LevelUpSpellChoiceImpl;

  factory LevelUpSpellChoice.fromJson(Map<String, dynamic> jsonSerialization) {
    return LevelUpSpellChoice(
      spellId: jsonSerialization['spellId'] as int,
      kind: _ioezer4n.CharacterSpellSelectionKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      replacesSelectionId: jsonSerialization['replacesSelectionId'] as String?,
    );
  }

  int spellId;

  _ioezer4n.CharacterSpellSelectionKind kind;

  String? replacesSelectionId;

  /// Returns a shallow copy of this [LevelUpSpellChoice]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LevelUpSpellChoice copyWith({
    int? spellId,
    _ioezer4n.CharacterSpellSelectionKind? kind,
    String? replacesSelectionId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LevelUpSpellChoice',
      'spellId': spellId,
      'kind': kind.toJson(),
      if (replacesSelectionId != null)
        'replacesSelectionId': replacesSelectionId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LevelUpSpellChoice',
      'spellId': spellId,
      'kind': kind.toJson(),
      if (replacesSelectionId != null)
        'replacesSelectionId': replacesSelectionId,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LevelUpSpellChoiceImpl extends LevelUpSpellChoice {
  _LevelUpSpellChoiceImpl({
    required int spellId,
    required _ioezer4n.CharacterSpellSelectionKind kind,
    String? replacesSelectionId,
  }) : super._(
         spellId: spellId,
         kind: kind,
         replacesSelectionId: replacesSelectionId,
       );

  /// Returns a shallow copy of this [LevelUpSpellChoice]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LevelUpSpellChoice copyWith({
    int? spellId,
    _ioezer4n.CharacterSpellSelectionKind? kind,
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
