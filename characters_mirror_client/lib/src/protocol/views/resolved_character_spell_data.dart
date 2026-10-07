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
import '../data/spell_data.dart' as _i2;
import '../views/spell_source_context_data.dart' as _i3;

abstract class ResolvedCharacterSpellData implements _i1.SerializableModel {
  ResolvedCharacterSpellData._({
    required this.spellKey,
    required this.spell,
    required this.sources,
  });

  factory ResolvedCharacterSpellData({
    required String spellKey,
    required _i2.SpellData spell,
    required List<_i3.SpellSourceContextData> sources,
  }) = _ResolvedCharacterSpellDataImpl;

  factory ResolvedCharacterSpellData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ResolvedCharacterSpellData(
      spellKey: jsonSerialization['spellKey'] as String,
      spell: _i2.SpellData.fromJson(
          (jsonSerialization['spell'] as Map<String, dynamic>)),
      sources: (jsonSerialization['sources'] as List)
          .map((e) =>
              _i3.SpellSourceContextData.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  String spellKey;

  _i2.SpellData spell;

  List<_i3.SpellSourceContextData> sources;

  /// Returns a shallow copy of this [ResolvedCharacterSpellData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ResolvedCharacterSpellData copyWith({
    String? spellKey,
    _i2.SpellData? spell,
    List<_i3.SpellSourceContextData>? sources,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'spellKey': spellKey,
      'spell': spell.toJson(),
      'sources': sources.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ResolvedCharacterSpellDataImpl extends ResolvedCharacterSpellData {
  _ResolvedCharacterSpellDataImpl({
    required String spellKey,
    required _i2.SpellData spell,
    required List<_i3.SpellSourceContextData> sources,
  }) : super._(
          spellKey: spellKey,
          spell: spell,
          sources: sources,
        );

  /// Returns a shallow copy of this [ResolvedCharacterSpellData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ResolvedCharacterSpellData copyWith({
    String? spellKey,
    _i2.SpellData? spell,
    List<_i3.SpellSourceContextData>? sources,
  }) {
    return ResolvedCharacterSpellData(
      spellKey: spellKey ?? this.spellKey,
      spell: spell ?? this.spell.copyWith(),
      sources: sources ?? this.sources.map((e0) => e0.copyWith()).toList(),
    );
  }
}
