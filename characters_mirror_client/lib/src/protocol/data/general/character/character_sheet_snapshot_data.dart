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
import '../../../data/general/character/character_data.dart' as _i2;
import '../../../enums/damage_type.dart' as _i3;

abstract class CharacterSheetSnapshotData implements _i1.SerializableModel {
  CharacterSheetSnapshotData._({
    this.id,
    required this.characterId,
    this.character,
    this.totalLevel,
    this.proficiencyBonus,
    this.armorClass,
    this.initiative,
    this.speed,
    this.maxHp,
    this.passivePerception,
    this.passiveInvestigation,
    this.passiveInsight,
    this.savingThrowBonuses,
    this.skillBonuses,
    this.spellSlots,
    this.pactSlots,
    this.hitDiceSummary,
    this.senses,
    this.resistances,
    this.sheetVersion,
    this.rebuiltAt,
  });

  factory CharacterSheetSnapshotData({
    int? id,
    required int characterId,
    _i2.CharacterData? character,
    int? totalLevel,
    int? proficiencyBonus,
    int? armorClass,
    int? initiative,
    int? speed,
    int? maxHp,
    int? passivePerception,
    int? passiveInvestigation,
    int? passiveInsight,
    Map<String, int>? savingThrowBonuses,
    Map<String, int>? skillBonuses,
    Map<int, int>? spellSlots,
    Map<int, int>? pactSlots,
    Map<String, int>? hitDiceSummary,
    List<String>? senses,
    List<_i3.DamageType>? resistances,
    int? sheetVersion,
    DateTime? rebuiltAt,
  }) = _CharacterSheetSnapshotDataImpl;

