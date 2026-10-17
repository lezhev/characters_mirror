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

abstract class SpellSlotProgressionData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SpellSlotProgressionData._({
    this.id,
    this.tableKey,
    required this.level,
    this.spellSlots,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory SpellSlotProgressionData({
    int? id,
    String? tableKey,
    required int level,
    Map<int, int>? spellSlots,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SpellSlotProgressionDataImpl;

  factory SpellSlotProgressionData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SpellSlotProgressionData(
      id: jsonSerialization['id'] as int?,
      tableKey: jsonSerialization['tableKey'] as String?,
      level: jsonSerialization['level'] as int,
      spellSlots: jsonSerialization['spellSlots'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<int, int>>(
              jsonSerialization['spellSlots'],
            ),
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

  static final t = SpellSlotProgressionDataTable();

  static const db = SpellSlotProgressionDataRepository._();

  @override
  int? id;

  String? tableKey;

  int level;

  Map<int, int>? spellSlots;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SpellSlotProgressionData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SpellSlotProgressionData copyWith({
    int? id,
    String? tableKey,
    int? level,
    Map<int, int>? spellSlots,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SpellSlotProgressionData',
      if (id != null) 'id': id,
      if (tableKey != null) 'tableKey': tableKey,
      'level': level,
      if (spellSlots != null) 'spellSlots': spellSlots?.toJson(),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SpellSlotProgressionData',
      if (id != null) 'id': id,
      if (tableKey != null) 'tableKey': tableKey,
      'level': level,
      if (spellSlots != null) 'spellSlots': spellSlots?.toJson(),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static SpellSlotProgressionDataInclude include() {
    return SpellSlotProgressionDataInclude._();
  }

  static SpellSlotProgressionDataIncludeList includeList({
    _is.WhereExpressionBuilder<SpellSlotProgressionDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SpellSlotProgressionDataTable>? orderBy,
    _is.OrderByListBuilder<SpellSlotProgressionDataTable>? orderByList,
    SpellSlotProgressionDataInclude? include,
  }) {
    return SpellSlotProgressionDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SpellSlotProgressionData.t),
      orderByList: orderByList?.call(SpellSlotProgressionData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpellSlotProgressionDataImpl extends SpellSlotProgressionData {
  _SpellSlotProgressionDataImpl({
    int? id,
    String? tableKey,
    required int level,
    Map<int, int>? spellSlots,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         tableKey: tableKey,
         level: level,
         spellSlots: spellSlots,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SpellSlotProgressionData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SpellSlotProgressionData copyWith({
    Object? id = _Undefined,
    Object? tableKey = _Undefined,
    int? level,
    Object? spellSlots = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return SpellSlotProgressionData(
      id: id is int? ? id : this.id,
      tableKey: tableKey is String? ? tableKey : this.tableKey,
      level: level ?? this.level,
      spellSlots: spellSlots is Map<int, int>?
          ? spellSlots
          : this.spellSlots?.map((key0, value0) => MapEntry(key0, value0)),
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class SpellSlotProgressionDataUpdateTable
    extends _is.UpdateTable<SpellSlotProgressionDataTable> {
  SpellSlotProgressionDataUpdateTable(super.table);

  _is.ColumnValue<String, String> tableKey(String? value) =>
      _is.ColumnValue(table.tableKey, value);

  _is.ColumnValue<int, int> level(int value) =>
      _is.ColumnValue(table.level, value);

  _is.ColumnValue<Map<int, int>, Map<int, int>> spellSlots(
    Map<int, int>? value,
  ) => _is.ColumnValue(table.spellSlots, value);

  _is.ColumnValue<String, String> source(String? value) =>
      _is.ColumnValue(table.source, value);

  _is.ColumnValue<int, int> version(int? value) =>
      _is.ColumnValue(table.version, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);
}

class SpellSlotProgressionDataTable extends _is.Table<int?> {
  SpellSlotProgressionDataTable({super.tableRelation})
    : super(tableName: 'spell_slot_progression_data') {
    updateTable = SpellSlotProgressionDataUpdateTable(this);
    tableKey = _is.ColumnString('tableKey', this);
    level = _is.ColumnInt('level', this);
    spellSlots = _is.ColumnSerializable<Map<int, int>>('spellSlots', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
  }

  late final SpellSlotProgressionDataUpdateTable updateTable;

  late final _is.ColumnString tableKey;

  late final _is.ColumnInt level;

  late final _is.ColumnSerializable<Map<int, int>> spellSlots;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    tableKey,
    level,
    spellSlots,
    source,
    version,
    createdAt,
    updatedAt,
  ];
}

class SpellSlotProgressionDataInclude extends _is.IncludeObject {
  SpellSlotProgressionDataInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SpellSlotProgressionData.t;
}

class SpellSlotProgressionDataIncludeList extends _is.IncludeList {
  SpellSlotProgressionDataIncludeList._({
    _is.WhereExpressionBuilder<SpellSlotProgressionDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SpellSlotProgressionData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SpellSlotProgressionData.t;
}

class SpellSlotProgressionDataRepository {
  const SpellSlotProgressionDataRepository._();

  /// Returns a list of [SpellSlotProgressionData]s matching the given query parameters.
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
  Future<List<SpellSlotProgressionData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SpellSlotProgressionDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SpellSlotProgressionDataTable>? orderBy,
    _is.OrderByListBuilder<SpellSlotProgressionDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SpellSlotProgressionData>(
      where: where?.call(SpellSlotProgressionData.t),
      orderBy: orderBy?.call(SpellSlotProgressionData.t),
      orderByList: orderByList?.call(SpellSlotProgressionData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SpellSlotProgressionData] matching the given query parameters.
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
  Future<SpellSlotProgressionData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SpellSlotProgressionDataTable>? where,
    int? offset,
    _is.OrderByBuilder<SpellSlotProgressionDataTable>? orderBy,
    _is.OrderByListBuilder<SpellSlotProgressionDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SpellSlotProgressionData>(
      where: where?.call(SpellSlotProgressionData.t),
      orderBy: orderBy?.call(SpellSlotProgressionData.t),
      orderByList: orderByList?.call(SpellSlotProgressionData.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SpellSlotProgressionData] by its [id] or null if no such row exists.
  Future<SpellSlotProgressionData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SpellSlotProgressionData>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SpellSlotProgressionData]s in the list and returns the inserted rows.
  ///
  /// The returned [SpellSlotProgressionData]s will have their `id` fields set.
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
  Future<List<SpellSlotProgressionData>> insert(
    _is.DatabaseSession session,
    List<SpellSlotProgressionData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SpellSlotProgressionData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SpellSlotProgressionData] and returns the inserted row.
  ///
  /// The returned [SpellSlotProgressionData] will have its `id` field set.
  Future<SpellSlotProgressionData> insertRow(
    _is.DatabaseSession session,
    SpellSlotProgressionData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SpellSlotProgressionData>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SpellSlotProgressionData]s in the list and returns the resulting rows.
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
  /// The returned [SpellSlotProgressionData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SpellSlotProgressionData>> upsert(
    _is.DatabaseSession session,
    List<SpellSlotProgressionData> rows, {
    required _is.ColumnSelections<SpellSlotProgressionDataTable>
    conflictColumns,
    _is.ColumnSelections<SpellSlotProgressionDataTable>? updateColumns,
    _is.WhereExpressionBuilder<SpellSlotProgressionDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SpellSlotProgressionData>(
      rows,
      conflictColumns: conflictColumns(SpellSlotProgressionData.t),
      updateColumns: updateColumns?.call(SpellSlotProgressionData.t),
      updateWhere: updateWhere?.call(SpellSlotProgressionData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SpellSlotProgressionData] and returns the resulting row.
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
  /// The returned [SpellSlotProgressionData] will have its `id` field set.
  Future<SpellSlotProgressionData?> upsertRow(
    _is.DatabaseSession session,
    SpellSlotProgressionData row, {
    required _is.ColumnSelections<SpellSlotProgressionDataTable>
    conflictColumns,
    _is.ColumnSelections<SpellSlotProgressionDataTable>? updateColumns,
    _is.WhereExpressionBuilder<SpellSlotProgressionDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SpellSlotProgressionData>(
      row,
      conflictColumns: conflictColumns(SpellSlotProgressionData.t),
      updateColumns: updateColumns?.call(SpellSlotProgressionData.t),
      updateWhere: updateWhere?.call(SpellSlotProgressionData.t),
      transaction: transaction,
    );
  }

  /// Updates all [SpellSlotProgressionData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SpellSlotProgressionData>> update(
    _is.DatabaseSession session,
    List<SpellSlotProgressionData> rows, {
    _is.ColumnSelections<SpellSlotProgressionDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SpellSlotProgressionData>(
      rows,
      columns: columns?.call(SpellSlotProgressionData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SpellSlotProgressionData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SpellSlotProgressionData> updateRow(
    _is.DatabaseSession session,
    SpellSlotProgressionData row, {
    _is.ColumnSelections<SpellSlotProgressionDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SpellSlotProgressionData>(
      row,
      columns: columns?.call(SpellSlotProgressionData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SpellSlotProgressionData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SpellSlotProgressionData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SpellSlotProgressionDataUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SpellSlotProgressionData>(
      id,
      columnValues: columnValues(SpellSlotProgressionData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SpellSlotProgressionData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SpellSlotProgressionData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SpellSlotProgressionDataUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<SpellSlotProgressionDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SpellSlotProgressionDataTable>? orderBy,
    _is.OrderByListBuilder<SpellSlotProgressionDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SpellSlotProgressionData>(
      columnValues: columnValues(SpellSlotProgressionData.t.updateTable),
      where: where(SpellSlotProgressionData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SpellSlotProgressionData.t),
      orderByList: orderByList?.call(SpellSlotProgressionData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SpellSlotProgressionData]s in the list and returns the deleted rows.
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
  Future<List<SpellSlotProgressionData>> delete(
    _is.DatabaseSession session,
    List<SpellSlotProgressionData> rows, {
    _is.OrderByBuilder<SpellSlotProgressionDataTable>? orderBy,
    _is.OrderByListBuilder<SpellSlotProgressionDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SpellSlotProgressionData>(
      rows,
      orderBy: orderBy?.call(SpellSlotProgressionData.t),
      orderByList: orderByList?.call(SpellSlotProgressionData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SpellSlotProgressionData].
  Future<SpellSlotProgressionData> deleteRow(
    _is.DatabaseSession session,
    SpellSlotProgressionData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SpellSlotProgressionData>(
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
  Future<List<SpellSlotProgressionData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SpellSlotProgressionDataTable> where,
    _is.OrderByBuilder<SpellSlotProgressionDataTable>? orderBy,
    _is.OrderByListBuilder<SpellSlotProgressionDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SpellSlotProgressionData>(
      where: where(SpellSlotProgressionData.t),
      orderBy: orderBy?.call(SpellSlotProgressionData.t),
      orderByList: orderByList?.call(SpellSlotProgressionData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SpellSlotProgressionDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SpellSlotProgressionData>(
      where: where?.call(SpellSlotProgressionData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SpellSlotProgressionData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SpellSlotProgressionDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SpellSlotProgressionData>(
      where: where(SpellSlotProgressionData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
