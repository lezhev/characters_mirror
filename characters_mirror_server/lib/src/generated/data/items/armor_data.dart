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
import 'package:serverpod/serverpod.dart' as _is;
import '../../enums/armor_category.dart' as _ixuui93s;

abstract class ArmorData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ArmorData._({
    this.id,
    this.referenceKey,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.categoryValue,
    this.baseAC,
    this.bonusAC,
    this.dexBonus,
    this.dexBonusMax,
    this.strengthRequirement,
    this.stealthDisadvantage,
    this.weight,
    this.cost,
  });

  factory ArmorData({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    _ixuui93s.ArmorCategory? categoryValue,
    int? baseAC,
    int? bonusAC,
    bool? dexBonus,
    int? dexBonusMax,
    int? strengthRequirement,
    bool? stealthDisadvantage,
    double? weight,
    String? cost,
  }) = _ArmorDataImpl;

  factory ArmorData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ArmorData(
      id: jsonSerialization['id'] as int?,
      referenceKey: jsonSerialization['referenceKey'] as String?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      categoryValue: jsonSerialization['categoryValue'] == null
          ? null
          : _ixuui93s.ArmorCategory.fromJson(
              (jsonSerialization['categoryValue'] as String),
            ),
      baseAC: jsonSerialization['baseAC'] as int?,
      bonusAC: jsonSerialization['bonusAC'] as int?,
      dexBonus: jsonSerialization['dexBonus'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['dexBonus']),
      dexBonusMax: jsonSerialization['dexBonusMax'] as int?,
      strengthRequirement: jsonSerialization['strengthRequirement'] as int?,
      stealthDisadvantage: jsonSerialization['stealthDisadvantage'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['stealthDisadvantage'],
            ),
      weight: (jsonSerialization['weight'] as num?)?.toDouble(),
      cost: jsonSerialization['cost'] as String?,
    );
  }

  static final t = ArmorDataTable();

  static const db = ArmorDataRepository._();

  @override
  int? id;

  String? referenceKey;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  _ixuui93s.ArmorCategory? categoryValue;

  int? baseAC;

  int? bonusAC;

  bool? dexBonus;

  int? dexBonusMax;

  int? strengthRequirement;

  bool? stealthDisadvantage;

  double? weight;

  String? cost;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ArmorData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ArmorData copyWith({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    _ixuui93s.ArmorCategory? categoryValue,
    int? baseAC,
    int? bonusAC,
    bool? dexBonus,
    int? dexBonusMax,
    int? strengthRequirement,
    bool? stealthDisadvantage,
    double? weight,
    String? cost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ArmorData',
      if (id != null) 'id': id,
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (categoryValue != null) 'categoryValue': categoryValue?.toJson(),
      if (baseAC != null) 'baseAC': baseAC,
      if (bonusAC != null) 'bonusAC': bonusAC,
      if (dexBonus != null) 'dexBonus': dexBonus,
      if (dexBonusMax != null) 'dexBonusMax': dexBonusMax,
      if (strengthRequirement != null)
        'strengthRequirement': strengthRequirement,
      if (stealthDisadvantage != null)
        'stealthDisadvantage': stealthDisadvantage,
      if (weight != null) 'weight': weight,
      if (cost != null) 'cost': cost,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ArmorData',
      if (id != null) 'id': id,
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (categoryValue != null) 'categoryValue': categoryValue?.toJson(),
      if (baseAC != null) 'baseAC': baseAC,
      if (bonusAC != null) 'bonusAC': bonusAC,
      if (dexBonus != null) 'dexBonus': dexBonus,
      if (dexBonusMax != null) 'dexBonusMax': dexBonusMax,
      if (strengthRequirement != null)
        'strengthRequirement': strengthRequirement,
      if (stealthDisadvantage != null)
        'stealthDisadvantage': stealthDisadvantage,
      if (weight != null) 'weight': weight,
      if (cost != null) 'cost': cost,
    };
  }

  static ArmorDataInclude include() {
    return ArmorDataInclude._();
  }

  static ArmorDataIncludeList includeList({
    _is.WhereExpressionBuilder<ArmorDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ArmorDataTable>? orderBy,
    _is.OrderByListBuilder<ArmorDataTable>? orderByList,
    ArmorDataInclude? include,
  }) {
    return ArmorDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ArmorData.t),
      orderByList: orderByList?.call(ArmorData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ArmorDataImpl extends ArmorData {
  _ArmorDataImpl({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    _ixuui93s.ArmorCategory? categoryValue,
    int? baseAC,
    int? bonusAC,
    bool? dexBonus,
    int? dexBonusMax,
    int? strengthRequirement,
    bool? stealthDisadvantage,
    double? weight,
    String? cost,
  }) : super._(
         id: id,
         referenceKey: referenceKey,
         name: name,
         description: description,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
         categoryValue: categoryValue,
         baseAC: baseAC,
         bonusAC: bonusAC,
         dexBonus: dexBonus,
         dexBonusMax: dexBonusMax,
         strengthRequirement: strengthRequirement,
         stealthDisadvantage: stealthDisadvantage,
         weight: weight,
         cost: cost,
       );

  /// Returns a shallow copy of this [ArmorData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ArmorData copyWith({
    Object? id = _Undefined,
    Object? referenceKey = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? categoryValue = _Undefined,
    Object? baseAC = _Undefined,
    Object? bonusAC = _Undefined,
    Object? dexBonus = _Undefined,
    Object? dexBonusMax = _Undefined,
    Object? strengthRequirement = _Undefined,
    Object? stealthDisadvantage = _Undefined,
    Object? weight = _Undefined,
    Object? cost = _Undefined,
  }) {
    return ArmorData(
      id: id is int? ? id : this.id,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      categoryValue: categoryValue is _ixuui93s.ArmorCategory?
          ? categoryValue
          : this.categoryValue,
      baseAC: baseAC is int? ? baseAC : this.baseAC,
      bonusAC: bonusAC is int? ? bonusAC : this.bonusAC,
      dexBonus: dexBonus is bool? ? dexBonus : this.dexBonus,
      dexBonusMax: dexBonusMax is int? ? dexBonusMax : this.dexBonusMax,
      strengthRequirement: strengthRequirement is int?
          ? strengthRequirement
          : this.strengthRequirement,
      stealthDisadvantage: stealthDisadvantage is bool?
          ? stealthDisadvantage
          : this.stealthDisadvantage,
      weight: weight is double? ? weight : this.weight,
      cost: cost is String? ? cost : this.cost,
    );
  }
}