  factory CharacterSheetSnapshotData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterSheetSnapshotData(
      id: jsonSerialization['id'] as int?,
      characterId: jsonSerialization['characterId'] as int,
      character: jsonSerialization['character'] == null
          ? null
          : _i2.CharacterData.fromJson(
              (jsonSerialization['character'] as Map<String, dynamic>)),
      totalLevel: jsonSerialization['totalLevel'] as int?,
      proficiencyBonus: jsonSerialization['proficiencyBonus'] as int?,
      armorClass: jsonSerialization['armorClass'] as int?,
      initiative: jsonSerialization['initiative'] as int?,
      speed: jsonSerialization['speed'] as int?,
      maxHp: jsonSerialization['maxHp'] as int?,
      passivePerception: jsonSerialization['passivePerception'] as int?,
      passiveInvestigation: jsonSerialization['passiveInvestigation'] as int?,
      passiveInsight: jsonSerialization['passiveInsight'] as int?,
      savingThrowBonuses: (jsonSerialization['savingThrowBonuses'] as Map?)
          ?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      skillBonuses:
          (jsonSerialization['skillBonuses'] as Map?)?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      spellSlots: (jsonSerialization['spellSlots'] as List?)
          ?.fold<Map<int, int>>(
              {}, (t, e) => {...t, e['k'] as int: e['v'] as int}),
      pactSlots: (jsonSerialization['pactSlots'] as List?)?.fold<Map<int, int>>(
          {}, (t, e) => {...t, e['k'] as int: e['v'] as int}),
      hitDiceSummary:
          (jsonSerialization['hitDiceSummary'] as Map?)?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      senses: (jsonSerialization['senses'] as List?)
          ?.map((e) => e as String)
          .toList(),
      resistances: (jsonSerialization['resistances'] as List?)
          ?.map((e) => _i3.DamageType.fromJson((e as String)))
          .toList(),
      sheetVersion: jsonSerialization['sheetVersion'] as int?,
      rebuiltAt: jsonSerialization['rebuiltAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['rebuiltAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int characterId;

  _i2.CharacterData? character;

  int? totalLevel;

  int? proficiencyBonus;

  int? armorClass;

  int? initiative;

  int? speed;

  int? maxHp;

  int? passivePerception;

  int? passiveInvestigation;

  int? passiveInsight;

  Map<String, int>? savingThrowBonuses;

  Map<String, int>? skillBonuses;

  Map<int, int>? spellSlots;

  Map<int, int>? pactSlots;

  Map<String, int>? hitDiceSummary;

  List<String>? senses;

  List<_i3.DamageType>? resistances;

  int? sheetVersion;

  DateTime? rebuiltAt;

  /// Returns a shallow copy of this [CharacterSheetSnapshotData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterSheetSnapshotData copyWith({
    int? id,
    int? characterId,
    _i2.CharacterData? character,
    int? totalLevel,
    int? proficiencyBonus,
    int? armorClass,
    int? initiative,
    int? speed,
    int? maxHp,
    int? passivePerception,
    int? passiveInvestigation,
    int? passiveInsight,
    Map<String, int>? savingThrowBonuses,
    Map<String, int>? skillBonuses,
    Map<int, int>? spellSlots,
    Map<int, int>? pactSlots,
    Map<String, int>? hitDiceSummary,
    List<String>? senses,
    List<_i3.DamageType>? resistances,
    int? sheetVersion,
    DateTime? rebuiltAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'characterId': characterId,
      if (character != null) 'character': character?.toJson(),
      if (totalLevel != null) 'totalLevel': totalLevel,
      if (proficiencyBonus != null) 'proficiencyBonus': proficiencyBonus,
      if (armorClass != null) 'armorClass': armorClass,
      if (initiative != null) 'initiative': initiative,
      if (speed != null) 'speed': speed,
      if (maxHp != null) 'maxHp': maxHp,
      if (passivePerception != null) 'passivePerception': passivePerception,
      if (passiveInvestigation != null)
        'passiveInvestigation': passiveInvestigation,
      if (passiveInsight != null) 'passiveInsight': passiveInsight,
      if (savingThrowBonuses != null)
        'savingThrowBonuses': savingThrowBonuses?.toJson(),
      if (skillBonuses != null) 'skillBonuses': skillBonuses?.toJson(),
      if (spellSlots != null) 'spellSlots': spellSlots?.toJson(),
      if (pactSlots != null) 'pactSlots': pactSlots?.toJson(),
      if (hitDiceSummary != null) 'hitDiceSummary': hitDiceSummary?.toJson(),
      if (senses != null) 'senses': senses?.toJson(),
      if (resistances != null)
        'resistances': resistances?.toJson(valueToJson: (v) => v.toJson()),
      if (sheetVersion != null) 'sheetVersion': sheetVersion,
      if (rebuiltAt != null) 'rebuiltAt': rebuiltAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSheetSnapshotDataImpl extends CharacterSheetSnapshotData {
  _CharacterSheetSnapshotDataImpl({
    int? id,
    required int characterId,
    _i2.CharacterData? character,
    int? totalLevel,
    int? proficiencyBonus,
    int? armorClass,
    int? initiative,
    int? speed,
    int? maxHp,
    int? passivePerception,
    int? passiveInvestigation,
    int? passiveInsight,
    Map<String, int>? savingThrowBonuses,
    Map<String, int>? skillBonuses,
    Map<int, int>? spellSlots,
    Map<int, int>? pactSlots,
    Map<String, int>? hitDiceSummary,
    List<String>? senses,
    List<_i3.DamageType>? resistances,
    int? sheetVersion,
    DateTime? rebuiltAt,
  }) : super._(
          id: id,
          characterId: characterId,
          character: character,
          totalLevel: totalLevel,
          proficiencyBonus: proficiencyBonus,
          armorClass: armorClass,
          initiative: initiative,
          speed: speed,
          maxHp: maxHp,
          passivePerception: passivePerception,
          passiveInvestigation: passiveInvestigation,
          passiveInsight: passiveInsight,
          savingThrowBonuses: savingThrowBonuses,
          skillBonuses: skillBonuses,
          spellSlots: spellSlots,
          pactSlots: pactSlots,
          hitDiceSummary: hitDiceSummary,
          senses: senses,
          resistances: resistances,
          sheetVersion: sheetVersion,
          rebuiltAt: rebuiltAt,
        );

  /// Returns a shallow copy of this [CharacterSheetSnapshotData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterSheetSnapshotData copyWith({
    Object? id = _Undefined,
    int? characterId,
    Object? character = _Undefined,
    Object? totalLevel = _Undefined,
    Object? proficiencyBonus = _Undefined,
    Object? armorClass = _Undefined,
    Object? initiative = _Undefined,
    Object? speed = _Undefined,
    Object? maxHp = _Undefined,
    Object? passivePerception = _Undefined,
    Object? passiveInvestigation = _Undefined,
    Object? passiveInsight = _Undefined,
    Object? savingThrowBonuses = _Undefined,
    Object? skillBonuses = _Undefined,
    Object? spellSlots = _Undefined,
    Object? pactSlots = _Undefined,
    Object? hitDiceSummary = _Undefined,
    Object? senses = _Undefined,
    Object? resistances = _Undefined,
    Object? sheetVersion = _Undefined,
    Object? rebuiltAt = _Undefined,
  }) {
    return CharacterSheetSnapshotData(
      id: id is int? ? id : this.id,
      characterId: characterId ?? this.characterId,
      character: character is _i2.CharacterData?
          ? character
          : this.character?.copyWith(),
      totalLevel: totalLevel is int? ? totalLevel : this.totalLevel,
      proficiencyBonus:
          proficiencyBonus is int? ? proficiencyBonus : this.proficiencyBonus,
      armorClass: armorClass is int? ? armorClass : this.armorClass,
      initiative: initiative is int? ? initiative : this.initiative,
      speed: speed is int? ? speed : this.speed,
      maxHp: maxHp is int? ? maxHp : this.maxHp,
      passivePerception: passivePerception is int?
          ? passivePerception
          : this.passivePerception,
      passiveInvestigation: passiveInvestigation is int?
          ? passiveInvestigation
          : this.passiveInvestigation,
      passiveInsight:
          passiveInsight is int? ? passiveInsight : this.passiveInsight,
      savingThrowBonuses: savingThrowBonuses is Map<String, int>?
          ? savingThrowBonuses
          : this.savingThrowBonuses?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      skillBonuses: skillBonuses is Map<String, int>?
          ? skillBonuses
          : this.skillBonuses?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      spellSlots: spellSlots is Map<int, int>?
          ? spellSlots
          : this.spellSlots?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      pactSlots: pactSlots is Map<int, int>?
          ? pactSlots
          : this.pactSlots?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      hitDiceSummary: hitDiceSummary is Map<String, int>?
          ? hitDiceSummary
          : this.hitDiceSummary?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      senses: senses is List<String>?
          ? senses
          : this.senses?.map((e0) => e0).toList(),
      resistances: resistances is List<_i3.DamageType>?
          ? resistances
          : this.resistances?.map((e0) => e0).toList(),
      sheetVersion: sheetVersion is int? ? sheetVersion : this.sheetVersion,
      rebuiltAt: rebuiltAt is DateTime? ? rebuiltAt : this.rebuiltAt,
    );
  }
}
