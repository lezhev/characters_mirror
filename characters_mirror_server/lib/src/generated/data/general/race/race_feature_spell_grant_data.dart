/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
import '../../../data/general/race/race_feature_data.dart' as _ib72xv5p;
import '../../../data/general/spell_activation_data.dart' as _ispxy1n8;
import '../../../data/spell_data.dart' as _isenpj1r;
import '../../../enums/ability.dart' as _iw3bk51e;
import '../../../enums/rest_type.dart' as _igwcjrvt;

abstract class RaceFeatureSpellGrantData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RaceFeatureSpellGrantData._({
    this.id,
    required this.featureId,
    this.feature,
    required this.spellId,
    this.spell,
    this.grantedAtLevel,
    this.activation,
    this.castingAbility,
    this.freeCastsPerRest,
    this.freeCastsFormula,
    this.castAtSpellLevel,
    this.canAlsoCastWithSpellSlots,
    this.notes,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory RaceFeatureSpellGrantData({
    int? id,
    required int featureId,
    _ib72xv5p.RaceFeatureData? feature,
    required int spellId,
    _isenpj1r.SpellData? spell,
    int? grantedAtLevel,
    _ispxy1n8.SpellActivationData? activation,
    _iw3bk51e.Ability? castingAbility,
    _igwcjrvt.RestType? freeCastsPerRest,
    String? freeCastsFormula,
    int? castAtSpellLevel,
    bool? canAlsoCastWithSpellSlots,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _RaceFeatureSpellGrantDataImpl;

  factory RaceFeatureSpellGrantData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return RaceFeatureSpellGrantData(
      id: jsonSerialization['id'] as int?,
      featureId: jsonSerialization['featureId'] as int,
      feature: jsonSerialization['feature'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_ib72xv5p.RaceFeatureData>(
              jsonSerialization['feature'],
            ),
      spellId: jsonSerialization['spellId'] as int,
      spell: jsonSerialization['spell'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_isenpj1r.SpellData>(
              jsonSerialization['spell'],
            ),
      grantedAtLevel: jsonSerialization['grantedAtLevel'] as int?,
      activation: jsonSerialization['activation'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_ispxy1n8.SpellActivationData>(
              jsonSerialization['activation'],
            ),
      castingAbility: jsonSerialization['castingAbility'] == null
          ? null
          : _iw3bk51e.Ability.fromJson(
              (jsonSerialization['castingAbility'] as String),
            ),
      freeCastsPerRest: jsonSerialization['freeCastsPerRest'] == null
          ? null
          : _igwcjrvt.RestType.fromJson(
              (jsonSerialization['freeCastsPerRest'] as String),
            ),
      freeCastsFormula: jsonSerialization['freeCastsFormula'] as String?,
      castAtSpellLevel: jsonSerialization['castAtSpellLevel'] as int?,
      canAlsoCastWithSpellSlots:
          jsonSerialization['canAlsoCastWithSpellSlots'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['canAlsoCastWithSpellSlots'],
            ),
      notes: jsonSerialization['notes'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = RaceFeatureSpellGrantDataTable();

  static const db = RaceFeatureSpellGrantDataRepository._();

  @override
  int? id;

  int featureId;

  _ib72xv5p.RaceFeatureData? feature;

  int spellId;

  _isenpj1r.SpellData? spell;

  int? grantedAtLevel;

  _ispxy1n8.SpellActivationData? activation;

  _iw3bk51e.Ability? castingAbility;

  _igwcjrvt.RestType? freeCastsPerRest;

  String? freeCastsFormula;

  int? castAtSpellLevel;

  bool? canAlsoCastWithSpellSlots;

  String? notes;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RaceFeatureSpellGrantData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RaceFeatureSpellGrantData copyWith({
    int? id,
    int? featureId,
    _ib72xv5p.RaceFeatureData? feature,
    int? spellId,
    _isenpj1r.SpellData? spell,
    int? grantedAtLevel,
    _ispxy1n8.SpellActivationData? activation,
    _iw3bk51e.Ability? castingAbility,
    _igwcjrvt.RestType? freeCastsPerRest,
    String? freeCastsFormula,
    int? castAtSpellLevel,
    bool? canAlsoCastWithSpellSlots,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RaceFeatureSpellGrantData',
      if (id != null) 'id': id,
      'featureId': featureId,
      if (feature != null) 'feature': feature?.toJson(),
      'spellId': spellId,
      if (spell != null) 'spell': spell?.toJson(),
      if (grantedAtLevel != null) 'grantedAtLevel': grantedAtLevel,
      if (activation != null) 'activation': activation?.toJson(),
      if (castingAbility != null) 'castingAbility': castingAbility?.toJson(),
      if (freeCastsPerRest != null)
        'freeCastsPerRest': freeCastsPerRest?.toJson(),
      if (freeCastsFormula != null) 'freeCastsFormula': freeCastsFormula,
      if (castAtSpellLevel != null) 'castAtSpellLevel': castAtSpellLevel,
      if (canAlsoCastWithSpellSlots != null)
        'canAlsoCastWithSpellSlots': canAlsoCastWithSpellSlots,
      if (notes != null) 'notes': notes,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RaceFeatureSpellGrantData',
      if (id != null) 'id': id,
      'featureId': featureId,
      if (feature != null) 'feature': feature?.toJsonForProtocol(),
      'spellId': spellId,
      if (spell != null) 'spell': spell?.toJsonForProtocol(),
      if (grantedAtLevel != null) 'grantedAtLevel': grantedAtLevel,
      if (activation != null) 'activation': activation?.toJsonForProtocol(),
      if (castingAbility != null) 'castingAbility': castingAbility?.toJson(),
      if (freeCastsPerRest != null)
        'freeCastsPerRest': freeCastsPerRest?.toJson(),
      if (freeCastsFormula != null) 'freeCastsFormula': freeCastsFormula,
      if (castAtSpellLevel != null) 'castAtSpellLevel': castAtSpellLevel,
      if (canAlsoCastWithSpellSlots != null)
        'canAlsoCastWithSpellSlots': canAlsoCastWithSpellSlots,
      if (notes != null) 'notes': notes,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static RaceFeatureSpellGrantDataInclude include({
    _ib72xv5p.RaceFeatureDataInclude? feature,
    _isenpj1r.SpellDataInclude? spell,
  }) {
    return RaceFeatureSpellGrantDataInclude._(feature: feature, spell: spell);
  }

  static RaceFeatureSpellGrantDataIncludeList includeList({
    _is.WhereExpressionBuilder<RaceFeatureSpellGrantDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RaceFeatureSpellGrantDataTable>? orderBy,
    _is.OrderByListBuilder<RaceFeatureSpellGrantDataTable>? orderByList,
    RaceFeatureSpellGrantDataInclude? include,
  }) {
    return RaceFeatureSpellGrantDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RaceFeatureSpellGrantData.t),
      orderByList: orderByList?.call(RaceFeatureSpellGrantData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RaceFeatureSpellGrantDataImpl extends RaceFeatureSpellGrantData {
  _RaceFeatureSpellGrantDataImpl({
    int? id,
    required int featureId,
    _ib72xv5p.RaceFeatureData? feature,
    required int spellId,
    _isenpj1r.SpellData? spell,
    int? grantedAtLevel,
    _ispxy1n8.SpellActivationData? activation,
    _iw3bk51e.Ability? castingAbility,
    _igwcjrvt.RestType? freeCastsPerRest,
    String? freeCastsFormula,
    int? castAtSpellLevel,
    bool? canAlsoCastWithSpellSlots,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         featureId: featureId,
         feature: feature,
         spellId: spellId,
         spell: spell,
         grantedAtLevel: grantedAtLevel,
         activation: activation,
         castingAbility: castingAbility,
         freeCastsPerRest: freeCastsPerRest,
         freeCastsFormula: freeCastsFormula,
         castAtSpellLevel: castAtSpellLevel,
         canAlsoCastWithSpellSlots: canAlsoCastWithSpellSlots,
         notes: notes,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [RaceFeatureSpellGrantData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RaceFeatureSpellGrantData copyWith({
    Object? id = _Undefined,
    int? featureId,
    Object? feature = _Undefined,
    int? spellId,
    Object? spell = _Undefined,
    Object? grantedAtLevel = _Undefined,
    Object? activation = _Undefined,
    Object? castingAbility = _Undefined,
    Object? freeCastsPerRest = _Undefined,
    Object? freeCastsFormula = _Undefined,
    Object? castAtSpellLevel = _Undefined,
    Object? canAlsoCastWithSpellSlots = _Undefined,
    Object? notes = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return RaceFeatureSpellGrantData(
      id: id is int? ? id : this.id,
      featureId: featureId ?? this.featureId,
      feature: feature is _ib72xv5p.RaceFeatureData?
          ? feature
          : this.feature?.copyWith(),
      spellId: spellId ?? this.spellId,
      spell: spell is _isenpj1r.SpellData? ? spell : this.spell?.copyWith(),
      grantedAtLevel: grantedAtLevel is int?
          ? grantedAtLevel
          : this.grantedAtLevel,
      activation: activation is _ispxy1n8.SpellActivationData?
          ? activation
          : this.activation?.copyWith(),
      castingAbility: castingAbility is _iw3bk51e.Ability?
          ? castingAbility
          : this.castingAbility,
      freeCastsPerRest: freeCastsPerRest is _igwcjrvt.RestType?
          ? freeCastsPerRest
          : this.freeCastsPerRest,
      freeCastsFormula: freeCastsFormula is String?
          ? freeCastsFormula
          : this.freeCastsFormula,
      castAtSpellLevel: castAtSpellLevel is int?
          ? castAtSpellLevel
          : this.castAtSpellLevel,
      canAlsoCastWithSpellSlots: canAlsoCastWithSpellSlots is bool?
          ? canAlsoCastWithSpellSlots
          : this.canAlsoCastWithSpellSlots,
      notes: notes is String? ? notes : this.notes,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class RaceFeatureSpellGrantDataUpdateTable
    extends _is.UpdateTable<RaceFeatureSpellGrantDataTable> {
  RaceFeatureSpellGrantDataUpdateTable(super.table);

  _is.ColumnValue<int, int> featureId(int value) =>
      _is.ColumnValue(table.featureId, value);

  _is.ColumnValue<int, int> spellId(int value) =>
      _is.ColumnValue(table.spellId, value);

  _is.ColumnValue<int, int> grantedAtLevel(int? value) =>
      _is.ColumnValue(table.grantedAtLevel, value);

  _is.ColumnValue<_ispxy1n8.SpellActivationData, _ispxy1n8.SpellActivationData>
  activation(_ispxy1n8.SpellActivationData? value) =>
      _is.ColumnValue(table.activation, value);

  _is.ColumnValue<_iw3bk51e.Ability, _iw3bk51e.Ability> castingAbility(
    _iw3bk51e.Ability? value,
  ) => _is.ColumnValue(table.castingAbility, value);

  _is.ColumnValue<_igwcjrvt.RestType, _igwcjrvt.RestType> freeCastsPerRest(
    _igwcjrvt.RestType? value,
  ) => _is.ColumnValue(table.freeCastsPerRest, value);

  _is.ColumnValue<String, String> freeCastsFormula(String? value) =>
      _is.ColumnValue(table.freeCastsFormula, value);

  _is.ColumnValue<int, int> castAtSpellLevel(int? value) =>
      _is.ColumnValue(table.castAtSpellLevel, value);

  _is.ColumnValue<bool, bool> canAlsoCastWithSpellSlots(bool? value) =>
      _is.ColumnValue(table.canAlsoCastWithSpellSlots, value);

  _is.ColumnValue<String, String> notes(String? value) =>
      _is.ColumnValue(table.notes, value);

  _is.ColumnValue<String, String> source(String? value) =>
      _is.ColumnValue(table.source, value);

  _is.ColumnValue<int, int> version(int? value) =>
      _is.ColumnValue(table.version, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);
}

class RaceFeatureSpellGrantDataTable extends _is.Table<int?> {
  RaceFeatureSpellGrantDataTable({super.tableRelation})
    : super(tableName: 'race_feature_spell_grant_data') {
    updateTable = RaceFeatureSpellGrantDataUpdateTable(this);
    featureId = _is.ColumnInt('featureId', this);
    spellId = _is.ColumnInt('spellId', this);
    grantedAtLevel = _is.ColumnInt('grantedAtLevel', this);
    activation = _is.ColumnSerializable<_ispxy1n8.SpellActivationData>(
      'activation',
      this,
    );
    castingAbility = _is.ColumnEnum(
      'castingAbility',
      this,
      _is.EnumSerialization.byName,
    );
    freeCastsPerRest = _is.ColumnEnum(
      'freeCastsPerRest',
      this,
      _is.EnumSerialization.byName,
    );
    freeCastsFormula = _is.ColumnString('freeCastsFormula', this);
    castAtSpellLevel = _is.ColumnInt('castAtSpellLevel', this);
    canAlsoCastWithSpellSlots = _is.ColumnBool(
      'canAlsoCastWithSpellSlots',
      this,
    );
    notes = _is.ColumnString('notes', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
  }

  late final RaceFeatureSpellGrantDataUpdateTable updateTable;

  late final _is.ColumnInt featureId;

  _ib72xv5p.RaceFeatureDataTable? _feature;

  late final _is.ColumnInt spellId;

  _isenpj1r.SpellDataTable? _spell;

  late final _is.ColumnInt grantedAtLevel;

  late final _is.ColumnSerializable<_ispxy1n8.SpellActivationData> activation;

  late final _is.ColumnEnum<_iw3bk51e.Ability> castingAbility;

  late final _is.ColumnEnum<_igwcjrvt.RestType> freeCastsPerRest;

  late final _is.ColumnString freeCastsFormula;

  late final _is.ColumnInt castAtSpellLevel;

  late final _is.ColumnBool canAlsoCastWithSpellSlots;

  late final _is.ColumnString notes;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  _ib72xv5p.RaceFeatureDataTable get feature {
    if (_feature != null) return _feature!;
    _feature = _is.createRelationTable(
      relationFieldName: 'feature',
      field: RaceFeatureSpellGrantData.t.featureId,
      foreignField: _ib72xv5p.RaceFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ib72xv5p.RaceFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _feature!;
  }

  _isenpj1r.SpellDataTable get spell {
    if (_spell != null) return _spell!;
    _spell = _is.createRelationTable(
      relationFieldName: 'spell',
      field: RaceFeatureSpellGrantData.t.spellId,
      foreignField: _isenpj1r.SpellData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _isenpj1r.SpellDataTable(tableRelation: foreignTableRelation),
    );
    return _spell!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    featureId,
    spellId,
    grantedAtLevel,
    activation,
    castingAbility,
    freeCastsPerRest,
    freeCastsFormula,
    castAtSpellLevel,
    canAlsoCastWithSpellSlots,
    notes,
    source,
    version,
    createdAt,
    updatedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'feature') {
      return feature;
    }
    if (relationField == 'spell') {
      return spell;
    }
    return null;
  }
}

class RaceFeatureSpellGrantDataInclude extends _is.IncludeObject {
  RaceFeatureSpellGrantDataInclude._({
    _ib72xv5p.RaceFeatureDataInclude? feature,
    _isenpj1r.SpellDataInclude? spell,
  }) {
    _feature = feature;
    _spell = spell;
  }

  _ib72xv5p.RaceFeatureDataInclude? _feature;

  _isenpj1r.SpellDataInclude? _spell;

  @override
  Map<String, _is.Include?> get includes => {
    'feature': _feature,
    'spell': _spell,
  };

  @override
  _is.Table<int?> get table => RaceFeatureSpellGrantData.t;
}

class RaceFeatureSpellGrantDataIncludeList extends _is.IncludeList {
  RaceFeatureSpellGrantDataIncludeList._({
    _is.WhereExpressionBuilder<RaceFeatureSpellGrantDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RaceFeatureSpellGrantData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RaceFeatureSpellGrantData.t;
}

class RaceFeatureSpellGrantDataRepository {
  const RaceFeatureSpellGrantDataRepository._();

  final attachRow = const RaceFeatureSpellGrantDataAttachRowRepository._();

  /// Returns a list of [RaceFeatureSpellGrantData]s matching the given query parameters.
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
  Future<List<RaceFeatureSpellGrantData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RaceFeatureSpellGrantDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RaceFeatureSpellGrantDataTable>? orderBy,
    _is.OrderByListBuilder<RaceFeatureSpellGrantDataTable>? orderByList,
    _is.Transaction? transaction,
    RaceFeatureSpellGrantDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RaceFeatureSpellGrantData>(
      where: where?.call(RaceFeatureSpellGrantData.t),
      orderBy: orderBy?.call(RaceFeatureSpellGrantData.t),
      orderByList: orderByList?.call(RaceFeatureSpellGrantData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RaceFeatureSpellGrantData] matching the given query parameters.
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
  Future<RaceFeatureSpellGrantData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RaceFeatureSpellGrantDataTable>? where,
    int? offset,
    _is.OrderByBuilder<RaceFeatureSpellGrantDataTable>? orderBy,
    _is.OrderByListBuilder<RaceFeatureSpellGrantDataTable>? orderByList,
    _is.Transaction? transaction,
    RaceFeatureSpellGrantDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RaceFeatureSpellGrantData>(
      where: where?.call(RaceFeatureSpellGrantData.t),
      orderBy: orderBy?.call(RaceFeatureSpellGrantData.t),
      orderByList: orderByList?.call(RaceFeatureSpellGrantData.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RaceFeatureSpellGrantData] by its [id] or null if no such row exists.
  Future<RaceFeatureSpellGrantData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    RaceFeatureSpellGrantDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RaceFeatureSpellGrantData>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RaceFeatureSpellGrantData]s in the list and returns the inserted rows.
  ///
  /// The returned [RaceFeatureSpellGrantData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RaceFeatureSpellGrantData>> insert(
    _is.DatabaseSession session,
    List<RaceFeatureSpellGrantData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RaceFeatureSpellGrantData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RaceFeatureSpellGrantData] and returns the inserted row.
  ///
  /// The returned [RaceFeatureSpellGrantData] will have its `id` field set.
  Future<RaceFeatureSpellGrantData> insertRow(
    _is.DatabaseSession session,
    RaceFeatureSpellGrantData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RaceFeatureSpellGrantData>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RaceFeatureSpellGrantData]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [RaceFeatureSpellGrantData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RaceFeatureSpellGrantData>> upsert(
    _is.DatabaseSession session,
    List<RaceFeatureSpellGrantData> rows, {
    required _is.ColumnSelections<RaceFeatureSpellGrantDataTable>
    conflictColumns,
    _is.ColumnSelections<RaceFeatureSpellGrantDataTable>? updateColumns,
    _is.WhereExpressionBuilder<RaceFeatureSpellGrantDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RaceFeatureSpellGrantData>(
      rows,
      conflictColumns: conflictColumns(RaceFeatureSpellGrantData.t),
      updateColumns: updateColumns?.call(RaceFeatureSpellGrantData.t),
      updateWhere: updateWhere?.call(RaceFeatureSpellGrantData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RaceFeatureSpellGrantData] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [RaceFeatureSpellGrantData] will have its `id` field set.
  Future<RaceFeatureSpellGrantData?> upsertRow(
    _is.DatabaseSession session,
    RaceFeatureSpellGrantData row, {
    required _is.ColumnSelections<RaceFeatureSpellGrantDataTable>
    conflictColumns,
    _is.ColumnSelections<RaceFeatureSpellGrantDataTable>? updateColumns,
    _is.WhereExpressionBuilder<RaceFeatureSpellGrantDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RaceFeatureSpellGrantData>(
      row,
      conflictColumns: conflictColumns(RaceFeatureSpellGrantData.t),
      updateColumns: updateColumns?.call(RaceFeatureSpellGrantData.t),
      updateWhere: updateWhere?.call(RaceFeatureSpellGrantData.t),
      transaction: transaction,
    );
  }

  /// Updates all [RaceFeatureSpellGrantData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RaceFeatureSpellGrantData>> update(
    _is.DatabaseSession session,
    List<RaceFeatureSpellGrantData> rows, {
    _is.ColumnSelections<RaceFeatureSpellGrantDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RaceFeatureSpellGrantData>(
      rows,
      columns: columns?.call(RaceFeatureSpellGrantData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RaceFeatureSpellGrantData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RaceFeatureSpellGrantData> updateRow(
    _is.DatabaseSession session,
    RaceFeatureSpellGrantData row, {
    _is.ColumnSelections<RaceFeatureSpellGrantDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RaceFeatureSpellGrantData>(
      row,
      columns: columns?.call(RaceFeatureSpellGrantData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RaceFeatureSpellGrantData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RaceFeatureSpellGrantData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RaceFeatureSpellGrantDataUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RaceFeatureSpellGrantData>(
      id,
      columnValues: columnValues(RaceFeatureSpellGrantData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RaceFeatureSpellGrantData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RaceFeatureSpellGrantData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RaceFeatureSpellGrantDataUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<RaceFeatureSpellGrantDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RaceFeatureSpellGrantDataTable>? orderBy,
    _is.OrderByListBuilder<RaceFeatureSpellGrantDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RaceFeatureSpellGrantData>(
      columnValues: columnValues(RaceFeatureSpellGrantData.t.updateTable),
      where: where(RaceFeatureSpellGrantData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RaceFeatureSpellGrantData.t),
      orderByList: orderByList?.call(RaceFeatureSpellGrantData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RaceFeatureSpellGrantData]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RaceFeatureSpellGrantData>> delete(
    _is.DatabaseSession session,
    List<RaceFeatureSpellGrantData> rows, {
    _is.OrderByBuilder<RaceFeatureSpellGrantDataTable>? orderBy,
    _is.OrderByListBuilder<RaceFeatureSpellGrantDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RaceFeatureSpellGrantData>(
      rows,
      orderBy: orderBy?.call(RaceFeatureSpellGrantData.t),
      orderByList: orderByList?.call(RaceFeatureSpellGrantData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RaceFeatureSpellGrantData].
  Future<RaceFeatureSpellGrantData> deleteRow(
    _is.DatabaseSession session,
    RaceFeatureSpellGrantData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RaceFeatureSpellGrantData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RaceFeatureSpellGrantData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RaceFeatureSpellGrantDataTable> where,
    _is.OrderByBuilder<RaceFeatureSpellGrantDataTable>? orderBy,
    _is.OrderByListBuilder<RaceFeatureSpellGrantDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RaceFeatureSpellGrantData>(
      where: where(RaceFeatureSpellGrantData.t),
      orderBy: orderBy?.call(RaceFeatureSpellGrantData.t),
      orderByList: orderByList?.call(RaceFeatureSpellGrantData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RaceFeatureSpellGrantDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RaceFeatureSpellGrantData>(
      where: where?.call(RaceFeatureSpellGrantData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RaceFeatureSpellGrantData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RaceFeatureSpellGrantDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RaceFeatureSpellGrantData>(
      where: where(RaceFeatureSpellGrantData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class RaceFeatureSpellGrantDataAttachRowRepository {
  const RaceFeatureSpellGrantDataAttachRowRepository._();

  /// Creates a relation between the given [RaceFeatureSpellGrantData] and [RaceFeatureData]
  /// by setting the [RaceFeatureSpellGrantData]'s foreign key `featureId` to refer to the [RaceFeatureData].
  Future<void> feature(
    _is.DatabaseSession session,
    RaceFeatureSpellGrantData raceFeatureSpellGrantData,
    _ib72xv5p.RaceFeatureData feature, {
    _is.Transaction? transaction,
  }) async {
    if (raceFeatureSpellGrantData.id == null) {
      throw ArgumentError.notNull('raceFeatureSpellGrantData.id');
    }
    if (feature.id == null) {
      throw ArgumentError.notNull('feature.id');
    }

    var $raceFeatureSpellGrantData = raceFeatureSpellGrantData.copyWith(
      featureId: feature.id,
    );
    await session.db.updateRow<RaceFeatureSpellGrantData>(
      $raceFeatureSpellGrantData,
      columns: [RaceFeatureSpellGrantData.t.featureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [RaceFeatureSpellGrantData] and [SpellData]
  /// by setting the [RaceFeatureSpellGrantData]'s foreign key `spellId` to refer to the [SpellData].
  Future<void> spell(
    _is.DatabaseSession session,
    RaceFeatureSpellGrantData raceFeatureSpellGrantData,
    _isenpj1r.SpellData spell, {
    _is.Transaction? transaction,
  }) async {
    if (raceFeatureSpellGrantData.id == null) {
      throw ArgumentError.notNull('raceFeatureSpellGrantData.id');
    }
    if (spell.id == null) {
      throw ArgumentError.notNull('spell.id');
    }

    var $raceFeatureSpellGrantData = raceFeatureSpellGrantData.copyWith(
      spellId: spell.id,
    );
    await session.db.updateRow<RaceFeatureSpellGrantData>(
      $raceFeatureSpellGrantData,
      columns: [RaceFeatureSpellGrantData.t.spellId],
      transaction: transaction,
    );
  }
}