class ArmorDataUpdateTable extends _is.UpdateTable<ArmorDataTable> {
  ArmorDataUpdateTable(super.table);

  _is.ColumnValue<String, String> referenceKey(String? value) =>
      _is.ColumnValue(table.referenceKey, value);

  _is.ColumnValue<String, String> name(String? value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<String, String> source(String? value) =>
      _is.ColumnValue(table.source, value);

  _is.ColumnValue<int, int> version(int? value) =>
      _is.ColumnValue(table.version, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);

  _is.ColumnValue<_ixuui93s.ArmorCategory, _ixuui93s.ArmorCategory>
  categoryValue(_ixuui93s.ArmorCategory? value) =>
      _is.ColumnValue(table.categoryValue, value);

  _is.ColumnValue<int, int> baseAC(int? value) =>
      _is.ColumnValue(table.baseAC, value);

  _is.ColumnValue<int, int> bonusAC(int? value) =>
      _is.ColumnValue(table.bonusAC, value);

  _is.ColumnValue<bool, bool> dexBonus(bool? value) =>
      _is.ColumnValue(table.dexBonus, value);

  _is.ColumnValue<int, int> dexBonusMax(int? value) =>
      _is.ColumnValue(table.dexBonusMax, value);

  _is.ColumnValue<int, int> strengthRequirement(int? value) =>
      _is.ColumnValue(table.strengthRequirement, value);

  _is.ColumnValue<bool, bool> stealthDisadvantage(bool? value) =>
      _is.ColumnValue(table.stealthDisadvantage, value);

  _is.ColumnValue<double, double> weight(double? value) =>
      _is.ColumnValue(table.weight, value);

  _is.ColumnValue<String, String> cost(String? value) =>
      _is.ColumnValue(table.cost, value);
}

class ArmorDataTable extends _is.Table<int?> {
  ArmorDataTable({super.tableRelation}) : super(tableName: 'armor_data') {
    updateTable = ArmorDataUpdateTable(this);
    referenceKey = _is.ColumnString('referenceKey', this);
    name = _is.ColumnString('name', this);
    description = _is.ColumnString('description', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
    categoryValue = _is.ColumnEnum(
      'categoryValue',
      this,
      _is.EnumSerialization.byName,
    );
    baseAC = _is.ColumnInt('baseAC', this);
    bonusAC = _is.ColumnInt('bonusAC', this);
    dexBonus = _is.ColumnBool('dexBonus', this);
    dexBonusMax = _is.ColumnInt('dexBonusMax', this);
    strengthRequirement = _is.ColumnInt('strengthRequirement', this);
    stealthDisadvantage = _is.ColumnBool('stealthDisadvantage', this);
    weight = _is.ColumnDouble('weight', this);
    cost = _is.ColumnString('cost', this);
  }

  late final ArmorDataUpdateTable updateTable;

  late final _is.ColumnString referenceKey;

  late final _is.ColumnString name;

  late final _is.ColumnString description;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnEnum<_ixuui93s.ArmorCategory> categoryValue;

  late final _is.ColumnInt baseAC;

  late final _is.ColumnInt bonusAC;

  late final _is.ColumnBool dexBonus;

  late final _is.ColumnInt dexBonusMax;

  late final _is.ColumnInt strengthRequirement;

  late final _is.ColumnBool stealthDisadvantage;

  late final _is.ColumnDouble weight;

  late final _is.ColumnString cost;

  @override
  List<_is.Column> get columns => [
    id,
    referenceKey,
    name,
    description,
    source,
    version,
    createdAt,
    updatedAt,
    categoryValue,
    baseAC,
    bonusAC,
    dexBonus,
    dexBonusMax,
    strengthRequirement,
    stealthDisadvantage,
    weight,
    cost,
  ];
}

class ArmorDataInclude extends _is.IncludeObject {
  ArmorDataInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ArmorData.t;
}

class ArmorDataIncludeList extends _is.IncludeList {
  ArmorDataIncludeList._({
    _is.WhereExpressionBuilder<ArmorDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ArmorData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ArmorData.t;
}

class ArmorDataRepository {
  const ArmorDataRepository._();

  /// Returns a list of [ArmorData]s matching the given query parameters.
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
  Future<List<ArmorData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ArmorDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ArmorDataTable>? orderBy,
    _is.OrderByListBuilder<ArmorDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ArmorData>(
      where: where?.call(ArmorData.t),
      orderBy: orderBy?.call(ArmorData.t),
      orderByList: orderByList?.call(ArmorData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ArmorData] matching the given query parameters.
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
  Future<ArmorData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ArmorDataTable>? where,
    int? offset,
    _is.OrderByBuilder<ArmorDataTable>? orderBy,
    _is.OrderByListBuilder<ArmorDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ArmorData>(
      where: where?.call(ArmorData.t),
      orderBy: orderBy?.call(ArmorData.t),
      orderByList: orderByList?.call(ArmorData.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ArmorData] by its [id] or null if no such row exists.
  Future<ArmorData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ArmorData>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ArmorData]s in the list and returns the inserted rows.
  ///
  /// The returned [ArmorData]s will have their `id` fields set.
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
  Future<List<ArmorData>> insert(
    _is.DatabaseSession session,
    List<ArmorData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ArmorData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ArmorData] and returns the inserted row.
  ///
  /// The returned [ArmorData] will have its `id` field set.
  Future<ArmorData> insertRow(
    _is.DatabaseSession session,
    ArmorData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ArmorData>(row, transaction: transaction);
  }

  /// Upserts all [ArmorData]s in the list and returns the resulting rows.
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
  /// The returned [ArmorData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ArmorData>> upsert(
    _is.DatabaseSession session,
    List<ArmorData> rows, {
    required _is.ColumnSelections<ArmorDataTable> conflictColumns,
    _is.ColumnSelections<ArmorDataTable>? updateColumns,
    _is.WhereExpressionBuilder<ArmorDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ArmorData>(
      rows,
      conflictColumns: conflictColumns(ArmorData.t),
      updateColumns: updateColumns?.call(ArmorData.t),
      updateWhere: updateWhere?.call(ArmorData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ArmorData] and returns the resulting row.
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
  /// The returned [ArmorData] will have its `id` field set.
  Future<ArmorData?> upsertRow(
    _is.DatabaseSession session,
    ArmorData row, {
    required _is.ColumnSelections<ArmorDataTable> conflictColumns,
    _is.ColumnSelections<ArmorDataTable>? updateColumns,
    _is.WhereExpressionBuilder<ArmorDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ArmorData>(
      row,
      conflictColumns: conflictColumns(ArmorData.t),
      updateColumns: updateColumns?.call(ArmorData.t),
      updateWhere: updateWhere?.call(ArmorData.t),
      transaction: transaction,
    );
  }

  /// Updates all [ArmorData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ArmorData>> update(
    _is.DatabaseSession session,
    List<ArmorData> rows, {
    _is.ColumnSelections<ArmorDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ArmorData>(
      rows,
      columns: columns?.call(ArmorData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ArmorData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ArmorData> updateRow(
    _is.DatabaseSession session,
    ArmorData row, {
    _is.ColumnSelections<ArmorDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ArmorData>(
      row,
      columns: columns?.call(ArmorData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ArmorData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ArmorData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ArmorDataUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ArmorData>(
      id,
      columnValues: columnValues(ArmorData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ArmorData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ArmorData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ArmorDataUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ArmorDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ArmorDataTable>? orderBy,
    _is.OrderByListBuilder<ArmorDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ArmorData>(
      columnValues: columnValues(ArmorData.t.updateTable),
      where: where(ArmorData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ArmorData.t),
      orderByList: orderByList?.call(ArmorData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ArmorData]s in the list and returns the deleted rows.
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
  Future<List<ArmorData>> delete(
    _is.DatabaseSession session,
    List<ArmorData> rows, {
    _is.OrderByBuilder<ArmorDataTable>? orderBy,
    _is.OrderByListBuilder<ArmorDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ArmorData>(
      rows,
      orderBy: orderBy?.call(ArmorData.t),
      orderByList: orderByList?.call(ArmorData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ArmorData].
  Future<ArmorData> deleteRow(
    _is.DatabaseSession session,
    ArmorData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ArmorData>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ArmorData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ArmorDataTable> where,
    _is.OrderByBuilder<ArmorDataTable>? orderBy,
    _is.OrderByListBuilder<ArmorDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ArmorData>(
      where: where(ArmorData.t),
      orderBy: orderBy?.call(ArmorData.t),
      orderByList: orderByList?.call(ArmorData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ArmorDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ArmorData>(
      where: where?.call(ArmorData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ArmorData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ArmorDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ArmorData>(
      where: where(ArmorData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
