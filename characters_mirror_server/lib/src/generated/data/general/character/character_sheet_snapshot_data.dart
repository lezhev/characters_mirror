/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../../../data/general/character/character_data.dart' as _i2;
import '../../../enums/damage_type.dart' as _i3;

abstract class CharacterSheetSnapshotData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = CharacterSheetSnapshotDataTable();

  static const db = CharacterSheetSnapshotDataRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'characterId': characterId,
      if (character != null) 'character': character?.toJsonForProtocol(),
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

  static CharacterSheetSnapshotDataInclude include(
      {_i2.CharacterDataInclude? character}) {
    return CharacterSheetSnapshotDataInclude._(character: character);
  }

  static CharacterSheetSnapshotDataIncludeList includeList({
    _i1.WhereExpressionBuilder<CharacterSheetSnapshotDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterSheetSnapshotDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterSheetSnapshotDataTable>? orderByList,
    CharacterSheetSnapshotDataInclude? include,
  }) {
    return CharacterSheetSnapshotDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterSheetSnapshotData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CharacterSheetSnapshotData.t),
      include: include,
    );
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

class CharacterSheetSnapshotDataTable extends _i1.Table<int?> {
  CharacterSheetSnapshotDataTable({super.tableRelation})
      : super(tableName: 'character_sheet_snapshot_data') {
    characterId = _i1.ColumnInt(
      'characterId',
      this,
    );
    totalLevel = _i1.ColumnInt(
      'totalLevel',
      this,
    );
    proficiencyBonus = _i1.ColumnInt(
      'proficiencyBonus',
      this,
    );
    armorClass = _i1.ColumnInt(
      'armorClass',
      this,
    );
    initiative = _i1.ColumnInt(
      'initiative',
      this,
    );
    speed = _i1.ColumnInt(
      'speed',
      this,
    );
    maxHp = _i1.ColumnInt(
      'maxHp',
      this,
    );
    passivePerception = _i1.ColumnInt(
      'passivePerception',
      this,
    );
    passiveInvestigation = _i1.ColumnInt(
      'passiveInvestigation',
      this,
    );
    passiveInsight = _i1.ColumnInt(
      'passiveInsight',
      this,
    );
    savingThrowBonuses = _i1.ColumnSerializable(
      'savingThrowBonuses',
      this,
    );
    skillBonuses = _i1.ColumnSerializable(
      'skillBonuses',
      this,
    );
    spellSlots = _i1.ColumnSerializable(
      'spellSlots',
      this,
    );
    pactSlots = _i1.ColumnSerializable(
      'pactSlots',
      this,
    );
    hitDiceSummary = _i1.ColumnSerializable(
      'hitDiceSummary',
      this,
    );
    senses = _i1.ColumnSerializable(
      'senses',
      this,
    );
    resistances = _i1.ColumnSerializable(
      'resistances',
      this,
    );
    sheetVersion = _i1.ColumnInt(
      'sheetVersion',
      this,
    );
    rebuiltAt = _i1.ColumnDateTime(
      'rebuiltAt',
      this,
    );
  }

  late final _i1.ColumnInt characterId;

  _i2.CharacterDataTable? _character;

  late final _i1.ColumnInt totalLevel;

  late final _i1.ColumnInt proficiencyBonus;

  late final _i1.ColumnInt armorClass;

  late final _i1.ColumnInt initiative;

  late final _i1.ColumnInt speed;

  late final _i1.ColumnInt maxHp;

  late final _i1.ColumnInt passivePerception;

  late final _i1.ColumnInt passiveInvestigation;

  late final _i1.ColumnInt passiveInsight;

  late final _i1.ColumnSerializable savingThrowBonuses;

  late final _i1.ColumnSerializable skillBonuses;

  late final _i1.ColumnSerializable spellSlots;

  late final _i1.ColumnSerializable pactSlots;

  late final _i1.ColumnSerializable hitDiceSummary;

  late final _i1.ColumnSerializable senses;

  late final _i1.ColumnSerializable resistances;

  late final _i1.ColumnInt sheetVersion;

  late final _i1.ColumnDateTime rebuiltAt;

  _i2.CharacterDataTable get character {
    if (_character != null) return _character!;
    _character = _i1.createRelationTable(
      relationFieldName: 'character',
      field: CharacterSheetSnapshotData.t.characterId,
      foreignField: _i2.CharacterData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CharacterDataTable(tableRelation: foreignTableRelation),
    );
    return _character!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        characterId,
        totalLevel,
        proficiencyBonus,
        armorClass,
        initiative,
        speed,
        maxHp,
        passivePerception,
        passiveInvestigation,
        passiveInsight,
        savingThrowBonuses,
        skillBonuses,
        spellSlots,
        pactSlots,
        hitDiceSummary,
        senses,
        resistances,
        sheetVersion,
        rebuiltAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'character') {
      return character;
    }
    return null;
  }
}

class CharacterSheetSnapshotDataInclude extends _i1.IncludeObject {
  CharacterSheetSnapshotDataInclude._({_i2.CharacterDataInclude? character}) {
    _character = character;
  }

