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

abstract class ClassSpellDeltaView implements _i1.SerializableModel {
  ClassSpellDeltaView._({
    required this.cantripsToAdd,
    required this.knownSpellsToAdd,
    required this.knownSpellReplacements,
    required this.spellbookSpellsToAdd,
    this.preparedSpellLimitBefore,
    this.preparedSpellLimitAfter,
  });

  factory ClassSpellDeltaView({
    required int cantripsToAdd,
    required int knownSpellsToAdd,
    required int knownSpellReplacements,
    required int spellbookSpellsToAdd,
    int? preparedSpellLimitBefore,
    int? preparedSpellLimitAfter,
  }) = _ClassSpellDeltaViewImpl;

  factory ClassSpellDeltaView.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassSpellDeltaView(
      cantripsToAdd: jsonSerialization['cantripsToAdd'] as int,
      knownSpellsToAdd: jsonSerialization['knownSpellsToAdd'] as int,
      knownSpellReplacements:
          jsonSerialization['knownSpellReplacements'] as int,
      spellbookSpellsToAdd: jsonSerialization['spellbookSpellsToAdd'] as int,
      preparedSpellLimitBefore:
          jsonSerialization['preparedSpellLimitBefore'] as int?,
      preparedSpellLimitAfter:
          jsonSerialization['preparedSpellLimitAfter'] as int?,
    );
  }

  int cantripsToAdd;

  int knownSpellsToAdd;

  int knownSpellReplacements;

  int spellbookSpellsToAdd;

  int? preparedSpellLimitBefore;

  int? preparedSpellLimitAfter;

  /// Returns a shallow copy of this [ClassSpellDeltaView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassSpellDeltaView copyWith({
    int? cantripsToAdd,
    int? knownSpellsToAdd,
    int? knownSpellReplacements,
    int? spellbookSpellsToAdd,
    int? preparedSpellLimitBefore,
    int? preparedSpellLimitAfter,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'cantripsToAdd': cantripsToAdd,
      'knownSpellsToAdd': knownSpellsToAdd,
      'knownSpellReplacements': knownSpellReplacements,
      'spellbookSpellsToAdd': spellbookSpellsToAdd,
      if (preparedSpellLimitBefore != null)
        'preparedSpellLimitBefore': preparedSpellLimitBefore,
      if (preparedSpellLimitAfter != null)
        'preparedSpellLimitAfter': preparedSpellLimitAfter,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassSpellDeltaViewImpl extends ClassSpellDeltaView {
  _ClassSpellDeltaViewImpl({
    required int cantripsToAdd,
    required int knownSpellsToAdd,
    required int knownSpellReplacements,
    required int spellbookSpellsToAdd,
    int? preparedSpellLimitBefore,
    int? preparedSpellLimitAfter,
  }) : super._(
          cantripsToAdd: cantripsToAdd,
          knownSpellsToAdd: knownSpellsToAdd,
          knownSpellReplacements: knownSpellReplacements,
          spellbookSpellsToAdd: spellbookSpellsToAdd,
          preparedSpellLimitBefore: preparedSpellLimitBefore,
          preparedSpellLimitAfter: preparedSpellLimitAfter,
        );

  /// Returns a shallow copy of this [ClassSpellDeltaView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassSpellDeltaView copyWith({
    int? cantripsToAdd,
    int? knownSpellsToAdd,
    int? knownSpellReplacements,
    int? spellbookSpellsToAdd,
    Object? preparedSpellLimitBefore = _Undefined,
    Object? preparedSpellLimitAfter = _Undefined,
  }) {
    return ClassSpellDeltaView(
      cantripsToAdd: cantripsToAdd ?? this.cantripsToAdd,
      knownSpellsToAdd: knownSpellsToAdd ?? this.knownSpellsToAdd,
      knownSpellReplacements:
          knownSpellReplacements ?? this.knownSpellReplacements,
      spellbookSpellsToAdd: spellbookSpellsToAdd ?? this.spellbookSpellsToAdd,
      preparedSpellLimitBefore: preparedSpellLimitBefore is int?
          ? preparedSpellLimitBefore
          : this.preparedSpellLimitBefore,
      preparedSpellLimitAfter: preparedSpellLimitAfter is int?
          ? preparedSpellLimitAfter
          : this.preparedSpellLimitAfter,
    );
  }
}
