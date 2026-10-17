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
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
import '../data/spell_data.dart' as _iavpgfjb;
import '../views/spell_source_context_data.dart' as _iu3jjmdm;

abstract class ResolvedCharacterSpellData
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ResolvedCharacterSpellData._({
    required this.spellKey,
    required this.spell,
    required this.sources,
  });

  factory ResolvedCharacterSpellData({
    required String spellKey,
    required _iavpgfjb.SpellData spell,
    required List<_iu3jjmdm.SpellSourceContextData> sources,
  }) = _ResolvedCharacterSpellDataImpl;

  factory ResolvedCharacterSpellData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ResolvedCharacterSpellData(
      spellKey: jsonSerialization['spellKey'] as String,
      spell: _ikmnmw29.Protocol().deserialize<_iavpgfjb.SpellData>(
        jsonSerialization['spell'],
      ),
      sources: _ikmnmw29.Protocol()
          .deserialize<List<_iu3jjmdm.SpellSourceContextData>>(
            jsonSerialization['sources'],
          ),
    );
  }

  String spellKey;

  _iavpgfjb.SpellData spell;

  List<_iu3jjmdm.SpellSourceContextData> sources;

  /// Returns a shallow copy of this [ResolvedCharacterSpellData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ResolvedCharacterSpellData copyWith({
    String? spellKey,
    _iavpgfjb.SpellData? spell,
    List<_iu3jjmdm.SpellSourceContextData>? sources,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ResolvedCharacterSpellData',
      'spellKey': spellKey,
      'spell': spell.toJson(),
      'sources': sources.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ResolvedCharacterSpellData',
      'spellKey': spellKey,
      'spell': spell.toJsonForProtocol(),
      'sources': sources.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ResolvedCharacterSpellDataImpl extends ResolvedCharacterSpellData {
  _ResolvedCharacterSpellDataImpl({
    required String spellKey,
    required _iavpgfjb.SpellData spell,
    required List<_iu3jjmdm.SpellSourceContextData> sources,
  }) : super._(spellKey: spellKey, spell: spell, sources: sources);

  /// Returns a shallow copy of this [ResolvedCharacterSpellData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ResolvedCharacterSpellData copyWith({
    String? spellKey,
    _iavpgfjb.SpellData? spell,
    List<_iu3jjmdm.SpellSourceContextData>? sources,
  }) {
    return ResolvedCharacterSpellData(
      spellKey: spellKey ?? this.spellKey,
      spell: spell ?? this.spell.copyWith(),
      sources: sources ?? this.sources.map((e0) => e0.copyWith()).toList(),
    );
  }
}