  _i2.CharacterDataInclude? _character;

  @override
  Map<String, _i1.Include?> get includes => {'character': _character};

  @override
  _i1.Table<int?> get table => CharacterSheetSnapshotData.t;
}

class CharacterSheetSnapshotDataIncludeList extends _i1.IncludeList {
  CharacterSheetSnapshotDataIncludeList._({
    _i1.WhereExpressionBuilder<CharacterSheetSnapshotDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterSheetSnapshotData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CharacterSheetSnapshotData.t;
}

class CharacterSheetSnapshotDataRepository {
  const CharacterSheetSnapshotDataRepository._();

  final attachRow = const CharacterSheetSnapshotDataAttachRowRepository._();

  /// Returns a list of [CharacterSheetSnapshotData]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<CharacterSheetSnapshotData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterSheetSnapshotDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterSheetSnapshotDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterSheetSnapshotDataTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterSheetSnapshotDataInclude? include,
  }) async {
    return session.db.find<CharacterSheetSnapshotData>(
      where: where?.call(CharacterSheetSnapshotData.t),
      orderBy: orderBy?.call(CharacterSheetSnapshotData.t),
      orderByList: orderByList?.call(CharacterSheetSnapshotData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [CharacterSheetSnapshotData] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<CharacterSheetSnapshotData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterSheetSnapshotDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<CharacterSheetSnapshotDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterSheetSnapshotDataTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterSheetSnapshotDataInclude? include,
  }) async {
    return session.db.findFirstRow<CharacterSheetSnapshotData>(
      where: where?.call(CharacterSheetSnapshotData.t),
      orderBy: orderBy?.call(CharacterSheetSnapshotData.t),
      orderByList: orderByList?.call(CharacterSheetSnapshotData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [CharacterSheetSnapshotData] by its [id] or null if no such row exists.
  Future<CharacterSheetSnapshotData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CharacterSheetSnapshotDataInclude? include,
  }) async {
    return session.db.findById<CharacterSheetSnapshotData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [CharacterSheetSnapshotData]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterSheetSnapshotData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CharacterSheetSnapshotData>> insert(
    _i1.Session session,
    List<CharacterSheetSnapshotData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CharacterSheetSnapshotData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CharacterSheetSnapshotData] and returns the inserted row.
  ///
  /// The returned [CharacterSheetSnapshotData] will have its `id` field set.
  Future<CharacterSheetSnapshotData> insertRow(
    _i1.Session session,
    CharacterSheetSnapshotData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterSheetSnapshotData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CharacterSheetSnapshotData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CharacterSheetSnapshotData>> update(
    _i1.Session session,
    List<CharacterSheetSnapshotData> rows, {
    _i1.ColumnSelections<CharacterSheetSnapshotDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CharacterSheetSnapshotData>(
      rows,
      columns: columns?.call(CharacterSheetSnapshotData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterSheetSnapshotData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterSheetSnapshotData> updateRow(
    _i1.Session session,
    CharacterSheetSnapshotData row, {
    _i1.ColumnSelections<CharacterSheetSnapshotDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterSheetSnapshotData>(
      row,
      columns: columns?.call(CharacterSheetSnapshotData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CharacterSheetSnapshotData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CharacterSheetSnapshotData>> delete(
    _i1.Session session,
    List<CharacterSheetSnapshotData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CharacterSheetSnapshotData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CharacterSheetSnapshotData].
  Future<CharacterSheetSnapshotData> deleteRow(
    _i1.Session session,
    CharacterSheetSnapshotData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterSheetSnapshotData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CharacterSheetSnapshotData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CharacterSheetSnapshotDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CharacterSheetSnapshotData>(
      where: where(CharacterSheetSnapshotData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterSheetSnapshotDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CharacterSheetSnapshotData>(
      where: where?.call(CharacterSheetSnapshotData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CharacterSheetSnapshotDataAttachRowRepository {
  const CharacterSheetSnapshotDataAttachRowRepository._();

  /// Creates a relation between the given [CharacterSheetSnapshotData] and [CharacterData]
  /// by setting the [CharacterSheetSnapshotData]'s foreign key `characterId` to refer to the [CharacterData].
  Future<void> character(
    _i1.Session session,
    CharacterSheetSnapshotData characterSheetSnapshotData,
    _i2.CharacterData character, {
    _i1.Transaction? transaction,
  }) async {
    if (characterSheetSnapshotData.id == null) {
      throw ArgumentError.notNull('characterSheetSnapshotData.id');
    }
    if (character.id == null) {
      throw ArgumentError.notNull('character.id');
    }

    var $characterSheetSnapshotData =
        characterSheetSnapshotData.copyWith(characterId: character.id);
    await session.db.updateRow<CharacterSheetSnapshotData>(
      $characterSheetSnapshotData,
      columns: [CharacterSheetSnapshotData.t.characterId],
      transaction: transaction,
    );
  }
}
